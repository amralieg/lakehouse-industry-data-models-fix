-- Schema for Domain: order | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`order` COMMENT 'Core transactional domain managing the full order lifecycle from cart submission through confirmed delivery. Owns order capture, OMS orchestration, order status tracking, cancellations, delivery confirmation, and order-level SLA management across B2C, B2B, and marketplace channels. Tracks AOV, CVR, and GMV at the order level.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`cart` (
    `cart_id` BIGINT COMMENT 'Unique identifier for the cart (primary key).',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who owns the cart.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: CART PRICING CONTEXT: The cart calculates totals using a selected price list; persisting the list ID enables seamless order conversion.',
    `session_id` BIGINT COMMENT 'Web or app session identifier associated with the cart.',
    `abandonment_email_sent_flag` BOOLEAN COMMENT 'Indicates whether a cart abandonment email has been sent.',
    `abandonment_reason` STRING COMMENT 'Free‑text reason captured (if any) for why the cart was abandoned.',
    `cart_number` STRING COMMENT 'Business-facing cart identifier shown to customers and used in support.',
    `cart_source` STRING COMMENT 'System or integration source that created the cart.. Valid values are `web|app|api|partner|offline`',
    `cart_status` STRING COMMENT 'Current lifecycle status of the cart.. Valid values are `active|abandoned|converted|expired|cancelled`',
    `channel` STRING COMMENT 'Origin channel through which the cart was created.. Valid values are `b2c|b2b|marketplace|mobile_app`',
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
    `shipping_address_city` STRING COMMENT 'City component of the shipping address.',
    `shipping_address_country_code` STRING COMMENT 'Three‑letter country code of the shipping address.',
    `shipping_address_line1` STRING COMMENT 'First line of the shipping street address.',
    `shipping_address_line2` STRING COMMENT 'Second line of the shipping street address (optional).',
    `shipping_address_postal_code` STRING COMMENT 'Postal/ZIP code of the shipping address.',
    `shipping_address_state` STRING COMMENT 'State or province component of the shipping address.',
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
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller offering the product.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for real‑time inventory, pricing and fulfillment; cart item must map to the definitive SKU record used in downstream order processing.',
    `session_id` BIGINT COMMENT 'Identifier of the user session associated with this cart action.',
    `variant_sku_id` BIGINT COMMENT 'Identifier for the specific product variant (size, color, etc.) selected.',
    `added_timestamp` TIMESTAMP COMMENT 'Date and time when the item was added to the cart.',
    `backorder_estimate_date` DATE COMMENT 'Estimated date when the back‑ordered item will be available.',
    `coupon_applied` BOOLEAN COMMENT 'True if a coupon was applied to this line.',
    `coupon_code` STRING COMMENT 'Code of the coupon applied, if any.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `device_type` STRING COMMENT 'Type of device used during the add‑to‑cart action.. Valid values are `desktop|mobile|tablet`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to this line item.',
    `fulfillment_method` STRING COMMENT 'Chosen shipping or pickup method for the item.. Valid values are `standard|express|same_day|pickup|drone`',
    `gift_message` STRING COMMENT 'Optional message entered for the gift recipient.',
    `inventory_status` STRING COMMENT 'Current inventory condition of the SKU at the time of add‑to‑cart.. Valid values are `in_stock|out_of_stock|reserved|allocated|backordered`',
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
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to service.entitlement. Business justification: Business process: Apply customers support entitlement to each order for SLA and case handling; experts expect an order to reference its entitlement tier.',
    `center_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center assigned to the order.',
    `header_order_address_id` BIGINT COMMENT 'Reference to the address where the order will be shipped.',
    `household_id` BIGINT COMMENT 'Foreign key linking to customer.household. Business justification: Supports household‑level order aggregation for family plans and shared loyalty, enabling reporting of total household GMV and order counts.',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to payment.merchant_account. Business justification: REQUIRED: Reconciliation reports need the merchant account that processed each order; linking order_header to merchant_account enables accurate financial statements and audit trails.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Order processing must satisfy specific compliance obligations (consumer protection, data privacy); linking allows tracking obligation fulfillment per order for audit trails.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: REQUIRED: Operational dashboards track which payment gateway handled each order for SLA monitoring and compliance; a FK from order_header to gateway provides this linkage.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: REQUIRED: Storing the tokenized payment method used for an order enables refunds, recurring billing, and fraud analysis; the FK links order_header to payment_method.',
    `price_approval_id` BIGINT COMMENT 'Foreign key linking to pricing.price_approval. Business justification: COMPLIANCE APPROVAL: High‑value orders may need price approval; linking to the approval record satisfies audit and regulatory reporting.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: ORDER PRICING AUDIT: Each order is priced using a specific price list; storing price_list_id enables price source traceability for compliance reports.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: REGIONAL PRICING: Orders are assigned to a price zone to apply region‑specific pricing rules; FK required for zone‑based revenue analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: REQUIRED: Assign each order to a profit center for profit‑center performance reporting.',
    `query_log_id` BIGINT COMMENT 'Foreign key linking to search.query_log. Business justification: Attribution of each order to the originating search query for marketing ROI and search performance reporting.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Tax compliance reporting requires each order to reference the tax regulation (e.g., VAT, sales tax) governing the transaction, enabling accurate filing and audit.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Needed for segment‑based order analytics and targeted marketing, allowing each order to be attributed to the customer segment at time of purchase.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller fulfilling the order (if applicable).',
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
    `order_source` STRING COMMENT 'Origin channel of the order request.. Valid values are `web|mobile_app|call_center|api`',
    `order_status` STRING COMMENT 'Current lifecycle state of the order.. Valid values are `pending|confirmed|shipped|delivered|cancelled|returned`',
    `order_type` STRING COMMENT 'Logical classification of the order (e.g., standard purchase, gift, subscription).. Valid values are `standard|gift|subscription`',
    `payment_method` STRING COMMENT 'Instrument used to settle the order.. Valid values are `credit_card|debit_card|paypal|bank_transfer|gift_card|apple_pay`',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order_order_line data product (auto-inserted pre-linking).',
    `line_id` BIGINT COMMENT 'Unique surrogate key for each order line item.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier assignment per order line is required for carrier performance reporting and SLA compliance; e‑commerce ops track carrier_id for each line.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Link enables compliance, merchandising and sales reporting by tying each order line to its master catalog item record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: REQUIRED: Track line‑level cost allocation to cost centers for detailed expense reporting.',
    `dynamic_price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dynamic_price_rule. Business justification: DYNAMIC PRICING LOG: When a dynamic pricing rule adjusts a line, storing the rule ID supports performance reporting and rule‑impact analysis.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: REQUIRED: Directly map each order line to a GL account for precise accounting postings.',
    `header_id` BIGINT COMMENT 'Identifier of the parent order header.',
    `indexed_document_id` BIGINT COMMENT 'Foreign key linking to search.indexed_document. Business justification: Enables linking purchased line items to the catalog document used in search, supporting search relevance and conversion attribution analysis.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Product‑level regulations (hazardous, restricted items) must be validated per order line; linking ensures regulatory checks and reporting.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: LOT TRACEABILITY: Regulatory and quality processes need to link sold items to their originating lot for recall, expiry, and compliance reporting.',
    `markdown_schedule_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown_schedule. Business justification: DISCOUNT AUDIT: A markdown schedule may be applied to a line; linking enables tracking of schedule source for discount compliance.',
    `marketplace_listing_id` BIGINT COMMENT 'Identifier of the marketplace (B2C, B2B, C2C) where the order originated.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: LINE PRICE SOURCE: Order line price is calculated from a concrete price‑list item; FK allows audit of which item supplied the unit price.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: REQUIRED: Attribute each order line to a profit center for granular margin analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Drop‑ship fulfillment creates a PO per marketplace order line; linking enables PO tracking, cost allocation, and delivery ETA reporting.',
    `result_id` BIGINT COMMENT 'Foreign key linking to search.result. Business justification: Tracks which search result led to the purchase, essential for click‑to‑purchase conversion metrics and A/B test evaluation.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller offering the product.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Order line needs a stable reference to the SKU entity for shipping, tax calculation and returns; replaces the denormalized sku string.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: PICK PLAN: Mapping each order line to a specific stock position is required for the warehouse picking system to generate accurate pick lists and optimize routing.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment node assigned to this line.',
    `actual_delivery_date` DATE COMMENT 'Date the line was actually delivered to the customer.',
    `asin` STRING COMMENT 'Marketplace‑specific product identifier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `dimensions_cm` STRING COMMENT 'Package dimensions formatted as LxWxH in centimeters.',
    `fulfillment_status` STRING COMMENT 'Current status of the fulfillment process for this line.. Valid values are `allocated|picked|packed|shipped|delivered|failed`',
    `fulfillment_type` STRING COMMENT 'Method by which the line is fulfilled.. Valid values are `warehouse|drop_ship|store_pickup|third_party`',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the product is classified as hazardous.',
    `is_backordered` BOOLEAN COMMENT 'True if the line is currently on backorder.',
    `is_gift` BOOLEAN COMMENT 'True if the line is marked as a gift for the recipient.',
    `is_returnable` BOOLEAN COMMENT 'Indicates whether the product can be returned under policy.',
    `line_discount_amount` DECIMAL(18,2) COMMENT 'Absolute discount applied to this line.',
    `line_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line.',
    `line_status` STRING COMMENT 'Current lifecycle status of the order line.. Valid values are `pending|confirmed|shipped|delivered|canceled|returned`',
    `line_total_gross` DECIMAL(18,2) COMMENT 'Total amount before tax and after discounts (quantity × unit_price – discount).',
    `line_total_net` DECIMAL(18,2) COMMENT 'Final amount after tax (gross total + tax_amount).',
    `product_name` STRING COMMENT 'Human‑readable name of the product.',
    `promised_delivery_date` DATE COMMENT 'Date promised to the customer for delivery of this line.',
    `quantity_fulfilled` STRING COMMENT 'Number of units actually shipped to the customer.',
    `quantity_ordered` STRING COMMENT 'Number of units requested by the customer.',
    `restricted_item_flag` BOOLEAN COMMENT 'True if the product is subject to sales restrictions.',
    `return_window_days` STRING COMMENT 'Number of days after delivery during which a return is allowed.',
    `shipping_method` STRING COMMENT 'Selected shipping service for the line.. Valid values are `standard|express|overnight|pickup|drone|freight`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax charged for this line.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the line is exempt from tax.',
    `tax_jurisdiction` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code indicating the tax authority for this line.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for the shipment.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit before discounts and taxes.',
    `upc` STRING COMMENT 'Global barcode identifier for the product.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the line item in kilograms.',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual SKU-level line items within a confirmed order. Captures SKU/ASIN/UPC, product name, quantity ordered/fulfilled, unit selling price, line-level discount, line total, seller ID for marketplace orders, fulfillment node assignment, line status, promised delivery date, and line-level tax details (jurisdiction, rate, amount, exemption status). Supports GMV decomposition, line-level fulfillment tracking, returns attribution, and tax compliance reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique surrogate identifier for each status transition record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the actor (user, system, seller, etc.) that performed the transition.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this status transition belongs.',
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
    `privacy_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_notice. Business justification: Privacy notices govern personal address data collection; linking address records to the applicable notice supports GDPR/CCPA compliance reporting.',
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
    `header_id` BIGINT COMMENT 'Identifier of the order to which this payment allocation belongs.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: REQUIRED: Reconcile each payment to its accounting journal entry for audit and financial reporting.',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant (seller) receiving the payment.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Payment processing must adhere to PCI DSS obligations; linking each payment to its compliance obligation enables security audit and reporting.',
    `payment_transaction_id` BIGINT COMMENT 'Identifier of the payment transaction from the payment gateway.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Required for marketplace split‑payment reconciliation; each payment line must be tied to the seller receiving funds, a standard financial report in e‑commerce.',
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
    `payment_method` STRING COMMENT 'Method used for the payment.. Valid values are `credit_card|debit_card|bank_transfer|gift_card|store_credit|paypal`',
    `payment_status` STRING COMMENT 'Current status of the payment allocation.. Valid values are `authorized|captured|failed|refunded|partial|voided`',
    `reconciliation_status` STRING COMMENT 'Status of financial reconciliation for this payment allocation.. Valid values are `matched|unmatched|pending`',
    `reference` STRING COMMENT 'External reference or token from the payment gateway for this payment transaction.',
    `refunded_amount` DECIMAL(18,2) COMMENT 'Amount refunded for this payment allocation, if any.',
    `settlement_currency_code` STRING COMMENT 'Currency code used for settlement, may differ from transaction currency.. Valid values are `[A-Z]{3}`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was settled with the acquiring bank.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment amount, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    CONSTRAINT pk_order_payment PRIMARY KEY(`order_payment_id`)
) COMMENT 'Order-level payment allocation records linking a sales order to one or more payment transactions. Captures payment method type, payment reference from the payment gateway, amount allocated to this order, currency, payment status (authorized, captured, failed, refunded), split-payment flags, and gift card or store credit redemption amounts. This is the order domains local reference to payment events — it does NOT own gateway integration, PCI-scoped card data, or settlement processing (those belong to the payment domain). Enables order-level payment reconciliation, refund eligibility checks, and revenue recognition without crossing domain boundaries.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`order_promotion` (
    `order_promotion_id` BIGINT COMMENT 'Unique identifier for the order promotion record.',
    `line_id` BIGINT COMMENT 'Identifier of the specific order line to which the promotion was applied, when applicable.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated the promotion, if applicable.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this promotion is applied.',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty program associated with the promotion, if applicable.',
    `merchandising_rule_id` BIGINT COMMENT 'Foreign key linking to search.merchandising_rule. Business justification: Allows analysis of promotion effectiveness tied to specific merchandising rules, required for promotion performance reporting.',
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
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Tax can be applied at the line level; adding order_line_id FK enables precise tax calculations per line and removes ambiguity of using only header_id.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Tax compliance requires attributing tax amounts to the responsible seller for jurisdictional reporting and settlement.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`order_sla` (
    `order_sla_id` BIGINT COMMENT 'Unique surrogate key for each SLA commitment record.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier responsible for shipment.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this SLA applies.',
    `actual_delivery_date` DATE COMMENT 'Date the order was actually delivered to the customer.',
    `actual_handling_time_hours` DECIMAL(18,2) COMMENT 'Observed time taken to handle the order before shipping, in hours.',
    `actual_ship_date` DATE COMMENT 'Date the order was actually shipped.',
    `breach_flag` BOOLEAN COMMENT 'True if any SLA metric was missed, otherwise False.',
    `breach_reason` STRING COMMENT 'Categorized cause for SLA breach when breach_flag is true.. Valid values are `late_handling|late_ship|late_delivery|exception|customer_cancel|other`',
    `commitment_type` STRING COMMENT 'Scope of the SLA (e.g., handling only, shipping only, delivery only, or full end‑to‑end).. Valid values are `handling|shipping|delivery|full`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA commitment was created in the OMS.',
    `delivery_date_delta_days` DECIMAL(18,2) COMMENT 'Number of days the actual delivery date deviates from the promised delivery date.',
    `effective_from` DATE COMMENT 'Date when the SLA commitment becomes effective (typically order date).',
    `effective_until` DATE COMMENT 'Date when the SLA commitment expires; null for open‑ended agreements.',
    `handling_time_delta_hours` DECIMAL(18,2) COMMENT 'Difference between actual and promised handling time (positive = overrun).',
    `measurement_unit` STRING COMMENT 'Unit used for time‑based SLA metrics.. Valid values are `hours|days`',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information about the SLA.',
    `promised_delivery_date` DATE COMMENT 'Date by which the order is expected to be delivered to the customer.',
    `promised_handling_time_hours` DECIMAL(18,2) COMMENT 'Maximum time allotted for order handling before shipping, expressed in hours.',
    `promised_ship_date` DATE COMMENT 'Date by which the order is expected to be shipped according to the SLA.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this SLA record was first persisted.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the SLA record.',
    `ship_date_delta_days` DECIMAL(18,2) COMMENT 'Number of days the actual ship date deviates from the promised ship date.',
    `sla_number` STRING COMMENT 'Human‑readable SLA code assigned by the Order Management System.',
    `sla_status` STRING COMMENT 'Current lifecycle state of the SLA record.. Valid values are `active|breached|fulfilled|cancelled|expired`',
    `sla_tier` STRING COMMENT 'Classification of service level commitment (e.g., standard, expedited).. Valid values are `standard|expedited|same_day|next_day|priority|custom`',
    CONSTRAINT pk_order_sla PRIMARY KEY(`order_sla_id`)
) COMMENT 'SLA commitment records governing order fulfillment and delivery timelines. Defines the promised handling time, promised ship date, promised delivery date, SLA tier (standard, expedited, same-day, next-day), SLA breach flag, breach reason, and actual vs. promised delta in hours. Supports OMS SLA orchestration, carrier SLA enforcement, and customer NPS correlation with delivery performance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`cancellation` (
    `cancellation_id` BIGINT COMMENT 'System-generated unique identifier for the cancellation event.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who initiated or is affected by the cancellation.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this cancellation applies.',
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
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Dispute resolution and compliance need the delivery proof image stored as a digital asset linked to the delivery confirmation.',
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
    `account_id` BIGINT COMMENT 'Identifier of the internal user who manually overrode or confirmed the allocation.',
    `center_id` BIGINT COMMENT 'FK to fulfillment.center.center_id — Order allocation to warehouse tracing. Without this FK, the OMS cannot determine which fulfillment center was assigned to process an order line — breaking allocation-to-dispatch traceability.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Carrier hand‑off and regulatory compliance require associating the generated shipping label PDF asset with each allocation.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this allocation belongs.',
    `line_id` BIGINT COMMENT 'Identifier of the specific order line being allocated.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Allocation of inventory to an order line must reference the goods receipt that supplied the stock for accurate inventory and financial reconciliation.',
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
    `shipping_zone` STRING COMMENT 'Geographic shipping zone used for rate calculation.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`b2b_order` (
    `b2b_order_id` BIGINT COMMENT 'Unique identifier for the B2B order record.',
    `account_id` BIGINT COMMENT 'Identifier of the user who approved the order.',
    `organization_id` BIGINT COMMENT 'Identifier of the corporate buyer organization placing the order.',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the contract governing pricing and terms for this order.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: b2b_order is an extended order record for B2B purchases; linking to the core order_header provides a single source of truth for order-level attributes and eliminates a silo.',
    `actual_delivery_date` DATE COMMENT 'Date the order was actually delivered to the buyer.',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the order.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the order received final approval.',
    `billing_address` STRING COMMENT 'Full billing address associated with the order.',
    `billing_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code for the billing address.',
    `carrier_name` STRING COMMENT 'Logistics carrier responsible for shipping.',
    `credit_check_passed` BOOLEAN COMMENT 'True if the buyer passed the creditworthiness assessment.',
    `credit_limit_status` STRING COMMENT 'Result of the credit limit check for the buyer organization.. Valid values are `within_limit|exceeded|pending_review`',
    `delivery_method` STRING COMMENT 'Chosen delivery service level for the order.. Valid values are `standard|express|overnight`',
    `edi_status` STRING COMMENT 'Current processing status of the EDI transaction.. Valid values are `sent|received|error|rejected`',
    `edi_transaction_reference` STRING COMMENT 'Identifier of the associated EDI transaction, if applicable.',
    `expected_delivery_date` DATE COMMENT 'Planned delivery date based on carrier SLA.',
    `fraud_check_status` STRING COMMENT 'Result of the automated fraud screening.. Valid values are `passed|failed|review`',
    `order_source_channel` STRING COMMENT 'Channel through which the order was submitted.',
    `order_type` STRING COMMENT 'Indicates whether the order is a new purchase, contract renewal, or return.. Valid values are `new|renewal|return`',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the buyer (e.g., NET30, NET60).',
    `po_number` STRING COMMENT 'Buyer‑provided purchase order reference number.',
    `pricing_tier` STRING COMMENT 'Pricing tier or discount level applicable under the contract.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the order record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the order record.',
    `shipment_tracking_number` STRING COMMENT 'Tracking identifier provided by the carrier.',
    `shipping_address` STRING COMMENT 'Full shipping address for order delivery.',
    `shipping_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code for the shipping destination.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the order failed to meet its SLA.',
    `sla_tier` STRING COMMENT 'Service‑level agreement tier promised to the buyer.. Valid values are `standard|premium|enterprise`',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the order is tax‑exempt under buyer’s tax status.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Aggregate discount value applied to the order.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total amount before discounts, taxes, and adjustments.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after discounts and taxes.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the order.',
    CONSTRAINT pk_b2b_order PRIMARY KEY(`b2b_order_id`)
) COMMENT 'Extended order record for B2B (business-to-business) purchase orders placed by corporate buyers. Captures PO number, buyer organization reference, contract pricing tier, payment terms (NET30, NET60), credit limit check status, bulk quantity, EDI transaction reference, approved buyer contact, and B2B-specific SLA tier. Extends the core order_header for enterprise procurement workflows distinct from B2C consumer orders.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`subscription_order` (
    `subscription_order_id` BIGINT COMMENT 'Unique identifier for the subscription order record.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who owns the subscription.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: subscription_order represents recurring orders; linking to order_header centralizes order-level data and removes duplication, connecting the previously siloed table.',
    `subscription_plan_id` BIGINT COMMENT 'Identifier of the subscription plan associated with this order.',
    `arr_amount` DECIMAL(18,2) COMMENT 'Revenue recognized on an annual basis from this subscription.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the subscription automatically renews after each cycle.',
    `billing_frequency` STRING COMMENT 'Recurrence interval for billing the subscription.. Valid values are `weekly|monthly|quarterly|yearly`',
    `cancellation_reason` STRING COMMENT 'Reason provided by the customer or system for cancelling the subscription.',
    `delivery_preference` STRING COMMENT 'Customer‑selected delivery option for recurring shipments.. Valid values are `standard|express|same_day|pickup`',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the subscription.',
    `end_date` DATE COMMENT 'Date when the subscription terminates or is scheduled to end (null for open‑ended).',
    `is_trial` BOOLEAN COMMENT 'Indicates whether the subscription is currently in a trial period.',
    `last_payment_date` DATE COMMENT 'Date of the most recent successful payment for this subscription.',
    `mrr_amount` DECIMAL(18,2) COMMENT 'Revenue recognized on a monthly basis from this subscription.',
    `next_order_date` DATE COMMENT 'Date on which the next recurring order will be generated.',
    `next_payment_date` DATE COMMENT 'Scheduled date for the upcoming payment.',
    `notes` STRING COMMENT 'Free‑form text for internal comments or special instructions.',
    `promo_code` STRING COMMENT 'Code of any promotion applied to the subscription.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the subscription order record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subscription order record.',
    `recurring_amount` DECIMAL(18,2) COMMENT 'Standard recurring charge for each billing cycle.',
    `renewal_cycle_count` STRING COMMENT 'Number of completed renewal cycles for the subscription.',
    `skip_count` STRING COMMENT 'Number of billing cycles the customer has chosen to skip.',
    `start_date` DATE COMMENT 'Date when the subscription becomes effective.',
    `subscription_term_months` STRING COMMENT 'Total length of the subscription contract in months.',
    `trial_end_date` DATE COMMENT 'Date when the trial period expires and regular billing begins.',
    CONSTRAINT pk_subscription_order PRIMARY KEY(`subscription_order_id`)
) COMMENT 'Records for recurring subscription-based orders (subscribe-and-save, auto-replenishment, membership-based orders). Captures subscription plan reference, billing frequency (weekly, monthly, quarterly), next order generation date, subscription status (active, paused, cancelled), discount rate applied, skip count, and customer-configured delivery preferences. Distinct from one-time order_header due to its recurring lifecycle and MRR/ARR contribution.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Primary key for the Allocation association',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to the order line being allocated',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to the purchase order line providing inventory',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory allocated from the PO line to the order line',
    `allocation_method` STRING COMMENT 'Method used for allocation (e.g., automatic, manual)',
    `allocation_status` STRING COMMENT 'Current status of the allocation (e.g., pending, completed, cancelled)',
    `allocation_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation was recorded',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'Represents the allocation of inventory from purchase order line items to order line items. Each record links one order_order_line to one po_line_item and captures the quantity allocated, the time of allocation, the status of the allocation, and the method used.. Existence Justification: In the e‑commerce fulfillment process, a single order line can be satisfied by multiple purchase order line items (split shipments), and a single PO line can supply multiple order lines (multiple customers or orders). The allocation of quantities, timestamps, and status is recorded in an allocation table that is actively created, updated, and deleted by operations staff.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`line` (
    `line_id` BIGINT COMMENT 'Primary key for the order_line association',
    `header_id` BIGINT COMMENT 'Foreign key linking to the order header',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to the marketplace listing',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to this line item',
    `quantity_ordered` BIGINT COMMENT 'Number of units of the listing ordered in this line',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to this line item',
    `total_gross` DECIMAL(18,2) COMMENT 'Gross total (quantity * unit price) before discounts and taxes',
    `total_net` DECIMAL(18,2) COMMENT 'Net total after applying discounts and taxes',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the listing at the time of the order',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'This association product represents the transactional line items linking an order_header to a marketplace_listing. It captures the quantity, unit price, discounts, taxes, and total amounts for each listing within an order.. Existence Justification: An order can contain multiple marketplace listings, and a single marketplace listing can be sold in many different orders over time. The line item captures the quantity, price, discounts, and taxes for each listing within an order, which are attributes that belong to the relationship itself, not to either the order or the listing alone.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`session` (
    `session_id` BIGINT COMMENT 'Primary key for session',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer associated with the session.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the session, if any.',
    `browser_name` STRING COMMENT 'Name of the web browser (e.g., Chrome, Safari).',
    `conversion_flag` BOOLEAN COMMENT 'True if the session resulted in a conversion event (e.g., purchase).',
    `conversion_type` STRING COMMENT 'Category of conversion that occurred during the session.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code derived from IP geolocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was first inserted into the data lake.',
    `device_code` STRING COMMENT 'Identifier of the device used for the session (e.g., mobile device ID).',
    `device_type` STRING COMMENT 'Class of device used for the session.',
    `exit_page_url` STRING COMMENT 'Last page URL visited before the session ended.',
    `ip_address` STRING COMMENT 'IP address from which the session originated.',
    `is_bounce` BOOLEAN COMMENT 'True if the session consisted of a single page view.',
    `is_new_visitor` BOOLEAN COMMENT 'True if this is the first recorded session for the user.',
    `landing_page_url` STRING COMMENT 'First page URL visited in the session.',
    `language` STRING COMMENT 'Language selected or inferred for the session.',
    `os_name` STRING COMMENT 'Operating system of the device (e.g., Windows, iOS).',
    `page_view_count` STRING COMMENT 'Number of distinct pages viewed during the session.',
    `referrer_url` STRING COMMENT 'URL of the page that referred the user to the site.',
    `region_code` STRING COMMENT 'Sub‑national region or state code derived from IP geolocation.',
    `session_duration_seconds` STRING COMMENT 'Total length of the session in seconds, calculated as end minus start.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the session ended or was terminated.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the session began.',
    `session_status` STRING COMMENT 'Current lifecycle state of the session.',
    `traffic_source` STRING COMMENT 'Marketing channel that brought the user to the site.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the session record.',
    `user_agent` STRING COMMENT 'Browser and operating system details reported by the client.',
    CONSTRAINT pk_session PRIMARY KEY(`session_id`)
) COMMENT 'Master reference table for session. Referenced by session_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`subscription_plan` (
    `subscription_plan_id` BIGINT COMMENT 'Primary key for subscription_plan',
    `upgraded_from_subscription_plan_id` BIGINT COMMENT 'Self-referencing FK on subscription_plan (upgraded_from_subscription_plan_id)',
    `auto_renew` BOOLEAN COMMENT 'Indicates whether the plan automatically renews at the end of each billing cycle.',
    `billing_cycle` STRING COMMENT 'Frequency at which customers are billed for the plan.',
    `cancellation_policy` STRING COMMENT 'Policy governing how and when a subscriber may cancel the plan.',
    `subscription_plan_description` STRING COMMENT 'Detailed marketing description of the plan, including benefits and features.',
    `effective_from` DATE COMMENT 'Date when the plan becomes legally binding and available for subscription.',
    `effective_until` DATE COMMENT 'Date when the plan is retired or expires; null for open‑ended plans.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which customers may subscribe to the plan.',
    `external_system_code` STRING COMMENT 'Identifier of the plan in an external billing or CRM system.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this plan is the default offering for new customers.',
    `is_featured` BOOLEAN COMMENT 'Flag to highlight the plan in marketing channels.',
    `max_items` STRING COMMENT 'Maximum number of items (e.g., orders, downloads) a subscriber may consume per billing cycle.',
    `max_users` STRING COMMENT 'Maximum number of distinct user accounts allowed under the plan.',
    `subscription_plan_name` STRING COMMENT 'Human‑readable name of the subscription plan displayed to customers.',
    `overage_fee_amount` DECIMAL(18,2) COMMENT 'Monetary charge applied per unit when usage exceeds the defined limit.',
    `plan_category` STRING COMMENT 'Business classification of the plan for segmentation and pricing strategy.',
    `plan_code` STRING COMMENT 'External business identifier code for the subscription plan, used in marketing and billing systems.',
    `plan_type` STRING COMMENT 'Category of the plan based on billing cadence or usage model.',
    `plan_version` STRING COMMENT 'Version number of the plan definition, incremented on each change.',
    `price_amount` DECIMAL(18,2) COMMENT 'Base monetary amount charged per billing cycle.',
    `price_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the plan price.',
    `promotional_code` STRING COMMENT 'Optional code that provides a discount or special terms for the plan.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the subscription plan record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subscription plan record.',
    `renewal_period_months` STRING COMMENT 'Number of months after which the subscription is renewed when auto‑renew is enabled.',
    `subscription_plan_status` STRING COMMENT 'Current lifecycle status of the plan.',
    `support_contact_email` STRING COMMENT 'Email address for customers to contact support regarding this plan.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether the plan is exempt from sales tax.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the plan when not tax‑exempt.',
    `trial_period_days` STRING COMMENT 'Number of days a customer can use the plan for free before regular billing starts.',
    `trial_price_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged during the trial period, if any.',
    `usage_limit` STRING COMMENT 'Overall usage limit (e.g., API calls, storage) associated with the plan.',
    CONSTRAINT pk_subscription_plan PRIMARY KEY(`subscription_plan_id`)
) COMMENT 'Master reference table for subscription_plan. Referenced by subscription_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_session_id` FOREIGN KEY (`session_id`) REFERENCES `ecommerce_ecm`.`order`.`session`(`session_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `ecommerce_ecm`.`order`.`cart`(`cart_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_session_id` FOREIGN KEY (`session_id`) REFERENCES `ecommerce_ecm`.`order`.`session`(`session_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_order_address_id` FOREIGN KEY (`order_address_id`) REFERENCES `ecommerce_ecm`.`order`.`order_address`(`order_address_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_header_order_address_id` FOREIGN KEY (`header_order_address_id`) REFERENCES `ecommerce_ecm`.`order`.`order_address`(`order_address_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `ecommerce_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ADD CONSTRAINT `fk_order_order_sla_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ADD CONSTRAINT `fk_order_b2b_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ADD CONSTRAINT `fk_order_subscription_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ADD CONSTRAINT `fk_order_subscription_order_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `ecommerce_ecm`.`order`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `ecommerce_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_plan` ADD CONSTRAINT `fk_order_subscription_plan_upgraded_from_subscription_plan_id` FOREIGN KEY (`upgraded_from_subscription_plan_id`) REFERENCES `ecommerce_ecm`.`order`.`subscription_plan`(`subscription_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` SET TAGS ('dbx_subdomain' = 'cart_management');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_email_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Email Sent Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_email_sent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_email_sent_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_reason` SET TAGS ('dbx_business_glossary_term' = 'Cart Abandonment Reason');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_number` SET TAGS ('dbx_business_glossary_term' = 'Cart Number (CART_NO)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_source` SET TAGS ('dbx_business_glossary_term' = 'Cart Source System');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_source` SET TAGS ('dbx_value_regex' = 'web|app|api|partner|offline');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_business_glossary_term' = 'Cart Status');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_value_regex' = 'active|abandoned|converted|expired|cancelled');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel (B2C/B2B/Marketplace/Mobile App)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'b2c|b2b|marketplace|mobile_app');
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
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_city` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address City');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 1');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 2');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Postal Code');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_state` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address State/Province');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_address_state` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'User Session Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `variant_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Variant Identifier');
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
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'in_stock|out_of_stock|reserved|allocated|backordered');
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
ALTER TABLE `ecommerce_ecm`.`order`.`header` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
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
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center ID (FCID)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `header_order_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID (SAID)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `header_order_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `header_order_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `price_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Price Approval Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `query_log_id` SET TAGS ('dbx_business_glossary_term' = 'Query Log Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID (SID)');
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
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source (OSRC)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|api');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status (OS)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|shipped|delivered|cancelled|returned');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (OT)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|gift|subscription');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PM)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|paypal|bank_transfer|gift_card|apple_pay');
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
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for order_order_line');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `dynamic_price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Indexed Document Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Line Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `markdown_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Schedule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `result_id` SET TAGS ('dbx_business_glossary_term' = 'Result Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `asin` SET TAGS ('dbx_business_glossary_term' = 'Amazon Standard Identification Number (ASIN)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions (cm)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'allocated|picked|packed|shipped|delivered|failed');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'warehouse|drop_ship|store_pickup|third_party');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `is_backordered` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Gift Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `is_returnable` SET TAGS ('dbx_business_glossary_term' = 'Returnable Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `line_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Percent');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|shipped|delivered|canceled|returned');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `line_total_gross` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Total');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `line_total_net` SET TAGS ('dbx_business_glossary_term' = 'Line Net Total');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `quantity_fulfilled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Fulfilled');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `restricted_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Item Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window (Days)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'standard|express|overnight|pickup|drone|freight');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Selling Price (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Actor Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
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
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_id` SET TAGS ('dbx_business_glossary_term' = 'Order Address ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Original Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `privacy_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` SET TAGS ('dbx_subdomain' = 'payment_accounting');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `order_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Payment ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|gift_card|store_credit|paypal');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|failed|refunded|partial|voided');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (Token)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `refunded_amount` SET TAGS ('dbx_business_glossary_term' = 'Refunded Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` SET TAGS ('dbx_subdomain' = 'payment_accounting');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `order_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Order Promotion ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Applied Order Line ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `merchandising_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`order`.`tax` SET TAGS ('dbx_subdomain' = 'payment_accounting');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Order Tax Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `order_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Order SLA Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `actual_handling_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Handling Time (Hours)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `breach_reason` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Reason');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `breach_reason` SET TAGS ('dbx_value_regex' = 'late_handling|late_ship|late_delivery|exception|customer_cancel|other');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Type');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'handling|shipping|delivery|full');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `delivery_date_delta_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date Delta (Days)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'SLA Effective From Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'SLA Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `handling_time_delta_hours` SET TAGS ('dbx_business_glossary_term' = 'Handling Time Delta (Hours)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'SLA Measurement Unit');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'hours|days');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SLA Notes');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `promised_handling_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Promised Handling Time (Hours)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `promised_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Ship Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `ship_date_delta_days` SET TAGS ('dbx_business_glossary_term' = 'Ship Date Delta (Days)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `sla_number` SET TAGS ('dbx_business_glossary_term' = 'SLA Number');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|breached|fulfilled|cancelled|expired');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier');
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|expedited|same_day|next_day|priority|custom');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` SET TAGS ('dbx_subdomain' = 'payment_accounting');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
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
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Digital Asset Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `fulfillment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Allocation Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated By User ID');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Digital Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `shipping_zone` SET TAGS ('dbx_business_glossary_term' = 'Shipping Zone');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `sla_actual_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `sla_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Target (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `split_shipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Split Shipment Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `tax_estimate` SET TAGS ('dbx_business_glossary_term' = 'Tax Estimate (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` SET TAGS ('dbx_subdomain' = 'payment_accounting');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `b2b_order_id` SET TAGS ('dbx_business_glossary_term' = 'B2B Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User ID');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Organization ID');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `billing_address` SET TAGS ('dbx_business_glossary_term' = 'Billing Address');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `billing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `credit_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Passed');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `credit_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Status');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `credit_limit_status` SET TAGS ('dbx_value_regex' = 'within_limit|exceeded|pending_review');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'standard|express|overnight');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `edi_status` SET TAGS ('dbx_business_glossary_term' = 'EDI Status');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `edi_status` SET TAGS ('dbx_value_regex' = 'sent|received|error|rejected');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `edi_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'EDI Transaction ID');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Check Status');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|review');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Source Channel');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_active' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_web' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_mobile' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_api' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_call_center' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'new|renewal|return');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `shipping_address` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `shipping_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `shipping_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `shipping_country` SET TAGS ('dbx_business_glossary_term' = 'Shipping Country');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` SET TAGS ('dbx_subdomain' = 'payment_accounting');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `subscription_order_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan ID');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `arr_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Recurring Revenue (ARR)');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renew Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `delivery_preference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Preference');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `delivery_preference` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|pickup');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Percent)');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `is_trial` SET TAGS ('dbx_business_glossary_term' = 'Trial Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `mrr_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR)');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `next_order_date` SET TAGS ('dbx_business_glossary_term' = 'Next Order Generation Date');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `next_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Date');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Subscription Notes');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `recurring_amount` SET TAGS ('dbx_business_glossary_term' = 'Recurring Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `renewal_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Count');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `skip_count` SET TAGS ('dbx_business_glossary_term' = 'Skip Count');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `subscription_term_months` SET TAGS ('dbx_business_glossary_term' = 'Subscription Term (Months)');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` SET TAGS ('dbx_association_edges' = 'order.order_order_line,procurement.po_line_item');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Allocation Id');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Order Order Line Id');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Po Line Item Id');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`order`.`line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `ecommerce_ecm`.`order`.`line` SET TAGS ('dbx_association_edges' = 'order.order_header,marketplace.marketplace_listing');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Order Line Id');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Sales Order Id');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Marketplace Listing Id');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Tax');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `total_gross` SET TAGS ('dbx_business_glossary_term' = 'Line Total Gross');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `total_net` SET TAGS ('dbx_business_glossary_term' = 'Line Total Net');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `ecommerce_ecm`.`order`.`session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`order`.`session` SET TAGS ('dbx_subdomain' = 'cart_management');
ALTER TABLE `ecommerce_ecm`.`order`.`session` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`session` ALTER COLUMN `account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`session` ALTER COLUMN `account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`session` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`session` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_plan` SET TAGS ('dbx_subdomain' = 'payment_accounting');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_plan` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_plan` ALTER COLUMN `upgraded_from_subscription_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
