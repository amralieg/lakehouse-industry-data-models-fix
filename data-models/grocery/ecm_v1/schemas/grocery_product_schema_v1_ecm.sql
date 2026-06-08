-- Schema for Domain: product | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`product` COMMENT 'Authoritative catalog of all sellable items including CPG products, private-label brands, fresh produce, pharmacy drug items, and fuel grades. Manages SKU, UPC, GTIN, PLU codes, product hierarchies, categories, attributes, nutritional information, and regulatory compliance flags. Supports planogram design, category management, and FDA labeling requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_header` (
    `order_header_id` BIGINT COMMENT 'Unique surrogate identifier for every customer purchase record across all channels (POS, online, click-and-collect, curbside pickup, last-mile delivery, pharmacy Rx fills). Primary key of the order_header entity and the single canonical identity for all customer transactions in the enterprise.',
    `associate_id` BIGINT COMMENT 'Reference to the workforce associate (cashier) who processed the POS transaction. Applicable only for in_store_pos channel type. Used for cashier performance reporting, void/return authorization auditing, and labor analytics. Null for self-checkout, online, and OMS orders.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost center assignment enables internal cost allocation and budgeting reports per order, a standard practice in grocery chains.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Links each order to its fiscal period, enabling period‑based financial statements and variance analysis.',
    `fiscal_week_fiscal_period_id` BIGINT COMMENT 'Reference to the retail fiscal calendar week in which this order was placed. Enables alignment of sales reporting to the 4-5-4 retail fiscal calendar used for comp sales (comparable store sales) and same-store sales analysis. Derived from order_date at ingestion.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue GL account needed for GAAP sales reporting; each order must post revenue to a specific GL account, obvious to finance analysts.',
    `household_id` BIGINT COMMENT 'Reference to the customer household entity for household-level purchase analytics, loyalty program household linking, and targeted promotions. Enables household basket analysis and CLTV (Customer Lifetime Value) calculations at the household level. Null for anonymous transactions.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Identifies the corporate legal entity owning the store for consolidation and regulatory reporting.',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: REQUIRED: Loyalty reporting needs to tie each order to the shoppers membership to calculate points earned, tier changes, and generate the Points Earned per Order report.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: Order‑level reference to the tokenized payment method allows reporting of payment method usage per order and supports refunds to the original method.',
    `order_channel_id` BIGINT COMMENT 'Foreign key linking to order.order_channel. Business justification: Orders belong to a channel; replace the free‑text channel_type with a foreign key to order_channel for referential integrity and channel‑level analytics.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Business process: Org‑unit performance reporting requires linking each order to the responsible org unit for labor and cost allocation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center linkage supports profitability analysis by store/region; required for P&L statements per profit center.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Required for Marketing ROI report linking each order to its originating campaign; replaces denormalized promo_code.',
    `rx_patient_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_patient. Business justification: Orders containing prescriptions must be associated with the patient to satisfy HIPAA, claim reconciliation, and loyalty program integration.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer/shopper who placed or completed this order. Nullable for anonymous in-store POS transactions where no loyalty card was scanned and no account was identified.',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Required for cluster‑level sales performance reporting; each order must be attributed to its store cluster for weekly KPI dashboards.',
    `store_location_id` BIGINT COMMENT 'Reference to the physical store or fulfillment location where the order originated or was fulfilled. Links to the store master for store-level reporting, comp sales, and same-store sales analysis.',
    `age_verification_required` BOOLEAN COMMENT 'Indicates whether the order contains age-restricted items (alcohol, tobacco, lottery tickets, certain medications) requiring cashier or delivery driver age verification at point of sale or delivery. Triggers age-check workflow in NCR POS or last-mile delivery confirmation.',
    `bag_fee_amount` DECIMAL(18,2) COMMENT 'Total fee charged for single-use plastic or paper bags per applicable state and local bag fee ordinances. Required for regulatory compliance reporting in jurisdictions with mandatory bag fee laws (e.g., California, Illinois). Zero in jurisdictions without bag fee requirements.',
    `basket_item_count` STRING COMMENT 'Total number of distinct line items (SKUs) in the order basket. Used for basket size analytics, express lane eligibility (e.g., 15 items or fewer), and customer segmentation. Distinct from total unit quantity which counts individual units across all line items.',
    `cancellation_reason` STRING COMMENT 'Reason code explaining why the order was cancelled. Populated only when order_status = cancelled. Used for cancellation root-cause analysis, OOS (Out of Stock) reporting, and fraud detection. Values: customer_request, out_of_stock, payment_failure, fraud_hold, store_closure, system_error.. Valid values are `customer_request|out_of_stock|payment_failure|fraud_hold|store_closure|system_error`',
    `change_due_amount` DECIMAL(18,2) COMMENT 'Amount of cash change to be returned to the customer when cash tender exceeds the order total. Applicable only for in-store POS and self-checkout cash transactions. Null for non-cash or digital orders. Sourced from NCR POS cash management module.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order_header record was first written to the Silver layer data lakehouse. Distinct from order_timestamp (business event time) — this is the data capture audit timestamp used for data lineage, pipeline monitoring, and late-arriving data detection.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this order. Defaults to USD for domestic US grocery operations. Required for multi-currency support in international or border-region store operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for last-mile delivery service. Applicable for online_delivery channel orders. May be zero for fee-waived orders (e.g., loyalty member benefit, promotional free delivery). Null for in-store POS, click-and-collect, and curbside pickup orders.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all discounts applied to the order, including promotional discounts (TPR — Temporary Price Reduction), loyalty discounts, coupon redemptions, and BOGO (Buy One Get One) savings. Stored as a positive value representing the reduction from subtotal.',
    `ebt_snap_wic_used` BOOLEAN COMMENT 'Indicates whether any government assistance program tender (EBT — Electronic Benefits Transfer, SNAP — Supplemental Nutrition Assistance Program, or WIC — Women Infants and Children) was used in this transaction. Required for USDA SNAP/WIC program compliance reporting and retailer authorization audits.',
    `fulfillment_date` DATE COMMENT 'Scheduled or actual date on which the order is to be fulfilled — delivered to the customer, made available for pickup, or dispensed (for pharmacy Rx). Used for delivery slot management, SLA tracking, and fulfillment capacity planning. Null for immediate in-store POS transactions.',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the order was actually fulfilled — delivered, picked up by the customer, or dispensed. Used for on-time delivery rate (OTD) measurement, last-mile delivery (LMD) SLA compliance, and customer experience analytics. Null until fulfillment is confirmed.',
    `loyalty_card_scanned` BOOLEAN COMMENT 'Indicates whether a customer loyalty card or loyalty account was identified and scanned/linked at the time of the transaction. True enables loyalty points accrual and personalized offer redemption. False indicates an anonymous transaction with no loyalty attribution.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty reward points earned by the customer on this transaction based on the applicable loyalty program earning rules. Zero for anonymous transactions (loyalty_card_scanned = false) or transactions where no points were awarded (e.g., fuel-only purchases).',
    `oms_order_reference` STRING COMMENT 'External order reference number assigned by the OMS (Order Management System — Salesforce Commerce Cloud) for omnichannel orders. Enables cross-system order tracing between the Silver layer canonical model and the OMS source system. Null for pure in-store POS transactions not routed through OMS.',
    `order_date` DATE COMMENT 'Calendar date on which the order was placed or the POS transaction was initiated. Used for daily sales reporting, comp sales (comparable store sales), same-store sales analysis, and fiscal period alignment.',
    `order_number` STRING COMMENT 'Externally visible, human-readable order reference number presented to the customer on receipts, confirmation emails, and order tracking pages. Generated by the source system (NCR POS transaction number, Salesforce Commerce Cloud order number, or McKesson Rx order number). Unique within the source system.',
    `order_status` STRING COMMENT 'Current lifecycle state of the order. Tracks the order from initial placement through fulfillment to completion or cancellation. POS transactions typically transition directly to a terminal state (completed or voided). OMS-originated orders traverse the full lifecycle. Values: placed, confirmed, in_fulfillment, ready, dispatched, delivered, cancelled. [ENUM-REF-CANDIDATE: placed|confirmed|in_fulfillment|ready|dispatched|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `order_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the order was placed or the POS transaction was opened. The principal real-world business event timestamp. Used for intraday sales analytics, peak-hour staffing analysis, and order SLA measurement. Stored in ISO 8601 format with timezone offset.',
    `payment_method` STRING COMMENT 'Primary payment instrument used to tender the order. For split-tender transactions, reflects the dominant or first payment method. Full tender breakdown is captured in the order_payment child entity. Values include EBT/SNAP for government assistance program transactions. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|ebt_snap|ebt_cash|gift_card|loyalty_points|mobile_pay|check — promote to reference product]',
    `pharmacy_rx_flag` BOOLEAN COMMENT 'Indicates whether this order contains one or more pharmacy prescription (Rx) line items. When true, the order is subject to HIPAA privacy requirements, DEA controlled substance regulations, and State Board of Pharmacy dispensing rules. Drives downstream routing to McKesson Pharmacy Systems.',
    `register_number` STRING COMMENT 'POS register or checkout lane identifier within the store where the transaction was processed. Applicable only for in_store_pos and self_checkout channel types. Used for lane-level performance reporting, cashier assignment, and cash reconciliation. Null for OMS-originated orders.',
    `self_checkout` BOOLEAN COMMENT 'Indicates whether the transaction was processed through a self-checkout (SCO) lane where the customer scanned and bagged their own items without cashier assistance. Used for self-checkout adoption analytics, shrink attribution, and labor efficiency reporting.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this order record. Drives data lineage, reconciliation, and system-specific business rule application. Values: ncr_pos (in-store and self-checkout POS transactions), salesforce_commerce_cloud (online, delivery, click-and-collect, curbside orders), mckesson_pharmacy (pharmacy Rx fill orders).. Valid values are `ncr_pos|salesforce_commerce_cloud|mckesson_pharmacy`',
    `special_instructions` STRING COMMENT 'Free-text field capturing customer-provided delivery, pickup, or preparation instructions (e.g., Leave at front door, No substitutions, Call upon arrival). Applicable for online delivery, click-and-collect, and curbside pickup orders. Null for in-store POS transactions.',
    `substitution_allowed` BOOLEAN COMMENT 'Customer preference indicating whether out-of-stock (OOS) items in the order may be substituted with comparable alternatives by the picker or fulfillment associate. Applicable for online delivery, click-and-collect, and curbside pickup orders. Null for in-store POS transactions.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item extended prices before tax, discounts, and fees are applied. Represents the gross merchandise value (GMV) of the basket prior to adjustments. Used in COGS (Cost of Goods Sold) and GMROI (Gross Margin Return on Investment) calculations.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax charged on the order, calculated based on applicable state and local tax rates for taxable items in the basket. Excludes tax-exempt items (e.g., qualifying grocery staples, SNAP/EBT-eligible items). Required for tax remittance reporting and SOX financial controls.',
    `tender_summary` STRING COMMENT 'Human-readable summary of payment tender types used in this transaction (e.g., Credit $45.20, Loyalty Points $5.00). Provides a quick overview of how the order was paid without exposing sensitive payment details. Sourced from NCR POS tender records or Salesforce Commerce Cloud payment summary.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final net amount due from the customer after applying subtotal, discounts, fees, and tax. Equals subtotal_amount minus discount_amount plus tax_amount plus any applicable fees (delivery, service). This is the amount tendered by the customer. Core metric for revenue reporting and EBITDA calculations.',
    `total_unit_quantity` STRING COMMENT 'Total number of individual units (items) purchased across all line items in the order. Differs from basket_item_count which counts distinct SKUs. Used for average units per transaction (UPT) analytics and shrink analysis.',
    `transaction_type` STRING COMMENT 'Classification of the POS or OMS transaction by its business purpose. Primarily relevant for in-store POS and self-checkout channels. Values: sale (standard purchase), return (merchandise returned for refund), void (transaction cancelled before tender completion), no_sale (cash drawer opened without a sale), exchange (item swap without net monetary change).. Valid values are `sale|return|void|no_sale|exchange`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this order_header record was last modified in the Silver layer. Tracks order status changes, payment updates, and post-transaction adjustments. Used for incremental data processing and change data capture (CDC) pipelines.',
    CONSTRAINT pk_order_header PRIMARY KEY(`order_header_id`)
) COMMENT 'Master record for every customer purchase across all channels (in-store POS, online, click-and-collect, curbside pickup, last-mile delivery, and pharmacy Rx fills). Captures order number, channel type, register/lane (for POS), cashier (for POS), transaction type (sale, return, void, no-sale for POS), order date/time, order status lifecycle (placed, confirmed, in-fulfillment, ready, dispatched, delivered, cancelled), customer reference, store reference, total amounts, subtotal, tax, tender summary, change due (for POS), basket item count, loyalty card scanned flag, loyalty points earned, promo codes applied, special instructions, self-checkout flag, EBT/SNAP/WIC tender flag, source system (NCR POS / Salesforce Commerce Cloud / McKesson), payment method summary, and OMS order reference. Single source of truth for ALL customer purchase identity in the retail-grocery enterprise — encompasses both POS transactions and OMS-originated orders in one canonical entity. No separate POS transaction entity exists; channel-specific attributes are captured via channel type discriminator and nullable POS-specific fields.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`product_order_line` (
    `product_order_line_id` BIGINT COMMENT 'Unique identifier for the order line item. Primary key for the order line product.',
    `age_restricted_sale_id` BIGINT COMMENT 'Foreign key linking to compliance.age_restricted_sale. Business justification: Required for Age‑Restricted Sale compliance report linking each sold line to its verification record; auditors need to trace every age‑restricted SKU to the age_restricted_sale entry.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Needed for planogram compliance analysis; linking each sold line to the specific assortment item enables tracking of plan execution vs actual sales.',
    `assortment_plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: Supports assortment‑plan performance metrics; associating order lines with the originating assortment plan allows calculation of plan fulfillment rates.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Enables brand performance analytics and promotional budgeting by linking each order line to its brand master.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Order line should be linked to the department responsible for the sold item to enable departmental sales reporting.',
    `drug_item_id` BIGINT COMMENT 'Foreign key linking to product.drug_item. Business justification: Necessary for pharmacy order compliance, controlled‑substance tracking, and drug‑specific reporting.',
    `fuel_grade_id` BIGINT COMMENT 'Foreign key linking to product.product_fuel_grade. Business justification: Tracks fuel grade sales and satisfies regulatory reporting for fuel products sold at the pump.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Supports hierarchical assortment planning and category‑level sales reporting via the item hierarchy reference.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header that contains this line item. Links the line to its transaction header.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Required for traceability report linking sold items to supplier purchase order lines for recall compliance.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Line‑level tracking of prescription items enables accurate inventory deduction, claim submission, and return processing in pharmacy operations.',
    `price_change_id` BIGINT COMMENT 'Foreign key linking to pricing.price_change. Business justification: Price‑change impact analysis tracks which price_change event affected a line, supporting margin and revenue impact reporting.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: When a coupon or promo code is applied, the order line should reference the specific promo offer for audit and effectiveness analysis.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Price audit report requires linking each order line to the exact retail_price record applied, enabling compliance checks of sold price versus current price.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for SKU‑level sales reporting and inventory allocation; order lines must reference the SKU master record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Required for supplier performance reporting per line item; enables cost allocation and on‑time delivery metrics that retailers track for each SKUs supplier.',
    `age_restricted_flag` BOOLEAN COMMENT 'Indicates whether this item requires age verification at point of sale. Includes alcohol, tobacco, and certain over-the-counter medications.',
    `bogo_flag` BOOLEAN COMMENT 'Indicates whether this line item was part of a Buy One Get One promotion. Used for basket analysis and promotional effectiveness reporting.',
    `coupon_code` STRING COMMENT 'Manufacturer or store coupon code applied to this line item. Links to coupon campaign for redemption tracking and vendor chargeback.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was first created in the system. Represents when the item was added to the cart or scanned at POS.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item from promotions, coupons, loyalty rewards, or temporary price reductions (TPR). Reduces the extended price.',
    `extended_price` DECIMAL(18,2) COMMENT 'Total price for the line item calculated as quantity multiplied by unit price, before discounts and taxes. Gross line amount.',
    `fulfillment_method` STRING COMMENT 'Method by which this specific line item will be fulfilled. Supports mixed-cart scenarios where different items in the same order have different fulfillment methods.. Valid values are `in_store|delivery|curbside_pickup|click_and_collect|ship_to_home`',
    `gtin` STRING COMMENT 'Global Trade Item Number for international product identification. Encompasses UPC, EAN, and other GS1 identifiers.. Valid values are `^[0-9]{8,14}$`',
    `item_description` STRING COMMENT 'Human-readable description of the product as it appears on the receipt and in order details. Includes brand, size, and variant information.',
    `line_number` STRING COMMENT 'Sequential position of this line item within the parent order. Used for ordering and display purposes.',
    `line_status` STRING COMMENT 'Current lifecycle status of the order line item. Tracks the line through fulfillment stages from active order to final disposition. [ENUM-REF-CANDIDATE: active|substituted|cancelled|out_of_stock|voided|returned|picked|packed|delivered — 9 candidates stripped; promote to reference product]',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the customer for purchasing this line item. Used for customer lifetime value (CLTV) calculation and loyalty program analytics.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was last modified. Tracks updates to quantity, price, status, or other line attributes.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount for the line item after discounts and including taxes. This is the amount the customer pays for this line.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether this item is certified organic by USDA or equivalent certification body. Used for organic category reporting and compliance.',
    `original_sku` STRING COMMENT 'Original SKU that was requested by the customer before substitution occurred. Null if no substitution was made.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether this item is a perishable product requiring cold chain management and FIFO inventory rotation. Includes fresh produce, meat, dairy, deli, bakery, and frozen items.',
    `plu` STRING COMMENT 'Price Look-Up code used for fresh produce, deli, and bakery items that are not pre-packaged with barcodes. Typically 4-5 digit codes entered manually or via scale.. Valid values are `^[0-9]{4,5}$`',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this item is a store-owned private label brand product. Used for private label performance analysis and margin reporting.',
    `promo_applied_flag` BOOLEAN COMMENT 'Indicates whether a promotional discount was applied to this line item. True if any promotion, coupon, or loyalty discount was used.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity of the item ordered by the customer. Supports fractional quantities for variable-weight items such as produce, meat, and deli products.',
    `return_flag` BOOLEAN COMMENT 'Indicates whether this line item represents a product return. Used for return rate analysis and inventory restocking.',
    `return_reason_code` STRING COMMENT 'Reason code explaining why the item was returned. Examples include defective, expired, customer dissatisfaction, or wrong item delivered.',
    `scan_method` STRING COMMENT 'Method used to capture the item at point of sale or during order picking. Indicates whether the item was scanned via handheld device, belt scanner, self-checkout, manually keyed, or captured via mobile app.. Valid values are `handheld_scanner|belt_scanner|self_checkout|manual_entry|mobile_app|scale`',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using SNAP Electronic Benefits Transfer (EBT). Required for government program compliance and reporting.',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether this line item is a substitution for an originally requested item that was out of stock or unavailable. Common in online and click-and-collect orders.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sales tax amount calculated for this line item based on applicable tax jurisdiction and product tax code. Includes state, county, and municipal taxes.',
    `tax_code` STRING COMMENT 'Tax classification code for the item determining applicable sales tax rates. Differentiates taxable, non-taxable, and reduced-rate items such as groceries, prepared foods, and SNAP-eligible products.',
    `tpr_flag` BOOLEAN COMMENT 'Indicates whether this line item was sold at a temporary price reduction. Used for promotional markdown analysis and ad circular tracking.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity ordered. Indicates whether the item is sold by each, weight, volume, or pack. [ENUM-REF-CANDIDATE: each|lb|kg|oz|g|case|pack|dozen|gallon|liter|ml — 11 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure before any discounts or promotions are applied. Base selling price for the item.',
    `upc` STRING COMMENT 'Universal Product Code scanned at Point of Sale (POS). Standard barcode identifier for CPG items.. Valid values are `^[0-9]{12,14}$`',
    `void_flag` BOOLEAN COMMENT 'Indicates whether this line item was voided during the transaction. Used for shrink analysis and cashier performance monitoring.',
    `void_reason_code` STRING COMMENT 'Reason code explaining why the line item was voided. Examples include customer changed mind, pricing error, damaged item, or cashier error.',
    `weight_actual` DECIMAL(18,2) COMMENT 'Actual weight of the item for variable-weight products such as fresh produce, meat, deli, and seafood. Captured from scale at POS or during fulfillment picking.',
    `weight_unit` STRING COMMENT 'Unit of measure for the actual weight field. Typically pounds or kilograms depending on regional standards.. Valid values are `lb|kg|oz|g`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using WIC benefits. Required for government program compliance and reporting.',
    CONSTRAINT pk_product_order_line PRIMARY KEY(`product_order_line_id`)
) COMMENT 'Individual line item within a customer order representing a single SKU/UPC purchased or requested across all channels (in-store POS scan, online cart, click-and-collect). Captures line sequence number, SKU/GTIN, PLU (for produce), UPC (for POS-scanned items), item description, ordered quantity, unit of measure, unit price, extended price, discount amount, promo applied flag, substitution flag, substitution SKU, line status (active, substituted, cancelled, out-of-stock, voided, returned), weight (for variable-weight/scale items), tax code, department code, tax amount, fulfillment method per line, void flag, return flag, TPR flag, BOGO flag, coupon applied reference, and scan method (handheld, belt scanner, self-checkout, manual key). Supports both fixed-weight CPG items and variable-weight fresh/deli items. Enables basket analytics, shrink analysis, and category performance reporting at the item level across all channels.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_status_history` (
    `order_status_history_id` BIGINT COMMENT 'Unique identifier for each status transition record in the order lifecycle. Primary key for the immutable audit trail.',
    `associate_id` BIGINT COMMENT 'The unique identifier of the person or system account that triggered the status transition. May be an employee ID, customer ID, system service account, or driver ID depending on actor_type.',
    `carrier_id` BIGINT COMMENT 'Reference to the delivery carrier or logistics provider involved in this status transition. Applicable for delivery-related status changes (out_for_delivery, delivered). Null for non-delivery transitions.',
    `order_header_id` BIGINT COMMENT 'Reference to the order header that experienced this status transition. Links this status event to the parent order entity.',
    `store_location_id` BIGINT COMMENT 'Reference to the physical location (store, distribution center, micro-fulfillment center, pharmacy) where the status transition occurred. Null for system-automated transitions without physical location context.',
    `web_session_id` BIGINT COMMENT 'The application session or transaction identifier during which this status transition was recorded. Used for technical troubleshooting and audit trail correlation.',
    `actor_type` STRING COMMENT 'The category of actor (person or system) that triggered the status transition. Examples: customer, store_associate, warehouse_picker, delivery_driver, system_automation, customer_service_rep, pharmacy_technician. [ENUM-REF-CANDIDATE: customer|store_associate|warehouse_picker|delivery_driver|system_automation|customer_service_rep|pharmacy_technician — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this status history record was created in the data platform. Distinct from transition_timestamp, which represents the business event time. Used for data lineage and audit purposes.',
    `device_code` STRING COMMENT 'The unique identifier of the device (mobile scanner, POS terminal, handheld picker device) used to record this status transition. Used for device audit trails and operational troubleshooting.',
    `dwell_time_minutes` STRING COMMENT 'The number of minutes the order spent in the previous status before this transition. Calculated as the difference between this transition_timestamp and the prior transition_timestamp. Used for cycle time analysis and bottleneck identification.',
    `estimated_completion_timestamp` TIMESTAMP COMMENT 'The estimated date and time when the order is expected to reach final completion (delivered or ready for pickup), calculated at the time of this status transition. Updated with each transition to reflect current estimates.',
    `exception_code` STRING COMMENT 'Standardized code identifying any exception or issue that occurred during this status transition. Examples: OUT_OF_STOCK, PAYMENT_DECLINED, ADDRESS_INVALID, WEATHER_DELAY, CUSTOMER_NOT_HOME. Null for normal transitions.',
    `exception_description` STRING COMMENT 'Free-text description providing additional context about the exception or issue. Used for customer service investigation and root cause analysis. Null for normal transitions.',
    `fulfillment_channel` STRING COMMENT 'The omnichannel fulfillment method for this order. Examples: in_store (traditional POS), curbside_pickup (click-and-collect), home_delivery (last-mile delivery), ship_to_home (parcel shipment), pharmacy_pickup, locker_pickup.. Valid values are `in_store|curbside_pickup|home_delivery|ship_to_home|pharmacy_pickup|locker_pickup`',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate where the status transition occurred, captured from mobile device or delivery scanner. Used for delivery verification and route optimization analysis. Null if geolocation not captured.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate where the status transition occurred, captured from mobile device or delivery scanner. Used for delivery verification and route optimization analysis. Null if geolocation not captured.',
    `new_status` STRING COMMENT 'The status the order transitioned to. Captures the to-state in the status change event. This is the current status after the transition. [ENUM-REF-CANDIDATE: pending|confirmed|allocated|picking|picked|packed|ready_for_pickup|out_for_delivery|delivered|cancelled|refunded — 11 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the actor at the time of status transition. Used for operational context, special instructions, or issue documentation. Null if no notes provided.',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the customer of this status transition. Examples: email, sms, push (mobile push notification), none (no notification sent).. Valid values are `email|sms|push|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a customer notification (email, SMS, push notification) was sent for this status transition. True if notification was triggered, False otherwise.',
    `previous_status` STRING COMMENT 'The status the order was in immediately before this transition. Captures the from-state in the status change event. [ENUM-REF-CANDIDATE: pending|confirmed|allocated|picking|picked|packed|ready_for_pickup|out_for_delivery|delivered|cancelled|refunded — 11 candidates stripped; promote to reference product]',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the status transition occurred within the SLA target window. True if transition_timestamp <= sla_target_timestamp, False otherwise. Critical for performance reporting and customer service.',
    `sla_target_timestamp` TIMESTAMP COMMENT 'The target date and time by which this status transition was expected to occur, based on the orders service level agreement. Used for SLA compliance tracking and exception reporting.',
    `source_system_transaction_ref` STRING COMMENT 'The unique transaction or event identifier from the source system (OMS, TMS, WMS, POS) that generated this status transition. Used for cross-system reconciliation and technical troubleshooting.',
    `tracking_number` STRING COMMENT 'The carrier-provided tracking number or shipment identifier associated with this status transition. Used for carrier dispute management and delivery verification. Null for non-delivery transitions.',
    `transition_timestamp` TIMESTAMP COMMENT 'The precise date and time when the status transition occurred. This is the business event timestamp for the status change, distinct from record creation time.',
    `triggering_event` STRING COMMENT 'The specific business event or action that caused this status transition. Examples: customer_placed_order, payment_authorized, inventory_allocated, pick_started, pick_completed, pack_completed, customer_arrived (for pickup), driver_dispatched, driver_scanned, delivery_confirmed, customer_cancelled, system_timeout, exception_raised, refund_processed. [ENUM-REF-CANDIDATE: customer_placed_order|payment_authorized|inventory_allocated|pick_started|pick_completed|pack_completed|customer_arrived|driver_dispatched|driver_scanned|delivery_confirmed|customer_cancelled|system_timeout|exception_raised|refund_processed — 14 candidates stripped; promote to reference product]',
    `triggering_system` STRING COMMENT 'The source system that initiated or recorded this status transition. Examples: OMS (Order Management System), TMS (Transportation Management System), WMS (Warehouse Management System), POS (Point of Sale), ECOM (eCommerce platform), MOBILE (mobile app), PHARMACY (pharmacy system), MANUAL (manual override). [ENUM-REF-CANDIDATE: OMS|TMS|WMS|POS|ECOM|MOBILE|PHARMACY|MANUAL — 8 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'The system process or ETL job identifier that created this record in the data platform. Used for data lineage tracking and operational support.',
    CONSTRAINT pk_order_status_history PRIMARY KEY(`order_status_history_id`)
) COMMENT 'Immutable audit trail of every status transition for an order header throughout its lifecycle. Records the previous status, new status, transition timestamp, triggering system (OMS, TMS, WMS, POS), triggering event (customer action, store action, driver scan, system timeout), and operator/system actor. Enables SLA tracking, exception investigation, and omnichannel fulfillment performance reporting. Critical for customer service resolution and carrier dispute management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`delivery_order` (
    `delivery_order_id` BIGINT COMMENT 'Unique identifier for the delivery order record. Primary key for the delivery order entity representing the last-mile logistics leg of an online or OMS-originated order.',
    `associate_id` BIGINT COMMENT 'Reference to the driver or delivery associate assigned to fulfill this delivery order. Links to workforce or driver master data.',
    `contact_info_id` BIGINT COMMENT 'Foreign key linking to customer.contact_info. Business justification: Required for Delivery Address Verification report; each delivery order must reference a validated contact_info record for carrier compliance.',
    `fulfillment_delivery_route_id` BIGINT COMMENT 'Reference to the TMS route plan that includes this delivery. Links to JDA Transportation Management System route optimization.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header that originated this delivery. Links the delivery leg back to the original customer order.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the delivery was completed and goods were handed off to the customer or left at the delivery location. Null if delivery not yet completed.',
    `carrier_code` STRING COMMENT 'Code identifying the carrier or delivery service provider responsible for this delivery. May represent internal fleet or third-party carrier.. Valid values are `^[A-Z0-9]{2,10}$`',
    `contactless_delivery_flag` BOOLEAN COMMENT 'Indicates whether the customer requested contactless delivery. When true, driver should leave items at the door and minimize direct contact.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order record was first created in the system. Represents the moment the delivery leg was initiated from the order management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this delivery order record.. Valid values are `^[A-Z]{3}$`',
    `delivery_fee_amount` DECIMAL(18,2) COMMENT 'The delivery service charge amount billed to the customer for this delivery. May be zero for free delivery promotions or loyalty members.',
    `delivery_notes` STRING COMMENT 'Free-text notes recorded by the driver at delivery time. May include delivery condition observations, customer interactions, or exception details.',
    `delivery_order_number` STRING COMMENT 'Human-readable business identifier for the delivery order, used for tracking and customer communication. Typically formatted as DO- prefix followed by 10-digit sequence.. Valid values are `^DO-[0-9]{10}$`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery order. Tracks progression from scheduling through final delivery or failure. Values: scheduled (delivery window assigned), assigned (driver allocated), en_route (in transit), out_for_delivery (final leg), delivered (completed successfully), failed (delivery attempt unsuccessful), returned (sent back to origin), cancelled (order cancelled before delivery). [ENUM-REF-CANDIDATE: scheduled|assigned|en_route|out_for_delivery|delivered|failed|returned|cancelled — 8 candidates stripped; promote to reference product]',
    `delivery_type` STRING COMMENT 'Classification of delivery service level. Defines the speed and method of delivery fulfillment.. Valid values are `standard|express|same_day|scheduled|curbside|contactless`',
    `distance_miles` DECIMAL(18,2) COMMENT 'Total distance in miles from the fulfillment origin (store, MFC, or DC) to the delivery destination. Used for delivery fee calculation and route analytics.',
    `failure_reason_code` STRING COMMENT 'Standardized code indicating why a delivery attempt failed. Populated only when delivery_status is failed or returned. Used for root cause analysis and redelivery planning. [ENUM-REF-CANDIDATE: customer_not_home|address_not_found|access_denied|weather|vehicle_issue|refused|damaged|other — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this delivery order record. Tracks the last status change, address correction, or driver assignment.',
    `proof_of_delivery_method` STRING COMMENT 'The method used to capture proof that the delivery was completed. Values: signature (customer signed on device), photo (driver captured delivery photo), pin (customer provided PIN code), none (no proof captured for contactless).. Valid values are `signature|photo|pin|none`',
    `proof_of_delivery_reference` STRING COMMENT 'Reference identifier or URL to the stored proof of delivery artifact (signature image, photo, or PIN verification record). Used for dispute resolution.',
    `reattempt_count` STRING COMMENT 'Number of delivery attempts made for this order. Increments with each failed delivery attempt. Used to trigger customer contact or return-to-sender workflows.',
    `recipient_name` STRING COMMENT 'Name of the person who received the delivery. May differ from the order customer if delivery was accepted by household member or designee.',
    `scheduled_delivery_date` DATE COMMENT 'The date on which the delivery is scheduled to occur. Used for day-level delivery planning and customer communication.',
    `scheduled_window_end_time` TIMESTAMP COMMENT 'The ending timestamp of the scheduled delivery window communicated to the customer. Defines the latest time within the promised delivery window.',
    `scheduled_window_start_time` TIMESTAMP COMMENT 'The beginning timestamp of the scheduled delivery window communicated to the customer. Defines the earliest time the customer should expect delivery.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this delivery order record. Typically OMS (Order Management System), TMS (Transportation Management System), or eCommerce platform.. Valid values are `^[A-Z_]{2,20}$`',
    `stop_sequence_number` STRING COMMENT 'The position of this delivery within the drivers route sequence. Used for route optimization and estimated time of arrival calculation.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this delivery requires cold chain temperature control for perishable or frozen items. When true, vehicle must have refrigeration capability.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount provided by the customer for the delivery driver. May be pre-tip at order time or post-delivery adjustment.',
    `vehicle_code` STRING COMMENT 'Identifier for the vehicle used to fulfill this delivery. May be license plate, fleet number, or vehicle asset tag.. Valid values are `^[A-Z0-9-]{5,20}$`',
    CONSTRAINT pk_delivery_order PRIMARY KEY(`delivery_order_id`)
) COMMENT 'Last-mile delivery order record managing the logistics leg of an online or OMS-originated order dispatched to a customer address. Captures delivery order number, linked order header, delivery address, scheduled delivery window (start/end), actual delivery timestamp, delivery status (scheduled, assigned, en-route, delivered, failed, returned), driver/carrier reference, vehicle reference, delivery zone, distance miles, delivery fee, tip amount, contactless delivery flag, delivery instructions, proof-of-delivery method (photo/signature/PIN), and TMS route reference. Integrates with JDA TMS.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`pickup_appointment` (
    `pickup_appointment_id` BIGINT COMMENT 'Unique identifier for the pickup appointment record. Primary key for curbside and click-and-collect appointment tracking.',
    `associate_id` BIGINT COMMENT 'Reference to the store associate who fulfilled and dispensed the pickup order. Used for performance tracking and quality accountability.',
    `order_header_id` BIGINT COMMENT 'Reference to the order header associated with this pickup appointment. Links the appointment to the customers order for fulfillment tracking.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who scheduled the pickup appointment. Links appointment to customer profile for notification and service history.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the pickup appointment is scheduled. Identifies the fulfillment location for curbside or in-store pickup.',
    `appointment_number` STRING COMMENT 'Human-readable business identifier for the pickup appointment. Used for customer communication and associate reference during fulfillment.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the pickup appointment. Tracks progression from scheduling through completion or cancellation. Critical for SLA (Service Level Agreement) monitoring and operational workflow management. [ENUM-REF-CANDIDATE: scheduled|confirmed|ready|arrived|in_progress|dispensed|completed|no_show|cancelled — 9 candidates stripped; promote to reference product]',
    `appointment_type` STRING COMMENT 'Classification of pickup method. Distinguishes between curbside delivery to vehicle, in-store pickup counter collection, or automated locker retrieval.. Valid values are `curbside|in_store|locker`',
    `arrival_notification_sent_timestamp` TIMESTAMP COMMENT 'The timestamp when the customer sent an Im here notification via mobile app or SMS. Alerts store associates that customer has arrived.',
    `cancellation_notes` STRING COMMENT 'Free-text notes explaining the cancellation circumstances. Provides additional context beyond the reason code for customer service and operational review.',
    `cancellation_reason` STRING COMMENT 'The reason code for appointment cancellation. Used for root cause analysis and service improvement initiatives.. Valid values are `customer_request|order_cancelled|no_show|system_error|inventory_unavailable|other`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The timestamp when the appointment was cancelled by customer or system. Used for slot release and cancellation rate analytics.',
    `contact_phone_number` STRING COMMENT 'The phone number to reach the customer upon arrival or for appointment coordination. Used for real-time communication during pickup process.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the pickup appointment record was first created in the system. Audit field for record lifecycle tracking.',
    `customer_arrival_timestamp` TIMESTAMP COMMENT 'The actual timestamp when the customer arrived at the pickup location. Captured via mobile app check-in or associate entry. Critical for SLA (Service Level Agreement) measurement.',
    `customer_feedback` STRING COMMENT 'Free-text feedback provided by the customer about their pickup experience. Captures qualitative insights for service improvement.',
    `customer_rating` STRING COMMENT 'The customer satisfaction rating provided after pickup completion, typically on a 1-5 scale. Used for service quality measurement and associate performance evaluation.',
    `dispensing_completion_timestamp` TIMESTAMP COMMENT 'The timestamp when the order was fully dispensed to the customer and the transaction completed. Used for calculating total service time and SLA compliance.',
    `dispensing_start_timestamp` TIMESTAMP COMMENT 'The timestamp when the associate began loading items into the customers vehicle or handed over the order. Marks the beginning of the dispensing process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the pickup appointment record was last updated. Audit field for tracking changes to appointment details or status.',
    `order_ready_timestamp` TIMESTAMP COMMENT 'The timestamp when the order was fully picked, staged, and ready for customer pickup. Triggers customer notification that order is available.',
    `parking_spot_number` STRING COMMENT 'The specific parking spot identifier where the customer parks for curbside pickup. May differ from bay number in stores with multiple spot configurations.',
    `pickup_bay_number` STRING COMMENT 'The designated curbside bay or parking spot number assigned to this appointment. Used for directing customers to the correct location and managing bay capacity.',
    `ready_notification_sent_timestamp` TIMESTAMP COMMENT 'The timestamp when the order-ready notification (SMS, email, or app push) was sent to the customer. Used for communication audit trail.',
    `reminder_notification_sent_timestamp` TIMESTAMP COMMENT 'The timestamp when a reminder notification was sent to the customer about their upcoming appointment. Used for proactive customer engagement tracking.',
    `scheduled_date` DATE COMMENT 'The calendar date on which the pickup appointment is scheduled. Used for day-level capacity planning and customer communication.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The ending timestamp of the scheduled pickup window. Defines the latest time within the appointment slot for customer arrival.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The beginning timestamp of the scheduled pickup window. Defines when the customer can arrive for their appointment.',
    `sla_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the appointment met the SLA target. True if wait time was within target, false if exceeded. Used for compliance reporting.',
    `sla_target_minutes` STRING COMMENT 'The target service time in minutes for this appointment type. Used for measuring performance against service commitments.',
    `slot_capacity_used` STRING COMMENT 'The capacity units consumed by this appointment within the time slot. Used for managing concurrent appointment limits and preventing overbooking.',
    `special_instructions` STRING COMMENT 'Customer-provided special instructions for the pickup (e.g., trunk placement, contactless delivery, accessibility needs). Guides associate fulfillment behavior.',
    `substitution_preference` STRING COMMENT 'Customer preference for handling out-of-stock items. Determines whether substitutions are allowed and if customer approval is required.. Valid values are `accept_substitutions|contact_first|no_substitutions`',
    `temperature_zone` STRING COMMENT 'The temperature control requirement for this order. Determines staging location and handling procedures to maintain cold chain integrity for perishables.. Valid values are `ambient|refrigerated|frozen|mixed`',
    `total_bag_count` STRING COMMENT 'The total number of bags or containers prepared for this pickup. Helps associates verify complete order transfer to customer.',
    `total_item_count` STRING COMMENT 'The total number of items in the order for this pickup appointment. Used for workload estimation and associate staffing decisions.',
    `vehicle_description` STRING COMMENT 'Description of the customers vehicle including make, model, and color. Helps associates identify the correct vehicle during curbside fulfillment.',
    `vehicle_license_plate` STRING COMMENT 'The license plate number of the customers vehicle. Used for positive identification during curbside pickup. Business-confidential customer information.',
    `wait_time_minutes` DECIMAL(18,2) COMMENT 'The calculated wait time in minutes from customer arrival to dispensing completion. Key performance indicator for curbside service quality and SLA compliance.',
    CONSTRAINT pk_pickup_appointment PRIMARY KEY(`pickup_appointment_id`)
) COMMENT 'Curbside or in-store click-and-collect pickup appointment record. Captures appointment ID, linked order header, store ID, pickup bay/slot, scheduled pickup window (date, start time, end time), actual arrival timestamp, actual pickup completion timestamp, appointment status (scheduled, arrived, dispensed, no-show, cancelled), vehicle description, parking spot number, associate who dispensed, and customer notification timestamps (ready SMS, reminder). Manages curbside slot capacity and SLA compliance for click-and-collect fulfillment.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_fulfillment` (
    `order_fulfillment_id` BIGINT COMMENT 'Unique identifier for the fulfillment execution record. Primary key.',
    `wave_id` BIGINT COMMENT 'Identifier for the batch wave if this fulfillment was part of a multi-order picking wave. Used in WMS optimization for efficient picking routes.',
    `node_id` BIGINT COMMENT 'Identifier of the specific store, MFC, DC, or pharmacy location executing this fulfillment.',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Needed for fulfillment audit to associate each order fulfillment with the inbound shipment that supplied the inventory.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header being fulfilled. Links this fulfillment execution to the customer order.',
    `cart_id` BIGINT COMMENT 'Identifier of the physical picking cart or tote used by the picker. Used for equipment tracking and multi-order batch picking workflows.',
    `associate_id` BIGINT COMMENT 'Workforce associate assigned to pick this order. References the associate performing the physical picking task.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Regulatory and labor reporting tracks which shift performed fulfillment; linking fulfillment to shift enables shift‑level productivity and compliance analysis.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Required for Pickup Fulfillment Assignment report: links each fulfillment record to the store that performed the pickup, enabling SLA monitoring and inventory allocation.',
    `actual_fulfillment_minutes` STRING COMMENT 'Actual elapsed time in minutes from pick start to dispatch. Used to measure picker productivity and SLA compliance.',
    `cancellation_reason` STRING COMMENT 'Reason code or description if the fulfillment was cancelled. Examples: customer_request, inventory_unavailable, system_error, weather_delay. Populated only when fulfillment_status = cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was created in the system, typically when the order was released to the fulfillment queue.',
    `dispatched_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was handed to the customer (curbside/in-store pickup) or to the delivery carrier for last-mile delivery.',
    `fulfillment_location_type` STRING COMMENT 'Type of facility executing the fulfillment. Store = retail store backroom, MFC = Micro-Fulfillment Center, DC = Distribution Center, Pharmacy = pharmacy dispensing area.. Valid values are `store|mfc|dc|pharmacy`',
    `fulfillment_method` STRING COMMENT 'Method by which the customer will receive the order. Curbside Pickup = customer collects at designated parking spot, In-Store Pickup = customer collects at service desk, Home Delivery = last-mile delivery to customer address, Locker Pickup = customer retrieves from automated locker.. Valid values are `curbside_pickup|in_store_pickup|home_delivery|locker_pickup`',
    `fulfillment_number` STRING COMMENT 'Business-readable identifier for this fulfillment execution, used for tracking and communication with pickers and customers.',
    `fulfillment_status` STRING COMMENT 'Current state of the fulfillment workflow. Queued = awaiting assignment, Assigned = picker assigned but not started, Picking = actively picking items, Picked = all items picked, Packing = items being packed, Packed = packing complete, Staged = ready for customer pickup or delivery dispatch, Dispatched = handed to carrier or customer, Cancelled = fulfillment aborted. [ENUM-REF-CANDIDATE: queued|assigned|picking|picked|packing|packed|staged|dispatched|cancelled — 9 candidates stripped; promote to reference product]',
    `oos_line_count` STRING COMMENT 'Number of order lines that could not be fulfilled due to out-of-stock conditions and no acceptable substitution. Impacts customer satisfaction and fill rate metrics.',
    `pack_complete_timestamp` TIMESTAMP COMMENT 'Timestamp when packing was completed and order is ready for staging or dispatch.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Timestamp when packing of picked items began. Used for labor tracking and process efficiency analysis.',
    `package_count` STRING COMMENT 'Number of packages or bags this fulfillment was packed into. Used for customer communication and carrier handoff verification.',
    `pick_complete_timestamp` TIMESTAMP COMMENT 'Timestamp when all items were picked (or picking was completed with substitutions/OOS). Marks transition to packing stage.',
    `pick_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the picker began picking items for this order. Used for labor productivity tracking and SLA monitoring.',
    `picker_notes` STRING COMMENT 'Free-text notes entered by the picker during fulfillment, such as item condition observations, substitution reasons, or customer communication notes.',
    `quality_check_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment underwent a quality inspection before staging. True = quality check performed, False = no quality check. Used for high-value orders or training purposes.',
    `sla_target_minutes` STRING COMMENT 'Target time in minutes from order placement to fulfillment completion, based on the order type and fulfillment method. Used for performance monitoring and customer promise tracking.',
    `staged_timestamp` TIMESTAMP COMMENT 'Timestamp when the packed order was placed in the staging area or pickup bay, ready for customer collection or carrier pickup.',
    `staging_area` STRING COMMENT 'Physical staging location identifier within the fulfillment facility (e.g., bay number, zone, cooler section) where the packed order is held for pickup or dispatch.',
    `substitution_count` STRING COMMENT 'Number of order lines where a substitute item was picked due to the original item being out of stock or unavailable.',
    `temperature_zone` STRING COMMENT 'Primary temperature control zone required for this fulfillment. Ambient = room temperature, Refrigerated = cold chain 0-4°C, Frozen = frozen storage below 0°C. Critical for fresh produce and perishable inventory management.. Valid values are `ambient|refrigerated|frozen`',
    `total_lines` STRING COMMENT 'Total number of order line items in the original order that this fulfillment is responsible for picking.',
    `total_lines_picked` STRING COMMENT 'Number of order lines successfully picked (including substitutions). Used to calculate fill rate and picker productivity.',
    `total_units_picked` DECIMAL(18,2) COMMENT 'Total quantity of units picked across all lines, including substitutions. Used for labor productivity measurement (units per hour).',
    `total_volume_liters` DECIMAL(18,2) COMMENT 'Total volume of the packed order in liters. Used for vehicle capacity planning and staging area space management.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the picked and packed order in kilograms. Used for shipping cost calculation and load planning for delivery vehicles.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fulfillment record. Used for audit trail and data freshness tracking.',
    `wms_task_reference` STRING COMMENT 'External task or wave identifier from Manhattan Associates WMS that orchestrated this fulfillment execution. Used for integration and audit trail.',
    CONSTRAINT pk_order_fulfillment PRIMARY KEY(`order_fulfillment_id`)
) COMMENT 'Fulfillment execution record linking an order header to its physical pick-pack-ship workflow in the store backroom, MFC, or DC. Captures fulfillment ID, linked order header, fulfillment location type (store/MFC/DC), fulfillment location ID, assigned picker ID, pick start timestamp, pick complete timestamp, pack complete timestamp, staging area/bay, fulfillment status (queued, picking, picked, packed, staged, dispatched), total lines, total lines picked, substitution count, OOS line count, and WMS task reference. Integrates with Manhattan Associates WMS.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_discount` (
    `order_discount_id` BIGINT COMMENT 'Unique identifier for the order discount record. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Discount expense must be posted to a specific GL account for accurate discount expense reporting.',
    `order_header_id` BIGINT COMMENT 'Reference to the order header to which this discount is applied. Links to the parent order transaction.',
    `payment_transaction_id` BIGINT COMMENT 'The unique transaction identifier from the source system (POS transaction number, eCommerce order number). Used for cross-system reconciliation and audit.',
    `associate_id` BIGINT COMMENT 'Reference to the store associate or cashier who processed this discount at the point of sale. Nullable for automated or online discounts.',
    `product_order_line_id` BIGINT COMMENT 'Reference to the specific order line item to which this discount is applied. Nullable for header-level discounts that apply to the entire order rather than a specific line.',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotion campaign or offer that generated this discount. Links to the promotion master data.',
    `store_location_id` BIGINT COMMENT 'Reference to the physical store location where this discount was applied, if applicable. Nullable for online-only transactions.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier funding this discount, if applicable. Nullable for store-funded or loyalty-funded discounts.',
    `applied_timestamp` TIMESTAMP COMMENT 'The date and time when this discount was applied to the order during the transaction or order processing workflow.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this discount required manager or supervisor approval before being applied. True if approval was required, false otherwise.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this discount was approved by a manager or supervisor. Nullable if no approval was required.',
    `channel` STRING COMMENT 'The sales channel through which this discount was applied. In-store for POS (Point of Sale) transactions, online for eCommerce, mobile app for app-based orders, curbside pickup for click-and-collect, delivery for last-mile delivery orders, pharmacy for prescription fills.. Valid values are `in_store|online|mobile_app|curbside_pickup|delivery|pharmacy`',
    `coupon_code` STRING COMMENT 'The specific coupon or promo code entered or scanned by the customer to activate this discount. Nullable if discount was automatically applied.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this discount record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The absolute monetary value of the discount applied to the order or line item, in the transaction currency. Represents the reduction in price.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage rate of discount applied, expressed as a decimal (e.g., 15.00 for 15% off). Nullable if discount is a fixed amount rather than percentage-based.',
    `discount_reason_code` STRING COMMENT 'Internal code indicating the business reason or authorization basis for the discount. Used for audit and compliance tracking.',
    `discount_scope` STRING COMMENT 'The level at which this discount is applied. Order header applies to entire order, order line applies to specific line item, category applies to product category, SKU (Stock Keeping Unit) applies to specific product, basket applies to qualifying basket combinations.. Valid values are `order_header|order_line|category|sku|basket`',
    `discount_status` STRING COMMENT 'Current lifecycle status of the discount. Applied indicates successfully applied, reversed indicates discount was removed or refunded, pending indicates awaiting validation, expired indicates promotion period ended, invalid indicates discount failed validation rules.. Valid values are `applied|reversed|pending|expired|invalid`',
    `discount_type` STRING COMMENT 'Classification of the discount mechanism applied. TPR (Temporary Price Reduction), BOGO (Buy One Get One), digital coupon, loyalty reward, ad circular promotion, markdown clearance, employee discount, EBT (Electronic Benefits Transfer) discount, vendor-funded promotion, or store-funded promotion. [ENUM-REF-CANDIDATE: tpr|bogo|digital_coupon|loyalty_reward|ad_circular|markdown|employee_discount|ebt_discount|vendor_funded|store_funded — 10 candidates stripped; promote to reference product]',
    `final_price` DECIMAL(18,2) COMMENT 'The final price after this discount was applied. Represents the net amount charged to the customer for this discount application.',
    `funding_source` STRING COMMENT 'Entity responsible for funding or absorbing the cost of this discount. Vendor-funded promotions are reimbursed by suppliers, store-funded are absorbed by the retailer.. Valid values are `vendor|store|manufacturer|loyalty_program|corporate`',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the customer to obtain this discount. Nullable if discount is not loyalty-based.',
    `max_discount_allowed` DECIMAL(18,2) COMMENT 'The maximum discount amount permitted by the promotion rules or system configuration. Used to enforce discount caps and prevent over-discounting.',
    `min_purchase_required` DECIMAL(18,2) COMMENT 'The minimum purchase amount required to qualify for this discount. Nullable if no minimum threshold applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this discount record was last modified or updated. Used for audit trail and change tracking.',
    `original_price` DECIMAL(18,2) COMMENT 'The original price of the item or order total before this discount was applied. Used for calculating discount impact and GMROI (Gross Margin Return on Investment) analysis.',
    `pos_terminal_code` STRING COMMENT 'Identifier of the point-of-sale terminal or register where this discount was processed. Nullable for digital commerce transactions.',
    `promo_stack_sequence` STRING COMMENT 'The order in which this discount was applied when multiple promotions are stacked on the same order or line. Lower numbers indicate earlier application in the discount calculation sequence.',
    `promotion_end_date` DATE COMMENT 'The effective end date of the promotion period after which this discount is no longer valid.',
    `promotion_start_date` DATE COMMENT 'The effective start date of the promotion period during which this discount is valid.',
    `quantity_threshold` STRING COMMENT 'The minimum quantity of items required to qualify for this discount (e.g., buy 3 get 1 free). Nullable if discount is not quantity-based.',
    `reversal_reason` STRING COMMENT 'Explanation or code indicating why this discount was reversed or removed from the order. Nullable if discount was not reversed.',
    `reversal_timestamp` TIMESTAMP COMMENT 'The date and time when this discount was reversed or removed. Nullable if discount was not reversed.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this discount can be combined with SNAP benefits. True if eligible for SNAP transactions, false otherwise.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this discount record (e.g., NCR POS, Salesforce Commerce Cloud, Oracle Retail). Used for data lineage and reconciliation.',
    `tax_treatment` STRING COMMENT 'Indicates whether this discount is applied before tax calculation (pre-tax), after tax calculation (post-tax), or if the discounted amount is tax-exempt.. Valid values are `pre_tax|post_tax|tax_exempt`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this discount can be combined with WIC benefits. True if eligible for WIC transactions, false otherwise.',
    CONSTRAINT pk_order_discount PRIMARY KEY(`order_discount_id`)
) COMMENT 'Discount and promotion application record for each discount applied to an order header or order line. Captures discount ID, linked order header, linked order line (nullable for header-level discounts), promotion reference, coupon code, discount type (TPR, BOGO, digital coupon, loyalty reward, ad circular, markdown, employee discount, EBT discount), discount amount, discount percentage, promo stack sequence (for stacked promotions), and applied timestamp. Enables promotion redemption tracking and GMROI analysis.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_payment` (
    `order_payment_id` BIGINT COMMENT 'Unique identifier for the payment tender record. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Tracks which bank account received the payment for reconciliation and cash‑management reporting.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: Needed for fraud analysis: associate each order payment with the stored tokenized payment method used, enabling compliance and recurring‑payment tracking.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the parent order header. Links this payment tender to the customer order it settles.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Required for audit: link each order payment record to its underlying payment transaction for settlement reconciliation and financial reporting.',
    `authorization_code` STRING COMMENT 'Authorization code returned by the payment processor or card issuer confirming approval of the transaction. Used for reconciliation and dispute resolution.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the payment authorization was received from the payment processor. Represents the real-world event time of payment approval.',
    `avs_response_code` STRING COMMENT 'Response code returned by the Address Verification Service (AVS) indicating the match result between billing address provided and address on file with card issuer. Used for fraud detection and risk management.',
    `bank_account_last_four_digits` STRING COMMENT 'Last four digits of the bank account number from the check. Applicable only when tender_type is check. Stored for reference while maintaining compliance with financial data protection standards.. Valid values are `^[0-9]{4}$`',
    `bank_routing_number` STRING COMMENT 'Nine-digit American Bankers Association (ABA) routing number from the check. Applicable only when tender_type is check. Used for electronic check verification and processing.. Valid values are `^[0-9]{9}$`',
    `billing_postal_code` STRING COMMENT 'Postal code associated with the billing address for the payment instrument. Used for Address Verification Service (AVS) fraud checks. Applicable to card-based tenders.',
    `card_last_four_digits` STRING COMMENT 'Last four digits of the payment card number. Used for customer reference and dispute resolution while maintaining Payment Card Industry Data Security Standard (PCI DSS) compliance by not storing full card number.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'Card network brand for credit and debit card tenders. Applicable only when tender_type is credit_card or debit_card.. Valid values are `visa|mastercard|amex|discover|other`',
    `cardholder_name` STRING COMMENT 'Name of the cardholder as it appears on the payment card. Used for fraud detection and dispute resolution. Applicable to credit and debit card tenders.',
    `change_given_amount` DECIMAL(18,2) COMMENT 'Amount of change returned to the customer when payment_amount exceeds the order balance. Applicable primarily to cash tenders. Null for non-cash tenders or when exact payment is tendered.',
    `check_number` STRING COMMENT 'Check number from the paper check tendered. Applicable only when tender_type is check. Used for reconciliation and fraud detection.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment tender record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Supports multi-currency transactions in international operations.. Valid values are `^[A-Z]{3}$`',
    `cvv_response_code` STRING COMMENT 'Response code indicating whether the Card Verification Value (CVV) provided matched the value on file with the card issuer. Used for fraud detection. Applicable to card-not-present transactions.',
    `decline_reason_code` STRING COMMENT 'Code returned by the payment processor indicating why the payment was declined. Examples include insufficient_funds, invalid_card, expired_card, fraud_suspected. Applicable when settlement_status is declined.',
    `ebt_balance_remaining` DECIMAL(18,2) COMMENT 'Remaining balance on the Electronic Benefits Transfer (EBT) card after this transaction. Applicable only when tender_type is ebt_snap. Supports customer service inquiries and Supplemental Nutrition Assistance Program (SNAP) regulatory reporting requirements.',
    `fuel_reward_discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of fuel reward points applied as discount. Applicable only when tender_type is fuel_reward.',
    `fuel_reward_points_redeemed` STRING COMMENT 'Number of fuel reward loyalty points redeemed as payment toward this order. Applicable only when tender_type is fuel_reward. Supports fuel center operations and loyalty program reporting.',
    `gift_card_balance_remaining` DECIMAL(18,2) COMMENT 'Remaining balance on the gift card after this transaction. Applicable only when tender_type is gift_card. Supports customer service inquiries.',
    `gift_card_number` STRING COMMENT 'Masked or tokenized gift card number. Applicable only when tender_type is gift_card. Stored in compliance with Payment Card Industry Data Security Standard (PCI DSS) tokenization requirements.',
    `mobile_wallet_type` STRING COMMENT 'Type of mobile wallet used for payment. Applicable only when tender_type is mobile_wallet.. Valid values are `apple_pay|google_pay|samsung_pay|other`',
    `payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount applied from this payment tender toward the order total. For split-tender transactions, this represents the portion paid by this specific instrument. Expressed in the transaction currency.',
    `payment_channel` STRING COMMENT 'Channel or interface through which the payment was captured. Point of Sale (POS) for in-store register transactions; ecommerce for web storefront; mobile_app for native app checkout; kiosk for self-service terminals; phone for call center orders; curbside_terminal for pickup payment devices.. Valid values are `pos|ecommerce|mobile_app|kiosk|phone|curbside_terminal`',
    `payment_gateway` STRING COMMENT 'Name or identifier of the payment gateway or processor that handled this transaction. Examples include First Data, Worldpay, Stripe, or internal processor identifiers.',
    `payment_processor_reference` STRING COMMENT 'Unique transaction identifier assigned by the external payment processor or gateway. Used for reconciliation, dispute resolution, and cross-system traceability.',
    `payment_sequence_number` STRING COMMENT 'Sequential number of this payment tender within the order. Supports split-tender transactions where multiple payment instruments are applied to a single order.',
    `refund_reason_code` STRING COMMENT 'Code indicating the reason for refund when settlement_status is refunded. Examples include customer_request, damaged_goods, pricing_error, order_cancellation. Used for refund analytics and fraud detection.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed. Applicable only when settlement_status is refunded.',
    `settlement_status` STRING COMMENT 'Current state of the payment in the settlement lifecycle. Authorized indicates approval but funds not yet captured; captured indicates funds reserved; settled indicates funds transferred to merchant account; voided indicates authorization cancelled before capture; refunded indicates funds returned to customer; declined indicates payment rejected; pending indicates awaiting processor response. [ENUM-REF-CANDIDATE: authorized|captured|settled|voided|refunded|declined|pending — 7 candidates stripped; promote to reference product]',
    `snap_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of the order total that qualifies for Supplemental Nutrition Assistance Program (SNAP) Electronic Benefits Transfer (EBT) payment. Applicable when tender_type is ebt_snap. Required for SNAP regulatory reporting and compliance audits.',
    `tender_type` STRING COMMENT 'Type of payment instrument used. Distinguishes between credit card, debit card, Electronic Benefits Transfer (EBT) for Supplemental Nutrition Assistance Program (SNAP), Women Infants and Children (WIC) voucher, mobile wallet (Apple Pay, Google Pay), gift card, fuel reward points, cash, or check. [ENUM-REF-CANDIDATE: credit_card|debit_card|ebt_snap|wic|mobile_wallet|gift_card|fuel_reward|cash|check — 9 candidates stripped; promote to reference product]',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added by the customer for delivery or service. Applicable primarily to delivery and curbside pickup orders. Null when no tip is provided.',
    `tokenized_payment_instrument` STRING COMMENT 'Payment Card Industry Data Security Standard (PCI DSS) compliant token representing the payment instrument. Used for recurring payments and stored payment methods without retaining sensitive card data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment tender record was last modified. Used for audit trail and change tracking.',
    `wic_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of the order total that qualifies for Women Infants and Children (WIC) program payment. Applicable when tender_type is wic. Required for WIC program reporting.',
    `wic_voucher_number` STRING COMMENT 'Unique voucher or authorization number for Women Infants and Children (WIC) program payment. Applicable only when tender_type is wic. Required for WIC program reconciliation and state reporting.',
    CONSTRAINT pk_order_payment PRIMARY KEY(`order_payment_id`)
) COMMENT 'Payment tender record for each payment instrument applied to a customer order. Captures payment ID, linked order header, tender type (credit, debit, EBT/SNAP, WIC, mobile wallet, gift card, fuel reward, cash, check), card type (Visa/MC/Amex), last four digits, authorization code, authorization timestamp, settlement status, payment amount, change given, EBT balance remaining (for EBT tenders), and payment processor reference. Supports PCI DSS compliance and SNAP/WIC regulatory reporting. References order_header as the single parent — no dual-FK pattern.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_refund` (
    `order_refund_id` BIGINT COMMENT 'Unique identifier for the refund transaction record. Primary key for the order_refund product.',
    `associate_id` BIGINT COMMENT 'Foreign key reference to the workforce associate who authorized and approved the refund transaction. Required for audit trail and accountability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Refunds are expense entries that require a GL account for proper accounting and audit trails.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the original order header for which this refund was issued. Links the refund back to the parent order transaction.',
    `payment_transaction_id` BIGINT COMMENT 'External payment processor transaction identifier for the refund payment. Used for payment reconciliation and dispute resolution.',
    `primary_order_payment_transaction_id` BIGINT COMMENT 'External payment processor transaction identifier from the original order. Used to link refund back to original payment for reconciliation and chargeback prevention.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Financial reconciliation of refunds by campaign for GMROI calculations; promotion_code_reversed is a denormalized code.',
    `shopper_id` BIGINT COMMENT 'Foreign key reference to the customer who requested the refund. May differ from the original order customer in cases of gift returns.',
    `store_location_id` BIGINT COMMENT 'Foreign key reference to the store location where the refund was processed. Applicable for in-store and curbside refunds.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was first created in the system. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund transaction (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_score` STRING COMMENT 'Optional post-refund satisfaction rating provided by customer, typically on a scale of 1-5. Used to measure refund experience quality. Null if not collected.',
    `denial_reason` STRING COMMENT 'Free-text explanation for why the refund request was denied. Null if refund was approved. Used for customer communication and policy compliance.',
    `exception_approval_level` STRING COMMENT 'Authorization level required to approve this refund if it was a policy exception. Null if no exception was needed.. Valid values are `associate|supervisor|store_manager|district_manager|corporate`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical fraud risk score assigned by fraud detection system, typically 0-100 where higher values indicate greater fraud likelihood. Null if fraud scoring not applied.',
    `inventory_disposition` STRING COMMENT 'Action taken with the returned inventory. Restock returns item to sellable inventory, damage_out records shrink, donate sends to charity, dispose discards, vendor_return sends back to supplier.. Valid values are `restock|damage_out|donate|dispose|vendor_return`',
    `is_fraudulent` BOOLEAN COMMENT 'Boolean indicator whether this refund was flagged as potentially fraudulent by fraud detection systems or manual review. Used for loss prevention analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was last updated. Used for change tracking and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `loyalty_points_reversed` STRING COMMENT 'Number of loyalty program points deducted from customer account due to this refund. Zero if no loyalty points were earned on original purchase or if points not reversed.',
    `original_payment_method` STRING COMMENT 'Payment instrument used in the original order transaction. Captured to support original tender refund processing. SNAP = Supplemental Nutrition Assistance Program, WIC = Women Infants and Children Program, EBT = Electronic Benefits Transfer. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|check|gift_card|store_credit|ebt|snap|wic — 9 candidates stripped; promote to reference product]',
    `policy_exception_flag` BOOLEAN COMMENT 'Boolean indicator whether this refund required an exception to standard return policy (e.g., outside return window, no receipt, final sale item). Requires manager approval.',
    `receipt_number` STRING COMMENT 'Original receipt number provided by customer to validate the purchase. Used for no-receipt return policy enforcement and fraud prevention.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total monetary value being refunded to the customer, including product cost and applicable taxes. Expressed in the transaction currency.',
    `refund_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was approved by an authorized associate or automated system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refund_channel` STRING COMMENT 'Business channel through which the refund was initiated. POS = Point of Sale for in-store refunds.. Valid values are `pos|online|mobile_app|customer_service|pharmacy|curbside`',
    `refund_denied_timestamp` TIMESTAMP COMMENT 'Date and time when the refund request was denied. Null if refund was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refund_method` STRING COMMENT 'Payment instrument used to return funds to the customer. Original tender returns to the same payment method used for purchase. EBT = Electronic Benefits Transfer.. Valid values are `original_tender|store_credit|gift_card|cash|check|ebt`',
    `refund_notes` STRING COMMENT 'Free-text notes captured by the associate processing the refund. May include additional context, customer comments, or special handling instructions.',
    `refund_number` STRING COMMENT 'Externally visible business identifier for the refund transaction. Used for customer communication and tracking. Format: RFN followed by 10 digits.. Valid values are `^RFN[0-9]{10}$`',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund payment was successfully processed and funds were returned to the customer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refund_reason_code` STRING COMMENT 'Standardized code indicating the business reason for issuing the refund. Used for root cause analysis, shrink tracking, and operational improvement. OOS = Out of Stock. [ENUM-REF-CANDIDATE: damaged|wrong_item|oos|customer_dissatisfaction|spoilage|quality_issue|pricing_error|duplicate_charge|delivery_failure|expired_product — 10 candidates stripped; promote to reference product]',
    `refund_requested_timestamp` TIMESTAMP COMMENT 'Date and time when the customer initiated the refund request. Represents the start of the refund lifecycle. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refund_status` STRING COMMENT 'Current lifecycle state of the refund transaction. Tracks progression from initial request through final settlement or denial.. Valid values are `requested|approved|processed|denied|cancelled|reversed`',
    `refund_subtotal` DECIMAL(18,2) COMMENT 'Refund amount before taxes. Represents the product cost portion of the refund.',
    `refund_tax_amount` DECIMAL(18,2) COMMENT 'Portion of the refund amount representing sales tax or other applicable taxes being returned to the customer.',
    `refund_type` STRING COMMENT 'Classification of the refund scope. Full refund returns entire order value, partial refund returns a portion of order value, line-level refund returns specific line items only.. Valid values are `full|partial|line_level`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to customer for processing the return, if applicable per store policy. Deducted from the refund amount. Zero if no restocking fee applies.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost of shipping the returned items back to the retailer for online/delivery orders. May be absorbed by retailer or charged to customer depending on policy.',
    `return_window_days` STRING COMMENT 'Number of days between original order date and refund request date. Used to enforce return policy time limits and analyze return patterns.',
    `shrink_flag` BOOLEAN COMMENT 'Boolean indicator whether this refund contributes to inventory shrink (loss from theft, spoilage, or damage). True if item cannot be restocked.',
    CONSTRAINT pk_order_refund PRIMARY KEY(`order_refund_id`)
) COMMENT 'Refund and return transaction record for orders where items are returned or credits are issued. Captures refund ID, linked original order header, refund type (full/partial/line-level), refund reason code (damaged, wrong item, OOS, customer dissatisfaction, spoilage), refund amount, refund method (original tender, store credit, gift card), refund status (requested, approved, processed, denied), approving associate ID, and refund timestamp. Supports shrink tracking and customer satisfaction management. References order_header as the single parent.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`rx_order` (
    `rx_order_id` BIGINT COMMENT 'Unique identifier for the pharmacy prescription order record. Primary key representing the purchase-event view of an Rx fill within the order domain.',
    `associate_id` BIGINT COMMENT 'Reference to the licensed pharmacist who verified and dispensed the prescription.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header for combined grocery and pharmacy orders. Links the Rx order to the overall customer order transaction.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Regulatory reporting requires each Rx order to be linked to the specific pharmacy location that dispensed it for state compliance and inventory tracking.',
    `pharmacy_patient_id` BIGINT COMMENT 'Reference to the pharmacy patient record. Links the Rx order to the patient receiving the medication.',
    `rx_claim_id` BIGINT COMMENT 'Reference identifier for the insurance claim submitted for this prescription fill. Links to third-party payer adjudication.',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether the medication is a controlled substance requiring DEA reporting and special handling.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Patient copayment amount in USD for this prescription fill after insurance adjudication.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this Rx order record was first created in the system.',
    `days_supply` STRING COMMENT 'Number of days the dispensed medication is intended to last based on prescribed dosing instructions.',
    `dea_schedule` STRING COMMENT 'DEA classification schedule for controlled substances (II through V). Non-controlled medications are marked as Non_Controlled.. Valid values are `Schedule_II|Schedule_III|Schedule_IV|Schedule_V|Non_Controlled`',
    `delivery_method` STRING COMMENT 'Method by which the prescription was delivered to the patient: in-store pickup, curbside pickup, home delivery, or mail order.. Valid values are `pickup|curbside|home_delivery|mail_order`',
    `dispensed_timestamp` TIMESTAMP COMMENT 'Date and time the prescription was picked up or delivered to the patient.',
    `dispensing_fee` DECIMAL(18,2) COMMENT 'Professional fee charged by the pharmacy for dispensing services in USD.',
    `drug_form` STRING COMMENT 'Physical form of the medication dispensed (tablet, capsule, liquid, etc.). [ENUM-REF-CANDIDATE: tablet|capsule|liquid|injection|cream|ointment|inhaler|patch|suppository|suspension|solution — 11 candidates stripped; promote to reference product]',
    `drug_name` STRING COMMENT 'Brand or generic name of the medication dispensed to the patient.',
    `drug_ndc_code` STRING COMMENT 'Eleven-digit National Drug Code identifying the specific drug product dispensed. FDA-assigned unique identifier for drugs.. Valid values are `^[0-9]{11}$`',
    `drug_strength` STRING COMMENT 'Dosage strength of the medication (e.g., 500mg, 10mcg). Includes unit of measure.',
    `fill_number` STRING COMMENT 'Sequential number indicating which fill this is for the prescription (1 for initial fill, 2+ for refills).',
    `fill_status` STRING COMMENT 'Current status of the prescription fill in the pharmacy workflow: received, in clinical verification, ready for patient pickup, dispensed to patient, on hold, cancelled, or returned. [ENUM-REF-CANDIDATE: received|in_verification|ready_for_pickup|dispensed|on_hold|cancelled|returned — 7 candidates stripped; promote to reference product]',
    `fill_timestamp` TIMESTAMP COMMENT 'Date and time the prescription was filled and verified by the pharmacist.',
    `fill_type` STRING COMMENT 'Classification of the prescription fill event: new prescription, refill of existing prescription, transfer from another pharmacy, transfer to another pharmacy, or partial fill.. Valid values are `new|refill|transfer_in|transfer_out|partial_fill`',
    `insurance_bin_number` STRING COMMENT 'Six-digit Bank Identification Number identifying the patients insurance processor for electronic claims routing.. Valid values are `^[0-9]{6}$`',
    `insurance_group_number` STRING COMMENT 'Group identifier for the patients insurance plan, typically employer or organization-specific.',
    `insurance_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by insurance in USD for this prescription fill after adjudication.',
    `insurance_pcn` STRING COMMENT 'Processor Control Number used by insurance plans to route claims to specific benefit plans.',
    `mckesson_rx_system_ref` STRING COMMENT 'Source system identifier from McKesson Pharmacy Systems for this prescription order record.',
    `original_drug_ndc_code` STRING COMMENT 'NDC code of the originally prescribed drug if a generic substitution was made.. Valid values are `^[0-9]{11}$`',
    `prescriber_name` STRING COMMENT 'Full name of the healthcare provider who prescribed the medication.',
    `prescriber_npi` STRING COMMENT 'Ten-digit National Provider Identifier for the prescribing healthcare provider. Required for insurance claims and regulatory compliance.. Valid values are `^[0-9]{10}$`',
    `prescription_expiration_date` DATE COMMENT 'Date after which the prescription is no longer valid for filling or refilling.',
    `prescription_number` STRING COMMENT 'Unique prescription identifier assigned by the pharmacy system. Used for prescription tracking, refill management, and regulatory reporting.. Valid values are `^[A-Z0-9]{7,15}$`',
    `prescription_received_timestamp` TIMESTAMP COMMENT 'Date and time the prescription was received by the pharmacy (electronically, by phone, or in person).',
    `prescription_written_date` DATE COMMENT 'Date the prescription was originally written by the prescriber.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Number of units of medication dispensed to the patient (e.g., number of tablets, milliliters of liquid).',
    `refills_remaining` STRING COMMENT 'Number of authorized refills remaining on the prescription after this fill.',
    `sig_code` STRING COMMENT 'Prescription directions for use (Sig) provided to the patient. Instructions on how to take the medication.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether generic substitution was permitted by the prescriber for this prescription.',
    `substitution_occurred_flag` BOOLEAN COMMENT 'Indicates whether a generic substitution was actually made when filling this prescription.',
    `total_price` DECIMAL(18,2) COMMENT 'Total price charged for the prescription fill in USD before insurance coverage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this Rx order record was last modified in the system.',
    CONSTRAINT pk_rx_order PRIMARY KEY(`rx_order_id`)
) COMMENT 'Pharmacy prescription order record representing the purchase-event view of an Rx fill within the order domain. Captures Rx order ID, linked order header (for combined grocery+pharmacy orders), prescription number, patient reference, prescriber NPI, drug NDC code, drug name, quantity dispensed, days supply, fill type (new/refill/transfer), fill status (received, in-verification, filled, ready, dispensed, on-hold, cancelled), controlled substance schedule (DEA Schedule II-V flag), insurance claim reference, copay amount, and McKesson Rx system reference. This entity owns the ORDER-SIDE view of the Rx transaction (purchase event, payment, order status); the pharmacy domain owns the CLINICAL-SIDE (drug utilization review, patient counseling, clinical verification, controlled substance DEA reporting). Integrates with McKesson Pharmacy Systems.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_substitution` (
    `order_substitution_id` BIGINT COMMENT 'Unique identifier for the order substitution record. Primary key.',
    `node_id` BIGINT COMMENT 'Foreign key reference to the store, distribution center, or micro-fulfillment center where the substitution occurred.',
    `associate_id` BIGINT COMMENT 'Foreign key reference to the store associate or picker who made the substitution decision during order fulfillment. Null for system-automated substitutions.',
    `product_order_line_id` BIGINT COMMENT 'Foreign key reference to the order line item that required substitution. Links to the specific line item in the order that was out of stock or unavailable.',
    `brand_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute item is from the same brand as the original item.',
    `category_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute item is from the same product category as the original item, supporting substitution quality analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this substitution record was first created in the data platform.',
    `customer_acceptance_status` STRING COMMENT 'The customers response to the substitution offer. ACCEPTED=Customer explicitly accepted, REJECTED=Customer declined substitute, PENDING=Awaiting customer response, AUTO_ACCEPTED=Accepted per customer preferences, NOT_REQUIRED=No acceptance needed per business rules.. Valid values are `ACCEPTED|REJECTED|PENDING|AUTO_ACCEPTED|NOT_REQUIRED`',
    `customer_feedback_comments` STRING COMMENT 'Free-text comments provided by the customer regarding the substitution experience.',
    `customer_notification_method` STRING COMMENT 'The channel used to notify the customer about the substitution. APP=Mobile app notification, SMS=Text message, EMAIL=Email notification, PHONE=Phone call, NONE=No notification sent.. Valid values are `APP|SMS|EMAIL|PHONE|NONE`',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the customer was notified about the substitution. Null if no notification was sent.',
    `customer_response_timestamp` TIMESTAMP COMMENT 'The date and time when the customer provided their acceptance or rejection response. Null if no response received or not required.',
    `customer_satisfaction_rating` STRING COMMENT 'Customer-provided rating (1-5 scale) of their satisfaction with the substitution. Null if customer has not provided feedback.',
    `inventory_snapshot_timestamp` TIMESTAMP COMMENT 'The timestamp when inventory levels were checked for the original item, capturing the point-in-time inventory state that led to the OOS condition.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the substitution from store associates, customer service, or system processes.',
    `original_gtin` STRING COMMENT 'The GTIN (UPC/EAN) of the originally ordered product that was unavailable. Supports 8, 12, 13, or 14 digit formats.. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `original_item_stock_level` STRING COMMENT 'The on-hand inventory quantity of the original item at the fulfillment location at the time of substitution decision.',
    `original_product_name` STRING COMMENT 'The display name of the originally ordered product for customer communication and reporting.',
    `original_quantity` DECIMAL(18,2) COMMENT 'The quantity of the original item that was ordered before substitution.',
    `original_sku` STRING COMMENT 'The SKU of the originally ordered item that was unavailable and required substitution.',
    `original_unit_price` DECIMAL(18,2) COMMENT 'The unit price of the originally ordered item at the time of order placement.',
    `price_difference_amount` DECIMAL(18,2) COMMENT 'The monetary difference between the original item and substitute item (substitute price minus original price). Negative values indicate customer savings, positive values indicate upcharge.',
    `price_protection_applied_flag` BOOLEAN COMMENT 'Indicates whether price protection was applied to ensure the customer was not charged more than the original item price, even if the substitute was more expensive.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary amount refunded to the customer related to this substitution. Null if no refund was issued.',
    `refund_issued_flag` BOOLEAN COMMENT 'Indicates whether a refund was issued to the customer due to substitution rejection or price difference.',
    `size_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute item has the same or comparable size/quantity as the original item.',
    `source_system` STRING COMMENT 'The operational system that originated this substitution record (e.g., OMS, WMS, POS).',
    `substitute_gtin` STRING COMMENT 'The GTIN (UPC/EAN) of the substitute product provided. Supports 8, 12, 13, or 14 digit formats.. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `substitute_item_stock_level` STRING COMMENT 'The on-hand inventory quantity of the substitute item at the fulfillment location at the time of substitution.',
    `substitute_product_name` STRING COMMENT 'The display name of the substitute product provided to the customer.',
    `substitute_quantity` DECIMAL(18,2) COMMENT 'The quantity of the substitute item provided to fulfill the order.',
    `substitute_sku` STRING COMMENT 'The SKU of the replacement item provided as a substitute.',
    `substitute_unit_price` DECIMAL(18,2) COMMENT 'The unit price of the substitute item at the time of substitution.',
    `substitution_approval_required_flag` BOOLEAN COMMENT 'Indicates whether customer approval was required before proceeding with the substitution based on business rules and customer preferences.',
    `substitution_number` STRING COMMENT 'Business-facing identifier for the substitution event, used for customer service and tracking purposes.',
    `substitution_quality_score` DECIMAL(18,2) COMMENT 'A system-calculated score (0.00 to 5.00) representing the quality of the substitution match based on product attributes, category similarity, and customer preferences.',
    `substitution_reason_code` STRING COMMENT 'The primary reason the original item required substitution. OOS=Out of Stock, DAMAGED=Product damaged, RECALLED=Product recalled, EXPIRED=Product expired or near expiration, QUALITY=Quality issue identified, DISCONTINUED=Product discontinued.. Valid values are `OOS|DAMAGED|RECALLED|EXPIRED|QUALITY|DISCONTINUED`',
    `substitution_reason_description` STRING COMMENT 'Detailed free-text explanation of why the substitution was necessary, providing additional context beyond the reason code.',
    `substitution_timestamp` TIMESTAMP COMMENT 'The date and time when the substitution decision was made and recorded in the system.',
    `substitution_type` STRING COMMENT 'The method by which the substitution was determined. AUTO_SYSTEM=Automatically selected by system algorithm, PICKER_SELECTED=Chosen by store associate or picker during fulfillment, CUSTOMER_PREAPPROVED=Customer pre-authorized substitutions in preferences, CUSTOMER_REQUESTED=Customer specifically requested this substitute.. Valid values are `AUTO_SYSTEM|PICKER_SELECTED|CUSTOMER_PREAPPROVED|CUSTOMER_REQUESTED`',
    CONSTRAINT pk_order_substitution PRIMARY KEY(`order_substitution_id`)
) COMMENT 'Item substitution record capturing instances where an ordered SKU was unavailable (OOS) and replaced with an alternative item during fulfillment. Captures substitution ID, linked order line, original SKU/GTIN, substitute SKU/GTIN, substitution reason (OOS, damaged, recalled), substitution type (auto-substituted by system, picker-selected, customer pre-approved), customer notification method (app/SMS/email), customer acceptance status (accepted, rejected, pending), price difference amount, and substitution timestamp. Supports OOS root cause analysis and customer experience improvement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`storefront` (
    `storefront_id` BIGINT COMMENT 'Unique identifier for the digital storefront channel. Primary key.',
    `price_book_id` BIGINT COMMENT 'Identifier of the price book applied to this storefront. Determines pricing for products based on channel, region, or customer segment.',
    `accepted_tender_types` STRING COMMENT 'Comma-separated list of payment tender types accepted on this storefront (e.g., credit_card,debit_card,ebt,snap,wic,gift_card,mobile_wallet). Drives checkout payment options. [ENUM-REF-CANDIDATE: credit_card|debit_card|ebt|snap|wic|gift_card|mobile_wallet|cash|check — promote to reference product]',
    `age_verification_required_flag` BOOLEAN COMMENT 'Indicates whether age verification is required for certain product categories (e.g., alcohol, tobacco, pharmacy) on this storefront.',
    `api_endpoint_url` STRING COMMENT 'Base URL for the storefront API endpoint. Used by mobile apps and third-party integrations to interact with the storefront.',
    `brand_name` STRING COMMENT 'Brand identity displayed on this storefront (e.g., Grocery, Grocery Fresh, Grocery Pharmacy). Supports multi-brand storefronts.',
    `catalog_id` STRING COMMENT 'Identifier of the product catalog syndicated to this storefront. Determines which SKUs (Stock Keeping Units) are available for purchase.',
    `channel_type` STRING COMMENT 'Type of digital channel this storefront represents. Determines device-specific behavior and feature availability.. Valid values are `web|mobile_app|kiosk|tablet|voice_assistant|smart_tv`',
    `contact_email` STRING COMMENT 'Primary customer service email address for this storefront. Used for customer inquiries and support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary customer service phone number for this storefront. Used for customer support and order inquiries.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code (e.g., USA, CAN, MEX). Determines regulatory compliance, payment methods, and fulfillment options.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the storefront record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code (e.g., USD, CAD, MXN). Default currency for pricing and transactions on this storefront.. Valid values are `^[A-Z]{3}$`',
    `ebt_eligible_flag` BOOLEAN COMMENT 'Indicates whether this storefront accepts EBT (Electronic Benefits Transfer) cards for payment.',
    `fulfillment_methods_supported` STRING COMMENT 'Comma-separated list of fulfillment methods available on this storefront (e.g., delivery,pickup,curbside,in_store). Drives checkout fulfillment options.',
    `guest_checkout_allowed_flag` BOOLEAN COMMENT 'Indicates whether customers can complete purchases without creating an account (guest checkout).',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (e.g., en, es, fr). Primary language for storefront content and customer communication.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the storefront record was last updated.',
    `launch_date` DATE COMMENT 'Date when the storefront was first made available to customers.',
    `locale_code` STRING COMMENT 'ISO locale code for language and region (e.g., en_US, es_MX, fr_CA). Drives language, currency, and regional content.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `loyalty_program_code` STRING COMMENT 'Code identifying the specific loyalty program integrated with this storefront (e.g., GROCERY_REWARDS, FUEL_POINTS). Null if no loyalty integration.',
    `loyalty_program_integrated_flag` BOOLEAN COMMENT 'Indicates whether the storefront is integrated with the customer loyalty program for points earning and redemption.',
    `maximum_cart_item_count` STRING COMMENT 'Maximum number of distinct line items allowed in a single cart. Null if no limit applies.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'Minimum subtotal required to place an order on this storefront. Null if no minimum applies.',
    `personalization_enabled_flag` BOOLEAN COMMENT 'Indicates whether AI-driven personalization features (product recommendations, personalized promotions) are enabled on this storefront.',
    `platform` STRING COMMENT 'Operating system or platform for the storefront (e.g., iOS, Android, Web Desktop). Applicable primarily to mobile apps and platform-specific web experiences. [ENUM-REF-CANDIDATE: ios|android|web_desktop|web_mobile|windows|linux|macos — 7 candidates stripped; promote to reference product]',
    `promotion_engine_enabled_flag` BOOLEAN COMMENT 'Indicates whether the promotion engine is active on this storefront for applying discounts, coupons, and promotional offers.',
    `search_enabled_flag` BOOLEAN COMMENT 'Indicates whether product search functionality is enabled on this storefront.',
    `sla_target_delivery_hours` STRING COMMENT 'Target time in hours from order placement to delivery completion for delivery orders on this storefront. Null if delivery not supported.',
    `sla_target_order_processing_minutes` STRING COMMENT 'Target time in minutes from order placement to order fulfillment start for this storefront. Used for performance monitoring and customer expectations.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this storefront accepts SNAP (Supplemental Nutrition Assistance Program) benefits as payment.',
    `storefront_code` STRING COMMENT 'Business-readable unique code for the storefront channel (e.g., WEB_US, MOBILE_IOS, KIOSK_INSTORE). Used for external integrations and reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `storefront_name` STRING COMMENT 'Human-readable name of the storefront channel (e.g., Grocery Web USA, Grocery Mobile App iOS, In-Store Kiosk).',
    `storefront_status` STRING COMMENT 'Current operational status of the storefront. Active storefronts are live and accepting orders; sunset storefronts are being phased out.. Valid values are `active|inactive|pending_launch|sunset|maintenance`',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether product substitutions are allowed by default for out-of-stock items on this storefront.',
    `sunset_date` DATE COMMENT 'Planned or actual date when the storefront will be or was decommissioned. Null for active storefronts with no planned sunset.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction for this storefront. Determines sales tax calculation rules and rates.',
    `theme_code` STRING COMMENT 'Visual theme or branding template applied to the storefront (e.g., default, holiday_2024, pharmacy_blue). Controls UI/UX appearance.',
    `timezone` STRING COMMENT 'IANA timezone identifier (e.g., America/New_York, America/Los_Angeles). Used for scheduling, promotions, and time-sensitive features.',
    `url` STRING COMMENT 'Public-facing URL for the storefront (e.g., https://www.grocery.com, https://m.grocery.com). Null for non-web channels like mobile apps.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this storefront accepts WIC (Women, Infants, and Children) vouchers as payment.',
    CONSTRAINT pk_storefront PRIMARY KEY(`storefront_id`)
) COMMENT 'Master record for each digital storefront channel operated by Grocery, including web, mobile app (iOS, Android), and kiosk surfaces. Captures storefront identity, locale and language configuration, supported payment methods, feature flags and feature toggles, channel-specific branding, minimum order thresholds, accepted tender types (credit, EBT, SNAP, WIC, gift card), fulfillment method availability, loyalty integration settings, launch/sunset dates, age-verification requirements, SNAP/EBT acceptance configuration, maximum cart item count, and channel-specific SLA targets. Each storefront maps to a distinct omnichannel touchpoint and drives catalog syndication, personalization rules, runtime checkout behavior, and OMS routing logic via Salesforce Commerce Cloud. This is the single configuration master for all channel-level settings — no separate channel configuration entity exists.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`catalog` (
    `catalog_id` BIGINT COMMENT 'Primary key for catalog',
    `category_id` BIGINT COMMENT 'Reference to the primary category this item belongs to in the digital catalog hierarchy. Used for navigation and merchandising.',
    `storefront_id` BIGINT COMMENT 'Reference to the digital storefront channel this catalog serves (e.g., web, mobile app, kiosk). Each catalog is tied to a specific storefront and may differ by channel.',
    `age_restricted_flag` BOOLEAN COMMENT 'Indicates whether the product requires age verification for purchase (e.g., alcohol, tobacco, certain medications). Triggers age verification workflow at checkout.',
    `allergen_warnings` STRING COMMENT 'Comma-separated list of allergen warnings (e.g., Contains: Milk, Eggs, Peanuts). Critical for customer safety and regulatory compliance.',
    `availability_end_date` DATE COMMENT 'The date when this item will no longer be available for online purchase. Used for limited-time offers and seasonal discontinuation.',
    `availability_start_date` DATE COMMENT 'The date when this item becomes available for online purchase. Used for scheduled product launches and seasonal items.',
    `brand_name` STRING COMMENT 'The brand name of the product. Used for filtering, faceted search, and brand-specific merchandising.',
    `catalog_name` STRING COMMENT 'The primary display name of the product as shown on the digital storefront. Optimized for customer-facing presentation and search.',
    `catalog_status` STRING COMMENT 'Current lifecycle status of the item in the digital catalog. Indicates whether the item is available for online shopping, temporarily unavailable, or removed from the digital assortment.. Valid values are `active|inactive|pending|discontinued|seasonal`',
    `category_path` STRING COMMENT 'Hierarchical category path for navigation (e.g., Grocery > Dairy > Milk > Organic). Defines where the product appears in the digital storefront taxonomy.',
    `channel_exclusion_flag` BOOLEAN COMMENT 'Indicates whether this item is excluded from certain channels (e.g., kiosk catalog may exclude alcohol). True means channel-specific restrictions apply.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this catalog record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the display price (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `display_price` DECIMAL(18,2) COMMENT 'The price displayed to customers on the digital storefront. May differ from the base price due to promotions, channel-specific pricing, or personalized offers.',
    `excluded_channels` STRING COMMENT 'Comma-separated list of channel codes where this item is not available (e.g., KIOSK, MOBILE_APP). Used to enforce channel-specific assortment rules.',
    `featured_flag` BOOLEAN COMMENT 'Indicates whether this product is featured in promotional placements, homepage carousels, or special merchandising zones.',
    `gluten_free_flag` BOOLEAN COMMENT 'Indicates whether the product is certified or labeled gluten-free. Used for dietary filtering and allergen management.',
    `hero_image_url` STRING COMMENT 'URL of the primary product image displayed prominently on the product detail page and in featured placements.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this catalog record was last updated. Used for change tracking and synchronization with source systems.',
    `long_description` STRING COMMENT 'Detailed rich product description displayed on the product detail page. May include HTML formatting, nutritional information, usage instructions, and ingredient lists.',
    `merchandising_rank` STRING COMMENT 'Numeric rank used to control the display order of products within a category. Lower numbers appear first. Used for strategic product placement.',
    `minimum_age_required` STRING COMMENT 'The minimum age required to purchase this product (e.g., 18, 21). Null if no age restriction applies.',
    `new_arrival_flag` BOOLEAN COMMENT 'Indicates whether this product is marked as a new arrival. Used for New Items merchandising and filtering.',
    `nutritional_callouts` STRING COMMENT 'Marketing callouts highlighting nutritional benefits (e.g., High Protein, Low Sodium, No Added Sugar). Used for merchandising and filtering.',
    `online_availability_flag` BOOLEAN COMMENT 'Indicates whether the item is currently available for purchase through the digital channel. True means the item can be added to cart and ordered online.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether the product is certified organic. Important for customer filtering and regulatory compliance.',
    `package_size` STRING COMMENT 'The size or quantity of the product package as displayed to customers (e.g., 12 oz, 1 gallon, 6-pack). Used for customer decision-making.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether the product is perishable and requires temperature-controlled handling. Affects fulfillment method and delivery logistics.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this is a store-owned brand (private label) product. True for private label, false for national brands.',
    `search_boost_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00-999.99) used to boost or demote this item in search results. Higher scores increase prominence in search rankings.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and synonyms to improve product discoverability in site search. Includes common misspellings and alternate terms.',
    `short_description` STRING COMMENT 'Brief product description used in search results, category listings, and mobile views. Typically 100-200 characters.',
    `sku` STRING COMMENT 'The unique product identifier (Stock Keeping Unit) representing the item in the digital catalog. This is the commerce-layer view of what is shoppable online, distinct from the physical product master.. Valid values are `^[A-Z0-9]{6,20}$`',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether the product is eligible for purchase using SNAP benefits (formerly food stamps). Required for government assistance program compliance.',
    `source_system` STRING COMMENT 'The source system that provided this catalog data (e.g., Salesforce Commerce Cloud, Oracle Retail). Used for data lineage and troubleshooting.',
    `temperature_zone` STRING COMMENT 'The required storage and handling temperature zone for the product. Critical for cold chain management and fulfillment operations.. Valid values are `ambient|refrigerated|frozen`',
    `thumbnail_image_url` STRING COMMENT 'URL of the thumbnail image used in search results, category grids, and cart views.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the product as sold online (e.g., each, pound, gallon). Important for pricing and quantity selection. [ENUM-REF-CANDIDATE: each|lb|oz|kg|g|gal|qt|pt|fl_oz|l|ml|dozen|case — 13 candidates stripped; promote to reference product]',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether the product is eligible for purchase using WIC benefits. Required for government assistance program compliance.',
    CONSTRAINT pk_catalog PRIMARY KEY(`catalog_id`)
) COMMENT 'Syndicated digital product catalog representing the online-available assortment for a specific storefront channel. Manages item eligibility for eCommerce, digital shelf presentation attributes (hero images, rich descriptions, nutritional callouts, allergen warnings), search boost scores, category navigation hierarchy, and availability windows. Each catalog is tied to a storefront and may differ by channel (e.g., kiosk catalog may exclude alcohol). Distinct from the physical product master in the product domain — this is the commerce-layer view of what is shoppable online.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`web_session` (
    `web_session_id` BIGINT COMMENT 'Unique identifier for the web session. Primary key.',
    `ab_test_experiment_id` BIGINT COMMENT 'Identifier of the A/B test or multivariate experiment the session was assigned to for personalization and testing.',
    `order_header_id` BIGINT COMMENT 'Identifier of the order placed during this session, if conversion occurred. Null if no order was placed.',
    `shopper_id` BIGINT COMMENT 'Identifier of the authenticated shopper. Null for guest sessions.',
    `store_location_id` BIGINT COMMENT 'Identifier of the preferred or selected store for click-and-collect or curbside pickup during the session. Null if no store selected.',
    `ab_test_variant` STRING COMMENT 'Specific variant or treatment group assigned to the session within the A/B test experiment (e.g., control, variant_a, variant_b).',
    `add_to_cart_count` STRING COMMENT 'Number of times items were added to the shopping cart during the session.',
    `authentication_status` STRING COMMENT 'Indicates whether the session is authenticated (logged-in shopper), guest (identified but not logged in), or anonymous (no identification).. Valid values are `authenticated|guest|anonymous`',
    `browser_name` STRING COMMENT 'Name of the web browser used (e.g., Chrome, Safari, Firefox, Edge).',
    `browser_version` STRING COMMENT 'Version number of the browser used during the session.',
    `cart_abandonment_flag` BOOLEAN COMMENT 'Indicates whether the session ended with items in the cart but no order placed (True) or not (False).',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether the session resulted in a completed order (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was first created in the system.',
    `device_fingerprint` STRING COMMENT 'Unique fingerprint hash of the device based on browser and OS characteristics for tracking and fraud detection.',
    `device_type` STRING COMMENT 'Type of device used for the session: desktop, mobile, tablet, smart TV, wearable, or other.. Valid values are `desktop|mobile|tablet|smart_tv|wearable|other`',
    `entry_source` STRING COMMENT 'Source channel through which the session was initiated (e.g., organic search, paid media, email campaign, loyalty app deep link, social media, direct).',
    `entry_source_category` STRING COMMENT 'High-level categorization of the entry source: organic, paid, email, social, direct, referral, or affiliate. [ENUM-REF-CANDIDATE: organic|paid|email|social|direct|referral|affiliate — 7 candidates stripped; promote to reference product]',
    `exit_page_url` STRING COMMENT 'URL of the last page viewed before the session ended.',
    `geolocation_city` STRING COMMENT 'City name derived from IP geolocation.',
    `geolocation_country_code` STRING COMMENT 'Three-letter country code derived from IP geolocation.. Valid values are `^[A-Z]{3}$`',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the session origin based on IP geolocation.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the session origin based on IP geolocation.',
    `geolocation_postal_code` STRING COMMENT 'Postal code derived from IP geolocation.',
    `geolocation_state` STRING COMMENT 'State or province code derived from IP geolocation.',
    `ip_address` STRING COMMENT 'IP address of the device initiating the session. May be IPv4 or IPv6.',
    `landing_page_url` STRING COMMENT 'URL of the first page viewed in the session.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was last updated.',
    `loyalty_app_session_flag` BOOLEAN COMMENT 'Indicates whether the session originated from the loyalty mobile app (True) or web browser (False).',
    `operating_system` STRING COMMENT 'Operating system of the device (e.g., Windows, macOS, iOS, Android, Linux).',
    `operating_system_version` STRING COMMENT 'Version number of the operating system.',
    `pages_viewed_count` STRING COMMENT 'Total number of pages viewed during the session.',
    `personalization_segment` STRING COMMENT 'Customer segment or persona assigned to the session for personalized content and merchandising.',
    `product_detail_views_count` STRING COMMENT 'Number of product detail pages viewed during the session.',
    `referring_url` STRING COMMENT 'Full URL of the referring page that directed the user to the site.',
    `search_query_count` STRING COMMENT 'Number of search queries executed during the session.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the session in seconds from start to end.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the session ended or was terminated.',
    `session_number` STRING COMMENT 'Business-readable session identifier or tracking number for customer service reference.',
    `session_outcome` STRING COMMENT 'Final outcome of the session: converted (order placed), abandoned (cart left), bounced (single page view), or browsing (multi-page without conversion).. Valid values are `converted|abandoned|bounced|browsing`',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the session was initiated. Principal business event timestamp for this session.',
    `session_status` STRING COMMENT 'Current lifecycle status of the session: active (in progress), completed (ended normally), abandoned (cart left without checkout), expired (timeout), bounced (single page view).. Valid values are `active|completed|abandoned|expired|bounced`',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter from the entry URL for campaign tracking.',
    `utm_content` STRING COMMENT 'UTM content parameter from the entry URL for A/B test or ad variant tracking.',
    `utm_medium` STRING COMMENT 'UTM medium parameter from the entry URL for campaign tracking.',
    `utm_source` STRING COMMENT 'UTM source parameter from the entry URL for campaign tracking.',
    `utm_term` STRING COMMENT 'UTM term parameter from the entry URL for paid search keyword tracking.',
    CONSTRAINT pk_web_session PRIMARY KEY(`web_session_id`)
) COMMENT 'Captures individual shopper browsing sessions across web and mobile app storefronts. Records session start/end timestamps, device type, browser/OS fingerprint, entry source (organic search, paid media, email campaign, loyalty app deep link, social), referring URL, geolocation, authenticated vs. guest status, pages visited count, product detail page views, and session outcome (converted, abandoned, bounced). Supports personalization, A/B test experiment assignment, conversion funnel analysis, and digital merchandising attribution. This is the commerce-owned session for shopping behavior — distinct from platform-level clickstream or security audit logs.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`cart` (
    `cart_id` BIGINT COMMENT 'Unique identifier for the shopping cart. Primary key for the cart entity.',
    `merged_from_cart_id` BIGINT COMMENT 'Reference to the previous cart that was merged into this cart for cross-device continuity. Null if cart was not created from a merge.',
    `shopper_id` BIGINT COMMENT 'Reference to the shopper who owns this cart. Links to the customer domain shopper entity.',
    `store_location_id` BIGINT COMMENT 'Reference to the store, distribution center (DC), or micro-fulfillment center (MFC) selected for order fulfillment. Links to store domain.',
    `web_session_id` BIGINT COMMENT 'Unique identifier for the digital session during which this cart was created or modified. Used for cross-device continuity and session analytics.',
    `abandonment_notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a cart abandonment recovery notification (email, SMS, push) has been sent to the shopper. True if sent, False otherwise.',
    `abandonment_notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart abandonment recovery notification was sent. Null if no notification sent. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `browser_type` STRING COMMENT 'Web browser or mobile app identifier used for the cart session (e.g., Chrome, Safari, iOS App). Used for technical support and analytics.',
    `cart_number` STRING COMMENT 'Human-readable business identifier for the cart, used for customer service and cart recovery campaigns.',
    `cart_status` STRING COMMENT 'Current lifecycle status of the shopping cart. Active indicates ongoing shopping session, checked_out indicates conversion to order, abandoned indicates cart left without checkout, expired indicates cart exceeded retention period, merged indicates cart combined with another session, saved indicates customer explicitly saved for later.. Valid values are `active|checked_out|abandoned|expired|merged|saved`',
    `cart_type` STRING COMMENT 'Classification of the cart based on its intended purpose. Standard for regular shopping, wishlist for saved items, subscription for recurring orders, quick_reorder for repeat purchase carts.. Valid values are `standard|wishlist|subscription|quick_reorder`',
    `checkout_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart was converted to an order through checkout completion. Null for carts that have not been checked out. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart was first created. Represents the start of the shopping session. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the cart (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `delivery_address_line1` STRING COMMENT 'First line of the delivery address (street number and name) for delivery fulfillment method. Null for pickup methods.',
    `delivery_address_line2` STRING COMMENT 'Second line of the delivery address (apartment, suite, unit) for delivery fulfillment method. Null for pickup methods.',
    `delivery_city` STRING COMMENT 'City name for the delivery address. Null for pickup methods.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery address (e.g., USA, CAN, MEX). Null for pickup methods.. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal code or ZIP code for the delivery address. Null for pickup methods.',
    `delivery_state` STRING COMMENT 'State or province code for the delivery address (e.g., CA, TX, ON). Null for pickup methods.',
    `device_type` STRING COMMENT 'Type of device used to create or last modify the cart. Used for channel analytics and cross-device behavior tracking.. Valid values are `desktop|mobile_web|mobile_app|tablet|kiosk`',
    `estimated_discount_amount` DECIMAL(18,2) COMMENT 'Estimated total discount amount applied to the cart from promotions, coupons, and loyalty rewards. Recalculated dynamically.',
    `estimated_subtotal_amount` DECIMAL(18,2) COMMENT 'Estimated subtotal of all items in the cart before discounts, taxes, and fees. Recalculated dynamically as cart contents change.',
    `estimated_tax_amount` DECIMAL(18,2) COMMENT 'Estimated sales tax amount for the cart based on selected fulfillment location and applicable tax jurisdictions. Final tax calculated at checkout.',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'Estimated grand total for the cart including subtotal, discounts, taxes, and fees. Represents the expected checkout amount.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart will expire and be eligible for purging. Typically set based on business retention policy (e.g., 30 days from last modification). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `fulfillment_method` STRING COMMENT 'Selected method for order fulfillment. Delivery for last-mile delivery (LMD), curbside_pickup for Click-and-Collect curbside, in_store_pickup for in-store collection, ship_to_home for parcel shipping.. Valid values are `delivery|curbside_pickup|in_store_pickup|ship_to_home`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart was last updated with item additions, removals, or quantity changes. Used for abandonment analytics and cart recovery timing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed and applied to this cart for discounts or rewards.',
    `promo_codes_applied` STRING COMMENT 'Comma-separated list of promotion codes or coupon codes applied to the cart. Used for discount calculation and campaign tracking.',
    `scheduled_fulfillment_date` DATE COMMENT 'Date selected by the shopper for order fulfillment (delivery or pickup). Format: yyyy-MM-dd.',
    `scheduled_fulfillment_window_end` STRING COMMENT 'End time of the selected fulfillment time window (e.g., 12:00 PM for a 10:00-12:00 delivery slot). Format: HH:mm.',
    `scheduled_fulfillment_window_start` STRING COMMENT 'Start time of the selected fulfillment time window (e.g., 10:00 AM for a 10:00-12:00 delivery slot). Format: HH:mm.',
    `source_system` STRING COMMENT 'Identifier of the source system that created or owns this cart record (e.g., Salesforce Commerce Cloud, Mobile App, Kiosk).',
    `special_instructions` STRING COMMENT 'Free-text field for shopper to provide special instructions for fulfillment (e.g., gate code, ripe bananas, contactless delivery).',
    `substitution_preference` STRING COMMENT 'Shopper preference for item substitutions when items are out of stock (OOS). Allow_all permits any substitute, allow_similar permits category-matched substitutes, contact_me requires shopper approval, no_substitutions rejects all substitutes.. Valid values are `allow_all|allow_similar|contact_me|no_substitutions`',
    `total_item_count` STRING COMMENT 'Total number of distinct Stock Keeping Units (SKUs) in the cart. Does not account for quantity per SKU, only unique items.',
    `total_unit_quantity` DECIMAL(18,2) COMMENT 'Total quantity of all items in the cart, accounting for quantities of each SKU. Supports fractional quantities for weight-based items (e.g., produce, deli).',
    CONSTRAINT pk_cart PRIMARY KEY(`cart_id`)
) COMMENT 'Represents an active or abandoned digital shopping cart for a shopper session. Tracks cart creation timestamp, last modified timestamp, cart status (active, checked_out, abandoned, expired, merged), total item count, estimated subtotal, applied promo codes, selected fulfillment method (delivery, curbside pickup, in-store pickup, ship-to-home), scheduled fulfillment slot reference, and cart merge history for cross-device continuity. Supports cart recovery campaigns, abandonment analytics, and order conversion measurement within Salesforce Commerce Cloud.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`cart_item` (
    `cart_item_id` BIGINT COMMENT 'Unique identifier for each line item within a digital shopping cart. Primary key for the cart_item product.',
    `cart_id` BIGINT COMMENT 'Reference to the parent shopping cart that contains this item. Links to the cart header entity.',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotion applied to this cart item. Links to the promotion master for details on discount rules, funding source, and promotion terms.',
    `web_session_id` BIGINT COMMENT 'Unique session identifier for the browsing session during which this item was added. Links cart activity to broader session behavior for journey analytics.',
    `added_timestamp` TIMESTAMP COMMENT 'Timestamp when this item was added to the cart. Critical for cart abandonment analysis, session analytics, and time-in-cart metrics.',
    `age_restricted_flag` BOOLEAN COMMENT 'Indicates whether this item requires age verification at checkout. Includes alcohol, tobacco, and certain over-the-counter medications.',
    `bogo_flag` BOOLEAN COMMENT 'Indicates whether this item is part of a buy-one-get-one promotion. Supports promotional compliance and basket analysis.',
    `category_code` STRING COMMENT 'Product category code within the department hierarchy. Supports assortment planning and category management analytics.. Valid values are `^[0-9]{2,6}$`',
    `coupon_code` STRING COMMENT 'Digital or manufacturer coupon code applied to this specific item. Captured for redemption tracking and vendor chargeback processing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this cart item. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Retail department code for merchandising classification. Used for category performance analysis and store layout optimization.. Valid values are `^[0-9]{2,4}$`',
    `device_type` STRING COMMENT 'Type of device used to add this item to cart. Enables device-specific user experience optimization and responsive design analytics.. Valid values are `desktop|mobile|tablet|smart_tv|voice_device`',
    `estimated_weight_lbs` DECIMAL(18,2) COMMENT 'Estimated weight of this cart item in pounds. Used for delivery route planning, vehicle capacity planning, and shipping cost estimation for variable-weight items.',
    `extended_price` DECIMAL(18,2) COMMENT 'Total price for this cart line calculated as quantity requested multiplied by unit price, before any item-level promotions or discounts are applied.',
    `gtin` STRING COMMENT 'Global trade item number assigned by GS1 for worldwide product identification. May be 8, 12, 13, or 14 digits depending on product type.. Valid values are `^[0-9]{8,14}$`',
    `item_discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to this specific cart item from promotions, coupons, or temporary price reductions. Reduces the extended price to arrive at net item amount.',
    `item_status` STRING COMMENT 'Current status of this item within the cart lifecycle. Tracks whether item is active in cart, removed by customer, saved for later purchase, unavailable, or substituted during fulfillment.. Valid values are `active|removed|saved_for_later|out_of_stock|substituted`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cart item. Tracks quantity changes, substitution preference updates, or special instruction edits.',
    `line_number` STRING COMMENT 'Sequential line number indicating the order in which items were added to the cart. Used for display ordering and cart recovery workflows.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item qualifies for loyalty points accrual. Some categories like alcohol, tobacco, and pharmacy may be excluded from loyalty programs.',
    `net_item_amount` DECIMAL(18,2) COMMENT 'Net amount for this cart line after item-level discounts are applied. Calculated as extended price minus item discount amount.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether this item is certified organic. Supports customer preference tracking and organic category performance analysis.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether this item is perishable and requires temperature-controlled handling. Drives fulfillment workflow and cold chain logistics.',
    `plu` STRING COMMENT 'Price look-up code used primarily for fresh produce and bulk items sold by weight. Typically 4 or 5 digit codes assigned by the International Federation for Produce Standards.. Valid values are `^[0-9]{4,5}$`',
    `preferred_substitute_sku` STRING COMMENT 'Specific SKU the customer has designated as an acceptable substitute if the original item is unavailable. Only populated when substitution preference is specific_only.. Valid values are `^[A-Z0-9]{6,14}$`',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this item is a store-owned private label brand. Used for private label penetration analysis and margin reporting.',
    `product_name` STRING COMMENT 'Human-readable product name displayed to the customer in the digital cart. Captured at time of cart add to preserve the product description as shown to the shopper.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of the item requested by the customer. May be whole units for packaged goods or fractional for weighted items like produce or deli products.',
    `recommendation_source` STRING COMMENT 'Source that led to this item being added to cart. Tracks effectiveness of recommendation engines, search, and merchandising strategies.. Valid values are `manual|personalized_rec|frequently_bought|trending|search|category_browse`',
    `removed_timestamp` TIMESTAMP COMMENT 'Timestamp when this item was removed from the cart by the customer. Used for cart abandonment analysis and product affinity modeling.',
    `sku` STRING COMMENT 'Internal stock keeping unit code identifying the specific product variant added to cart. Primary product identifier for inventory and merchandising systems.. Valid values are `^[A-Z0-9]{6,14}$`',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using SNAP Electronic Benefits Transfer. Required for SNAP transaction processing and compliance reporting.',
    `source_channel` STRING COMMENT 'Digital channel through which this item was added to the cart. Supports omnichannel behavior analysis and channel-specific merchandising strategies.. Valid values are `web|mobile_app|kiosk|call_center|voice_assistant`',
    `special_instructions` STRING COMMENT 'Free-text customer instructions for this specific item. Common for produce ripeness preferences, deli slicing thickness, bakery customization, or other item-specific requests.',
    `substitution_preference` STRING COMMENT 'Customer preference for item substitution if the requested product is out of stock during fulfillment. Drives picker behavior and customer communication workflows.. Valid values are `allow|deny|contact_me|specific_only`',
    `tpr_flag` BOOLEAN COMMENT 'Indicates whether this item is currently on temporary price reduction. Used for promotional analytics and margin analysis.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity requested. Indicates whether item is sold by each, weight, volume, or other standard retail units. [ENUM-REF-CANDIDATE: each|lb|oz|kg|g|gal|qt|pt|fl_oz|l|ml|dozen|case — 13 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure at the time the item was added to cart. Captured to preserve pricing for cart recovery and price change analysis.',
    `upc` STRING COMMENT '12-digit universal product code barcode identifier. Standard retail product identifier used for scanning and product lookup.. Valid values are `^[0-9]{12}$`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is approved for purchase under the WIC program. Required for WIC voucher processing and state compliance reporting.',
    CONSTRAINT pk_cart_item PRIMARY KEY(`cart_item_id`)
) COMMENT 'Line-item level detail within a digital shopping cart. Captures the SKU/UPC added, quantity requested, unit price at time of add, substitution preference (allow/deny/specific), special instructions (e.g., ripeness preference for produce), item-level promo applied, and item add timestamp. Supports cart recovery, substitution workflows, and order conversion analytics.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`checkout_session` (
    `checkout_session_id` BIGINT COMMENT 'Unique identifier for the checkout session. Primary key.',
    `cart_id` BIGINT COMMENT 'Reference to the shopping cart that was submitted for checkout.',
    `order_header_id` BIGINT COMMENT 'Reference to the order header created from this checkout session upon completion. Links to the OMS (Order Management System) for order routing and fulfillment.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer who initiated the checkout session.',
    `store_location_id` BIGINT COMMENT 'Store location selected for pickup or fulfillment, if applicable.',
    `abandoned_timestamp` TIMESTAMP COMMENT 'Timestamp when the checkout session was abandoned by the customer without completing the purchase.',
    `abandonment_step` STRING COMMENT 'The checkout funnel step at which the customer abandoned the session, if applicable. Used for conversion funnel analysis.. Valid values are `address|fulfillment|payment|review`',
    `browser_type` STRING COMMENT 'Web browser or mobile app version used during the checkout session.',
    `channel_type` STRING COMMENT 'Digital channel through which the checkout session was initiated (web storefront, mobile app, in-store kiosk, call center).. Valid values are `web|mobile_app|kiosk|call_center`',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the checkout session was successfully completed and order was placed.',
    `coupon_codes_applied` STRING COMMENT 'Comma-separated list of coupon codes validated and applied during checkout.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this checkout session record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this checkout session.. Valid values are `^[A-Z]{3}$`',
    `delivery_fee_amount` DECIMAL(18,2) COMMENT 'Delivery or service fee charged for order fulfillment, if applicable.',
    `device_type` STRING COMMENT 'Type of device used by the customer to complete the checkout session.. Valid values are `desktop|mobile|tablet|kiosk`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied during checkout from promotions, coupons, and loyalty rewards.',
    `ebt_snap_flag` BOOLEAN COMMENT 'Indicates whether EBT SNAP benefits were selected as a payment tender during checkout.',
    `expired_timestamp` TIMESTAMP COMMENT 'Timestamp when the checkout session expired due to inactivity timeout.',
    `fulfillment_method` STRING COMMENT 'The fulfillment method selected by the customer during checkout (home delivery, in-store pickup, curbside pickup).. Valid values are `delivery|pickup|curbside`',
    `initiated_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer began the checkout process by submitting their cart. Principal business event timestamp for this transaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this checkout session record was last updated. Audit trail for record modification.',
    `loyalty_card_number` STRING COMMENT 'Loyalty card number entered or scanned during checkout for rewards and personalization.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned from this purchase, calculated during checkout.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the customer during this checkout session.',
    `oms_order_reference` STRING COMMENT 'External reference identifier assigned by the Order Management System upon successful checkout completion and order routing.',
    `payment_authorization_code` STRING COMMENT 'Authorization code returned by the payment processor upon successful payment validation.',
    `payment_method_selected` STRING COMMENT 'Primary payment method selected by the customer during checkout. [ENUM-REF-CANDIDATE: credit_card|debit_card|ebt|gift_card|paypal|apple_pay|google_pay — 7 candidates stripped; promote to reference product]',
    `payment_processor_reference` STRING COMMENT 'External reference identifier from the payment gateway or processor for this checkout transaction.',
    `promo_codes_applied` STRING COMMENT 'Comma-separated list of promotional codes applied during checkout for discounts or offers.',
    `selected_fulfillment_slot_end` TIMESTAMP COMMENT 'End time of the delivery or pickup time slot selected by the customer.',
    `selected_fulfillment_slot_start` TIMESTAMP COMMENT 'Start time of the delivery or pickup time slot selected by the customer.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the checkout session in seconds, from initiation to completion or abandonment.',
    `session_number` STRING COMMENT 'Business-friendly unique identifier for the checkout session, used for customer service and tracking.',
    `session_status` STRING COMMENT 'Current lifecycle status of the checkout session. Tracks progression from initiation through completion or abandonment.. Valid values are `initiated|in_progress|completed|abandoned|failed|expired`',
    `snap_eligible_amount` DECIMAL(18,2) COMMENT 'Total amount of items in the cart that are eligible for SNAP benefits payment.',
    `source_system` STRING COMMENT 'Name of the source system or platform that captured this checkout session (e.g., Salesforce Commerce Cloud, custom eCommerce platform).',
    `special_instructions` STRING COMMENT 'Free-text special instructions or notes provided by the customer for order fulfillment (e.g., delivery instructions, item preferences).',
    `step_address_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer completed the delivery/pickup address step in the checkout funnel.',
    `step_fulfillment_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer completed the fulfillment method and time slot selection step.',
    `step_payment_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer completed the payment information entry step.',
    `step_review_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer completed the order review and confirmation step.',
    `substitution_preference` STRING COMMENT 'Customer preference for item substitutions if ordered items are out of stock during fulfillment.. Valid values are `allow|contact_me|no_substitutions`',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total amount of all items in the cart before discounts, taxes, and fees are applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax calculated and applied to the order during checkout.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Optional tip amount entered by the customer for delivery or pickup service.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount after all discounts, taxes, fees, and tips are applied. Net amount the customer will pay.',
    `total_item_count` STRING COMMENT 'Total number of distinct line items in the cart at checkout initiation.',
    `total_unit_quantity` DECIMAL(18,2) COMMENT 'Total quantity of all units across all items in the cart at checkout.',
    `wic_flag` BOOLEAN COMMENT 'Indicates whether WIC benefits were selected as a payment tender during checkout.',
    CONSTRAINT pk_checkout_session PRIMARY KEY(`checkout_session_id`)
) COMMENT 'Records the checkout funnel event for a digital order, from cart submission through payment authorization. Captures checkout initiation timestamp, steps completed (address, fulfillment slot, payment), step abandonment point if applicable, applied loyalty points, coupon codes validated, EBT/SNAP tender flag, total before/after discounts, tax amount, and checkout completion status. Integrates with OMS for order routing.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`product_order` (
    `product_order_id` BIGINT COMMENT 'Primary key for order',
    `node_id` BIGINT COMMENT 'Reference to the store, Micro-Fulfillment Center (MFC), or Distribution Center (DC) assigned to fulfill this order.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Needed for order‑level analytics and campaign performance dashboards; promo_code_applied is a denormalized string.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who placed this digital order.',
    `age_verification_required_flag` BOOLEAN COMMENT 'Indicates whether this order contains age-restricted items (alcohol, tobacco, certain medications) requiring customer age verification at fulfillment.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for order cancellation.. Valid values are `customer_request|out_of_stock|payment_failed|address_issue|fraud_suspected|system_error`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the order was cancelled, if applicable.',
    `channel_source` STRING COMMENT 'The digital channel through which the customer placed the order (web storefront, mobile app, in-store kiosk, voice assistant, chatbot, or third-party marketplace).. Valid values are `web|mobile_app|kiosk|voice|chatbot|third_party_marketplace`',
    `contactless_delivery_flag` BOOLEAN COMMENT 'Indicates whether the customer requested contactless delivery (leave at door, no signature required).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `customer_feedback_comments` STRING COMMENT 'Free-text customer feedback or comments about the order experience.',
    `customer_rating` STRING COMMENT 'Customer satisfaction rating for the order experience on a scale of 1 to 5 stars.',
    `delivery_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for delivery or fulfillment service. Zero for in-store pickup orders.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the order including promotions, coupons, and loyalty rewards.',
    `fulfillment_type` STRING COMMENT 'The method by which the order will be fulfilled and delivered to the customer. Click-and-Collect refers to in-store pickup, curbside pickup is contactless vehicle-side handoff, last-mile delivery is same-day home delivery, ship-to-home is standard shipping, and locker pickup is automated pickup point.. Valid values are `click_and_collect|curbside_pickup|last_mile_delivery|ship_to_home|locker_pickup`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was last updated.',
    `loyalty_card_number` STRING COMMENT 'Customer loyalty card number applied to this order for points accrual and member pricing.',
    `loyalty_points_earned` STRING COMMENT 'Total loyalty program points earned by the customer for this order.',
    `oms_order_reference` STRING COMMENT 'External reference identifier from the Order Management System (OMS) used for routing and orchestration across fulfillment systems.',
    `order_number` STRING COMMENT 'Externally-visible unique order number displayed to customers and used for customer service inquiries. Generated by the Order Management System (OMS).. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the digital order in the fulfillment workflow. [ENUM-REF-CANDIDATE: pending|confirmed|picking|packed|ready_for_pickup|out_for_delivery|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `payment_method` STRING COMMENT 'Primary payment instrument type used for this order. EBT refers to Electronic Benefits Transfer for SNAP/WIC programs.. Valid values are `credit_card|debit_card|ebt|gift_card|digital_wallet|buy_now_pay_later`',
    `payment_status` STRING COMMENT 'Current status of payment processing for this order.. Valid values are `pending|authorized|captured|failed|refunded|partially_refunded`',
    `placed_timestamp` TIMESTAMP COMMENT 'The exact date and time when the customer submitted the order through the digital channel. This is the principal business event timestamp for the order lifecycle.',
    `prescription_included_flag` BOOLEAN COMMENT 'Indicates whether this order includes pharmacy prescription items requiring special handling and HIPAA compliance.',
    `promised_fulfillment_date` DATE COMMENT 'The date promised to the customer for order fulfillment (pickup or delivery).',
    `promised_window_end_time` TIMESTAMP COMMENT 'The end of the time window promised to the customer for order pickup or delivery.',
    `promised_window_start_time` TIMESTAMP COMMENT 'The start of the time window promised to the customer for order pickup or delivery.',
    `snap_eligible_amount` DECIMAL(18,2) COMMENT 'Total amount of SNAP-eligible items in the order that can be paid using Electronic Benefits Transfer (EBT).',
    `source_system_code` STRING COMMENT 'Identifier of the source system that originated this order record (e.g., Salesforce Commerce Cloud, custom eCommerce platform, mobile app backend).',
    `special_instructions` STRING COMMENT 'Free-text field for customer-provided delivery or fulfillment instructions (e.g., gate code, preferred substitutions, contactless delivery preferences).',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the customer has allowed product substitutions if ordered items are out of stock.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total amount of all order line items before discounts, taxes, and fees.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax amount charged on the order.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Optional gratuity amount provided by the customer for delivery or pickup service.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount charged to the customer including subtotal, taxes, fees, tips, minus discounts.',
    `total_item_count` STRING COMMENT 'Total number of distinct line items (SKUs) in the order.',
    `total_unit_quantity` DECIMAL(18,2) COMMENT 'Total quantity of all units across all line items in the order (sum of quantities).',
    `wic_eligible_amount` DECIMAL(18,2) COMMENT 'Total amount of WIC-eligible items in the order that can be paid using WIC vouchers or EBT.',
    CONSTRAINT pk_product_order PRIMARY KEY(`product_order_id`)
) COMMENT 'Master record for an online order placed through any digital channel (web, mobile, kiosk). Captures order number, channel source, fulfillment type (click-and-collect, curbside pickup, last-mile delivery, ship-to-home), order status, placed timestamp, promised fulfillment window, store or MFC assigned for fulfillment, total amount, payment status, and OMS routing reference. SSOT for digital order identity within the commerce domain; physical execution is owned by the order and fulfillment domains.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`fulfillment_slot` (
    `fulfillment_slot_id` BIGINT COMMENT 'Unique identifier for the fulfillment slot. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the operations user who performed the capacity override.',
    `store_location_id` BIGINT COMMENT 'Store or MFC (Micro-Fulfillment Center) where this fulfillment slot is available.',
    `available_capacity` STRING COMMENT 'Remaining capacity available for new bookings, calculated as total_capacity minus booked_count minus reserved_count.',
    `booked_count` STRING COMMENT 'Current number of confirmed orders assigned to this slot.',
    `cancellation_reason` STRING COMMENT 'Reason code or description for why this slot was cancelled, if applicable.',
    `capacity_override_flag` BOOLEAN COMMENT 'Indicates whether the slot capacity was manually adjusted by operations staff.',
    `channel` STRING COMMENT 'Digital commerce channel through which this slot is made available for booking.. Valid values are `web|mobile_app|call_center|in_store_kiosk`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for slot fee amount.. Valid values are `^[A-Z]{3}$`',
    `cutoff_timestamp` TIMESTAMP COMMENT 'Deadline timestamp after which new bookings for this slot are no longer accepted.',
    `delivery_zone_code` STRING COMMENT 'Geographic zone or service area code for delivery slots, used for routing and capacity planning.',
    `fulfillment_type` STRING COMMENT 'Type of fulfillment service this slot supports: click-and-collect pickup, curbside pickup, last-mile delivery (LMD), or pharmacy prescription pickup.. Valid values are `pickup|curbside|delivery|pharmacy`',
    `holiday_flag` BOOLEAN COMMENT 'Indicates whether this slot falls on a holiday or high-demand promotional period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot record was last updated.',
    `override_reason` STRING COMMENT 'Business justification for manual capacity override, if applicable.',
    `priority_tier` STRING COMMENT 'Customer segment or priority level that has preferential access to this slot.. Valid values are `standard|loyalty_member|premium|employee`',
    `reserved_count` STRING COMMENT 'Number of slots currently held in reservation (not yet confirmed) during checkout sessions.',
    `service_level` STRING COMMENT 'Service tier or speed commitment associated with this slot.. Valid values are `standard|express|same_day|next_day|scheduled`',
    `slot_closed_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot was closed to new bookings, either due to reaching capacity or manual closure.',
    `slot_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot record was first created in the system.',
    `slot_date` DATE COMMENT 'Calendar date for which this fulfillment slot is scheduled.',
    `slot_duration_minutes` STRING COMMENT 'Length of the fulfillment window in minutes.',
    `slot_end_time` TIMESTAMP COMMENT 'Timestamp when the fulfillment slot window ends.',
    `slot_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for booking this slot, if applicable.',
    `slot_notes` STRING COMMENT 'Free-text operational notes or special instructions related to this slot.',
    `slot_number` STRING COMMENT 'Business identifier for the slot, used in customer-facing displays and operational tracking.',
    `slot_published_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot was made visible and bookable to customers.',
    `slot_start_time` TIMESTAMP COMMENT 'Timestamp when the fulfillment slot window begins.',
    `slot_status` STRING COMMENT 'Current lifecycle status of the fulfillment slot indicating availability for new bookings.. Valid values are `open|full|closed|cancelled|suspended|reserved`',
    `source_system` STRING COMMENT 'Operational system that created or manages this slot record, such as OMS (Order Management System) or Salesforce Commerce Cloud.',
    `surge_pricing_flag` BOOLEAN COMMENT 'Indicates whether surge or dynamic pricing is applied to this slot due to high demand.',
    `temperature_zone` STRING COMMENT 'Temperature control requirement for this slot, relevant for perishable and frozen goods fulfillment.. Valid values are `ambient|refrigerated|frozen|multi_temp`',
    `total_capacity` STRING COMMENT 'Maximum number of orders that can be assigned to this slot.',
    CONSTRAINT pk_fulfillment_slot PRIMARY KEY(`fulfillment_slot_id`)
) COMMENT 'Scheduled time windows available for click-and-collect, curbside pickup, or last-mile delivery fulfillment at a given store or MFC. Captures slot date, start/end time, fulfillment type, location, total capacity (max orders), booked count, available capacity, cutoff time for new bookings, and slot status (open, full, closed, cancelled). Also manages individual slot reservations linking a checkout session or order to a specific slot, including reservation timestamp, reservation status (held, confirmed, released, expired), hold expiry timestamp, and release reason. Drives the slot selection UI in checkout and manages capacity contention during high-demand periods such as holidays and promotional events. This is the commerce-layer view of slot availability and reservation for the digital shopping experience; physical fulfillment execution is owned by the fulfillment domain.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`slot_reservation` (
    `slot_reservation_id` BIGINT COMMENT 'Unique identifier for the slot reservation record. Primary key.',
    `fulfillment_slot_id` BIGINT COMMENT 'Reference to the specific fulfillment slot being reserved.',
    `order_header_id` BIGINT COMMENT 'Reference to the order associated with this slot reservation.',
    `shopper_id` BIGINT COMMENT 'Reference to the shopper who made the reservation.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the fulfillment slot is located.',
    `web_session_id` BIGINT COMMENT 'Digital session identifier linking the reservation to the customers checkout session for analytics and troubleshooting.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the reservation was cancelled by the customer or system.',
    `capacity_units_reserved` STRING COMMENT 'Number of capacity units consumed by this reservation within the slots total capacity. Used for slot inventory management.',
    `channel_type` STRING COMMENT 'The digital channel through which the slot reservation was made.. Valid values are `web|mobile_app|call_center|in_store_kiosk`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the reservation transitioned from held to confirmed status, typically after successful payment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the slot fee amount.. Valid values are `USD|CAD|MXN`',
    `device_code` STRING COMMENT 'Identifier of the device used to make the reservation, used for fraud detection and customer experience analytics.',
    `fulfillment_type` STRING COMMENT 'The method of order fulfillment associated with this slot reservation.. Valid values are `pickup|delivery|curbside`',
    `hold_duration_seconds` STRING COMMENT 'The length of time in seconds that the slot was held before confirmation or expiration. Used for checkout flow optimization.',
    `hold_expiry_timestamp` TIMESTAMP COMMENT 'The date and time when a held reservation will automatically expire if not confirmed. Used to manage slot inventory contention during high-demand periods.',
    `holiday_flag` BOOLEAN COMMENT 'Indicates whether the reserved slot falls on a holiday or peak shopping period, used for capacity planning and pricing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this record was most recently updated in the data platform.',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the customer about the reservation status.. Valid values are `email|sms|push|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a confirmation or reminder notification was sent to the customer for this reservation.',
    `priority_tier` STRING COMMENT 'Customer priority level for slot allocation, used during high-demand periods to prioritize loyal or premium customers.. Valid values are `standard|premium|vip`',
    `release_reason_code` STRING COMMENT 'Coded reason why the slot reservation was released or cancelled. Used for operational analytics and slot inventory optimization.. Valid values are `customer_cancel|payment_fail|timeout|system_error|inventory_conflict|duplicate`',
    `release_reason_description` STRING COMMENT 'Detailed explanation of why the slot was released, providing additional context beyond the reason code.',
    `release_timestamp` TIMESTAMP COMMENT 'The date and time when the slot was released back to available inventory.',
    `reservation_number` STRING COMMENT 'Business-facing unique identifier for the slot reservation, used for customer communication and tracking.',
    `reservation_status` STRING COMMENT 'Current lifecycle status of the slot reservation. Held indicates temporary hold during checkout, confirmed indicates successful booking, released indicates slot returned to inventory, expired indicates hold timeout, cancelled indicates customer cancellation.. Valid values are `held|confirmed|released|expired|cancelled`',
    `reservation_timestamp` TIMESTAMP COMMENT 'The exact date and time when the slot reservation was initially created. Principal business event timestamp.',
    `service_level` STRING COMMENT 'The speed or priority tier of the fulfillment service for this reservation.. Valid values are `standard|express|same_day|next_day`',
    `slot_date` DATE COMMENT 'The calendar date of the reserved fulfillment slot.',
    `slot_end_time` TIMESTAMP COMMENT 'The ending time of the reserved fulfillment window.',
    `slot_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged for reserving this specific slot, if applicable. May vary based on demand, time, or service level.',
    `slot_start_time` TIMESTAMP COMMENT 'The beginning time of the reserved fulfillment window.',
    `source_system` STRING COMMENT 'The operational system that originated this slot reservation record, used for data lineage and troubleshooting.',
    `special_instructions` STRING COMMENT 'Customer-provided notes or special requests related to the slot reservation and fulfillment.',
    `surge_pricing_flag` BOOLEAN COMMENT 'Indicates whether surge pricing was applied to this slot reservation due to high demand or holiday periods.',
    CONSTRAINT pk_slot_reservation PRIMARY KEY(`slot_reservation_id`)
) COMMENT 'Transactional record linking a digital order or checkout session to a specific fulfillment slot. Captures reservation timestamp, reserved slot reference, shopper identity, order reference, reservation status (held, confirmed, released, expired), hold expiry timestamp, and release reason if applicable. Manages slot inventory contention during high-demand periods such as holiday or promotional events.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`payment_event` (
    `payment_event_id` BIGINT COMMENT 'Primary key for payment_event',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the original authorization transaction for capture, void, or refund events. Links related payment events in the transaction chain.',
    `product_order_id` BIGINT COMMENT 'Reference to the digital commerce order that initiated this payment event. Links payment event to the order header in the digital shopping flow.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who initiated this payment. Links to the customer master for analytics and personalization.',
    `storefront_id` BIGINT COMMENT 'Reference to the digital storefront where this payment event occurred. Links to the commerce platform configuration.',
    `web_session_id` BIGINT COMMENT 'Unique identifier for the customers digital session during which this payment event occurred. Used for conversion funnel analysis.',
    `authorization_code` STRING COMMENT 'Approval code returned by the payment processor or issuing bank when the transaction is authorized. Used for settlement reconciliation.',
    `avs_response_code` STRING COMMENT 'Response code from the Address Verification System indicating whether the billing address provided matches the address on file with the card issuer.',
    `card_type` STRING COMMENT 'Card network or brand for card-based payments (Visa, Mastercard, American Express, Discover). Null for non-card tender types.. Valid values are `visa|mastercard|amex|discover|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment event record was first created in the commerce system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `cvv_response_code` STRING COMMENT 'Response code indicating whether the CVV/CVC security code provided matches the card issuers records. Used for fraud prevention.',
    `decline_reason_code` STRING COMMENT 'Code indicating the reason the transaction was declined by the processor or issuer (insufficient funds, invalid card, fraud suspicion, etc.).',
    `device_code` STRING COMMENT 'Unique identifier for the device used to initiate the payment. Used for fraud detection and device fingerprinting.',
    `ebt_balance_remaining` DECIMAL(18,2) COMMENT 'Remaining balance on the EBT (Electronic Benefits Transfer) card after this transaction. Null for non-EBT transactions.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this transaction was flagged as potentially fraudulent by automated fraud detection systems.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by fraud detection system indicating the likelihood this transaction is fraudulent. Higher scores indicate higher risk.',
    `gift_card_balance_remaining` DECIMAL(18,2) COMMENT 'Remaining balance on the gift card after this transaction. Null for non-gift-card tender types.',
    `ip_address` STRING COMMENT 'Internet Protocol address of the device that initiated the payment transaction. Used for fraud detection and geolocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment event record was last updated. Tracks changes to transaction status or settlement information.',
    `loyalty_points_redeemed` DECIMAL(18,2) COMMENT 'Number of loyalty program points redeemed as part of this payment transaction. Null if no points were used.',
    `merchant_account_code` STRING COMMENT 'Identifier for the merchant account used to process this transaction. Multiple accounts may be used for different brands or regions.',
    `payment_channel` STRING COMMENT 'Digital channel or interface through which the payment was initiated (web storefront, mobile app, mobile web, in-store kiosk, call center).. Valid values are `web|mobile_app|mobile_web|kiosk|call_center`',
    `payment_gateway` STRING COMMENT 'Name or identifier of the payment gateway or processor that handled this transaction (e.g., Stripe, Adyen, Cybersource).',
    `payment_token_ref` BIGINT COMMENT 'Reference to the tokenized payment instrument in the payment domain. The payment domain is the authoritative SSOT for tokenization and PCI compliance.',
    `processor_response_code` STRING COMMENT 'Response code returned by the payment gateway or processor indicating the outcome of the transaction attempt (approved, declined, error codes).',
    `processor_response_message` STRING COMMENT 'Human-readable message from the payment processor describing the transaction outcome or reason for decline.',
    `processor_transaction_ref` STRING COMMENT 'Unique transaction identifier assigned by the payment processor or gateway. Used for reconciliation and dispute resolution.',
    `retry_attempt_number` STRING COMMENT 'Sequential number indicating which retry attempt this is for the same payment. First attempt is 1, subsequent retries increment.',
    `settlement_date` DATE COMMENT 'Date when the transaction was settled and funds were transferred. Null for unsettled transactions.',
    `settlement_status` STRING COMMENT 'Status of funds settlement with the payment processor. Indicates whether the transaction has been finalized and funds transferred.. Valid values are `pending|settled|failed|reversed`',
    `snap_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of the transaction amount that qualifies for SNAP (Supplemental Nutrition Assistance Program) benefits. Null for non-SNAP transactions.',
    `tender_type` STRING COMMENT 'Payment instrument type used for this transaction. Includes credit card, debit card, EBT (Electronic Benefits Transfer), SNAP (Supplemental Nutrition Assistance Program), WIC (Women Infants and Children Program), loyalty points, or gift card.. Valid values are `credit_card|debit_card|ebt|snap|wic|gift_card`',
    `three_d_secure_flag` BOOLEAN COMMENT 'Indicates whether 3D Secure authentication (Verified by Visa, Mastercard SecureCode) was used for this transaction. Enhances security and shifts liability.',
    `three_d_secure_version` STRING COMMENT 'Version of 3D Secure protocol used (e.g., 1.0, 2.0, 2.1). Null if 3D Secure was not used.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of this payment event. For authorizations and captures, this is the gross amount; for refunds, this is the amount being returned.',
    `transaction_status` STRING COMMENT 'Current status of the payment transaction event in its lifecycle. Tracks progression from initiation through settlement or failure.. Valid values are `pending|approved|declined|failed|voided|settled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment event was initiated in the digital commerce flow. Primary business event timestamp for this transaction.',
    `transaction_type` STRING COMMENT 'Type of payment event: authorization (hold funds), capture (settle funds), void (cancel authorization), refund (return funds), partial_refund (return portion), or reversal (undo transaction).. Valid values are `authorization|capture|void|refund|partial_refund|reversal`',
    `wic_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of the transaction amount that qualifies for WIC (Women Infants and Children Program) benefits. Null for non-WIC transactions.',
    CONSTRAINT pk_payment_event PRIMARY KEY(`payment_event_id`)
) COMMENT 'Commerce-layer record of each payment authorization, capture, void, or refund event initiated through the digital shopping flow. Captures transaction type, amount, currency, tender type (credit, debit, EBT, SNAP, WIC, loyalty points, gift card), authorization code, processor response code, transaction timestamp, digital order reference, payment token reference (FK to payment domain), and settlement status. This product exists solely for checkout UX state management, order confirmation display, and digital channel conversion analytics. The payment domain is the authoritative SSOT for payment processing lifecycle, tokenization, PCI compliance, and settlement — commerce does not duplicate that responsibility.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`search_query` (
    `search_query_id` BIGINT COMMENT 'Unique identifier for each product search query event executed by a shopper on a digital storefront.',
    `shopper_id` BIGINT COMMENT 'Reference to the authenticated shopper who executed the search. Null for guest users.',
    `store_location_id` BIGINT COMMENT 'Reference to the physical store selected by the shopper for fulfillment context, if applicable to the search session.',
    `storefront_id` BIGINT COMMENT 'Reference to the digital storefront where the search was executed.',
    `web_session_id` BIGINT COMMENT 'Unique identifier for the shopper session during which the search was performed, enabling session-level analytics and journey tracking.',
    `ab_test_variant` STRING COMMENT 'The A/B test variant or experiment group assigned to this search event, enabling controlled testing of search algorithms and merchandising strategies.',
    `added_to_cart_flag` BOOLEAN COMMENT 'Indicator of whether the shopper added any product to their cart as a result of this search, measuring search conversion effectiveness.',
    `autocomplete_suggestion` STRING COMMENT 'The autocomplete suggestion selected by the shopper, if applicable.',
    `autocomplete_used_flag` BOOLEAN COMMENT 'Indicator of whether the shopper selected a suggestion from the autocomplete dropdown rather than typing the full query.',
    `clicked_position` STRING COMMENT 'The position (rank) of the clicked product in the search results list, used to measure relevance quality.',
    `clicked_sku` STRING COMMENT 'The SKU of the first product clicked by the shopper from the search results, if any.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this search query record was created in the system.',
    `device_type` STRING COMMENT 'The type of device used by the shopper to perform the search.. Valid values are `desktop|tablet|smartphone|kiosk|other`',
    `filter_brand_applied` STRING COMMENT 'The brand filter applied by the shopper to narrow search results, if any.',
    `filter_category_applied` STRING COMMENT 'The product category filter applied by the shopper to narrow search results, if any.',
    `filter_dietary_applied` STRING COMMENT 'Dietary or nutritional filters applied by the shopper (e.g., organic, gluten-free, vegan, low-sodium) to narrow search results.',
    `filter_price_max` DECIMAL(18,2) COMMENT 'The maximum price threshold applied by the shopper as a filter, if any.',
    `filter_price_min` DECIMAL(18,2) COMMENT 'The minimum price threshold applied by the shopper as a filter, if any.',
    `ip_address` STRING COMMENT 'The IP address of the device from which the search was executed, used for fraud detection and geographic analytics.',
    `locale_code` STRING COMMENT 'The locale or language setting of the shopper at the time of search (e.g., en-US, es-MX), affecting search relevance and merchandising.',
    `normalized_query_string` STRING COMMENT 'The search query after normalization processing (lowercased, stemmed, stop-words removed) used for relevance matching and analytics.',
    `personalization_applied_flag` BOOLEAN COMMENT 'Indicator of whether personalized ranking or filtering was applied to the search results based on shopper profile or behavior.',
    `query_refined_flag` BOOLEAN COMMENT 'Indicator of whether the shopper refined or modified the search query after viewing initial results, signaling potential relevance issues.',
    `query_string` STRING COMMENT 'The raw search text entered by the shopper, capturing the exact keywords or phrases used to find products.',
    `refined_query_string` STRING COMMENT 'The subsequent search query entered by the shopper if they refined their original search.',
    `result_clicked_flag` BOOLEAN COMMENT 'Indicator of whether the shopper clicked on any product from the search results, measuring search effectiveness.',
    `result_count` STRING COMMENT 'The total number of product results returned by the search engine for this query.',
    `search_channel` STRING COMMENT 'The digital channel through which the search was executed (e.g., web browser, mobile app, mobile web, in-store kiosk).. Valid values are `web|mobile_app|mobile_web|kiosk`',
    `search_engine_version` STRING COMMENT 'The version of the search engine or algorithm used to process this query, enabling A/B testing and performance tracking.',
    `search_method` STRING COMMENT 'The method used by the shopper to initiate the search (e.g., text input, voice search, barcode scan, image search).. Valid values are `text_input|voice_search|barcode_scan|image_search|autocomplete_selection`',
    `search_response_time_ms` STRING COMMENT 'The time in milliseconds taken by the search engine to return results, used for performance monitoring.',
    `search_timestamp` TIMESTAMP COMMENT 'The precise date and time when the shopper executed the search query.',
    `sort_order` STRING COMMENT 'The sort order selected by the shopper to organize search results (e.g., relevance, price ascending, price descending, newest arrivals). [ENUM-REF-CANDIDATE: relevance|price_low_to_high|price_high_to_low|newest|best_selling|customer_rating|alphabetical — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The source system or platform that captured this search event (e.g., Salesforce Commerce Cloud, custom eCommerce platform).',
    `user_agent` STRING COMMENT 'The user agent string of the browser or application used to perform the search, providing device and browser details.',
    `zero_results_flag` BOOLEAN COMMENT 'Indicator of whether the search returned no results, critical for identifying search relevance gaps and merchandising opportunities.',
    CONSTRAINT pk_search_query PRIMARY KEY(`search_query_id`)
) COMMENT 'Captures each product search event executed by a shopper on a digital storefront. Records query string, storefront, session reference, timestamp, result count returned, zero-results flag, applied filters (category, brand, dietary), sort order selected, and whether the shopper clicked a result or refined the query. Supports search relevance tuning, zero-result remediation, and digital merchandising decisions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`product_recommendation` (
    `product_recommendation_id` BIGINT COMMENT 'Unique identifier for the product recommendation record. Primary key.',
    `category_id` BIGINT COMMENT 'Identifier of the product category to which the recommended product belongs.',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the merchandising or promotional campaign associated with this recommendation, if applicable.',
    `order_header_id` BIGINT COMMENT 'Identifier of the order in which the recommended product was purchased, if conversion occurred.',
    `shopper_id` BIGINT COMMENT 'Identifier of the shopper to whom the recommendation was presented.',
    `storefront_id` BIGINT COMMENT 'Identifier of the digital storefront where the recommendation was displayed.',
    `web_session_id` BIGINT COMMENT 'Unique identifier for the digital browsing session during which the recommendation was presented.',
    `ab_test_variant` STRING COMMENT 'Identifier of the A/B test variant or experiment group to which this recommendation belongs, enabling testing of recommendation strategies.',
    `add_to_cart_flag` BOOLEAN COMMENT 'Indicates whether the shopper added the recommended product to their cart (True if added, False otherwise).',
    `add_to_cart_timestamp` TIMESTAMP COMMENT 'The date and time when the recommended product was added to the cart, if applicable.',
    `algorithm` STRING COMMENT 'The name or identifier of the personalization algorithm or strategy used to generate the recommendation.',
    `brand_name` STRING COMMENT 'The brand name of the recommended product.',
    `channel` STRING COMMENT 'The digital channel through which the recommendation was delivered to the shopper.. Valid values are `web|mobile_app|email|push_notification`',
    `click_flag` BOOLEAN COMMENT 'Indicates whether the shopper clicked on the recommended product (True if clicked, False otherwise).',
    `click_timestamp` TIMESTAMP COMMENT 'The date and time when the shopper clicked on the recommendation, if applicable.',
    `context` STRING COMMENT 'The page or context within the digital storefront where the recommendation was displayed.. Valid values are `homepage|product_detail_page|cart|checkout|search_results|category_page`',
    `control_group_flag` BOOLEAN COMMENT 'Indicates whether this recommendation was part of a control group in an A/B test (True for control, False for treatment).',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether the shopper purchased the recommended product (True if purchased, False otherwise).',
    `conversion_timestamp` TIMESTAMP COMMENT 'The date and time when the recommended product was purchased, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this recommendation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the display price.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `device_type` STRING COMMENT 'The type of device used by the shopper when the recommendation was presented.. Valid values are `desktop|mobile|tablet|app`',
    `display_position` STRING COMMENT 'The ordinal position where the recommendation was displayed on the page (1 for first position, 2 for second, etc.).',
    `display_price` DECIMAL(18,2) COMMENT 'The price of the recommended product as displayed to the shopper at the time of the recommendation.',
    `expiration_timestamp` TIMESTAMP COMMENT 'The date and time when the recommendation is no longer considered valid or relevant for tracking purposes.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate of the shoppers location at the time of the recommendation, if available.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate of the shoppers location at the time of the recommendation, if available.',
    `impression_timestamp` TIMESTAMP COMMENT 'The exact date and time when the recommendation was displayed to the shopper.',
    `ip_address` STRING COMMENT 'The IP address of the shopper at the time of the recommendation impression, used for fraud detection and analytics.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this recommendation record was last updated.',
    `model_version` STRING COMMENT 'Version identifier of the machine learning model or recommendation engine that generated this recommendation.',
    `promotion_applied_flag` BOOLEAN COMMENT 'Indicates whether a promotional discount was applied to the recommended product at the time of display.',
    `recommendation_number` STRING COMMENT 'Business-friendly reference number for the recommendation event, used for tracking and reporting.',
    `recommendation_source` STRING COMMENT 'The origin or system that generated the recommendation, distinguishing between automated and manual recommendations.. Valid values are `personalization_engine|manual_merchandising|promotional_campaign|editorial_curation`',
    `recommendation_status` STRING COMMENT 'Current lifecycle status of the recommendation indicating shopper interaction level.. Valid values are `presented|clicked|added_to_cart|purchased|dismissed|expired`',
    `recommendation_type` STRING COMMENT 'The category or methodology of the recommendation strategy employed.. Valid values are `collaborative_filtering|content_based|hybrid|trending|frequently_bought_together|personalized`',
    `recommended_product_name` STRING COMMENT 'The display name of the recommended product as shown to the shopper.',
    `recommended_sku` STRING COMMENT 'The SKU of the product that was recommended to the shopper.',
    `score` DECIMAL(18,2) COMMENT 'Confidence or relevance score assigned by the recommendation engine, indicating predicted likelihood of shopper interest.',
    `time_on_page_seconds` STRING COMMENT 'The number of seconds the shopper spent on the page where the recommendation was displayed.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured at the time of the recommendation impression.',
    CONSTRAINT pk_product_recommendation PRIMARY KEY(`product_recommendation_id`)
) COMMENT 'Operational record of a product recommendation presented to a shopper on a digital storefront, generated by the personalization engine. Captures recommendation context (homepage, PDP, cart, checkout), recommended SKU, recommendation algorithm/model version, display position, impression timestamp, click flag, add-to-cart flag, and conversion flag. Enables A/B testing of recommendation strategies and measurement of digital merchandising lift.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_status_event` (
    `order_status_event_id` BIGINT COMMENT 'Primary key for order_status_event',
    `associate_id` BIGINT COMMENT 'The unique identifier of the specific actor (associate ID, shopper ID, system process ID, or carrier ID) who triggered this status transition.',
    `carrier_id` BIGINT COMMENT 'Reference to the delivery carrier or logistics provider associated with this status event. Applicable for delivery and shipping fulfillment channels.',
    `order_header_id` BIGINT COMMENT 'Reference to the digital order that experienced this status transition. Links to the parent order header.',
    `store_location_id` BIGINT COMMENT 'The store, Micro-Fulfillment Center (MFC), or Distribution Center (DC) where this status transition occurred.',
    `web_session_id` BIGINT COMMENT 'The application session identifier during which this status transition was recorded. Used for technical troubleshooting and audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this event record was first created in the system. This is the system record creation time, distinct from the business event_timestamp.',
    `device_code` STRING COMMENT 'The unique identifier of the mobile device or terminal that recorded this status transition event. Used for audit and troubleshooting.',
    `dwell_time_minutes` STRING COMMENT 'The number of minutes the order spent in the previous status before this transition. Used for operational efficiency analysis and bottleneck identification.',
    `estimated_completion_timestamp` TIMESTAMP COMMENT 'The estimated date and time when the order will reach its final delivered or ready_for_pickup state. Updated dynamically as the order progresses.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the status transition event occurred in the order lifecycle. This is the business event time, not the system record creation time.',
    `event_type` STRING COMMENT 'The specific status transition type that occurred. Represents the new state the order moved into during this event. [ENUM-REF-CANDIDATE: placed|confirmed|picking_started|ready_for_pickup|out_for_delivery|delivered|cancelled|refund_initiated — 8 candidates stripped; promote to reference product]',
    `exception_code` STRING COMMENT 'The standardized code representing the type of exception that occurred during this status transition. Null if no exception occurred.',
    `exception_description` STRING COMMENT 'Detailed description of the exception or issue that occurred during this status transition. Null if no exception occurred.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this status transition was associated with an operational exception or issue requiring attention.',
    `fulfillment_channel` STRING COMMENT 'The order fulfillment method associated with this status event. Indicates whether the order is for curbside pickup, last-mile delivery (LMD), or ship-to-home.. Valid values are `pickup|delivery|ship_to_home`',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate where this status transition occurred. Captured from mobile devices for delivery events.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate where this status transition occurred. Captured from mobile devices for delivery events.',
    `location_type` STRING COMMENT 'The type of fulfillment location where this status transition occurred. MFC refers to Micro-Fulfillment Center, DC refers to Distribution Center.. Valid values are `store|mfc|dc|carrier_hub`',
    `new_status` STRING COMMENT 'The order status after this transition event. Matches the event_type in most cases.',
    `notes` STRING COMMENT 'Free-form text notes or comments recorded by the actor at the time of this status transition. Used for operational context and issue documentation.',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the shopper of this status transition. Push refers to mobile app push notification.. Valid values are `push|sms|email|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a customer notification was successfully sent for this status transition event. Used for shopper app real-time tracking.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the customer notification was sent for this status event. Null if no notification was sent.',
    `previous_status` STRING COMMENT 'The order status immediately before this transition event. Null for the initial placed event.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether this status transition occurred within the SLA target window. Used for operational SLA breach detection and performance monitoring.',
    `sla_target_timestamp` TIMESTAMP COMMENT 'The target date and time by which this status transition should have occurred to meet the service level agreement commitment to the customer.',
    `sla_variance_minutes` STRING COMMENT 'The difference in minutes between the actual event timestamp and the SLA target timestamp. Negative values indicate early completion, positive values indicate SLA breach.',
    `source_system` STRING COMMENT 'The name or code of the operational system that generated this status event record. Examples include OMS (Order Management System), WMS (Warehouse Management System), TMS (Transportation Management System).',
    `source_system_transaction_ref` STRING COMMENT 'The unique transaction or event identifier from the source operational system. Used for data lineage and reconciliation.',
    `tracking_number` STRING COMMENT 'The carrier-provided tracking number for shipment visibility. Applicable for out_for_delivery and delivered events.',
    `triggered_by` STRING COMMENT 'The actor type that initiated this status transition. Indicates whether the event was automated or human-initiated.. Valid values are `system|associate|shopper|carrier`',
    CONSTRAINT pk_order_status_event PRIMARY KEY(`order_status_event_id`)
) COMMENT 'Immutable event log of each status transition for a digital order, supporting shopper notifications and operational SLA tracking. Captures event type (placed, confirmed, picking_started, ready_for_pickup, out_for_delivery, delivered, cancelled, refund_initiated), event timestamp, triggered_by (system, associate, shopper), store or MFC location, and notification sent flag. Enables real-time order tracking in the shopper app and SLA breach detection.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`channel_config` (
    `channel_config_id` BIGINT COMMENT 'Primary key for channel_config',
    `catalog_id` BIGINT COMMENT 'Reference to the digital catalog assigned to this channel. Determines which products are available for browsing and purchase.',
    `price_book_id` BIGINT COMMENT 'Identifier of the price book used for this channel. Determines pricing rules and promotional pricing logic.',
    `storefront_id` BIGINT COMMENT 'Reference to the digital storefront that this channel configuration applies to. Links to the storefront master data.',
    `accepted_tender_types` STRING COMMENT 'Comma-separated list of payment tender types accepted on this channel (e.g., credit_card, debit_card, gift_card, paypal, apple_pay, google_pay, ebt, snap, wic).',
    `age_verification_required_flag` BOOLEAN COMMENT 'Indicates whether age verification is required for purchases on this channel (e.g., for alcohol, tobacco, pharmacy items).',
    `api_endpoint_url` STRING COMMENT 'Base API endpoint URL for this channel. Used by mobile apps and integrations to connect to backend services.',
    `channel_code` STRING COMMENT 'Unique business identifier code for the digital channel (e.g., WEB_US, IOS_APP, ANDROID_APP, KIOSK).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `channel_config_status` STRING COMMENT 'Current operational status of the digital channel configuration.. Valid values are `active|inactive|maintenance|deprecated|pilot|sunset`',
    `channel_name` STRING COMMENT 'Human-readable name of the digital channel (e.g., Web Storefront, iOS Mobile App, Android Mobile App, In-Store Kiosk).',
    `channel_type` STRING COMMENT 'Classification of the digital channel platform type.. Valid values are `web|mobile_app|kiosk|api|voice`',
    `contact_email` STRING COMMENT 'Customer support email address for inquiries related to this channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Customer support phone number for inquiries related to this channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel configuration record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing and transactions on this channel (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `ebt_eligible_flag` BOOLEAN COMMENT 'Indicates whether this channel accepts Electronic Benefits Transfer (EBT) payments for government assistance programs.',
    `feature_toggles` STRING COMMENT 'JSON or comma-separated list of feature flags and their enabled/disabled state for this channel (e.g., enable_voice_search=true, enable_ar_preview=false). Drives runtime behavior.',
    `fulfillment_methods_supported` STRING COMMENT 'Comma-separated list of fulfillment methods available on this channel (e.g., delivery, pickup, curbside, in_store, ship_to_home). Drives OMS routing logic.',
    `guest_checkout_allowed_flag` BOOLEAN COMMENT 'Indicates whether customers can complete purchases without creating an account (guest checkout) on this channel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel configuration record was last updated.',
    `launch_date` DATE COMMENT 'Date when the digital channel was first made available to customers.',
    `locale_code` STRING COMMENT 'Locale identifier for language and regional formatting (e.g., en_US, es_MX, fr_CA). Drives localization behavior.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `loyalty_program_code` STRING COMMENT 'Identifier of the loyalty program integrated with this channel. Null if no loyalty integration.',
    `loyalty_program_integrated_flag` BOOLEAN COMMENT 'Indicates whether the loyalty program is integrated and active on this channel, allowing customers to earn and redeem points.',
    `maximum_cart_item_count` STRING COMMENT 'Maximum number of distinct line items (SKUs) allowed in a single cart on this channel. Enforces cart size limits.',
    `minimum_age_required` STRING COMMENT 'Minimum age in years required to use this channel or purchase age-restricted items. Typically 18 or 21 depending on jurisdiction and product category.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'Minimum order subtotal required for checkout on this channel. Used to enforce order minimums for delivery or pickup.',
    `personalization_enabled_flag` BOOLEAN COMMENT 'Indicates whether personalized product recommendations and content are enabled on this channel.',
    `platform` STRING COMMENT 'Operating system or platform on which the channel operates (iOS, Android, Web Desktop, Web Mobile, Windows, Linux).. Valid values are `ios|android|web_desktop|web_mobile|windows|linux`',
    `promotion_engine_enabled_flag` BOOLEAN COMMENT 'Indicates whether the promotion engine is active on this channel, allowing application of discounts, coupons, and promotional offers.',
    `search_enabled_flag` BOOLEAN COMMENT 'Indicates whether product search functionality is enabled on this channel.',
    `sla_target_delivery_hours` STRING COMMENT 'Target time in hours for order delivery from order placement to customer receipt for this channel. Used for service level commitments.',
    `sla_target_order_processing_minutes` STRING COMMENT 'Target time in minutes for order processing from submission to fulfillment assignment for this channel. Used for performance monitoring.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this channel accepts SNAP (Supplemental Nutrition Assistance Program) Electronic Benefits Transfer (EBT) payments.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether product substitutions are allowed by default on this channel when items are out of stock during fulfillment.',
    `sunset_date` DATE COMMENT 'Planned or actual date when the digital channel will be or was decommissioned. Null for active channels with no planned sunset.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code for calculating sales tax on transactions in this channel. Used for tax compliance.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the channel (e.g., America/New_York, America/Los_Angeles). Used for scheduling and time display.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this channel accepts WIC (Women, Infants, and Children) program vouchers or EBT.',
    CONSTRAINT pk_channel_config PRIMARY KEY(`channel_config_id`)
) COMMENT 'Configuration master for each digital channel (web, iOS app, Android app, kiosk), capturing feature toggles, supported fulfillment methods, minimum order amounts, accepted tender types, loyalty integration flags, age-verification requirements, SNAP/EBT acceptance flag, maximum cart item count, and channel-specific SLA targets. Drives runtime behavior of the Salesforce Commerce Cloud storefront and OMS routing logic.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`product_item` (
    `product_item_id` BIGINT COMMENT 'Unique identifier for the product item. Primary key for the product_item entity.',
    `brand_id` BIGINT COMMENT 'FK to product.brand',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Item Master Data creation audit requires tracking which associate entered the new product_item; used in compliance and merchandising performance reports.',
    `fuel_grade_id` BIGINT COMMENT 'Foreign key linking to product.product_fuel_grade. Business justification: Fuel grade is a product attribute for fuel items; FK enables lookup.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Product items belong to a hierarchy; linking provides parent classification.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Tracks which legal entity owns/liabilities for a product, needed for entity‑level financial reporting and compliance.',
    `plu_code_id` BIGINT COMMENT 'Foreign key linking to product.plu_code. Business justification: PLU codes are managed centrally; replace string with FK.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Sourcing teams designate a primary supplier per item for purchase order generation and cost negotiations.',
    `age_restricted_flag` BOOLEAN COMMENT 'Indicates whether the item requires age verification at point-of-sale (e.g., alcohol, tobacco, certain pharmacy items).',
    `allergen_information` STRING COMMENT 'List of major allergens contained in or potentially cross-contaminated with the product (e.g., milk, eggs, peanuts, tree nuts, soy, wheat, fish, shellfish). Required for FDA labeling compliance.',
    `case_pack_quantity` STRING COMMENT 'Number of sellable units contained in one case. Used for warehouse receiving, putaway, and replenishment planning.',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Unit cost paid to the supplier or manufacturer. Used for margin calculation and financial reporting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the item was manufactured or grown. Required for customs and labeling compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this item record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this item record was discontinued or became inactive. Null for currently active items.',
    `effective_start_date` DATE COMMENT 'Date when this item record became active and available for ordering and sale.',
    `fda_labeling_required_flag` BOOLEAN COMMENT 'Indicates whether the item requires FDA-compliant nutrition facts labeling and ingredient disclosure.',
    `gtin` STRING COMMENT 'Global Trade Item Number assigned by GS1 for international product identification. May be 8, 12, 13, or 14 digits depending on packaging level.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `haccp_classification` STRING COMMENT 'HACCP risk classification for food safety management. Identifies critical control points for temperature, handling, and contamination prevention.',
    `height_inches` DECIMAL(18,2) COMMENT 'Height dimension of the item package in inches. Used for planogram design and space allocation.',
    `ingredient_statement` STRING COMMENT 'Complete list of ingredients in descending order by weight. Required for FDA-regulated food products.',
    `item_description` STRING COMMENT 'Full business description of the sellable item as it appears in merchandising systems and customer-facing channels.',
    `item_status` STRING COMMENT 'Current lifecycle status of the item in the product catalog. Determines availability for ordering and replenishment.. Valid values are `active|discontinued|seasonal|pending|inactive|obsolete`',
    `item_type` STRING COMMENT 'High-level classification of the item by department or operational area. Determines handling, storage, and regulatory requirements.. Valid values are `grocery|produce|pharmacy|fuel|bakery|deli`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this item record was last updated in the system.',
    `length_inches` DECIMAL(18,2) COMMENT 'Length dimension of the item package in inches. Used for planogram design and space allocation.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or supplier who produces the item. Used for vendor management and sourcing.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age in years required to purchase this item. Typically 18 or 21 for age-restricted products.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified organic by USDA or equivalent certifying body.',
    `pack_size` STRING COMMENT 'Size or quantity of the product package (e.g., 12 oz, 1 gallon, 6-pack). Used for merchandising and pricing.',
    `plu_code` STRING COMMENT 'Price Look-Up code used primarily for fresh produce and bulk items at point-of-sale. Typically 4 or 5 digits.. Valid values are `^[0-9]{4,5}$`',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether the item is a store-owned private-label brand product rather than a national CPG brand.',
    `shelf_life_days` STRING COMMENT 'Number of days the item remains sellable from receipt date. Critical for perishable inventory management and shrink reduction.',
    `sku` STRING COMMENT 'Internal Stock Keeping Unit code used for inventory management, replenishment, and warehouse operations. Unique within the retailers system.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether the item is eligible for purchase using SNAP/EBT benefits.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this item master data originates (e.g., Oracle Retail, SAP MM).',
    `source_system_code` STRING COMMENT 'Unique identifier for this item in the source system. Used for data lineage and reconciliation.',
    `suggested_retail_price` DECIMAL(18,2) COMMENT 'Manufacturers suggested retail price for the item. Used as a reference for pricing and promotional planning.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether sales tax applies to this item at point-of-sale. Tax treatment varies by jurisdiction and item category.',
    `temperature_class` STRING COMMENT 'Required storage temperature classification for the item. Critical for cold chain management and HACCP compliance.. Valid values are `ambient|refrigerated|frozen`',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for inventory tracking and ordering. Standard units include each, case, pound, ounce, gallon, liter, kilogram, gram. [ENUM-REF-CANDIDATE: each|case|pound|ounce|gallon|liter|kilogram|gram — 8 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT '12-digit Universal Product Code used for point-of-sale scanning and inventory tracking. Primary barcode identifier for CPG products.. Valid values are `^[0-9]{12}$`',
    `usda_grade` STRING COMMENT 'USDA quality grade for meat, poultry, dairy, and produce items (e.g., Prime, Choice, Select for beef; Grade A for eggs).',
    `weight_pounds` DECIMAL(18,2) COMMENT 'Weight of the item in pounds. Used for shipping cost calculation and transportation planning.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether the item is approved for purchase under the WIC program.',
    `width_inches` DECIMAL(18,2) COMMENT 'Width dimension of the item package in inches. Used for planogram design and space allocation.',
    CONSTRAINT pk_product_item PRIMARY KEY(`product_item_id`)
) COMMENT 'Core master record and single source of truth for every sellable item in the Grocery catalog — CPG products, private-label brands, fresh produce, pharmacy drug items, and fuel grades. Stores the authoritative item description, brand reference, pack size, unit of measure, item status (active/discontinued/seasonal), item type (grocery/produce/pharmacy/fuel), temperature class (ambient/refrigerated/frozen), HACCP classification, FDA labeling flag, organic certification flag, USDA grade, private-label indicator, and source system reference. Extended by sku (identification codes and sellable units), drug_item (pharmacy attributes), fuel_grade (fuel center attributes), item_attribute (extensible regulatory/compliance flags), and nutritional_info (FDA nutrition/allergen data). Sourced from Oracle Retail Item Management and SAP MM Material Master.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the SKU record. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: SKU generation is performed by a merchandising associate; tracking creator supports audit of SKU assignments and error resolution.',
    `product_item_id` BIGINT COMMENT 'Reference to the parent item master record in the product catalog. Links SKU to the base product definition.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: SKU master data includes a default supplier to streamline PO creation and inventory replenishment.',
    `alcohol_flag` BOOLEAN COMMENT 'Indicates whether this SKU is an alcoholic beverage requiring age verification and special licensing. True for beer, wine, and spirits.',
    `barcode_type` STRING COMMENT 'Type of barcode symbology used for this SKU. Determines scanning compatibility and data capacity. [ENUM-REF-CANDIDATE: UPC-A|UPC-E|EAN-13|EAN-8|GTIN-14|GS1-128|GS1 DataBar — 7 candidates stripped; promote to reference product]',
    `case_pack_quantity` STRING COMMENT 'Number of selling units contained in a case pack for receiving and distribution. Used for warehouse replenishment and DSD deliveries.',
    `catch_weight_flag` BOOLEAN COMMENT 'Indicates whether this SKU is sold by variable weight with price calculated at time of sale. True for meat, seafood, deli, and produce items sold by weight.',
    `check_digit` STRING COMMENT 'Single-digit checksum calculated from the barcode to ensure scanning accuracy. Validates UPC, EAN, and GTIN integrity at POS and receiving.. Valid values are `^[0-9]{1}$`',
    `commodity_type` STRING COMMENT 'Classification of produce or bulk commodity type per IFPS standards. Used for PLU assignment and produce category management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was first created in the system. Used for audit trail and new item tracking.',
    `ean_code` STRING COMMENT '13-digit EAN-13 barcode identifier used internationally. Superset of UPC, used for global product identification and cross-border trade.. Valid values are `^[0-9]{13}$`',
    `effective_end_date` DATE COMMENT 'Date when this SKU is discontinued or removed from active assortment. Null for ongoing items. Used for markdown planning and inventory liquidation.',
    `effective_start_date` DATE COMMENT 'Date when this SKU becomes active and available for sale. Used for new item introductions and seasonal assortment planning.',
    `fda_regulated_flag` BOOLEAN COMMENT 'Indicates whether this SKU is subject to FDA labeling and safety regulations. True for food, beverage, dietary supplements, and OTC drugs.',
    `gs1_company_prefix` STRING COMMENT 'GS1-assigned company prefix portion of the GTIN, identifying the brand owner or manufacturer. Used for barcode validation and supplier identification.. Valid values are `^[0-9]{6,12}$`',
    `gtin` STRING COMMENT '14-digit GTIN identifier used for case and pallet level tracking in supply chain and distribution. Includes packaging hierarchy information.. Valid values are `^[0-9]{14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this SKU contains hazardous materials requiring special handling, storage, or transportation. True for items with flammable, corrosive, or toxic components.',
    `inner_pack_quantity` STRING COMMENT 'Number of selling units contained in an inner pack within a case. Used for shelf replenishment and inventory control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was last updated. Used for change tracking and data synchronization across systems.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether this SKU is certified organic per USDA standards. True for products meeting organic certification requirements. Corresponds to PLU codes starting with 9.',
    `plu_code` STRING COMMENT '4 or 5-digit PLU code used for fresh produce, bulk items, and variable-weight products. Follows IFPS standard. 5-digit codes starting with 9 indicate organic products.. Valid values are `^[0-9]{4,5}$`',
    `primary_barcode_flag` BOOLEAN COMMENT 'Indicates whether this barcode is the primary identifier for POS scanning. True if this is the default barcode, False for alternate barcodes.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this SKU is a store-owned brand product. True for private label, False for national brands and CPG products.',
    `retailer_item_number` STRING COMMENT 'Internal item number assigned by the retailer for merchandising and procurement purposes. May differ from SKU code in multi-location or multi-pack scenarios.. Valid values are `^[A-Z0-9]{8,15}$`',
    `selling_unit_of_measure` STRING COMMENT 'Unit of measure for customer-facing sales transactions. Determines how the item is priced and sold at POS. [ENUM-REF-CANDIDATE: EACH|POUND|OUNCE|KILOGRAM|GRAM|LITER|GALLON|CASE|PACK — 9 candidates stripped; promote to reference product]',
    `shelf_life_days` STRING COMMENT 'Number of days the product remains sellable from receipt date. Critical for perishable inventory management, markdown planning, and FIFO rotation.',
    `size_grade` STRING COMMENT 'Size or grade classification for produce and fresh items. Examples: Small, Medium, Large, Extra Large, Grade A. Used for pricing and quality differentiation.',
    `sku_code` STRING COMMENT 'Retailer-assigned unique alphanumeric code representing a specific item-pack-location combination for inventory and sales tracking. This is the primary business identifier used across POS, WMS, and merchandising systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sku_status` STRING COMMENT 'Current lifecycle status of the SKU. Active items are available for sale and replenishment. Inactive items are temporarily unavailable. Discontinued items are permanently removed from assortment.. Valid values are `ACTIVE|INACTIVE|DISCONTINUED|PENDING|SEASONAL`',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for purchase using SNAP benefits (EBT). True for qualifying food items per USDA guidelines.',
    `temperature_zone` STRING COMMENT 'Required storage and transportation temperature zone for this SKU. Critical for cold chain management and warehouse slotting.. Valid values are `AMBIENT|REFRIGERATED|FROZEN|CONTROLLED`',
    `tobacco_flag` BOOLEAN COMMENT 'Indicates whether this SKU is a tobacco product requiring age verification and regulatory compliance. True for cigarettes, cigars, and vaping products.',
    `upc_code` STRING COMMENT '12-digit UPC-A barcode identifier used for POS scanning and inventory tracking. Primary barcode for most CPG products in North America.. Valid values are `^[0-9]{12}$`',
    `variable_weight_flag` BOOLEAN COMMENT 'Indicates whether this SKU has variable weight for inventory tracking purposes. True for items where each unit may have different weight.',
    `variety` STRING COMMENT 'Specific variety or sub-type of the commodity. Examples: Gala apples, Roma tomatoes, Russet potatoes. Used for produce differentiation and customer selection.',
    `vendor_item_number` STRING COMMENT 'Supplier or manufacturer assigned item number used for ordering, receiving, and EDI transactions. Critical for cross-referencing purchase orders and invoices.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is approved for WIC program purchases. True for items meeting WIC nutritional and category requirements.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Retailer-assigned Stock Keeping Unit representing a unique item-pack-location combination for inventory and sales tracking. Stores SKU code, parent item reference, retailer item number, vendor item number, case pack quantity, inner pack quantity, selling unit of measure, catch-weight flag, variable-weight flag, shelf life days, and SKU status (active/inactive/discontinued). Serves as the authoritative single source of truth for all item identification codes including UPC-A, UPC-E, EAN-13, GTIN-14, GS1 DataBar barcodes (with barcode type, barcode value, GS1 company prefix, check digit, primary barcode flag, effective date range) and PLU codes (IFPS standard PLU, commodity type, variety, organic flag per 9-prefix convention, size/grade). Bridges the item master to store-level assortment, inventory positions, and POS transactions. Supports POS scanning, receiving, EDI transactions, manual PLU entry for produce and bulk items, and multi-barcode lookup for items with multiple packaging configurations. Sourced from Oracle Retail Merchandising System and IFPS.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_hierarchy` (
    `item_hierarchy_id` BIGINT COMMENT 'Unique identifier for each node in the product classification hierarchy. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Hierarchy ownership determines planogram and space allocation; associate owner is tracked for labor planning and audit.',
    `parent_node_item_hierarchy_id` BIGINT COMMENT 'Reference to the parent node in the hierarchy tree. Null for top-level department nodes. Enables recursive hierarchy traversal and roll-up calculations.',
    `supplier_id` BIGINT COMMENT 'Reference to the lead vendor responsible for category management, assortment recommendations, and planogram design for this hierarchy node. Typically assigned at category or subcategory level.',
    `age_restriction_years` STRING COMMENT 'Minimum age in years required to purchase items in this hierarchy node. Applies to alcohol, tobacco, and other age-restricted products. Enforced at POS with ID verification.',
    `average_unit_retail_price` DECIMAL(18,2) COMMENT 'Average retail price per unit for items in this hierarchy node. Used in pricing strategy, competitive analysis, and ASP (Average Selling Price) reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the system. Used for audit trail and data lineage tracking.',
    `dsd_category_flag` BOOLEAN COMMENT 'Indicates whether items in this hierarchy node are typically delivered via DSD (Direct Store Delivery) rather than through DC (Distribution Center). Affects receiving processes and vendor management.',
    `effective_end_date` DATE COMMENT 'Date when this hierarchy node was discontinued or retired. Null for active nodes. Used for historical reporting and category lifecycle analysis.',
    `effective_start_date` DATE COMMENT 'Date when this hierarchy node became active and available for use in assortment planning, reporting, and SKU assignment. Supports temporal hierarchy analysis.',
    `endcap_eligible_flag` BOOLEAN COMMENT 'Indicates whether items in this hierarchy node are suitable for endcap (end-of-aisle display) placement. Used in planogram design and promotional space allocation.',
    `fda_regulated_flag` BOOLEAN COMMENT 'Indicates whether items in this hierarchy node are subject to FDA (Food and Drug Administration) regulation for food safety, labeling, or nutritional information disclosure.',
    `gmroi_target_percentage` DECIMAL(18,2) COMMENT 'Target GMROI (Gross Margin Return on Investment) percentage for this hierarchy node. Used in merchandise planning and performance evaluation. Calculated as (Gross Margin / Average Inventory Cost) * 100.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the hierarchy tree. Typically: 1=Department, 2=Category, 3=Subcategory, 4=Segment, 5=Subsegment. Supports drill-down navigation and roll-up aggregation.',
    `hierarchy_level_name` STRING COMMENT 'Business name for the hierarchy level. Standard retail taxonomy labels used in category management and merchandise planning.. Valid values are `department|category|subcategory|segment|subsegment|class`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was last updated. Used for change tracking, audit trail, and incremental data processing.',
    `leaf_node_flag` BOOLEAN COMMENT 'Indicates whether this node is a leaf (has no children). True for lowest-level nodes that directly contain SKUs (Stock Keeping Units). Used to optimize query performance.',
    `minimum_facings` STRING COMMENT 'Minimum number of product facings (product fronts visible on shelf) required for items in this hierarchy node. Used in planogram compliance and shelf stocking guidelines.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this hierarchy node. Used for audit trail and accountability in category management changes.',
    `node_code` STRING COMMENT 'Business identifier code for the hierarchy node. Used in planograms, assortment planning, and financial reporting. Examples: DEPT01, CAT-DAIRY, SUBCAT-MILK.. Valid values are `^[A-Z0-9]{2,20}$`',
    `node_depth` STRING COMMENT 'Distance from root node (0 for root). Used for hierarchy traversal algorithms and display indentation in user interfaces.',
    `node_description` STRING COMMENT 'Detailed description of the hierarchy node including scope, product types included, and merchandising guidelines.',
    `node_name` STRING COMMENT 'Human-readable name of the hierarchy node. Examples: Fresh Produce, Dairy Products, Organic Milk, Private Label Snacks.',
    `node_path` STRING COMMENT 'Full path from root to current node using node codes separated by forward slashes. Example: DEPT01/CAT-DAIRY/SUBCAT-MILK. Supports fast ancestor queries and breadcrumb navigation.',
    `node_status` STRING COMMENT 'Current lifecycle status of the hierarchy node. Active nodes are used in assortment planning and reporting. Inactive nodes are retained for historical analysis.. Valid values are `active|inactive|pending|discontinued`',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether items in this hierarchy node require USDA organic certification. Drives supplier qualification, labeling requirements, and premium pricing strategies.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether items in this hierarchy node are perishable (fresh produce, dairy, meat, bakery). Drives cold chain requirements, FIFO (First In First Out) handling, and shrink management.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node contains primarily private-label (store-owned brand) products. Used for brand mix analysis and margin optimization.',
    `promotional_category_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node is frequently featured in ad circulars, BOGO (Buy One Get One) promotions, and TPR (Temporary Price Reduction) campaigns. Used in promotional planning.',
    `replenishment_frequency_days` STRING COMMENT 'Standard replenishment cycle in days for items in this hierarchy node. Used in CAO (Computer-Assisted Ordering) and DC (Distribution Center) planning.',
    `seasonality_pattern` STRING COMMENT 'Primary seasonality pattern for demand in this hierarchy node. Used in seasonal assortment planning, inventory forecasting, and promotional calendar development.. Valid values are `year_round|spring|summer|fall|winter|holiday`',
    `shrink_rate_percentage` DECIMAL(18,2) COMMENT 'Expected shrink (inventory loss from theft, spoilage, or damage) rate percentage for this hierarchy node. Used in inventory valuation, loss prevention planning, and COGS (Cost of Goods Sold) calculation.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether items in this hierarchy node are eligible for purchase using SNAP (Supplemental Nutrition Assistance Program) or EBT (Electronic Benefits Transfer) benefits. Required for POS (Point of Sale) transaction processing.',
    `space_allocation_percentage` DECIMAL(18,2) COMMENT 'Target percentage of total store shelf space allocated to this hierarchy node. Used in planogram design and space productivity analysis. Sum of all categories should equal 100% at store level.',
    `target_gross_margin_percentage` DECIMAL(18,2) COMMENT 'Target gross margin percentage for this hierarchy node. Used in pricing decisions, vendor negotiations, and financial planning. Calculated as ((Retail Price - Cost) / Retail Price) * 100.',
    `temperature_zone` STRING COMMENT 'Required temperature zone for storing and displaying items in this hierarchy node. Drives cold chain logistics, WMS (Warehouse Management System) slotting, and HACCP (Hazard Analysis Critical Control Points) compliance.. Valid values are `ambient|refrigerated|frozen|climate_controlled`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether items in this hierarchy node are eligible for purchase using WIC (Women, Infants, and Children) program benefits. Required for POS transaction processing and state reporting.',
    CONSTRAINT pk_item_hierarchy PRIMARY KEY(`item_hierarchy_id`)
) COMMENT 'Product classification hierarchy defining the multi-level taxonomy used for category management, merchandise planning, and financial reporting. Stores each node in the hierarchy (department, category, subcategory, segment, subsegment) with node code, node name, hierarchy level number, parent node reference, category captain vendor, GMROI target, and space allocation percentage. Supports planogram design, assortment optimization, ad circular planning, and COGS roll-up by category. Sourced from Oracle Retail Merchandising System.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`upc_barcode` (
    `upc_barcode_id` BIGINT COMMENT 'Unique identifier for the UPC barcode record. Primary key for the barcode registry.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU that this barcode represents. Links barcode to the master product catalog.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier who provided this barcode. Used for DSD receiving and vendor barcode compliance tracking.',
    `barcode_image_url` STRING COMMENT 'URL to the stored barcode image file used for label printing and visual verification. Supports planogram and shelf label generation.',
    `barcode_status` STRING COMMENT 'Current lifecycle status of the barcode. Active barcodes are scannable at POS and receiving. Recalled barcodes trigger alerts.. Valid values are `Active|Inactive|Pending|Discontinued|Recalled`',
    `barcode_type` STRING COMMENT 'The barcode symbology standard used for this code. Determines the encoding format and scanning requirements. [ENUM-REF-CANDIDATE: UPC-A|UPC-E|EAN-13|EAN-8|GTIN-14|GS1-128|GS1 DataBar — 7 candidates stripped; promote to reference product]',
    `barcode_value` DECIMAL(18,2) COMMENT 'The numeric barcode value as encoded in the barcode symbol. Supports UPC-A (12 digits), UPC-E (8 digits), EAN-13 (13 digits), and GTIN-14 (14 digits).',
    `check_digit` STRING COMMENT 'The calculated check digit at the end of the barcode used to validate barcode accuracy during scanning. Computed using GS1 modulo-10 algorithm.. Valid values are `^[0-9]$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this barcode record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'The date this barcode is discontinued and should no longer be accepted. Null for active barcodes with no planned discontinuation.',
    `effective_start_date` DATE COMMENT 'The date this barcode becomes active and scannable in POS and warehouse systems. Supports phased product launches and barcode transitions.',
    `gs1_company_prefix` STRING COMMENT 'The GS1-assigned company prefix portion of the barcode that identifies the brand owner or manufacturer. Used for vendor identification and EDI transactions.. Valid values are `^[0-9]{6,12}$`',
    `gtin` STRING COMMENT 'The standardized Global Trade Item Number assigned by GS1. May be GTIN-8, GTIN-12, GTIN-13, or GTIN-14 depending on product packaging level.. Valid values are `^[0-9]{8,14}$`',
    `is_age_restricted` BOOLEAN COMMENT 'Indicates whether this product requires age verification at POS (alcohol, tobacco, pharmacy items). Triggers ID check prompt.',
    `is_coupon_eligible` BOOLEAN COMMENT 'Indicates whether this barcode is eligible for manufacturer or store coupon redemption. Used for POS coupon validation.',
    `is_pharmacy_item` BOOLEAN COMMENT 'Indicates whether this barcode is for a pharmacy prescription or over-the-counter drug item requiring special handling and compliance tracking.',
    `is_primary_barcode` BOOLEAN COMMENT 'Indicates whether this is the primary barcode for the SKU. Used when a product has multiple barcodes for different packaging configurations.',
    `is_snap_eligible` BOOLEAN COMMENT 'Indicates whether this product is eligible for purchase using SNAP EBT benefits. Required for government program compliance.',
    `is_store_brand` BOOLEAN COMMENT 'Indicates whether this barcode is for a private-label or store-owned brand product. Used for private label reporting and margin analysis.',
    `is_variable_weight` BOOLEAN COMMENT 'Indicates whether this barcode includes embedded weight or price information for random-weight items like fresh produce and deli products.',
    `is_wic_eligible` BOOLEAN COMMENT 'Indicates whether this product is eligible for purchase using WIC benefits. Must match state WIC approved product lists.',
    `item_reference` STRING COMMENT 'The item reference portion of the GTIN assigned by the brand owner to uniquely identify the product within their company prefix.. Valid values are `^[0-9]{1,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time this barcode record was last updated. Used for change tracking and synchronization with downstream systems.',
    `last_scanned_date` DATE COMMENT 'The most recent date this barcode was scanned at POS or in warehouse operations. Used to identify inactive or obsolete barcodes.',
    `ndc_code` STRING COMMENT 'The FDA National Drug Code for pharmacy items. Used for prescription processing and drug inventory management. Null for non-pharmacy items.. Valid values are `^[0-9]{10,11}$`',
    `packaging_level` STRING COMMENT 'The packaging hierarchy level this barcode represents. Each represents consumer unit, Case represents distribution unit, Pallet represents logistics unit.. Valid values are `Each|Inner Pack|Case|Pallet|Display Unit`',
    `packaging_quantity` STRING COMMENT 'The number of consumer units contained in this packaging level. For Each level this is 1, for Case it represents units per case.',
    `plu_code` STRING COMMENT 'The 4 or 5 digit PLU code used for fresh produce and bulk items that are not pre-packaged. Used at POS for manual entry when barcode is not available.. Valid values are `^[0-9]{4,5}$`',
    `scan_count` BIGINT COMMENT 'Total number of times this barcode has been scanned across all POS and warehouse systems. Used for barcode usage analytics.',
    `source_system` STRING COMMENT 'The system of record that provided this barcode data. Used for data lineage and reconciliation with vendor-provided barcode information.. Valid values are `Oracle Retail|SAP MM|EDI|Vendor Portal|Manual Entry|GS1 Registry`',
    CONSTRAINT pk_upc_barcode PRIMARY KEY(`upc_barcode_id`)
) COMMENT 'Universal Product Code and barcode registry for all items. Stores UPC-A, UPC-E, EAN-13, GTIN-14, and GS1 DataBar codes associated with each SKU, including barcode type, barcode value, GS1 company prefix, check digit, primary barcode flag, and effective date range. Supports POS scanning, receiving, and EDI transactions. Enables multi-barcode lookup for items with multiple packaging configurations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`plu_code` (
    `plu_code_id` BIGINT COMMENT 'Unique identifier for the PLU code record. Primary key.',
    `supplier_id` BIGINT COMMENT 'Identifier of the primary vendor or supplier for this item. Links to vendor master data for procurement and supply chain management.',
    `allergen_info` STRING COMMENT 'Free-text field listing any allergens present in or associated with the item (e.g., Contains tree nuts, May contain traces of peanuts). Required for FDA allergen labeling compliance and customer safety.',
    `average_weight` DECIMAL(18,2) COMMENT 'The average weight per unit for items sold by each (e.g., average weight of one apple). Used for inventory estimation and yield calculations. Null for items sold strictly by weight.',
    `category_code` STRING COMMENT 'The product category code within the department (e.g., FRUIT, VEGETABLE, HERB, NUT). Used for merchandising hierarchy and analytics.',
    `commodity_type` STRING COMMENT 'The broad commodity category for the item (e.g., Apples, Bananas, Tomatoes, Nuts, Cheese). Used for category management and reporting.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The current cost per unit of measure paid to the supplier. Used for margin calculation and GMROI analysis. Business-confidential pricing data.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the product was grown or produced (e.g., USA, MEX, CHL). Required for COOL (Country of Origin Labeling) compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this PLU code record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price (e.g., USD, CAD, MXN). Required for multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The store department code where this item is merchandised (e.g., PRODUCE, DELI, BAKERY, BULK). Used for sales reporting and category management.',
    `effective_date` DATE COMMENT 'The date when this PLU code and its associated pricing became effective. Used for price change tracking and historical analysis.',
    `expiration_date` DATE COMMENT 'The date when this PLU code or pricing is scheduled to expire or be replaced. Null if no expiration is planned. Used for seasonal item management and price change scheduling.',
    `fair_trade_certified_flag` BOOLEAN COMMENT 'Indicates whether the item carries Fair Trade certification. True if certified, False otherwise. Used for marketing, customer transparency, and ethical sourcing reporting.',
    `gmo_flag` BOOLEAN COMMENT 'Indicates whether the item is a genetically modified organism or contains GMO ingredients. True if GMO, False if non-GMO or GMO-free. Used for labeling compliance and customer transparency.',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'The gross margin percentage for this item, calculated as (price - cost) / price * 100. Used for profitability analysis and category management. Business-confidential financial metric.',
    `image_url` STRING COMMENT 'URL or file path to the product image used for digital signage, eCommerce, and mobile app display. Supports omnichannel customer experience.',
    `item_description` STRING COMMENT 'Human-readable description of the produce or bulk item (e.g., Fuji Apples, Organic Bananas, Bulk Almonds).',
    `last_modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this PLU code record was last updated. Used for change tracking and audit compliance.',
    `locally_sourced_flag` BOOLEAN COMMENT 'Indicates whether the item is sourced from local farms or suppliers within a defined geographic radius. True if locally sourced, False otherwise. Used for marketing and sustainability reporting.',
    `nutritional_info` STRING COMMENT 'Free-text or structured field containing key nutritional facts (calories, fat, carbohydrates, protein, vitamins per serving). Used for customer information and FDA nutrition labeling compliance.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether the item is certified organic. True if organic (typically PLU codes starting with 9), False otherwise. Used for pricing, labeling, and compliance with USDA organic certification requirements.',
    `plu_code` STRING COMMENT 'The 4-digit or 5-digit PLU code assigned to the item. 5-digit codes starting with 9 indicate organic products per IFPS convention. This is the externally-known unique identifier used at POS for manual entry.. Valid values are `^[0-9]{4,5}$`',
    `plu_code_status` STRING COMMENT 'Current lifecycle status of the PLU code. Active codes are available for sale; inactive codes are temporarily unavailable; discontinued codes are permanently removed; seasonal codes are available only during specific periods.. Valid values are `active|inactive|discontinued|seasonal`',
    `pos_display_name` STRING COMMENT 'The abbreviated or formatted name displayed on POS terminals and customer receipts. May differ from the full item description for space constraints.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'The current selling price per unit of measure (e.g., price per pound, price per each). Used by POS systems to calculate transaction totals for variable-weight items.',
    `seasonal_availability` STRING COMMENT 'Free-text description of the seasonal availability window for this item (e.g., Summer only, Year-round, Fall harvest). Used for assortment planning and customer communication.',
    `shelf_life_days` STRING COMMENT 'The typical shelf life of the item in days from receipt to expected spoilage or quality degradation. Used for inventory rotation, FIFO management, and shrink reduction. Critical for perishable produce management.',
    `size_grade` STRING COMMENT 'The size or grade classification of the item (e.g., Small, Medium, Large, Extra Large, Grade A). Used for pricing differentiation and customer selection.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using SNAP benefits (formerly food stamps). True if eligible, False otherwise. Required for EBT transaction processing compliance.',
    `storage_temperature_requirement` STRING COMMENT 'The required storage temperature zone for this item (ambient for room temperature, refrigerated for cold chain, frozen for sub-zero). Critical for cold chain compliance and food safety.. Valid values are `ambient|refrigerated|frozen`',
    `subcategory_code` STRING COMMENT 'The product subcategory code for finer classification (e.g., APPLE, CITRUS, LEAFY_GREEN). Supports detailed category management and assortment planning.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether sales tax applies to this item. True if taxable, False if tax-exempt. Tax treatment varies by jurisdiction and product type (e.g., fresh produce may be tax-exempt in some states).',
    `unit_of_measure` STRING COMMENT 'The unit in which the item is sold and priced (e.g., each for individual items, pound for weight-based pricing). Critical for POS transaction processing and pricing calculation.. Valid values are `each|pound|kilogram|ounce|gram`',
    `variety` STRING COMMENT 'The specific variety or cultivar of the commodity (e.g., Fuji, Gala, Honeycrisp for apples; Roma, Beefsteak for tomatoes). Null if not applicable.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using WIC benefits. True if eligible, False otherwise. Required for WIC transaction processing and compliance.',
    CONSTRAINT pk_plu_code PRIMARY KEY(`plu_code_id`)
) COMMENT 'Price Look-Up code registry for fresh produce, bulk items, and variable-weight products not identified by UPC. Stores PLU code (IFPS standard), item description, commodity type, variety, organic flag (9-prefix convention), size/grade, and effective date. Used at POS for manual entry of produce and deli items. Sourced from IFPS (International Federation for Produce Standards) and store operations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_attribute` (
    `item_attribute_id` BIGINT COMMENT 'Primary key for item_attribute',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Attribute maintenance is performed by a data steward associate; needed for data quality metrics and compliance checks.',
    `product_item_id` BIGINT COMMENT 'Reference to the parent item (SKU, UPC, PLU, or drug item) to which this attribute applies. Links to the item master catalog.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this attribute record is currently active and should be used for business operations. Supports soft delete and historical tracking.',
    `age_restricted_flag` BOOLEAN COMMENT 'Indicates whether the item has age restrictions for purchase (e.g., alcohol, tobacco, certain medications). Triggers POS age verification prompts.',
    `attribute_data_type` STRING COMMENT 'The data type of the attribute value to enable proper parsing and validation. Supports string, numeric, boolean, date, and timestamp types.. Valid values are `string|numeric|boolean|date|timestamp`',
    `attribute_group` STRING COMMENT 'Categorical grouping of the attribute for organizational and filtering purposes. Includes regulatory compliance, certifications, physical characteristics, marketing claims, sustainability, nutritional facts, allergen information, and safety warnings. [ENUM-REF-CANDIDATE: regulatory|certification|physical|marketing|sustainability|nutritional|allergen|safety — 8 candidates stripped; promote to reference product]',
    `attribute_name` STRING COMMENT 'The name or key of the attribute being stored (e.g., organic_certified, gluten_free_certified, country_of_origin, bioengineered_disclosure). Enables flexible schema extension without DDL changes.',
    `attribute_source_reference` STRING COMMENT 'External reference identifier or document number from the source system or certifying body that provided this attribute value. Supports audit trail and data lineage.',
    `attribute_value` DECIMAL(18,2) COMMENT 'The value of the attribute stored as a string. May represent text, numeric, boolean, or date values depending on attribute_data_type. Supports regulatory flags, certifications, and compliance indicators.',
    `bioengineered_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the item contains bioengineered (genetically modified) ingredients and requires disclosure under the National Bioengineered Food Disclosure Standard. Mandatory for FDA compliance.',
    `certification_number` STRING COMMENT 'The unique certification or registration number issued by the certifying body. Used for audit trail and regulatory verification. Null for non-certified attributes.',
    `certifying_body` STRING COMMENT 'The name of the organization or regulatory agency that issued the certification or compliance designation (e.g., USDA, FDA, Non-GMO Project, Fair Trade USA, Orthodox Union for Kosher). Null for non-certified attributes.',
    `compliance_status` STRING COMMENT 'Current compliance status of the attribute with respect to regulatory or certification requirements. Tracks whether the item meets the declared standard.. Valid values are `compliant|non_compliant|pending|expired|not_applicable`',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification (Schedule I through V) for pharmacy items. Null for non-controlled substances. Required for pharmacy compliance and inventory controls.',
    `country_of_origin` STRING COMMENT 'The country where the item was produced, manufactured, or grown. Required for COOL (Country of Origin Labeling) compliance for certain food categories.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this attribute record was first created in the system. Supports audit trail and data lineage.',
    `dsd_item_flag` BOOLEAN COMMENT 'Indicates whether the item is delivered directly to stores by the vendor rather than through the distribution center. Affects replenishment planning and receiving processes.',
    `ebt_eligible_flag` BOOLEAN COMMENT 'Indicates whether the item is eligible for purchase using EBT cards. Supports SNAP and other government assistance programs.',
    `effective_date` DATE COMMENT 'The date from which this attribute value becomes valid and applicable. Supports time-variant attribute tracking for regulatory compliance and product lifecycle management.',
    `expiration_date` DATE COMMENT 'The date on which this attribute value expires or is no longer valid. Null for attributes with indefinite validity. Critical for certification renewals and regulatory compliance tracking.',
    `fair_trade_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified fair trade by Fair Trade USA or equivalent certifying body. Supports sustainability and ethical sourcing claims.',
    `gluten_free_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified gluten-free by a recognized certifying body (e.g., GFCO, NSF). Required for gluten-free labeling claims under FDA regulations.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified halal by a recognized Islamic certifying body. Supports dietary preference filtering and marketing.',
    `hazard_classification` STRING COMMENT 'The HACCP hazard classification for the item (e.g., biological, chemical, physical). Used for food safety risk assessment and supply chain controls.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified kosher by a recognized rabbinical authority (e.g., OU, OK, Star-K). Supports dietary preference filtering and marketing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this attribute record was last updated. Supports change tracking and audit trail.',
    `last_verified_date` DATE COMMENT 'The date when this attribute value was last verified or validated against the source system or certifying body. Used for data quality monitoring and compliance audits.',
    `minimum_purchase_age` STRING COMMENT 'The minimum age required to purchase the item, if age restricted. Null for non-age-restricted items. Used for POS validation.',
    `non_gmo_verified_flag` BOOLEAN COMMENT 'Indicates whether the item has been verified as non-GMO by the Non-GMO Project or equivalent certifying body. Supports marketing claims and consumer transparency.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified organic by the USDA or an accredited certifying agent. Required for organic labeling and marketing claims.',
    `planogram_required_flag` BOOLEAN COMMENT 'Indicates whether the item must be merchandised according to a specific planogram layout. Used for space allocation and compliance monitoring.',
    `prescription_required_flag` BOOLEAN COMMENT 'Indicates whether the item requires a valid prescription for purchase. Applicable to pharmacy drug items and certain medical devices.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether the item is a store-owned private label brand product. Used for category management, margin analysis, and promotional planning.',
    `shelf_life_days` STRING COMMENT 'The number of days the item remains safe and suitable for consumption or use under proper storage conditions. Used for inventory rotation (FIFO) and markdown planning.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether the item is eligible for purchase using SNAP benefits (formerly food stamps). Required for POS system configuration and regulatory reporting.',
    `source_system` STRING COMMENT 'The operational system or external data source from which this attribute was ingested (e.g., GS1 Data Sync, vendor EDI feed, certifying body API, Oracle Retail Item Management). Supports data lineage and troubleshooting.',
    `temperature_zone` STRING COMMENT 'The required temperature control zone for storage and transportation of the item. Critical for cold chain compliance and perishable inventory management.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for numeric attribute values (e.g., grams, ounces, milliliters, percent, degrees). Null for non-numeric attributes.',
    `usda_grade` STRING COMMENT 'The USDA quality grade assigned to the item (e.g., Prime, Choice, Select for beef; Grade A for eggs and dairy). Applicable to meat, poultry, dairy, and produce items.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether the item is eligible for purchase using WIC benefits. Required for POS system configuration and state WIC program compliance.',
    CONSTRAINT pk_item_attribute PRIMARY KEY(`item_attribute_id`)
) COMMENT 'Extensible attribute store and single source of truth for item-level business, regulatory, and compliance attributes that vary by item type and cannot be anticipated at schema design time. Captures attribute name, attribute value, attribute data type, attribute group (regulatory, certification, physical, marketing, sustainability), unit of measure, certifying body, certification number, source system, effective date, and expiration date. Stores all regulatory compliance flags including SNAP/WIC/EBT eligibility, FDA bioengineered food disclosure, organic certification, non-GMO verification, gluten-free certification, kosher/halal certifications, fair-trade status, USDA grade designations, country of origin, and compliance status. Enables flexible attribute extension without schema changes. Note: structured nutritional facts and allergen declarations are owned by nutritional_info; this product handles all other regulatory flags and certifications. Sourced from vendor GS1 Sync data, certifying bodies, and regulatory agencies.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`nutritional_info` (
    `nutritional_info_id` BIGINT COMMENT 'Unique identifier for the nutritional information record. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Nutrition label data entry is done by a compliance associate; required for FDA reporting and label accuracy audits.',
    `product_item_id` BIGINT COMMENT 'Reference to the product (SKU) this nutritional information applies to. Links to the authoritative product catalog.',
    `added_sugars_g` DECIMAL(18,2) COMMENT 'Added sugars content per serving, measured in grams. Mandatory disclosure per updated FDA Nutrition Facts label requirements (2016 rule).',
    `allergen_declaration_text` STRING COMMENT 'Full allergen declaration statement as it appears on the product label, including Contains and May Contain statements. Used for customer-facing allergen disclosure on eCommerce and in-store digital displays.',
    `allergen_eggs` BOOLEAN COMMENT 'Indicates whether the product contains eggs or egg-derived ingredients. Part of FALCPA major food allergen declaration.',
    `allergen_fish` BOOLEAN COMMENT 'Indicates whether the product contains fish or fish-derived ingredients. Part of FALCPA major food allergen declaration.',
    `allergen_milk` BOOLEAN COMMENT 'Indicates whether the product contains milk or milk-derived ingredients. Part of FALCPA major food allergen declaration.',
    `allergen_peanuts` BOOLEAN COMMENT 'Indicates whether the product contains peanuts or peanut-derived ingredients. Part of FALCPA major food allergen declaration.',
    `allergen_sesame` BOOLEAN COMMENT 'Indicates whether the product contains sesame or sesame-derived ingredients. Added as the 9th major allergen per FASTER Act (2021).',
    `allergen_shellfish` BOOLEAN COMMENT 'Indicates whether the product contains crustacean shellfish or shellfish-derived ingredients. Part of FALCPA major food allergen declaration.',
    `allergen_soybeans` BOOLEAN COMMENT 'Indicates whether the product contains soybeans or soy-derived ingredients. Part of FALCPA major food allergen declaration.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Indicates whether the product contains tree nuts (almonds, walnuts, cashews, etc.) or tree nut-derived ingredients. Part of FALCPA major food allergen declaration.',
    `allergen_verification_date` DATE COMMENT 'Date when allergen information was last verified by the vendor or certifying body. Critical for recall management and compliance auditing.',
    `allergen_wheat` BOOLEAN COMMENT 'Indicates whether the product contains wheat or wheat-derived ingredients. Part of FALCPA major food allergen declaration.',
    `bioengineered_food_disclosure` STRING COMMENT 'Indicates whether the product contains bioengineered (genetically modified) ingredients, as required by USDA National Bioengineered Food Disclosure Standard.. Valid values are `bioengineered|derived_from_bioengineering|not_bioengineered|unknown`',
    `calcium_mg` DECIMAL(18,2) COMMENT 'Calcium content per serving, measured in milligrams. Mandatory micronutrient disclosure per FDA regulations.',
    `calories` DECIMAL(18,2) COMMENT 'Total calories per serving, expressed in kilocalories (kcal). Mandatory field for FDA Nutrition Facts label.',
    `cholesterol_mg` DECIMAL(18,2) COMMENT 'Cholesterol content per serving, measured in milligrams. Required nutrient on FDA Nutrition Facts label.',
    `data_source` STRING COMMENT 'Source of the nutritional information data (vendor-supplied via GS1 Sync, laboratory analysis, USDA nutrient database, manual entry). Used for data quality assessment and audit trails.. Valid values are `vendor_supplied|gs1_sync|lab_analysis|usda_database|manual_entry`',
    `dietary_fiber_g` DECIMAL(18,2) COMMENT 'Dietary fiber content per serving, measured in grams. Sub-component of total carbohydrates on FDA Nutrition Facts label.',
    `effective_date` DATE COMMENT 'Date when this nutritional information record becomes effective and should be used for labeling and customer disclosure. Supports product reformulation and label change management.',
    `expiration_date` DATE COMMENT 'Date when this nutritional information record is no longer valid, typically due to product reformulation or discontinuation. Nullable for current active records.',
    `fda_compliance_status` STRING COMMENT 'Current compliance status of the nutritional information and labeling with FDA regulations. Used for regulatory auditing and product launch approval.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `gtin` STRING COMMENT '14-digit Global Trade Item Number uniquely identifying the trade item globally. Used for supply chain and EDI transactions.. Valid values are `^[0-9]{14}$`',
    `ingredient_list` STRING COMMENT 'Complete list of ingredients in descending order of predominance by weight, as required by FDA labeling regulations. Used for allergen identification and consumer transparency.',
    `iron_mg` DECIMAL(18,2) COMMENT 'Iron content per serving, measured in milligrams. Mandatory micronutrient disclosure per FDA regulations.',
    `potassium_mg` DECIMAL(18,2) COMMENT 'Potassium content per serving, measured in milligrams. Mandatory micronutrient disclosure per updated FDA Nutrition Facts label.',
    `protein_g` DECIMAL(18,2) COMMENT 'Protein content per serving, measured in grams. Required macronutrient on FDA Nutrition Facts label.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this nutritional information record was first created in the system. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this nutritional information record was last updated. Used for change tracking and data quality monitoring.',
    `saturated_fat_g` DECIMAL(18,2) COMMENT 'Saturated fat content per serving, measured in grams. Required sub-component of total fat on FDA Nutrition Facts label.',
    `serving_size` STRING COMMENT 'The standardized serving size for this product as defined by FDA regulations, expressed in common household measures (e.g., 1 cup, 2 tablespoons, 1 slice) and metric weight or volume.',
    `serving_size_unit` STRING COMMENT 'Unit of measure for the serving size (grams, milliliters, ounces, cups, tablespoons, etc.). [ENUM-REF-CANDIDATE: g|mg|kg|ml|l|oz|lb|cup|tbsp|tsp|slice|piece|container — 13 candidates stripped; promote to reference product]',
    `servings_per_container` DECIMAL(18,2) COMMENT 'Number of servings contained in the package. Required by FDA for Nutrition Facts labeling.',
    `sodium_mg` DECIMAL(18,2) COMMENT 'Sodium content per serving, measured in milligrams. Critical for dietary management and FDA labeling compliance.',
    `total_carbohydrate_g` DECIMAL(18,2) COMMENT 'Total carbohydrate content per serving, measured in grams. Includes dietary fiber, sugars, and other carbohydrates.',
    `total_fat_g` DECIMAL(18,2) COMMENT 'Total fat content per serving, measured in grams. Includes saturated, trans, polyunsaturated, and monounsaturated fats.',
    `total_sugars_g` DECIMAL(18,2) COMMENT 'Total sugars content per serving, measured in grams. Includes naturally occurring and added sugars.',
    `trans_fat_g` DECIMAL(18,2) COMMENT 'Trans fat content per serving, measured in grams. Mandatory disclosure per FDA regulations due to health impact.',
    `upc` STRING COMMENT '12-digit Universal Product Code identifying the product for which nutritional information is provided. Used for barcode scanning and product identification at point of sale.. Valid values are `^[0-9]{12}$`',
    `vitamin_d_mcg` DECIMAL(18,2) COMMENT 'Vitamin D content per serving, measured in micrograms. Mandatory micronutrient disclosure per updated FDA Nutrition Facts label.',
    CONSTRAINT pk_nutritional_info PRIMARY KEY(`nutritional_info_id`)
) COMMENT 'FDA-mandated food compliance record serving as the single source of truth for nutritional facts, allergen declarations, and ingredient data for all food and beverage items. Stores serving size, servings per container, calories, total fat, saturated fat, trans fat, cholesterol, sodium, total carbohydrates, dietary fiber, total sugars, added sugars, protein, vitamins and minerals (D, calcium, iron, potassium), percent daily values, FDA compliance status, ingredient list, allergen type (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame per FALCPA), allergen presence indicator (contains/may contain/free-from), allergen declaration source, allergen verification date, and regulatory compliance flag. Supports FDA Nutrition Facts labeling requirements, FALCPA allergen compliance, digital nutrition and allergen display on eCommerce storefronts, customer dietary filtering, recall management for allergen-related incidents, and bioengineered food disclosure. Sourced from vendor-supplied GS1 Sync data and certifying bodies.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`allergen_declaration` (
    `allergen_declaration_id` BIGINT COMMENT 'Unique identifier for the allergen declaration record. Primary key for the allergen declaration entity.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Allergen declarations are entered by a quality associate; essential for allergen compliance reporting and consumer safety alerts.',
    `product_item_id` BIGINT COMMENT 'Reference to the product item (SKU) to which this allergen declaration applies. Links to the product master catalog.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided the allergen declaration information or ingredient specification.',
    `allergen_type` STRING COMMENT 'Type of allergen declared per FDA FALCPA major food allergen categories: milk, eggs, fish, crustacean shellfish, tree nuts, peanuts, wheat, soybeans, and sesame (added 2023). [ENUM-REF-CANDIDATE: milk|eggs|fish|shellfish|tree_nuts|peanuts|wheat|soybeans|sesame — 9 candidates stripped; promote to reference product]',
    `certification_body` STRING COMMENT 'Name of third-party certification organization that validated the allergen-free claim (e.g., GFCO for gluten-free, FARE for allergen-free certification).',
    `certification_expiration_date` DATE COMMENT 'Expiration date of the allergen certification, after which re-certification or re-validation is required.',
    `certification_number` STRING COMMENT 'Unique certification or registration number issued by the certification body for allergen-free or allergen-controlled product claims.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the allergen declaration against FDA FALCPA requirements and labeling standards.. Valid values are `compliant|non_compliant|pending_review|requires_update`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allergen declaration record was first created in the system.',
    `cross_contact_risk` STRING COMMENT 'Assessment of allergen cross-contact risk during manufacturing, processing, or handling based on facility design, cleaning procedures, and production scheduling.. Valid values are `high|medium|low|none`',
    `declaration_source` STRING COMMENT 'Source of the allergen declaration information: supplier specification sheet, laboratory testing, ingredient analysis, manufacturer label review, or third-party certification body.. Valid values are `supplier_specification|lab_test|ingredient_analysis|manufacturer_label|third_party_certification`',
    `detection_limit_ppm` DECIMAL(18,2) COMMENT 'Laboratory test detection limit for allergen presence expressed in parts per million (ppm), used for quantitative allergen testing and threshold determination.',
    `digital_display_flag` BOOLEAN COMMENT 'Boolean indicator whether this allergen declaration should be displayed on digital commerce channels (website, mobile app) for customer dietary filtering.',
    `effective_date` DATE COMMENT 'Date when this allergen declaration becomes effective and applicable to product labeling and customer communication.',
    `expiration_date` DATE COMMENT 'Date when this allergen declaration expires or is superseded by a new declaration, typically due to formulation changes or supplier changes.',
    `gtin` STRING COMMENT 'GS1 Global Trade Item Number for the product. Standard barcode identifier used for supply chain and point-of-sale scanning.. Valid values are `^[0-9]{8,14}$`',
    `ingredient_source` STRING COMMENT 'Specific ingredient or component that is the source of the allergen (e.g., whey protein concentrate for milk allergen, soy lecithin for soybean allergen).',
    `label_statement` STRING COMMENT 'Exact allergen statement text that appears on the product label or packaging, formatted per FDA requirements (e.g., Contains: Milk, Eggs, Wheat).',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this allergen declaration record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this allergen declaration record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the allergen declaration, including formulation changes, supplier communications, or regulatory guidance.',
    `precautionary_statement` STRING COMMENT 'Optional precautionary allergen statement used when cross-contact risk exists (e.g., May contain traces of peanuts, Processed in a facility that also processes tree nuts).',
    `presence_indicator` STRING COMMENT 'Indicates the level of allergen presence: contains (ingredient), may_contain (cross-contact risk), free_from (certified absent), processed_in_facility (shared equipment warning).. Valid values are `contains|may_contain|free_from|processed_in_facility`',
    `private_label_flag` BOOLEAN COMMENT 'Boolean indicator whether this allergen declaration applies to a private-label (store-owned brand) product requiring internal quality control oversight.',
    `recall_date` DATE COMMENT 'Date when a recall was initiated due to allergen mislabeling or undeclared allergen, if applicable.',
    `recall_flag` BOOLEAN COMMENT 'Boolean indicator whether this allergen declaration is associated with a product recall due to undeclared allergen or labeling error.',
    `test_method` STRING COMMENT 'Specific laboratory test method used to detect or quantify allergen presence (e.g., ELISA, PCR, mass spectrometry), if laboratory testing was performed.',
    `test_result` STRING COMMENT 'Result of laboratory allergen testing: detected (allergen present), not_detected (allergen absent), below_threshold (trace amounts below action level), above_threshold (exceeds acceptable limit).. Valid values are `detected|not_detected|below_threshold|above_threshold`',
    `upc` STRING COMMENT '12-digit Universal Product Code used for retail scanning and inventory management in North America.. Valid values are `^[0-9]{12}$`',
    `verification_date` DATE COMMENT 'Date when the allergen declaration was last verified or validated by quality assurance or regulatory compliance team.',
    `verification_method` STRING COMMENT 'Method used to verify the allergen declaration: document review, laboratory analysis (ELISA/PCR), supplier audit, ingredient traceability review, or visual inspection.. Valid values are `document_review|lab_analysis|supplier_audit|ingredient_traceability|visual_inspection`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this allergen declaration record, typically a quality assurance specialist or regulatory compliance analyst.',
    CONSTRAINT pk_allergen_declaration PRIMARY KEY(`allergen_declaration_id`)
) COMMENT 'Allergen and dietary compliance declarations for food items per FDA FALCPA (Food Allergen Labeling and Consumer Protection Act) requirements. Stores the item reference, allergen type (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame), presence indicator (contains/may contain/free-from), declaration source, verification date, and regulatory compliance flag. Supports FDA labeling compliance, customer dietary filtering on digital channels, and recall management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`private_label` (
    `private_label_id` BIGINT COMMENT 'Unique identifier for the private-label brand. Primary key.',
    `associate_id` BIGINT COMMENT 'Reference to the employee responsible for managing this private-label brand. Used for accountability, performance reviews, and cross-functional collaboration.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Private label brands should reference the master brand entity.',
    `supplier_id` BIGINT COMMENT 'Reference to the primary vendor or co-manufacturer that produces products under this private-label brand. Critical for sourcing, quality control, and supply chain management.',
    `allergen_declaration_required` BOOLEAN COMMENT 'Boolean flag indicating whether products under this private-label brand require allergen declarations per FDA labeling requirements. True if the brand covers categories with common allergens (dairy, nuts, gluten, etc.); False otherwise.',
    `annual_sales_target_amount` DECIMAL(18,2) COMMENT 'The annual sales revenue target for this private-label brand in USD. Used for brand performance tracking, portfolio planning, and merchandising strategy. Confidential business metric.',
    `brand_logo_asset_reference` STRING COMMENT 'URI or file path reference to the digital asset repository location of the brands logo and visual identity files. Used for packaging design, marketing materials, and digital commerce.',
    `brand_owner_business_unit` STRING COMMENT 'The internal business unit or division responsible for managing this private-label brand (e.g., Fresh Foods, Center Store, Health & Wellness, Pharmacy). Used for organizational accountability and P&L reporting.',
    `brand_positioning_statement` STRING COMMENT 'A concise statement defining the brands value proposition, target customer, and competitive differentiation. Used by merchandising, marketing, and category management teams to guide product development and promotional strategy.',
    `brand_status` STRING COMMENT 'Current lifecycle status of the private-label brand. Active brands are in market; inactive brands are temporarily suspended; discontinued brands are permanently retired; pending launch brands are approved but not yet in stores; under review brands are being evaluated for portfolio fit.. Valid values are `active|inactive|discontinued|pending_launch|under_review`',
    `brand_tier` STRING COMMENT 'The positioning tier of the private-label brand within the portfolio. Premium brands target high-quality, differentiated products; standard brands offer everyday value; value brands compete on price; organic brands emphasize certified organic ingredients; specialty brands serve niche categories.. Valid values are `premium|standard|value|organic|specialty`',
    `brand_website_url` STRING COMMENT 'The public-facing website URL for this private-label brand, if one exists. Used for digital marketing, customer education, and omnichannel commerce integration.',
    `country_of_origin_disclosure` STRING COMMENT 'The primary country of origin for products manufactured under this private-label brand, represented as a 3-letter ISO country code (e.g., USA, MEX, CHN). Required for USDA and FTC country-of-origin labeling compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this private-label brand record was first created in the system. Used for audit trail and data lineage tracking.',
    `discontinuation_date` DATE COMMENT 'The date the private-label brand was discontinued or retired from the portfolio. Null for active brands. Used for historical analysis and SKU rationalization reporting.',
    `last_modified_by_user` STRING COMMENT 'The username or employee identifier of the user who last modified this private-label brand record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this private-label brand record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `launch_date` DATE COMMENT 'The date the private-label brand was first introduced to market. Used for brand lifecycle analysis, anniversary promotions, and portfolio performance tracking.',
    `nutritional_labeling_standard` STRING COMMENT 'The FDA-mandated labeling format required for products under this private-label brand. FDA standard applies to most food products; dual column is used for multi-serving packages; supplement facts applies to dietary supplements; drug facts applies to OTC pharmacy items; not applicable for non-food items.. Valid values are `fda_standard|fda_dual_column|supplement_facts|drug_facts|not_applicable`',
    `packaging_specification_reference` STRING COMMENT 'Reference identifier or document link to the master packaging specification for this private-label brand. Includes material standards, labeling requirements, sustainability guidelines, and FDA compliance specifications.',
    `quality_standard_tier` STRING COMMENT 'The quality assurance tier applied to this private-label brand. Basic tier meets minimum regulatory standards; enhanced tier includes additional quality checks; premium tier requires rigorous testing and certification; certified organic tier meets USDA organic standards; GMP (Good Manufacturing Practice) certified tier meets pharmaceutical-grade standards for pharmacy private-label items.. Valid values are `basic|enhanced|premium|certified_organic|gmp_certified`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this private-label brand is currently in full compliance with all applicable FDA, USDA, DEA, and state regulatory requirements. True indicates compliant; False indicates compliance issues requiring resolution.',
    `social_media_handle` STRING COMMENT 'The primary social media handle or username for this private-label brand (e.g., @GroceryEssentials). Used for digital marketing campaigns and customer engagement tracking.',
    `sustainability_certification` STRING COMMENT 'Third-party sustainability or ethical sourcing certification held by this private-label brand. None indicates no certification; other values represent specific certifications (Rainforest Alliance, Fair Trade, Non-GMO Project, USDA Organic, Marine Stewardship Council, Forest Stewardship Council). [ENUM-REF-CANDIDATE: none|rainforest_alliance|fair_trade|non_gmo_project|usda_organic|msc_certified|fsc_certified — 7 candidates stripped; promote to reference product]',
    `target_category` STRING COMMENT 'The primary product category or department this private-label brand is designed to serve (e.g., Dairy, Bakery, Frozen Foods, Health & Beauty, Pharmacy OTC). Used for category management and assortment planning.',
    `target_margin_percentage` DECIMAL(18,2) COMMENT 'The target gross margin percentage for products under this private-label brand, expressed as a percentage (e.g., 35.50 for 35.5%). Used for pricing strategy, vendor negotiations, and profitability analysis. Confidential business metric.',
    CONSTRAINT pk_private_label PRIMARY KEY(`private_label_id`)
) COMMENT 'Private-label brand registry managing Grocerys store-owned brand portfolio. Stores brand name, brand tier (premium/standard/value/organic), brand logo asset reference, brand launch date, brand status, co-manufacturer vendor reference, quality standard tier, target category, brand positioning statement, and packaging specification reference. Supports private-label brand development, sourcing decisions, and category management strategy. Owned by the Grocery merchandising and private-label development team.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`brand` (
    `brand_id` BIGINT COMMENT 'Unique identifier for the brand. Primary key. Inferred role: MASTER_RESOURCE.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor designated as the category captain for the category where this brand competes. The category captain provides market insights, planogram recommendations, and assortment guidance. Used for vendor collaboration and category management.',
    `brand_co_manufacturer_vendor_supplier_id` BIGINT COMMENT 'Reference to the co-manufacturer or contract manufacturer who produces private-label products under this brand on behalf of Grocery. Null for non-private-label brands. Used for private-label sourcing and quality management.',
    `brand_supplier_id` BIGINT COMMENT 'Reference to the primary vendor or supplier who provides products under this brand. For CPG brands, this is the manufacturer. For private-label brands, this is the co-manufacturer or contract packer.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Brands are owned by legal entities; linking enables brand‑level profit and expense reporting.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Brand management is overseen by a specific associate; required for brand profitability reporting and accountability.',
    `allergen_declaration` STRING COMMENT 'A comma-separated list of major food allergens that are present in products under this brand or manufactured in facilities that process these allergens. Used for FDA allergen labeling compliance and customer safety. Examples: milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame.',
    `brand_code` STRING COMMENT 'Internal short code or abbreviation used for the brand in merchandising systems, planograms, and reporting. Serves as a business identifier for operational use.',
    `brand_description` STRING COMMENT 'A detailed narrative description of the brand, its history, values, product range, and unique selling propositions. Used for eCommerce content, marketing materials, and internal training.',
    `brand_name` STRING COMMENT 'The official marketing name of the brand as it appears on product packaging and promotional materials. This is the primary human-readable identifier for the brand.',
    `brand_status` STRING COMMENT 'Current lifecycle state of the brand. Active brands are currently sold and replenished. Inactive brands are temporarily not available. Discontinued brands are permanently removed from assortment. Pending launch brands are approved but not yet in stores. Phasing out brands are being replaced. Seasonal brands are active only during specific periods.. Valid values are `active|inactive|discontinued|pending_launch|phasing_out|seasonal`',
    `brand_tier` STRING COMMENT 'Quality and pricing tier of the brand within its category. Premium brands command higher price points and emphasize quality. Standard brands are mainstream offerings. Value and economy brands compete on price. Organic brands meet USDA organic certification. Specialty brands target niche segments.. Valid values are `premium|standard|value|organic|specialty|economy`',
    `brand_type` STRING COMMENT 'Classification of the brand by market scope and ownership model. National brands are widely distributed CPG manufacturer brands. Regional brands have limited geographic distribution. Private-label and store brands are owned by Grocery. Generic brands are unbranded commodity products. Exclusive brands are third-party brands sold only at Grocery.. Valid values are `national|regional|private_label|generic|store_brand|exclusive`',
    `country_of_origin` STRING COMMENT 'The primary country where the brand is headquartered or where the majority of its products are manufactured. Represented as ISO 3166-1 alpha-3 country code. Used for country-of-origin labeling compliance and sourcing analytics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this brand record was first created in the system. Used for data lineage and audit trail.',
    `discontinuation_date` DATE COMMENT 'The date when the brand was permanently discontinued and removed from the assortment. Null for active brands. Used for historical analysis and SKU rationalization reporting.',
    `exclusive_to_grocery_flag` BOOLEAN COMMENT 'Indicates whether this brand is sold exclusively at Grocery stores and not available through competing retailers. True for private-label brands and exclusive third-party brands. False for national and regional brands available at multiple retailers. Used for competitive differentiation analysis.',
    `fair_trade_certified_flag` BOOLEAN COMMENT 'Indicates whether the brand is Fair Trade Certified by Fair Trade USA or another recognized fair trade certification body. True for certified brands. False otherwise. Used for ethical sourcing reporting and sustainability merchandising.',
    `gluten_free_certified_flag` BOOLEAN COMMENT 'Indicates whether the brand is certified gluten-free by a recognized certification body such as GFCO (Gluten-Free Certification Organization) and meets FDA gluten-free labeling standards. True for certified brands. False otherwise. Used for allergen management and dietary preference merchandising.',
    `gs1_company_prefix` STRING COMMENT 'The GS1-assigned company prefix that appears in the GTIN and UPC barcodes for all products under this brand. Used to identify the brand owner in global supply chain systems and for barcode validation.. Valid values are `^[0-9]{6,12}$`',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the brand is certified halal by a recognized halal certification body and meets Islamic dietary law requirements. True for certified brands. False otherwise. Used for religious dietary compliance and specialty merchandising.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the brand is certified kosher by a recognized kosher certification agency and authorized to display a kosher symbol. True for certified brands. False otherwise. Used for religious dietary compliance and specialty merchandising.',
    `last_modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this brand record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this brand record was most recently updated. Used for change tracking and data quality monitoring.',
    `launch_date` DATE COMMENT 'The date when the brand was first introduced to the market or first carried by Grocery stores. Used for brand lifecycle analysis and new item introduction tracking.',
    `logo_asset_reference` STRING COMMENT 'Reference identifier or URI to the digital asset management system location where the official brand logo and visual identity assets are stored. Used for planogram design, ad circular production, and eCommerce merchandising.',
    `non_gmo_verified_flag` BOOLEAN COMMENT 'Indicates whether the brand is verified by the Non-GMO Project and authorized to display the Non-GMO Project Verified seal. True for verified brands. False otherwise. Used for product labeling and consumer transparency.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the brand holds USDA organic certification and is authorized to use the USDA Organic seal on product packaging. True for certified organic brands. False otherwise. Used for regulatory compliance and organic category reporting.',
    `owner` STRING COMMENT 'The legal entity that owns the intellectual property rights to the brand. For CPG brands, this is the manufacturer or parent company. For private-label brands, this is Grocery or its subsidiary. For licensed brands, this is the licensor.',
    `packaging_specification_reference` STRING COMMENT 'Reference identifier to the master packaging specification document or system record that defines standard packaging formats, materials, labeling requirements, and sustainability attributes for products under this brand. Used for private-label development and vendor compliance.',
    `parent_company` STRING COMMENT 'The ultimate parent corporation that owns the brand owner entity. Used to group brands by corporate family for vendor relationship management and category analysis. May be the same as brand owner for independent brands.',
    `positioning_statement` STRING COMMENT 'A concise statement describing the brands value proposition, target customer segment, and competitive differentiation. Used for merchandising strategy, marketing alignment, and private-label brand development. Example: Premium organic dairy products for health-conscious families.',
    `private_label_development_stage` STRING COMMENT 'For private-label brands only, the current stage in the brand development lifecycle. Concept stage is initial ideation. Sourcing stage is vendor selection. Formulation stage is product development. Testing stage is quality validation. Approved stage is ready for launch. Launched stage is in-market. Mature stage is established. Null for non-private-label brands. [ENUM-REF-CANDIDATE: concept|sourcing|formulation|testing|approved|launched|mature — 7 candidates stripped; promote to reference product]',
    `quality_standard_tier` STRING COMMENT 'The quality assurance and certification level for the brand. Tier 1 represents highest quality standards with rigorous testing. Tier 2 is standard quality. Tier 3 is basic quality. Certified organic meets USDA organic standards. Non-GMO meets Non-GMO Project verification. Fair Trade meets Fair Trade USA certification.. Valid values are `tier_1|tier_2|tier_3|certified_organic|non_gmo|fair_trade`',
    `sustainability_certification` STRING COMMENT 'The name of any sustainability or environmental certification held by the brand, such as Rainforest Alliance, Marine Stewardship Council, Forest Stewardship Council, or B Corporation. Null if no sustainability certification. Used for ESG reporting and sustainable product merchandising. [ENUM-REF-CANDIDATE: rainforest_alliance|marine_stewardship_council|forest_stewardship_council|b_corporation|carbon_neutral|regenerative_organic|utz_certified — promote to reference product]',
    `target_category` STRING COMMENT 'The primary product category or department where this brand is positioned. Used for category management, assortment planning, and category captain assignments. Examples include Dairy, Bakery, Frozen Foods, Health and Beauty, Pharmacy.',
    `website_url` STRING COMMENT 'The official website URL for the brand where consumers can find product information, recipes, and brand story. Used for digital commerce integration and customer engagement.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Brand master registry and single source of truth for all brands sold across Grocery stores — including CPG manufacturer brands, regional brands, and Grocerys private-label store-owned brand portfolio. Stores brand name, brand owner (manufacturer or Grocery private-label), brand type (national/regional/private-label/generic), brand tier (premium/standard/value/organic), parent company, GS1 company prefix, brand status, country of origin, brand logo asset reference, brand launch date, co-manufacturer vendor reference, quality standard tier, target category, brand positioning statement, and packaging specification reference. For private-label brands, additionally tracks brand development lifecycle, sourcing decisions, and category management strategy. Serves as the authoritative brand reference for item master, assortment planning, vendor relationship management, and private-label brand portfolio management. Sourced from merchandising, vendor management, and private-label development teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_cost` (
    `item_cost_id` BIGINT COMMENT 'Unique identifier for the item cost record. Primary key for the item cost entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for cost accounting reports that allocate each SKUs cost to a specific cost center for budgeting and variance analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps each item cost to the appropriate GL expense account for automatic posting in the general ledger.',
    `associate_id` BIGINT COMMENT 'Reference to the user or employee who approved this cost record. Supports audit trail and SOX compliance for cost change authorization.',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotional event or campaign during which this promotional cost applies. Used to measure promotional lift and incremental margin impact.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this cost record applies. Links to the product master catalog.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier providing this item at the specified cost. Each SKU-vendor combination may have distinct cost structures.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this cost record was approved. Part of the audit trail for cost change management and financial controls.',
    `base_unit_cost` DECIMAL(18,2) COMMENT 'The fundamental unit cost from the vendor before any allowances, discounts, or additional charges. This is the invoice line item cost per unit as stated by the supplier.',
    `billback_allowance` DECIMAL(18,2) COMMENT 'Post-invoice allowance claimed back from the vendor after the sale or promotion period. Requires submission of proof-of-performance documentation. Expressed in the same currency and unit basis as base cost.',
    `contract_reference_number` STRING COMMENT 'External reference number or identifier of the vendor contract or purchase agreement under which this cost is defined. Links cost to legal or commercial terms.',
    `cost_approval_status` STRING COMMENT 'Workflow approval status for this cost record. Indicates whether the cost has been reviewed and approved by procurement or finance before being applied to transactions.. Valid values are `approved|pending_approval|rejected|auto_approved`',
    `cost_basis` STRING COMMENT 'The unit of measure on which the base unit cost is calculated. Indicates whether cost is per individual item (each), per case, per pallet, per unit weight, or per unit volume.. Valid values are `each|case|pallet|weight|volume`',
    `cost_notes` STRING COMMENT 'Free-text field for additional context, explanations, or special conditions related to this cost record. May include reasons for manual overrides, contract clauses, or vendor negotiation details.',
    `cost_source` STRING COMMENT 'Indicates the origin or method by which this cost was captured. EDI 832 is electronic price catalog from vendor; vendor contract is negotiated agreement; manual override is user-entered adjustment; system calculated is derived by ERP; purchase order is actual PO line cost.. Valid values are `edi_832|vendor_contract|manual_override|system_calculated|purchase_order`',
    `cost_status` STRING COMMENT 'Current lifecycle status of the cost record. Active indicates the cost is in use; pending indicates awaiting approval or effective date; expired indicates past effective end date; superseded indicates replaced by newer cost; suspended indicates temporarily inactive.. Valid values are `active|pending|expired|superseded|suspended`',
    `cost_type` STRING COMMENT 'Classification of the cost record indicating the costing methodology applied. Standard cost is the baseline expected cost; actual cost reflects real invoice amounts; contract cost is negotiated rate; promotional cost applies during vendor promotions; landed cost includes all acquisition expenses; average cost is weighted average over time.. Valid values are `standard|actual|contract|promotional|landed|average`',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'The difference between standard cost and actual cost for this SKU-vendor combination. Positive variance indicates actual cost exceeded standard; negative indicates savings. Used for procurement performance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the cost is denominated (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `dead_net_cost` DECIMAL(18,2) COMMENT 'The final, fully-loaded cost per unit after applying all allowances, discounts, freight, handling, and amortized fees. This is the true cost used for gross margin and GMROI (Gross Margin Return on Investment) calculations.',
    `effective_end_date` DATE COMMENT 'The date on which this cost record expires or is superseded by a new cost record. Null indicates the cost is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'The date from which this cost record becomes active and applicable for costing transactions. Supports time-based cost history and contract period tracking.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost allocated to this SKU for moving goods from vendor to distribution center or store. May be actual freight invoice or allocated based on weight/volume. Expressed per unit basis.',
    `handling_cost` DECIMAL(18,2) COMMENT 'Warehouse or distribution center handling cost allocated to this SKU, including receiving, putaway, storage, and picking activities. Expressed per unit basis.',
    `is_primary_vendor` BOOLEAN COMMENT 'Boolean flag indicating whether this vendor is the primary or preferred source for this SKU. True if primary; false if secondary or backup vendor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost record was last updated. Supports change tracking and audit requirements.',
    `last_purchase_date` DATE COMMENT 'The most recent date on which this SKU was purchased from this vendor at this cost. Supports cost aging analysis and vendor performance tracking.',
    `lead_time_days` STRING COMMENT 'The number of days between placing a purchase order and receiving the goods from this vendor for this SKU. Used for replenishment planning and inventory optimization.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered from the vendor to qualify for this cost. Expressed in the same unit of measure as cost basis.',
    `off_invoice_allowance` DECIMAL(18,2) COMMENT 'Immediate discount or allowance deducted directly from the invoice at the time of purchase. Reduces the base unit cost before payment. Expressed in the same currency and unit basis as base cost.',
    `purchase_order_number` STRING COMMENT 'Reference to the specific purchase order from which this actual cost was derived. Applicable when cost type is actual and sourced from a PO receipt.',
    `scan_based_trading_allowance` DECIMAL(18,2) COMMENT 'Allowance applied under scan-based trading arrangements where the retailer pays the vendor only when the item is sold (scanned at POS). Reflects the discount or rebate negotiated under SBT terms.',
    `slotting_fee_amortization` DECIMAL(18,2) COMMENT 'Amortized portion of the one-time slotting fee paid to secure shelf space for this SKU, allocated per unit over the expected sales volume or contract period. Contributes to total landed cost.',
    CONSTRAINT pk_item_cost PRIMARY KEY(`item_cost_id`)
) COMMENT 'Landed cost record for each SKU-vendor combination capturing all cost components used in margin and COGS analysis. Stores base cost (unit cost from vendor), off-invoice allowances, billback allowances, scan-based trading allowances, freight cost, handling cost, slotting fee amortization, effective date range, cost type (standard/actual/contract/promotional), cost basis (case/each/weight), currency code, and cost source (EDI 832 price catalog, vendor contract, manual override). Supports gross margin calculation, GMROI analysis, promotional lift measurement, and dead net cost reporting. Sourced from SAP MM Purchasing and Oracle Retail Price Management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_lifecycle_event` (
    `item_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the item lifecycle event record. Primary key.',
    `category_id` BIGINT COMMENT 'Reference to the product category to which the item belonged at the time of this lifecycle event. Supports category management analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lifecycle events generate costs that need allocation to the responsible cost center for budgeting and analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial impact of lifecycle events (e.g., recalls) must be posted to a GL account for accurate financial statements.',
    `associate_id` BIGINT COMMENT 'Reference to the user who initiated or approved the lifecycle event. Null if the event was triggered by an automated system process.',
    `product_item_id` BIGINT COMMENT 'Reference to the item (SKU) in the product catalog that this lifecycle event pertains to.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with the item at the time of this lifecycle event. Relevant for supplier-driven discontinuations, recalls, or quality issues.',
    `affected_dc_count` STRING COMMENT 'Number of distribution centers impacted by this lifecycle event. Supports supply chain impact analysis.',
    `affected_store_count` STRING COMMENT 'Number of stores impacted by this lifecycle event. Relevant for recalls, discontinuations, and new item introductions to track distribution scope.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event required formal approval from management or a governance committee before execution.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event was formally approved. Null if no approval was required or approval is pending.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event was triggered to maintain regulatory compliance (True) or for other business reasons (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this lifecycle event record was first created in the data lakehouse. System audit field.',
    `effective_date` DATE COMMENT 'The date on which the lifecycle event becomes effective for business operations. May differ from event_timestamp for planned future events.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the lifecycle event in USD, including inventory write-offs, recall costs, or lost sales. Used for financial planning and reporting.',
    `estimated_inventory_units` DECIMAL(18,2) COMMENT 'Estimated quantity of inventory units affected by this lifecycle event across all locations at the time of the event. Used for recall scope and financial impact assessment.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event occurred in the real world. This is the business event time, not the system record creation time.',
    `event_type` STRING COMMENT 'Type of lifecycle event. Indicates the nature of the state change for the item (e.g., new item introduction, discontinuation, reactivation, reformulation, recall initiation, recall closure, regulatory hold, organic certification granted, organic certification revoked).. Valid values are `new_item_introduction|item_discontinuation|item_reactivation|reformulation|recall_initiation|recall_closure`',
    `new_status` STRING COMMENT 'The lifecycle status of the item after this event was applied. Represents the target state of the transition.. Valid values are `active|inactive|pending|discontinued|recalled|on_hold`',
    `notes` STRING COMMENT 'Additional free-text notes or comments providing context, instructions, or follow-up actions related to the lifecycle event.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether customer or stakeholder notifications were sent for this lifecycle event (e.g., recall notices, discontinuation alerts to vendors).',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when notifications were sent to customers, vendors, or regulatory agencies regarding this lifecycle event.',
    `prior_status` STRING COMMENT 'The lifecycle status of the item immediately before this event occurred. Supports audit trail and state transition analysis.. Valid values are `active|inactive|pending|discontinued|recalled|on_hold`',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the lifecycle event. [ENUM-REF-CANDIDATE: low_sales|supplier_discontinuation|regulatory_violation|quality_issue|seasonal_rotation|product_refresh|contamination|labeling_error|allergen_mislabel|expired_certification|voluntary_recall|mandatory_recall|market_expansion|assortment_optimization — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text explanation providing additional context and details about why the lifecycle event was triggered. Complements the reason code with narrative detail.',
    `recall_class` STRING COMMENT 'FDA recall classification indicating the severity of the health hazard. Class I: dangerous or defective products that could cause serious health problems or death. Class II: products that might cause temporary health problem or slight threat of serious nature. Class III: products unlikely to cause adverse health reaction but violate FDA labeling or manufacturing regulations. Populated only for recall events.. Valid values are `class_i|class_ii|class_iii`',
    `recall_number` STRING COMMENT 'Official recall identification number assigned by the FDA, USDA, or internal recall management system. Populated only for recall-related events.',
    `regulatory_agency` STRING COMMENT 'The governing body or regulatory agency associated with this lifecycle event (e.g., FDA for food recalls, DEA for controlled substance holds, USDA for organic certification changes).. Valid values are `fda|usda|dea|state_pharmacy_board|epa|other`',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this lifecycle event was captured (e.g., Oracle Retail Merchandising System, SAP MM, McKesson Pharmacy Systems).',
    `source_system_event_ref` STRING COMMENT 'Unique identifier of the lifecycle event in the source operational system. Enables traceability back to the originating system.',
    `supporting_document_url` STRING COMMENT 'URL or file path to supporting documentation for the lifecycle event (e.g., FDA recall notice, supplier discontinuation letter, reformulation specification sheet).',
    `triggered_by_system` STRING COMMENT 'Name or identifier of the system that triggered the lifecycle event if it was automated (e.g., Oracle Retail Merchandising System, SAP MM, Blue Yonder Demand Planning). Null if manually triggered by a user.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this lifecycle event record was last modified in the data lakehouse. System audit field.',
    CONSTRAINT pk_item_lifecycle_event PRIMARY KEY(`item_lifecycle_event_id`)
) COMMENT 'Audit trail of significant lifecycle state changes for items in the catalog. Captures event type (new item introduction, item discontinuation, item reactivation, reformulation, recall initiation, recall closure, regulatory hold, organic certification granted/revoked), event timestamp, triggered-by user or system, prior status, new status, reason code, and supporting notes. Enables traceability for FDA recall management, regulatory compliance reporting, and category management workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`drug_item` (
    `drug_item_id` BIGINT COMMENT 'Unique identifier for the pharmacy drug item record. Primary key for the drug item master.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Drug items extend core product items; FK creates proper inheritance.',
    `active_ingredient` STRING COMMENT 'Primary active pharmaceutical ingredient (API) responsible for the therapeutic effect. May include multiple ingredients separated by semicolons for combination drugs.',
    `brand_name` STRING COMMENT 'Proprietary brand name of the drug product as marketed by the manufacturer (e.g., Lipitor, Advil).',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether the drug is classified as a controlled substance requiring special handling, documentation, and security per DEA regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drug item record was first created in the pharmacy system.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance classification (I through V) indicating abuse potential and regulatory restrictions. Non-scheduled indicates the drug is not a controlled substance.. Valid values are `I|II|III|IV|V|non-scheduled`',
    `discontinuation_date` DATE COMMENT 'Date the drug was discontinued by the manufacturer or removed from the pharmacy formulary. Null for active drugs.',
    `dosage_form` STRING COMMENT 'Physical form in which the drug is manufactured and dispensed (e.g., tablet, capsule, liquid, injection). [ENUM-REF-CANDIDATE: tablet|capsule|liquid|injection|cream|ointment|gel|patch|inhaler|suppository|powder|suspension|solution|spray|drops|lozenge — 16 candidates stripped; promote to reference product]',
    `drug_interaction_group` STRING COMMENT 'Classification code or group identifier used by pharmacy systems to screen for potential drug-drug interactions, contraindications, and adverse reactions.',
    `drug_item_status` STRING COMMENT 'Current lifecycle status of the drug item in the pharmacy inventory system. Active items are available for dispensing, discontinued items are no longer stocked, recalled items have FDA safety alerts, back-ordered items are temporarily unavailable, restricted items require special authorization.. Valid values are `active|discontinued|recalled|back_ordered|restricted`',
    `expiration_tracking_method` STRING COMMENT 'Method used to track and manage drug expiration dates in inventory. Lot-based tracks by manufacturing lot, unit-based tracks individual units, FIFO (First In First Out) dispenses oldest stock first, FEFO (First Expired First Out) dispenses nearest expiration first.. Valid values are `lot_based|unit_based|fifo|fefo`',
    `fda_approval_date` DATE COMMENT 'Date the drug received FDA approval for marketing and distribution in the United States.',
    `formulary_status` STRING COMMENT 'Insurance formulary classification indicating coverage tier and restrictions (preferred, non-preferred, excluded, or requiring prior authorization).. Valid values are `preferred|non-preferred|excluded|prior_authorization_required`',
    `generic_name` STRING COMMENT 'Non-proprietary generic name of the drug using the United States Adopted Name (USAN) or International Nonproprietary Name (INN) convention (e.g., atorvastatin, ibuprofen).',
    `gtin` STRING COMMENT 'GS1 Global Trade Item Number uniquely identifying the drug product for supply chain and inventory management. 14-digit format.. Valid values are `^[0-9]{14}$`',
    `hazardous_drug_flag` BOOLEAN COMMENT 'Indicates whether the drug is classified as hazardous per NIOSH guidelines, requiring special handling, personal protective equipment, and disposal procedures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the drug item record was last modified in the pharmacy system. Used for change tracking and data synchronization with McKesson Pharmacy Systems.',
    `manufacturer_labeler_code` STRING COMMENT 'FDA-assigned 5-digit labeler code identifying the manufacturer or distributor. First segment of the NDC.. Valid values are `^[0-9]{5}$`',
    `manufacturer_name` STRING COMMENT 'Name of the pharmaceutical company that manufactures or markets the drug product.',
    `mckesson_drug_code` STRING COMMENT 'McKesson proprietary drug identifier used for ordering, inventory management, and integration with McKesson Pharmacy Systems drug database.',
    `multi_source_code` STRING COMMENT 'FDA Orange Book code indicating generic availability. Y = generic available, N = no generic available, O = original brand with generic equivalents.. Valid values are `Y|N|O`',
    `ndc` STRING COMMENT 'FDA-assigned National Drug Code uniquely identifying the drug product, labeler, and package size. Standard 11-digit format with hyphens (5-4-2, 5-3-2, or 4-4-2 configuration).. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `package_size` STRING COMMENT 'Quantity and unit of measure for the drug package (e.g., 30 tablets, 100 mL, 1 vial). Represents the dispensing unit size.',
    `prescription_required_flag` BOOLEAN COMMENT 'Indicates whether the drug requires a valid prescription (Rx) or is available over-the-counter (OTC). True for prescription drugs, False for OTC drugs.',
    `refrigeration_required_flag` BOOLEAN COMMENT 'Indicates whether the drug must be stored under refrigerated conditions (2-8°C) to maintain stability and efficacy.',
    `repackaged_flag` BOOLEAN COMMENT 'Indicates whether the drug has been repackaged from bulk containers into smaller dispensing units by a repackager rather than the original manufacturer.',
    `route_of_administration` STRING COMMENT 'Method by which the drug is administered to the patient (e.g., oral, topical, intravenous, intramuscular). [ENUM-REF-CANDIDATE: oral|topical|intravenous|intramuscular|subcutaneous|inhalation|rectal|ophthalmic|otic|nasal|transdermal|sublingual|buccal — 13 candidates stripped; promote to reference product]',
    `storage_temperature_requirement` STRING COMMENT 'Required storage temperature condition to maintain drug stability and efficacy. Room temperature (15-25°C), refrigerated (2-8°C), frozen (<0°C), or controlled room temperature (20-25°C).. Valid values are `room_temperature|refrigerated|frozen|controlled_room_temperature`',
    `strength` STRING COMMENT 'Concentration or potency of the active ingredient, including unit of measure (e.g., 10 mg, 500 mg/5 mL, 0.5%).',
    `therapeutic_class` STRING COMMENT 'Pharmacological or therapeutic category indicating the drugs primary clinical use (e.g., antihypertensive, antibiotic, analgesic, antidiabetic).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for inventory tracking and dispensing (e.g., each, tablet, capsule, mL, gram). [ENUM-REF-CANDIDATE: each|tablet|capsule|ml|gram|vial|bottle|box|tube|patch|inhaler — 11 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT '12-digit Universal Product Code barcode identifier used for point-of-sale scanning and inventory tracking of OTC pharmacy items.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_drug_item PRIMARY KEY(`drug_item_id`)
) COMMENT 'Pharmacy drug item master extending the core item record with pharmacy-specific attributes. Stores NDC (National Drug Code), drug name (brand and generic), active ingredient, strength, dosage form, route of administration, DEA schedule (I–V or non-scheduled), controlled substance flag, OTC vs Rx flag, therapeutic class, drug interaction group, storage temperature requirement, expiration tracking method, and McKesson drug database reference. Supports McKesson Pharmacy Systems drug inventory and prescription dispensing workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`fuel_grade` (
    `fuel_grade_id` BIGINT COMMENT 'Unique identifier for the fuel grade master record. Primary key for the fuel grade entity.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_grade. Business justification: Required for fuel pricing and EPA compliance reports that join product fuel grade definitions with master fuel grade data; grocery analysts expect this direct reference.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Fuel procurement contracts require linking each fuel grade to its supplying vendor for pricing, compliance, and inventory management.',
    `active_status` BOOLEAN COMMENT 'Indicates whether the fuel grade is currently available for sale at fuel centers. False for discontinued or seasonally unavailable grades.',
    `base_price_differential` DECIMAL(18,2) COMMENT 'Standard price increment above the base fuel grade (typically Regular Unleaded) in dollars per gallon. Used for automated pricing calculations and competitive positioning.',
    `biodiesel_blend_percentage` DECIMAL(18,2) COMMENT 'Percentage of biodiesel content in diesel fuel blends (e.g., 5.00 for B5, 20.00 for B20). Zero for non-diesel fuels. Required for EPA renewable fuel standard reporting.',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Lifecycle greenhouse gas emissions in grams of CO2 equivalent per megajoule of energy (gCO2e/MJ). Used for Low Carbon Fuel Standard (LCFS) compliance in California and other jurisdictions.',
    `cetane_number` STRING COMMENT 'Measure of diesel fuel ignition quality and combustion speed. Higher cetane numbers indicate better ignition properties. Typically 40-55 for diesel fuels. Null for gasoline products.',
    `cold_filter_plugging_point_fahrenheit` STRING COMMENT 'Lowest temperature in degrees Fahrenheit at which diesel fuel will flow through a standardized filtration device. Critical for winter operability. Applicable to diesel grades only.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel grade master record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when the fuel grade was discontinued or when the specification version was superseded. Null for currently active grades. Used for historical analysis and regulatory reporting.',
    `effective_start_date` DATE COMMENT 'Date when the fuel grade became available for sale or when the current specification version became effective. Used for historical tracking and seasonal blend transitions.',
    `epa_fuel_type_code` STRING COMMENT 'EPA-assigned code for fuel type classification used in emissions compliance reporting and fuel economy labeling. Maps to EPA fuel type taxonomy.. Valid values are `^[A-Z0-9]{1,5}$`',
    `ethanol_blend_percentage` DECIMAL(18,2) COMMENT 'Percentage of ethanol content in the fuel blend (e.g., 10.00 for E10, 85.00 for E85). Zero for pure gasoline or diesel. Required for EPA renewable fuel standard reporting.',
    `flash_point_fahrenheit` STRING COMMENT 'Minimum temperature in degrees Fahrenheit at which the fuel emits sufficient vapor to ignite. Critical for fire safety protocols and storage requirements.',
    `fuel_grade_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the fuel grade (e.g., REG, MID, PREM, DSL, E85). Used for system integration and pump configuration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `fuel_grade_name` STRING COMMENT 'Full descriptive name of the fuel grade (e.g., Regular Unleaded, Mid-Grade, Premium, Diesel, E85 Flex Fuel). Used for customer-facing displays and reporting.',
    `fuel_type` STRING COMMENT 'High-level classification of the fuel product type. Aligns with EPA fuel type taxonomy for emissions reporting and regulatory compliance.. Valid values are `gasoline|diesel|ethanol_blend|biodiesel|compressed_natural_gas|electric`',
    `gtin` STRING COMMENT '14-digit GS1 Global Trade Item Number uniquely identifying the fuel grade product for supply chain and inventory management. Used for cross-enterprise product identification.. Valid values are `^[0-9]{14}$`',
    `hazmat_class` STRING COMMENT 'Department of Transportation (DOT) hazardous materials classification for the fuel grade. Required for transportation, storage, and safety compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel grade master record was most recently updated. Used for change tracking and data quality monitoring.',
    `octane_rating` STRING COMMENT 'Octane number indicating the fuels resistance to knocking or pinging during combustion. Typically 87 for Regular, 89 for Mid-Grade, 91-93 for Premium. Null for diesel and non-gasoline fuels.',
    `price_tier` STRING COMMENT 'Numeric ranking of fuel grade pricing from lowest to highest (e.g., 1 for Regular, 2 for Mid-Grade, 3 for Premium). Used for pricing strategy and margin management.',
    `pump_button_color` STRING COMMENT 'Standard color coding for fuel grade selection buttons on dispensers (e.g., green for Regular, yellow for Mid-Grade, red for Premium, black for Diesel). Supports consistent customer experience across fuel centers.. Valid values are `red|yellow|green|blue|black|silver`',
    `pump_display_label` STRING COMMENT 'Customer-facing label text displayed on fuel pump dispensers and signage. Includes grade name, octane rating, and ethanol content per FTC labeling requirements.',
    `reformulated_gasoline_indicator` BOOLEAN COMMENT 'Flag indicating whether the fuel meets EPA reformulated gasoline (RFG) requirements for ozone non-attainment areas. True for RFG-compliant fuels sold in designated metropolitan areas.',
    `renewable_fuel_indicator` BOOLEAN COMMENT 'Flag indicating whether the fuel grade qualifies as a renewable fuel under EPA Renewable Fuel Standard (RFS). True for ethanol blends, biodiesel, and other renewable fuels.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of fuel density to water density at standard temperature. Used for volume-to-weight conversions in inventory reconciliation and delivery verification.',
    `sulfur_content_ppm` STRING COMMENT 'Sulfur concentration in parts per million. EPA regulations mandate ultra-low sulfur diesel (ULSD) at 15 ppm maximum. Required for emissions compliance reporting.',
    `summer_blend_indicator` BOOLEAN COMMENT 'Flag indicating whether the fuel grade is formulated for warm weather with lower Reid Vapor Pressure (RVP) to reduce evaporative emissions. Seasonal blend used from June through September.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transportation (e.g., UN1203 for gasoline, UN1202 for diesel). Required for shipping documentation and emergency response.. Valid values are `^UN[0-9]{4}$`',
    `upc` STRING COMMENT '12-digit Universal Product Code for the fuel grade. Used for Point of Sale (POS) transaction processing and inventory tracking at fuel centers.. Valid values are `^[0-9]{12}$`',
    `wholesale_product_code` STRING COMMENT 'Supplier or terminal product code used for wholesale fuel procurement and Electronic Data Interchange (EDI) transactions. Links to vendor catalog and supply chain systems.',
    `winter_blend_indicator` BOOLEAN COMMENT 'Flag indicating whether the fuel grade is formulated for cold weather performance with higher Reid Vapor Pressure (RVP). Seasonal blend used from November through March in most regions.',
    CONSTRAINT pk_fuel_grade PRIMARY KEY(`fuel_grade_id`)
) COMMENT 'Fuel grade master defining the types of fuel sold at Grocery fuel centers. Stores fuel grade code, fuel grade name (Regular Unleaded, Mid-Grade, Premium, Diesel, E85), octane rating, ethanol blend percentage, EPA fuel type classification, pump display label, price tier, and active status. Supports fuel center pump configuration, EPA emissions compliance reporting, and fuel pricing management. Referenced by fuel inventory and fuel pricing domains.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_substitution` (
    `item_substitution_id` BIGINT COMMENT 'Unique identifier for the item substitution relationship record.',
    `associate_id` BIGINT COMMENT 'User identifier of the category manager or merchandising manager who approved this substitution relationship.',
    `product_item_id` BIGINT COMMENT 'The original item that is out of stock or unavailable. References the item master catalog.',
    `allergen_match_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the substitute item must have the same allergen profile as the primary item. Critical for food safety and customer health. True enforces allergen matching; False allows different allergen profiles.',
    `approval_status` STRING COMMENT 'Current approval status of this substitution relationship in the governance workflow. Draft indicates initial creation; pending_review awaits category manager approval; approved is active; rejected was denied; suspended is temporarily inactive; expired has passed its effective end date.. Valid values are `draft|pending_review|approved|rejected|suspended|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this substitution relationship was approved by the authorized user.',
    `auto_substitute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this substitution can be applied automatically by the Order Management System (OMS) or Computer Assisted Ordering (CAO) system without manual intervention. True enables automatic substitution; False requires manual review.',
    `brand_match_preference` STRING COMMENT 'Indicates the brand matching requirement for substitution: exact (same brand only), private_label (store-owned brand preferred), national_brand (Consumer Packaged Goods brand preferred), or any (brand agnostic).. Valid values are `exact|private_label|national_brand|any`',
    `category_match_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the substitute item must belong to the same product category as the primary item. True enforces category matching; False allows cross-category substitution.',
    `channel_applicability` STRING COMMENT 'Indicates which fulfillment channels this substitution rule applies to: all channels, in-store only, online only, pickup (click-and-collect), delivery (last mile delivery), or curbside pickup.. Valid values are `all|in_store|online|pickup|delivery|curbside`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this substitution relationship record was first created in the system.',
    `customer_acceptance_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of times customers accepted this substitution when offered (accepted substitutions divided by total offers). Used to measure customer satisfaction and optimize substitution rules.',
    `customer_consent_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether explicit customer approval is required before making this substitution. True means the customer must approve the substitute before fulfillment; False means the substitution can be made automatically.',
    `dietary_restriction_match_flag` BOOLEAN COMMENT 'Boolean indicator of whether the substitute item must match dietary restrictions of the primary item (e.g., organic, gluten-free, kosher, halal, vegan). True enforces dietary attribute matching; False allows different dietary profiles.',
    `effective_end_date` DATE COMMENT 'The date when this substitution relationship expires and should no longer be used. Null indicates an open-ended relationship with no expiration.',
    `effective_start_date` DATE COMMENT 'The date when this substitution relationship becomes active and can be used for order fulfillment and replenishment decisions.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time when this substitution was most recently applied in an order fulfillment or replenishment transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this substitution relationship record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for category managers to document special instructions, business rationale, customer communication guidelines, or other relevant information about this substitution relationship.',
    `pharmacy_therapeutic_equivalent_flag` BOOLEAN COMMENT 'Boolean indicator specific to pharmacy items indicating whether the substitute drug is therapeutically equivalent to the primary drug per FDA Orange Book standards. True means the substitute has the same active ingredient, strength, dosage form, and route of administration.',
    `prescription_required_match_flag` BOOLEAN COMMENT 'Boolean indicator for pharmacy items indicating whether the substitute must have the same prescription requirement status as the primary item (both Rx or both OTC). True enforces matching; False allows substitution between prescription and over-the-counter items.',
    `price_variance_threshold_percent` DECIMAL(18,2) COMMENT 'Maximum acceptable percentage difference in price between the primary item and substitute item. Positive values allow higher-priced substitutes; negative values allow lower-priced substitutes. For example, 15.00 means the substitute can cost up to 15% more.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the order of preference when multiple substitutes exist for the same primary item. Lower numbers indicate higher priority (1 = first choice, 2 = second choice, etc.).',
    `size_match_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage variance in product size or quantity between the primary item and substitute item. For example, 10.00 means the substitute can be up to 10% larger or smaller than the original item.',
    `source_system_code` STRING COMMENT 'Identifies the originating system or process that created this substitution rule: merchandising system, eCommerce platform, Computer Assisted Ordering (CAO), manual entry by category manager, or category management tool.. Valid values are `merchandising|ecommerce|cao|manual|category_mgmt`',
    `substitution_reason_code` STRING COMMENT 'Code indicating the primary business reason for establishing this substitution relationship: out-of-stock (OOS), discontinued item, seasonal availability, product recall, quality issue, pricing strategy, or promotional campaign. [ENUM-REF-CANDIDATE: oos|discontinued|seasonal|recall|quality|pricing|promotion — 7 candidates stripped; promote to reference product]',
    `substitution_type` STRING COMMENT 'Classification of the substitution relationship indicating whether the substitute is an equivalent product, an upgrade (higher quality or price), a downgrade (lower quality or price), similar product, alternative brand, or generic equivalent.. Valid values are `equivalent|upgrade|downgrade|similar|alternative|generic`',
    `usage_count` STRING COMMENT 'Cumulative count of how many times this substitution has been applied in actual order fulfillment or replenishment transactions. Used for effectiveness tracking and optimization.',
    CONSTRAINT pk_item_substitution PRIMARY KEY(`item_substitution_id`)
) COMMENT 'Approved item substitution relationships defining which items can replace others during out-of-stock (OOS) scenarios in eCommerce order picking, CAO (Computer Assisted Ordering) replenishment, and in-store fulfillment. Stores primary item, substitute item, substitution type (equivalent/upgrade/downgrade), priority rank, channel applicability (in-store/online/pickup/delivery), customer consent required flag, size-match tolerance, brand-match preference, and effective date range. Critical for omnichannel order fulfillment SLA compliance and customer satisfaction. Sourced from category management and eCommerce fulfillment teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_vendor` (
    `item_vendor_id` BIGINT COMMENT 'Unique identifier for the item-vendor association record.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Procurement ownership of vendor contracts is assigned to an associate; needed for spend analysis and supplier performance dashboards.',
    `product_item_id` BIGINT COMMENT 'Reference to the item (SKU) in this vendor relationship.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier providing this item.',
    `contract_reference_number` STRING COMMENT 'Reference to the master supply agreement or contract governing this item-vendor relationship. Links to vendor contract management system.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the vendor cost (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where this item is manufactured or grown by this vendor. Required for customs, labeling, and country-of-origin marketing.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this item-vendor relationship record was first created in the system.',
    `dsd_indicator` BOOLEAN COMMENT 'Indicates whether this vendor delivers directly to stores, bypassing the distribution center. Common for bread, dairy, snacks, and beverages.',
    `edi_transaction_set_supported` STRING COMMENT 'Comma-separated list of EDI transaction sets supported by this vendor for this item (e.g., 850 Purchase Order, 856 Advance Ship Notice, 810 Invoice). Blank if vendor does not support EDI.',
    `effective_end_date` DATE COMMENT 'Date when this item-vendor relationship expires or is terminated. Null indicates an open-ended relationship.',
    `effective_start_date` DATE COMMENT 'Date when this item-vendor relationship becomes active and can be used for purchase order creation.',
    `item_vendor_status` STRING COMMENT 'Current lifecycle status of this item-vendor sourcing relationship. Blocked status prevents new purchase orders; discontinued indicates vendor no longer supplies this item.. Valid values are `active|inactive|pending|blocked|discontinued`',
    `last_cost_update_date` DATE COMMENT 'Date when the vendor cost was last updated in the system. Used for cost change tracking and margin analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this item-vendor relationship record was last updated. Used for change tracking and audit trails.',
    `last_purchase_order_date` DATE COMMENT 'Date of the most recent purchase order placed with this vendor for this item. Used for vendor activity analysis and relationship management.',
    `last_receipt_date` DATE COMMENT 'Date of the most recent goods receipt from this vendor for this item at any distribution center or store. Used for vendor performance tracking.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The smallest quantity that can be ordered from this vendor for this item, expressed in the vendors unit of measure.',
    `order_multiple` DECIMAL(18,2) COMMENT 'The quantity increment in which this item must be ordered (e.g., case pack size, pallet quantity). Orders must be in multiples of this value.',
    `primary_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the primary or preferred source for this item. Used in automated replenishment and purchase order generation.',
    `promotional_allowance_percent` DECIMAL(18,2) COMMENT 'Standard promotional discount percentage offered by this vendor for this item during promotional periods. Used in temporary price reduction (TPR) planning.',
    `return_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether a return merchandise authorization (RMA) is required from this vendor before returning defective or unsold items.',
    `slotting_fee_amount` DECIMAL(18,2) COMMENT 'One-time or recurring fee paid by the vendor for shelf space allocation for this item. Common in new item introductions and category resets.',
    `vendor_cost` DECIMAL(18,2) COMMENT 'The current negotiated cost per vendor unit of measure. Used for purchase order pricing and gross margin calculations. Subject to contract terms and promotional allowances.',
    `vendor_item_number` STRING COMMENT 'The vendors internal catalog or part number for this item, used in purchase orders and EDI transactions.',
    `vendor_lead_time_days` STRING COMMENT 'Number of days from purchase order submission to expected delivery at the distribution center or store. Critical for replenishment planning and safety stock calculations.',
    `vendor_pack_size` STRING COMMENT 'Number of consumer units (eaches) contained in the vendors shipping unit (case or pallet). Used for unit conversion between vendor ordering and store selling units.',
    `vendor_quality_certification` STRING COMMENT 'Quality certifications held by the vendor for this item (e.g., USDA Organic, Non-GMO Project, Fair Trade, HACCP, SQF). Pipe-separated list if multiple certifications apply.',
    `vendor_reliability_rating` STRING COMMENT 'Performance rating for this vendor on this item, based on fill rate, on-time delivery, and quality metrics. Used in vendor selection and category captain decisions.. Valid values are `excellent|good|fair|poor`',
    `vendor_unit_of_measure` STRING COMMENT 'The unit of measure used by the vendor for ordering and invoicing this item. [ENUM-REF-CANDIDATE: each|case|pallet|pound|kilogram|liter|gallon|dozen|box — 9 candidates stripped; promote to reference product]',
    `vendor_upc` STRING COMMENT 'The UPC or GTIN assigned by the vendor for this item, may differ from retailers UPC in case of private label or vendor-specific packaging.. Valid values are `^[0-9]{8,14}$`',
    CONSTRAINT pk_item_vendor PRIMARY KEY(`item_vendor_id`)
) COMMENT 'Association between items and their approved vendors/suppliers, capturing the sourcing relationship. Stores vendor reference, item reference, vendor item number, vendor UPC, primary vendor flag, vendor lead time days, minimum order quantity, order multiple, EDI transaction set supported, DSD indicator, and effective date range. Supports purchase order creation, replenishment planning, and vendor performance management. Sourced from SAP MM Purchasing Info Record and Oracle Retail.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`recall` (
    `recall_id` BIGINT COMMENT 'Unique identifier for the product recall record. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Recall process requires identifying the associate who initiated the recall; essential for incident investigation and regulatory reporting.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Recalls are tied to the specific product affected; FK provides direct association.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Recall management reports must identify the responsible supplier for regulatory notifications and corrective action tracking.',
    `affected_gtin` STRING COMMENT '14-digit GTIN of the affected product. Global standard identifier for supply chain and distribution tracking.. Valid values are `^[0-9]{14}$`',
    `affected_lot_numbers` STRING COMMENT 'Comma-separated list of affected lot or batch numbers. Used to identify specific production runs subject to recall.',
    `affected_product_description` STRING COMMENT 'Detailed description of the affected product including brand name, product name, package size, and any distinguishing characteristics to aid in identification.',
    `affected_states` STRING COMMENT 'Comma-separated list of US state codes where the recalled product was distributed. Used for targeted store notification and consumer alerts.',
    `affected_upc` STRING COMMENT '12-digit UPC barcode of the affected product. Used for POS system identification and automated inventory removal.. Valid values are `^[0-9]{12}$`',
    `classification` STRING COMMENT 'FDA recall classification indicating severity of health risk. Class I: life-threatening or serious injury risk. Class II: temporary or reversible adverse health consequences. Class III: unlikely to cause adverse health consequences.. Valid values are `Class I|Class II|Class III`',
    `closed_date` DATE COMMENT 'Date when the regulatory agency officially closed the recall case. Indicates successful completion of all regulatory requirements.',
    `completed_date` DATE COMMENT 'Date when all recall activities (store removal, consumer notification, disposition) were completed. Precedes regulatory closure.',
    `consumer_notification_date` DATE COMMENT 'Date when consumers were notified of the recall through public communication channels.',
    `consumer_notification_method` STRING COMMENT 'Method used to notify consumers of the recall. Multiple methods may be used; this field captures the primary notification channel. [ENUM-REF-CANDIDATE: Press Release|Email|SMS|In-Store Signage|Website|Social Media|Loyalty App — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was first created in the data platform. Audit trail field.',
    `disposition_instructions` STRING COMMENT 'Instructions for handling recalled product. Destroy: dispose of product. Return to Vendor: ship back to supplier. Hold for Inspection: quarantine pending agency review. Dispose per HACCP: follow food safety protocols.. Valid values are `Destroy|Return to Vendor|Hold for Inspection|Dispose per HACCP`',
    `distribution_scope` STRING COMMENT 'Geographic scope of product distribution. Indicates whether the recall affects national, regional, state-level, or local distribution.. Valid values are `National|Regional|State|Local`',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the recall including product cost, disposal costs, labor, and potential liability. Measured in USD. Business-confidential financial data.',
    `fda_enforcement_report_url` STRING COMMENT 'URL link to the official FDA enforcement report for this recall. Provides access to the public regulatory record.',
    `health_hazard_evaluation` STRING COMMENT 'FDA health hazard evaluation summary describing the potential health risk to consumers, including severity, likelihood of occurrence, and affected populations.',
    `initiated_date` DATE COMMENT 'Date the recall was officially initiated by the agency or manufacturer. Marks the start of the recall lifecycle.',
    `initiating_agency` STRING COMMENT 'Regulatory agency or entity that initiated the recall. FDA: food/drug/cosmetic. USDA: meat/poultry. CPSC: consumer product safety. DEA: controlled substances. Manufacturer: voluntary firm-initiated.. Valid values are `FDA|USDA|CPSC|DEA|Manufacturer`',
    `internal_case_number` STRING COMMENT 'Internal case tracking number assigned by the retailer for recall management and cross-functional coordination across supply chain, store operations, and legal teams.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was last modified in the data platform. Audit trail field.',
    `loyalty_matched_notification_flag` BOOLEAN COMMENT 'Indicates whether loyalty program purchase history was used to identify and directly notify customers who purchased the recalled product.',
    `manufacturer_contact_email` STRING COMMENT 'Email address of the manufacturer contact person. Business-confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `manufacturer_contact_name` STRING COMMENT 'Name of the manufacturer contact person responsible for coordinating the recall. Used for vendor communication and coordination.',
    `manufacturer_contact_phone` STRING COMMENT 'Phone number of the manufacturer contact person. Business-confidential organizational contact data.',
    `product_removed_date` DATE COMMENT 'Date when the recalled product was physically removed from store shelves and inventory. Marks completion of store-level recall execution.',
    `production_date_end` DATE COMMENT 'End date of the production date range for affected items. Defines the latest production date of recalled products.',
    `production_date_start` DATE COMMENT 'Start date of the production date range for affected items. Defines the earliest production date of recalled products.',
    `quantity_recalled` DECIMAL(18,2) COMMENT 'Total quantity of product units subject to recall. Measured in units appropriate to the product (cases, pounds, bottles, etc.).',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the quantity recalled field. Defines how the recalled quantity is measured.. Valid values are `Cases|Units|Pounds|Kilograms|Bottles|Packages`',
    `reason` STRING COMMENT 'Detailed explanation of the reason for the recall, including the specific defect, contamination, mislabeling, or health hazard that triggered the action.',
    `recall_number` STRING COMMENT 'Official recall number assigned by the initiating agency (FDA, USDA, CPSC, DEA, or manufacturer). Serves as the external business identifier for regulatory reporting and cross-agency coordination.. Valid values are `^[A-Z0-9-]+$`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall. Tracks progression from initiation through store notification, product removal, completion, and regulatory closure.. Valid values are `Initiated|In Progress|Store Notified|Product Removed|Completed|Closed`',
    `recall_type` STRING COMMENT 'Type of recall action. Voluntary: firm-initiated removal. Mandatory: agency-ordered removal. Market Withdrawal: removal of product not subject to FDA enforcement action.. Valid values are `Voluntary|Mandatory|Market Withdrawal`',
    `source_system` STRING COMMENT 'Name of the source system that originated this recall record (e.g., Oracle Retail, SAP, Manual Entry).',
    `source_system_code` STRING COMMENT 'Unique identifier of this recall record in the source system. Used for data lineage and reconciliation.',
    `store_notification_timestamp` TIMESTAMP COMMENT 'Timestamp when store operations were notified of the recall. Critical for tracking compliance with pull-from-shelf execution timelines.',
    CONSTRAINT pk_recall PRIMARY KEY(`recall_id`)
) COMMENT 'Product recall and market withdrawal record managing the end-to-end recall lifecycle per FDA 21 CFR Part 7 and USDA FSIS directives. Stores recall number (FDA/USDA/manufacturer-assigned), recall classification (Class I life-threatening / Class II reversible health risk / Class III no health risk), recall type (voluntary/mandatory/market withdrawal), initiating agency (FDA/USDA/CPSC/DEA), affected item references, affected lot/batch numbers, affected production date range, distribution scope, recall reason, health hazard evaluation summary, recall status (initiated/in-progress/store-notified/product-removed/completed/closed), store notification timestamp, consumer notification method, and disposition instructions (destroy/return-to-vendor/hold). Supports FDA recall compliance, store operations pull-from-shelf execution, customer notification for loyalty-matched purchases, and regulatory reporting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_regulatory_flag` (
    `item_regulatory_flag_id` BIGINT COMMENT 'Unique identifier for the item regulatory flag record. Primary key.',
    `product_item_id` BIGINT COMMENT 'Reference to the product item to which this regulatory flag applies.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes capturing audit trail information, compliance review findings, or historical changes to the regulatory flag status.',
    `certification_number` STRING COMMENT 'Unique certification or approval number issued by the certifying body for traceability and audit purposes.',
    `certifying_body` STRING COMMENT 'Name of the organization or government agency that issued the certification or approval (e.g., USDA, FDA, State Board of Pharmacy, third-party certifier).',
    `compliance_status` STRING COMMENT 'Current status of the regulatory compliance flag indicating whether the certification or approval is active, expired, suspended, pending, revoked, or under review.. Valid values are `active|expired|suspended|pending|revoked|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory flag record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `digital_channel_display_flag` BOOLEAN COMMENT 'Indicates whether this regulatory flag should be displayed in digital commerce channels (website, mobile app) for customer filtering and product discovery. True if displayable, False otherwise.',
    `disclosure_statement` STRING COMMENT 'Standardized text or statement required for regulatory disclosure on labels, receipts, or digital channels (e.g., Bioengineered Food, USDA Organic).',
    `effective_date` DATE COMMENT 'Date when the regulatory flag or certification becomes effective and can be used for compliance purposes at POS and in digital channels.',
    `expiration_date` DATE COMMENT 'Date when the regulatory flag or certification expires and is no longer valid for compliance purposes. Nullable for flags without expiration.',
    `flag_type` STRING COMMENT 'Type of regulatory compliance flag or certification. [ENUM-REF-CANDIDATE: snap_eligible|wic_approved|ebt_eligible|organic_certified|non_gmo|gluten_free_certified|kosher|halal|fair_trade|usda_grade|fda_bioengineered_disclosure|allergen_free — promote to reference product]. Valid values are `snap_eligible|wic_approved|ebt_eligible|organic_certified|non_gmo|gluten_free_certified`',
    `label_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this regulatory flag requires mandatory disclosure on product labels or packaging (e.g., FDA bioengineered food disclosure). True if disclosure required, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory flag record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or recertification audit to ensure ongoing regulatory adherence.',
    `pos_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this regulatory flag enables special transaction eligibility at POS systems (e.g., SNAP/EBT/WIC payment acceptance). True if eligible, False otherwise.',
    `regulatory_jurisdiction` STRING COMMENT 'Geographic or administrative jurisdiction where this regulatory flag applies (e.g., USA, California, European Union). Uses 3-letter country codes or state abbreviations.',
    `source_system` STRING COMMENT 'Name of the operational system of record that originated this regulatory flag data (e.g., Oracle Retail Merchandising System, SAP Retail MM).',
    `source_system_code` STRING COMMENT 'Unique identifier for this regulatory flag record in the source system, used for data lineage and reconciliation.',
    `supporting_documentation_url` STRING COMMENT 'URL or file path to supporting documentation, certificates, or audit reports that validate the regulatory flag or certification.',
    `verification_date` DATE COMMENT 'Date when the regulatory flag or certification was last verified or audited by the certifying body or internal compliance team.',
    CONSTRAINT pk_item_regulatory_flag PRIMARY KEY(`item_regulatory_flag_id`)
) COMMENT 'Regulatory compliance flags and certifications associated with items. Stores flag type (SNAP-eligible, WIC-approved, EBT-eligible, organic-certified, non-GMO, gluten-free-certified, kosher, halal, fair-trade, USDA-grade, FDA-bioengineered-disclosure), certifying body, certification number, effective date, expiration date, and compliance status. Supports EBT/SNAP/WIC transaction eligibility at POS, FDA bioengineered food disclosure compliance, and digital channel filtering.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_packaging` (
    `item_packaging_id` BIGINT COMMENT 'Unique identifier for the item packaging specification record. Primary key.',
    `product_item_id` BIGINT COMMENT 'Reference to the parent product item for which this packaging specification applies. Links to the authoritative product catalog.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or manufacturer who provides this packaged item. Used for vendor performance tracking and supply chain management.',
    `country_of_origin` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code indicating where the product was manufactured or produced. Required for customs declarations and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this packaging specification record was first created in the data platform. Used for audit trail and data lineage.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The refundable deposit amount charged for returnable containers such as bottles and cans, measured in USD. Applicable in states with bottle bill legislation. Null for non-deposit items.',
    `effective_end_date` DATE COMMENT 'The date when this packaging specification is no longer valid for use. Null indicates currently active with no planned end date. Supports time-variant packaging changes and historical tracking.',
    `effective_start_date` DATE COMMENT 'The date when this packaging specification becomes active and valid for use in the supply chain. Supports time-variant packaging changes and historical tracking.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the packaging level including product and all packaging materials, measured in pounds. Used for freight calculations and warehouse capacity planning.',
    `gtin` STRING COMMENT 'The GS1 Global Trade Item Number assigned to this specific packaging level. GTIN-8, GTIN-12 (UPC), GTIN-13 (EAN), or GTIN-14 (case/pallet) format. Used for scanning, EDI transactions, and supply chain traceability.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the packaging contains hazardous materials requiring special handling, labeling, and transportation compliance per DOT regulations.',
    `height_inches` DECIMAL(18,2) COMMENT 'The vertical dimension of the packaging unit measured in inches. Used for warehouse slotting, transportation planning, and planogram design.',
    `hi` STRING COMMENT 'The number of layers stacked vertically on a pallet in the Ti-Hi pallet configuration. Used for warehouse receiving, DC slotting, and transportation planning. Null for non-pallet packaging levels.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this packaging specification record was most recently updated in the data platform. Used for audit trail and change tracking.',
    `length_inches` DECIMAL(18,2) COMMENT 'The longest dimension of the packaging unit measured in inches. Used for warehouse slotting, transportation planning, and planogram design.',
    `max_stack_height` STRING COMMENT 'The maximum number of units that can be safely stacked vertically. Used for warehouse safety compliance and space planning. Null if not stackable.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the product contents only, excluding packaging materials, measured in pounds. Used for nutritional labeling and FDA compliance.',
    `packaging_level` STRING COMMENT 'The hierarchical level of packaging in the distribution chain. Each represents the consumer unit, inner pack is a sub-case grouping, case is the standard shipping unit, pallet is the warehouse unit, display shipper is a retail-ready merchandising unit, and master case is an outer shipping container.. Valid values are `each|inner_pack|case|pallet|display_shipper|master_case`',
    `packaging_material_type` STRING COMMENT 'The primary material composition of the packaging at this level. Used for sustainability reporting, recycling programs, and environmental compliance. [ENUM-REF-CANDIDATE: corrugated_cardboard|plastic|glass|metal|wood|composite|flexible_film — 7 candidates stripped; promote to reference product]',
    `packaging_status` STRING COMMENT 'Current lifecycle status of this packaging specification. Active indicates current use in supply chain, inactive indicates temporarily out of use, discontinued indicates permanently retired, pending approval indicates awaiting vendor or regulatory approval, seasonal indicates used only during specific periods.. Valid values are `active|inactive|discontinued|pending_approval|seasonal`',
    `recyclable_flag` BOOLEAN COMMENT 'Indicates whether the packaging material is recyclable through standard municipal recycling programs. Supports sustainability reporting and consumer labeling requirements.',
    `source_system` STRING COMMENT 'The name of the operational system of record from which this packaging specification was sourced (e.g., SAP MM, Oracle Retail, Manhattan WMS). Used for data lineage and troubleshooting.',
    `source_system_code` STRING COMMENT 'The unique identifier for this packaging record in the source operational system. Used for data reconciliation and traceability back to the system of record.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this packaging level can be safely stacked on top of identical units during storage and transportation. Used for warehouse space optimization and load planning.',
    `tariff_code` STRING COMMENT 'The Harmonized Tariff Schedule classification code for this packaged item. Used for customs clearance, duty calculation, and international trade compliance.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this packaging level requires temperature-controlled storage and transportation (cold chain). Applicable to perishables, frozen foods, and pharmacy items.',
    `ti` STRING COMMENT 'The number of cases per layer on a pallet in the Ti-Hi pallet configuration. Used for warehouse receiving, DC slotting, and transportation planning. Null for non-pallet packaging levels.',
    `unit_quantity` STRING COMMENT 'The number of base units (each) contained within this packaging level. For example, a case may contain 24 eaches, a pallet may contain 60 cases.',
    `upc` STRING COMMENT 'The 12-digit UPC barcode for this packaging level, primarily used at point-of-sale in North America. Subset of GTIN-12.. Valid values are `^[0-9]{12}$`',
    `vendor_item_number` STRING COMMENT 'The suppliers internal item identifier for this packaging configuration. Used for purchase orders, EDI transactions, and cross-reference with vendor catalogs.',
    `volume_cubic_feet` DECIMAL(18,2) COMMENT 'The total cubic volume of the packaging unit measured in cubic feet. Calculated from length, width, and height. Used for warehouse capacity planning and transportation optimization.',
    `width_inches` DECIMAL(18,2) COMMENT 'The width dimension of the packaging unit measured in inches. Used for warehouse slotting, transportation planning, and planogram design.',
    CONSTRAINT pk_item_packaging PRIMARY KEY(`item_packaging_id`)
) COMMENT 'Packaging specification record for each item defining the physical packaging hierarchy and dimensions. Stores packaging level (each/inner pack/case/pallet/display shipper), GTIN per level, unit quantity per level, gross weight, net weight, length, width, height, volume, packaging material type, recyclable flag, deposit amount (bottle deposit), and Ti-Hi (pallet configuration: tiers x height). Supports WMS receiving, DC slotting, transportation planning, and sustainability reporting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`ab_test_experiment` (
    `ab_test_experiment_id` BIGINT COMMENT 'Unique surrogate key for the A/B test experiment.',
    `associate_id` BIGINT COMMENT 'Identifier of the internal user who created the experiment.',
    `last_modified_by_user_associate_id` BIGINT COMMENT 'Identifier of the internal user who last modified the experiment.',
    `iterated_from_ab_test_experiment_id` BIGINT COMMENT 'Self-referencing FK on ab_test_experiment (iterated_from_ab_test_experiment_id)',
    `ab_test_experiment_status` STRING COMMENT 'Current lifecycle status of the experiment.. Valid values are `draft|running|paused|concluded`',
    `channel_scope` STRING COMMENT 'Comma‑separated list of sales channels (e.g., online, mobile, in‑store) included in the experiment.',
    `confidence_threshold` DECIMAL(18,2) COMMENT 'Minimum confidence level (percentage) required to declare a winner.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the experiment record was created.',
    `customer_segment_scope` STRING COMMENT 'Comma‑separated list of customer segment identifiers targeted by the experiment.',
    `end_date` DATE COMMENT 'Date when the experiment is scheduled to end.',
    `experiment_code` STRING COMMENT 'Unique business identifier or code for the experiment.',
    `experiment_name` STRING COMMENT 'Human‑readable name of the experiment.',
    `experiment_type` STRING COMMENT 'Indicates whether the experiment is a simple A/B test or a multivariate test.. Valid values are `ab|multivariate`',
    `hypothesis` STRING COMMENT 'Statement of the hypothesis being tested.',
    `is_statistically_significant` BOOLEAN COMMENT 'Indicates whether the result met the confidence threshold.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the experiment.',
    `product_scope` STRING COMMENT 'Comma‑separated list of product SKUs or categories targeted by the experiment.',
    `result_metric_confidence_interval` STRING COMMENT 'Confidence interval for the result metric value (e.g., 95% CI).',
    `result_metric_value` DECIMAL(18,2) COMMENT 'Observed value of the target metric for the winning variant.',
    `start_date` DATE COMMENT 'Date when the experiment is scheduled to start.',
    `statistical_test` STRING COMMENT 'Statistical test applied to determine significance of results.. Valid values are `t_test|chi_square|bayesian|z_test`',
    `storefront_scope` STRING COMMENT 'Comma‑separated list of storefront identifiers where the experiment is applied.',
    `target_metric` STRING COMMENT 'Primary metric used to evaluate experiment performance.. Valid values are `conversion_rate|average_order_value|click_through_rate|revenue_per_visit`',
    `target_metric_goal` DECIMAL(18,2) COMMENT 'Goal value for the target metric (e.g., 0.05 for a 5% conversion lift).',
    `traffic_allocation` STRING COMMENT 'JSON string mapping variant identifiers to traffic allocation percentages.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the experiment record.',
    `variant_count` STRING COMMENT 'Number of variants defined in the experiment, including the control.',
    `variant_definitions` STRING COMMENT 'JSON string describing each variants configuration (e.g., UI changes, pricing adjustments).',
    `version_number` STRING COMMENT 'Version number of the experiment definition, incremented on each change.',
    `winner_determined_timestamp` TIMESTAMP COMMENT 'Timestamp when the winning variant was identified.',
    `winning_variant_code` BIGINT COMMENT 'Identifier of the variant determined as the winner after experiment conclusion.',
    CONSTRAINT pk_ab_test_experiment PRIMARY KEY(`ab_test_experiment_id`)
) COMMENT 'Master record for A/B and multivariate test experiments run on digital storefronts. Captures experiment name, hypothesis, variant definitions, traffic allocation percentages, target metric (conversion rate, AOV, click-through), start/end dates, storefront scope, status (draft, running, paused, concluded), and winning variant determination. Supports data-driven optimization of the digital shopping experience including recommendation algorithms, search ranking, checkout flows, and promotional placements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_channel` (
    `order_channel_id` BIGINT COMMENT 'Unique surrogate key for each order origination channel. _canonical_skip_reason: Entity is a reference lookup for channel classification.',
    `parent_order_channel_id` BIGINT COMMENT 'Self-referencing FK on order_channel (parent_order_channel_id)',
    `allowed_payment_methods` STRING COMMENT 'List of payment methods accepted for this channel. [ENUM-REF-CANDIDATE: credit_card|debit_card|gift_card|mobile_wallet|cash|check|ebt|snap|wic|paypal|apple_pay|google_pay — promote to reference product]',
    `channel_code` STRING COMMENT 'Short alphanumeric code used internally to identify the channel (e.g., POS, WEB, MOB).',
    `channel_name` STRING COMMENT 'Human‑readable name of the order channel (e.g., In‑Store POS, Web Store, Mobile App).',
    `channel_type` STRING COMMENT 'Broad classification of the channel based on interaction mode.. Valid values are `in_store|online|mobile|phone|marketplace|kiosk`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for monetary limits on the channel.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the channel was retired or disabled (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the channel became operational.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the channel is currently enabled for order capture.',
    `is_third_party` BOOLEAN COMMENT 'Indicates whether the channel is operated by an external marketplace partner.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the channel record.',
    `max_order_value` DECIMAL(18,2) COMMENT 'Maximum monetary value allowed for a single order on this channel.',
    `min_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required for an order to be accepted via this channel.',
    `order_channel_description` STRING COMMENT 'Detailed description of the channels purpose, capabilities, and typical use cases.',
    `requires_age_verification` BOOLEAN COMMENT 'True if the channel must verify customer age for restricted items.',
    `requires_prescription` BOOLEAN COMMENT 'True if the channel can process pharmacy prescription orders.',
    `routing_rule_code` BIGINT COMMENT 'Identifier of the routing rule set that governs order flow for this channel.',
    `source_system` STRING COMMENT 'Name of the operational system of record that defines this channel (e.g., Salesforce Commerce Cloud, Oracle Retail).',
    `supported_fulfillment_methods` STRING COMMENT 'Comma‑separated list of fulfillment methods the channel can route to.. Valid values are `delivery|pickup|in_store|curbside|digital|pharmacy`',
    CONSTRAINT pk_order_channel PRIMARY KEY(`order_channel_id`)
) COMMENT 'Reference classification of order origination channels (in-store POS, web, mobile app, kiosk, phone, third-party marketplace) with channel-specific configuration and routing rules.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_hold` (
    `order_hold_id` BIGINT COMMENT 'System-generated unique identifier for the order hold record.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate responsible for handling the hold.',
    `order_header_id` BIGINT COMMENT 'Identifier of the order to which this hold is applied.',
    `primary_order_associate_id` BIGINT COMMENT 'Identifier of the user who performed the fraud review.',
    `product_order_line_id` BIGINT COMMENT 'Identifier of the order line that is subject to the hold.',
    `superseded_order_hold_id` BIGINT COMMENT 'Self-referencing FK on order_hold (superseded_order_hold_id)',
    `hold_age_verification_required_flag` BOOLEAN COMMENT 'Indicates if the hold is due to an age‑restricted item.',
    `hold_age_verified_flag` BOOLEAN COMMENT 'True when age verification has been successfully completed.',
    `hold_age_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when age verification was completed.',
    `hold_amount` DECIMAL(18,2) COMMENT 'Monetary amount placed on hold (e.g., pending payment amount).',
    `hold_applied_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold was initially placed on the order.',
    `hold_channel_type` STRING COMMENT 'Channel through which the order was placed that generated the hold.. Valid values are `online|in_store|mobile|call_center`',
    `hold_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `hold_currency` STRING COMMENT 'Three‑letter ISO currency code for the hold amount.',
    `hold_expiration_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold is scheduled to expire if not released.',
    `hold_expiry_reason_code` STRING COMMENT 'Code indicating why the hold expired without release.',
    `hold_expiry_reason_description` STRING COMMENT 'Free‑text description of the expiry reason.',
    `hold_fraud_review_status` STRING COMMENT 'Current status of the manual fraud review process.. Valid values are `pending|reviewed|cleared|rejected`',
    `hold_fraud_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud review decision was recorded.',
    `hold_fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by the fraud engine for this hold.',
    `hold_inventory_check_timestamp` TIMESTAMP COMMENT 'Timestamp when inventory confirmation was performed.',
    `hold_inventory_confirmed_flag` BOOLEAN COMMENT 'True if inventory availability has been confirmed for the held items.',
    `hold_last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the hold record.',
    `hold_notes` STRING COMMENT 'Free‑form notes entered by staff regarding the hold.',
    `hold_notification_channel` STRING COMMENT 'Channel used to notify the customer about the hold.. Valid values are `email|sms|push|none`',
    `hold_notification_sent_flag` BOOLEAN COMMENT 'True if a notification about the hold was sent to the customer.',
    `hold_number` STRING COMMENT 'External reference number for the hold, used in communications and reporting.',
    `hold_payment_verification_timestamp` TIMESTAMP COMMENT 'Timestamp when payment verification was completed.',
    `hold_payment_verified_flag` BOOLEAN COMMENT 'True when payment verification (e.g., card auth) has succeeded.',
    `hold_priority` STRING COMMENT 'Business priority assigned to the hold for processing urgency.. Valid values are `low|medium|high|critical`',
    `hold_reason_code` STRING COMMENT 'Standardized code representing the specific reason for the hold.',
    `hold_reason_description` STRING COMMENT 'Free‑text description of why the hold was applied.',
    `hold_related_quantity` STRING COMMENT 'Quantity of the related SKU involved in the hold.',
    `hold_related_sku` STRING COMMENT 'SKU of the product that triggered the hold, if applicable.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold was manually or automatically released.',
    `hold_sla_met_flag` BOOLEAN COMMENT 'Indicates whether the hold met its SLA target.',
    `hold_sla_target_minutes` STRING COMMENT 'Target time in minutes for the hold to be resolved.',
    `hold_sla_variance_minutes` STRING COMMENT 'Difference in minutes between actual resolution time and SLA target (positive = over, negative = under).',
    `hold_source_system` STRING COMMENT 'Originating system that created the hold (e.g., SAP Retail, Oracle Retail).',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold.. Valid values are `pending|released|cancelled|escalated|expired`',
    `hold_type` STRING COMMENT 'Category of the hold reason, such as fraud review, payment verification, age‑restricted item validation, inventory confirmation, or other.. Valid values are `fraud|payment|age_verification|inventory|other`',
    CONSTRAINT pk_order_hold PRIMARY KEY(`order_hold_id`)
) COMMENT 'Records order holds applied for fraud review, payment verification, age-restricted item validation, or inventory confirmation before fulfillment release.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`gs1_sync` (
    `gs1_sync_id` BIGINT COMMENT 'System-generated unique identifier for each GS1 data synchronization record.',
    `product_item_id` BIGINT COMMENT 'Identifier of the product item being synchronized.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external trading partner (vendor or supplier) involved in the synchronization.',
    `prior_gs1_sync_id` BIGINT COMMENT 'Self-referencing FK on gs1_sync (prior_gs1_sync_id)',
    `batch_number` STRING COMMENT 'Identifier for a batch of synchronization messages sent together.',
    `compliance_flag` STRING COMMENT 'Indicates whether the synchronized item meets applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending_review`',
    `correlation_ref` STRING COMMENT 'Identifier used to correlate related synchronization messages across systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the synchronization record was first created in the lakehouse.',
    `data_format` STRING COMMENT 'Serialization format of the synchronization payload.. Valid values are `XML|JSON`',
    `effective_end_date` DATE COMMENT 'Date when the synchronized data ceases to be effective (nullable for open‑ended records).',
    `effective_start_date` DATE COMMENT 'Date when the synchronized data becomes effective for downstream systems.',
    `error_code` STRING COMMENT 'Standardized code representing any error encountered during synchronization.',
    `error_description` STRING COMMENT 'Human‑readable description of the error associated with the synchronization attempt.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter ISO country code representing the jurisdiction of the regulatory requirement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the synchronization record.',
    `message_ref` STRING COMMENT 'Globally unique identifier for the synchronization message.',
    `payload_type` STRING COMMENT 'Category of data contained in the payload (e.g., product_data, pricing_data).',
    `payload_version` STRING COMMENT 'Version of the data payload format used in the synchronization message.',
    `record_status` STRING COMMENT 'Lifecycle status of the synchronization record within the data pool.. Valid values are `active|inactive|archived`',
    `regulatory_agency` STRING COMMENT 'Governing body responsible for the compliance aspect (e.g., FDA, USDA, DEA).',
    `retry_count` STRING COMMENT 'Number of retry attempts made after a failed synchronization.',
    `source_system` STRING COMMENT 'Name of the internal system that originated the synchronization message (e.g., SAP Retail, Oracle Retail).',
    `sync_action` STRING COMMENT 'Type of synchronization operation performed on the item data.. Valid values are `publish|subscribe|update|delete`',
    `sync_status` STRING COMMENT 'Current processing status of the synchronization record.. Valid values are `pending|in_progress|success|failed`',
    `sync_timestamp` TIMESTAMP COMMENT 'Exact date and time when the synchronization event occurred.',
    `target_system` STRING COMMENT 'Name of the external system or data pool that receives the synchronization message.',
    CONSTRAINT pk_gs1_sync PRIMARY KEY(`gs1_sync_id`)
) COMMENT 'GS1 Global Data Synchronization Network (GDSN) data pool synchronization records tracking item data publication, subscription, and synchronization status between Grocery and CPG trading partners per GS1 standards.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`product_assortment` (
    `product_assortment_id` BIGINT COMMENT 'Primary key for the assortment association',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product_item',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store_location',
    `effective_end_date` DATE COMMENT 'Date when the product is removed from the store',
    `effective_start_date` DATE COMMENT 'Date when the product becomes available at the store',
    CONSTRAINT pk_product_assortment PRIMARY KEY(`product_assortment_id`)
) COMMENT 'This association product represents the assortment relationship between product_item and store_location. It captures the period a product is available at a specific store.. Existence Justification: Each product_item can be stocked at many store_location records, and each store_location carries many product_item records. The business actively manages the assortment of items per store, tracking when a product becomes available and when it is removed using effective start and end dates.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`promo_sku_assignment` (
    `promo_sku_assignment_id` BIGINT COMMENT 'Primary key for the promo_sku_assignment association',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotional offer',
    `sku_id` BIGINT COMMENT 'Foreign key linking to SKU',
    `discount_override_amount` DECIMAL(18,2) COMMENT 'Specific monetary discount applied to this SKU within the offer',
    `discount_override_percentage` DECIMAL(18,2) COMMENT 'Specific percentage discount applied to this SKU within the offer',
    `facing_count` STRING COMMENT 'Number of facings allocated to the SKU for the promotion',
    `maximum_quantity` STRING COMMENT 'Maximum quantity of the SKU eligible for the offer',
    `planogram_placement_code` STRING COMMENT 'Code indicating shelf placement rules for the SKU under this offer',
    `priority_rank` STRING COMMENT 'Order in which the SKU is considered when multiple offers compete',
    `required_quantity` STRING COMMENT 'Minimum quantity of the SKU that must be purchased for the offer to apply',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether a substitute SKU may be used if the primary SKU is out of stock',
    CONSTRAINT pk_promo_sku_assignment PRIMARY KEY(`promo_sku_assignment_id`)
) COMMENT 'This association product represents the assignment of promotional offers to SKUs. It captures per‑SKU offer terms such as quantity limits, discount overrides, and placement priorities, enabling the business to manage and query which items participate in each promotion.. Existence Justification: In Grocery, marketing teams actively create and maintain a list of which SKUs are eligible for each promotional offer, and a single SKU can participate in multiple offers over time. Conversely, each promotional offer can include many SKUs. The association carries its own attributes such as required quantity and discount overrides, making it an operational entity.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`inventory_allocation` (
    `inventory_allocation_id` BIGINT COMMENT 'Primary key for the inventory_allocation association',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to the storage location',
    `available_quantity` BIGINT COMMENT 'Units available for allocation (on_hand - reserved)',
    `expiration_date` DATE COMMENT 'Expiration date of the SKU batch at the location',
    `lot_number` STRING COMMENT 'Lot or batch identifier for traceability',
    `on_hand_quantity` BIGINT COMMENT 'Current on‑hand units of the SKU at the location',
    `reserved_quantity` BIGINT COMMENT 'Units reserved for pending orders at the location',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Recorded temperature of the location for the SKU',
    CONSTRAINT pk_inventory_allocation PRIMARY KEY(`inventory_allocation_id`)
) COMMENT 'Represents the placement of a SKU in a specific storage location, capturing quantities, lot, expiration, and temperature information that belong to the SKU‑location relationship.. Existence Justification: A SKU can be stocked in many physical storage locations across stores and distribution centers, and each storage location can hold many different SKUs. The business actively manages this placement, tracking on‑hand, reserved, and available quantities, lot numbers, expiration dates, and temperature per SKU‑location pair.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`product_order_line2` (
    `product_order_line2_id` BIGINT COMMENT 'Unique identifier for the digital order line item. Primary key for this entity.',
    `category_id` BIGINT COMMENT 'Reference to the product category hierarchy node for this item, enabling category-level sales analysis and assortment planning.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header that contains this line item. Links this line to the overall order transaction.',
    `associate_id` BIGINT COMMENT 'Reference to the store associate or picker who selected and prepared this line item for fulfillment. Used for performance tracking and quality accountability.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: order_line must reference the product_item it represents; adds child-to-parent relationship',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotion or promotional campaign applied to this line item, enabling tracking of promotional effectiveness and discount attribution.',
    `store_location_id` BIGINT COMMENT 'Reference to the store, distribution center, or micro-fulfillment center from which this line item was picked and fulfilled.',
    `age_restricted_flag` BOOLEAN COMMENT 'Indicates whether this product has age restrictions requiring customer age verification at the time of delivery or pickup, such as alcohol or tobacco products.',
    `bogo_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item was part of a buy-one-get-one promotional offer.',
    `coupon_code` STRING COMMENT 'The specific coupon code applied to this line item for discount purposes. Used for tracking coupon redemption and promotional campaign performance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this order line record was first created in the order management system, representing when the customer added this item to their digital cart and confirmed the order.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which this line item is priced and billed.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The retail department or category code to which this product belongs, used for merchandising analytics, inventory management, and financial reporting.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of discounts applied to this line item, including promotional discounts, coupons, temporary price reductions, and loyalty rewards.',
    `extended_price` DECIMAL(18,2) COMMENT 'The total price for this line item calculated as quantity multiplied by unit price, before discounts and taxes. Represents the gross line amount.',
    `gtin` STRING COMMENT 'Global Trade Item Number that uniquely identifies the product internationally. Can be 8, 12, 13, or 14 digits depending on product type and packaging level.. Valid values are `^[0-9]{8,14}$`',
    `line_number` STRING COMMENT 'Sequential line number within the order, used for ordering and display purposes. Determines the sequence in which items appear on the order.',
    `line_status` STRING COMMENT 'Current fulfillment status of this individual line item within the order lifecycle. Tracks the line from order confirmation through final delivery or cancellation. [ENUM-REF-CANDIDATE: pending|confirmed|picking|picked|packed|shipped|delivered|cancelled|refunded — 9 candidates stripped; promote to reference product]',
    `net_amount` DECIMAL(18,2) COMMENT 'The final net amount for this line item after applying all discounts and adding taxes. This is the amount the customer pays for this specific line.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether this product is certified organic according to USDA organic standards. Important for customer preference tracking and regulatory compliance.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether this product is perishable and requires special handling, temperature control, or expedited fulfillment to maintain quality and food safety.',
    `picked_timestamp` TIMESTAMP COMMENT 'The date and time when this line item was physically picked from inventory by the fulfillment associate. Critical for fulfillment SLA tracking and operational efficiency analysis.',
    `picker_notes` STRING COMMENT 'Free-text notes entered by the store associate or picker regarding this line item, such as product condition, substitution rationale, or special handling instructions.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this product is a store-owned private label brand rather than a national or regional consumer packaged goods brand.',
    `product_name` STRING COMMENT 'Human-readable name or description of the product as displayed to the customer during order placement and in order confirmation communications.',
    `quantity_confirmed` DECIMAL(18,2) COMMENT 'The actual quantity of the item that was confirmed for fulfillment after inventory validation. May differ from quantity ordered due to stock availability or picking accuracy.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of the item that the customer originally requested in their order. This is the initial order quantity before any substitutions or out-of-stock adjustments.',
    `sku` STRING COMMENT 'Internal stock keeping unit code that uniquely identifies the product within the retailers inventory system. Primary product identifier for internal operations.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this product is eligible for purchase using SNAP benefits (formerly food stamps). Critical for government assistance program compliance.',
    `substituted_product_name` STRING COMMENT 'The name of the substitute product provided to the customer. Used for customer communication and order accuracy tracking.',
    `substituted_sku` STRING COMMENT 'The SKU of the substitute product that was provided when the original item was unavailable. Null if no substitution occurred.',
    `substitution_reason_code` STRING COMMENT 'Standardized code indicating why a substitution was made, such as out-of-stock, product discontinued, or quality concerns.. Valid values are `out_of_stock|discontinued|damaged|expired|quality_issue|customer_request`',
    `substitution_status` STRING COMMENT 'Indicates whether this line represents the original item ordered, a substituted item, an out-of-stock item, or a substitution that the customer declined.. Valid values are `original|substituted|out_of_stock|customer_declined`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total sales tax amount calculated and applied to this line item based on the product tax code and delivery location tax jurisdiction.',
    `temperature_zone` STRING COMMENT 'The required storage and handling temperature zone for this product: ambient (room temperature), refrigerated (cold chain), or frozen. Critical for cold chain compliance and food safety.. Valid values are `ambient|refrigerated|frozen`',
    `tpr_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item was sold at a temporary promotional price reduction at the time of order placement.',
    `unit_of_measure` STRING COMMENT 'The unit in which the product quantity is measured, such as each, pound, kilogram, gallon, or liter. Critical for accurate pricing and inventory management. [ENUM-REF-CANDIDATE: each|lb|oz|kg|g|gal|qt|pt|l|ml|dozen|case — 12 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per single unit of the product at the time of order placement, before any line-level discounts or promotions are applied.',
    `upc` STRING COMMENT '12-digit Universal Product Code barcode identifier used for point-of-sale scanning and product identification across retail systems.. Valid values are `^[0-9]{12}$`',
    `weight_actual` DECIMAL(18,2) COMMENT 'The actual weight of the item picked and fulfilled, particularly important for variable-weight items like produce, meat, and deli products sold by weight.',
    `weight_unit` STRING COMMENT 'The unit of measure for the actual weight field, such as pounds, ounces, kilograms, or grams.. Valid values are `lb|oz|kg|g`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this product is eligible for purchase using WIC program benefits. Required for WIC program compliance and reporting.',
    CONSTRAINT pk_product_order_line2 PRIMARY KEY(`product_order_line2_id`)
) COMMENT 'This association product represents the line items linking product_item and order_header. It captures quantity, unit price, discount, tax, net amount, and line status for each product in an order.. Existence Justification: An order can contain many product items and a single product item can appear in many orders. Each occurrence is recorded as an order line that stores quantity, pricing, discounts, tax, net amount, and line status. Business users create, update, and delete these order lines as part of the order fulfillment process.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`pick_assignment` (
    `pick_assignment_id` BIGINT COMMENT 'Primary key for the pick_assignment association',
    `associate_id` BIGINT COMMENT 'Identifier of the associate responsible for the pick',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU',
    `wave_id` BIGINT COMMENT 'Foreign key linking to the Wave',
    `actual_quantity` BIGINT COMMENT 'Quantity actually picked for the SKU in the wave',
    `priority_level` STRING COMMENT 'Priority assigned to the pick within the wave',
    `target_quantity` BIGINT COMMENT 'Planned quantity of the SKU to be picked in the wave',
    `task_status` STRING COMMENT 'Current status of the pick task (e.g., planned, in‑progress, completed)',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantities (e.g., each, case)',
    CONSTRAINT pk_pick_assignment PRIMARY KEY(`pick_assignment_id`)
) COMMENT 'Represents the assignment of a SKU to a picking wave in the fulfillment process, capturing quantities, status, and responsible associate for each allocation.. Existence Justification: In Grocery fulfillment, a SKU can be allocated to many picking waves over time, and each wave contains many SKUs. The allocation is managed through pick‑assignment records that capture quantities, status, and responsible associate, and these records are created, updated, and deleted by operations staff.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`line_item` (
    `line_item_id` BIGINT COMMENT 'Primary key for the line_item association',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to the payment transaction containing the line',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to the product_item being sold',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to this line item',
    `quantity` BIGINT COMMENT 'Number of units of the product sold in this line',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for this line item',
    `total_price` DECIMAL(18,2) COMMENT 'Final total price for this line after discounts and taxes',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the product at the time of sale',
    CONSTRAINT pk_line_item PRIMARY KEY(`line_item_id`)
) COMMENT 'Represents the association between a product_item and a payment_transaction. Each record captures the quantity of the product sold, the unit price, discounts, taxes and total price for that line in the transaction.. Existence Justification: Each payment transaction can include multiple product items, and each product item can be sold in many different payment transactions over time. The link between them is captured as a line‑item record that stores quantity, price and discount information, which is created, updated, and deleted by the sales and inventory processes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_order_channel_id` FOREIGN KEY (`order_channel_id`) REFERENCES `grocery_ecm`.`product`.`order_channel`(`order_channel_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_drug_item_id` FOREIGN KEY (`drug_item_id`) REFERENCES `grocery_ecm`.`product`.`drug_item`(`drug_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_fuel_grade_id` FOREIGN KEY (`fuel_grade_id`) REFERENCES `grocery_ecm`.`product`.`fuel_grade`(`fuel_grade_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `grocery_ecm`.`product`.`cart`(`cart_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`product`.`catalog` ADD CONSTRAINT `fk_product_catalog_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `grocery_ecm`.`product`.`storefront`(`storefront_id`);
ALTER TABLE `grocery_ecm`.`product`.`web_session` ADD CONSTRAINT `fk_product_web_session_ab_test_experiment_id` FOREIGN KEY (`ab_test_experiment_id`) REFERENCES `grocery_ecm`.`product`.`ab_test_experiment`(`ab_test_experiment_id`);
ALTER TABLE `grocery_ecm`.`product`.`web_session` ADD CONSTRAINT `fk_product_web_session_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`cart` ADD CONSTRAINT `fk_product_cart_merged_from_cart_id` FOREIGN KEY (`merged_from_cart_id`) REFERENCES `grocery_ecm`.`product`.`cart`(`cart_id`);
ALTER TABLE `grocery_ecm`.`product`.`cart` ADD CONSTRAINT `fk_product_cart_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ADD CONSTRAINT `fk_product_cart_item_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `grocery_ecm`.`product`.`cart`(`cart_id`);
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ADD CONSTRAINT `fk_product_cart_item_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ADD CONSTRAINT `fk_product_checkout_session_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `grocery_ecm`.`product`.`cart`(`cart_id`);
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ADD CONSTRAINT `fk_product_checkout_session_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ADD CONSTRAINT `fk_product_slot_reservation_fulfillment_slot_id` FOREIGN KEY (`fulfillment_slot_id`) REFERENCES `grocery_ecm`.`product`.`fulfillment_slot`(`fulfillment_slot_id`);
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ADD CONSTRAINT `fk_product_slot_reservation_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ADD CONSTRAINT `fk_product_slot_reservation_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ADD CONSTRAINT `fk_product_payment_event_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ADD CONSTRAINT `fk_product_payment_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `grocery_ecm`.`product`.`storefront`(`storefront_id`);
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ADD CONSTRAINT `fk_product_payment_event_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`search_query` ADD CONSTRAINT `fk_product_search_query_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `grocery_ecm`.`product`.`storefront`(`storefront_id`);
ALTER TABLE `grocery_ecm`.`product`.`search_query` ADD CONSTRAINT `fk_product_search_query_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ADD CONSTRAINT `fk_product_product_recommendation_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ADD CONSTRAINT `fk_product_product_recommendation_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `grocery_ecm`.`product`.`storefront`(`storefront_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ADD CONSTRAINT `fk_product_product_recommendation_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ADD CONSTRAINT `fk_product_order_status_event_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ADD CONSTRAINT `fk_product_order_status_event_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ADD CONSTRAINT `fk_product_channel_config_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `grocery_ecm`.`product`.`catalog`(`catalog_id`);
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ADD CONSTRAINT `fk_product_channel_config_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `grocery_ecm`.`product`.`storefront`(`storefront_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_fuel_grade_id` FOREIGN KEY (`fuel_grade_id`) REFERENCES `grocery_ecm`.`product`.`fuel_grade`(`fuel_grade_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_plu_code_id` FOREIGN KEY (`plu_code_id`) REFERENCES `grocery_ecm`.`product`.`plu_code`(`plu_code_id`);
ALTER TABLE `grocery_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_parent_node_item_hierarchy_id` FOREIGN KEY (`parent_node_item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ADD CONSTRAINT `fk_product_upc_barcode_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ADD CONSTRAINT `fk_product_item_attribute_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ADD CONSTRAINT `fk_product_nutritional_info_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ADD CONSTRAINT `fk_product_allergen_declaration_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`private_label` ADD CONSTRAINT `fk_product_private_label_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ADD CONSTRAINT `fk_product_item_lifecycle_event_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ADD CONSTRAINT `fk_product_drug_item_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ADD CONSTRAINT `fk_product_item_substitution_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`recall` ADD CONSTRAINT `fk_product_recall_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ADD CONSTRAINT `fk_product_item_regulatory_flag_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ADD CONSTRAINT `fk_product_item_packaging_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ADD CONSTRAINT `fk_product_ab_test_experiment_iterated_from_ab_test_experiment_id` FOREIGN KEY (`iterated_from_ab_test_experiment_id`) REFERENCES `grocery_ecm`.`product`.`ab_test_experiment`(`ab_test_experiment_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ADD CONSTRAINT `fk_product_order_channel_parent_order_channel_id` FOREIGN KEY (`parent_order_channel_id`) REFERENCES `grocery_ecm`.`product`.`order_channel`(`order_channel_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ADD CONSTRAINT `fk_product_order_hold_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ADD CONSTRAINT `fk_product_order_hold_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ADD CONSTRAINT `fk_product_order_hold_superseded_order_hold_id` FOREIGN KEY (`superseded_order_hold_id`) REFERENCES `grocery_ecm`.`product`.`order_hold`(`order_hold_id`);
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ADD CONSTRAINT `fk_product_gs1_sync_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ADD CONSTRAINT `fk_product_gs1_sync_prior_gs1_sync_id` FOREIGN KEY (`prior_gs1_sync_id`) REFERENCES `grocery_ecm`.`product`.`gs1_sync`(`gs1_sync_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` ADD CONSTRAINT `fk_product_product_assortment_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ADD CONSTRAINT `fk_product_promo_sku_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ADD CONSTRAINT `fk_product_inventory_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ADD CONSTRAINT `fk_product_product_order_line2_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ADD CONSTRAINT `fk_product_product_order_line2_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ADD CONSTRAINT `fk_product_pick_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `grocery_ecm`.`product`.`order_header` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_header` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier Associate ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `fiscal_week_fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `order_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Order Channel Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `age_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `bag_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Bag Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `basket_item_count` SET TAGS ('dbx_business_glossary_term' = 'Basket Item Count');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|out_of_stock|payment_failure|fraud_hold|store_closure|system_error');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `change_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Due Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `delivery_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `delivery_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `delivery_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `ebt_snap_wic_used` SET TAGS ('dbx_business_glossary_term' = 'EBT/SNAP/WIC Tender Used Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `loyalty_card_scanned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Scanned Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `oms_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Order Reference');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `pharmacy_rx_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Prescription (Rx) Order Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register Number (POS Lane)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `self_checkout` SET TAGS ('dbx_business_glossary_term' = 'Self-Checkout Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ncr_pos|salesforce_commerce_cloud|mckesson_pharmacy');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `tender_summary` SET TAGS ('dbx_business_glossary_term' = 'Tender Summary');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'sale|return|void|no_sale|exchange');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `age_restricted_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Sale Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `drug_item_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Po Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `price_change_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `age_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Item Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `bogo_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy One Get One (BOGO) Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `extended_price` SET TAGS ('dbx_business_glossary_term' = 'Extended Price');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'in_store|delivery|curbside_pickup|click_and_collect|ship_to_home');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Item Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `plu` SET TAGS ('dbx_business_glossary_term' = 'Price Look-Up Code (PLU)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `plu` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `promo_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Applied Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `return_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `scan_method` SET TAGS ('dbx_business_glossary_term' = 'Scan Method');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `scan_method` SET TAGS ('dbx_value_regex' = 'handheld_scanner|belt_scanner|self_checkout|manual_entry|mobile_app|scale');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `tpr_flag` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction (TPR) Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `void_flag` SET TAGS ('dbx_business_glossary_term' = 'Void Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `weight_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'lb|kg|oz|g');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `order_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Actor Identifier');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Status Dwell Time (Minutes)');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `estimated_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'in_store|curbside_pickup|home_delivery|ship_to_home|pharmacy_pickup|locker_pickup');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transition Notes');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `source_system_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `triggering_system` SET TAGS ('dbx_business_glossary_term' = 'Triggering System');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `contact_info_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Info Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `fulfillment_delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `contactless_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Contactless Delivery Flag');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Number');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_value_regex' = '^DO-[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_type` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|scheduled|curbside|contactless');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance Miles');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `proof_of_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Method');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `proof_of_delivery_method` SET TAGS ('dbx_value_regex' = 'signature|photo|pin|none');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `proof_of_delivery_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Reference');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `reattempt_count` SET TAGS ('dbx_business_glossary_term' = 'Reattempt Count');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `scheduled_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Window End Time');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `scheduled_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Window Start Time');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z_]{2,20}$');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `stop_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence Number');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `pickup_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Appointment ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Associate ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'curbside|in_store|locker');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `arrival_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Notification Sent Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|order_cancelled|no_show|system_error|inventory_unavailable|other');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `customer_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Arrival Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `customer_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Rating');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `dispensing_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Completion Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `dispensing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Start Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `order_ready_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Ready Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `parking_spot_number` SET TAGS ('dbx_business_glossary_term' = 'Parking Spot Number');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `pickup_bay_number` SET TAGS ('dbx_business_glossary_term' = 'Pickup Bay Number');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `ready_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ready Notification Sent Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `reminder_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reminder Notification Sent Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Pickup Date');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target in Minutes');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `slot_capacity_used` SET TAGS ('dbx_business_glossary_term' = 'Slot Capacity Used');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_business_glossary_term' = 'Substitution Preference');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_value_regex' = 'accept_substitutions|contact_first|no_substitutions');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|mixed');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `total_bag_count` SET TAGS ('dbx_business_glossary_term' = 'Total Bag Count');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `vehicle_description` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Description');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `vehicle_license_plate` SET TAGS ('dbx_business_glossary_term' = 'Vehicle License Plate Number');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `vehicle_license_plate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Wait Time in Minutes');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `order_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Wave ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Cart ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Picker ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `actual_fulfillment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Fulfillment Minutes');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `dispatched_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatched Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fulfillment_location_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location Type');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fulfillment_location_type` SET TAGS ('dbx_value_regex' = 'store|mfc|dc|pharmacy');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'curbside_pickup|in_store_pickup|home_delivery|locker_pickup');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fulfillment_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Number');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `oos_line_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Line Count');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `pack_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Complete Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `pick_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Complete Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `picker_notes` SET TAGS ('dbx_business_glossary_term' = 'Picker Notes');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `quality_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `staged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Staged Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `staging_area` SET TAGS ('dbx_business_glossary_term' = 'Staging Area');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `substitution_count` SET TAGS ('dbx_business_glossary_term' = 'Substitution Count');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `total_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Lines');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `total_lines_picked` SET TAGS ('dbx_business_glossary_term' = 'Total Lines Picked');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `total_units_picked` SET TAGS ('dbx_business_glossary_term' = 'Total Units Picked');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `total_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Liters');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kilograms (kg)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `wms_task_reference` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Task Reference');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `order_discount_id` SET TAGS ('dbx_business_glossary_term' = 'Order Discount ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|curbside_pickup|delivery|pharmacy');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_scope` SET TAGS ('dbx_business_glossary_term' = 'Discount Scope');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_scope` SET TAGS ('dbx_value_regex' = 'order_header|order_line|category|sku|basket');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_status` SET TAGS ('dbx_business_glossary_term' = 'Discount Status');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_status` SET TAGS ('dbx_value_regex' = 'applied|reversed|pending|expired|invalid');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'vendor|store|manufacturer|loyalty_program|corporate');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `max_discount_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Allowed');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `min_purchase_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Required');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `promo_stack_sequence` SET TAGS ('dbx_business_glossary_term' = 'Promotion Stack Sequence');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `promotion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `quantity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Threshold');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax|tax_exempt');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'WIC (Women Infants and Children) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `order_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Payment Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service (AVS) Response Code');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_last_four_digits` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `change_given_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Given Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Response Code');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `ebt_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Balance Remaining');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `ebt_balance_remaining` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `ebt_balance_remaining` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `fuel_reward_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Reward Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `fuel_reward_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Fuel Reward Points Redeemed');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `gift_card_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Balance Remaining');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Number');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_business_glossary_term' = 'Mobile Wallet Type');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_value_regex' = 'apple_pay|google_pay|samsung_pay|other');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|mobile_app|kiosk|phone|curbside_terminal');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `payment_gateway` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `payment_processor_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Reference Number');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `payment_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Sequence Number');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Status');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `snap_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Tender Type');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `tokenized_payment_instrument` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Payment Instrument');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `tokenized_payment_instrument` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `tokenized_payment_instrument` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `wic_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `wic_voucher_number` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Voucher Number');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `wic_voucher_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `wic_voucher_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `order_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Order Refund ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Associate ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `primary_order_payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Customer ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `exception_approval_level` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Level');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `exception_approval_level` SET TAGS ('dbx_value_regex' = 'associate|supervisor|store_manager|district_manager|corporate');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `inventory_disposition` SET TAGS ('dbx_business_glossary_term' = 'Inventory Disposition');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `inventory_disposition` SET TAGS ('dbx_value_regex' = 'restock|damage_out|donate|dispose|vendor_return');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Is Fraudulent Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `loyalty_points_reversed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Reversed');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `original_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Method');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `policy_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Exception Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_channel` SET TAGS ('dbx_business_glossary_term' = 'Refund Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_channel` SET TAGS ('dbx_value_regex' = 'pos|online|mobile_app|customer_service|pharmacy|curbside');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_denied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Denied Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_tender|store_credit|gift_card|cash|check|ebt');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_value_regex' = '^RFN[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Requested Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'requested|approved|processed|denied|cancelled|reversed');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_subtotal` SET TAGS ('dbx_business_glossary_term' = 'Refund Subtotal');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'full|partial|line_level');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `shrink_flag` SET TAGS ('dbx_business_glossary_term' = 'Shrink Flag');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `rx_order_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Prescription (Rx) Order ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `pharmacy_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `controlled_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'Schedule_II|Schedule_III|Schedule_IV|Schedule_V|Non_Controlled');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'pickup|curbside|home_delivery|mail_order');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `dispensed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispensed Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `dispensing_fee` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `drug_form` SET TAGS ('dbx_business_glossary_term' = 'Drug Form');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `drug_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Name');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `drug_ndc_code` SET TAGS ('dbx_business_glossary_term' = 'Drug National Drug Code (NDC)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `drug_ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `drug_strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_number` SET TAGS ('dbx_business_glossary_term' = 'Fill Number');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_status` SET TAGS ('dbx_business_glossary_term' = 'Fill Status');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fill Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_type` SET TAGS ('dbx_business_glossary_term' = 'Fill Type');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_type` SET TAGS ('dbx_value_regex' = 'new|refill|transfer_in|transfer_out|partial_fill');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_bin_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Bank Identification Number (BIN)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_bin_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_bin_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_group_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Group Number');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_group_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Paid Amount');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_pcn` SET TAGS ('dbx_business_glossary_term' = 'Insurance Processor Control Number (PCN)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_pcn` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `mckesson_rx_system_ref` SET TAGS ('dbx_business_glossary_term' = 'McKesson Pharmacy System Rx ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `original_drug_ndc_code` SET TAGS ('dbx_business_glossary_term' = 'Original Drug National Drug Code (NDC)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `original_drug_ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescriber_name` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Name');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescriber_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_expiration_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_number` SET TAGS ('dbx_business_glossary_term' = 'Prescription Number');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7,15}$');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prescription Received Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_received_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_received_timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Written Date');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `refills_remaining` SET TAGS ('dbx_business_glossary_term' = 'Refills Remaining');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `sig_code` SET TAGS ('dbx_business_glossary_term' = 'Sig Code (Prescription Directions)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `substitution_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Occurred Flag');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Price');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `order_substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Order Substitution ID');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Picker Associate ID');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `brand_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Match Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `category_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Match Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Status');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_value_regex' = 'ACCEPTED|REJECTED|PENDING|AUTO_ACCEPTED|NOT_REQUIRED');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Comments');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_notification_method` SET TAGS ('dbx_value_regex' = 'APP|SMS|EMAIL|PHONE|NONE');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `inventory_snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inventory Snapshot Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Substitution Notes');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `original_gtin` SET TAGS ('dbx_business_glossary_term' = 'Original Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `original_gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `original_item_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Original Item Stock Level');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `original_product_name` SET TAGS ('dbx_business_glossary_term' = 'Original Product Name');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `original_quantity` SET TAGS ('dbx_business_glossary_term' = 'Original Quantity');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `original_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `price_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Difference Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `price_protection_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Applied Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `refund_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Issued Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `size_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Size Match Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_gtin` SET TAGS ('dbx_business_glossary_term' = 'Substitute Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_item_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Substitute Item Stock Level');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_product_name` SET TAGS ('dbx_business_glossary_term' = 'Substitute Product Name');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_quantity` SET TAGS ('dbx_business_glossary_term' = 'Substitute Quantity');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_sku` SET TAGS ('dbx_business_glossary_term' = 'Substitute Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Substitute Unit Price');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Approval Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_number` SET TAGS ('dbx_business_glossary_term' = 'Substitution Number');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Substitution Quality Score');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_reason_code` SET TAGS ('dbx_value_regex' = 'OOS|DAMAGED|RECALLED|EXPIRED|QUALITY|DISCONTINUED');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Description');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Substitution Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'AUTO_SYSTEM|PICKER_SELECTED|CUSTOMER_PREAPPROVED|CUSTOMER_REQUESTED');
ALTER TABLE `grocery_ecm`.`product`.`storefront` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`storefront` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `accepted_tender_types` SET TAGS ('dbx_business_glossary_term' = 'Accepted Tender Types');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `age_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'web|mobile_app|kiosk|tablet|voice_assistant|smart_tv');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `ebt_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `fulfillment_methods_supported` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Methods Supported');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `guest_checkout_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Checkout Allowed Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `loyalty_program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `loyalty_program_integrated_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Integrated Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `maximum_cart_item_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cart Item Count');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `minimum_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `personalization_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `promotion_engine_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Engine Enabled Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `search_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Search Enabled Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `sla_target_delivery_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Hours');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `sla_target_order_processing_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Order Processing Minutes');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `storefront_code` SET TAGS ('dbx_business_glossary_term' = 'Storefront Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `storefront_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `storefront_name` SET TAGS ('dbx_business_glossary_term' = 'Storefront Name');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `storefront_status` SET TAGS ('dbx_business_glossary_term' = 'Storefront Status');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `storefront_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_launch|sunset|maintenance');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `theme_code` SET TAGS ('dbx_business_glossary_term' = 'Theme Code');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Storefront Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`storefront` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`catalog` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Identifier');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Category Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `age_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `allergen_warnings` SET TAGS ('dbx_business_glossary_term' = 'Allergen Warnings');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `catalog_name` SET TAGS ('dbx_business_glossary_term' = 'Catalog Display Name');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `catalog_status` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Status');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `catalog_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|seasonal');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `category_path` SET TAGS ('dbx_business_glossary_term' = 'Category Navigation Path');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `channel_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Exclusion Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `display_price` SET TAGS ('dbx_business_glossary_term' = 'Display Price');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `excluded_channels` SET TAGS ('dbx_business_glossary_term' = 'Excluded Channels');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured Product Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten Free Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `hero_image_url` SET TAGS ('dbx_business_glossary_term' = 'Hero Image Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `hero_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Long Product Description');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `merchandising_rank` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rank');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `minimum_age_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Required');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `new_arrival_flag` SET TAGS ('dbx_business_glossary_term' = 'New Arrival Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `nutritional_callouts` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Callouts');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `online_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Availability Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Item Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `search_boost_score` SET TAGS ('dbx_business_glossary_term' = 'Search Boost Score');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Keywords');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Product Description');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `thumbnail_image_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `thumbnail_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`catalog` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Program Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`web_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`web_session` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Web Session ID');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `ab_test_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Experiment ID');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `add_to_cart_count` SET TAGS ('dbx_business_glossary_term' = 'Add to Cart Count');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `authentication_status` SET TAGS ('dbx_business_glossary_term' = 'Authentication Status');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `authentication_status` SET TAGS ('dbx_value_regex' = 'authenticated|guest|anonymous');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `browser_name` SET TAGS ('dbx_business_glossary_term' = 'Browser Name');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `browser_version` SET TAGS ('dbx_business_glossary_term' = 'Browser Version');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `cart_abandonment_flag` SET TAGS ('dbx_business_glossary_term' = 'Cart Abandonment Flag');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|smart_tv|wearable|other');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `entry_source` SET TAGS ('dbx_business_glossary_term' = 'Entry Source');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `entry_source_category` SET TAGS ('dbx_business_glossary_term' = 'Entry Source Category');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `exit_page_url` SET TAGS ('dbx_business_glossary_term' = 'Exit Page Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Geolocation City');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Code');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Postal Code');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_state` SET TAGS ('dbx_business_glossary_term' = 'Geolocation State');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `geolocation_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `loyalty_app_session_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty App Session Flag');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `operating_system_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Version');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `pages_viewed_count` SET TAGS ('dbx_business_glossary_term' = 'Pages Viewed Count');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `personalization_segment` SET TAGS ('dbx_business_glossary_term' = 'Personalization Segment');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `product_detail_views_count` SET TAGS ('dbx_business_glossary_term' = 'Product Detail Page (PDP) Views Count');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `referring_url` SET TAGS ('dbx_business_glossary_term' = 'Referring Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `search_query_count` SET TAGS ('dbx_business_glossary_term' = 'Search Query Count');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Seconds');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Session Number');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_outcome` SET TAGS ('dbx_business_glossary_term' = 'Session Outcome');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_outcome` SET TAGS ('dbx_value_regex' = 'converted|abandoned|bounced|browsing');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'active|completed|abandoned|expired|bounced');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Campaign');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Content');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Medium');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Source');
ALTER TABLE `grocery_ecm`.`product`.`web_session` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Term');
ALTER TABLE `grocery_ecm`.`product`.`cart` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`cart` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `merged_from_cart_id` SET TAGS ('dbx_business_glossary_term' = 'Merged From Cart Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `abandonment_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `abandonment_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Notification Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `cart_number` SET TAGS ('dbx_business_glossary_term' = 'Cart Number');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_business_glossary_term' = 'Cart Status');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_value_regex' = 'active|checked_out|abandoned|expired|merged|saved');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `cart_type` SET TAGS ('dbx_business_glossary_term' = 'Cart Type');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `cart_type` SET TAGS ('dbx_value_regex' = 'standard|wishlist|subscription|quick_reorder');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_state` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `delivery_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile_web|mobile_app|tablet|kiosk');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `estimated_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `estimated_subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Subtotal Amount');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `estimated_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Expiration Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'delivery|curbside_pickup|in_store_pickup|ship_to_home');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `promo_codes_applied` SET TAGS ('dbx_business_glossary_term' = 'Promotion Codes Applied');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `scheduled_fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Fulfillment Date');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `scheduled_fulfillment_window_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Fulfillment Window End Time');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `scheduled_fulfillment_window_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Fulfillment Window Start Time');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_business_glossary_term' = 'Substitution Preference');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_value_regex' = 'allow_all|allow_similar|contact_me|no_substitutions');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `grocery_ecm`.`product`.`cart` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `cart_item_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Item Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Shopping Cart Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `added_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Item Added Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `age_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `bogo_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy One Get One (BOGO) Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,6}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `coupon_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|smart_tv|voice_device');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `estimated_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Estimated Weight in Pounds (lbs)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `extended_price` SET TAGS ('dbx_business_glossary_term' = 'Extended Price');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `item_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Item Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Cart Item Status');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'active|removed|saved_for_later|out_of_stock|substituted');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Cart Line Number');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `net_item_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Item Amount');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `plu` SET TAGS ('dbx_business_glossary_term' = 'Price Look-Up Code (PLU)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `plu` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `preferred_substitute_sku` SET TAGS ('dbx_business_glossary_term' = 'Preferred Substitute Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `preferred_substitute_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,14}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `recommendation_source` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Source');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `recommendation_source` SET TAGS ('dbx_value_regex' = 'manual|personalized_rec|frequently_bought|trending|search|category_browse');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `removed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Item Removed Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,14}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|kiosk|call_center|voice_assistant');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_business_glossary_term' = 'Substitution Preference');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_value_regex' = 'allow|deny|contact_me|specific_only');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `tpr_flag` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction (TPR) Flag');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Program Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `checkout_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Session ID');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart ID');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Selected Store ID');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `abandoned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Abandoned Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `abandonment_step` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Step');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `abandonment_step` SET TAGS ('dbx_value_regex' = 'address|fulfillment|payment|review');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'web|mobile_app|kiosk|call_center');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Completed Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `coupon_codes_applied` SET TAGS ('dbx_business_glossary_term' = 'Coupon Codes Applied');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `delivery_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `ebt_snap_flag` SET TAGS ('dbx_business_glossary_term' = 'EBT (Electronic Benefits Transfer) SNAP (Supplemental Nutrition Assistance Program) Flag');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `expired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Expired Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'delivery|pickup|curbside');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Initiated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Number');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `oms_order_reference` SET TAGS ('dbx_business_glossary_term' = 'OMS (Order Management System) Order Reference');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `payment_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `payment_authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `payment_method_selected` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Selected');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `payment_processor_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Reference');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `promo_codes_applied` SET TAGS ('dbx_business_glossary_term' = 'Promotion Codes Applied');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `selected_fulfillment_slot_end` SET TAGS ('dbx_business_glossary_term' = 'Selected Fulfillment Slot End Time');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `selected_fulfillment_slot_start` SET TAGS ('dbx_business_glossary_term' = 'Selected Fulfillment Slot Start Time');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Seconds');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Checkout Session Number');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Checkout Session Status');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|abandoned|failed|expired');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `snap_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Eligible Amount');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `step_address_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Address Step Completed Flag');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `step_address_completed_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `step_address_completed_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `step_fulfillment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Step Completed Flag');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `step_payment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Step Completed Flag');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `step_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Review Step Completed Flag');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_business_glossary_term' = 'Substitution Preference');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `substitution_preference` SET TAGS ('dbx_value_regex' = 'allow|contact_me|no_substitutions');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ALTER COLUMN `wic_flag` SET TAGS ('dbx_business_glossary_term' = 'WIC (Women Infants and Children) Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`product_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `age_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'customer_request|out_of_stock|payment_failed|address_issue|fraud_suspected|system_error');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `channel_source` SET TAGS ('dbx_business_glossary_term' = 'Channel Source');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `channel_source` SET TAGS ('dbx_value_regex' = 'web|mobile_app|kiosk|voice|chatbot|third_party_marketplace');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `contactless_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Contactless Delivery Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `customer_feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Comments');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `customer_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Rating');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `delivery_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'click_and_collect|curbside_pickup|last_mile_delivery|ship_to_home|locker_pickup');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Number');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `oms_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Order Reference');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|ebt|gift_card|digital_wallet|buy_now_pay_later');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|captured|failed|refunded|partially_refunded');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `prescription_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Included Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `prescription_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `prescription_included_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `promised_fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Fulfillment Date');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `promised_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Promised Window End Time');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `promised_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Promised Window Start Time');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `snap_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `grocery_ecm`.`product`.`product_order` ALTER COLUMN `wic_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Amount');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `fulfillment_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Slot ID');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Override By User ID');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `available_capacity` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `booked_count` SET TAGS ('dbx_business_glossary_term' = 'Booked Count');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `capacity_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Override Flag');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|in_store_kiosk');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `cutoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `delivery_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Code');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'pickup|curbside|delivery|pharmacy');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `holiday_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Flag');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'standard|loyalty_member|premium|employee');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `reserved_count` SET TAGS ('dbx_business_glossary_term' = 'Reserved Count');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|next_day|scheduled');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Closed Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Date');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration Minutes');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_end_time` SET TAGS ('dbx_business_glossary_term' = 'Slot End Time');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slot Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_notes` SET TAGS ('dbx_business_glossary_term' = 'Slot Notes');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_number` SET TAGS ('dbx_business_glossary_term' = 'Slot Number');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Published Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_start_time` SET TAGS ('dbx_business_glossary_term' = 'Slot Start Time');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'open|full|closed|cancelled|suspended|reserved');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `surge_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Surge Pricing Flag');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `total_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `slot_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Reservation Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `fulfillment_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Slot Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `capacity_units_reserved` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Reserved');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|in_store_kiosk');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'pickup|delivery|curbside');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `hold_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Hold Duration Seconds');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `holiday_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Flag');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|vip');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `release_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Release Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `release_reason_code` SET TAGS ('dbx_value_regex' = 'customer_cancel|payment_fail|timeout|system_error|inventory_conflict|duplicate');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `release_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Release Reason Description');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'held|confirmed|released|expired|cancelled');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `reservation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|next_day');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `slot_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Date');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `slot_end_time` SET TAGS ('dbx_business_glossary_term' = 'Slot End Time');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `slot_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slot Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `slot_start_time` SET TAGS ('dbx_business_glossary_term' = 'Slot Start Time');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ALTER COLUMN `surge_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Surge Pricing Flag');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `payment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Event Identifier');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Response Code');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Response Code');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `ebt_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'EBT Balance Remaining');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `gift_card_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Balance Remaining');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `merchant_account_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|mobile_web|kiosk|call_center');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `payment_gateway` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `payment_token_ref` SET TAGS ('dbx_business_glossary_term' = 'Payment Token ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `processor_response_code` SET TAGS ('dbx_business_glossary_term' = 'Processor Response Code');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `processor_response_message` SET TAGS ('dbx_business_glossary_term' = 'Processor Response Message');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `processor_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Processor Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `retry_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Retry Attempt Number');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|reversed');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `snap_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'SNAP Eligible Amount');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `tender_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|ebt|snap|wic|gift_card');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `three_d_secure_flag` SET TAGS ('dbx_business_glossary_term' = '3D Secure Flag');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `three_d_secure_version` SET TAGS ('dbx_business_glossary_term' = '3D Secure Version');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|declined|failed|voided|settled');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'authorization|capture|void|refund|partial_refund|reversal');
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ALTER COLUMN `wic_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'WIC Eligible Amount');
ALTER TABLE `grocery_ecm`.`product`.`search_query` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`search_query` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_query_id` SET TAGS ('dbx_business_glossary_term' = 'Search Query ID');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `added_to_cart_flag` SET TAGS ('dbx_business_glossary_term' = 'Added to Cart Flag');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `autocomplete_suggestion` SET TAGS ('dbx_business_glossary_term' = 'Autocomplete Suggestion');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `autocomplete_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Autocomplete Used Flag');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `clicked_position` SET TAGS ('dbx_business_glossary_term' = 'Clicked Position');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `clicked_sku` SET TAGS ('dbx_business_glossary_term' = 'Clicked Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|tablet|smartphone|kiosk|other');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `filter_brand_applied` SET TAGS ('dbx_business_glossary_term' = 'Filter Brand Applied');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `filter_category_applied` SET TAGS ('dbx_business_glossary_term' = 'Filter Category Applied');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `filter_dietary_applied` SET TAGS ('dbx_business_glossary_term' = 'Filter Dietary Applied');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `filter_price_max` SET TAGS ('dbx_business_glossary_term' = 'Filter Price Maximum');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `filter_price_min` SET TAGS ('dbx_business_glossary_term' = 'Filter Price Minimum');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `normalized_query_string` SET TAGS ('dbx_business_glossary_term' = 'Normalized Query String');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `personalization_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Applied Flag');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `query_refined_flag` SET TAGS ('dbx_business_glossary_term' = 'Query Refined Flag');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `query_string` SET TAGS ('dbx_business_glossary_term' = 'Query String');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `refined_query_string` SET TAGS ('dbx_business_glossary_term' = 'Refined Query String');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `result_clicked_flag` SET TAGS ('dbx_business_glossary_term' = 'Result Clicked Flag');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `result_count` SET TAGS ('dbx_business_glossary_term' = 'Result Count');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_channel` SET TAGS ('dbx_business_glossary_term' = 'Search Channel');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|mobile_web|kiosk');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Version');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_method` SET TAGS ('dbx_business_glossary_term' = 'Search Method');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_method` SET TAGS ('dbx_value_regex' = 'text_input|voice_search|barcode_scan|image_search|autocomplete_selection');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Search Response Time Milliseconds');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `search_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Search Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`search_query` ALTER COLUMN `zero_results_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Results Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `product_recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recommendation ID');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Campaign ID');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `add_to_cart_flag` SET TAGS ('dbx_business_glossary_term' = 'Add to Cart Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `add_to_cart_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Add to Cart Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `algorithm` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Algorithm');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|email|push_notification');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `click_flag` SET TAGS ('dbx_business_glossary_term' = 'Click Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `context` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Context');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `context` SET TAGS ('dbx_value_regex' = 'homepage|product_detail_page|cart|checkout|search_results|category_page');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `control_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Group Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|app');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `display_position` SET TAGS ('dbx_business_glossary_term' = 'Display Position');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `display_price` SET TAGS ('dbx_business_glossary_term' = 'Display Price');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Expiration Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `impression_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Impression Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `promotion_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Applied Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommendation_number` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Number');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommendation_source` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Source');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommendation_source` SET TAGS ('dbx_value_regex' = 'personalization_engine|manual_merchandising|promotional_campaign|editorial_curation');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Status');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_value_regex' = 'presented|clicked|added_to_cart|purchased|dismissed|expired');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Type');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_value_regex' = 'collaborative_filtering|content_based|hybrid|trending|frequently_bought_together|personalized');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommended_product_name` SET TAGS ('dbx_business_glossary_term' = 'Recommended Product Name');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `recommended_sku` SET TAGS ('dbx_business_glossary_term' = 'Recommended Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Score');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `time_on_page_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time on Page Seconds');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `order_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status Event Identifier');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Actor ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time Minutes');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `estimated_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'pickup|delivery|ship_to_home');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|mfc|dc|carrier_hub');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'push|sms|email|none');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `sla_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Variance Minutes');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `source_system_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `triggered_by` SET TAGS ('dbx_business_glossary_term' = 'Triggered By');
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ALTER COLUMN `triggered_by` SET TAGS ('dbx_value_regex' = 'system|associate|shopper|carrier');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_config_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Config Identifier');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog ID');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book ID');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront ID');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `accepted_tender_types` SET TAGS ('dbx_business_glossary_term' = 'Accepted Tender Types');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `age_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_config_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|deprecated|pilot|sunset');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'web|mobile_app|kiosk|api|voice');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `ebt_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `feature_toggles` SET TAGS ('dbx_business_glossary_term' = 'Feature Toggles');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `fulfillment_methods_supported` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Methods Supported');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `guest_checkout_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Checkout Allowed Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Launch Date');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `loyalty_program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `loyalty_program_integrated_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Integrated Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `maximum_cart_item_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cart Item Count');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `minimum_age_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Required');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `minimum_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `personalization_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'ios|android|web_desktop|web_mobile|windows|linux');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `promotion_engine_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Engine Enabled Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `search_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Search Enabled Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `sla_target_delivery_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Hours');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `sla_target_order_processing_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Order Processing Minutes');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Sunset Date');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`product_item` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item ID');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `plu_code_id` SET TAGS ('dbx_business_glossary_term' = 'Plu Code Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `age_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `fda_labeling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Labeling Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Classification');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height Inches');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `ingredient_statement` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Statement');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|seasonal|pending|inactive|obsolete');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `item_type` SET TAGS ('dbx_value_regex' = 'grocery|produce|pharmacy|fuel|bakery|deli');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `length_inches` SET TAGS ('dbx_business_glossary_term' = 'Length Inches');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `plu_code` SET TAGS ('dbx_business_glossary_term' = 'Price Look-Up (PLU) Code');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `plu_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `suggested_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Suggested Retail Price (SRP)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `temperature_class` SET TAGS ('dbx_business_glossary_term' = 'Temperature Class');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `temperature_class` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `usda_grade` SET TAGS ('dbx_business_glossary_term' = 'USDA (United States Department of Agriculture) Grade');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight Pounds');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'WIC (Women Infants and Children Program) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `width_inches` SET TAGS ('dbx_business_glossary_term' = 'Width Inches');
ALTER TABLE `grocery_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Created By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `alcohol_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Product Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `catch_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `check_digit` SET TAGS ('dbx_business_glossary_term' = 'Barcode Check Digit');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `check_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{1}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `ean_code` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `ean_code` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `fda_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_business_glossary_term' = 'GS1 Company Prefix');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `inner_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inner Pack Quantity');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `plu_code` SET TAGS ('dbx_business_glossary_term' = 'Price Look-Up (PLU) Code');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `plu_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `primary_barcode_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Barcode Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `retailer_item_number` SET TAGS ('dbx_business_glossary_term' = 'Retailer Item Number');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `retailer_item_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `selling_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Selling Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `size_grade` SET TAGS ('dbx_business_glossary_term' = 'Size Grade');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Status');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|DISCONTINUED|PENDING|SEASONAL');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'AMBIENT|REFRIGERATED|FROZEN|CONTROLLED');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `tobacco_flag` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Product Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `variable_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Variable Weight Flag');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `variety` SET TAGS ('dbx_business_glossary_term' = 'Product Variety');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Program Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy ID');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Owner Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `parent_node_item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node ID');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `age_restriction_years` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Years');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `average_unit_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Retail Price');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `dsd_category_flag` SET TAGS ('dbx_business_glossary_term' = 'DSD (Direct Store Delivery) Category Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `endcap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Endcap (End-of-Aisle Display) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `fda_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Regulated Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `gmroi_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Target Percentage');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level Number');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `hierarchy_level_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level Name');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `hierarchy_level_name` SET TAGS ('dbx_value_regex' = 'department|category|subcategory|segment|subsegment|class');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `leaf_node_flag` SET TAGS ('dbx_business_glossary_term' = 'Leaf Node Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `minimum_facings` SET TAGS ('dbx_business_glossary_term' = 'Minimum Product Facings');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Depth');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Description');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Path');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'USDA Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Product Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `promotional_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Category Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `replenishment_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency Days');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `seasonality_pattern` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Pattern');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `seasonality_pattern` SET TAGS ('dbx_value_regex' = 'year_round|spring|summer|fall|winter|holiday');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `shrink_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Shrink Rate Percentage');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `space_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Percentage');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `target_gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Percentage');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Storage Zone');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|climate_controlled');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'WIC (Women Infants and Children) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `upc_barcode_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC) Barcode ID');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `barcode_image_url` SET TAGS ('dbx_business_glossary_term' = 'Barcode Image URL');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `barcode_status` SET TAGS ('dbx_business_glossary_term' = 'Barcode Status');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `barcode_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Discontinued|Recalled');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `barcode_value` SET TAGS ('dbx_business_glossary_term' = 'Barcode Value');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `check_digit` SET TAGS ('dbx_business_glossary_term' = 'Check Digit');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `check_digit` SET TAGS ('dbx_value_regex' = '^[0-9]$');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_business_glossary_term' = 'GS1 Company Prefix');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_age_restricted` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_coupon_eligible` SET TAGS ('dbx_business_glossary_term' = 'Coupon Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_pharmacy_item` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Item Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_primary_barcode` SET TAGS ('dbx_business_glossary_term' = 'Primary Barcode Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_snap_eligible` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_store_brand` SET TAGS ('dbx_business_glossary_term' = 'Store Brand Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_variable_weight` SET TAGS ('dbx_business_glossary_term' = 'Variable Weight Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `is_wic_eligible` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `item_reference` SET TAGS ('dbx_business_glossary_term' = 'Item Reference Number');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `item_reference` SET TAGS ('dbx_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `last_scanned_date` SET TAGS ('dbx_business_glossary_term' = 'Last Scanned Date');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10,11}$');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Level');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `packaging_level` SET TAGS ('dbx_value_regex' = 'Each|Inner Pack|Case|Pallet|Display Unit');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `packaging_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packaging Quantity');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `plu_code` SET TAGS ('dbx_business_glossary_term' = 'Price Look-Up (PLU) Code');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `plu_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `scan_count` SET TAGS ('dbx_business_glossary_term' = 'Scan Count');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Oracle Retail|SAP MM|EDI|Vendor Portal|Manual Entry|GS1 Registry');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `plu_code_id` SET TAGS ('dbx_business_glossary_term' = 'Price Look-Up (PLU) Code ID');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `allergen_info` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `average_weight` SET TAGS ('dbx_business_glossary_term' = 'Average Weight');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `fair_trade_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Trade Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Flag');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percent');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image URL');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `locally_sourced_flag` SET TAGS ('dbx_business_glossary_term' = 'Locally Sourced Flag');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `nutritional_info` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Information');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Flag');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `plu_code` SET TAGS ('dbx_business_glossary_term' = 'Price Look-Up (PLU) Code');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `plu_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `plu_code_status` SET TAGS ('dbx_business_glossary_term' = 'PLU Status');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `plu_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|seasonal');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `pos_display_name` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Display Name');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `size_grade` SET TAGS ('dbx_business_glossary_term' = 'Size or Grade');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `storage_temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Requirement');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `storage_temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `subcategory_code` SET TAGS ('dbx_business_glossary_term' = 'Subcategory Code');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|pound|kilogram|ounce|gram');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `variety` SET TAGS ('dbx_business_glossary_term' = 'Variety');
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women, Infants, and Children (WIC) Program Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `item_attribute_id` SET TAGS ('dbx_business_glossary_term' = 'Item Attribute Identifier');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Item Attribute Maintained By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `age_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `attribute_data_type` SET TAGS ('dbx_business_glossary_term' = 'Attribute Data Type');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `attribute_data_type` SET TAGS ('dbx_value_regex' = 'string|numeric|boolean|date|timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `attribute_group` SET TAGS ('dbx_business_glossary_term' = 'Attribute Group');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `attribute_name` SET TAGS ('dbx_business_glossary_term' = 'Attribute Name');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `attribute_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Attribute Source Reference');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `attribute_value` SET TAGS ('dbx_business_glossary_term' = 'Attribute Value');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `bioengineered_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Bioengineered Food Disclosure Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|expired|not_applicable');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `dsd_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Item Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `ebt_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `fair_trade_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Trade Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `gluten_free_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten-Free Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Hazard Classification');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `minimum_purchase_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Age');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `non_gmo_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO (Genetically Modified Organism) Verified Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `planogram_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `prescription_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `prescription_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `prescription_required_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `usda_grade` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Grade');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Program Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `nutritional_info_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Information ID');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Info Entered By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `added_sugars_g` SET TAGS ('dbx_business_glossary_term' = 'Added Sugars (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_declaration_text` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Text');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Eggs');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Fish');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Milk');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Peanuts');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_sesame` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Sesame');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Shellfish');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Soybeans');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Tree Nuts');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Allergen Verification Date');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Wheat');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `bioengineered_food_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Bioengineered Food Disclosure');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `bioengineered_food_disclosure` SET TAGS ('dbx_value_regex' = 'bioengineered|derived_from_bioengineering|not_bioengineered|unknown');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `calcium_mg` SET TAGS ('dbx_business_glossary_term' = 'Calcium (Milligrams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `calories` SET TAGS ('dbx_business_glossary_term' = 'Calories Per Serving');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `cholesterol_mg` SET TAGS ('dbx_business_glossary_term' = 'Cholesterol (Milligrams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'vendor_supplied|gs1_sync|lab_analysis|usda_database|manual_entry');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `dietary_fiber_g` SET TAGS ('dbx_business_glossary_term' = 'Dietary Fiber (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `fda_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Status');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `fda_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `iron_mg` SET TAGS ('dbx_business_glossary_term' = 'Iron (Milligrams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `potassium_mg` SET TAGS ('dbx_business_glossary_term' = 'Potassium (Milligrams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `protein_g` SET TAGS ('dbx_business_glossary_term' = 'Protein (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `saturated_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Saturated Fat (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `serving_size` SET TAGS ('dbx_business_glossary_term' = 'Serving Size');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `serving_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Serving Size Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `servings_per_container` SET TAGS ('dbx_business_glossary_term' = 'Servings Per Container');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `sodium_mg` SET TAGS ('dbx_business_glossary_term' = 'Sodium (Milligrams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `total_carbohydrate_g` SET TAGS ('dbx_business_glossary_term' = 'Total Carbohydrate (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `total_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Total Fat (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `total_sugars_g` SET TAGS ('dbx_business_glossary_term' = 'Total Sugars (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `trans_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Trans Fat (Grams)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `vitamin_d_mcg` SET TAGS ('dbx_business_glossary_term' = 'Vitamin D (Micrograms)');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `allergen_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration ID');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Entered By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body Name');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|requires_update');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `cross_contact_risk` SET TAGS ('dbx_business_glossary_term' = 'Cross-Contact Risk Level');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `cross_contact_risk` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `declaration_source` SET TAGS ('dbx_business_glossary_term' = 'Declaration Source');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `declaration_source` SET TAGS ('dbx_value_regex' = 'supplier_specification|lab_test|ingredient_analysis|manufacturer_label|third_party_certification');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `detection_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Parts Per Million (PPM)');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `digital_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Display Flag');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `ingredient_source` SET TAGS ('dbx_business_glossary_term' = 'Allergen Ingredient Source');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `label_statement` SET TAGS ('dbx_business_glossary_term' = 'Allergen Label Statement');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Declaration Notes');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Allergen Statement');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `presence_indicator` SET TAGS ('dbx_business_glossary_term' = 'Allergen Presence Indicator');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `presence_indicator` SET TAGS ('dbx_value_regex' = 'contains|may_contain|free_from|processed_in_facility');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Method');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Result');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'detected|not_detected|below_threshold|above_threshold');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|lab_analysis|supplier_audit|ingredient_traceability|visual_inspection');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `grocery_ecm`.`product`.`private_label` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`private_label` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `private_label_id` SET TAGS ('dbx_business_glossary_term' = 'Private Label ID');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Manager Employee ID');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Manufacturer Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `allergen_declaration_required` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `annual_sales_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Sales Target Amount');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `annual_sales_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_logo_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Asset Reference');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_owner_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Business Unit');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_launch|under_review');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|value|organic|specialty');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website URL');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `country_of_origin_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Disclosure');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `country_of_origin_disclosure` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Discontinuation Date');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `nutritional_labeling_standard` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Labeling Standard');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `nutritional_labeling_standard` SET TAGS ('dbx_value_regex' = 'fda_standard|fda_dual_column|supplement_facts|drug_facts|not_applicable');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `packaging_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Reference');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `quality_standard_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Tier');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `quality_standard_tier` SET TAGS ('dbx_value_regex' = 'basic|enhanced|premium|certified_organic|gmp_certified');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `target_category` SET TAGS ('dbx_business_glossary_term' = 'Target Category');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `target_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `target_margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`brand` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Vendor Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_co_manufacturer_vendor_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Manufacturer Vendor Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Manager Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Lifecycle Status');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_launch|phasing_out|seasonal');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|value|organic|specialty|economy');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Type');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_type` SET TAGS ('dbx_value_regex' = 'national|regional|private_label|generic|store_brand|exclusive');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Discontinuation Date');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `exclusive_to_grocery_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive to Grocery Flag');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `fair_trade_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Trade Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `gluten_free_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten-Free Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_business_glossary_term' = 'Global Standards 1 (GS1) Company Prefix');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `logo_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Asset Reference');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `non_gmo_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO Verified Flag');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `packaging_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Reference');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `parent_company` SET TAGS ('dbx_business_glossary_term' = 'Parent Company');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `private_label_development_stage` SET TAGS ('dbx_business_glossary_term' = 'Private Label Development Stage');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `quality_standard_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Tier');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `quality_standard_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|certified_organic|non_gmo|fair_trade');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `target_category` SET TAGS ('dbx_business_glossary_term' = 'Target Category');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `item_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Item Cost ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Event ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `base_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Cost');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `billback_allowance` SET TAGS ('dbx_business_glossary_term' = 'Billback Allowance');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Approval Status');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|auto_approved');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_basis` SET TAGS ('dbx_value_regex' = 'each|case|pallet|weight|volume');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Notes');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_source` SET TAGS ('dbx_business_glossary_term' = 'Cost Source');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_source` SET TAGS ('dbx_value_regex' = 'edi_832|vendor_contract|manual_override|system_calculated|purchase_order');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|suspended');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'standard|actual|contract|promotional|landed|average');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `dead_net_cost` SET TAGS ('dbx_business_glossary_term' = 'Dead Net Cost');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `handling_cost` SET TAGS ('dbx_business_glossary_term' = 'Handling Cost');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `is_primary_vendor` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Vendor Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `off_invoice_allowance` SET TAGS ('dbx_business_glossary_term' = 'Off-Invoice Allowance');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `scan_based_trading_allowance` SET TAGS ('dbx_business_glossary_term' = 'Scan-Based Trading (SBT) Allowance');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `slotting_fee_amortization` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amortization');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `item_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Item Lifecycle Event ID');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `affected_dc_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Distribution Center (DC) Count');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `affected_store_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Store Count');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `estimated_inventory_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Inventory Units');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'new_item_introduction|item_discontinuation|item_reactivation|reformulation|recall_initiation|recall_closure');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|recalled|on_hold');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Status');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|recalled|on_hold');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Class');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'fda|usda|dea|state_pharmacy_board|epa|other');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `source_system_event_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `triggered_by_system` SET TAGS ('dbx_business_glossary_term' = 'Triggered By System');
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `drug_item_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Item ID');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `controlled_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non-scheduled');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `drug_interaction_group` SET TAGS ('dbx_business_glossary_term' = 'Drug Interaction Group');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `drug_item_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Item Status');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `drug_item_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|recalled|back_ordered|restricted');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `expiration_tracking_method` SET TAGS ('dbx_business_glossary_term' = 'Expiration Tracking Method');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `expiration_tracking_method` SET TAGS ('dbx_value_regex' = 'lot_based|unit_based|fifo|fefo');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `fda_approval_date` SET TAGS ('dbx_business_glossary_term' = 'FDA Approval Date');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'preferred|non-preferred|excluded|prior_authorization_required');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `generic_name` SET TAGS ('dbx_business_glossary_term' = 'Generic Name');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `hazardous_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Drug Flag');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `manufacturer_labeler_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Labeler Code');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `manufacturer_labeler_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `mckesson_drug_code` SET TAGS ('dbx_business_glossary_term' = 'McKesson Drug Code');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_business_glossary_term' = 'Multi-Source Code');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_value_regex' = 'Y|N|O');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `prescription_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `prescription_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `prescription_required_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `refrigeration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `repackaged_flag` SET TAGS ('dbx_business_glossary_term' = 'Repackaged Flag');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `storage_temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Requirement');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `storage_temperature_requirement` SET TAGS ('dbx_value_regex' = 'room_temperature|refrigerated|frozen|controlled_room_temperature');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `therapeutic_class` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fuel Grade ID');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `base_price_differential` SET TAGS ('dbx_business_glossary_term' = 'Base Price Differential');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `biodiesel_blend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Biodiesel Blend Percentage');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity Score');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `cetane_number` SET TAGS ('dbx_business_glossary_term' = 'Cetane Number');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `cold_filter_plugging_point_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Cold Filter Plugging Point (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `epa_fuel_type_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Fuel Type Code');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `epa_fuel_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `ethanol_blend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ethanol Blend Percentage');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `flash_point_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `fuel_grade_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Code');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `fuel_grade_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `fuel_grade_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Name');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|ethanol_blend|biodiesel|compressed_natural_gas|electric');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `octane_rating` SET TAGS ('dbx_business_glossary_term' = 'Octane Rating');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `pump_button_color` SET TAGS ('dbx_business_glossary_term' = 'Pump Button Color');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `pump_button_color` SET TAGS ('dbx_value_regex' = 'red|yellow|green|blue|black|silver');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `pump_display_label` SET TAGS ('dbx_business_glossary_term' = 'Pump Display Label');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `reformulated_gasoline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reformulated Gasoline Indicator');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `renewable_fuel_indicator` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Indicator');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (Parts Per Million)');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `summer_blend_indicator` SET TAGS ('dbx_business_glossary_term' = 'Summer Blend Indicator');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `wholesale_product_code` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Product Code');
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ALTER COLUMN `winter_blend_indicator` SET TAGS ('dbx_business_glossary_term' = 'Winter Blend Indicator');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `item_substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Item Substitution ID');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Item ID');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `allergen_match_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Match Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|suspended|expired');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `auto_substitute_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Substitute Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `brand_match_preference` SET TAGS ('dbx_business_glossary_term' = 'Brand Match Preference');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `brand_match_preference` SET TAGS ('dbx_value_regex' = 'exact|private_label|national_brand|any');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `category_match_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Match Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'all|in_store|online|pickup|delivery|curbside');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `customer_acceptance_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Rate Percent');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `customer_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Consent Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `dietary_restriction_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction Match Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Substitution Notes');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `pharmacy_therapeutic_equivalent_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Therapeutic Equivalent Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `prescription_required_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Required Match Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `prescription_required_match_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `prescription_required_match_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `price_variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Threshold Percent');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `size_match_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Size Match Tolerance Percent');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'merchandising|ecommerce|cao|manual|category_mgmt');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `substitution_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'equivalent|upgrade|downgrade|similar|alternative|generic');
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `item_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Item Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Item Vendor Procurement Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `dsd_indicator` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Indicator');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `edi_transaction_set_supported` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set Supported');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `item_vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Item Vendor Relationship Status');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `item_vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|blocked|discontinued');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `last_cost_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Date');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order Date');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `primary_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `promotional_allowance_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance Percent');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `promotional_allowance_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `return_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amount');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_cost` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lead Time Days');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_pack_size` SET TAGS ('dbx_business_glossary_term' = 'Vendor Pack Size');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quality Certification');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_reliability_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reliability Rating');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_reliability_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Vendor Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_upc` SET TAGS ('dbx_business_glossary_term' = 'Vendor Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `vendor_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`product`.`recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`recall` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `recall_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `affected_gtin` SET TAGS ('dbx_business_glossary_term' = 'Affected Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `affected_gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `affected_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Numbers');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `affected_product_description` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Description');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `affected_states` SET TAGS ('dbx_business_glossary_term' = 'Affected States');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `affected_upc` SET TAGS ('dbx_business_glossary_term' = 'Affected Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `affected_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Closed Date');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Completed Date');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `consumer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Consumer Notification Date');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `consumer_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Consumer Notification Method');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `disposition_instructions` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instructions');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `disposition_instructions` SET TAGS ('dbx_value_regex' = 'Destroy|Return to Vendor|Hold for Inspection|Dispose per HACCP');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'National|Regional|State|Local');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `fda_enforcement_report_url` SET TAGS ('dbx_business_glossary_term' = 'FDA Enforcement Report URL');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Evaluation Summary');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated Date');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `initiating_agency` SET TAGS ('dbx_business_glossary_term' = 'Initiating Agency');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `initiating_agency` SET TAGS ('dbx_value_regex' = 'FDA|USDA|CPSC|DEA|Manufacturer');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `internal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Case Number');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `loyalty_matched_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Matched Notification Flag');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Contact Email Address');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Contact Name');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Contact Phone Number');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `manufacturer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `product_removed_date` SET TAGS ('dbx_business_glossary_term' = 'Product Removed Date');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `production_date_end` SET TAGS ('dbx_business_glossary_term' = 'Production Date Range End');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `production_date_start` SET TAGS ('dbx_business_glossary_term' = 'Production Date Range Start');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `quantity_recalled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'Cases|Units|Pounds|Kilograms|Bottles|Packages');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'Initiated|In Progress|Store Notified|Product Removed|Completed|Closed');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'Voluntary|Mandatory|Market Withdrawal');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`recall` ALTER COLUMN `store_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Store Notification Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `item_regulatory_flag_id` SET TAGS ('dbx_business_glossary_term' = 'Item Regulatory Flag ID');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending|revoked|under_review');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `digital_channel_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Display Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `disclosure_statement` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Statement');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `flag_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag Type');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `flag_type` SET TAGS ('dbx_value_regex' = 'snap_eligible|wic_approved|ebt_eligible|organic_certified|non_gmo|gluten_free_certified');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `label_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Disclosure Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `pos_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Eligibility Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation URL');
ALTER TABLE `grocery_ecm`.`product`.`item_regulatory_flag` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `item_packaging_id` SET TAGS ('dbx_business_glossary_term' = 'Item Packaging Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Bottle Deposit Amount');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height in Inches');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `hi` SET TAGS ('dbx_business_glossary_term' = 'Hi (Pallet Height Count)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `length_inches` SET TAGS ('dbx_business_glossary_term' = 'Length in Inches');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `max_stack_height` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stack Height');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Level');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `packaging_level` SET TAGS ('dbx_value_regex' = 'each|inner_pack|case|pallet|display_shipper|master_case');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `packaging_material_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Type');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `packaging_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Status');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `packaging_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|seasonal');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `recyclable_flag` SET TAGS ('dbx_business_glossary_term' = 'Recyclable Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `ti` SET TAGS ('dbx_business_glossary_term' = 'Ti (Pallet Tier Count)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Quantity per Packaging Level');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `volume_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Feet');
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ALTER COLUMN `width_inches` SET TAGS ('dbx_business_glossary_term' = 'Width in Inches');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `ab_test_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `associate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `last_modified_by_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `last_modified_by_user_associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `last_modified_by_user_associate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `iterated_from_ab_test_experiment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `ab_test_experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `ab_test_experiment_status` SET TAGS ('dbx_value_regex' = 'draft|running|paused|concluded');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `confidence_threshold` SET TAGS ('dbx_business_glossary_term' = 'Confidence Threshold');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment Creation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `customer_segment_scope` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Scope');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Date');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Code');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `experiment_name` SET TAGS ('dbx_business_glossary_term' = 'Experiment Name');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_business_glossary_term' = 'Experiment Type');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_value_regex' = 'ab|multivariate');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Experiment Hypothesis');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `is_statistically_significant` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Experiment Notes');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `result_metric_confidence_interval` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Confidence Interval');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `result_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Value');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `statistical_test` SET TAGS ('dbx_business_glossary_term' = 'Statistical Test');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `statistical_test` SET TAGS ('dbx_value_regex' = 't_test|chi_square|bayesian|z_test');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `storefront_scope` SET TAGS ('dbx_business_glossary_term' = 'Storefront Scope');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `target_metric` SET TAGS ('dbx_value_regex' = 'conversion_rate|average_order_value|click_through_rate|revenue_per_visit');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `target_metric_goal` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Goal');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `traffic_allocation` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment Update Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `variant_count` SET TAGS ('dbx_business_glossary_term' = 'Variant Count');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `variant_definitions` SET TAGS ('dbx_business_glossary_term' = 'Variant Definitions');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Experiment Version Number');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `winner_determined_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Winner Determined Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ALTER COLUMN `winning_variant_code` SET TAGS ('dbx_business_glossary_term' = 'Winning Variant ID');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `order_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Order Channel Identifier');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `parent_order_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `allowed_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Methods');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile|phone|marketplace|kiosk');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Channel Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Channel Active Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `is_third_party` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Channel Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Channel Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `max_order_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Value');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `min_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `order_channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `requires_age_verification` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Required Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `requires_prescription` SET TAGS ('dbx_business_glossary_term' = 'Prescription Requirement Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `requires_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `requires_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `routing_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Identifier');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `routing_rule_code` SET TAGS ('dbx_fk_target_hint' = 'routing_rule');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `supported_fulfillment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Fulfillment Methods');
ALTER TABLE `grocery_ecm`.`product`.`order_channel` ALTER COLUMN `supported_fulfillment_methods` SET TAGS ('dbx_value_regex' = 'delivery|pickup|in_store|curbside|digital|pharmacy');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `order_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Order Hold ID');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Associate ID (ASSOC_ID)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `primary_order_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review User ID (HOLD_FRAUD_REVIEW_USER_ID)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order Line ID (HOLD_ORDER_LINE_ID)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `superseded_order_hold_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_age_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Required Flag (HOLD_AGE_VERIF_REQ_FLG)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_age_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verified Flag (HOLD_AGE_VERIFIED_FLG)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_age_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Age Verified Timestamp (HOLD_AGE_VERIFIED_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Amount (HOLD_AMT)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Applied Timestamp (HOLD_APPLIED_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type (HOLD_CHNL_TYPE)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_channel_type` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile|call_center');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Record Created Timestamp (HOLD_CREATED_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_currency` SET TAGS ('dbx_business_glossary_term' = 'Hold Currency Code (HOLD_CURR_CD)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Timestamp (HOLD_EXPIRATION_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_expiry_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Reason Code (HOLD_EXPIRY_REASON_CD)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_expiry_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Reason Description (HOLD_EXPIRY_REASON_DESC)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status (HOLD_FRAUD_REVIEW_STS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_fraud_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|cleared|rejected');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_fraud_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Timestamp (HOLD_FRAUD_REVIEW_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score (HOLD_FRAUD_SCORE)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_inventory_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inventory Check Timestamp (HOLD_INVENTORY_CHECK_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_inventory_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Confirmation Flag (HOLD_INVENTORY_CONF_FLG)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Record Last Modified Timestamp (HOLD_MODIFIED_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes (HOLD_NOTES)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Hold Notification Channel (HOLD_NOTIF_CHNL)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Notification Sent Flag (HOLD_NOTIF_SENT_FLG)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number (HOLD_NO)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_payment_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Verification Timestamp (HOLD_PAYMENT_VERIF_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_payment_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Verification Flag (HOLD_PAYMENT_VERIF_FLG)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority (HOLD_PRIORITY)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code (HOLD_REASON_CD)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description (HOLD_REASON_DESC)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_related_quantity` SET TAGS ('dbx_business_glossary_term' = 'Related Quantity (HOLD_RELATED_QTY)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_related_sku` SET TAGS ('dbx_business_glossary_term' = 'Related SKU (HOLD_RELATED_SKU)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp (HOLD_RELEASE_TS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold SLA Met Flag (HOLD_SLA_MET_FLG)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Hold SLA Target Minutes (HOLD_SLA_TGT_MIN)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_sla_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Hold SLA Variance Minutes (HOLD_SLA_VAR_MIN)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (HOLD_SRC_SYS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status (HOLD_STATUS)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'pending|released|cancelled|escalated|expired');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type (HOLD_TYPE)');
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'fraud|payment|age_verification|inventory|other');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `gs1_sync_id` SET TAGS ('dbx_business_glossary_term' = 'GS1 Synchronization Record ID');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `prior_gs1_sync_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `correlation_ref` SET TAGS ('dbx_business_glossary_term' = 'Correlation Identifier');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'XML|JSON');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction ISO Code');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `message_ref` SET TAGS ('dbx_business_glossary_term' = 'Message Identifier');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `payload_type` SET TAGS ('dbx_business_glossary_term' = 'Payload Type');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `payload_version` SET TAGS ('dbx_business_glossary_term' = 'Payload Version');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `sync_action` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Action');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `sync_action` SET TAGS ('dbx_value_regex' = 'publish|subscribe|update|delete');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|success|failed');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Event Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ALTER COLUMN `target_system` SET TAGS ('dbx_business_glossary_term' = 'Target System Name');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` SET TAGS ('dbx_association_edges' = 'product.product_item,store.store_location');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` ALTER COLUMN `product_assortment_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment - Assortment Id');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment - Product Item Id');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment - Store Location Id');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,promotion.promo_offer');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `promo_sku_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Sku Assignment - Promo Sku Assignment Id');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Sku Assignment - Promo Offer Id');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Sku Assignment - Sku Id');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `discount_override_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Override Amount');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `discount_override_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Override Percentage');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `facing_count` SET TAGS ('dbx_business_glossary_term' = 'Facing Count');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `planogram_placement_code` SET TAGS ('dbx_business_glossary_term' = 'Planogram Placement Code');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` SET TAGS ('dbx_association_edges' = 'product.sku,inventory.storage_location');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `inventory_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation - Inventory Allocation Id');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation - Sku Id');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation - Storage Location Id');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (C)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` SET TAGS ('dbx_association_edges' = 'product.product_item,order.order_header');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `product_order_line2_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order Line Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Picker Associate Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `age_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `bogo_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy One Get One (BOGO) Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `extended_price` SET TAGS ('dbx_business_glossary_term' = 'Extended Price');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `picked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picked Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `picker_notes` SET TAGS ('dbx_business_glossary_term' = 'Picker Notes');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `quantity_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Confirmed');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `substituted_product_name` SET TAGS ('dbx_business_glossary_term' = 'Substituted Product Name');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_business_glossary_term' = 'Substituted Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `substitution_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `substitution_reason_code` SET TAGS ('dbx_value_regex' = 'out_of_stock|discontinued|damaged|expired|quality_issue|customer_request');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `substitution_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Status');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `substitution_status` SET TAGS ('dbx_value_regex' = 'original|substituted|out_of_stock|customer_declined');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `tpr_flag` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction (TPR) Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `weight_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'lb|oz|kg|g');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,fulfillment.wave');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `pick_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Assignment - Pick Assignment Id');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Associate');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Assignment - Sku Id');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Assignment - Wave Id');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`line_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`line_item` SET TAGS ('dbx_subdomain' = 'digital_commerce');
ALTER TABLE `grocery_ecm`.`product`.`line_item` SET TAGS ('dbx_association_edges' = 'product.product_item,payment.payment_transaction');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item - Line Item Id');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item - Payment Transaction Id');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item - Product Item Id');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Price');
ALTER TABLE `grocery_ecm`.`product`.`line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
