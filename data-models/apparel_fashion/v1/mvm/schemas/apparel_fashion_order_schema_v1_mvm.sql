-- Schema for Domain: order | Business: Apparel Fashion | Version: v1_mvm
-- Generated on: 2026-05-05 18:07:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`order` COMMENT 'Manages end-to-end order lifecycle from quote to fulfillment including sales orders, POs, backorders, allocations, and OTIF tracking. Handles DTC e-commerce orders, wholesale EDI orders, retail POS orders, and replenishment. Owns ATP, ATS, RMA processing, and order orchestration across SAP S/4HANA SD and Salesforce Commerce Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`sales_order` (
    `sales_order_id` BIGINT COMMENT 'Unique identifier for the sales order record. Primary key for the sales order entity.',
    `address_id` BIGINT COMMENT 'Reference to the billing address for this order. Links to customer address master. Used for invoicing and payment processing.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Orders frequently originate from marketing campaigns. Direct link enables ROAS calculation, CAC analysis, campaign performance measurement, and marketing attribution reporting—core analytics for appar',
    `channel_id` BIGINT COMMENT 'Foreign key linking to merchandising.channel. Business justification: sales_order.distribution_channel is a plain text denormalization of the channel master. Linking to merchandising.channel enables channel-level order analytics, pricing strategy validation per channel,',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Collection-level sales reporting: wholesale sales orders in apparel are placed against a seasonal collection (e.g., Spring 2025). Collection-level sell-through analysis, wholesale line sheet order tra',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Apparel groups (e.g., PVH, Tapestry, Capri) operate multiple legal entities. Sales orders must be attributed to a company code for statutory revenue reporting, intercompany sales elimination, and mult',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: B2B orders are placed by specific contacts at wholesale accounts. Captures ordering contact for account management, sales commission tracking, and contact-level purchasing behavior analysis in wholesa',
    `payment_method_id` BIGINT COMMENT 'Reference to the payment method used for this order. Links to customer payment method master for credit card, bank transfer, or other payment instruments.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to merchandising.price_book. Business justification: Wholesale and B2B apparel orders are executed against a specific price book (seasonal, wholesale, VIP). Linking sales_order to price_book enables price book utilization reporting, wholesale margin ana',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed this sales order. Links to the customer master record for DTC (Direct-to-Consumer) orders.',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to marketing.promo_code. Business justification: At checkout, the sales order captures which promo code was entered — the source-of-truth for order-level promo attribution, fraud detection, and discount reconciliation. The existing plain-text promot',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-level sales attribution and omnichannel channel-mix reporting require knowing which retail store originated a sales order (in-store POS, BOPIS, SFS). Fashion retail operations track store-origin',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Sales orders are executed within seasonal merchandise cycles. Essential for seasonal sales performance reporting, assortment planning validation, and aligning order fulfillment with seasonal delivery ',
    `shipping_address_id` BIGINT COMMENT 'Reference to the shipping address for order delivery. Links to customer address master. Used for fulfillment and logistics planning.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this order. Links to warehouse location master. Determined by inventory availability and shipping address proximity.',
    `wholesale_account_id` BIGINT COMMENT 'Reference to the wholesale account for B2B orders. Null for DTC (Direct-to-Consumer) orders. Links to wholesale account master for wholesale EDI (Electronic Data Interchange) orders.',
    `carrier_code` STRING COMMENT 'Code identifying the logistics carrier assigned to deliver this order. Examples include UPS, FedEx, DHL, USPS, or 3PL (Third-Party Logistics) provider codes.. Valid values are `^[A-Z0-9]{2,10}$`',
    `confirmed_delivery_date` DATE COMMENT 'System-confirmed delivery date based on ATP (Available to Promise) and logistics capacity. May differ from requested date due to inventory or capacity constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales order record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order transaction. All monetary amounts in this order are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customer-provided purchase order number for wholesale and B2B orders. Required for EDI (Electronic Data Interchange) orders and accounts payable matching. Null for DTC (Direct-to-Consumer) orders.. Valid values are `^[A-Z0-9-]{1,35}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order, including promotional discounts, markdown (MD) adjustments, and customer-specific pricing. Reduces the subtotal amount.',
    `division` STRING COMMENT 'Product division or category for the order. Used for business unit reporting and merchandise planning. Represents the primary product line of the order. [ENUM-REF-CANDIDATE: mens|womens|kids|accessories|footwear|athletic|lifestyle — 7 candidates stripped; promote to reference product]',
    `fulfillment_status` STRING COMMENT 'Status of order fulfillment operations. Tracks progress through warehouse picking, packing, and shipping. Used for operational monitoring and OTIF (On Time In Full) reporting.. Valid values are `not_started|in_progress|partially_fulfilled|fully_fulfilled|blocked`',
    `gift_message` STRING COMMENT 'Customer-provided gift message for gift orders. Printed on packing slip or gift card. Null for non-gift orders.',
    `is_gift` BOOLEAN COMMENT 'Flag indicating whether this order is a gift. True for gift orders requiring special packaging and gift message inclusion. False for regular orders.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales order record was last modified. Updated whenever order details, status, or amounts change. Used for change tracking and audit compliance.',
    `order_channel` STRING COMMENT 'Sales channel through which the order was placed. E-commerce includes DTC (Direct-to-Consumer) web orders, retail POS (Point of Sale) captures in-store transactions, wholesale EDI (Electronic Data Interchange) handles B2B orders, call center represents phone orders, mobile app captures mobile commerce, and marketplace includes third-party platforms.. Valid values are `ecommerce|retail_pos|wholesale_edi|call_center|mobile_app|marketplace`',
    `order_date` DATE COMMENT 'The date when the sales order was placed by the customer. Represents the business event timestamp for order creation. Used for sales reporting, trend analysis, and OTIF (On Time In Full) tracking.',
    `order_notes` STRING COMMENT 'Free-text notes or special instructions for order fulfillment. May include customer requests, delivery instructions, or internal processing notes.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the sales order. Used for customer communication, tracking, and cross-system reference. Unique across all sales channels.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_source_system` STRING COMMENT 'Operational system of record where the order was originally created. SAP S/4HANA SD handles wholesale and B2B orders, Salesforce Commerce Cloud manages DTC e-commerce, SAP CAR (Customer Activity Repository) captures retail POS transactions, Oracle Retail handles store operations.. Valid values are `sap_s4hana_sd|salesforce_commerce_cloud|sap_car|oracle_retail|other`',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order. Draft orders are incomplete, submitted orders await confirmation, confirmed orders are accepted, allocated orders have inventory reserved, picked orders are in warehouse fulfillment, packed orders are ready to ship, shipped orders are in transit, delivered orders are complete, cancelled orders are voided, returned orders are processing RMA (Return Merchandise Authorization). [ENUM-REF-CANDIDATE: draft|submitted|confirmed|allocated|picked|packed|shipped|delivered|cancelled|returned — 10 candidates stripped; promote to reference product]',
    `order_time` TIMESTAMP COMMENT 'Precise timestamp when the order was placed, including time zone. Used for order sequencing, fulfillment prioritization, and customer service.',
    `order_type` STRING COMMENT 'Classification of the sales order by business purpose. Standard orders are regular sales, rush orders require expedited fulfillment, pre-orders are for future collection releases, backorders are for out-of-stock items, sample orders are for sales representatives, and return orders process RMA (Return Merchandise Authorization).. Valid values are `standard|rush|pre_order|backorder|sample|return`',
    `payment_status` STRING COMMENT 'Status of payment processing for the order. Pending indicates awaiting payment, authorized means funds are reserved, captured means payment is collected, partially paid applies to installment orders, fully paid indicates complete payment, refunded applies to returns, failed indicates payment rejection. [ENUM-REF-CANDIDATE: pending|authorized|captured|partially_paid|fully_paid|refunded|failed — 7 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'Payment terms for the order. Immediate applies to DTC (Direct-to-Consumer) orders, net 30/60/90 are standard B2B terms, COD (Cash on Delivery) for specific channels, prepaid for advance payment, LC (Letter of Credit) for international wholesale. [ENUM-REF-CANDIDATE: immediate|net_30|net_60|net_90|cod|prepaid|lc — 7 candidates stripped; promote to reference product]',
    `priority_tier` STRING COMMENT 'Fulfillment priority classification. VIP orders are for high-value customers, rush orders require expedited processing, high priority orders are time-sensitive, standard orders follow normal processing, backorder priority applies to replenishment orders.. Valid values are `standard|high|vip|rush|backorder`',
    `requested_delivery_date` DATE COMMENT 'Customer-requested delivery date. Used for fulfillment planning and OTIF (On Time In Full) performance measurement.',
    `sales_organization` STRING COMMENT 'Sales organization code responsible for this order. Represents the legal entity or business unit that owns the customer relationship and revenue. Used for financial reporting and commission calculation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `shipping_amount` DECIMAL(18,2) COMMENT 'Shipping and handling charges for order delivery. May be zero for free shipping promotions or wholesale FOB (Free on Board) orders.',
    `shipping_method` STRING COMMENT 'Delivery method selected for the order. Standard is regular ground shipping, express is expedited delivery, overnight is next-day, two-day is second-day, ground is economy shipping, freight is for large wholesale orders, pickup is for BOPIS (Buy Online Pickup In Store). [ENUM-REF-CANDIDATE: standard|express|overnight|two_day|ground|freight|pickup — 7 candidates stripped; promote to reference product]',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, shipping, and discounts. Represents the gross merchandise value of the order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the order, including sales tax, VAT (Value Added Tax), GST (Goods and Services Tax), or other applicable taxes based on ship-to jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final order total including subtotal, taxes, shipping, minus discounts. Represents the total amount charged to the customer or invoiced to the wholesale account.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility. Used for customer self-service tracking and delivery confirmation.. Valid values are `^[A-Z0-9]{10,35}$`',
    CONSTRAINT pk_sales_order PRIMARY KEY(`sales_order_id`)
) COMMENT 'Core master record for all outbound sales orders across DTC e-commerce, retail POS, and wholesale EDI channels. Captures order header data including channel type, order date, customer/account reference, billing and shipping addresses, currency, total amounts, payment terms, order source system (SAP S/4HANA SD or Salesforce Commerce Cloud), priority tier, and overall lifecycle status. Tracks order-level amendments (quantity changes, address updates, cancellations) as audit-trail change records. Serves as the SSOT for all outbound sales order transactions in the apparel-fashion business.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` (
    `sales_order_line_id` BIGINT COMMENT 'Primary key for sales_order_line',
    `price_master_id` BIGINT COMMENT 'Foreign key linking to merchandising.price_master. Business justification: Price auditing, markdown analysis, and revenue reconciliation reports require knowing which price_master record governed the unit_price at time of sale. Apparel finance teams routinely reconcile order',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to marketing.promo_code. Business justification: Line-level promo code attribution is a named apparel business process: margin analysis by SKU requires knowing which promotion drove each lines discount. The existing promotion_id FK points to mercha',
    `promotion_id` BIGINT COMMENT 'Reference to the specific promotion or marketing campaign that generated the discount on this line. Enables promotional ROI analysis.',
    `sales_order_id` BIGINT COMMENT 'Reference to the parent sales order header. Links this line item to its containing order.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment or delivery document that contains this line item. Links order line to physical shipment execution.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU representing the style, colorway, and size combination ordered on this line.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which this line item will be fulfilled. Drives allocation and fulfillment routing.',
    `actual_ship_date` DATE COMMENT 'The actual date on which this line item was shipped to the customer. Used for OTIF (On Time In Full) performance measurement.',
    `atp_confirmed_flag` BOOLEAN COMMENT 'Indicates whether this line item has been confirmed against available inventory through ATP check. True if inventory is reserved, false if pending or backordered.',
    `cancel_date` DATE COMMENT 'The date on which this line item was cancelled. Populated only for cancelled lines. Used for order cancellation analysis.',
    `colorway_code` STRING COMMENT 'Code representing the specific color variant of the product ordered. Used for inventory and fulfillment tracking.',
    `confirmed_ship_date` DATE COMMENT 'The date on which the business has confirmed it can ship this line item. May differ from requested date based on ATP availability.',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'The standard or actual cost of the goods sold on this line item. Used for margin calculation and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this order line record was first created in the system. Represents the initial order capture event.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Enables multi-currency order processing.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total monetary discount applied to this line item. Calculated from discount percentage or promotional pricing rules.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the unit price for this line item. Used for promotional pricing and markdown tracking.',
    `discount_type` STRING COMMENT 'The category or reason for the discount applied. Used for promotional effectiveness analysis and margin tracking. [ENUM-REF-CANDIDATE: promotional|seasonal|volume|employee|wholesale|markdown|clearance — 7 candidates stripped; promote to reference product]',
    `imu_percentage` DECIMAL(18,2) COMMENT 'The initial markup percentage for this line item, calculated as (unit_price - COGS) / unit_price. Key metric for pricing strategy and profitability.',
    `line_number` STRING COMMENT 'Sequential line number within the sales order. Determines the ordering and display sequence of line items within the parent order.',
    `line_status` STRING COMMENT 'Current fulfillment status of this order line. Tracks the line through its lifecycle from order entry to delivery or cancellation. [ENUM-REF-CANDIDATE: open|confirmed|allocated|picked|packed|shipped|delivered|cancelled|backordered — 9 candidates stripped; promote to reference product]',
    `line_subtotal` DECIMAL(18,2) COMMENT 'The extended price for this line item before tax. Calculated as (unit_price * quantity_ordered) - discount_amount.',
    `line_total` DECIMAL(18,2) COMMENT 'The final total amount for this line item including all discounts and taxes. Represents the customers payment obligation for this line.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this order line record was last modified. Tracks the most recent update to any field on this line.',
    `msrp` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for this item. Used for markdown calculation and pricing analytics.',
    `order_source` STRING COMMENT 'The channel or system through which this order line was captured. Enables channel-specific analytics and fulfillment routing.. Valid values are `ecommerce|pos|edi|call_center|mobile_app|wholesale`',
    `product_code` STRING COMMENT 'Business-readable product identifier or style number for the item ordered. Used for display and reporting purposes.',
    `product_name` STRING COMMENT 'Human-readable name or description of the product ordered on this line. Includes style name and key attributes for business user recognition.',
    `quantity_backordered` DECIMAL(18,2) COMMENT 'The quantity of units on backorder due to insufficient inventory at time of order processing. Awaiting future stock availability.',
    `quantity_cancelled` DECIMAL(18,2) COMMENT 'The quantity of units cancelled from this line item, either by customer request or due to inability to fulfill.',
    `quantity_confirmed` DECIMAL(18,2) COMMENT 'The quantity of units confirmed for fulfillment after ATP (Available to Promise) check. May differ from quantity ordered due to inventory constraints.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of units requested by the customer for this line item. Represents the original order request before any adjustments.',
    `quantity_shipped` DECIMAL(18,2) COMMENT 'The actual quantity of units shipped to the customer for this line item. Updated as shipments are processed.',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer has requested delivery of this line item. Critical for customer satisfaction and logistics planning.',
    `requested_ship_date` DATE COMMENT 'The date by which the customer has requested this line item to be shipped. Used for fulfillment prioritization and OTIF tracking.',
    `return_reason_code` STRING COMMENT 'Code indicating the reason for return if this line item was returned by the customer. Used for return merchandise authorization (RMA) processing and quality analysis.',
    `size_code` STRING COMMENT 'Size designation for the product ordered (e.g., S, M, L, XL, or numeric sizes). Critical for fulfillment and inventory allocation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to this line item. Calculated based on applicable tax rates and jurisdiction rules.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is measured. Common values: EA (Each), PR (Pair), DZ (Dozen), CS (Case), PK (Pack).. Valid values are `EA|PR|DZ|CS|PK`',
    `unit_price` DECIMAL(18,2) COMMENT 'The selling price per unit for this line item before any discounts or adjustments. Represents the base transaction price.',
    `upc` STRING COMMENT '12-digit barcode identifier for the specific SKU. Used for point-of-sale scanning and inventory tracking.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_sales_order_line PRIMARY KEY(`sales_order_line_id`)
) COMMENT 'Individual line-item detail within a sales order, representing a specific SKU (style/colorway/size) and quantity requested. Captures product reference, quantity ordered, quantity confirmed, unit price, MSRP, applied discount (amount, type, source), IMU percentage, line status, requested ship date, cancel date, and ATP confirmation flag. Supports both single-unit DTC orders and multi-line wholesale EDI orders with size-curve breakdowns. Each line drives downstream allocation, fulfillment, and backorder processing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` (
    `order_purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record in the lakehouse.',
    `buy_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.buy_plan. Business justification: In apparel, a purchase order is the execution artifact of a buy plan. Buyers and planners track PO-to-buy-plan linkage for OTB reconciliation, receipt-vs-plan variance reporting, and season-end buy ac',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign-driven open-to-buy planning is a core apparel process: buyers raise POs specifically to support product launch campaigns. Linking order_purchase_order to campaign enables campaign-level OTB r',
    `capacity_profile_id` BIGINT COMMENT 'Foreign key linking to supplier.capacity_profile. Business justification: PO placement consumes supplier capacity. Linking PO to the capacity profile used at booking enables capacity utilization tracking, over-booking prevention, and season-level capacity consumption report',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Collection-level OTB management: apparel POs are placed within a seasonal collection budget. Collection-level OTB tracking, seasonal buy vs. plan reporting, and collection margin analysis require PO-t',
    `delivery_window_id` BIGINT COMMENT 'Foreign key linking to production.delivery_window. Business justification: In apparel fashion buying, purchase orders are booked against specific factory delivery windows during the production booking process. This PO-to-delivery-window assignment drives capacity management,',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the receiving warehouse, distribution center, or store where goods will be delivered. Used for inventory allocation and receiving planning.',
    `division_id` BIGINT COMMENT 'Foreign key linking to merchandising.division. Business justification: order_purchase_order.division is a plain text denormalization of the division master. Apparel POs are organized by division (Mens, Womens, Kids). Linking to merchandising.division enables division-',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Purchase orders are planned and tracked by merchandise hierarchy (division/department/class). Essential for category-level procurement reporting, compliance with category budgets, and merchandise plan',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Purchase orders consume open-to-buy budget. Fundamental to OTB management, budget tracking, and preventing over-commitment. Merchandisers must track PO value against available OTB by category and peri',
    `primary_order_warehouse_location_id` BIGINT COMMENT 'Reference to the vendor facility or origin location from which goods will ship. Used for logistics planning and landed cost calculation.',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.production_factory. Business justification: A purchase order in apparel fashion is placed with a specific factory, which may differ from the vendor entity (one vendor operates multiple factories). Buyers need PO-to-factory linkage for complianc',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: In apparel fashion, every commercial PO is awarded following an RFQ process. Linking order_purchase_order to the originating rfq enables sourcing-to-order traceability, vendor performance audits, and ',
    `routing_guide_id` BIGINT COMMENT 'Foreign key linking to logistics.routing_guide. Business justification: Apparel POs must reference the routing guide governing vendor shipping compliance — carrier selection, mode, and lane. Routing guide compliance is a core vendor scorecard metric. Buyers assign routing',
    `season_id` BIGINT COMMENT 'Reference to the merchandising season or collection for which goods are being purchased. Used for assortment planning and markdown management. Nullable for non-seasonal or replenishment orders.',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Seasonal buying process: apparel buyers place POs against a style during line planning before SKU-level breakdown. Style-level OTB tracking, OTIF reporting, and seasonal buy management all require PO-',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_agreement. Business justification: Each PO must reference the governing master vendor agreement for payment terms enforcement, liability cap application, incoterms validation, and legal audit trails. Apparel buyers routinely link POs t',
    `vendor_contact_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contact. Business justification: order_purchase_order stores vendor_contact_email and vendor_contact_name as denormalized plain-text columns. A proper FK to vendor_contact normalizes this, enables contact management, and supports PO ',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor fulfilling this purchase order. Links to supplier master data.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: In apparel fashion, a purchase order issued to a vendor directly triggers a production work order. Buyers and production planners track PO-to-WO linkage for OTIF reporting, production visibility, and ',
    `actual_delivery_date` DATE COMMENT 'Actual date goods were received at destination. Used to calculate OTIF performance. Nullable until goods receipt posted.',
    `approval_status` STRING COMMENT 'Current approval workflow status. Pending indicates awaiting authorization, approved indicates all required approvals obtained, rejected indicates approval denied. Approval may be required based on PO value thresholds or buyer authority limits.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who provided final approval for this purchase order. Nullable if approval not required or still pending.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when final approval was granted. Nullable if approval not required or still pending.',
    `confirmed_delivery_date` DATE COMMENT 'Vendor-confirmed delivery date. May differ from requested date based on vendor capacity and lead time. Nullable until vendor acknowledgment received.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order.. Valid values are `^[A-Z]{3}$`',
    `edi_acknowledgment_received_flag` BOOLEAN COMMENT 'Indicates whether vendor has sent EDI 855 Purchase Order Acknowledgment confirming receipt and acceptance of the PO. True if acknowledgment received, False if pending or not applicable.',
    `edi_transmission_flag` BOOLEAN COMMENT 'Indicates whether this purchase order was transmitted to vendor via EDI (True) or through manual/email channel (False). Used for process automation tracking.',
    `fob_terms` STRING COMMENT 'Specific FOB terms detailing the point at which ownership and risk transfer from vendor to buyer. May include location details beyond standard Incoterms.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Estimated or actual freight and logistics cost for this shipment. May be buyer or vendor responsibility depending on Incoterms. Expressed in currency_code.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the division of costs and risks between buyer and seller. Standard codes per ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `lc_reference` STRING COMMENT 'Reference number for letter of credit securing payment for this purchase order. Used for international trade finance. Nullable for domestic or non-LC transactions.. Valid values are `^[A-Z0-9]{10,30}$`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this purchase order record. Audit trail for change accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was last modified. Audit trail for change tracking.',
    `moq_compliance_flag` BOOLEAN COMMENT 'Indicates whether this purchase order meets the vendors minimum order quantity requirements. True if compliant, False if exception was granted.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special handling requirements, or internal comments related to this purchase order. May include packaging instructions, quality requirements, or delivery constraints.',
    `otif_target_flag` BOOLEAN COMMENT 'Indicates whether this purchase order met OTIF performance targets. True if delivered on or before confirmed_delivery_date with full quantity, False otherwise. Nullable until delivery complete.',
    `payment_terms` STRING COMMENT 'Code defining payment conditions including due date calculation, cash discount periods, and discount percentages. Examples: Net 30, 2/10 Net 30.. Valid values are `^[A-Z0-9]{4,10}$`',
    `po_date` DATE COMMENT 'Date the purchase order was issued to the vendor. Principal business event timestamp for the transaction.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order number issued to vendor. Business identifier used in EDI transactions and vendor communications.. Valid values are `^[A-Z0-9]{8,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Tracks progression from draft through vendor acknowledgment, production, shipment, receipt, and closure. Cancelled indicates order was terminated before completion. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|in_production|shipped|received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of purchase order by business purpose: replenishment (NOS restocking, VMI, min-max), wholesale (bulk buying for resale), drop-ship (direct-to-customer fulfillment), demand-driven (responsive to actual demand signal), consignment (vendor-owned inventory), or sample (pre-production or marketing samples).. Valid values are `replenishment|wholesale|drop_ship|demand_driven|consignment|sample`',
    `priority_code` STRING COMMENT 'Urgency classification for this purchase order. Rush and critical orders may incur premium freight or vendor surcharges. Used for vendor capacity allocation and logistics planning.. Valid values are `standard|expedited|rush|critical`',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or buying team responsible for this PO. Used for workload distribution and performance tracking.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for procurement. May represent centralized or decentralized buying structure.. Valid values are `^[A-Z0-9]{4,10}$`',
    `replenishment_trigger` STRING COMMENT 'Business rule or event that triggered creation of this replenishment purchase order. Reorder_point indicates stock fell below threshold, wos_target indicates weeks-of-supply planning, vmi_signal indicates vendor-managed inventory auto-replenishment, manual indicates buyer-initiated, forecast_driven indicates demand planning system, promotion indicates event-based buying.. Valid values are `reorder_point|wos_target|vmi_signal|manual|forecast_driven|promotion`',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods. Used for OTIF tracking and supply chain planning.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order. May include VAT, GST, customs duties depending on jurisdiction and Incoterms. Expressed in currency_code.',
    `total_landed_cost` DECIMAL(18,2) COMMENT 'Total cost to land goods at destination including PO value, taxes, freight, duties, and other charges. Used for inventory valuation and profitability analysis. Expressed in currency_code.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and freight. Expressed in currency_code.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this purchase order record. Audit trail for accountability.',
    CONSTRAINT pk_order_purchase_order PRIMARY KEY(`order_purchase_order_id`)
) COMMENT 'Purchase orders issued for replenishment (NOS restocking, VMI, min-max), wholesale buying, and drop-ship fulfillment. Captures PO number, buyer entity, vendor/supplier reference, PO type (replenishment, wholesale, drop-ship, demand-driven), FOB terms, LC reference, MOQ compliance flag, total PO value, currency, incoterms, expected delivery date, replenishment trigger (reorder point, WOS target), source/destination locations, and PO status. Sourced from SAP S/4HANA MM and supports OTIF tracking for inbound goods flow. Consolidates all inbound demand order types into a single entity differentiated by PO type.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` (
    `order_purchase_order_line_id` BIGINT COMMENT 'Primary key for purchase_order_line',
    `bom_id` BIGINT COMMENT 'Foreign key linking to product.bom. Business justification: BOM-based costing validation on PO lines: in apparel manufacturing, PO lines reference the approved BOM to validate unit costs against target COGS. PLM-ERP integration requires this link for cost devi',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Colorway-level buying: apparel PO lines are placed at colorway level (specific color of a style) before size-run SKU breakdown. Colorway-level buy reporting, assortment color analysis, and vendor allo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PO lines in apparel are charged to cost centers for budget consumption tracking and departmental spend reporting. Linking order_purchase_order_line to finance.cost_center enables OTB budget vs. actual',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: PO lines reference GL accounts for automated AP posting and expense classification in apparel procurement-to-pay. Linking order_purchase_order_line to finance.gl_account enables automated journal entr',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Each PO line in apparel imports carries an HS code for duty calculation, customs entry filing, and trade compliance reporting. Linking to logistics.hs_code enables automated duty rate lookup, Section ',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line to the overall PO document.',
    `rfq_line_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq_line. Business justification: Each PO line traces to the RFQ line for cost benchmarking — comparing awarded unit cost against target FOB/CMT cost from the RFQ line. This cost variance report is a mandatory step in apparel landed c',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU being ordered. Links to the product master for material details.',
    `sourcing_purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order_line. Business justification: Each commercial PO line maps to a sourcing PO line for quantity confirmation, costing variance analysis, and delivery status reconciliation. Apparel buyers require this link to track open quantities a',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Style-level OTB management and OTIF reporting: PO lines in apparel track ordered quantities by style for assortment planning and vendor performance reporting. style_code is a denormalized plain-text r',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: PO lines in apparel can be split across factories (e.g., cut-and-sew at one factory, embellishment at another). Factory-level line tracking is required for country-of-origin certification, capacity al',
    `vendor_cost_quote_id` BIGINT COMMENT 'Foreign key linking to sourcing.vendor_cost_quote. Business justification: The unit cost on a commercial PO line is derived from an approved vendor cost quote. This link enables cost variance analysis (PO cost vs. quoted cost), a mandatory control in apparel landed cost mana',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor providing this line item. May differ from factory if using a trading company or agent.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Each PO line maps to a specific work order at the style/SKU/quantity level. Production planners and merchandisers require PO line → work order linkage for production tracking, unit costing, and delive',
    `actual_delivery_date` DATE COMMENT 'Actual date when goods were delivered to the warehouse or DC. Used for OTIF (On Time In Full) performance measurement.',
    `confirmed_delivery_date` DATE COMMENT 'Delivery date confirmed by the supplier. May differ from requested date due to production lead times or capacity constraints.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the supplier via order acknowledgment or EDI 855. May differ from ordered quantity due to capacity or material constraints.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the goods are manufactured. Required for customs compliance and trade preference programs (GSP, FTA). [ENUM-REF-CANDIDATE: USA|CHN|IND|VNM|BGD|TUR|MEX|IDN|PAK|KHM — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order line was first created in the system. Used for audit trail and order processing analytics.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Indicates the currency in which the supplier invoice will be denominated.. Valid values are `USD|EUR|GBP|CNY|JPY|INR`',
    `incoterm` STRING COMMENT 'Incoterm defining the delivery terms and transfer of risk between buyer and supplier. Common values: FOB (Free on Board), EXW (Ex Works), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: FOB|EXW|FCA|CPT|CIP|DAP|DDP|DPU — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this line item. Tracks changes to quantities, dates, or status throughout the order lifecycle.',
    `line_category` STRING COMMENT 'Classification of the purchase order line type. Determines procurement process and inventory handling. Values: standard (normal purchase), consignment (supplier-owned inventory), subcontracting (CMT with buyer-supplied materials), stock_transfer (inter-company transfer).. Valid values are `standard|consignment|subcontracting|stock_transfer`',
    `line_notes` STRING COMMENT 'Free-text notes or special instructions for this line item. May include packing requirements, labeling instructions, or quality specifications.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines ordering and display sequence.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line. Tracks progression from order placement through goods receipt. Values: open (awaiting confirmation), confirmed (supplier acknowledged), in_production (manufacturing underway), shipped (in transit), received (goods receipt posted), closed (fully delivered), cancelled (order cancelled). [ENUM-REF-CANDIDATE: open|confirmed|in_production|shipped|received|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this line. Calculated as ordered quantity multiplied by unit cost.',
    `material_description` STRING COMMENT 'Textual description of the material or product being ordered. Includes style, color, size, and fabric details.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this SKU. Used to validate order quantities against supplier constraints.',
    `open_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be received. Calculated as confirmed quantity minus received quantity. Used for backorder tracking.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Total quantity of the SKU ordered on this line. Expressed in the unit of measure specified.',
    `otif_status` STRING COMMENT 'OTIF performance indicator for this line. Compares actual delivery date and quantity against confirmed commitments. Values: on_time_in_full (met commitments), late (delivered after confirmed date), short (quantity less than confirmed), partial (multiple receipts).. Valid values are `on_time_in_full|late|short|partial`',
    `payment_terms` STRING COMMENT 'Payment terms negotiated for this line. Specifies due date calculation and early payment discounts (e.g., Net 30, 2/10 Net 30, LC at sight).',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether this line item requires quality inspection upon receipt. True triggers QC workflow in WMS before stock availability.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity received to date against this line. Updated via goods receipt postings in WMS.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of this line item. Used for production planning and TNA calendar alignment.',
    `season_code` STRING COMMENT 'Fashion season or collection code for this line item. Links to merchandise planning and assortment strategy (e.g., SS24, FW24, Holiday23).',
    `tax_code` STRING COMMENT 'Tax classification code for this line item. Determines applicable VAT, GST, or sales tax rates based on jurisdiction and product category.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for this line item. Represents the negotiated price from the supplier, typically FOB or CMT cost.',
    `unit_of_measure` STRING COMMENT 'Unit in which the ordered quantity is expressed. Common values: EA (each), PC (piece), DZ (dozen), CS (case), PK (pack), PR (pair), ST (set), KG (kilogram), LB (pound), YD (yard), MT (meter). [ENUM-REF-CANDIDATE: EA|PC|DZ|CS|PK|PR|ST|KG|LB|YD|MT — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_order_purchase_order_line PRIMARY KEY(`order_purchase_order_line_id`)
) COMMENT 'Line-item detail for a purchase order, capturing individual SKU-level quantities, unit cost (CMT/FOB), material description, HS code, country of origin, MOQ per line, confirmed quantity, open quantity, and line delivery schedule. Supports inbound goods receipt matching and OTIF measurement at the SKU level. Linked to the purchase_order header and drives supply chain visibility.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`fulfillment` (
    `fulfillment_id` BIGINT COMMENT 'Primary key for fulfillment',
    `allocation_id` BIGINT COMMENT 'Foreign key linking to order.allocation. Business justification: Fulfillment is the physical execution of an inventory allocation. The allocation record reserves inventory against a sales order line; the fulfillment record tracks the pick/pack/ship execution of tha',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Fulfillment records track which carrier executed the outbound delivery. Linking to logistics.carrier enables carrier OTIF performance reporting, SLA breach detection, and damage claim tracking at the ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to merchandising.channel. Business justification: fulfillment.channel is a plain text denormalization of the channel master. Linking to merchandising.channel enables channel-level OTIF performance reporting, shipping cost analysis by channel, and omn',
    `lot_id` BIGINT COMMENT 'Foreign key linking to production.lot. Business justification: Apparel fashion fulfillment is traced to a specific production lot for quality traceability, product recall management, and compliance audits. Knowing which production lot was shipped is a regulatory ',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Ship-from-store fulfillment requires identifying the originating retail store for store inventory deduction, labor cost attribution, and SFS OTIF performance reporting. fulfillment.warehouse_location_',
    `sales_order_id` BIGINT COMMENT 'Reference to the parent sales order being fulfilled. Links this fulfillment record to the originating order.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the specific order line item being fulfilled. Nullable for header-level fulfillments.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Fulfillment carries fully denormalized ship-to address fields that duplicate customer.address. Normalizing via FK supports carrier integration, address validation reporting, delivery performance analy',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Fulfillment executes physical shipment of orders. Links fulfillment records to logistics_shipment for OTIF tracking, carrier performance analysis, and delivery confirmation workflows. Essential for or',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center location from which the order was fulfilled.',
    `actual_delivery_date` DATE COMMENT 'Actual date the shipment was delivered to the customer. Used to measure OTIF (On Time In Full) performance and service level compliance.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment was delivered to the customer, including time zone. Captured from carrier proof of delivery.',
    `asn_reference_number` STRING COMMENT 'EDI 856 ASN document reference number sent to wholesale buyers notifying them of inbound shipment details.. Valid values are `^[A-Z0-9]{8,30}$`',
    `carrier_service_level` STRING COMMENT 'Specific service tier provided by the carrier such as ground, two-day, overnight, or international express.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment record was first created in the system. Marks the initiation of fulfillment processing.',
    `estimated_delivery_date` DATE COMMENT 'Carrier-provided estimated date of delivery based on service level and transit time. May differ from promised date.',
    `fulfillment_number` STRING COMMENT 'Business-facing unique identifier for the fulfillment record. Used for tracking and customer communication.. Valid values are `^[A-Z0-9]{8,20}$`',
    `fulfillment_status` STRING COMMENT 'Current lifecycle status of the fulfillment execution. Tracks progression from warehouse pick through final delivery. [ENUM-REF-CANDIDATE: pending|picking|picked|packing|packed|shipped|in_transit|delivered|cancelled|failed — 10 candidates stripped; promote to reference product]',
    `fulfillment_type` STRING COMMENT 'Classification of the fulfillment service level. Determines handling priority and delivery expectations. [ENUM-REF-CANDIDATE: standard|express|same_day|next_day|international|store_pickup|curbside — 7 candidates stripped; promote to reference product]',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the fulfillment included 100% of the ordered quantity, regardless of delivery timing.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment record was most recently modified. Used for change tracking and data synchronization.',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the fulfillment was delivered on or before the promised delivery date, regardless of quantity completeness.',
    `otif_flag` BOOLEAN COMMENT 'Boolean indicator of whether the fulfillment met OTIF (On Time In Full) performance criteria: delivered on or before promised date with complete quantity.',
    `pack_complete_timestamp` TIMESTAMP COMMENT 'Date and time when all items were packed into shipping cartons and ready for carrier pickup.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Date and time when packing activity began for this fulfillment. Marks the transition from picking to packing operations.',
    `pick_complete_timestamp` TIMESTAMP COMMENT 'Date and time when all items for this fulfillment were successfully picked from warehouse inventory.',
    `pick_start_timestamp` TIMESTAMP COMMENT 'Date and time when warehouse picking activity began for this fulfillment. Marks the start of physical fulfillment execution.',
    `promised_delivery_date` DATE COMMENT 'Date committed to the customer for delivery. Used to calculate OTIF (On Time In Full) performance and manage customer expectations.',
    `ship_date` DATE COMMENT 'Date the shipment was handed over to the carrier and departed the fulfillment location. Key milestone for OTIF (On Time In Full) tracking.',
    `ship_to_email_address` STRING COMMENT 'Email address for the delivery recipient. Used for shipment tracking notifications and delivery confirmations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ship_to_name` STRING COMMENT 'Name of the recipient or delivery contact for this shipment. May differ from the ordering customer for gift orders.',
    `ship_to_phone_number` STRING COMMENT 'Contact phone number for the delivery recipient. Used by carrier for delivery coordination and customer notification.',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost charged by the carrier for this shipment. Used for COGS (Cost of Goods Sold) calculation and profitability analysis.',
    `shipping_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the shipping cost amount.. Valid values are `^[A-Z]{3}$`',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for warehouse or carrier regarding special handling requirements such as fragile items, gift wrapping, or delivery preferences.',
    `total_cartons` STRING COMMENT 'Total number of shipping cartons or packages in this fulfillment. Used for warehouse capacity planning and carrier billing.',
    `total_units` STRING COMMENT 'Total number of individual SKU (Stock Keeping Unit) units included in this fulfillment across all cartons.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the shipment in cubic meters. Used for warehouse space planning and dimensional weight pricing.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms including packaging. Used for carrier billing and freight cost calculation.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for shipment visibility. Used by customers and operations to monitor delivery progress.. Valid values are `^[A-Z0-9]{10,35}$`',
    CONSTRAINT pk_fulfillment PRIMARY KEY(`fulfillment_id`)
) COMMENT 'Tracks the fulfillment execution record for a sales order or order line, capturing pick, pack, and ship activities including ASN (Advance Shipment Notice) generation for wholesale buyers. Includes fulfillment status, warehouse/DC location, 3PL carrier assignment, ship date, promised delivery date, actual delivery date, tracking number, EDI 856 ASN reference, total cartons, total units, OTIF flag, and fulfillment channel (store, DC, drop-ship). Sourced from Manhattan Associates WMS and SAP WM. Serves as the single source of truth for all outbound shipment events linking orders to physical delivery.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Primary key for allocation',
    `allocation_rule_id` BIGINT COMMENT 'Foreign key linking to order.allocation_rule. Business justification: Allocations are executed according to allocation rules. The allocation table has an allocation_method STRING field but no FK to the governing allocation_rule. Adding allocation_rule_id creates a direc',
    `channel_id` BIGINT COMMENT 'Foreign key linking to merchandising.channel. Business justification: allocation.channel is a plain text denormalization. Linking to merchandising.channel master enables channel-level inventory allocation analysis, fill rate by channel reporting, and supports omnichanne',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific lot or batch of inventory allocated, supporting traceability and FEFO logic.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to production.lot. Business justification: In apparel fashion, inventory allocation for sales orders is performed at the production lot level to ensure quality-controlled units are reserved for specific orders. Allocating specific production l',
    `reservation_id` BIGINT COMMENT 'Reference to the inventory reservation record that preceded or accompanies this allocation.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-level inventory allocation is a core apparel merchandising process — allocating units to specific stores for new season drops and replenishment. Allocation records must reference the destination',
    `sales_order_id` BIGINT COMMENT 'Reference to the parent sales order for which inventory is being allocated.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the specific sales order line item being allocated.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record that fulfilled this allocation.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU being allocated to fulfill the order line.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, store, or 3PL location from which inventory is allocated.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity of SKU units allocated to this order line from available inventory.',
    `allocated_quantity_uom` STRING COMMENT 'Unit of measure for the allocated quantity (e.g., each, pieces, pairs).. Valid values are `EA|PCS|PAIR|SET|BOX|CASE`',
    `allocation_date` DATE COMMENT 'The business date on which the allocation decision was made.',
    `allocation_method` STRING COMMENT 'The allocation strategy or rule applied to determine inventory assignment (First In First Out, priority, channel-based, proximity). [ENUM-REF-CANDIDATE: FIFO|LIFO|FEFO|priority_based|channel_based|proximity_based|cost_optimized — 7 candidates stripped; promote to reference product]',
    `allocation_number` STRING COMMENT 'Business-readable unique allocation document number for tracking and reference.. Valid values are `^ALLOC-[0-9]{10}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the allocation record indicating its fulfillment state.. Valid values are `pending|confirmed|partially_fulfilled|fulfilled|cancelled|expired`',
    `allocation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the allocation was created in the system.',
    `atp_confirmation_flag` BOOLEAN COMMENT 'Indicates whether the allocation was confirmed against Available to Promise inventory rules.',
    `atp_confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when ATP confirmation was received for this allocation.',
    `ats_at_allocation` DECIMAL(18,2) COMMENT 'Snapshot of the Available to Sell inventory quantity at the source location at the time of allocation.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether this allocation is for a backordered item awaiting future inventory availability.',
    `cancellation_reason` STRING COMMENT 'Reason code or description if the allocation was cancelled (e.g., inventory unavailable, order cancelled, customer request).',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment classification influencing allocation priority and method.. Valid values are `VIP|premium|standard|wholesale|employee`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the allocated lot/batch, relevant for FEFO allocation strategies.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'The actual quantity fulfilled against this allocation, which may differ from allocated quantity due to shortages or adjustments.',
    `fulfilled_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was fully or partially fulfilled.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special handling, exceptions, or business context for this allocation.',
    `preorder_flag` BOOLEAN COMMENT 'Indicates whether this allocation is for a preorder item not yet available in inventory.',
    `priority` STRING COMMENT 'Numeric priority ranking assigned to this allocation for sequencing fulfillment (lower number = higher priority).',
    `promised_delivery_date` DATE COMMENT 'The date promised to the customer for delivery of the allocated SKU, used for OTIF tracking.',
    `requested_ship_date` DATE COMMENT 'The date by which the allocated inventory is requested to ship to meet customer delivery expectations.',
    `source_location_type` STRING COMMENT 'Classification of the source location from which inventory is allocated.. Valid values are `DC|warehouse|store|3PL|vendor|cross_dock`',
    `source_system` STRING COMMENT 'The source system or module that originated this allocation record.. Valid values are `SAP_SD|Oracle_RMS|Salesforce_Commerce|Manhattan_WMS|manual`',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'Records the inventory allocation decisions made against sales order lines, capturing allocated SKU, allocated quantity, allocation source location (DC, store, 3PL), allocation date, ATS at time of allocation, ATP confirmation, allocation method (FIFO, priority, channel-based), and allocation status. Supports OTB-driven allocation strategies and NOS replenishment logic. Owned by the order domain as the bridge between demand and available inventory.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`backorder` (
    `backorder_id` BIGINT COMMENT 'Unique identifier for the backorder record. Primary key.',
    `allocation_id` BIGINT COMMENT 'Foreign key linking to order.allocation. Business justification: A backorder is created when an allocation attempt fails (allocation.backorder_flag = true). Linking backorder.allocation_id → allocation.allocation_id directly connects the backorder to the specific a',
    `allocation_rule_id` BIGINT COMMENT 'Reference to the allocation rule that was applied when the backorder was created, if applicable.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (style-color-size combination) that is backordered.',
    `backorder_substitute_sku_id` BIGINT COMMENT 'Reference to an alternative SKU offered or accepted as a substitute for the backordered item, if applicable.',
    `fulfillment_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment. Business justification: When a backorder is resolved, it is fulfilled via a fulfillment record. Linking backorder.fulfillment_id → fulfillment.fulfillment_id captures the resolution event — enabling measurement of backorder-',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed the original order containing this backorder.',
    `replenishment_order_id` BIGINT COMMENT 'Reference to the replenishment order or purchase order that will supply inventory to fulfill this backorder, if linked.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-originated backorders (e.g., BOPIS where store inventory is insufficient) require store attribution for store-level backorder rate reporting, customer notification workflows, and store operation',
    `sales_order_id` BIGINT COMMENT 'Reference to the parent sales order that generated this backorder.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the specific sales order line item that could not be fulfilled and resulted in this backorder.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: backorder.season_code is a plain text denormalization of the season master. In apparel, backordered items are season-specific; linking to season enables season-level backorder aging reports, clearance',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Style-level backorder analysis and replenishment planning: operations teams track backorders by style to prioritize production and replenishment decisions. style_code is a denormalized plain-text colu',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center responsible for fulfilling this backorder.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Wholesale backorder management in apparel tracks open backorders per retail account for account-level fill-rate reporting, priority allocation decisions, and buyer communication. backorder already has',
    `work_order_id` BIGINT COMMENT 'Reference to the production order that will manufacture goods to fulfill this backorder, if applicable.',
    `actual_fulfillment_date` DATE COMMENT 'The actual date when the backorder was fulfilled and shipped, null if still pending.',
    `backorder_number` STRING COMMENT 'Human-readable business identifier for the backorder, used for tracking and customer communication.. Valid values are `^BO-[0-9]{8}$`',
    `backorder_status` STRING COMMENT 'Current lifecycle status of the backorder indicating its fulfillment stage. [ENUM-REF-CANDIDATE: open|allocated|in_production|ready_to_ship|shipped|cancelled|substituted — 7 candidates stripped; promote to reference product]',
    `backordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of units that could not be fulfilled and are on backorder.',
    `cancellation_date` DATE COMMENT 'The date when the backorder was cancelled, either by the customer or by the business, null if still active.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the backorder was cancelled, if applicable.',
    `color_code` STRING COMMENT 'The color code of the backordered SKU.',
    `creation_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the backorder record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the backorder monetary values.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment classification used to determine backorder priority and handling (VIP, wholesale, retail, DTC, employee).. Valid values are `vip|wholesale|retail|dtc|employee`',
    `days_on_backorder` STRING COMMENT 'The number of days the order has been on backorder status, calculated from backorder_creation_date to current date or fulfillment date.',
    `expected_fulfillment_date` DATE COMMENT 'The estimated date when the backorder will be fulfilled and shipped to the customer.',
    `expected_replenishment_date` DATE COMMENT 'The anticipated date when inventory will be replenished and available to fulfill this backorder.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the backordered quantity (backordered_quantity × unit_price).',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'The quantity that was successfully fulfilled from the original order line, if any partial fulfillment occurred.',
    `nos_flag` BOOLEAN COMMENT 'Boolean indicator of whether the backordered SKU is part of a Never Out of Stock program, which affects replenishment priority.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or internal notes related to the backorder.',
    `notification_sent_date` DATE COMMENT 'The date when the backorder notification was sent to the customer.',
    `notification_status` STRING COMMENT 'Status indicating whether the customer has been notified about the backorder and any follow-up communications.. Valid values are `not_sent|sent|acknowledged|reminder_sent`',
    `order_channel` STRING COMMENT 'The sales channel through which the original order was placed (e-commerce, wholesale EDI, retail POS, call center, mobile app).. Valid values are `ecommerce|wholesale_edi|retail_pos|call_center|mobile_app`',
    `original_requested_quantity` DECIMAL(18,2) COMMENT 'The original quantity requested on the sales order line before partial fulfillment or backorder split.',
    `priority_tier` STRING COMMENT 'Priority classification for backorder fulfillment based on customer segment, order value, or business rules (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `reason_code` STRING COMMENT 'Categorical reason code explaining why the backorder occurred (stockout, production delay, allocation exhausted, supplier delay, quality hold, demand spike).. Valid values are `stockout|production_delay|allocation_exhausted|supplier_delay|quality_hold|demand_spike`',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of the backorder reason providing additional context beyond the reason code.',
    `resolution_action` STRING COMMENT 'The action taken or planned to resolve the backorder (hold for next drop, cancel, substitute with alternative SKU, split shipment, upgrade).. Valid values are `hold|cancel|substitute|split_shipment|upgrade`',
    `size_code` STRING COMMENT 'The size code of the backordered SKU.',
    `sla_target_days` STRING COMMENT 'The number of days within which the backorder should be fulfilled per the customer service SLA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the backordered quantity (EA=Each, PR=Pair, DZ=Dozen, CS=Case, PK=Pack).. Valid values are `EA|PR|DZ|CS|PK`',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the backordered SKU at the time of the original order.',
    `creation_date` DATE COMMENT 'The date when the backorder was created, typically when the order line could not be allocated.',
    CONSTRAINT pk_backorder PRIMARY KEY(`backorder_id`)
) COMMENT 'Captures unfulfilled demand when a sales order line cannot be immediately allocated due to insufficient ATS or ATP. Tracks original order line reference, backordered SKU (style/color/size), backordered quantity, backorder creation date, expected replenishment date, reason code (stockout, production delay, allocation exhausted), priority tier based on customer segment, notification status, and resolution action (cancel, substitute, hold for next drop). Triggers WOS-based replenishment and supports customer service SLA management for apparel seasonal and NOS programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Unique identifier for the return merchandise authorization record.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: RMAs in apparel generate credit memos against the original AR invoice for refund processing and revenue reversal. Linking rma to ar_invoice enables credit memo issuance, chargeback reconciliation, and',
    `profile_id` BIGINT COMMENT 'Reference to the customer initiating the return.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: In-store returns generate RMAs. Store-level return rate reporting, loss prevention analysis, and disposition routing all require identifying which retail store processed the return. rma has warehouse_',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Return label generation and carrier pickup scheduling require the customers canonical return-from address. Apparel returns operations link RMAs to the specific address record for logistics processing',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Return merchandise processing requires linking the RMA to its physical return shipment for carrier OTIF tracking, return freight cost reconciliation, and customs compliance on international returns. A',
    `sales_order_id` BIGINT COMMENT 'Reference to the new order created if the disposition type is exchange.',
    `rma_sales_order_id` BIGINT COMMENT 'Reference to the originating sales order that this RMA is associated with.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer, relevant for wholesale RTV processing and vendor chargebacks.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where the returned merchandise was received.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: B2B wholesale returns in apparel are managed per wholesale account — retailers return seasonal overstock or defective goods under account-level RMA agreements. Account-level return rate reporting, cre',
    `approved_date` DATE COMMENT 'Date when the RMA was approved by customer service or automated system.',
    `completed_date` DATE COMMENT 'Date when the RMA process was fully completed including refund, exchange, or credit issuance.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the RMA complies with FTC and CPSC requirements for consumer returns and product safety standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this RMA.. Valid values are `^[A-Z]{3}$`',
    `disposition_type` STRING COMMENT 'Action taken on the return: full refund, exchange for different item, store credit issued, repair and return, or rejection of return.. Valid values are `refund|exchange|store_credit|repair|reject`',
    `inspection_notes` STRING COMMENT 'Free-text notes recorded by the inspector during the condition assessment of returned merchandise.',
    `quality_defect_code` STRING COMMENT 'Standardized code identifying the specific quality defect found during inspection, if applicable.',
    `received_date` DATE COMMENT 'Date when the returned merchandise was physically received at the warehouse or store.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total monetary amount refunded to the customer in the transaction currency.',
    `requested_date` DATE COMMENT 'Date when the customer or wholesale partner initiated the return request.',
    `restocking_eligible_flag` BOOLEAN COMMENT 'Indicates whether the returned merchandise is eligible to be restocked into available inventory based on condition assessment.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing the return, if applicable per return policy.',
    `return_channel` STRING COMMENT 'Channel through which the return was initiated: Direct-to-Consumer (DTC) online, DTC store, wholesale Return to Vendor (RTV), or marketplace.. Valid values are `dtc_online|dtc_store|wholesale_rtv|marketplace`',
    `return_condition` STRING COMMENT 'Assessment of the physical condition of returned merchandise upon inspection: new/unused, opened but unused, lightly used, damaged, defective, or missing parts.. Valid values are `new_unused|opened_unused|lightly_used|damaged|defective|missing_parts`',
    `return_label_type` STRING COMMENT 'Indicates who paid for the return shipping label: prepaid by retailer, paid by customer, or paid by vendor.. Valid values are `prepaid|customer_paid|vendor_paid`',
    `return_policy_version` STRING COMMENT 'Version identifier of the return policy that was in effect at the time of the original purchase, ensuring compliance with applicable terms.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for return (e.g., defect, wrong item, size exchange, buyer remorse, damaged in transit). [ENUM-REF-CANDIDATE: defect|wrong_item|size_exchange|buyer_remorse|damaged_in_transit|quality_issue|fit_issue|color_mismatch|late_delivery|duplicate_order|no_longer_needed — promote to reference product]',
    `return_reason_description` STRING COMMENT 'Free-text description providing additional detail about the return reason from the customer or service representative.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost of return shipping, which may be borne by customer, retailer, or supplier depending on return policy and reason.',
    `return_window_days` STRING COMMENT 'Number of days from original purchase date within which the return was allowed per policy.',
    `rma_number` STRING COMMENT 'Business-facing unique RMA number used for customer communication and tracking.. Valid values are `^RMA[0-9]{8,12}$`',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA: requested, approved, rejected, in transit, received at warehouse, inspected, completed, or cancelled. [ENUM-REF-CANDIDATE: requested|approved|rejected|in_transit|received|inspected|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was last modified.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Merchandise Authorization record managing the end-to-end returns and after-sales service process. Captures RMA number, originating order reference, return reason code (defect, wrong item, size exchange, buyer remorse), return channel (DTC, store, wholesale RTV), return condition assessment, refund or exchange decision, credit memo reference, restocking eligibility flag, and RMA status. Supports both consumer returns and wholesale RTV processing per FTC and CPSC compliance requirements.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`rma_line` (
    `rma_line_id` BIGINT COMMENT 'Unique identifier for the RMA line item. Primary key for the RMA line entity.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Lot traceability and recall management: returned garments must be traced to their original dye lot or production batch for quality defect analysis, vendor chargebacks, and recall compliance. rma_line.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to production.lot. Business justification: Returned garments in apparel fashion are investigated against the originating production lot for defect root cause analysis and vendor chargebacks. rma_line.lot_number is a denormalized plain attribut',
    `rma_id` BIGINT COMMENT 'Reference to the parent RMA header under which this line item is grouped. Links this line to the overall return authorization.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the original sales order line item that this return corresponds to. Enables traceability back to the original purchase transaction.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: RMA disposition workflow requires linking returned items to product master for restocking decisions, vendor chargebacks, quality defect analysis, and inventory revaluation. The existing sku text col',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Vendor-defect RMA lines must be traced to the originating factory for quality defect root-cause analysis and corrective action plans. Apparel QA teams track defect rates at factory level to trigger re',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier who originally provided this SKU. Used for RTV processing and vendor chargeback claims.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RMA line record was first created in the system. Used for audit trail and processing time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount. Indicates the currency in which the refund will be processed.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to this line item on the original order. Used for accurate refund calculation and promotional analysis.',
    `disposition_action` STRING COMMENT 'The action to be taken with the returned merchandise. RESTOCK=return to sellable inventory, DESTROY=dispose of item, RTV=Return to Vendor, LIQUIDATE=sell through secondary channel, REPAIR=send for refurbishment, DONATE=charitable donation.. Valid values are `RESTOCK|DESTROY|RTV|LIQUIDATE|REPAIR|DONATE`',
    `inspection_date` DATE COMMENT 'Date when the physical inspection of the returned item was completed. Used for tracking processing time and SLA compliance.',
    `inspection_result` STRING COMMENT 'Result of the quality inspection performed on the returned item. PASS=item meets restocking criteria, FAIL=item does not meet criteria, PENDING=inspection in progress, NOT_INSPECTED=inspection not yet performed.. Valid values are `PASS|FAIL|PENDING|NOT_INSPECTED`',
    `line_number` STRING COMMENT 'Sequential line number within the RMA document. Used for ordering and referencing specific line items within the return authorization.',
    `line_refund_amount` DECIMAL(18,2) COMMENT 'Total refund amount for this line item, calculated as quantity returned multiplied by unit refund amount, minus any restocking fees or adjustments.',
    `line_status` STRING COMMENT 'Current processing status of this RMA line item. Tracks the line through the return workflow from receipt through final disposition and refund. [ENUM-REF-CANDIDATE: PENDING|RECEIVED|INSPECTED|APPROVED|REJECTED|REFUNDED|CLOSED — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-form text field for additional comments or special instructions related to this return line item. Used by customer service and warehouse staff.',
    `original_unit_price` DECIMAL(18,2) COMMENT 'The original unit price paid by the customer at the time of purchase. Used for refund calculation and variance analysis.',
    `quantity_returned` DECIMAL(18,2) COMMENT 'The number of units of this SKU being returned by the customer. Used for inventory reconciliation and refund calculation.',
    `receiving_bin_location` STRING COMMENT 'Specific bin or staging location within the warehouse where the returned item is physically stored pending disposition. Enables precise inventory tracking.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `refund_method` STRING COMMENT 'Method by which the refund will be issued to the customer. ORIGINAL_PAYMENT=refund to original payment method, STORE_CREDIT=issue store credit, GIFT_CARD=issue gift card, CHECK=mail check, BANK_TRANSFER=direct bank transfer.. Valid values are `ORIGINAL_PAYMENT|STORE_CREDIT|GIFT_CARD|CHECK|BANK_TRANSFER`',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Timestamp when the refund for this line item was successfully processed and issued to the customer. Used for SLA tracking and customer communication.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the return line item was rejected. Captures why the return was not accepted per return policy guidelines.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing the return, if applicable per return policy. Deducted from the total refund amount.',
    `return_condition` STRING COMMENT 'Physical condition of the returned merchandise as assessed during inspection. Determines disposition action and potential restocking eligibility.. Valid values are `NEW|USED|DAMAGED|DEFECTIVE|INCOMPLETE`',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why the customer is returning this item. Used for quality analysis, vendor chargebacks, and product improvement initiatives.. Valid values are `DEFECTIVE|WRONG_SIZE|WRONG_COLOR|DAMAGED|NOT_AS_DESCRIBED|CHANGED_MIND`',
    `serial_number` STRING COMMENT 'Unique serial number of the returned item, if applicable for serialized inventory. Enables individual unit tracking and warranty validation.. Valid values are `^[A-Z0-9]{8,30}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount to be refunded for this line item. Calculated based on applicable tax jurisdiction and original transaction tax treatment.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the returned quantity. EA=Each, PR=Pair, DZ=Dozen, CS=Case, BX=Box. Aligns with inventory and order management standards.. Valid values are `EA|PR|DZ|CS|BX`',
    `unit_refund_amount` DECIMAL(18,2) COMMENT 'The refund amount per unit for this SKU. May differ from original unit price due to promotions, discounts, or partial refund policies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this RMA line record was last modified. Used for audit trail and change tracking.',
    `vendor_rma_number` STRING COMMENT 'RMA number issued by the vendor for items being returned to vendor (RTV). Used for tracking vendor returns and processing vendor credits.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `warehouse_location_code` STRING COMMENT 'Code identifying the warehouse or distribution center where the returned item was received and inspected. Used for inventory tracking and logistics.. Valid values are `^[A-Z0-9]{3,10}$`',
    CONSTRAINT pk_rma_line PRIMARY KEY(`rma_line_id`)
) COMMENT 'Line-item detail for a Return Merchandise Authorization, capturing the specific SKU being returned, quantity returned, unit refund amount, return condition (new, damaged, defective), disposition action (restock, destroy, RTV to vendor), inspection result, and restocking fee if applicable. Enables granular tracking of returned merchandise at the SKU level and feeds inventory disposition workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`order_payment` (
    `order_payment_id` BIGINT COMMENT 'Unique identifier for the payment record. Primary key for the payment entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Payment application to AR invoice is a core accounts receivable process. Linking order_payment to ar_invoice enables cash reconciliation, DSO reporting, and payment application workflows — all standar',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to customer.payment_method. Business justification: Payment transactions use stored payment methods. Direct link enables payment instrument analysis, fraud pattern detection by method, and eliminates denormalized card fields for PCI compliance and data',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.rma. Business justification: Refund payments are generated as a result of approved RMAs. The order_payment table captures refund_amount and refund_date, and the rma table captures the return authorization. Linking order_payment.r',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order, POS transaction, or wholesale invoice that this payment is associated with. Links payment to the originating order transaction.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount of the payment transaction in the specified currency. Represents the gross payment value before any adjustments or fees.',
    `authorization_code` STRING COMMENT 'Authorization or approval code returned by the payment processor or issuing bank. Used for payment verification and reconciliation. Business-confidential transaction identifier.. Valid values are `^[A-Z0-9]{6,12}$`',
    `avs_response_code` STRING COMMENT 'Response code from Address Verification Service check. Indicates match status between billing address provided and address on file with card issuer. Used for fraud prevention.. Valid values are `^[A-Z0-9]{1,3}$`',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the payment method. Used for Address Verification Service (AVS) checks and fraud prevention.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (apartment, suite, unit number). Optional field for additional address details.',
    `billing_city` STRING COMMENT 'City or municipality of the billing address. Used for AVS verification and tax calculation.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address. Used for international payment processing and compliance.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal code or ZIP code of the billing address. Critical for AVS verification and fraud detection.',
    `billing_state_province` STRING COMMENT 'State, province, or region of the billing address. Used for AVS verification and tax jurisdiction determination.',
    `channel` STRING COMMENT 'Channel or interface through which the payment was initiated. Distinguishes between Direct-to-Consumer (DTC) digital channels, retail Point of Sale (POS), and wholesale Electronic Data Interchange (EDI) channels. [ENUM-REF-CANDIDATE: e_commerce|mobile_app|pos|call_center|edi|wholesale_portal|marketplace — 7 candidates stripped; promote to reference product]',
    `chargeback_date` DATE COMMENT 'Date when a chargeback was initiated by the cardholder or issuing bank. Null if no chargeback has occurred. Used for dispute management and financial reconciliation.',
    `chargeback_reason_code` STRING COMMENT 'Standardized reason code provided by card network for the chargeback. Used to categorize disputes and identify root causes for fraud prevention.. Valid values are `^[A-Z0-9]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Supports multi-currency transactions across global markets.. Valid values are `^[A-Z]{3}$`',
    `cvv_response_code` STRING COMMENT 'Response code from CVV/CVC verification check. Indicates whether the card security code provided matches the issuer records. Used for fraud prevention.. Valid values are `^[A-Z]{1}$`',
    `due_date` DATE COMMENT 'Date by which payment is due for net terms or trade credit transactions. Used for AR aging and collections management. Null for immediate payments.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this payment has been flagged as potentially fraudulent by automated systems or manual review. True if flagged, false otherwise.',
    `gateway_name` STRING COMMENT 'Name of the payment gateway or payment service provider that processed the transaction. Examples include Stripe, Adyen, PayPal, Authorize.Net, or internal payment systems.',
    `gateway_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment gateway or processor. Used for tracing payment through external systems and for dispute resolution.. Valid values are `^[A-Za-z0-9_-]{10,50}$`',
    `installment_number` STRING COMMENT 'Sequential number of this installment payment within the plan. For example, 1 for first payment, 2 for second payment. Null for non-installment payments.',
    `installment_plan_flag` BOOLEAN COMMENT 'Indicates whether this payment is part of an installment or Buy Now Pay Later (BNPL) plan. True if installment plan is active, false otherwise.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net amount received after deducting processing fees and adjustments. Represents actual funds deposited to merchant account.',
    `payment_date` DATE COMMENT 'Date when the payment transaction was initiated or authorized. Represents the business event date for the payment.',
    `payment_method` STRING COMMENT 'Payment instrument or method used by the customer or wholesale account. Includes digital wallets, card payments, trade credit instruments, and Buy Now Pay Later (BNPL) options. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|gift_card|store_credit|net_terms|letter_of_credit|factoring|bnpl|wire_transfer|ach|cash|check — 15 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks progression from authorization through settlement or failure states including dispute and chargeback scenarios. [ENUM-REF-CANDIDATE: authorized|captured|settled|refunded|partially_refunded|failed|declined|voided|disputed|chargeback|pending — 11 candidates stripped; promote to reference product]',
    `payment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment transaction was initiated or authorized. Includes timezone information for accurate cross-region reconciliation.',
    `processing_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the payment processor or gateway for this transaction. Used for Cost of Goods Sold (COGS) calculation and profitability analysis.',
    `reference_number` STRING COMMENT 'Externally visible unique payment reference number or transaction identifier used for customer communication and reconciliation. Generated by payment gateway or internal system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the customer for this payment. Null if no refund has been issued. May be partial or full refund of the original payment amount.',
    `refund_date` DATE COMMENT 'Date when the refund was processed. Null if no refund has been issued. Used for returns processing and customer service tracking.',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by payment gateway or internal fraud detection system. Higher scores indicate higher risk. Used for fraud prevention and order review workflows.',
    `settlement_date` DATE COMMENT 'Date when the payment was settled and funds were transferred to the merchant account. May differ from payment date due to processing delays.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment was settled. Used for cash flow analysis and reconciliation with bank statements.',
    `terms` STRING COMMENT 'Payment terms for wholesale or trade accounts. Examples include Net 30, Net 60, 2/10 Net 30. Null for immediate DTC payments. Used for Accounts Receivable (AR) aging and credit management.',
    `total_installments` STRING COMMENT 'Total number of installments in the payment plan. Used to calculate payment schedule and remaining balance. Null for non-installment payments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_order_payment PRIMARY KEY(`order_payment_id`)
) COMMENT 'Payment record associated with a sales order, POS transaction, or wholesale invoice, capturing payment method (credit card, PayPal, Apple Pay, gift card, store credit, net terms, letter of credit, factoring), payment amount, currency, authorization code, payment gateway reference, payment status (authorized, captured, settled, refunded, failed, disputed), payment date, settlement date, and installment/BNPL plan details if applicable. Covers DTC digital payments via Salesforce Commerce Cloud, wholesale net-terms and LC payments via SAP FI/AR, and POS tender types. Supports payment reconciliation, chargeback management, and AR aging for wholesale accounts.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'Primary key for allocation_rule',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Apparel allocation rules are formally configured per customer segment (VIP, loyalty tier, wholesale tier) to prioritize inventory for high-value segments. Formalizing customer_tier_filter as a proper ',
    `fallback_allocation_rule_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule (fallback_allocation_rule_id)',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: allocation_rule.product_category_filter is a plain text denormalization of merchandise_hierarchy. Allocation rules in apparel are scoped to hierarchy levels (e.g., all denim bottoms). Linking to merch',
    `size_curve_id` BIGINT COMMENT 'Foreign key linking to merchandising.size_curve. Business justification: Apparel allocation rules use size curves to determine how inventory units are distributed across sizes. Linking allocation_rule to size_curve enables size-level allocation accuracy reporting and allow',
    `allocation_basis` STRING COMMENT 'The foundational metric or data source used to drive allocation decisions (inventory levels, demand signals, capacity constraints, historical sales, forecast, manual override).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of available inventory or capacity to allocate when using proportional allocation logic (0.00 to 100.00).',
    `allocation_scope` STRING COMMENT 'The organizational or geographic scope to which this allocation rule applies (global, regional, country-level, channel-specific, store-level, warehouse, customer segment).',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether allocations generated by this rule require manual approval before execution (true = approval required, false = auto-execute).',
    `backorder_handling` STRING COMMENT 'Defines how this allocation rule handles backorder scenarios (allow backorders, prevent backorders, allow partial backorders).',
    `channel_filter` STRING COMMENT 'Sales channel(s) to which this allocation rule applies (Direct-to-Consumer, wholesale, retail stores, e-commerce, marketplace, or all channels).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation rule record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this allocation rule expires and is no longer applied. Null indicates rule is open-ended.',
    `effective_start_date` DATE COMMENT 'Date when this allocation rule becomes active and begins to be applied in allocation processing.',
    `execution_frequency` STRING COMMENT 'Frequency at which this allocation rule is scheduled to execute (real-time, hourly, daily, weekly, on-demand).',
    `external_rule_code` STRING COMMENT 'Identifier for this allocation rule in the source system of record, used for integration and reconciliation.',
    `geographic_region_filter` STRING COMMENT 'Geographic region(s) to which this allocation rule applies. Null indicates rule applies globally.',
    `last_execution_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation rule was last executed in an allocation run.',
    `maximum_allocation_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity cap that can be allocated under this rule. Used to prevent over-concentration of inventory.',
    `minimum_allocation_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity threshold that must be allocated when this rule is applied. Prevents fractional or uneconomical allocations.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified this allocation rule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation rule record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this allocation rule.',
    `override_allowed_flag` BOOLEAN COMMENT 'Indicates whether users are permitted to manually override allocations generated by this rule (true = overrides allowed, false = system-enforced).',
    `priority_level` STRING COMMENT 'Numeric priority ranking for rule execution when multiple rules apply (lower number = higher priority).',
    `rounding_method` STRING COMMENT 'Method for rounding fractional allocation quantities (round up, round down, round to nearest, or no rounding).',
    `rule_code` STRING COMMENT 'Business identifier code for the allocation rule, used for external reference and integration.',
    `rule_description` STRING COMMENT 'Detailed description of the allocation rule logic, business purpose, and application context.',
    `rule_name` STRING COMMENT 'Human-readable name of the allocation rule describing its purpose.',
    `rule_owner` STRING COMMENT 'Business owner or team responsible for maintaining and governing this allocation rule.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the allocation rule (active and in use, inactive, draft/pending approval, temporarily suspended, archived).',
    `rule_type` STRING COMMENT 'Classification of the allocation rule methodology (proportional distribution, priority-based, round-robin, geographic, channel-based, customer tier, product category).',
    `rule_version` STRING COMMENT 'Version number of this allocation rule, incremented with each modification to support change tracking and audit.',
    `safety_stock_reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of inventory to reserve as safety stock and exclude from allocation calculations (0.00 to 100.00).',
    `system_of_record` STRING COMMENT 'Source system where this allocation rule is defined and maintained (e.g., SAP S/4HANA, OMS, WMS).',
    `created_by` STRING COMMENT 'User or system identifier that created this allocation rule record.',
    CONSTRAINT pk_allocation_rule PRIMARY KEY(`allocation_rule_id`)
) COMMENT 'Master reference table for allocation_rule. Referenced by allocation_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation`(`allocation_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation`(`allocation_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `apparel_fashion_ecm`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_rma_sales_order_id` FOREIGN KEY (`rma_sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ADD CONSTRAINT `fk_order_allocation_rule_fallback_allocation_rule_id` FOREIGN KEY (`fallback_allocation_rule_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation_rule`(`allocation_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,35}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Product Division');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|partially_fulfilled|fully_fulfilled|blocked');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Is Gift Order');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'ecommerce|retail_pos|wholesale_edi|call_center|mobile_app|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_value_regex' = 'sap_s4hana_sd|salesforce_commerce_cloud|sap_car|oracle_retail|other');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_time` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|pre_order|backorder|sample|return');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Tier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'standard|high|vip|rush|backorder');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Order Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `price_master_id` SET TAGS ('dbx_business_glossary_term' = 'Price Master Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `atp_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Confirmed Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `cancel_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `confirmed_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `imu_percentage` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup (IMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `imu_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `line_subtotal` SET TAGS ('dbx_business_glossary_term' = 'Line Subtotal Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'ecommerce|pos|edi|call_center|mobile_app|wholesale');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `quantity_backordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Backordered');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `quantity_cancelled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Cancelled');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `quantity_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Confirmed');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `quantity_shipped` SET TAGS ('dbx_business_glossary_term' = 'Quantity Shipped');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|PR|DZ|CS|PK');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_returns');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `buy_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Plan Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `capacity_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Profile Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `delivery_window_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `division_id` SET TAGS ('dbx_business_glossary_term' = 'Division Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `primary_order_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Production Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `routing_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `edi_acknowledgment_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Acknowledgment Received Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `edi_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `fob_terms` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Terms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `lc_reference` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Reference');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `lc_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `moq_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `otif_target_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'replenishment|wholesale|drop_ship|demand_driven|consignment|sample');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|critical');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `replenishment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `replenishment_trigger` SET TAGS ('dbx_value_regex' = 'reorder_point|wos_target|vmi_signal|manual|forecast_driven|promotion');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `total_landed_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Landed Cost');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` SET TAGS ('dbx_subdomain' = 'purchase_returns');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `order_purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `rfq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Line Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `sourcing_purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Line Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `vendor_cost_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost Quote Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CNY|JPY|INR');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `line_category` SET TAGS ('dbx_business_glossary_term' = 'Line Category');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `line_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|stock_transfer');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `line_notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|short|partial');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `asn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `asn_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `pack_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Complete Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `pick_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Complete Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_business_glossary_term' = 'Ship To Email Address');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_name` SET TAGS ('dbx_business_glossary_term' = 'Ship To Name');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Ship To Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `shipping_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `shipping_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `total_cartons` SET TAGS ('dbx_business_glossary_term' = 'Total Cartons');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Cubic Meters');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reservation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocated_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocated_quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|PCS|PAIR|SET|BOX|CASE');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^ALLOC-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|partially_fulfilled|fulfilled|cancelled|expired');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `atp_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Confirmation Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `atp_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Confirmation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `ats_at_allocation` SET TAGS ('dbx_business_glossary_term' = 'Available to Sell (ATS) at Allocation');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'VIP|premium|standard|wholesale|employee');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `fulfilled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `preorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Preorder Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_location_type` SET TAGS ('dbx_business_glossary_term' = 'Source Location Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_location_type` SET TAGS ('dbx_value_regex' = 'DC|warehouse|store|3PL|vendor|cross_dock');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source System');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_SD|Oracle_RMS|Salesforce_Commerce|Manhattan_WMS|manual');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backorder_id` SET TAGS ('dbx_business_glossary_term' = 'Backorder Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backorder_substitute_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `actual_fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Fulfillment Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backorder_number` SET TAGS ('dbx_business_glossary_term' = 'Backorder Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backorder_number` SET TAGS ('dbx_value_regex' = '^BO-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backorder_status` SET TAGS ('dbx_business_glossary_term' = 'Backorder Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Backorder Creation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'vip|wholesale|retail|dtc|employee');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `days_on_backorder` SET TAGS ('dbx_business_glossary_term' = 'Days on Backorder');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `expected_fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Fulfillment Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `expected_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Replenishment Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `nos_flag` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|reminder_sent');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'ecommerce|wholesale_edi|retail_pos|call_center|mobile_app');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `original_requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Original Requested Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Backorder Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'stockout|production_delay|allocation_exhausted|supplier_delay|quality_hold|demand_spike');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Backorder Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'hold|cancel|substitute|split_shipment|upgrade');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|PR|DZ|CS|PK');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Backorder Creation Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'purchase_returns');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Return From Address Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'RMA Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'RMA Completed Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Return Disposition Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'refund|exchange|store_credit|repair|reject');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `quality_defect_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'RMA Received Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'RMA Requested Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `restocking_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Restocking Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_channel` SET TAGS ('dbx_business_glossary_term' = 'Return Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_channel` SET TAGS ('dbx_value_regex' = 'dtc_online|dtc_store|wholesale_rtv|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Return Condition Assessment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_condition` SET TAGS ('dbx_value_regex' = 'new_unused|opened_unused|lightly_used|damaged|defective|missing_parts');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_label_type` SET TAGS ('dbx_business_glossary_term' = 'Return Label Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_label_type` SET TAGS ('dbx_value_regex' = 'prepaid|customer_paid|vendor_paid');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Version');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` SET TAGS ('dbx_subdomain' = 'purchase_returns');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Line ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order Line ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'RESTOCK|DESTROY|RTV|LIQUIDATE|REPAIR|DONATE');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|PENDING|NOT_INSPECTED');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `line_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `original_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `receiving_bin_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Bin Location');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `receiving_bin_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'ORIGINAL_PAYMENT|STORE_CREDIT|GIFT_CARD|CHECK|BANK_TRANSFER');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Return Condition');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `return_condition` SET TAGS ('dbx_value_regex' = 'NEW|USED|DAMAGED|DEFECTIVE|INCOMPLETE');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'DEFECTIVE|WRONG_SIZE|WRONG_COLOR|DAMAGED|NOT_AS_DESCRIBED|CHANGED_MIND');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|PR|DZ|CS|BX');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `unit_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Unit Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `vendor_rma_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Return Merchandise Authorization (RMA) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `vendor_rma_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` SET TAGS ('dbx_subdomain' = 'purchase_returns');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `order_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Payment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service (AVS) Response Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `chargeback_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `chargeback_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `chargeback_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Response Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `gateway_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Name');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `gateway_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Transaction Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `gateway_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{10,50}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Installment Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `installment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Installment Plan Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Payment Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Installments');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ALTER COLUMN `fallback_allocation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ALTER COLUMN `size_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Size Curve Id (Foreign Key)');
