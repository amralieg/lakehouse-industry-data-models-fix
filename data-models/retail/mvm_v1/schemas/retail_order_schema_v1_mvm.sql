-- Schema for Domain: order | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`order` COMMENT 'Manages omnichannel order lifecycle from cart creation through fulfillment including online orders, in-store POS transactions, BOPIS (Buy Online Pick Up In Store), ROPIS, ship-from-store (SFS), and drop-ship orders. Tracks order headers, line items, payment methods, fulfillment status, delivery tracking, and RMA (Return Merchandise Authorization). Integrates with OMS for end-to-end order orchestration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`order`.`header` (
    `header_id` BIGINT COMMENT 'Unique identifier for the order header record. Primary key for the order header entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: B2B and account-based retail operations require tracking orders against customer accounts for credit limit enforcement, account statement generation, billing cycle management, and corporate purchasing',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retail orders require cost center allocation for internal accounting, departmental P&L tracking, B2B order costing, and management reporting. Standard practice in multi-department retail operations fo',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the store, distribution center, or warehouse responsible for fulfilling this order. Cross-domain reference to inventory or store domain.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Omnichannel order attribution: retail orders (BOPIS, in-store pickup, ship-from-store) must be attributed to the originating or fulfilling store location for store-level P&L reporting, sales comp repo',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Online and phone orders must link to loyalty membership for points accrual, tier-based pricing, personalized promotions, and member purchase history tracking—core retail loyalty operations.',
    `outbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_shipment. Business justification: Retail order-to-shipment traceability: the outbound_shipment from the DC is the physical execution of the customer order. Customer service, carrier billing reconciliation, and on-time delivery reporti',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Order-level pricing audit and customer segment revenue reporting require knowing which price list (VIP, wholesale, regional) governed the entire order. Retail pricing analysts and finance teams reconc',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed the order. Links to customer master data.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Retail operations tag customer orders with selling season for seasonal performance analysis, trend reporting, merchandising plan effectiveness measurement, and comparing actual sales against seasonal ',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla. Business justification: Each order header is governed by a fulfillment SLA based on channel, geography, and customer tier. This FK enables promised_delivery_date validation at order creation, SLA breach reporting, customer c',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.purchase_order. Business justification: Retail drop-ship orders where vendor ships directly to customer require tracking the source supplier PO for cost reconciliation, vendor chargeback processing, and fulfillment exception handling. Essen',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Storefront-level sales reporting and revenue attribution require linking each online order header to its originating storefront. Retail omnichannel analytics and P&L reporting by digital channel depen',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to order.subscription. Business justification: A subscription generates recurring order headers (one subscription produces many headers over its lifecycle). Without this FK, subscription-generated orders cannot be traced back to their originating ',
    `actual_delivery_date` DATE COMMENT 'Actual date the order was delivered to the customer. Null until delivery is confirmed.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the payment method.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address for apartment, suite, or unit number.',
    `billing_city` STRING COMMENT 'City or municipality for the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address.',
    `billing_state_province` STRING COMMENT 'State, province, or region for the billing address.',
    `carrier_code` STRING COMMENT 'Code identifying the shipping carrier or third-party logistics (3PL) provider handling delivery (e.g., UPS, FedEx, USPS).',
    `channel` STRING COMMENT 'Sales channel through which the order was originated. Distinguishes omnichannel order sources for analytics and fulfillment routing.. Valid values are `web|mobile_app|store_pos|call_center|marketplace|kiosk`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order header record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_email` STRING COMMENT 'Email address provided by the customer for order confirmation and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_phone` STRING COMMENT 'Contact phone number for delivery coordination and customer service.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order including promotional discounts, coupons, loyalty rewards, and markdowns.',
    `grand_total_amount` DECIMAL(18,2) COMMENT 'Final order total including subtotal, tax, shipping, minus discounts. Amount charged to customer payment method.',
    `locale` STRING COMMENT 'Language and regional locale for the order (e.g., en_US, fr_CA). Used for localized content and formatting.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `oms_reference_code` STRING COMMENT 'External reference identifier from the Order Management System for end-to-end order orchestration and tracking.',
    `order_date` TIMESTAMP COMMENT 'Date and time when the order was placed by the customer. Principal business event timestamp for the transaction.',
    `order_number` STRING COMMENT 'Externally-known unique business identifier for the order. Used for customer communication, tracking, and cross-system reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the order in the fulfillment workflow. Tracks progression from creation through final disposition. [ENUM-REF-CANDIDATE: draft|submitted|confirmed|processing|picking|packing|shipped|delivered|completed|cancelled|returned — 11 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of order fulfillment method. BOPIS (Buy Online Pick Up In Store), ROPIS (Reserve Online Pick Up In Store), SFS (Ship From Store), or standard home delivery. [ENUM-REF-CANDIDATE: standard|bopis|ropis|ship_from_store|drop_ship|exchange|replacement — 7 candidates stripped; promote to reference product]',
    `payment_method` STRING COMMENT 'Primary payment instrument used for the order. Identifies the payment type without exposing sensitive card details. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|gift_card|store_credit|cash|check|bank_transfer — 10 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current status of payment processing for the order. Tracks authorization, capture, and settlement lifecycle. [ENUM-REF-CANDIDATE: pending|authorized|captured|paid|failed|refunded|partially_refunded — 7 candidates stripped; promote to reference product]',
    `promised_delivery_date` DATE COMMENT 'Date committed to the customer for order delivery. Used for SLA compliance measurement.',
    `requested_delivery_date` DATE COMMENT 'Customer-requested target delivery date. Used for scheduling and SLA tracking.',
    `shipping_address_line1` STRING COMMENT 'First line of the shipping address including street number and name. Primary delivery location identifier.',
    `shipping_address_line2` STRING COMMENT 'Second line of the shipping address for apartment, suite, or unit number. Optional address detail.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'Shipping and handling charges for order delivery. Zero for in-store pickup orders.',
    `shipping_city` STRING COMMENT 'City or municipality for the shipping address.',
    `shipping_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipping address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `shipping_postal_code` STRING COMMENT 'Postal or ZIP code for the shipping address. Critical for carrier routing and delivery zone determination.',
    `shipping_state_province` STRING COMMENT 'State, province, or region for the shipping address. Used for tax jurisdiction and carrier routing.',
    `source_system` STRING COMMENT 'Name of the originating system that created this order record (e.g., Salesforce Commerce Cloud, SAP S/4HANA, Store POS).',
    `special_instructions` STRING COMMENT 'Customer-provided delivery instructions or notes (e.g., gate code, leave at door, signature required).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, discounts, and shipping charges. Base merchandise value.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax applied to the order based on jurisdiction and product taxability rules.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and customer self-service tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this order header record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core master record for every omnichannel order. Captures order number, channel origin (web, app, call center, marketplace), order date/time, customer reference, fulfillment node reference (FK to store/distribution domain), order status, currency, locale, totals (subtotal, tax, discount, shipping, grand total), OMS reference ID, source system, and audit timestamps. SSOT for order identity and lifecycle. Carrier and fulfillment node masters are owned by peer domains and referenced via cross-domain FK.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order line item. Primary key for the order line product.',
    `accrual_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.accrual_rule. Business justification: Each order line earns points under a specific accrual rule (product category multiplier, promo bonus). Recording the applied rule per line enables points audit trails, member dispute resolution, and l',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_item. Business justification: Assortment sell-through reporting — a core merchandising KPI — requires linking actual sales (order lines) to the assortment item plan. Retail merchandisers track planned vs. actual units sold per ass',
    `buying_order_line_id` BIGINT COMMENT 'Foreign key linking to merchandising.buying_order_line. Business justification: Sell-through and vendor performance reporting requires tracing customer order lines back to the buying order line that sourced the inventory. Retail merchandisers use this link to measure actual vs. p',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line-level cost center assignment enables accurate departmental P&L in mixed-cart orders, supports product category profitability analysis, and is required for internal management accounting and segme',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: COGS audit and gross margin reporting require the exact cost record (landed cost, duty, freight) used at order line fulfillment time. order_line.cost_of_goods_sold is a scalar snapshot; the FK enables',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Department-level sales reporting: order lines must be attributed to a store department for department P&L, gross margin targets, and shrinkage rate analysis. Retail domain experts expect order lines t',
    `digital_catalog_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_catalog. Business justification: Catalog-to-conversion reporting — identifying which digital product listing drove each sale — is a core e-commerce analytics requirement. Merchandising and content teams use this for A/B test attribut',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Ship-from-store and BOPIS fulfillment: individual order lines can be fulfilled from different store locations. Store-level fulfillment attribution per line drives store inventory depletion, store P&L ',
    `fulfillment_node_id` BIGINT COMMENT 'Identifier of the distribution center, store, or warehouse assigned to fulfill this line. Supports split-fulfillment where different lines ship from different nodes.',
    `header_id` BIGINT COMMENT 'Foreign key reference to the parent order header. Links this line item to its containing order transaction.',
    `item_bundle_id` BIGINT COMMENT 'Foreign key linking to product.item_bundle. Business justification: When a customer orders a product bundle, the order line must reference the bundle definition to enforce bundle pricing rules, validate component quantities, apply bundle discounts, and drive component',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Lot traceability is mandatory for recalls, quality issues, and regulatory compliance in retail (especially food, pharma, cosmetics). Fulfillment systems must record which specific lot/batch was picked',
    `markdown_event_id` BIGINT COMMENT 'Foreign key linking to merchandising.markdown_event. Business justification: Omnichannel markdown impact reporting requires linking online/digital order lines sold at markdown prices to the authorizing markdown_event. Merchandising teams measure actual revenue and margin impac',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: Markdown sell-through reporting — a core retail buying KPI — requires linking order lines to the markdown event that authorized the reduced price. Buyers track units sold and revenue per markdown even',
    `member_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.member_offer. Business justification: Each online/omnichannel order line may be fulfilled under a specific personalized member offer. Needed for offer attribution reporting, loyalty personalization ROI analysis, and member offer redemptio',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supplychain.po_line. Business justification: Drop-ship retail operations require line-level PO-to-order-line reconciliation: which specific PO line is fulfilling which customer order line. Retail buyers and operations teams use this for fill-rat',
    `price_change_id` BIGINT COMMENT 'Foreign key linking to pricing.price_change. Business justification: Retail margin analysis requires linking each order line to the price change event (promotional, competitive, cost-driven) that set the unit retail price. Pricing analysts measure price change effectiv',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center allocation at line level is essential for channel profitability analysis, store/DC performance measurement, segment reporting, and financial consolidation. Retail standard for tracking m',
    `promo_offer_id` BIGINT COMMENT 'Identifier of the promotion applied to this line item. Links to the promotion master for discount calculation and campaign tracking.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.purchase_order. Business justification: Drop-ship and special-order retail: each order line references the specific PO created to source that item. Retail operations teams use this for line-level PO-to-customer-order traceability, vendor ac',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Order lines must reference the product SKU being ordered. The product_description column becomes redundant as it can be joined from product.sku. This is a fundamental cross-domain relationship between',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: Order lines capture actual transaction prices. Linking to sku_price enables margin variance analysis, promotional effectiveness measurement, price compliance auditing, and reconciliation between plann',
    `uom_id` BIGINT COMMENT 'Foreign key linking to product.uom. Business justification: Order line fulfillment requires UOM conversion factor lookups for inventory deduction accuracy, carrier weight calculations, and cross-channel unit reconciliation. Current unit_of_measure string preve',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: Order line costing, margin reporting, and vendor compliance tracking require resolving which vendor_item record governs unit cost and pack configuration for the SKU-vendor combination. Retail OMS and ',
    `actual_ship_date` DATE COMMENT 'Actual date when this line item was shipped from the fulfillment node. Used for SLA performance measurement and delivery estimation.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether this line item is on backorder due to insufficient inventory at order time. True if the item will be shipped when inventory becomes available.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating why this line was cancelled. Populated only when line_status is CANCELLED. Enables root cause analysis of order cancellations.. Valid values are `OUT_OF_STOCK|CUSTOMER_REQUEST|PRICING_ERROR|FRAUD|PAYMENT_FAILED|ADDRESS_INVALID`',
    `cancelled_quantity` DECIMAL(18,2) COMMENT 'Quantity cancelled and not fulfilled. Tracks partial cancellations where only a portion of the ordered quantity is cancelled.',
    `carrier_code` STRING COMMENT 'Code identifying the shipping carrier assigned to deliver this line item. Supports multi-carrier fulfillment strategies. [ENUM-REF-CANDIDATE: FEDEX|UPS|USPS|DHL|ONTRAC|LASERSHIP|LOCAL_COURIER — 7 candidates stripped; promote to reference product]',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Unit cost of the product at the time of order fulfillment. Used for margin analysis and profitability reporting. Business-confidential financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was first created in the system. Represents the moment the line item was added to the order.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Supports multi-currency transactions in global retail operations.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item. Includes promotional discounts, markdowns, coupons, and loyalty rewards applied at the line level.',
    `expected_ship_date` DATE COMMENT 'Planned date when this line item is expected to ship from the fulfillment node. Used for customer communication and Service Level Agreement (SLA) tracking.',
    `extended_price` DECIMAL(18,2) COMMENT 'Total price for this line item before discounts and taxes. Calculated as ordered_quantity multiplied by unit_retail_price.',
    `fulfillment_method` STRING COMMENT 'Method by which this line will be fulfilled. Supports omnichannel fulfillment including ship-to-home, Buy Online Pick Up In Store (BOPIS), Reserve Online Pick Up In Store (ROPIS), Ship-from-Store (SFS), and drop-ship.. Valid values are `SHIP_TO_HOME|BOPIS|ROPIS|SFS|DROP_SHIP|IN_STORE_PICKUP`',
    `gift_flag` BOOLEAN COMMENT 'Indicates whether this line item is marked as a gift. True if the customer designated this item for gift wrapping, gift messaging, or special handling.',
    `gift_message` STRING COMMENT 'Customer-provided gift message to be included with this line item. Populated only when gift_flag is true.',
    `gtin` STRING COMMENT '14-digit Global Trade Item Number. International standard for product identification across the supply chain.. Valid values are `^[0-9]{14}$`',
    `line_number` STRING COMMENT 'Sequential line number within the order. Determines the display and processing order of line items within a single order header.',
    `line_status` STRING COMMENT 'Current fulfillment status of this order line. Tracks the line through the fulfillment lifecycle from order confirmation to final delivery or cancellation. [ENUM-REF-CANDIDATE: PENDING|CONFIRMED|ALLOCATED|PICKED|PACKED|SHIPPED|DELIVERED|CANCELLED|RETURNED — 9 candidates stripped; promote to reference product]',
    `margin_amount` DECIMAL(18,2) COMMENT 'Gross margin for this line item calculated as line_total minus cost_of_goods_sold. Key metric for profitability analysis and Gross Margin Return on Investment (GMROI) calculations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was last modified. Tracks any updates to quantity, status, pricing, or fulfillment details.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the product ordered by the customer. Supports fractional quantities for weight-based or volume-based items.',
    `original_sku` STRING COMMENT 'Original SKU that was ordered by the customer, populated only when substitution_flag is true. Enables tracking of substitution patterns and customer acceptance rates.. Valid values are `^[A-Z0-9]{8,14}$`',
    `personalization_notes` STRING COMMENT 'Special instructions for product personalization such as monogramming, engraving, or custom text. Captured at order time and passed to fulfillment operations.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why this line was returned by the customer. Populated when returned_quantity is greater than zero. Supports Return Merchandise Authorization (RMA) processing.. Valid values are `DEFECTIVE|WRONG_ITEM|NOT_AS_DESCRIBED|NO_LONGER_NEEDED|SIZE_FIT|DAMAGED_IN_TRANSIT`',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Quantity returned by the customer after delivery. Supports partial returns and links to Return Merchandise Authorization (RMA) processing.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity shipped to the customer. May differ from ordered_quantity due to partial fulfillment, substitutions, or inventory constraints.',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether this line item is a substitution for an out-of-stock product. True if a substitute product was provided instead of the originally ordered item.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on this line item. Includes sales tax, VAT, GST, or other applicable taxes based on jurisdiction and product category.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction for this line item. Determines applicable tax rates based on ship-to location and product tax category.. Valid values are `^[A-Z]{2,5}$`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Effective tax rate applied to this line item expressed as a decimal. For example, 0.0825 represents 8.25 percent sales tax.',
    `total` DECIMAL(18,2) COMMENT 'Final total amount for this line item after discounts and taxes. Calculated as extended_price minus discount_amount plus tax_amount.',
    `tracking_number` STRING COMMENT 'Carrier tracking number for this line item shipment. Enables customer self-service tracking and last-mile delivery visibility.',
    `unit_retail_price` DECIMAL(18,2) COMMENT 'Price per unit at the time of order. Represents the Average Unit Retail (AUR) before any line-level discounts or promotions.',
    `upc` STRING COMMENT '12-digit Universal Product Code barcode identifier. Standard North American product identifier used at point of sale.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line-item detail within an order header. Captures SKU/UPC/GTIN, product description snapshot, ordered quantity, unit retail price (AUR), extended price, discount amount, tax amount, line status, fulfillment method per line (ship, BOPIS, ROPIS, SFS, drop-ship), substitution flag, gift flag, personalization notes, and line-level cancellation reason. Supports split-fulfillment where different lines ship from different nodes.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique identifier for each status transition record in the order lifecycle. Primary key for the immutable audit trail.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Order status transitions track service level changes (upgrade to overnight, downgrade due to inventory). Business requires carrier_service_id to analyze SLA breach rates by service tier and generate c',
    `fulfillment_node_id` BIGINT COMMENT 'Identifier of the physical or logical node (store, DC, MFC, dark store, vendor) responsible for this stage of fulfillment. Enables location-based performance tracking.',
    `header_id` BIGINT COMMENT 'Reference to the order header that this status transition belongs to. Links this status event to the parent order entity.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Store-level SLA and exception reporting: order status events such as ready for pickup, picked up in store, or exception at store must be attributed to a store location for store-level SLA breach',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Order lines have their own lifecycle status (line_status on order_line) that transitions independently from the header status — e.g., a single line can be backordered, partially shipped, or cancelled ',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Status events like shipped, out_for_delivery, delivered are directly triggered by shipment records. This FK enables carrier SLA breach analysis and customer notification audit trails. tracking_n',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The exact date and time when the order was successfully delivered to the customer. Populated only for DELIVERED status. Critical for SLA compliance measurement.',
    `assigned_to_team_code` STRING COMMENT 'Code identifying the team or department responsible for resolving this exception. Supports workload distribution and capacity planning.',
    `carrier_code` STRING COMMENT 'Identifier of the shipping carrier responsible for delivery at this stage. Populated for SHIPPED, IN_TRANSIT, OUT_FOR_DELIVERY, and DELIVERED statuses.',
    `created_by_process` STRING COMMENT 'Identifier of the ETL job, API call, or data ingestion process that created this record in the lakehouse. Supports data lineage and troubleshooting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this status history record was created in the data platform. Distinct from transition_timestamp which represents the business event time.',
    `customer_notification_channel` STRING COMMENT 'The communication channel used to notify the customer of this status change. Null if no notification was sent.. Valid values are `EMAIL|SMS|PUSH|IN_APP|NONE`',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicator of whether a customer notification (email, SMS, push) was sent for this status transition. Supports customer communication audit.',
    `duration_in_previous_status_minutes` STRING COMMENT 'The number of minutes the order spent in the previous status before this transition. Enables stage-level performance analysis.',
    `estimated_delivery_date` DATE COMMENT 'Projected delivery date communicated to the customer at this status transition. Updated as the order progresses through fulfillment stages.',
    `event_sequence_number` STRING COMMENT 'Sequential number indicating the order of status transitions for this order. Enables chronological sorting and gap detection.',
    `exception_category` STRING COMMENT 'High-level classification of the exception type. Enables exception trend analysis and root cause identification. [ENUM-REF-CANDIDATE: INVENTORY|PAYMENT|ADDRESS|CARRIER|FRAUD|QUALITY|SYSTEM|CUSTOMER|NONE — 9 candidates stripped; promote to reference product]',
    `exception_flag` BOOLEAN COMMENT 'Indicator of whether this status transition represents an exception or abnormal condition requiring intervention. True for statuses like FAILED, ON_HOLD, CANCELLED.',
    `fulfillment_node_type` STRING COMMENT 'Classification of the fulfillment node handling this order stage. Supports omnichannel fulfillment strategy analysis. [ENUM-REF-CANDIDATE: STORE|DC|MFC|DARK_STORE|VENDOR|3PL|CROSS_DOCK — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this status transition. Captures operational context not covered by structured fields.',
    `order_type` STRING COMMENT 'Classification of the order fulfillment model. Denormalized for performance in fulfillment-type-specific analysis. BOPIS = Buy Online Pick Up In Store, ROPIS = Reserve Online Pick Up In Store, SFS = Ship From Store. [ENUM-REF-CANDIDATE: STANDARD|BOPIS|ROPIS|SFS|DROP_SHIP|SUBSCRIPTION|RUSH — 7 candidates stripped; promote to reference product]',
    `previous_status_code` STRING COMMENT 'The status that the order was in immediately before this transition. Enables tracking of status flow and identifying invalid state transitions. [ENUM-REF-CANDIDATE: CREATED|CONFIRMED|ALLOCATED|PICKED|PACKED|SHIPPED|IN_TRANSIT|OUT_FOR_DELIVERY|DELIVERED|CANCELLED|RETURNED|REFUNDED|FAILED|ON_HOLD|BACKORDERED — 15 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority assigned to this status transition or exception. Drives resolution sequencing and resource allocation.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `resolution_required_flag` BOOLEAN COMMENT 'Indicator of whether this status transition requires manual resolution or intervention. True for exceptions that cannot be auto-resolved.',
    `sla_breach_duration_minutes` STRING COMMENT 'The number of minutes by which the SLA was breached. Null if no breach occurred. Enables quantitative analysis of service failures.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether this status transition violated the defined SLA target. True if transition occurred after the SLA target timestamp.',
    `sla_target_timestamp` TIMESTAMP COMMENT 'The target date and time by which this status transition should have occurred per the service level agreement. Enables SLA breach detection.',
    `source_order_channel` STRING COMMENT 'The originating channel through which the order was placed. Denormalized for performance in channel-specific SLA analysis. [ENUM-REF-CANDIDATE: WEB|MOBILE_APP|STORE|CALL_CENTER|MARKETPLACE|SOCIAL|KIOSK — 7 candidates stripped; promote to reference product]',
    `source_system_transaction_code` STRING COMMENT 'Unique transaction or event identifier from the originating system. Enables end-to-end traceability and reconciliation across systems.',
    `status_code` STRING COMMENT 'The new status that the order transitioned to at this point in time. Represents the current state in the order fulfillment lifecycle. [ENUM-REF-CANDIDATE: CREATED|CONFIRMED|ALLOCATED|PICKED|PACKED|SHIPPED|IN_TRANSIT|OUT_FOR_DELIVERY|DELIVERED|CANCELLED|RETURNED|REFUNDED|FAILED|ON_HOLD|BACKORDERED — 15 candidates stripped; promote to reference product]',
    `transition_reason_code` STRING COMMENT 'Standardized code explaining why the status transition occurred. Enables root cause analysis for exceptions and delays. [ENUM-REF-CANDIDATE: CUSTOMER_REQUEST|INVENTORY_UNAVAILABLE|PAYMENT_FAILED|ADDRESS_INVALID|CARRIER_DELAY|SYSTEM_ERROR|FRAUD_DETECTED|QUALITY_ISSUE|DAMAGED_IN_TRANSIT|CUSTOMER_REFUSED|BUSINESS_RULE|MANUAL_OVERRIDE|AUTOMATED_PROCESS — 13 candidates stripped; promote to reference product]',
    `transition_reason_description` STRING COMMENT 'Free-text explanation providing additional context for the status transition. Captures details not covered by the standardized reason code.',
    `transition_timestamp` TIMESTAMP COMMENT 'The exact date and time when the order status changed to the new status. Critical for SLA (Service Level Agreement) tracking and customer-facing order tracking.',
    `triggering_system_code` STRING COMMENT 'Identifier of the system or application that initiated this status transition. Enables system-level performance analysis and troubleshooting. [ENUM-REF-CANDIDATE: OMS|WMS|TMS|POS|ECOM|CARRIER_API|PAYMENT_GATEWAY|FRAUD_ENGINE|CSR_PORTAL|BATCH_JOB|EDI|MOBILE_APP — 12 candidates stripped; promote to reference product]',
    `triggering_user_name` STRING COMMENT 'Display name of the user who triggered the status change. Provides human-readable context for manual interventions.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Immutable audit trail of every status transition for an order header throughout its lifecycle (e.g., CREATED → CONFIRMED → ALLOCATED → PICKED → SHIPPED → DELIVERED → RETURNED). Captures status code, previous status, transition timestamp, triggering system/user, reason code, and node identifier. Enables SLA tracking, exception management, and customer-facing order tracking.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`pos_transaction` (
    `pos_transaction_id` BIGINT COMMENT 'Unique identifier for the POS transaction record. Primary key for in-store register transactions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: POS transactions must be allocated to cost centers for store-level P&L, department performance tracking, and internal management reporting. Required for daily sales accounting, variance analysis, and ',
    `header_id` BIGINT COMMENT 'Reference to the order header for omnichannel transactions such as BOPIS (Buy Online Pick Up In Store) pickups or ship-from-store fulfillments that originated as digital orders.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: POS transactions require direct membership link for real-time points posting, tier validation, member-only pricing, receipt balance printing, and daily loyalty reconciliation—critical in-store loyalty',
    `original_transaction_pos_transaction_id` BIGINT COMMENT 'Reference to the original POS transaction being returned or exchanged when transaction_type is return or exchange.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to customer.payment_method. Business justification: Omnichannel payment method usage reporting and stored-card fraud detection require linking POS transactions to the customers stored payment method. primary_payment_method is a denormalized text field',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier of the POS terminal device used to process the transaction.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Zone-level pricing compliance and revenue analytics require knowing which price zone was active for each POS transaction. Retail pricing teams audit that correct zone prices were charged at each store',
    `location_id` BIGINT COMMENT 'Identifier of the retail store location where the transaction occurred.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who made the purchase. Populated when loyalty card is scanned or customer account is identified.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Every POS transaction requires profit center assignment for segment reporting, store profitability analysis, financial consolidation, and management reporting. Fundamental requirement for retail finan',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: POS transactions analyzed by season for in-store seasonal sell-through reporting, validating merchandising plans against actual store performance, seasonal GMROI calculation, and measuring effectivene',
    `business_date` DATE COMMENT 'Retail business day to which this transaction is attributed for financial reporting. May differ from transaction timestamp for transactions after store closing but before end-of-day processing.',
    `change_amount` DECIMAL(18,2) COMMENT 'Cash change returned to the customer when tender_amount exceeds total_amount.',
    `coupon_count` STRING COMMENT 'Number of coupons redeemed in the transaction including manufacturer coupons and store coupons.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the POS transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the transaction including promotional discounts, coupons, markdowns, and employee discounts.',
    `fiscal_receipt_number` STRING COMMENT 'Government-mandated fiscal receipt identifier for tax compliance and audit purposes. Required in jurisdictions with fiscal receipt regulations.',
    `fulfillment_type` STRING COMMENT 'Fulfillment method for the transaction distinguishing between traditional in-store purchases and omnichannel fulfillment scenarios.. Valid values are `in_store_purchase|bopis_pickup|ropis_pickup|ship_from_store|curbside_pickup`',
    `item_count` STRING COMMENT 'Total number of distinct line items in the transaction basket. Used for basket analysis and UPT (Units Per Transaction) calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the POS transaction record was last updated. Used for audit trail and data synchronization.',
    `loyalty_card_number` STRING COMMENT 'Loyalty program card number scanned during the transaction for points accrual and customer identification.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the customer for this transaction based on purchase amount and promotional multipliers.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the customer during this transaction for discounts or rewards.',
    `manager_override_flag` BOOLEAN COMMENT 'Indicates whether a manager override was required during the transaction for actions such as large discounts, voids, or policy exceptions.',
    `payment_method_count` STRING COMMENT 'Number of distinct payment methods used in the transaction. Supports split-tender analysis.',
    `promotion_count` STRING COMMENT 'Number of distinct promotions applied to the transaction. Used for promotional effectiveness analysis.',
    `receipt_email` STRING COMMENT 'Email address provided by the customer for digital receipt delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `receipt_phone` STRING COMMENT 'Phone number provided by the customer for SMS receipt delivery or order pickup notifications.',
    `register_number` STRING COMMENT 'Physical register or checkout lane number within the store where the transaction was processed.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for return when transaction_type is return. Used for return analytics and product quality monitoring.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, fees, and discounts are applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax charged on the transaction based on applicable tax jurisdiction and product tax categories.',
    `tender_amount` DECIMAL(18,2) COMMENT 'Total amount tendered by the customer across all payment methods. May exceed total_amount when cash change is given.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount tendered by the customer including all items, taxes, fees, and after all discounts. Represents the net transaction value and ATV (Average Transaction Value).',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity of all items purchased in the transaction, summed across all line items. May differ from item_count when multiple units of the same SKU are purchased.',
    `training_mode_flag` BOOLEAN COMMENT 'Indicates whether the transaction was processed in training mode for new cashier onboarding. Training transactions are excluded from financial reporting.',
    `transaction_number` STRING COMMENT 'Business-readable transaction number printed on the customer receipt. Externally visible identifier for customer service and returns processing.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the POS transaction indicating whether it was completed, voided, suspended for later completion, or refunded.. Valid values are `completed|voided|suspended|refunded|partially_refunded`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was completed at the register. Primary business event timestamp for sales analytics and footfall analysis.',
    `transaction_type` STRING COMMENT 'Type of POS transaction distinguishing between sales, returns, exchanges, voids, and no-sale register opens.. Valid values are `sale|return|exchange|void|no_sale`',
    `void_reason_code` STRING COMMENT 'Standardized code indicating the reason for voiding the transaction when transaction_status is voided. Used for fraud detection and operational quality monitoring.',
    CONSTRAINT pk_pos_transaction PRIMARY KEY(`pos_transaction_id`)
) COMMENT 'Point-of-Sale transaction record for in-store purchase events at registers. Captures POS terminal ID, register number, cashier/associate ID, store number, transaction date/time, transaction type (sale, return, exchange, void), total tender, tax, discount, loyalty card number, basket metrics (item count, UPT, ATV), and fiscal receipt number. SSOT for brick-and-mortar register transactions. Complements order_header for transactions originating at physical registers rather than digital order flow. Payment tenders linked via the payment product.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`pos_transaction_line` (
    `pos_transaction_line_id` BIGINT COMMENT 'Unique identifier for the individual line item within a POS transaction. Primary key for the transaction line detail record.',
    `accrual_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.accrual_rule. Business justification: Each POS line item earns points under a specific accrual rule. Needed for store-level loyalty audit, cashier training validation, and points dispute resolution at POS. Retail store operations and loya',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_item. Business justification: In-store POS sales must be mapped to assortment items for real-time sell-through tracking against assortment plan targets. Retail merchandisers use daily POS-to-assortment data to make markdown timing',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: pos_transaction_line carries a denormalized category_code. Replacing with a proper FK to merchandising.category enables category-level sales reporting, margin analysis, and sell-through tracking — sta',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line-level cost center tracking enables department-specific performance measurement within store transactions, supports mixed-department basket analysis, and provides granular data for departmental P&',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: In-store gross margin reporting requires the exact cost record per POS transaction line. pos_transaction_line.cost_of_goods_sold is a scalar; the FK to cost_price enables full landed cost audit (duty,',
    `coupon_id` BIGINT COMMENT 'Foreign key linking to promotion.coupon. Business justification: Coupon redemption at POS line level: cashier scans coupon barcode applied to a specific line item. Required for coupon redemption tracking, fraud detection, single-use coupon enforcement, and vendor-f',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: POS department sales reporting: POS transaction lines carry a denormalized department_code; a proper FK to store.department enforces referential integrity and enables department-level sales, shrinkage',
    `item_bundle_id` BIGINT COMMENT 'Foreign key linking to product.item_bundle. Business justification: POS bundle sales (e.g., meal deals, multi-buy promotions) must reference the bundle definition to apply correct bundle pricing, validate component scan sequence, and report bundle attachment rates. Re',
    `markdown_event_id` BIGINT COMMENT 'Foreign key linking to merchandising.markdown_event. Business justification: POS lines sold at markdown prices must reference the authorizing markdown_event to enable actual vs. projected markdown impact reporting. Retail merchandising accountability requires reconciling markd',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: In-store markdown sell-through analysis — tracking units sold per markdown event at POS — is a standard retail buying report. Buyers need this to evaluate clearance markdown effectiveness across chann',
    `member_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.member_offer. Business justification: A POS line item may be sold under a personalized member offer (targeted discount or bonus points). Recording which member offer applied per line enables offer redemption tracking, personalization effe',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key reference to the parent POS transaction header. Links this line item to the overall transaction.',
    `price_change_id` BIGINT COMMENT 'Foreign key linking to pricing.price_change. Business justification: In-store price change effectiveness reporting requires linking POS transaction lines to the price change event that set the selling price. Retail pricing and buying teams measure units sold and margin',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Line-level profit center allocation supports accurate segment reporting for mixed-department transactions, enables product category profitability analysis, and is required for financial consolidation ',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: POS line-item promo attribution: each scanned item can have a specific promo_offer applied, mirroring order_line.promo_offer_id. Required for vendor chargeback reconciliation, margin reporting by offe',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the master product record. Links to product information management system for detailed product attributes.',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: POS lines record actual selling prices at point of sale. Linking to sku_price enables real-time price verification, override detection, shrinkage analysis from pricing discrepancies, and margin tracki',
    `stock_ledger_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_ledger. Business justification: Each POS line item generates a stock ledger transaction recording the inventory movement at SKU level. Required for item-level inventory accounting, variance analysis, and reconciling physical sales t',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the supplier or vendor who provided this product. Used for vendor performance analysis and chargebacks.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: POS transaction lines need vendor_item reference for DSD reconciliation, private label tracking, vendor-level sales reporting, and cost-of-goods reconciliation. Retail analytics and vendor scorecardin',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Unit cost of the product at the time of sale. Used for gross margin calculation and profitability analysis. Business confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction line record was first created in the system. Used for data lineage and audit trails.',
    `ean` STRING COMMENT '13-digit European Article Number for international product identification. Used for global product tracking and cross-border commerce.. Valid values are `^[0-9]{13}$`',
    `extended_price` DECIMAL(18,2) COMMENT 'Total price for this line item calculated as quantity multiplied by unit price before discounts. Gross line amount before markdown.',
    `fulfillment_type` STRING COMMENT 'Method by which this line item was fulfilled. Supports omnichannel order orchestration and fulfillment analytics.. Valid values are `in_store|bopis|ropis|ship_from_store|drop_ship`',
    `gtin` STRING COMMENT 'Global Trade Item Number that uniquely identifies trade items worldwide. Can be 8, 12, 13, or 14 digits depending on product type.. Valid values are `^[0-9]{8,14}$`',
    `item_description` STRING COMMENT 'Human-readable description of the product as it appears on the receipt. Includes brand, product name, size, and variant details.',
    `line_number` STRING COMMENT 'Sequential line number within the transaction. Determines the order in which items were scanned or entered at the point of sale.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned for this line item purchase. Used for customer loyalty program management and engagement.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed to discount this line item. Reduces the net amount paid by the customer.',
    `markdown_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to this line item. Includes promotional discounts, coupons, and price reductions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction line record was last modified. Used for change tracking and data quality monitoring.',
    `net_line_amount` DECIMAL(18,2) COMMENT 'Net amount for this line item after markdown but before tax. Calculated as extended price minus markdown amount.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this product is a store brand or private label item. True for private label, false for national brands.',
    `quantity_sold` DECIMAL(18,2) COMMENT 'Number of units sold for this line item. Supports fractional quantities for variable-weight items such as produce and deli products.',
    `return_flag` BOOLEAN COMMENT 'Indicates whether this line item represents a product return. True for returned items, false for normal sales.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for product return. Used for return analytics and quality management.. Valid values are `defective|wrong_item|changed_mind|damaged|expired|other`',
    `scanned_timestamp` TIMESTAMP COMMENT 'Date and time when this item was scanned or entered at the point of sale. Used for transaction timing analysis and basket sequence.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized products such as electronics and appliances. Used for warranty tracking and theft prevention.. Valid values are `^[A-Z0-9]{8,30}$`',
    `sku` STRING COMMENT 'Internal stock keeping unit identifier for the product sold. Used for inventory tracking and assortment management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax charged for this line item. Calculated by applying the tax rate to the net line amount.',
    `tax_code` STRING COMMENT 'Tax jurisdiction and category code for this line item. Determines applicable sales tax rate based on product category and location.. Valid values are `^[A-Z0-9]{1,10}$`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Sales tax rate applied to this line item expressed as a decimal. Example: 0.0825 represents 8.25 percent sales tax.',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Final total amount for this line item including tax. Sum of net line amount and tax amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity sold. Indicates whether the item is sold by each, weight, or bulk packaging. [ENUM-REF-CANDIDATE: each|lb|kg|oz|g|case|pack|box — 8 candidates stripped; promote to reference product]',
    `unit_retail_price` DECIMAL(18,2) COMMENT 'Regular retail price per unit before any discounts or promotions. Represents the shelf price or list price of the item.',
    `upc` STRING COMMENT '12-digit Universal Product Code scanned at point of sale. Standard barcode identifier for North American retail products.. Valid values are `^[0-9]{12}$`',
    `void_reason_code` STRING COMMENT 'Standardized code indicating the reason for voiding this line item. Used for shrinkage analysis and operational improvement.. Valid values are `scan_error|price_error|customer_request|damaged|other`',
    `voided_flag` BOOLEAN COMMENT 'Indicates whether this line item was voided or cancelled during the transaction. True for voided items, false for completed sales.',
    `weight_actual` DECIMAL(18,2) COMMENT 'Actual weight of variable-weight items measured at point of sale. Captured for produce, deli, meat, and bakery items sold by weight.',
    `weight_unit` STRING COMMENT 'Unit of measure for the actual weight. Indicates whether weight is measured in pounds, kilograms, ounces, or grams.. Valid values are `lb|kg|oz|g`',
    CONSTRAINT pk_pos_transaction_line PRIMARY KEY(`pos_transaction_line_id`)
) COMMENT 'Individual line-item detail within a POS transaction. Captures SKU, UPC, EAN, GTIN, item description, quantity sold, unit retail price, extended price, markdown amount, promotion code applied, tax code, tax amount, return reason (if applicable), serial number (for electronics), and weight (for variable-weight items). Supports basket analysis and sell-through rate calculations.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment tender record. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Cash application process: retail finance teams match customer payments to AR invoices to clear open items, manage aging reports, and reconcile accounts receivable. A retail AR analyst expects payment ',
    `checkout_id` BIGINT COMMENT 'Foreign key linking to ecommerce.checkout. Business justification: Payment fraud audit and checkout-to-payment reconciliation require tracing each OMS payment record back to the digital checkout session that initiated it. Finance and fraud teams use this link daily. ',
    `gift_card_id` BIGINT COMMENT 'Masked or tokenized gift card number used for this payment tender. Applicable only when payment method type is gift card.',
    `header_id` BIGINT COMMENT 'Reference to the order or POS (Point of Sale) transaction to which this payment tender is applied. Links payment to the originating order header.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to customer.payment_method. Business justification: Tokenized payment reconciliation and chargeback management require linking each payment transaction to the customers stored payment method on file. Retail fraud detection and PCI compliance reporting',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: A payment tender can be applied directly to a POS transaction (in-store purchase). While online order payments link via header_id, pure in-store POS payments need a direct FK to pos_transaction. This ',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: Payments made via pay with points (loyalty redemption as tender) must link to the specific redemption event. Enables payment reconciliation reports, fraud detection for points-as-payment, and loyalt',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Retail e-commerce uses ship-to-capture payment models where final payment capture is triggered by shipment confirmation. Linking payment to shipment enables automated capture workflows, financial audi',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to order.subscription. Business justification: Recurring subscription payments generate individual payment records for each billing cycle. Without a subscription_id FK on payment, there is no way to associate a specific payment transaction with th',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount applied by this payment tender toward the order total. In split-tender scenarios, multiple payment records sum to the order total.',
    `authorization_code` STRING COMMENT 'Authorization code returned by the payment processor or issuing bank confirming approval of the payment transaction. Used for reconciliation and dispute resolution.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was authorized by the payment processor or issuing bank. Represents the principal business event timestamp for this payment tender.',
    `avs_result_code` STRING COMMENT 'Result code returned by Address Verification Service (AVS) indicating match status of billing address and postal code. Used for fraud prevention and risk assessment.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the payment method. Used for AVS (Address Verification Service) and fraud prevention.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (apartment, suite, unit number). Optional field for AVS (Address Verification Service).',
    `billing_city` STRING COMMENT 'City of the billing address associated with the payment method. Used for AVS (Address Verification Service) and fraud prevention.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the billing address (e.g., USA, CAN, GBR). Used for AVS (Address Verification Service) and international payment processing.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address. Critical for AVS (Address Verification Service) validation and fraud prevention.',
    `billing_state_province` STRING COMMENT 'State or province of the billing address. Used for AVS (Address Verification Service) and tax calculation.',
    `bnpl_provider` STRING COMMENT 'Name of the Buy Now Pay Later (BNPL) service provider (e.g., Affirm, Klarna, Afterpay). Applicable only when payment method type is BNPL.',
    `capture_timestamp` TIMESTAMP COMMENT 'Date and time when the authorized payment was captured (funds marked for settlement). Typically occurs at order fulfillment or shipment.',
    `card_brand` STRING COMMENT 'Brand or network of the payment card used (e.g., Visa, Mastercard, American Express, Discover). Applicable only when payment method type is credit or debit card. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners_club|unionpay — 7 candidates stripped; promote to reference product]',
    `card_expiry_month` STRING COMMENT 'Expiration month of the payment card (1-12). Used for validation and recurring payment processing. Stored securely per PCI DSS requirements.',
    `card_expiry_year` STRING COMMENT 'Expiration year of the payment card (four-digit format, e.g., 2025). Used for validation and recurring payment processing. Stored securely per PCI DSS requirements.',
    `cardholder_name` STRING COMMENT 'Name of the cardholder as it appears on the payment card. Used for verification and fraud prevention. Stored securely per PCI DSS and GDPR requirements.',
    `channel` STRING COMMENT 'Channel or interface through which the payment was initiated. Distinguishes web, mobile app, in-store POS (Point of Sale), call center, kiosk, or third-party platform.. Valid values are `web|mobile_app|in_store_pos|call_center|kiosk|third_party`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment tender record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP, CAD). Supports multi-currency transactions.. Valid values are `^[A-Z]{3}$`',
    `cvv_result_code` STRING COMMENT 'Result code indicating whether the Card Verification Value (CVV/CVV2/CVC) provided by the cardholder matched the issuers records. Used for fraud prevention.',
    `digital_wallet_type` STRING COMMENT 'Type of digital wallet used for this payment tender (e.g., Apple Pay, Google Pay, Samsung Pay, PayPal, Venmo). Applicable only when payment method type is digital wallet.. Valid values are `apple_pay|google_pay|samsung_pay|paypal|venmo|other`',
    `fraud_decision` STRING COMMENT 'Decision outcome from fraud detection system. Indicates whether the payment was approved, declined, flagged for manual review, or challenged with additional authentication.. Valid values are `approved|declined|review|challenge`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical fraud risk score assigned by fraud detection system, typically ranging from 0 (low risk) to 100 (high risk). Used for payment approval decisions and risk management.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed as payment for this tender. Applicable only when payment method type is loyalty points.',
    `masked_pan` STRING COMMENT 'Masked or truncated version of the payment card Primary Account Number (PAN), typically showing only the last four digits (e.g., ****1234). Used for display and customer service without exposing full card number.',
    `method_type` STRING COMMENT 'Type of payment instrument used for this tender. Includes credit card, debit card, gift card, loyalty points, BNPL (Buy Now Pay Later), cash, digital wallet (e.g., Apple Pay, Google Pay), or check. [ENUM-REF-CANDIDATE: credit_card|debit_card|gift_card|loyalty_points|bnpl|cash|digital_wallet|check — 8 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment tender. Tracks progression from authorization through settlement, including declined, voided, or refunded states.. Valid values are `authorized|captured|settled|declined|voided|refunded`',
    `processor_reference_code` STRING COMMENT 'Unique transaction identifier assigned by the payment gateway or processor. Used for tracing and reconciliation with external payment systems.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the customer for this payment tender. May be partial or full refund of the original payment amount.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when a refund was processed for this payment tender. Applicable for returns and RMA (Return Merchandise Authorization) scenarios.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was settled and funds were transferred from the customers account to the merchants account. Final step in payment lifecycle.',
    `tender_sequence` STRING COMMENT 'Sequence number indicating the order in which this payment tender was applied in a split-tender scenario. First tender is 1, second is 2, etc.',
    `three_ds_authentication_result` STRING COMMENT 'Result of 3-D Secure (3DS) authentication protocol for card-not-present transactions. Indicates whether cardholder was successfully authenticated, reducing fraud liability.. Valid values are `authenticated|not_authenticated|attempted|unavailable|error`',
    `three_ds_version` STRING COMMENT 'Version of the 3-D Secure protocol used for authentication (e.g., 1.0.2, 2.1.0, 2.2.0). Newer versions provide enhanced security and user experience.',
    `token` STRING COMMENT 'Tokenized reference to the payment instrument, replacing sensitive card data. Token is generated by PCI DSS compliant tokenization service and used for recurring payments or stored payment methods.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment tender record was last modified. Used for audit trail and change tracking.',
    `void_timestamp` TIMESTAMP COMMENT 'Date and time when the payment authorization was voided (cancelled before capture). Applicable when order is cancelled before fulfillment.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Payment tender record capturing each payment instrument applied to an order or POS transaction. Stores payment method type (credit card, debit, gift card, loyalty points, BNPL, cash, digital wallet), masked PAN/token, payment processor reference, authorization code, settlement status (authorized, captured, settled, declined, voided), payment amount, currency, tender sequence for split-tender scenarios, PCI DSS tokenization reference, fraud score, and 3DS authentication result. Supports split-tender where multiple payment methods cover a single order total. Integrates with PCI SSC compliance requirements and payment gateway APIs.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`discount` (
    `discount_id` BIGINT COMMENT 'Primary key for discount',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Discount postings must reference specific GL accounts for financial reporting, promotional expense tracking, markdown accounting, and audit trails. Required for accurate revenue recognition, promotion',
    `header_id` BIGINT COMMENT 'Reference to the order to which this discount is applied. Links to the order header.',
    `location_id` BIGINT COMMENT 'Reference to the physical store location where the discount was applied. Null for online or non-store channels.',
    `loyalty_membership_id` BIGINT COMMENT 'Reference to the loyalty program member who redeemed points or received a loyalty-based discount. Null if discount is not loyalty-based.',
    `markdown_event_id` BIGINT COMMENT 'Foreign key linking to merchandising.markdown_event. Business justification: Discounts originating from a markdown event must be traceable to that event for markdown accountability reporting. Retail finance and merchandising teams reconcile markdown-driven discount amounts aga',
    `order_line_id` BIGINT COMMENT 'Reference to the specific order line item to which this discount is applied. Null if discount is applied at order header level.',
    `pos_terminal_id` BIGINT COMMENT 'The identifier of the Point of Sale (POS) terminal or register where the discount was applied. Null for online channels.',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: Discounts and promotions are applied at POS transactions in-store, analogous to how discount.header_id links to online order headers. A discount applied at the transaction level (e.g., a store-wide pr',
    `pos_transaction_line_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction_line. Business justification: Line-level discounts at POS (e.g., markdown on a specific scanned item, BOGO applied to a specific line) need a FK to pos_transaction_line, mirroring the existing discount.order_line_id for online ord',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the marketing or promotional campaign that generated this discount. Links to the promotion campaign master data for attribution and performance analysis.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Discount records are linked to promo_campaign but not to the specific promo_offer that triggered them. Vendor-funded offer chargeback reconciliation and offer-level discount performance reporting requ',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: A discount applied to an order may be funded by a loyalty redemption (points-for-discount reward). Linking discount to the specific redemption enables loyalty liability reconciliation, discount audit ',
    `rule_id` BIGINT COMMENT 'Foreign key linking to pricing.rule. Business justification: Pricing rule effectiveness reporting requires linking discount records to the pricing rule that triggered them. Retail pricing teams audit rule-driven discount spend, measure rule ROI, and validate th',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Vendor-funded markdowns and cooperative advertising allowances are governed by vendor contracts. Linking discount to vendor_contract enables vendor deduction accounting, co-op fund reconciliation, and',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the discount applied, in the order currency. Represents the total reduction in price due to this discount.',
    `applied_at_level` STRING COMMENT 'Indicates whether the discount was applied at the order header level (affecting the entire order) or at the line item level (affecting a specific product).. Valid values are `header|line`',
    `applied_timestamp` TIMESTAMP COMMENT 'The date and time when the discount was applied to the order or line item. Represents the business event time of discount application.',
    `approval_status` STRING COMMENT 'The approval status of the discount application. Indicates whether the discount was automatically applied, requires manager approval, has been approved, or was rejected.. Valid values are `approved|pending|rejected|auto_applied`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the discount was approved. Null if auto-applied or pending approval.',
    `channel` STRING COMMENT 'The sales channel through which the discount was applied. Indicates whether the discount was applied via online e-commerce, in-store Point of Sale (POS), mobile app, call center, or kiosk.. Valid values are `online|in_store|mobile_app|call_center|kiosk`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this discount record was first created in the data platform. Audit field for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount. Typically matches the order currency.. Valid values are `^[A-Z]{3}$`',
    `discount_code` STRING COMMENT 'The promotional code, coupon code, or discount identifier entered or applied by the customer or system. Examples include promo codes, loyalty reward codes, employee discount codes.',
    `discount_method` STRING COMMENT 'The calculation method used to determine the discount value. Indicates whether the discount is a percentage off, fixed dollar amount, tiered based on quantity or spend, Buy One Get One (BOGO) offer, or free shipping.. Valid values are `percentage|fixed_amount|tiered|bogo|free_shipping`',
    `discount_type` STRING COMMENT 'Classification of the discount mechanism. Indicates the nature of the discount applied (e.g., coupon, promotional code, loyalty reward, markdown, Buy One Get One (BOGO), clearance, employee discount, volume discount, seasonal promotion, bundle discount, price override, manager override). [ENUM-REF-CANDIDATE: coupon|promo_code|loyalty_reward|markdown|bogo|clearance|employee_discount|volume_discount|seasonal_promotion|bundle_discount|price_override|manager_override — 12 candidates stripped; promote to reference product]',
    `final_price` DECIMAL(18,2) COMMENT 'The final price after the discount has been applied. Represents the net amount the customer pays for the discounted item or order.',
    `loyalty_points_redeemed` STRING COMMENT 'The number of loyalty program points redeemed to obtain this discount. Null if discount is not loyalty-based.',
    `original_price` DECIMAL(18,2) COMMENT 'The original price of the item or order before the discount was applied. Used to calculate discount impact and markdown analysis.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the order or line item. Populated when discount_method is percentage. Expressed as a decimal (e.g., 15.00 for 15% off).',
    `priority_rank` STRING COMMENT 'The priority order in which this discount is applied when multiple discounts are present. Lower numbers indicate higher priority. Used to determine discount application sequence.',
    `reason_code` STRING COMMENT 'A code indicating the business reason for the discount. Examples include customer complaint resolution, price match, damaged goods, loyalty reward, seasonal clearance, or promotional campaign.',
    `reason_description` STRING COMMENT 'Free-text description providing additional context or justification for the discount application. Used for audit trail and customer service reference.',
    `source_system` STRING COMMENT 'The name or identifier of the source system that originated this discount record. Examples include Oracle Retail Price Management (RPM), Salesforce Commerce Cloud, SAP Customer Activity Repository (CAR), or Point of Sale (POS) system.',
    `source_system_discount_code` STRING COMMENT 'The unique identifier for this discount record in the source system. Used for traceability and reconciliation with upstream systems.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this discount can be combined (stacked) with other discounts on the same order or line item. True if stackable, False if exclusive.',
    `tax_treatment_flag` STRING COMMENT 'Indicates whether the discount is applied before tax calculation (pre-tax) or after tax calculation (post-tax). Affects the taxable amount and final tax computation.. Valid values are `pre_tax|post_tax`',
    `taxable_amount_adjustment` DECIMAL(18,2) COMMENT 'The adjustment to the taxable base amount resulting from this discount. Used to recalculate sales tax when discount affects the tax basis.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this discount record was last modified in the data platform. Audit field for change tracking and data quality monitoring.',
    `valid_from_date` DATE COMMENT 'The start date from which the discount code or promotion is valid. Used to enforce discount eligibility windows.',
    `valid_to_date` DATE COMMENT 'The end date until which the discount code or promotion is valid. Used to enforce discount eligibility windows. Null for open-ended discounts.',
    CONSTRAINT pk_discount PRIMARY KEY(`discount_id`)
) COMMENT 'Discount and promotion application record at the order header or line level. Captures discount type (coupon, promo code, loyalty reward, markdown, BOGO, clearance, employee discount), discount code, discount amount or percentage, promotion campaign reference, stackability flag, applied-at level (header vs line), and approval status. Enables promotion attribution, markdown tracking, sell-through analysis, and P&L impact per order. Tax calculation attributes (taxable amount adjustment) included where discount affects tax basis.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`cancellation` (
    `cancellation_id` BIGINT COMMENT 'Unique identifier for the cancellation event. Primary key for the cancellation record.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Invoice reversal process: when an invoiced order is cancelled, finance must reverse or credit-memo the AR invoice. Linking cancellation to ar_invoice enables automated credit memo generation, refund r',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: When an order is cancelled, the associated fulfillment_order must be halted and inventory released. Cancellation records must reference fulfillment_order to trigger WMS stop-pick/stop-pack workflows a',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cancellation accounting (restocking fees, cancellation charges, refund processing) requires GL account assignment for proper revenue/expense recognition, financial reporting, and audit compliance. Sta',
    `header_id` BIGINT COMMENT 'Reference to the parent order that was cancelled. Links this cancellation to the originating order header.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Store-level cancellation tracking: BOPIS and in-store order cancellations must be attributed to the store location for store-level cancellation rate KPIs, inventory release reconciliation, and custome',
    `order_line_id` BIGINT COMMENT 'Reference to the specific order line item that was cancelled. Null if the entire order was cancelled rather than individual lines.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to customer.payment_method. Business justification: Refund-to-original-tender processing requires linking cancellations to the specific customer payment method for automated refund routing. Retail return management and PCI-compliant refund workflows de',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: In-store transaction voids and returns are cancellation events that apply to a POS transaction. The cancellation table currently links to header_id and order_line_id for online orders, but lacks a FK ',
    `pos_transaction_line_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction_line. Business justification: Line-level returns at POS (customer returning a specific item from a prior transaction) require a FK to pos_transaction_line, mirroring the existing cancellation.order_line_id for online order line ca',
    `profile_id` BIGINT COMMENT 'Reference to the customer associated with the cancelled order. Links cancellation to the customer master record for analytics and customer service.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: When an order is cancelled, any loyalty redemption applied (points-for-discount) must be reversed. The cancellation record must reference the specific redemption to trigger the reversal workflow and e',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Post-shipment cancellations generate RMAs for already-shipped items. Linking cancellation to rma enables post-shipment cancellation workflows, refund reconciliation, and inventory recovery tracking. R',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: If a shipment is already in transit at cancellation time, the cancellation must reference the shipment to initiate carrier recall or return-to-sender. Retail reverse logistics, carrier void processing',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the cancellation requires managerial or supervisory approval before execution. True for high-value orders or policy exceptions.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation was approved by an authorized agent or manager. Null if no approval required or not yet approved.',
    `cancellation_number` STRING COMMENT 'Business-facing unique cancellation reference number used for customer communication and tracking. Format: CXL-XXXXXXXXXX.. Valid values are `^CXL-[0-9]{10}$`',
    `cancellation_status` STRING COMMENT 'Current processing status of the cancellation request. Tracks the cancellation through its approval and execution workflow.. Valid values are `pending|approved|rejected|completed|reversed`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation was initiated or requested. Represents the business event time of the cancellation action.',
    `cancelled_amount` DECIMAL(18,2) COMMENT 'Total order or line value that was cancelled, including product cost, taxes, and fees. Represents the gross cancelled transaction value.',
    `cancelled_quantity` DECIMAL(18,2) COMMENT 'Quantity of the product or item that was cancelled. Relevant for line-level cancellations. Measured in the unit of measure of the ordered item.',
    `channel` STRING COMMENT 'Channel or interface through which the cancellation was submitted. Tracks omnichannel cancellation touchpoints. [ENUM-REF-CANDIDATE: web|mobile_app|call_center|store|email|chat|system_automated — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a cancellation confirmation notification was sent to the customer via email, SMS, or app notification. True if notification sent.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation confirmation notification was sent to the customer. Null if notification not sent or failed.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Administrative or processing fee charged for the cancellation. Zero if no cancellation fee applies per business policy or customer segment.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the cancellation was triggered by fraud detection rules or suspected fraudulent activity. True if fraud-related cancellation.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the fraud detection system at the time of cancellation. Higher scores indicate higher fraud risk. Null if not fraud-related.',
    `initiator_type` STRING COMMENT 'Category of entity that initiated the cancellation. Distinguishes between customer-initiated, system-initiated, agent-initiated, and automated rule-based cancellations.. Valid values are `customer|system|agent|fraud_detection|inventory_allocation_failure|payment_failure`',
    `inventory_release_timestamp` TIMESTAMP COMMENT 'Date and time when allocated inventory was released back to available stock following the cancellation. Null if inventory was never allocated or not yet released.',
    `inventory_released_flag` BOOLEAN COMMENT 'Indicates whether inventory allocated to the cancelled order or line has been released back to available stock. True if inventory release confirmed.',
    `processing_system_code` STRING COMMENT 'Identifier of the system or automated process that executed the cancellation. Used for system-initiated cancellations to track which rule engine or service triggered the action.',
    `reason_code` STRING COMMENT 'Standardized code representing the reason for cancellation. [ENUM-REF-CANDIDATE: customer_request|out_of_stock|pricing_error|duplicate_order|payment_declined|fraud_suspected|delivery_delay|product_unavailable|customer_changed_mind|incorrect_item_ordered|found_better_price|shipping_cost_too_high|delivery_time_too_long|order_placed_by_mistake|item_no_longer_needed|quality_concerns|other — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text description or additional details provided by the initiator explaining the reason for cancellation. Captures customer comments or agent notes.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total monetary amount to be refunded to the customer for this cancellation. Includes product cost, taxes, and fees as applicable.',
    `refund_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount. Indicates the currency in which the refund will be processed.. Valid values are `^[A-Z]{3}$`',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether the cancelled order or line is eligible for a refund based on payment status and business rules. True if refund should be processed.',
    `refund_method` STRING COMMENT 'Method by which the refund will be issued to the customer. Typically matches the original payment method but may differ based on business rules.. Valid values are `original_payment_method|store_credit|gift_card|manual_check|bank_transfer`',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was successfully processed and submitted to the payment gateway or finance system. Null if refund not yet processed.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for cancelling the order after certain fulfillment stages. Zero if no restocking fee applies per business policy.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this cancellation was subsequently reversed and the order reinstated. True if the cancellation was undone.',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why the cancellation was reversed. Captures business justification for reinstating the order.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation was reversed and the order reinstated. Null if no reversal occurred.',
    `source_system` STRING COMMENT 'Name or identifier of the source system that originated the cancellation record. Used for data lineage and integration tracking across OMS, e-commerce, and POS systems.',
    `stage` STRING COMMENT 'Order fulfillment stage at which the cancellation occurred. Indicates how far the order progressed before cancellation and impacts inventory release and refund processing.. Valid values are `pre_allocation|post_allocation_pre_pick|post_pick_pre_ship|post_ship`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was last modified. Audit field for tracking changes to cancellation status, refund processing, or other attributes.',
    CONSTRAINT pk_cancellation PRIMARY KEY(`cancellation_id`)
) COMMENT 'Order or line-level cancellation event record capturing the full context of why and when an order or individual line was cancelled before shipment. Captures cancellation number, order/line reference, cancellation initiator (customer-initiated via web/app/call-center, system-initiated via OMS rules, fraud-hold auto-cancel, inventory allocation failure), cancellation reason code, cancellation timestamp, cancellation stage (pre-allocation, post-allocation-pre-pick, post-pick-pre-ship), refund eligibility flag, inventory release confirmation, and processing agent/system ID. Distinct from RMA which covers post-shipment returns.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`gift_card` (
    `gift_card_id` BIGINT COMMENT 'Unique identifier for the gift card record. Primary key.',
    `header_id` BIGINT COMMENT 'Identifier of the order transaction in which this gift card was purchased. Links gift card to originating sales transaction. Nullable for cards issued outside normal order flow (e.g., corporate bulk issuance).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Gift card liability tracking requires specific GL account for deferred revenue, breakage recognition, balance sheet reporting, and ASC 606 compliance. Role-prefixed because gift cards have multiple GL',
    `location_id` BIGINT COMMENT 'Identifier of the physical store location where the gift card was issued or sold. Nullable for non-store channels.',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: Gift cards are frequently purchased and activated at POS terminals in-store. The gift_card table currently has header_id for online gift card purchases but lacks a FK to pos_transaction for in-store a',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who purchased the gift card. May differ from the recipient. Nullable if purchased anonymously or by guest.',
    `primary_replacement_for_card_gift_card_id` BIGINT COMMENT 'Identifier of the original gift card that this card replaces (e.g., lost or damaged card replacement). Nullable for original issuances. Balance is typically transferred from original card.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: Gift cards in retail are frequently issued under a specific loyalty program (co-branded cards, program-exclusive gift cards). Linking gift_card to loyalty_program enables program-level liability repor',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the promotional campaign associated with this gift card issuance (e.g., holiday bonus card, purchase-with-purchase offer). Nullable for non-promotional cards.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Physical gift cards require shipment tracking. Linking gift_card to its delivery shipment enables customer service to resolve where is my gift card? inquiries, supports lost-card replacement workflo',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Gift cards sold or redeemed through digital channels require storefront attribution for revenue recognition, liability tracking by channel, and fraud prevention. Retailers must track which digital sto',
    `activation_date` DATE COMMENT 'Date when the gift card was activated and became available for redemption. May differ from issue date if activation is delayed (e.g., physical cards activated at first use).',
    `barcode` STRING COMMENT 'Barcode value encoded on physical gift cards for scanning at Point of Sale (POS). May be UPC (Universal Product Code), EAN (European Article Number), or proprietary format.',
    `card_number` STRING COMMENT 'Unique card number printed or encoded on the gift card. Typically 16-19 digits. Used for identification and redemption at Point of Sale (POS) or e-commerce checkout.. Valid values are `^[0-9]{16,19}$`',
    `card_status` STRING COMMENT 'Current lifecycle status of the gift card. Inactive: issued but not yet activated; Active: available for use; Suspended: temporarily blocked; Expired: past validity period; Depleted: balance fully redeemed; Cancelled: voided or returned.. Valid values are `inactive|active|suspended|expired|depleted|cancelled`',
    `card_type` STRING COMMENT 'Type of gift card instrument. Physical cards are tangible plastic cards; digital/virtual cards are delivered electronically via email or app; mobile wallet cards are provisioned into digital wallets (Apple Pay, Google Pay).. Valid values are `physical|digital|virtual|mobile_wallet`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift card record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the denomination of the gift card balance (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Remaining monetary value available on the gift card after all redemptions, adjustments, and fees. Updated in real-time with each transaction.',
    `escheatment_date` DATE COMMENT 'Date when the gift card balance was escheated (transferred) to state unclaimed property authority. Nullable if not yet escheated.',
    `escheatment_eligible_flag` BOOLEAN COMMENT 'Indicates whether the gift card balance is eligible for escheatment (transfer to state unclaimed property) based on dormancy period and state regulations. True: eligible; False: not eligible.',
    `expiry_date` DATE COMMENT 'Date when the gift card expires and can no longer be redeemed. Nullable for cards with no expiration. Subject to regulatory requirements (e.g., CARD Act in USA mandates minimum 5-year validity).',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this gift card has been flagged for suspected fraudulent activity (e.g., unauthorized use, balance tampering, stolen card). True: fraud suspected; False: no fraud detected.',
    `fraud_reason_code` STRING COMMENT 'Code indicating the reason for fraud flag (e.g., STOLEN, COUNTERFEIT, BALANCE_TAMPERING, SUSPICIOUS_ACTIVITY). Nullable if fraud_flag is false.',
    `initial_balance` DECIMAL(18,2) COMMENT 'Original monetary value loaded onto the gift card at the time of issuance or purchase. Represents the starting balance before any redemptions or adjustments.',
    `issue_date` DATE COMMENT 'Date when the gift card was originally issued or sold to the customer. Marks the beginning of the card lifecycle.',
    `issuing_channel` STRING COMMENT 'Sales channel through which the gift card was originally issued or purchased. Store: in-store POS; Ecommerce: online storefront; Mobile App: mobile commerce; Call Center: phone order; Corporate Sales: bulk B2B sales; Third Party: external marketplace or partner.. Valid values are `store|ecommerce|mobile_app|call_center|corporate_sales|third_party`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift card record was last updated. Tracks data currency and supports change data capture (CDC) processes.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction (redemption, reload, or adjustment) on this gift card. Used for dormancy tracking and escheatment compliance.',
    `pin_code` STRING COMMENT 'Personal Identification Number (PIN) required for online redemption or balance inquiry. Typically 4-8 digits. Stored encrypted in production systems.. Valid values are `^[0-9]{4,8}$`',
    `qr_code` STRING COMMENT 'Quick Response (QR) code data for mobile wallet provisioning or contactless redemption. Encoded with card number and validation data.',
    `recipient_email` STRING COMMENT 'Email address of the gift card recipient. Used for digital card delivery and balance notifications. Required for digital/virtual cards.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'Phone number of the gift card recipient. Used for SMS delivery of digital cards and balance inquiries.. Valid values are `^+?[0-9]{10,15}$`',
    `redemption_count` STRING COMMENT 'Total number of redemption transactions (purchases) made using this gift card since activation.',
    `reload_count` STRING COMMENT 'Total number of times the gift card has been reloaded with additional funds since issuance. Zero for non-reloadable or never-reloaded cards.',
    `reloadable_flag` BOOLEAN COMMENT 'Indicates whether the gift card can be reloaded with additional funds after initial issuance. True: reloadable; False: single-load only.',
    `terms_and_conditions_version` STRING COMMENT 'Version identifier of the terms and conditions that govern this gift card (e.g., expiration policy, fee schedule, usage restrictions). Used for compliance and customer service.',
    `total_fees_charged` DECIMAL(18,2) COMMENT 'Cumulative fees deducted from the gift card balance (e.g., dormancy fees, maintenance fees, replacement fees). Subject to regulatory restrictions (e.g., CARD Act limits dormancy fees).',
    `total_redeemed_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value redeemed from the gift card across all transactions since activation. Equals initial_balance + total_reloaded_amount - current_balance - total_fees.',
    `total_reloaded_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value added to the gift card through all reload transactions since issuance. Excludes initial balance.',
    CONSTRAINT pk_gift_card PRIMARY KEY(`gift_card_id`)
) COMMENT 'Master record for gift cards and stored-value instruments sold and redeemed across all channels. Captures card number, card type (physical, digital), initial balance, current balance, activation date, expiry date, and issuing channel.';

CREATE OR REPLACE TABLE `retail_ecm`.`order`.`subscription` (
    `subscription_id` BIGINT COMMENT 'Unique identifier for the subscription record. Primary key for the subscription entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: B2B subscription billing aggregation, account-level credit limit enforcement, and corporate subscription management require linking subscriptions to customer accounts. Retail B2B operations (e.g., off',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: Recurring subscription deliveries require consistent carrier assignment for customer experience and SLA management. Business tracks preferred carrier at subscription level for cost optimization and de',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Subscription service level (ground vs. expedited) drives recurring delivery promises and cost structure. Business needs carrier_service_id to enforce consistent service tier across subscription lifecy',
    `digital_catalog_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_catalog. Business justification: Subscribe-and-save programs require knowing which digital catalog listing originated the subscription — for renewal page rendering, pricing display, and catalog-driven subscription analytics. subscrip',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the distribution center, store, or fulfillment location assigned to process subscription orders. Links to the fulfillment node master record.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Store-initiated subscription attribution: subscriptions signed up in-store or fulfilled from a specific store location must be attributed to that location for store-level subscription revenue reportin',
    `loyalty_membership_id` BIGINT COMMENT 'Reference to the customers loyalty program membership. Links to the loyalty member record for points accrual and rewards tracking.',
    `payment_method_id` BIGINT COMMENT 'Reference to the stored payment method used for recurring subscription charges. Links to the customer payment method record.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Subscriptions lock in pricing terms at enrollment. Linking to price_list enables subscription pricing governance, renewal price determination, grandfathered rate tracking, and price change impact anal',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this subscription. Links to the customer master record.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Subscribe-and-save programs tie recurring subscriptions to a specific promo_offer defining the discount rate. Required for subscription discount management, offer expiry impact analysis on active subs',
    `renewed_from_subscription_id` BIGINT COMMENT 'Self-referencing FK on subscription (renewed_from_subscription_id)',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Subscription revenue recognition requires GL account assignment for deferred revenue, recognized revenue, and ASC 606 compliance. Role-prefixed to distinguish from potential expense or liability GL ac',
    `address_id` BIGINT COMMENT 'Reference to the default delivery address for subscription orders. Links to the customer address record.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Retail auto-replenishment/Subscribe-and-Save subscriptions are fundamentally tied to a specific SKU. Without this FK, subscription management cannot validate SKU availability, apply SKU-level pricing,',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla. Business justification: Subscription orders carry contractual delivery SLA commitments tied to customer tier and delivery frequency. Linking subscription to its governing SLA enables SLA breach monitoring for recurring deliv',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Subscriptions sold through digital channels require storefront attribution for revenue recognition, channel performance analysis, and fraud monitoring. Retail subscription businesses track which digit',
    `amount` DECIMAL(18,2) COMMENT 'Base recurring charge amount for the subscription per billing cycle, excluding taxes, discounts, and shipping fees.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the subscription automatically renews at the end of its term. True for auto-renewing subscriptions, false for subscriptions that require manual renewal.',
    `billing_cycle` STRING COMMENT 'Frequency at which the customer is charged for the subscription: per_delivery for charges with each order, monthly for monthly billing regardless of delivery frequency, quarterly for every 3 months, annual for yearly billing, or upfront for prepaid subscriptions.. Valid values are `per_delivery|monthly|quarterly|annual|upfront`',
    `cancellation_date` DATE COMMENT 'Date when the subscription was cancelled by the customer or system. Null for active subscriptions.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating why the subscription was cancelled (e.g., CUST_REQUEST, PAYMENT_FAILURE, PRODUCT_UNAVAILABLE, FRAUD_DETECTED).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `cancellation_reason_description` STRING COMMENT 'Free-text explanation of the subscription cancellation reason, providing additional context beyond the standardized code.',
    `carrier_service_level` STRING COMMENT 'Shipping service tier for subscription deliveries: ground for economy shipping, express for expedited delivery, two_day for 2-day service, next_day for overnight, or standard for default carrier service.. Valid values are `ground|express|two_day|next_day|standard`',
    `channel` STRING COMMENT 'Channel through which the subscription was originally created: web for website, mobile_app for mobile application, call_center for phone orders, in_store for retail location sign-ups, chatbot for automated chat enrollment, or voice_assistant for smart speaker subscriptions.. Valid values are `web|mobile_app|call_center|in_store|chatbot|voice_assistant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscription record was first created in the system, capturing the initial enrollment date and time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this subscription record.. Valid values are `^[A-Z]{3}$`',
    `delivery_frequency` STRING COMMENT 'Cadence at which subscription orders are automatically generated and fulfilled: weekly for every 7 days, biweekly for every 14 days, monthly for every 30 days, quarterly for every 90 days, or custom for non-standard intervals.. Valid values are `weekly|biweekly|monthly|quarterly|custom`',
    `delivery_frequency_days` STRING COMMENT 'Numeric representation of the delivery interval in days. Used for custom frequencies and precise scheduling calculations.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Recurring discount applied to each subscription billing cycle, such as promotional discounts, loyalty rewards, or volume-based savings.',
    `end_date` DATE COMMENT 'Date when the subscription is scheduled to terminate. Null for open-ended subscriptions without a defined end date.',
    `external_subscription_code` STRING COMMENT 'Subscription identifier from the source system or external platform, used for cross-system reconciliation and integration.',
    `gift_message` STRING COMMENT 'Personalized message from the gift giver to the recipient, included with gift subscription deliveries.',
    `gift_subscription_flag` BOOLEAN COMMENT 'Indicates whether this subscription was purchased as a gift for another person. True for gift subscriptions, false for self-purchased subscriptions.',
    `last_delivery_date` DATE COMMENT 'Date when the most recent subscription order was delivered to the customer. Null if no deliveries have occurred yet.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this subscription record, tracking changes to subscription details, status, or preferences.',
    `next_delivery_date` DATE COMMENT 'Date when the next subscription order is scheduled to be fulfilled and shipped to the customer.',
    `pause_end_date` DATE COMMENT 'Date when a paused subscription is scheduled to resume. Null for indefinite pauses or active subscriptions.',
    `pause_start_date` DATE COMMENT 'Date when the subscription was paused. Null if the subscription has never been paused or is currently active.',
    `skip_next_delivery_flag` BOOLEAN COMMENT 'Indicates whether the customer has requested to skip the next scheduled delivery. True when the upcoming order should be skipped, false for normal delivery processing.',
    `source_system` STRING COMMENT 'Identifier of the operational system that created or manages this subscription record (e.g., SALESFORCE_COMMERCE, OMS, SUBSCRIPTION_ENGINE).. Valid values are `^[A-Z0-9_]{2,30}$`',
    `special_instructions` STRING COMMENT 'Customer-provided delivery instructions, preferences, or notes for subscription fulfillment (e.g., gate codes, preferred delivery times, substitution preferences).',
    `start_date` DATE COMMENT 'Date when the subscription became active and the first delivery or service period began.',
    `subscription_number` STRING COMMENT 'Human-readable business identifier for the subscription, used in customer communications and service interactions.. Valid values are `^SUB-[0-9]{10}$`',
    `subscription_status` STRING COMMENT 'Current lifecycle state of the subscription: active for ongoing subscriptions, paused for temporarily suspended deliveries, cancelled for terminated subscriptions, expired for subscriptions past their end date, pending_activation for new subscriptions awaiting first order, or suspended for subscriptions on hold due to payment or compliance issues.. Valid values are `active|paused|cancelled|expired|pending_activation|suspended`',
    `subscription_type` STRING COMMENT 'Classification of the subscription model: subscribe-and-save for recurring product delivery, auto-replenishment for inventory-triggered orders, meal kit for prepared meal subscriptions, curated box for personalized selections, membership for access-based subscriptions, or service plan for ongoing service contracts.. Valid values are `subscribe_and_save|auto_replenishment|meal_kit|curated_box|membership|service_plan`',
    `total_deliveries_completed` STRING COMMENT 'Cumulative count of subscription orders that have been successfully delivered to the customer since subscription inception.',
    `total_deliveries_skipped` STRING COMMENT 'Cumulative count of scheduled deliveries that were skipped at the customers request or due to system holds.',
    CONSTRAINT pk_subscription PRIMARY KEY(`subscription_id`)
) COMMENT 'Master record for recurring subscription orders (subscribe-and-save, auto-replenishment, meal kit subscriptions). Captures subscription ID, customer, SKU list, delivery frequency, next delivery date, payment method, and subscription status.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `retail_ecm`.`order`.`subscription`(`subscription_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_original_transaction_pos_transaction_id` FOREIGN KEY (`original_transaction_pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `retail_ecm`.`order`.`gift_card`(`gift_card_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `retail_ecm`.`order`.`subscription`(`subscription_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_pos_transaction_line_id` FOREIGN KEY (`pos_transaction_line_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction_line`(`pos_transaction_line_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_pos_transaction_line_id` FOREIGN KEY (`pos_transaction_line_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction_line`(`pos_transaction_line_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_primary_replacement_for_card_gift_card_id` FOREIGN KEY (`primary_replacement_for_card_gift_card_id`) REFERENCES `retail_ecm`.`order`.`gift_card`(`gift_card_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_renewed_from_subscription_id` FOREIGN KEY (`renewed_from_subscription_id`) REFERENCES `retail_ecm`.`order`.`subscription`(`subscription_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `retail_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `retail_ecm`.`order`.`header` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`header` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `outbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source Purchase Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|store_pos|call_center|marketplace|kiosk');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `customer_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Email Address');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `customer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `customer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `customer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `customer_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Phone Number');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `customer_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `customer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `grand_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Grand Total Amount');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `oms_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Reference ID');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 1');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 2');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Amount');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_city` SET TAGS ('dbx_business_glossary_term' = 'Shipping City');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Country Code');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Postal Code');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_business_glossary_term' = 'Shipping State or Province');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `retail_ecm`.`order`.`header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`order`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `buying_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Buying Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `digital_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Catalog Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilling Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `item_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Item Bundle Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `markdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `member_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `price_change_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'OUT_OF_STOCK|CUSTOMER_REQUEST|PRICING_ERROR|FRAUD|PAYMENT_FAILED|ADDRESS_INVALID');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `expected_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Ship Date');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `extended_price` SET TAGS ('dbx_business_glossary_term' = 'Extended Price');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'SHIP_TO_HOME|BOPIS|ROPIS|SFS|DROP_SHIP|IN_STORE_PICKUP');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `gift_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Flag');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Amount');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `original_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,14}$');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `personalization_notes` SET TAGS ('dbx_business_glossary_term' = 'Personalization Notes');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'DEFECTIVE|WRONG_ITEM|NOT_AS_DESCRIBED|NO_LONGER_NEEDED|SIZE_FIT|DAMAGED_IN_TRANSIT');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `total` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `unit_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Retail Price');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `retail_ecm`.`order`.`order_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `retail_ecm`.`order`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`status_history` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `assigned_to_team_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team Code');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `created_by_process` SET TAGS ('dbx_business_glossary_term' = 'Record Created By Process');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Channel');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_value_regex' = 'EMAIL|SMS|PUSH|IN_APP|NONE');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `duration_in_previous_status_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Previous Status in Minutes');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `exception_category` SET TAGS ('dbx_business_glossary_term' = 'Exception Category');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `fulfillment_node_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Type');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Notes');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `previous_status_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status Code');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `resolution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Resolution Required Flag');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `sla_breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Breach Duration in Minutes');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Breach Flag');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Target Timestamp');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `source_order_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Order Channel');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `source_system_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `status_code` SET TAGS ('dbx_business_glossary_term' = 'Order Status Code');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Description');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `triggering_system_code` SET TAGS ('dbx_business_glossary_term' = 'Triggering System Code');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `triggering_user_name` SET TAGS ('dbx_business_glossary_term' = 'Triggering User Name');
ALTER TABLE `retail_ecm`.`order`.`status_history` ALTER COLUMN `triggering_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` SET TAGS ('dbx_subdomain' = 'store_transactions');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Transaction ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `original_transaction_pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Terminal ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `change_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `coupon_count` SET TAGS ('dbx_business_glossary_term' = 'Coupon Count');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `fiscal_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Receipt Number');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'in_store_purchase|bopis_pickup|ropis_pickup|ship_from_store|curbside_pickup');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Number');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `manager_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Flag');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `payment_method_count` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Count');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `promotion_count` SET TAGS ('dbx_business_glossary_term' = 'Promotion Count');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `receipt_email` SET TAGS ('dbx_business_glossary_term' = 'Receipt Email Address');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `receipt_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `receipt_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `receipt_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `receipt_phone` SET TAGS ('dbx_business_glossary_term' = 'Receipt Phone Number');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `receipt_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `receipt_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register Number');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Tender Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `training_mode_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Mode Flag');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|voided|suspended|refunded|partially_refunded');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'sale|return|exchange|void|no_sale');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` SET TAGS ('dbx_subdomain' = 'store_transactions');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `pos_transaction_line_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction Line ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `item_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Item Bundle Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `markdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `member_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `price_change_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `stock_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `extended_price` SET TAGS ('dbx_business_glossary_term' = 'Extended Price');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'in_store|bopis|ropis|ship_from_store|drop_ship');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `net_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `quantity_sold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `return_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Flag');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defective|wrong_item|changed_mind|damaged|expired|other');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `scanned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scanned Timestamp');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `total_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `unit_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Retail Price');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_value_regex' = 'scan_error|price_error|customer_request|damaged|other');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `voided_flag` SET TAGS ('dbx_business_glossary_term' = 'Voided Flag');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `weight_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit');
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'lb|kg|oz|g');
ALTER TABLE `retail_ecm`.`order`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`payment` SET TAGS ('dbx_subdomain' = 'payment_discounts');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `checkout_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Number');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Tender Amount');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_business_glossary_term' = 'AVS (Address Verification Service) Result Code');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_business_glossary_term' = 'BNPL (Buy Now Pay Later) Provider');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capture Timestamp');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Brand');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_store_pos|call_center|kiosk|third_party');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_business_glossary_term' = 'CVV (Card Verification Value) Result Code');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `digital_wallet_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Type');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `digital_wallet_type` SET TAGS ('dbx_value_regex' = 'apple_pay|google_pay|samsung_pay|paypal|venmo|other');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `fraud_decision` SET TAGS ('dbx_business_glossary_term' = 'Fraud Decision');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `fraud_decision` SET TAGS ('dbx_value_regex' = 'approved|declined|review|challenge');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `fraud_decision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `masked_pan` SET TAGS ('dbx_business_glossary_term' = 'Masked Primary Account Number (PAN)');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `masked_pan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `masked_pan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Status');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|declined|voided|refunded');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `processor_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Reference ID');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `processor_reference_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `tender_sequence` SET TAGS ('dbx_business_glossary_term' = 'Tender Sequence Number');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `three_ds_authentication_result` SET TAGS ('dbx_business_glossary_term' = '3DS (3-D Secure) Authentication Result');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `three_ds_authentication_result` SET TAGS ('dbx_value_regex' = 'authenticated|not_authenticated|attempted|unavailable|error');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `three_ds_authentication_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `three_ds_version` SET TAGS ('dbx_business_glossary_term' = '3DS (3-D Secure) Protocol Version');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS (Payment Card Industry Data Security Standard) Payment Token');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `retail_ecm`.`order`.`payment` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
ALTER TABLE `retail_ecm`.`order`.`discount` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`discount` SET TAGS ('dbx_subdomain' = 'payment_discounts');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Identifier');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `markdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `pos_transaction_line_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Campaign Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `applied_at_level` SET TAGS ('dbx_business_glossary_term' = 'Applied At Level');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `applied_at_level` SET TAGS ('dbx_value_regex' = 'header|line');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Timestamp');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|auto_applied');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Discount Application Channel');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile_app|call_center|kiosk');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Currency Code');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `discount_method` SET TAGS ('dbx_business_glossary_term' = 'Discount Method');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `discount_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|tiered|bogo|free_shipping');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason Code');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason Description');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `source_system_discount_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Discount Identifier (ID)');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `tax_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Flag');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `tax_treatment_flag` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `tax_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `tax_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `taxable_amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Taxable Amount Adjustment');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `retail_ecm`.`order`.`discount` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `retail_ecm`.`order`.`cancellation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`order`.`cancellation` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation ID');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `pos_transaction_line_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_number` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Number');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_number` SET TAGS ('dbx_value_regex' = '^CXL-[0-9]{10}$');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_status` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Status');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|reversed');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancelled_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Amount');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `cancelled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Channel');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee Amount');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `initiator_type` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Initiator Type');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `initiator_type` SET TAGS ('dbx_value_regex' = 'customer|system|agent|fraud_detection|inventory_allocation_failure|payment_failure');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `inventory_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inventory Release Timestamp');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `inventory_released_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Released Flag');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `processing_system_code` SET TAGS ('dbx_business_glossary_term' = 'Processing System ID');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Currency Code');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment_method|store_credit|gift_card|manual_check|bank_transfer');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Stage');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'pre_allocation|post_allocation_pre_pick|post_pick_pre_ship|post_ship');
ALTER TABLE `retail_ecm`.`order`.`cancellation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`order`.`gift_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`order`.`gift_card` SET TAGS ('dbx_subdomain' = 'payment_discounts');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card ID');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Source Order ID');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Store ID');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Purchaser Customer ID');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `primary_replacement_for_card_gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement For Gift Card ID');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode Value');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Number');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_number` SET TAGS ('dbx_value_regex' = '^[0-9]{16,19}$');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_status` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Status');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_status` SET TAGS ('dbx_value_regex' = 'inactive|active|suspended|expired|depleted|cancelled');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Type');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'physical|digital|virtual|mobile_wallet');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `escheatment_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Date');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `initial_balance` SET TAGS ('dbx_business_glossary_term' = 'Initial Balance Amount');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `issuing_channel` SET TAGS ('dbx_business_glossary_term' = 'Issuing Channel');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `issuing_channel` SET TAGS ('dbx_value_regex' = 'store|ecommerce|mobile_app|call_center|corporate_sales|third_party');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `pin_code` SET TAGS ('dbx_business_glossary_term' = 'Personal Identification Number (PIN) Code');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `pin_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `pin_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `pin_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `qr_code` SET TAGS ('dbx_business_glossary_term' = 'Quick Response (QR) Code');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `reload_count` SET TAGS ('dbx_business_glossary_term' = 'Reload Count');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `reloadable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reloadable Flag');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `terms_and_conditions_version` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Version');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `total_fees_charged` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Charged');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `total_redeemed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Redeemed Amount');
ALTER TABLE `retail_ecm`.`order`.`gift_card` ALTER COLUMN `total_reloaded_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Reloaded Amount');
ALTER TABLE `retail_ecm`.`order`.`subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`order`.`subscription` SET TAGS ('dbx_subdomain' = 'store_transactions');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `digital_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Catalog Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Identifier');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Identifier');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Identifier');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `renewed_from_subscription_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Identifier');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Subscription Amount');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'per_delivery|monthly|quarterly|annual|upfront');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `cancellation_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'ground|express|two_day|next_day|standard');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Subscription Channel');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|in_store|chatbot|voice_assistant');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|custom');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `delivery_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency in Days');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Subscription Discount Amount');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `external_subscription_code` SET TAGS ('dbx_business_glossary_term' = 'External Subscription Identifier');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `gift_subscription_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Subscription Flag');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `last_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Last Delivery Date');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `next_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Delivery Date');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `pause_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pause End Date');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `pause_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pause Start Date');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `skip_next_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Skip Next Delivery Flag');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Number');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_value_regex' = '^SUB-[0-9]{10}$');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|paused|cancelled|expired|pending_activation|suspended');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'subscribe_and_save|auto_replenishment|meal_kit|curated_box|membership|service_plan');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `total_deliveries_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Deliveries Completed');
ALTER TABLE `retail_ecm`.`order`.`subscription` ALTER COLUMN `total_deliveries_skipped` SET TAGS ('dbx_business_glossary_term' = 'Total Deliveries Skipped');
