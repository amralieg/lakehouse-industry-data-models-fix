-- Schema for Domain: order | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`order` COMMENT 'Manages end-to-end order lifecycle from quote to fulfillment including sales orders, POs, backorders, allocations, and OTIF tracking. Handles DTC e-commerce orders, wholesale EDI orders, retail POS orders, and replenishment. Owns ATP, ATS, RMA processing, and order orchestration across SAP S/4HANA SD and Salesforce Commerce Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`sales_order` (
    `sales_order_id` BIGINT COMMENT 'Unique identifier for the sales order record. Primary key for the sales order entity.',
    `address_id` BIGINT COMMENT 'Reference to the billing address for this order. Links to customer address master. Used for invoicing and payment processing.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Orders frequently originate from marketing campaigns. Direct link enables ROAS calculation, CAC analysis, campaign performance measurement, and marketing attribution reporting—core analytics for appar',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Wholesale/B2B pre-orders during market weeks reference design concepts before full production. Buyers place line buys against concept presentations. Critical for pre-season order tracking and concept-',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: B2B orders are placed by specific contacts at wholesale accounts. Captures ordering contact for account management, sales commission tracking, and contact-level purchasing behavior analysis in wholesa',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or associate who assisted with the order. Applicable for retail POS (Point of Sale), call center, and wholesale orders. Null for self-service e-commerce orders.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Sales orders drive scope 3 category 9 (downstream transportation) emissions reporting. ESG reports aggregate order-level carbon data for CDP, GRI, and TCFD disclosures. Apparel brands report sold-prod',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Orders may be involved in compliance incidents (restricted party screening hits, export control violations, sanctioned country shipments). Audit trail for regulatory investigations and OFAC/BIS compli',
    `payment_method_id` BIGINT COMMENT 'Reference to the payment method used for this order. Links to customer payment method master for credit card, bank transfer, or other payment instruments.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed this sales order. Links to the customer master record for DTC (Direct-to-Consumer) orders.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Export orders require regulatory filings for customs clearance, export licenses, and product safety certifications. Critical for international trade compliance and shipment authorization in apparel-fa',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Sales orders are executed within seasonal merchandise cycles. Essential for seasonal sales performance reporting, assortment planning validation, and aligning order fulfillment with seasonal delivery ',
    `shipping_address_id` BIGINT COMMENT 'Reference to the shipping address for order delivery. Links to customer address master. Used for fulfillment and logistics planning.',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: Export orders require trade compliance screening for ITAR/EAR controls, OFAC sanctioned parties, and customs classification. Regulatory mandate for international shipments preventing illegal exports a',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this order. Links to warehouse location master. Determined by inventory availability and shipping address proximity.',
    `wholesale_account_id` BIGINT COMMENT 'Reference to the wholesale account for B2B orders. Null for DTC (Direct-to-Consumer) orders. Links to wholesale account master for wholesale EDI (Electronic Data Interchange) orders.',
    `carrier_code` STRING COMMENT 'Code identifying the logistics carrier assigned to deliver this order. Examples include UPS, FedEx, DHL, USPS, or 3PL (Third-Party Logistics) provider codes.. Valid values are `^[A-Z0-9]{2,10}$`',
    `confirmed_delivery_date` DATE COMMENT 'System-confirmed delivery date based on ATP (Available to Promise) and logistics capacity. May differ from requested date due to inventory or capacity constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales order record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order transaction. All monetary amounts in this order are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customer-provided purchase order number for wholesale and B2B orders. Required for EDI (Electronic Data Interchange) orders and accounts payable matching. Null for DTC (Direct-to-Consumer) orders.. Valid values are `^[A-Z0-9-]{1,35}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order, including promotional discounts, markdown (MD) adjustments, and customer-specific pricing. Reduces the subtotal amount.',
    `distribution_channel` STRING COMMENT 'Distribution channel classification for the order. Retail includes owned stores, wholesale includes B2B accounts, e-commerce is DTC (Direct-to-Consumer) online, outlet is off-price stores, franchise is partner-operated stores.. Valid values are `retail|wholesale|ecommerce|outlet|franchise`',
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
    `promotion_code` STRING COMMENT 'Promotional code or coupon code applied to the order. Used for marketing campaign tracking and discount attribution.. Valid values are `^[A-Z0-9]{4,20}$`',
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
    `environmental_impact_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_impact. Business justification: Line-level product LCA data enables customer-facing carbon labels, scope 3 category 11 (use of sold products) calculations, and product environmental passport compliance (EU Digital Product Passport).',
    `ftc_label_id` BIGINT COMMENT 'Foreign key linking to compliance.ftc_label. Business justification: Order lines must reference correct FTC-compliant labeling for shipped SKUs. Federal Trade Commission Textile and Wool Acts require accurate fiber content, care instructions, and country of origin on c',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Order lines must verify SKU safety test compliance before fulfillment. CPSC and consumer product safety regulations require documented testing for childrens apparel, flammability standards, and chemi',
    `promotion_id` BIGINT COMMENT 'Reference to the specific promotion or marketing campaign that generated the discount on this line. Enables promotional ROI analysis.',
    `sales_order_id` BIGINT COMMENT 'Reference to the parent sales order header. Links this line item to its containing order.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment or delivery document that contains this line item. Links order line to physical shipment execution.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU representing the style, colorway, and size combination ordered on this line.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which this line item will be fulfilled. Drives allocation and fulfillment routing.',
    `actual_ship_date` DATE COMMENT 'The actual date on which this line item was shipped to the customer. Used for OTIF (On Time In Full) performance measurement.',
    `allocation_id` BIGINT COMMENT 'Reference to the inventory allocation record that reserved stock for this line item. Links order line to allocation planning.',
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
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: PO-level upstream transportation emissions (scope 3 category 4: upstream transportation and distribution) tracked for supplier carbon accounting, OTIF carbon intensity metrics, and modal shift decisio',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the receiving warehouse, distribution center, or store where goods will be delivered. Used for inventory allocation and receiving planning.',
    `employee_id` BIGINT COMMENT 'Reference to the legal entity or business unit placing the purchase order. May represent corporate headquarters, regional office, or individual store depending on procurement model.',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Purchase orders are planned and tracked by merchandise hierarchy (division/department/class). Essential for category-level procurement reporting, compliance with category budgets, and merchandise plan',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Purchase orders consume open-to-buy budget. Fundamental to OTB management, budget tracking, and preventing over-commitment. Merchandisers must track PO value against available OTB by category and peri',
    `primary_order_warehouse_location_id` BIGINT COMMENT 'Reference to the vendor facility or origin location from which goods will ship. Used for logistics planning and landed cost calculation.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Import purchase orders require regulatory filings for customs entry, import permits, and textile quota documentation. Mandatory for international sourcing compliance and customs clearance in apparel i',
    `season_id` BIGINT COMMENT 'Reference to the merchandising season or collection for which goods are being purchased. Used for assortment planning and markdown management. Nullable for non-seasonal or replenishment orders.',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: Import POs require trade compliance validation for HS code classification, duty rates, country of origin determination, and trade agreement eligibility. Customs clearance and landed cost calculation d',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor fulfilling this purchase order. Links to supplier master data.',
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
    `vendor_contact_email` STRING COMMENT 'Email address of the primary vendor contact for this purchase order. Business-confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the primary vendor contact person for this purchase order. Used for order coordination and issue resolution.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this purchase order record. Audit trail for accountability.',
    CONSTRAINT pk_order_purchase_order PRIMARY KEY(`order_purchase_order_id`)
) COMMENT 'Purchase orders issued for replenishment (NOS restocking, VMI, min-max), wholesale buying, and drop-ship fulfillment. Captures PO number, buyer entity, vendor/supplier reference, PO type (replenishment, wholesale, drop-ship, demand-driven), FOB terms, LC reference, MOQ compliance flag, total PO value, currency, incoterms, expected delivery date, replenishment trigger (reorder point, WOS target), source/destination locations, and PO status. Sourced from SAP S/4HANA MM and supports OTIF tracking for inbound goods flow. Consolidates all inbound demand order types into a single entity differentiated by PO type.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` (
    `order_purchase_order_line_id` BIGINT COMMENT 'Primary key for purchase_order_line',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Line-level buyer assignment enables split PO responsibilities across categories/vendors; critical for workload distribution, commission calculation, and vendor relationship management. Buyer_name is d',
    `ftc_label_id` BIGINT COMMENT 'Foreign key linking to compliance.ftc_label. Business justification: PO lines must specify required FTC labeling for sourced products. Procurement specification ensuring vendors produce goods with compliant fiber content, care, and origin labeling per FTC regulations.',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: PO lines require certification validation (GOTS, GRS, OEKO-TEX, BCI) for regulatory compliance, brand standards, and customer claims. Apparel sourcing teams verify certifications at PO line level befo',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line to the overall PO document.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: PO lines require safety test validation before goods receipt. Quality assurance gate ensuring purchased products meet safety standards (lead testing, flammability, restricted substances) before wareho',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility producing this line item. Links to factory master for capacity planning and compliance tracking.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU being ordered. Links to the product master for material details.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: PO lines specify sustainable material requirements (recycled content, organic certification) for sourcing compliance, brand sustainability commitments, and product labeling. Apparel brands track susta',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor providing this line item. May differ from factory if using a trading company or agent.',
    `actual_delivery_date` DATE COMMENT 'Actual date when goods were delivered to the warehouse or DC. Used for OTIF (On Time In Full) performance measurement.',
    `confirmed_delivery_date` DATE COMMENT 'Delivery date confirmed by the supplier. May differ from requested date due to production lead times or capacity constraints.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the supplier via order acknowledgment or EDI 855. May differ from ordered quantity due to capacity or material constraints.',
    `cost_center` STRING COMMENT 'Cost center to which this line item expense is allocated. Used for internal cost accounting and departmental budgeting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the goods are manufactured. Required for customs compliance and trade preference programs (GSP, FTA). [ENUM-REF-CANDIDATE: USA|CHN|IND|VNM|BGD|TUR|MEX|IDN|PAK|KHM — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order line was first created in the system. Used for audit trail and order processing analytics.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Indicates the currency in which the supplier invoice will be denominated.. Valid values are `USD|EUR|GBP|CNY|JPY|INR`',
    `gl_account_code` STRING COMMENT 'General ledger account to which this line item cost will be posted. Used for financial accounting and COGS tracking.. Valid values are `^[0-9]{4,10}$`',
    `hs_code` STRING COMMENT 'International tariff classification code for the material. Required for customs clearance and duty calculation. 6-10 digit code per WCO standards.. Valid values are `^[0-9]{6,10}$`',
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
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Shipment-level emissions (scope 3 category 9) calculated per fulfillment for carbon-neutral shipping programs, customer carbon receipts, and carrier carbon intensity benchmarking. Apparel brands offer',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Warehouse pickers execute order picking; essential for labor productivity tracking, pick accuracy metrics, quality control, and performance-based compensation in DC operations. Role-prefixed to distin',
    `sales_order_id` BIGINT COMMENT 'Reference to the parent sales order being fulfilled. Links this fulfillment record to the originating order.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the specific order line item being fulfilled. Nullable for header-level fulfillments.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Fulfillment executes physical shipment of orders. Links fulfillment records to logistics_shipment for OTIF tracking, carrier performance analysis, and delivery confirmation workflows. Essential for or',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center location from which the order was fulfilled.',
    `actual_delivery_date` DATE COMMENT 'Actual date the shipment was delivered to the customer. Used to measure OTIF (On Time In Full) performance and service level compliance.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment was delivered to the customer, including time zone. Captured from carrier proof of delivery.',
    `asn_reference_number` STRING COMMENT 'EDI 856 ASN document reference number sent to wholesale buyers notifying them of inbound shipment details.. Valid values are `^[A-Z0-9]{8,30}$`',
    `carrier_code` STRING COMMENT 'Code identifying the shipping carrier or third-party logistics provider assigned to transport the shipment.. Valid values are `^[A-Z0-9]{2,10}$`',
    `carrier_name` STRING COMMENT 'Full business name of the shipping carrier or 3PL (Third-Party Logistics) provider handling the shipment.',
    `carrier_service_level` STRING COMMENT 'Specific service tier provided by the carrier such as ground, two-day, overnight, or international express.',
    `channel` STRING COMMENT 'Source location or method used to fulfill the order. Indicates whether fulfilled from distribution center, retail store, or third-party.. Valid values are `dc|store|drop_ship|3pl|vendor_direct`',
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
    `ship_to_address_line1` STRING COMMENT 'Primary street address line for the shipment delivery destination.',
    `ship_to_address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number at the delivery destination.',
    `ship_to_city` STRING COMMENT 'City name for the shipment delivery destination.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipment delivery destination.. Valid values are `^[A-Z]{3}$`',
    `ship_to_email_address` STRING COMMENT 'Email address for the delivery recipient. Used for shipment tracking notifications and delivery confirmations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ship_to_name` STRING COMMENT 'Name of the recipient or delivery contact for this shipment. May differ from the ordering customer for gift orders.',
    `ship_to_phone_number` STRING COMMENT 'Contact phone number for the delivery recipient. Used by carrier for delivery coordination and customer notification.',
    `ship_to_postal_code` STRING COMMENT 'Postal or ZIP code for the shipment delivery destination.',
    `ship_to_state_province` STRING COMMENT 'State, province, or region for the shipment delivery destination.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that created the allocation.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific lot or batch of inventory allocated, supporting traceability and FEFO logic.',
    `nos_policy_id` BIGINT COMMENT 'Reference to the NOS replenishment policy applied to this allocation for critical SKUs.',
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
    `channel` STRING COMMENT 'The sales channel for which this allocation is made (Direct-to-Consumer, wholesale, retail store, e-commerce).. Valid values are `DTC|wholesale|retail|e_commerce|marketplace|B2B`',
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
    `reservation_id` BIGINT COMMENT 'Reference to the inventory reservation record that preceded or accompanies this allocation.',
    `source_location_type` STRING COMMENT 'Classification of the source location from which inventory is allocated.. Valid values are `DC|warehouse|store|3PL|vendor|cross_dock`',
    `source_system` STRING COMMENT 'The source system or module that originated this allocation record.. Valid values are `SAP_SD|Oracle_RMS|Salesforce_Commerce|Manhattan_WMS|manual`',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'Records the inventory allocation decisions made against sales order lines, capturing allocated SKU, allocated quantity, allocation source location (DC, store, 3PL), allocation date, ATS at time of allocation, ATP confirmation, allocation method (FIFO, priority, channel-based), and allocation status. Supports OTB-driven allocation strategies and NOS replenishment logic. Owned by the order domain as the bridge between demand and available inventory.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`backorder` (
    `backorder_id` BIGINT COMMENT 'Unique identifier for the backorder record. Primary key.',
    `allocation_rule_id` BIGINT COMMENT 'Reference to the allocation rule that was applied when the backorder was created, if applicable.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (style-color-size combination) that is backordered.',
    `backorder_substitute_sku_id` BIGINT COMMENT 'Reference to an alternative SKU offered or accepted as a substitute for the backordered item, if applicable.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Air freight expediting for backorders creates carbon hotspots (5-10x higher emissions than ocean freight). Tracking enables scope 3 category 4 emissions management, modal shift decisions, and backorde',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed the original order containing this backorder.',
    `replenishment_order_id` BIGINT COMMENT 'Reference to the replenishment order or purchase order that will supply inventory to fulfill this backorder, if linked.',
    `sales_order_id` BIGINT COMMENT 'Reference to the parent sales order that generated this backorder.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the specific sales order line item that could not be fulfilled and resulted in this backorder.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center responsible for fulfilling this backorder.',
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
    `season_code` STRING COMMENT 'The merchandise season or collection to which the backordered SKU belongs (e.g., SS24, FW24).',
    `size_code` STRING COMMENT 'The size code of the backordered SKU.',
    `sla_target_days` STRING COMMENT 'The number of days within which the backorder should be fulfilled per the customer service SLA.',
    `style_code` STRING COMMENT 'The style code of the backordered product for quick reference and reporting.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the backordered quantity (EA=Each, PR=Pair, DZ=Dozen, CS=Case, PK=Pack).. Valid values are `EA|PR|DZ|CS|PK`',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the backordered SKU at the time of the original order.',
    `creation_date` DATE COMMENT 'The date when the backorder was created, typically when the order line could not be allocated.',
    CONSTRAINT pk_backorder PRIMARY KEY(`backorder_id`)
) COMMENT 'Captures unfulfilled demand when a sales order line cannot be immediately allocated due to insufficient ATS or ATP. Tracks original order line reference, backordered SKU (style/color/size), backordered quantity, backorder creation date, expected replenishment date, reason code (stockout, production delay, allocation exhausted), priority tier based on customer segment, notification status, and resolution action (cancel, substitute, hold for next drop). Triggers WOS-based replenishment and supports customer service SLA management for apparel seasonal and NOS programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Unique identifier for the return merchandise authorization record.',
    `circular_enrollment_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_enrollment. Business justification: Returns feed circular economy programs (take-back, resale, recycling). RMA disposition (resell, recycle, landfill diversion) drives circular program enrollment and material recovery metrics. Apparel b',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Product returns may trigger compliance incidents requiring regulatory reporting (safety defects, labeling violations, restricted substances). CPSC recall procedures and consumer safety incident tracki',
    `profile_id` BIGINT COMMENT 'Reference to the customer initiating the return.',
    `return_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.return_shipment. Business justification: RMA authorizes customer return, return_shipment executes physical reverse logistics movement. Critical link for returns processing workflow, tracking return receipt against authorization, and reconcil',
    `employee_id` BIGINT COMMENT 'Reference to the customer service representative who processed the RMA request.',
    `rma_employee_id` BIGINT COMMENT 'Reference to the warehouse employee or quality control inspector who assessed the returned merchandise condition.',
    `sales_order_id` BIGINT COMMENT 'Reference to the new order created if the disposition type is exchange.',
    `rma_sales_order_id` BIGINT COMMENT 'Reference to the originating sales order that this RMA is associated with.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer, relevant for wholesale RTV processing and vendor chargebacks.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where the returned merchandise was received.',
    `approved_date` DATE COMMENT 'Date when the RMA was approved by customer service or automated system.',
    `completed_date` DATE COMMENT 'Date when the RMA process was fully completed including refund, exchange, or credit issuance.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the RMA complies with FTC and CPSC requirements for consumer returns and product safety standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was first created in the system.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued in the financial system for this return.',
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
    `return_shipping_carrier` STRING COMMENT 'Name of the shipping carrier used to return the merchandise (e.g., UPS, FedEx, USPS, DHL).',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost of return shipping, which may be borne by customer, retailer, or supplier depending on return policy and reason.',
    `return_tracking_number` STRING COMMENT 'Tracking number provided by the carrier for the return shipment.',
    `return_window_days` STRING COMMENT 'Number of days from original purchase date within which the return was allowed per policy.',
    `rma_number` STRING COMMENT 'Business-facing unique RMA number used for customer communication and tracking.. Valid values are `^RMA[0-9]{8,12}$`',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA: requested, approved, rejected, in transit, received at warehouse, inspected, completed, or cancelled. [ENUM-REF-CANDIDATE: requested|approved|rejected|in_transit|received|inspected|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was last modified.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Merchandise Authorization record managing the end-to-end returns and after-sales service process. Captures RMA number, originating order reference, return reason code (defect, wrong item, size exchange, buyer remorse), return channel (DTC, store, wholesale RTV), return condition assessment, refund or exchange decision, credit memo reference, restocking eligibility flag, and RMA status. Supports both consumer returns and wholesale RTV processing per FTC and CPSC compliance requirements.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`rma_line` (
    `rma_line_id` BIGINT COMMENT 'Unique identifier for the RMA line item. Primary key for the RMA line entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse associate or quality inspector who performed the inspection. Used for accountability and quality audit trails.',
    `rma_id` BIGINT COMMENT 'Reference to the parent RMA header under which this line item is grouped. Links this line to the overall return authorization.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the original sales order line item that this return corresponds to. Enables traceability back to the original purchase transaction.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: RMA disposition workflow requires linking returned items to product master for restocking decisions, vendor chargebacks, quality defect analysis, and inventory revaluation. The existing sku text col',
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
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the returned item, if applicable. Used for quality traceability and vendor chargeback documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
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

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` (
    `edi_transaction_id` BIGINT COMMENT 'Unique identifier for the EDI transaction record. Primary key.',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: Links EDI transaction messages (850 PO inbound from wholesale partners, 856 ASN inbound) to the purchase order they reference. Nullable FK populated based on document_type and direction. String column',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: EDI exceptions and validation failures require manual intervention; tracking resolution ownership is critical for SLA compliance, chargeback dispute resolution, and trading partner relationship manage',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to order.sales_order. Business justification: Links EDI transaction messages (810 Invoice, 856 ASN outbound) to the sales order they reference. Eliminates silo for edi_transaction. Nullable FK populated based on document_type. String column purch',
    `agreement_id` BIGINT COMMENT 'Reference to the trading partner agreement or vendor routing guide that governs this EDI transaction. Ensures compliance with retailer-specific requirements (e.g., Nordstrom, Macys routing guides).',
    `trading_partner_id` BIGINT COMMENT 'Identifier of the wholesale trading partner (retailer, distributor, or vendor) involved in this EDI transaction.',
    `asn_number` STRING COMMENT 'Shipment identification number for 856 ASN document type. Links EDI transaction to shipment record.',
    `chargeback_risk_flag` BOOLEAN COMMENT 'Indicates whether this transaction has potential chargeback risk due to late transmission, missing data, or non-compliance with trading partner requirements.',
    `communication_protocol` STRING COMMENT 'Protocol used to transmit or receive the EDI message. Common values: AS2 (Applicability Statement 2), SFTP (Secure File Transfer Protocol), FTP, VAN (Value-Added Network), API, HTTPS.. Valid values are `AS2|SFTP|FTP|VAN|API|HTTPS`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this EDI transaction record was first created in the data platform.',
    `direction` STRING COMMENT 'Indicates whether the EDI message was received (inbound) or sent (outbound) by the business.. Valid values are `inbound|outbound`',
    `document_type` STRING COMMENT 'ANSI X12 transaction set identifier. Common values: 850 (Purchase Order), 855 (PO Acknowledgment), 856 (Advance Ship Notice), 810 (Invoice), 860 (PO Change Request), 846 (Inventory Inquiry/Advice), 997 (Functional Acknowledgment), 940 (Warehouse Shipping Order), 945 (Warehouse Shipping Advice), 753 (Request for Routing Instructions). [ENUM-REF-CANDIDATE: 850|855|856|810|860|846|997|940|945|753 — 10 candidates stripped; promote to reference product]',
    `edi_standard_version` STRING COMMENT 'Version of the ANSI X12 standard used for this transaction (e.g., 004010, 005010). From ISA12 element.',
    `error_code` STRING COMMENT 'Standard error or rejection code when validation or processing fails. May reference ANSI X12 997 acknowledgment codes or custom trading partner error codes.',
    `error_description` STRING COMMENT 'Human-readable description of the error or rejection reason. Provides context for troubleshooting failed EDI transactions.',
    `file_name` STRING COMMENT 'Name of the EDI file as received or sent. Used for file-based EDI transmission tracking and troubleshooting.',
    `functional_ack_status` STRING COMMENT 'Status of the ANSI X12 997 Functional Acknowledgment for this transaction. Tracks whether acknowledgment was sent (for inbound) or received (for outbound).. Valid values are `not_required|pending|sent|received|accepted|rejected`',
    `functional_ack_timestamp` TIMESTAMP COMMENT 'Date and time when the 997 Functional Acknowledgment was sent or received for this transaction.',
    `functional_group_control_number` STRING COMMENT 'Control number for the functional group (GS segment) containing this transaction set. Groups related transaction sets together.',
    `integration_batch_code` STRING COMMENT 'Identifier of the integration batch or job that processed this EDI transaction into downstream operational systems.',
    `interchange_control_number` STRING COMMENT 'Unique control number for the entire EDI interchange envelope per ANSI X12 ISA segment. Ensures end-to-end traceability.',
    `invoice_number` STRING COMMENT 'Invoice number for 810 Invoice document type. Links EDI transaction to billing record.',
    `payload_size_bytes` BIGINT COMMENT 'Size of the EDI message payload in bytes. Used for transmission monitoring and capacity planning.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when the EDI transaction was successfully processed and integrated into operational systems.',
    `processing_status` STRING COMMENT 'Current processing state of the EDI transaction. Tracks lifecycle from receipt through validation, acknowledgment, and integration into operational systems. [ENUM-REF-CANDIDATE: received|validated|accepted|rejected|processed|error|pending_ack — 7 candidates stripped; promote to reference product]',
    `purchase_order_number` STRING COMMENT 'Trading partner purchase order number referenced in this EDI transaction. Applicable for 850, 855, 856, 810, 860 document types. Links EDI transaction to business order.',
    `receiver_code` STRING COMMENT 'Unique identifier of the EDI message receiver. Format depends on receiver_qualifier. From ANSI X12 ISA08.',
    `receiver_qualifier` STRING COMMENT 'Qualifier identifying the type of receiver ID (e.g., 01=DUNS, 12=Phone, 14=UPC, ZZ=Mutually Defined). From ANSI X12 ISA07.',
    `retry_count` STRING COMMENT 'Number of times transmission or processing of this EDI transaction was retried due to errors or failures.',
    `segment_count` STRING COMMENT 'Number of segments in the EDI transaction set. Used for validation and completeness checking per ANSI X12 SE01 element.',
    `sender_code` STRING COMMENT 'Unique identifier of the EDI message sender. Format depends on sender_qualifier (e.g., DUNS number, phone, custom ID). From ANSI X12 ISA06.',
    `sender_qualifier` STRING COMMENT 'Qualifier identifying the type of sender ID (e.g., 01=DUNS, 12=Phone, 14=UPC, ZZ=Mutually Defined). From ANSI X12 ISA05.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the EDI transaction was processed within the agreed SLA timeframe per trading partner agreement.',
    `source_system` STRING COMMENT 'Operational system that generated or received this EDI transaction (e.g., SAP S/4HANA SD, SPS Commerce, Oracle Retail, Salesforce Commerce Cloud).',
    `test_indicator` BOOLEAN COMMENT 'Indicates whether this is a test transaction (true) or production transaction (false). From ANSI X12 ISA15 element (T=Test, P=Production).',
    `transaction_set_control_number` STRING COMMENT 'Unique control number assigned to the transaction set within the functional group per ANSI X12 ST segment. Used for tracking and acknowledgment.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the EDI message was transmitted or received. Captured from ISA interchange date/time or system receipt timestamp.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this EDI transaction record was last modified.',
    `validation_status` STRING COMMENT 'Result of EDI syntax and business rule validation. Indicates whether the message conforms to ANSI X12 standards and trading partner-specific requirements.. Valid values are `passed|failed|warning|not_validated`',
    CONSTRAINT pk_edi_transaction PRIMARY KEY(`edi_transaction_id`)
) COMMENT 'Captures inbound and outbound EDI message transactions with wholesale trading partners per ANSI X12 standards. Includes document type (850 PO, 855 PO Ack, 856 ASN, 810 Invoice, 860 PO Change, 846 Inventory Inquiry, 997 Functional Ack), trading partner ID, transaction set control number, interchange control number, transmission timestamp, processing status, error/rejection codes, and functional acknowledgment status. Sourced from SAP EDI/ALE or SPS Commerce. Supports wholesale order automation, retailer compliance with vendor guides (e.g., Nordstrom, Macys routing guides), and chargeback avoidance through timely ASN transmission.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`order_payment` (
    `order_payment_id` BIGINT COMMENT 'Unique identifier for the payment record. Primary key for the payment entity.',
    `installment_plan_id` BIGINT COMMENT 'Reference identifier for the installment or BNPL plan if applicable. Links to external financing provider or internal installment program. Null for non-installment payments.. Valid values are `^[A-Z0-9]{8,20}$`',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to customer.payment_method. Business justification: Payment transactions use stored payment methods. Direct link enables payment instrument analysis, fraud pattern detection by method, and eliminates denormalized card fields for PCI compliance and data',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Manual payment processing (refunds, exceptions, installment adjustments) requires employee accountability for fraud prevention, SOX compliance, audit trails, and segregation of duties in financial ope',
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

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`otif_metric` (
    `otif_metric_id` BIGINT COMMENT 'Primary key for otif_metric',
    `profile_id` BIGINT COMMENT 'Reference to the customer or wholesale account receiving the order. Used for customer-specific OTIF scorecard reporting.',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order, purchase order, or shipment being measured for OTIF compliance. Links to the order management system record.',
    `shipment_id` BIGINT COMMENT 'Reference to the specific shipment or delivery being measured. Links to warehouse management or logistics system.',
    `third_party_logistics_id` BIGINT COMMENT 'Reference to the 3PL or logistics service provider responsible for fulfillment. Used for 3PL SLA management and performance tracking.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: OTIF measurement for inbound purchase orders requires tracking vendor on-time/in-full performance. Currently tracks _3pl_partner_id for outbound; adding vendor_id enables inbound supplier OTIF scoreca',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the fulfillment center or distribution center that processed the order. Used for facility-level OTIF performance analysis.',
    `actual_delivery_date` DATE COMMENT 'The actual date the order was delivered to the customer or received at the destination. Used to calculate on-time performance.',
    `actual_ship_date` DATE COMMENT 'The actual date the order was shipped from the fulfillment center. Used for ship-date-based OTIF compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this OTIF record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units delivered to the customer. Used to calculate in-full compliance and fill rate.',
    `delivery_variance_days` STRING COMMENT 'The number of days between promised and actual delivery date. Negative values indicate early delivery, positive values indicate late delivery, zero indicates on-time.',
    `fill_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of ordered quantity that was delivered, calculated as (delivered_quantity / ordered_quantity) * 100. Measures in-full performance independent of timing.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the delivered quantity met or exceeded the ordered quantity within the acceptable tolerance. True=in full, False=short shipment.',
    `in_full_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable variance percentage for in-full compliance. For example, 5% tolerance means 95-105% of ordered quantity is considered in-full. Retailer-specific parameter.',
    `measurement_date` DATE COMMENT 'The date on which the OTIF record was calculated and recorded. Used for reporting period assignment and historical trend analysis.',
    `measurement_level` STRING COMMENT 'The granularity level at which OTIF is being measured: order (entire order), shipment (individual shipment), line_item (SKU-level), or po (purchase order level). Determines aggregation logic.. Valid values are `order|shipment|line_item|po`',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the order was delivered on or before the promised delivery date. True=on time, False=late.',
    `order_type` STRING COMMENT 'Classification of the order channel: DTC (Direct-to-Consumer e-commerce), wholesale (B2B EDI orders), retail_pos (store point-of-sale), replenishment (automated stock replenishment), or transfer (inter-facility transfer).. Valid values are `DTC|wholesale|retail_pos|replenishment|transfer`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The total quantity of units ordered by the customer. This is the baseline for in-full performance measurement.',
    `otif_compliant_flag` BOOLEAN COMMENT 'Composite boolean indicator of whether the order met BOTH on-time AND in-full criteria. True=OTIF compliant, False=OTIF failure. This is the primary KPI for retailer scorecards.',
    `otif_score` DECIMAL(18,2) COMMENT 'Numeric OTIF performance score expressed as a percentage (0.00 to 100.00). Calculated as the percentage of orders meeting both on-time and in-full criteria. Used for trend analysis and benchmarking.',
    `otif_threshold_percent` DECIMAL(18,2) COMMENT 'The retailer-specific or customer-specific OTIF compliance threshold percentage required for this order. Typically ranges from 85% to 98% depending on retailer SLA agreements.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The financial penalty or chargeback amount assessed by the retailer for OTIF non-compliance. Expressed in the order currency. Null if no penalty applied.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the penalty amount (e.g., USD, EUR, GBP). Null if no penalty applied.. Valid values are `^[A-Z]{3}$`',
    `penalty_flag` BOOLEAN COMMENT 'Boolean indicator of whether this OTIF failure triggered a financial penalty or chargeback from the retailer. True=penalty applied, False=no penalty.',
    `po_number` STRING COMMENT 'External purchase order number from the customer or retailer. Used for wholesale EDI orders and retailer compliance tracking.',
    `promised_delivery_date` DATE COMMENT 'The committed delivery date communicated to the customer or retailer. This is the baseline for on-time performance measurement.',
    `quantity_uom` STRING COMMENT 'Unit of measure for ordered and delivered quantities. EA=Each, CS=Case, PK=Pack, DZ=Dozen, PR=Pair. Standard apparel industry UOM codes.. Valid values are `EA|CS|PK|DZ|PR`',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between ordered and delivered quantity (delivered_quantity - ordered_quantity). Negative values indicate short shipment, positive values indicate over-shipment.',
    `reporting_period` STRING COMMENT 'The fiscal or calendar period (e.g., 2024-Q1, 2024-W15, 2024-03) to which this OTIF record is assigned for scorecard reporting. Format varies by retailer requirements.',
    `requested_ship_date` DATE COMMENT 'The date the customer or retailer requested the order to be shipped from the warehouse. Used for ship-date-based OTIF calculations.',
    `retailer_code` STRING COMMENT 'Standardized code identifying the wholesale retailer or distribution partner. Used for retailer-specific OTIF threshold application.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause for OTIF failure. Used for trend analysis and corrective action planning. Null if OTIF compliant. [ENUM-REF-CANDIDATE: warehouse_capacity|inventory_shortage|transportation_delay|system_error|supplier_delay|weather|other — 7 candidates stripped; promote to reference product]',
    `root_cause_notes` STRING COMMENT 'Free-text field capturing detailed explanation of the root cause for OTIF failure. Used for continuous improvement and dispute resolution. Null if OTIF compliant.',
    `sla_tier` STRING COMMENT 'The service level tier associated with this order, determining OTIF thresholds and penalty structures. Premium=highest standards, Economy=relaxed standards.. Valid values are `premium|standard|economy`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this OTIF record was last modified. Used for audit trail and change tracking, particularly for dispute resolution.',
    CONSTRAINT pk_otif_metric PRIMARY KEY(`otif_metric_id`)
) COMMENT 'OTIF (On Time In Full) compliance record tracking delivery performance at the order, shipment, or PO level against committed SLAs. Captures order or PO reference, promised delivery date, actual delivery date, ordered quantity, delivered quantity, on-time flag, in-full flag, OTIF composite score, penalty flag, and retailer-specific OTIF threshold. Supports wholesale retailer compliance scorecards and 3PL SLA management.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`order_hold` (
    `order_hold_id` BIGINT COMMENT 'Unique identifier for the order hold record. Primary key.',
    `employee_id` BIGINT COMMENT 'User ID of the person who manually placed the hold, if applicable. Empty for system-generated holds.',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order on which this hold is placed. Links to the sales order transaction in SAP S/4HANA SD.',
    `tertiary_order_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified this hold record. Used for audit trail and change tracking.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether explicit management approval is required to release this hold (true) or if it can be auto-released by system rules (false).',
    `approver_role` STRING COMMENT 'Business role or job function authorized to approve release of this hold type. Examples include CREDIT_MANAGER, FRAUD_ANALYST, COMPLIANCE_OFFICER, WAREHOUSE_SUPERVISOR.',
    `auto_release_eligible_flag` BOOLEAN COMMENT 'Indicates whether this hold is eligible for automatic release by system rules when conditions are met (true) or requires manual intervention (false).',
    `blocked_delivery_date` DATE COMMENT 'Originally scheduled delivery date that is now at risk due to this hold. Used to assess customer impact and On Time In Full (OTIF) risk.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division responsible for managing this hold. Used for organizational reporting and accountability.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was first created in the system. Used for audit trail and data lineage.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified about the order hold and potential delivery delay.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer notification was sent regarding the hold. Null if no notification has been sent.',
    `distribution_channel_code` STRING COMMENT 'SAP distribution channel code for the order. Examples include Direct-to-Consumer (DTC), wholesale, e-commerce, retail store.. Valid values are `^[A-Z0-9]{2}$`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Calculated duration in hours that the hold was active, from placement to release. Used for Service Level Agreement (SLA) compliance reporting and process improvement analysis.',
    `escalation_level` STRING COMMENT 'Number of times this hold has been escalated to higher approval authority. Zero indicates no escalation; higher numbers indicate multiple escalation tiers.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was most recently escalated to a higher approval level. Null if never escalated.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the hold will automatically expire if not resolved. Some hold types have time-based expiration rules.',
    `external_hold_reference` STRING COMMENT 'External reference identifier from third-party systems such as fraud detection services, credit bureaus, or compliance platforms.',
    `hold_category` STRING COMMENT 'High-level business category grouping similar hold types for reporting and analytics. Enables trend analysis across hold categories.. Valid values are `financial|operational|regulatory|quality|customer_service`',
    `hold_code` STRING COMMENT 'System-assigned code identifying the specific hold type in SAP SD. Examples include ZCRD (credit hold), ZFRAUD (fraud review), ZINV (inventory shortage), ZCOMP (compliance review), ZADDR (address verification).. Valid values are `^[A-Z0-9]{2,10}$`',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold. Active holds prevent order progression; released holds allow fulfillment to continue.. Valid values are `active|released|expired|overridden|escalated`',
    `hold_type` STRING COMMENT 'Business classification of the hold reason. Determines the workflow and approval authority required for release. [ENUM-REF-CANDIDATE: credit_hold|fraud_review|inventory_shortage|compliance_review|address_verification|payment_verification|export_control|quality_hold — 8 candidates stripped; promote to reference product]',
    `impact_amount` DECIMAL(18,2) COMMENT 'Total order value in base currency that is blocked by this hold. Used for financial impact analysis and prioritization.',
    `impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the hold impact amount.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was last updated. Tracks the most recent change to any field in the record.',
    `placed_by_system_flag` BOOLEAN COMMENT 'Indicates whether the hold was automatically triggered by system rules (true) or manually applied by a user (false).',
    `placed_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was applied to the sales order. Critical for Service Level Agreement (SLA) tracking and On Time In Full (OTIF) performance measurement.',
    `priority` STRING COMMENT 'Business priority level assigned to the hold. Critical holds require immediate attention and executive approval for release.. Valid values are `critical|high|medium|low`',
    `reason_code` STRING COMMENT 'Detailed reason code explaining why the hold was applied. Provides granular classification for reporting and root cause analysis.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `reason_description` STRING COMMENT 'Free-text description providing additional context about why the hold was placed. May include system-generated messages or user-entered notes.',
    `related_document_number` STRING COMMENT 'Reference number of related business document that triggered or is associated with the hold. Examples include credit memo number, Return Merchandise Authorization (RMA) number, compliance case ID.',
    `release_notes` STRING COMMENT 'Free-text notes entered by the user who released the hold, documenting the resolution or approval rationale.',
    `release_reason_code` STRING COMMENT 'Code indicating the reason the hold was released. Examples include APPROVED, RESOLVED, OVERRIDE, EXPIRED, CANCELLED.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `released_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was released, allowing the order to proceed through fulfillment. Null for active holds.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the hold review process. Determines whether the order proceeds, is cancelled, or requires further action.. Valid values are `approved|rejected|cancelled|auto_resolved|escalated|expired`',
    `sales_organization_code` STRING COMMENT 'SAP sales organization code associated with the order under hold. Determines approval workflow and business rules.. Valid values are `^[A-Z0-9]{4}$`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the hold duration exceeded the defined Service Level Agreement (SLA) threshold for this hold type. Impacts On Time In Full (OTIF) metrics.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target resolution time in hours defined for this hold type. Used to calculate Service Level Agreement (SLA) compliance.',
    `source_system` STRING COMMENT 'Name of the system or module that originated the hold. Examples include SAP_SD, FRAUD_ENGINE, CREDIT_MGMT, COMPLIANCE_SYSTEM.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record where this hold was originally created. Examples include SAP_S4, SFCC, OMS.. Valid values are `^[A-Z0-9_]{2,20}$`',
    CONSTRAINT pk_order_hold PRIMARY KEY(`order_hold_id`)
) COMMENT 'Records holds placed on sales orders that prevent progression through the fulfillment workflow. Captures hold type (credit hold, fraud review, inventory shortage, compliance review, address verification), hold reason, hold placed by (user or system), hold placed timestamp, hold released timestamp, release reason, and hold resolution outcome. Supports order orchestration and exception management workflows in SAP SD.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique identifier for the wholesale quote record. Primary key.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Wholesale quote preparation targets specific buyer contacts at accounts. Eliminates denormalized contact fields, enables contact-level quote tracking and sales performance analysis by contact relation',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Wholesale quotes generated during line reviews/market appointments reference specific design concepts. Buyers request pricing against concept boards before committing to orders. Essential for B2B sell',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for this wholesale quote and buyer relationship.',
    `previous_quote_id` BIGINT COMMENT 'Reference to the prior version of this quote if it has been revised. Enables revision history tracking and audit trail.',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order created from this quote upon buyer confirmation. Links quote to the resulting firm order for traceability.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Wholesale quotes incorporate sustainability commitments (carbon-neutral delivery, sustainable packaging, minimum recycled content). Sustainability targets drive quote configuration and pricing for app',
    `wholesale_account_id` BIGINT COMMENT 'Reference to the wholesale buyer account receiving this quote. Links to the wholesale account master data.',
    `revised_quote_id` BIGINT COMMENT 'Self-referencing FK on quote (revised_quote_id)',
    `buyer_approval_date` DATE COMMENT 'Date when the wholesale buyer approved or rejected the quote. Key milestone in the pre-season booking cycle.',
    `buyer_approval_notes` STRING COMMENT 'Comments or conditions provided by the buyer regarding their approval decision. Captures negotiation details and special requests.',
    `buyer_approval_status` STRING COMMENT 'Wholesale buyer decision status on the quote. Tracks whether the buyer has accepted, rejected, or conditionally approved the quoted assortment.. Valid values are `pending|approved|rejected|conditional`',
    `conversion_date` DATE COMMENT 'Date when the quote was converted to a confirmed sales order. Marks the transition from pipeline to committed revenue.',
    `converted_to_order_flag` BOOLEAN COMMENT 'Indicates whether this quote has been converted to a confirmed sales order. True when the quote transitions to a firm Electronic Data Interchange (EDI) 850 purchase order.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quote record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the quote. Critical for international wholesale operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_window_end_date` DATE COMMENT 'Latest date in the delivery window for the quoted seasonal merchandise. Defines the fulfillment timeframe for the wholesale order.',
    `delivery_window_start_date` DATE COMMENT 'Earliest date in the delivery window for the quoted seasonal merchandise. Part of the Time and Action (TNA) calendar critical to apparel wholesale.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the quote for volume commitments, early booking incentives, or promotional programs.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the quote subtotal. Common in wholesale for early season commitments and volume tiers.',
    `distribution_channel_code` STRING COMMENT 'Code identifying the distribution channel for this quote, such as wholesale, specialty retail, or department store channel.',
    `division_code` STRING COMMENT 'Code identifying the product division or business unit for this quote, such as mens, womens, or childrens apparel.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Estimated freight and shipping charges for the quoted merchandise based on incoterms and delivery terms.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities for shipping, insurance, and customs. Standard in global apparel wholesale.',
    `market_event_date` DATE COMMENT 'Date of the market week or trade show event associated with this quote. Used for tracking seasonal booking cycles.',
    `market_event_name` STRING COMMENT 'Name of the market week or trade show event where this quote was presented to the buyer. Examples include MAGIC Las Vegas, Coterie New York.',
    `notes` STRING COMMENT 'Free-form notes and comments about the quote, including special terms, buyer requests, or internal sales team observations.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for the quote, such as Net 30, Net 60, or Letter of Credit (LC) requirements for international orders.',
    `pricing_basis` STRING COMMENT 'Pricing method used for the quote. Free On Board (FOB) is standard in apparel wholesale; Landed Duty Paid (LDP) includes all import costs.. Valid values are `fob|wholesale_cost|landed_duty_paid|ex_works`',
    `quote_date` DATE COMMENT 'Date when the quote was created and presented to the wholesale buyer. Principal business event timestamp for the quote lifecycle.',
    `quote_number` STRING COMMENT 'Business-facing unique quote number used in communications with wholesale buyers during market week and trade shows. Externally visible identifier.',
    `quote_status` STRING COMMENT 'Current lifecycle status of the quote in the pre-season booking workflow. Tracks progression from draft through buyer approval to order conversion. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|expired|converted — 7 candidates stripped; promote to reference product]',
    `quote_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the quote was generated, including time zone information for global wholesale operations.',
    `quote_type` STRING COMMENT 'Classification of the quote based on the business context and sales channel. Distinguishes seasonal wholesale bookings from special orders.. Valid values are `seasonal_booking|market_week|trade_show|special_order|reorder`',
    `revision_number` STRING COMMENT 'Sequential version number tracking quote revisions during buyer negotiations. Increments with each modification to quantities, pricing, or terms.',
    `sales_organization_code` STRING COMMENT 'Code identifying the sales organization unit responsible for this quote. Part of the SAP organizational structure for wholesale operations.',
    `season_code` STRING COMMENT 'Seasonal collection identifier for which this quote is being prepared. Critical for apparel wholesale where buyers commit to seasonal assortments 4-6 months in advance.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total quoted value before discounts, taxes, and freight charges. Sum of all line item extended amounts at preliminary wholesale pricing.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax amount for the quote based on buyer location and applicable tax jurisdictions.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total quoted value including all discounts, taxes, and freight. Final amount the buyer would commit to if the quote is accepted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this quote record was last modified. Audit trail for tracking changes during negotiations and revisions.',
    `validity_end_date` DATE COMMENT 'Date after which the quote expires and pricing is no longer guaranteed. Critical for managing seasonal booking windows.',
    `validity_start_date` DATE COMMENT 'Date from which the quote pricing and terms become valid. Defines the beginning of the quote acceptance window.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Pre-order quotation or proforma record for wholesale seasonal booking, capturing buyer interest during market week and trade shows before conversion to confirmed sales orders. Tracks quote number, wholesale account reference, season/delivery window, quoted styles and quantities, preliminary pricing (FOB/wholesale cost), quote revision history, validity period, buyer approval status, and conversion-to-order flag. Supports the 4-6 month pre-season booking cycle critical to apparel wholesale where buyers commit to seasonal assortments that later convert to firm EDI 850 purchase orders. Enables pipeline visibility, production planning inputs, and seasonal revenue forecasting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'Primary key for allocation_rule',
    `fallback_allocation_rule_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule (fallback_allocation_rule_id)',
    `allocation_basis` STRING COMMENT 'The foundational metric or data source used to drive allocation decisions (inventory levels, demand signals, capacity constraints, historical sales, forecast, manual override).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of available inventory or capacity to allocate when using proportional allocation logic (0.00 to 100.00).',
    `allocation_scope` STRING COMMENT 'The organizational or geographic scope to which this allocation rule applies (global, regional, country-level, channel-specific, store-level, warehouse, customer segment).',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether allocations generated by this rule require manual approval before execution (true = approval required, false = auto-execute).',
    `backorder_handling` STRING COMMENT 'Defines how this allocation rule handles backorder scenarios (allow backorders, prevent backorders, allow partial backorders).',
    `channel_filter` STRING COMMENT 'Sales channel(s) to which this allocation rule applies (Direct-to-Consumer, wholesale, retail stores, e-commerce, marketplace, or all channels).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation rule record was first created in the system.',
    `customer_tier_filter` STRING COMMENT 'Customer tier or segment classification to which this allocation rule applies. Null indicates rule applies to all tiers.',
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
    `product_category_filter` STRING COMMENT 'Product category or categories to which this allocation rule applies. Null indicates rule applies to all categories.',
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

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`trading_partner` (
    `trading_partner_id` BIGINT COMMENT 'Primary key for trading_partner',
    `parent_trading_partner_id` BIGINT COMMENT 'Self-referencing FK on trading_partner (parent_trading_partner_id)',
    `account_manager_name` STRING COMMENT 'Name of the internal account manager responsible for this trading partner relationship.',
    `address_line1` STRING COMMENT 'First line of the trading partners primary business address including street number and name.',
    `address_line2` STRING COMMENT 'Second line of the trading partners address for suite, building, or additional location details.',
    `city` STRING COMMENT 'City or municipality of the trading partners primary business location.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether the trading partner has provided required compliance certifications (e.g., social compliance, environmental standards).',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the trading partners primary business location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the trading partner record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the trading partner for outstanding orders and invoices.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for transactions with this trading partner.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business entity identification.',
    `edi_capability_flag` BOOLEAN COMMENT 'Indicates whether the trading partner has EDI integration capability for automated order processing.',
    `edi_identifier` STRING COMMENT 'Unique EDI identifier or interchange ID used to route electronic transactions to the trading partner.',
    `edi_standard` STRING COMMENT 'The EDI messaging standard used by the trading partner for electronic transactions.',
    `gln` STRING COMMENT 'GS1 standard 13-digit identifier for physical locations and legal entities used in EDI and supply chain transactions.',
    `incoterm` STRING COMMENT 'Standard Incoterms code defining delivery responsibilities and risk transfer for shipments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the trading partner record was last updated in the system.',
    `last_order_date` DATE COMMENT 'Date of the most recent order placed with or by this trading partner.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from order placement to expected delivery for this trading partner.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity required for orders placed with or by this trading partner.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or comments about the trading partner.',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage for on-time and in-full delivery performance agreed with the trading partner.',
    `partner_code` STRING COMMENT 'Externally-known unique business identifier for the trading partner used in EDI transactions and system integrations.',
    `partner_name` STRING COMMENT 'Full legal name of the trading partner organization.',
    `partner_status` STRING COMMENT 'Current lifecycle status of the trading partner relationship.',
    `partner_type` STRING COMMENT 'Classification of the trading partner based on their business relationship and role in the supply chain.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the trading partner (e.g., Net 30, Net 60, 2/10 Net 30).',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the trading partners primary business address.',
    `preferred_carrier` STRING COMMENT 'Name of the preferred shipping carrier for deliveries to this trading partner.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for order management and operational communications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the trading partner organization.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the trading partner business contact.',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with the trading partner was terminated or is scheduled to end.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with the trading partner was established.',
    `risk_rating` STRING COMMENT 'Business risk assessment rating for the trading partner based on credit, compliance, and operational factors.',
    `ship_to_location_count` STRING COMMENT 'Number of active ship-to locations associated with this trading partner.',
    `state_province` STRING COMMENT 'State, province, or region of the trading partners primary business location.',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the trading partner (e.g., EIN, VAT number).',
    CONSTRAINT pk_trading_partner PRIMARY KEY(`trading_partner_id`)
) COMMENT 'Master reference table for trading_partner. Referenced by trading_partner_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`order`.`installment_plan` (
    `installment_plan_id` BIGINT COMMENT 'Primary key for installment_plan',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order associated with this installment plan.',
    `payment_method_id` BIGINT COMMENT 'Reference to the default payment method used for automatic installment payments.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this installment plan.',
    `refinanced_installment_plan_id` BIGINT COMMENT 'Self-referencing FK on installment_plan (refinanced_installment_plan_id)',
    `activation_date` DATE COMMENT 'Date when the installment plan was activated and became effective.',
    `amount_outstanding` DECIMAL(18,2) COMMENT 'Remaining balance owed on the installment plan, including principal, interest, and fees.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount paid by the customer to date across all completed installments.',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for installments. True if auto-pay is active, false if manual payments required.',
    `cancellation_date` DATE COMMENT 'Date when the installment plan was cancelled before completion.',
    `completed_installments` STRING COMMENT 'Number of installment payments that have been successfully completed and received.',
    `completion_date` DATE COMMENT 'Date when all installment payments were completed and the plan was closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the installment plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the installment plan (e.g., USD, EUR, GBP).',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial down payment amount paid at plan origination, if applicable. Zero if no down payment required.',
    `down_payment_date` DATE COMMENT 'Date when the down payment was received, if applicable.',
    `early_payoff_allowed` BOOLEAN COMMENT 'Indicates whether the customer is permitted to pay off the remaining balance early without penalty. True if early payoff is allowed, false if restricted.',
    `early_payoff_penalty` DECIMAL(18,2) COMMENT 'Penalty fee charged if the customer pays off the installment plan before the scheduled final payment date. Zero if no penalty applies.',
    `final_payment_date` DATE COMMENT 'Scheduled date for the final installment payment, representing plan maturity.',
    `financing_partner` STRING COMMENT 'Name of the third-party financing partner or BNPL provider facilitating the installment plan (e.g., Affirm, Klarna, Afterpay). Null if financed internally.',
    `first_payment_date` DATE COMMENT 'Scheduled date for the first installment payment.',
    `grace_period_days` STRING COMMENT 'Number of days after the due date before a late fee is assessed or the payment is considered delinquent.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Standard amount due for each regular installment payment. Final payment may differ.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the installment plan, expressed as a decimal (e.g., 0.0599 for 5.99% APR). Zero for interest-free plans.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Standard late fee charged when an installment payment is not received within the grace period.',
    `missed_payments_count` STRING COMMENT 'Total number of installment payments that were missed or not received by the due date.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the installment plan record was last modified or updated.',
    `next_payment_date` DATE COMMENT 'Date when the next installment payment is due.',
    `notes` STRING COMMENT 'Free-text notes or comments about the installment plan, including special arrangements, customer requests, or internal annotations.',
    `partner_plan_code` STRING COMMENT 'External identifier assigned by the financing partner for this installment plan, used for reconciliation and partner API integration.',
    `payment_frequency` STRING COMMENT 'Frequency at which installment payments are scheduled: weekly, biweekly (every two weeks), monthly, quarterly, or custom interval.',
    `plan_number` STRING COMMENT 'Externally-visible unique business identifier for the installment plan, used in customer communications and billing statements.',
    `plan_type` STRING COMMENT 'Classification of the installment plan structure: equal installments (fixed periodic payments), deferred payment (single future payment), layaway (pay before delivery), buy now pay later (BNPL partner), or custom arrangement.',
    `principal_amount` DECIMAL(18,2) COMMENT 'Original principal amount financed through the installment plan, excluding interest and fees.',
    `remaining_installments` STRING COMMENT 'Number of installment payments still outstanding in the plan.',
    `installment_plan_status` STRING COMMENT 'Current lifecycle status of the installment plan: draft (not yet activated), active (payments in progress), suspended (temporarily paused), completed (all payments received), defaulted (missed payments), cancelled (terminated before completion).',
    `terms_accepted_timestamp` TIMESTAMP COMMENT 'Date and time when the customer accepted the installment plan terms and conditions.',
    `terms_version` STRING COMMENT 'Version identifier of the terms and conditions document accepted by the customer at plan origination.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount to be paid over the life of the installment plan, including principal, interest, and fees.',
    `total_fees` DECIMAL(18,2) COMMENT 'Total administrative, processing, or late fees associated with the installment plan.',
    `total_installments` STRING COMMENT 'Total number of scheduled installment payments in the plan.',
    `total_interest` DECIMAL(18,2) COMMENT 'Total interest charges to be paid over the life of the installment plan.',
    CONSTRAINT pk_installment_plan PRIMARY KEY(`installment_plan_id`)
) COMMENT 'Master reference table for installment_plan. Referenced by installment_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_rma_sales_order_id` FOREIGN KEY (`rma_sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ADD CONSTRAINT `fk_order_edi_transaction_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ADD CONSTRAINT `fk_order_edi_transaction_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ADD CONSTRAINT `fk_order_edi_transaction_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `apparel_fashion_ecm`.`order`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_installment_plan_id` FOREIGN KEY (`installment_plan_id`) REFERENCES `apparel_fashion_ecm`.`order`.`installment_plan`(`installment_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ADD CONSTRAINT `fk_order_otif_metric_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_previous_quote_id` FOREIGN KEY (`previous_quote_id`) REFERENCES `apparel_fashion_ecm`.`order`.`quote`(`quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_revised_quote_id` FOREIGN KEY (`revised_quote_id`) REFERENCES `apparel_fashion_ecm`.`order`.`quote`(`quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ADD CONSTRAINT `fk_order_allocation_rule_fallback_allocation_rule_id` FOREIGN KEY (`fallback_allocation_rule_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ADD CONSTRAINT `fk_order_trading_partner_parent_trading_partner_id` FOREIGN KEY (`parent_trading_partner_id`) REFERENCES `apparel_fashion_ecm`.`order`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` ADD CONSTRAINT `fk_order_installment_plan_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` ADD CONSTRAINT `fk_order_installment_plan_refinanced_installment_plan_id` FOREIGN KEY (`refinanced_installment_plan_id`) REFERENCES `apparel_fashion_ecm`.`order`.`installment_plan`(`installment_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` SET TAGS ('dbx_subdomain' = 'sales_execution');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|outlet|franchise');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` SET TAGS ('dbx_subdomain' = 'sales_execution');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Ftc Label Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier (ID)');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_management');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Entity ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `primary_order_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` SET TAGS ('dbx_subdomain' = 'procurement_management');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `order_purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Ftc Label Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CNY|JPY|INR');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Picker Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `asn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `asn_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'dc|store|drop_ship|3pl|vendor_direct');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship To City');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship To Country Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship To Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship To State or Province');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `nos_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Policy Identifier (ID)');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'DTC|wholesale|retail|e_commerce|marketplace|B2B');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reservation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_location_type` SET TAGS ('dbx_business_glossary_term' = 'Source Location Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_location_type` SET TAGS ('dbx_value_regex' = 'DC|warehouse|store|3PL|vendor|cross_dock');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source System');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_SD|Oracle_RMS|Salesforce_Commerce|Manhattan_WMS|manual');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backorder_id` SET TAGS ('dbx_business_glossary_term' = 'Backorder Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `backorder_substitute_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `style_code` SET TAGS ('dbx_business_glossary_term' = 'Style Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|PR|DZ|CS|PK');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Backorder Creation Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'returns_processing');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `circular_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Enrollment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Representative ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector User ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'RMA Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'RMA Completed Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Carrier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` SET TAGS ('dbx_subdomain' = 'returns_processing');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Line ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order Line ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` SET TAGS ('dbx_subdomain' = 'procurement_management');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `edi_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice (ASN) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `chargeback_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Risk Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'AS2|SFTP|FTP|VAN|API|HTTPS');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Transaction Direction');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'EDI Document Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `edi_standard_version` SET TAGS ('dbx_business_glossary_term' = 'EDI Standard Version');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'EDI File Name');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `functional_ack_status` SET TAGS ('dbx_business_glossary_term' = 'Functional Acknowledgment (997) Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `functional_ack_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|sent|received|accepted|rejected');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `functional_ack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Functional Acknowledgment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `functional_group_control_number` SET TAGS ('dbx_business_glossary_term' = 'Functional Group Control Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `integration_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Integration Batch ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Payload Size in Bytes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Receiver Interchange ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `receiver_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Receiver Interchange ID Qualifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `segment_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Count');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `sender_code` SET TAGS ('dbx_business_glossary_term' = 'Sender Interchange ID');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `sender_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Sender Interchange ID Qualifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `test_indicator` SET TAGS ('dbx_business_glossary_term' = 'Test Indicator');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Control Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` SET TAGS ('dbx_subdomain' = 'sales_execution');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `order_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Payment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `installment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Installment Plan Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `installment_plan_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `otif_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Otif Metric Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `delivery_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Variance Days');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `in_full_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'In Full Tolerance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `measurement_level` SET TAGS ('dbx_business_glossary_term' = 'Measurement Level');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `measurement_level` SET TAGS ('dbx_value_regex' = 'order|shipment|line_item|po');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'DTC|wholesale|retail_pos|replenishment|transfer');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `otif_score` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Score');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `otif_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Threshold Percentage');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|CS|PK|DZ|PR');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `retailer_code` SET TAGS ('dbx_business_glossary_term' = 'Retailer Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `root_cause_notes` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|economy');
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` SET TAGS ('dbx_subdomain' = 'sales_execution');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `order_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Order Hold Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `tertiary_order_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `tertiary_order_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `tertiary_order_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `auto_release_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Release Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `blocked_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Blocked Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Duration Hours');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `external_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'External Hold Reference');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_business_glossary_term' = 'Hold Category');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_value_regex' = 'financial|operational|regulatory|quality|customer_service');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `hold_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|overridden|escalated');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Impact Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Impact Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `placed_by_system_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed By System Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `related_document_number` SET TAGS ('dbx_business_glossary_term' = 'Related Document Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `release_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `release_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Outcome');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|cancelled|auto_resolved|escalated|expired');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Hold Source System');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` SET TAGS ('dbx_subdomain' = 'sales_execution');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `previous_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Quote Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `revised_quote_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `buyer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Buyer Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `buyer_approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Buyer Approval Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `buyer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Buyer Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `buyer_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `converted_to_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Converted to Order Flag');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `delivery_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `delivery_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `market_event_date` SET TAGS ('dbx_business_glossary_term' = 'Market Event Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `market_event_name` SET TAGS ('dbx_business_glossary_term' = 'Market Event Name');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'fob|wholesale_cost|landed_duty_paid|ex_works');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `quote_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'seasonal_booking|market_week|trade_show|special_order|reorder');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Subtotal Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ALTER COLUMN `fallback_allocation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` SET TAGS ('dbx_subdomain' = 'procurement_management');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `parent_trading_partner_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`trading_partner` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` SET TAGS ('dbx_subdomain' = 'returns_processing');
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` ALTER COLUMN `installment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Installment Plan Identifier');
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` ALTER COLUMN `refinanced_installment_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
