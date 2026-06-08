-- Schema for Domain: product | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`product` COMMENT 'Authoritative catalog of all sellable items including CPG products, private-label brands, fresh produce, pharmacy drug items, and fuel grades. Manages SKU, UPC, GTIN, PLU codes, product hierarchies, categories, attributes, nutritional information, and regulatory compliance flags. Supports planogram design, category management, and FDA labeling requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_header` (
    `order_header_id` BIGINT COMMENT 'Unique surrogate identifier for every customer purchase record across all channels (POS, online, click-and-collect, curbside pickup, last-mile delivery, pharmacy Rx fills). Primary key of the order_header entity and the single canonical identity for all customer transactions in the enterprise.',
    `ad_circular_id` BIGINT COMMENT 'Foreign key linking to promotion.ad_circular. Business justification: Grocery retailers measure ad circular ROI by attributing transactions to the specific circular that drove the visit. order_header.ad_circular_week is a denormalized reference; a proper FK to ad_circul',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost center assignment enables internal cost allocation and budgeting reports per order, a standard practice in grocery chains.',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: For omnichannel orders, the fulfillment node (dark store, DC, or store backroom) may differ from the store_location_id. Attributing orders to their fulfillment node is essential for node-level order v',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue GL account needed for GAAP sales reporting; each order must post revenue to a specific GL account, obvious to finance analysts.',
    `household_id` BIGINT COMMENT 'Reference to the customer household entity for household-level purchase analytics, loyalty program household linking, and targeted promotions. Enables household basket analysis and CLTV (Customer Lifetime Value) calculations at the household level. Null for anonymous transactions.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Identifies the corporate legal entity owning the store for consolidation and regulatory reporting.',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: REQUIRED: Loyalty reporting needs to tie each order to the shoppers membership to calculate points earned, tier changes, and generate the Points Earned per Order report.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: Order‑level reference to the tokenized payment method allows reporting of payment method usage per order and supports refunds to the original method.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Links each order to its fiscal period, enabling period‑based financial statements and variance analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center linkage supports profitability analysis by store/region; required for P&L statements per profit center.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Required for Marketing ROI report linking each order to its originating campaign; replaces denormalized promo_code.',
    `rx_patient_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_patient. Business justification: Orders containing prescriptions must be associated with the patient to satisfy HIPAA, claim reconciliation, and loyalty program integration.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer/shopper who placed or completed this order. Nullable for anonymous in-store POS transactions where no loyalty card was scanned and no account was identified.',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: The SLA policy applicable to an order (based on channel, customer tier, order value) governs the entire fulfillment commitment from placement to delivery. Customer service SLA breach reporting and com',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Required for cluster‑level sales performance reporting; each order must be attributed to its store cluster for weekly KPI dashboards.',
    `store_location_id` BIGINT COMMENT 'Reference to the physical store or fulfillment location where the order originated or was fulfilled. Links to the store master for store-level reporting, comp sales, and same-store sales analysis.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Grocery order headers must record the primary tender type for SNAP/EBT eligibility enforcement, fuel reward redemption rules, and regulatory SNAP transaction reporting. The existing plain-text paymen',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: B2B wholesale orders must be attributed to the wholesale_account for credit limit enforcement, contract pricing application, minimum order validation, and B2B account management reporting. A retail-gr',
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
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Needed for planogram compliance analysis; linking each sold line to the specific assortment item enables tracking of plan execution vs actual sales.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Enables brand performance analytics and promotional budgeting by linking each order line to its brand master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Order line cost center assignment drives departmental P&L for produce, deli, pharmacy, and fuel departments. Grocery retailers require line-level cost center allocation to accurately report department',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Order line should be linked to the department responsible for the sold item to enable departmental sales reporting.',
    `drug_item_id` BIGINT COMMENT 'Foreign key linking to product.drug_item. Business justification: Necessary for pharmacy order compliance, controlled‑substance tracking, and drug‑specific reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each order line must post to a GL account for revenue recognition and COGS recording by product category. Grocery financial systems require line-level GL assignment to support departmental revenue rep',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Supports hierarchical assortment planning and category‑level sales reporting via the item hierarchy reference.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header that contains this line item. Links the line to its transaction header.',
    `plu_code_id` BIGINT COMMENT 'Foreign key linking to product.plu_code. Business justification: product_order_line stores plu as a denormalized string for fresh produce and variable-weight items. plu_code is the authoritative PLU registry with commodity type, organic flag, size grade, and price-',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Line‑level tracking of prescription items enables accurate inventory deduction, claim submission, and return processing in pharmacy operations.',
    `price_change_id` BIGINT COMMENT 'Foreign key linking to pricing.price_change. Business justification: Price‑change impact analysis tracks which price_change event affected a line, supporting margin and revenue impact reporting.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: When a coupon or promo code is applied, the order line should reference the specific promo offer for audit and effectiveness analysis.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Price audit report requires linking each order line to the exact retail_price record applied, enabling compliance checks of sold price versus current price.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for SKU‑level sales reporting and inventory allocation; order lines must reference the SKU master record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Required for supplier performance reporting per line item; enables cost allocation and on‑time delivery metrics that retailers track for each SKUs supplier.',
    `upc_barcode_id` BIGINT COMMENT 'Foreign key linking to product.upc_barcode. Business justification: product_order_line stores upc as a denormalized string. upc_barcode is the authoritative UPC/barcode registry with scan metadata, packaging level, and GS1 company prefix. Adding upc_barcode_id normali',
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
    `void_flag` BOOLEAN COMMENT 'Indicates whether this line item was voided during the transaction. Used for shrink analysis and cashier performance monitoring.',
    `void_reason_code` STRING COMMENT 'Reason code explaining why the line item was voided. Examples include customer changed mind, pricing error, damaged item, or cashier error.',
    `weight_actual` DECIMAL(18,2) COMMENT 'Actual weight of the item for variable-weight products such as fresh produce, meat, deli, and seafood. Captured from scale at POS or during fulfillment picking.',
    `weight_unit` STRING COMMENT 'Unit of measure for the actual weight field. Typically pounds or kilograms depending on regional standards.. Valid values are `lb|kg|oz|g`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using WIC benefits. Required for government program compliance and reporting.',
    CONSTRAINT pk_product_order_line PRIMARY KEY(`product_order_line_id`)
) COMMENT 'Individual line item within a customer order representing a single SKU/UPC purchased or requested across all channels (in-store POS scan, online cart, click-and-collect). Captures line sequence number, SKU/GTIN, PLU (for produce), UPC (for POS-scanned items), item description, ordered quantity, unit of measure, unit price, extended price, discount amount, promo applied flag, substitution flag, substitution SKU, line status (active, substituted, cancelled, out-of-stock, voided, returned), weight (for variable-weight/scale items), tax code, department code, tax amount, fulfillment method per line, void flag, return flag, TPR flag, BOGO flag, coupon applied reference, and scan method (handheld, belt scanner, self-checkout, manual key). Supports both fixed-weight CPG items and variable-weight fresh/deli items. Enables basket analytics, shrink analysis, and category performance reporting at the item level across all channels.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_status_history` (
    `order_status_history_id` BIGINT COMMENT 'Unique identifier for each status transition record in the order lifecycle. Primary key for the immutable audit trail.',
    `carrier_id` BIGINT COMMENT 'Reference to the delivery carrier or logistics provider involved in this status transition. Applicable for delivery-related status changes (out_for_delivery, delivered). Null for non-delivery transitions.',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Status transitions (picked, packed, staged, dispatched) are node-level events. order_status_history has store_location_id but not fulfillment_node_id. Node attribution enables node-level throughput, e',
    `order_header_id` BIGINT COMMENT 'Reference to the order header that experienced this status transition. Links this status event to the parent order entity.',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: order_status_history has sla_target_timestamp and sla_met_flag as plain attributes but no FK to sla_policy. Linking enables SLA policy-level compliance reporting across individual status transitions, ',
    `store_location_id` BIGINT COMMENT 'Reference to the physical location (store, distribution center, micro-fulfillment center, pharmacy) where the status transition occurred. Null for system-automated transitions without physical location context.',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: Delivery orders must reference the carrier master for SLA tracking, rate lookup, and carrier performance reporting. carrier_code is a denormalized carrier reference already on delivery_order; a proper',
    `contact_info_id` BIGINT COMMENT 'Foreign key linking to customer.contact_info. Business justification: Required for Delivery Address Verification report; each delivery order must reference a validated contact_info record for carrier compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Delivery costs (carrier fees, fuel, driver labor) are allocated to cost centers for last-mile delivery P&L reporting. Grocery operators track delivery cost per order by cost center to manage delivery ',
    `delivery_route_id` BIGINT COMMENT 'Reference to the TMS route plan that includes this delivery. Links to JDA Transportation Management System route optimization.',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Delivery orders originate from a specific fulfillment node (dark store, DC, or store). Node-level delivery performance reporting and capacity planning require this link. A retail-grocery operations ex',
    `fulfillment_slot_id` BIGINT COMMENT 'Foreign key linking to product.fulfillment_slot. Business justification: A delivery_order represents last-mile delivery which is scheduled within a fulfillment_slot time window (scheduled_window_start_time, scheduled_window_end_time on delivery_order correspond to slot win',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Delivery fee revenue and carrier costs post to specific GL accounts for revenue recognition and expense reporting. Grocery finance requires GL-level delivery posting to separately track delivery fee i',
    `order_fulfillment_id` BIGINT COMMENT 'Foreign key linking to product.order_fulfillment. Business justification: A delivery_order is the last-mile logistics leg that follows the pick-pack-ship fulfillment execution in order_fulfillment. Linking delivery_order to order_fulfillment enables end-to-end order trackin',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header that originated this delivery. Links the delivery leg back to the original customer order.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to customer.shopper. Business justification: Delivery orders require direct shopper linkage for loyalty points attribution at delivery completion, customer communication (delivery notifications), and customer service lookups. The existing contac',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: Delivery SLA policies govern scheduled window commitments and breach compensation rules. Linking delivery_order to sla_policy enables SLA breach analysis, customer compensation processing, and channel',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: The originating store (dark store or MFC dispatch point) is a critical operational attribute for last-mile routing, carrier assignment, and store-level delivery SLA reporting. A direct FK avoids a mul',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fulfillment.vehicle. Business justification: Delivery orders are executed by a specific vehicle. Linking to the vehicle master enables fleet utilization reporting, temperature compliance tracking (cold-chain), and insurance/regulatory audit trai',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the delivery was completed and goods were handed off to the customer or left at the delivery location. Null if delivery not yet completed.',
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
    CONSTRAINT pk_delivery_order PRIMARY KEY(`delivery_order_id`)
) COMMENT 'Last-mile delivery order record managing the logistics leg of an online or OMS-originated order dispatched to a customer address. Captures delivery order number, linked order header, delivery address, scheduled delivery window (start/end), actual delivery timestamp, delivery status (scheduled, assigned, en-route, delivered, failed, returned), driver/carrier reference, vehicle reference, delivery zone, distance miles, delivery fee, tip amount, contactless delivery flag, delivery instructions, proof-of-delivery method (photo/signature/PIN), and TMS route reference. Integrates with JDA TMS.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`pickup_appointment` (
    `pickup_appointment_id` BIGINT COMMENT 'Unique identifier for the pickup appointment record. Primary key for curbside and click-and-collect appointment tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Curbside pickup operations incur labor (personal shoppers, staging staff) and facility costs allocated to cost centers. Grocery operators track pickup cost per appointment by cost center to manage omn',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Pickup appointments are serviced by a specific fulfillment node (e.g., curbside node at a store). Node-level capacity planning, SLA compliance, and throughput reporting require this link. pickup_appoi',
    `fulfillment_slot_id` BIGINT COMMENT 'Foreign key linking to product.fulfillment_slot. Business justification: A pickup_appointment is a curbside or click-and-collect appointment that must be scheduled within a fulfillment_slot time window. Linking pickup_appointment to fulfillment_slot enables slot capacity t',
    `order_fulfillment_id` BIGINT COMMENT 'Foreign key linking to product.order_fulfillment. Business justification: A pickup_appointment is the customer-facing scheduling record for click-and-collect, while order_fulfillment is the warehouse/store execution record (pick-pack-stage). Linking pickup_appointment to or',
    `order_header_id` BIGINT COMMENT 'Reference to the order header associated with this pickup appointment. Links the appointment to the customers order for fulfillment tracking.',
    `rx_patient_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_patient. Business justification: pickup_appointment tracks pharmacy prescription pickups (dispensing_start_timestamp, dispensing_completion_timestamp fields confirm pharmacy use). HIPAA-compliant identity verification at pickup requi',
    `service_capability_id` BIGINT COMMENT 'Foreign key linking to store.service_capability. Business justification: Pickup appointments are governed by the stores curbside or in-store pickup service_capability record, which defines bay count, SLA targets, and capacity limits. Linking appointments to service_capabi',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who scheduled the pickup appointment. Links appointment to customer profile for notification and service history.',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: pickup_appointment has sla_target_minutes and sla_met_flag as plain attributes but no FK to sla_policy. SLA policy defines the target window for curbside/BOPIS fulfillment by customer tier and channel',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: For ship-from-store and home-delivery fulfillment types, the carrier assigned at the fulfillment level drives dispatch, tracking, and carrier billing. Linking order_fulfillment to the carrier master e',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pick/pack/stage fulfillment operations incur labor and facility costs allocated to cost centers for e-commerce P&L reporting. Grocery operators track fulfillment cost per order by cost center to manag',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Fulfillment costs must be period-stamped for accrual accounting and omnichannel cost-of-service reporting. Grocery finance teams require fiscal-period-level fulfillment data to accrue labor and packag',
    `node_id` BIGINT COMMENT 'Identifier of the specific store, MFC, DC, or pharmacy location executing this fulfillment.',
    `fulfillment_slot_id` BIGINT COMMENT 'Foreign key linking to product.fulfillment_slot. Business justification: order_fulfillment is the execution record for pick-pack-ship workflows. fulfillment_slot defines the scheduled time windows for click-and-collect, curbside, or delivery. Linking order_fulfillment to i',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fulfillment labor, packaging, and staging costs post to specific GL accounts for operational expense reporting. Grocery retailers require GL-level fulfillment cost posting to support COGS allocation, ',
    `mfc_profile_id` BIGINT COMMENT 'Foreign key linking to store.mfc_profile. Business justification: MFC-fulfilled orders must reference the specific mfc_profile to support robotics throughput reporting, pick-time SLA tracking, and MFC-level order accuracy KPIs. Grocery omnichannel operations teams r',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header being fulfilled. Links this fulfillment execution to the customer order.',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: order_fulfillment has sla_target_minutes as a plain attribute but no FK to sla_policy. SLA policy governs pick/pack/dispatch targets per fulfillment channel and customer tier. Operations teams measure',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promotional discounts and markdowns are allocated to cost centers for trade spend accounting and departmental margin analysis. Grocery category managers require cost-center-level discount tracking to ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Discount accruals and promotional liabilities must be period-stamped for GAAP-compliant promotional expense recognition. Grocery retailers accrue vendor-funded discounts by fiscal period for accurate ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Discount expense must be posted to a specific GL account for accurate discount expense reporting.',
    `order_header_id` BIGINT COMMENT 'Reference to the order header to which this discount is applied. Links to the parent order transaction.',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: Discount authorization audit trails and promotion compliance reporting require knowing which price rule authorized each order discount. In grocery retail, SNAP/WIC discount compliance and loyalty disc',
    `product_order_line_id` BIGINT COMMENT 'Reference to the specific order line item to which this discount is applied. Nullable for header-level discounts that apply to the entire order rather than a specific line.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Discount funding allocation to profit centers is required for banner/store-level promotional P&L reporting. Grocery operators track discount impact by profit center to measure net margin by store and ',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotion campaign or offer that generated this discount. Links to the promotion master data.',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward_offer. Business justification: Loyalty-funded discount reconciliation requires distinguishing discounts funded by loyalty reward offers from trade-promotion discounts. Finance and loyalty teams separately account for loyalty redemp',
    `store_location_id` BIGINT COMMENT 'Reference to the physical store location where this discount was applied, if applicable. Nullable for online-only transactions.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier funding this discount, if applicable. Nullable for store-funded or loyalty-funded discounts.',
    `transaction_id` BIGINT COMMENT 'The unique transaction identifier from the source system (POS transaction number, eCommerce order number). Used for cross-system reconciliation and audit.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Wholesale volume discounts and contract-based pricing discounts must be attributed to the wholesale_account for B2B discount reporting, contract compliance auditing, and supplier funding reconciliatio',
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
    `authorization_id` BIGINT COMMENT 'Foreign key linking to payment.authorization. Business justification: Grocery order payments must link to the authorization record for chargeback response, settlement reconciliation, and dispute resolution. The plain-text authorization_code and authorization_timestam',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Tracks which bank account received the payment for reconciliation and cash‑management reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Payment transactions must be period-stamped for cash flow reporting, period-end bank reconciliation, and settlement status tracking. Grocery finance requires fiscal-period-level payment data for accur',
    `gift_card_id` BIGINT COMMENT 'Foreign key linking to payment.gift_card. Business justification: When a grocery order is paid with a gift card, the order_payment record must link to the specific gift card for balance management, fraud detection, and state escheatment law compliance. Plain-text g',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payment receipts (cash, credit, EBT, gift card) must post to specific GL accounts (cash clearing, AR, gift card liability) for daily cash reconciliation and financial close. Grocery treasury teams req',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: Needed for fraud analysis: associate each order payment with the stored tokenized payment method used, enabling compliance and recurring‑payment tracking.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the parent order header. Links this payment tender to the customer order it settles.',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to payment.settlement_batch. Business justification: Grocery treasury operations require linking each order payment directly to its settlement batch for daily settlement reconciliation, GL posting, and variance reporting. The plain-text settlement_stat',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Store-level payment reconciliation, tender balancing, and POS cash management reports require direct store attribution on each payment record. Grocery store controllers perform daily tender reconcilia',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Order payment records must link directly to tender_type for EBT/SNAP/WIC regulatory reconciliation, settlement batch assignment by tender category, and fee calculation. The plain-text tender_type co',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Required for audit: link each order payment record to its underlying payment transaction for settlement reconciliation and financial reporting.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Wholesale account payments (ACH transfers, net-30 invoice settlements, credit account payments) must be tracked against the wholesale_account for B2B accounts receivable management, payment terms enfo',
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
    `mobile_wallet_type` STRING COMMENT 'Type of mobile wallet used for payment. Applicable only when tender_type is mobile_wallet.. Valid values are `apple_pay|google_pay|samsung_pay|other`',
    `payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount applied from this payment tender toward the order total. For split-tender transactions, this represents the portion paid by this specific instrument. Expressed in the transaction currency.',
    `payment_channel` STRING COMMENT 'Channel or interface through which the payment was captured. Point of Sale (POS) for in-store register transactions; ecommerce for web storefront; mobile_app for native app checkout; kiosk for self-service terminals; phone for call center orders; curbside_terminal for pickup payment devices.. Valid values are `pos|ecommerce|mobile_app|kiosk|phone|curbside_terminal`',
    `payment_gateway` STRING COMMENT 'Name or identifier of the payment gateway or processor that handled this transaction. Examples include First Data, Worldpay, Stripe, or internal processor identifiers.',
    `payment_processor_reference` STRING COMMENT 'Unique transaction identifier assigned by the external payment processor or gateway. Used for reconciliation, dispute resolution, and cross-system traceability.',
    `payment_sequence_number` STRING COMMENT 'Sequential number of this payment tender within the order. Supports split-tender transactions where multiple payment instruments are applied to a single order.',
    `refund_reason_code` STRING COMMENT 'Code indicating the reason for refund when settlement_status is refunded. Examples include customer_request, damaged_goods, pricing_error, order_cancellation. Used for refund analytics and fraud detection.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed. Applicable only when settlement_status is refunded.',
    `snap_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of the order total that qualifies for Supplemental Nutrition Assistance Program (SNAP) Electronic Benefits Transfer (EBT) payment. Applicable when tender_type is ebt_snap. Required for SNAP regulatory reporting and compliance audits.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added by the customer for delivery or service. Applicable primarily to delivery and curbside pickup orders. Null when no tip is provided.',
    `tokenized_payment_instrument` STRING COMMENT 'Payment Card Industry Data Security Standard (PCI DSS) compliant token representing the payment instrument. Used for recurring payments and stored payment methods without retaining sensitive card data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment tender record was last modified. Used for audit trail and change tracking.',
    `wic_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of the order total that qualifies for Women Infants and Children (WIC) program payment. Applicable when tender_type is wic. Required for WIC program reporting.',
    `wic_voucher_number` STRING COMMENT 'Unique voucher or authorization number for Women Infants and Children (WIC) program payment. Applicable only when tender_type is wic. Required for WIC program reconciliation and state reporting.',
    CONSTRAINT pk_order_payment PRIMARY KEY(`order_payment_id`)
) COMMENT 'Payment tender record for each payment instrument applied to a customer order. Captures payment ID, linked order header, tender type (credit, debit, EBT/SNAP, WIC, mobile wallet, gift card, fuel reward, cash, check), card type (Visa/MC/Amex), last four digits, authorization code, authorization timestamp, settlement status, payment amount, change given, EBT balance remaining (for EBT tenders), and payment processor reference. Supports PCI DSS compliance and SNAP/WIC regulatory reporting. References order_header as the single parent — no dual-FK pattern.';

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`order_refund` (
    `order_refund_id` BIGINT COMMENT 'Unique identifier for the refund transaction record. Primary key for the order_refund product.',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to payment.chargeback. Business justification: In grocery retail, chargebacks frequently trigger refund issuance. Linking order_refund to the originating chargeback record enables chargeback-driven refund tracking, financial impact reporting, and ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Refund costs (shrink, fraud, policy exceptions) must be allocated to departmental cost centers for P&L reporting and shrink accounting. Grocery finance teams require cost-center-level refund tracking ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Refund reversals must be booked to the correct fiscal period for GAAP revenue recognition and period-end close. Grocery retailers require period-stamped refunds to accurately report net sales and avoi',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Refunds tied to fulfillment failures (short picks, substitutions, late delivery) must be attributed to the originating fulfillment node for root-cause analysis and node-level shrink/loss reporting. or',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Refunds are expense entries that require a GL account for proper accounting and audit trails.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the original order header for which this refund was issued. Links the refund back to the parent order transaction.',
    `transaction_id` BIGINT COMMENT 'External payment processor transaction identifier from the original order. Used to link refund back to original payment for reconciliation and chargeback prevention.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Refund costs must be attributed to the store/banner profit center for store-level P&L and same-store-sales reporting. Grocery operators track refund rates by profit center to assess store performance ',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Financial reconciliation of refunds by campaign for GMROI calculations; promotion_code_reversed is a denormalized code.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: When a promoted item is refunded, grocery retailers must reverse the associated vendor funding claim and loyalty points. Linking order_refund directly to promo_offer enables automated vendor deduction',
    `gift_card_id` BIGINT COMMENT 'Foreign key linking to payment.gift_card. Business justification: When grocery refunds are issued as store credit/gift cards, the order_refund must link to the specific gift card issued for balance tracking, fraud prevention, and state escheatment law compliance. Ro',
    `refund_id` BIGINT COMMENT 'Foreign key linking to payment.refund. Business justification: Grocery refund operations require linking the business-level order_refund (customer reason, policy exception, loyalty reversal) to the payment-level refund record (processor transaction, settlement) f',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Grocery refund policy mandates tender-type-specific rules: EBT refunds must return to EBT, gift card refunds to store credit. Linking order_refund to tender_type via role-prefixed refund_tender_type_',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to product.product_order_line. Business justification: A refund/return is typically tied to a specific order line item (the SKU being returned). order_refund already has order_header_id for the header-level link, but lacks a line-level reference. Adding r',
    `rx_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_claim. Business justification: When a pharmacy order is refunded, the associated rx_claim must be reversed for PBM/insurance adjudication. CMS and PBM contracts require claim reversals to match refund records within the reversal wi',
    `shopper_id` BIGINT COMMENT 'Foreign key reference to the customer who requested the refund. May differ from the original order customer in cases of gift returns.',
    `store_location_id` BIGINT COMMENT 'Foreign key reference to the store location where the refund was processed. Applicable for in-store and curbside refunds.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Wholesale refunds require credit memo issuance against the wholesale_account for B2B accounts receivable reconciliation and dispute resolution. order_refund already has shopper_id for retail customers',
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
    `policy_exception_flag` BOOLEAN COMMENT 'Boolean indicator whether this refund required an exception to standard return policy (e.g., outside return window, no receipt, final sale item). Requires manager approval.',
    `receipt_number` STRING COMMENT 'Original receipt number provided by customer to validate the purchase. Used for no-receipt return policy enforcement and fraud prevention.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total monetary value being refunded to the customer, including product cost and applicable taxes. Expressed in the transaction currency.',
    `refund_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was approved by an authorized associate or automated system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refund_channel` STRING COMMENT 'Business channel through which the refund was initiated. POS = Point of Sale for in-store refunds.. Valid values are `pos|online|mobile_app|customer_service|pharmacy|curbside`',
    `refund_denied_timestamp` TIMESTAMP COMMENT 'Date and time when the refund request was denied. Null if refund was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refund_notes` STRING COMMENT 'Free-text notes captured by the associate processing the refund. May include additional context, customer comments, or special handling instructions.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pharmacy operations have dedicated cost centers for drug costs, dispensing labor, and overhead. Grocery pharmacy P&L reporting requires cost-center-level rx_order allocation to track pharmacy departme',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: rx_order requires pharmacy.drug for insurance adjudication (AWP, WAC), formulary tier determination, REMS compliance, and DEA schedule verification at dispensing time. drug_item is the retail catalog ',
    `drug_item_id` BIGINT COMMENT 'Foreign key linking to product.drug_item. Business justification: rx_order stores drug_name, drug_ndc_code, drug_form, and drug_strength as denormalized strings. drug_item is the pharmacy drug item master with ndc, dosage_form, strength, and generic_name attributes.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Pharmacy insurance claim accruals and copay revenue must be period-stamped for GAAP revenue recognition. Grocery pharmacy finance requires fiscal-period-level rx_order data to accrue insurance receiva',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Pharmacy fulfillment (dispensing, delivery, curbside pickup) is executed at a specific fulfillment node. rx_order has pharmacy_location_id but not fulfillment_node_id. Node-level pharmacy fulfillment ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pharmacy revenue (copay, insurance reimbursement, dispensing fees) and drug COGS post to specific GL accounts. Grocery pharmacy finance requires GL-level rx_order posting for insurance AR reconciliati',
    `insurance_plan_id` BIGINT COMMENT 'Foreign key linking to pharmacy.insurance_plan. Business justification: Every rx_order is adjudicated against a specific insurance plan for copay calculation, formulary tier lookup, quantity limits, and step therapy requirements. insurance_bin_number, insurance_group_numb',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order header for combined grocery and pharmacy orders. Links the Rx order to the overall customer order transaction.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Regulatory reporting requires each Rx order to be linked to the specific pharmacy location that dispensed it for state compliance and inventory tracking.',
    `pharmacy_patient_id` BIGINT COMMENT 'Reference to the pharmacy patient record. Links the Rx order to the patient receiving the medication.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: rx_order is the fulfillment event for a specific prescription; pharmacists need direct access to sig, refills_authorized, controlled_substance_schedule, and prior_auth status. prescription_number, pre',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Controlled substances and specialty drugs require an approved prior authorization before dispensing. rx_order must reference pharmacy.prior_authorization to confirm PA status, approved quantity, and e',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pharmacy segment P&L reporting requires rx_order attribution to pharmacy profit centers. Grocery operators report pharmacy as a distinct profit center for segment disclosure, banner-level pharmacy per',
    `rx_claim_id` BIGINT COMMENT 'Reference identifier for the insurance claim submitted for this prescription fill. Links to third-party payer adjudication.',
    `rx_patient_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_patient. Business justification: rx_order must reference pharmacy.rx_patient for dispensing workflows: HIPAA authorization status, auto-refill enrollment, insurance BIN/PCN, and counseling preferences are all on rx_patient. Pharmacy ',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether the medication is a controlled substance requiring DEA reporting and special handling.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Patient copayment amount in USD for this prescription fill after insurance adjudication.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this Rx order record was first created in the system.',
    `days_supply` STRING COMMENT 'Number of days the dispensed medication is intended to last based on prescribed dosing instructions.',
    `dea_schedule` STRING COMMENT 'DEA classification schedule for controlled substances (II through V). Non-controlled medications are marked as Non_Controlled.. Valid values are `Schedule_II|Schedule_III|Schedule_IV|Schedule_V|Non_Controlled`',
    `delivery_method` STRING COMMENT 'Method by which the prescription was delivered to the patient: in-store pickup, curbside pickup, home delivery, or mail order.. Valid values are `pickup|curbside|home_delivery|mail_order`',
    `dispensed_timestamp` TIMESTAMP COMMENT 'Date and time the prescription was picked up or delivered to the patient.',
    `dispensing_fee` DECIMAL(18,2) COMMENT 'Professional fee charged by the pharmacy for dispensing services in USD.',
    `fill_number` STRING COMMENT 'Sequential number indicating which fill this is for the prescription (1 for initial fill, 2+ for refills).',
    `fill_status` STRING COMMENT 'Current status of the prescription fill in the pharmacy workflow: received, in clinical verification, ready for patient pickup, dispensed to patient, on hold, cancelled, or returned. [ENUM-REF-CANDIDATE: received|in_verification|ready_for_pickup|dispensed|on_hold|cancelled|returned — 7 candidates stripped; promote to reference product]',
    `fill_timestamp` TIMESTAMP COMMENT 'Date and time the prescription was filled and verified by the pharmacist.',
    `fill_type` STRING COMMENT 'Classification of the prescription fill event: new prescription, refill of existing prescription, transfer from another pharmacy, transfer to another pharmacy, or partial fill.. Valid values are `new|refill|transfer_in|transfer_out|partial_fill`',
    `insurance_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by insurance in USD for this prescription fill after adjudication.',
    `mckesson_rx_system_ref` STRING COMMENT 'Source system identifier from McKesson Pharmacy Systems for this prescription order record.',
    `prescription_expiration_date` DATE COMMENT 'Date after which the prescription is no longer valid for filling or refilling.',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Price protection adjustments and refund differences from substitutions post to GL accounts for revenue adjustment accounting. Grocery finance requires GL-level substitution posting to track price prot',
    `product_order_line_id` BIGINT COMMENT 'Foreign key reference to the order line item that required substitution. Links to the specific line item in the order that was out of stock or unavailable.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: During grocery fulfillment substitution, the substitute item may carry a different promo offer than the original. Retailers must track which offer applies to the substitute for correct discount applic',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to customer.shopper. Business justification: Substitution acceptance/rejection decisions are shopper-specific and drive personalization models (learning individual substitution preferences) and customer satisfaction reporting. Grocery retailers ',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: order_substitution captures the substitute item via substitute_sku (string) and substitute_product_name (string). Adding substitute_product_item_id normalizes the substitute item reference to the prod',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: order_substitution stores substitute_sku and substitute_gtin as denormalized strings. Adding substitute_sku_id as a FK to the sku table normalizes the substitute items SKU reference, enabling proper ',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Substitutions occur during picking waves. Linking order_substitution to the wave enables wave-level substitution rate analysis — a key fulfillment quality KPI in grocery operations. Wave managers use ',
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
    `substitute_item_stock_level` STRING COMMENT 'The on-hand inventory quantity of the substitute item at the fulfillment location at the time of substitution.',
    `substitute_quantity` DECIMAL(18,2) COMMENT 'The quantity of the substitute item provided to fulfill the order.',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`fulfillment_slot` (
    `fulfillment_slot_id` BIGINT COMMENT 'Unique identifier for the fulfillment slot. Primary key.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Slot fee revenue accruals and capacity cost allocations need fiscal period assignment for period-end close. Grocery finance requires period-stamped slot data to recognize slot fee income in the correc',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Fulfillment slots represent capacity units of a fulfillment node, not just a store location. Node-level slot capacity planning and throughput management require this link. A grocery omnichannel operat',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fulfillment slot fee revenue posts to a GL account for revenue recognition. Grocery retailers charge slot fees for premium delivery/pickup windows; these fees must post to a distinct GL account for om',
    `service_capability_id` BIGINT COMMENT 'Foreign key linking to store.service_capability. Business justification: Slot creation, capacity rules, and SLA targets are governed by the stores service_capability record (curbside, delivery, MFC). Linking fulfillment_slot to service_capability enables omnichannel capac',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: fulfillment_slot has service_level as a plain attribute but no FK to sla_policy. SLA policies govern slot-level delivery/pickup commitments (cutoff times, dispatch windows). Slot management teams need',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`product_item` (
    `product_item_id` BIGINT COMMENT 'Unique identifier for the product item. Primary key for the product_item entity.',
    `brand_id` BIGINT COMMENT 'FK to product.brand',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Product items are assigned to departmental cost centers for inventory valuation and shrink tracking. Grocery retailers require item-level cost center assignment to allocate shrink, spoilage, and markd',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Product items map to GL accounts for revenue classification and COGS posting rules at the item master level. Grocery financial systems use item-level GL assignment to drive automatic journal entry cre',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Product items belong to a hierarchy; linking provides parent classification.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Tracks which legal entity owns/liabilities for a product, needed for entity‑level financial reporting and compliance.',
    `plu_code_id` BIGINT COMMENT 'Foreign key linking to product.plu_code. Business justification: PLU codes are managed centrally; replace string with FK.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Sourcing teams designate a primary supplier per item for purchase order generation and cost negotiations.',
    `private_label_id` BIGINT COMMENT 'Foreign key linking to product.private_label. Business justification: product_item has a private_label_flag boolean but no FK to the private_label brand registry. For items where private_label_flag=true, adding private_label_id enables direct reference to the private la',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: For fresh produce and perishables, the specific sourcing site (farm, co-manufacturer, DC) is critical for FDA food safety traceability, FSMA compliance, and cold chain management. Grocery food safety ',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: SKUs map to GL accounts for POS-level revenue and COGS posting at the scan transaction level. Grocery financial systems require SKU-level GL assignment to support real-time revenue posting, inventory ',
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
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category management teams align product hierarchy nodes to the assortment category taxonomy for planogram resets, space planning, and assortment reviews. A retail-grocery domain expert expects each it',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Item hierarchy nodes (department/category) map to cost centers for departmental P&L reporting. Grocery retailers use hierarchy-level cost center assignment to allocate shrink, labor, and overhead cost',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Category/department hierarchy nodes map to GL accounts for revenue and COGS classification rules. Grocery financial systems use hierarchy-level GL assignment to drive automatic posting for all items w',
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
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: GS1 barcode validation against the vendors item catalog is a standard EDI/receiving process. Receiving teams resolve barcode discrepancies by comparing scanned UPCs against vendor_item records. A dir',
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
    `product_item_id` BIGINT COMMENT 'Reference to the parent item (SKU, UPC, PLU, or drug item) to which this attribute applies. Links to the item master catalog.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Product certifications (kosher, halal, organic, non-GMO) tracked in item_attribute are issued to specific suppliers/manufacturers. Regulatory compliance and quality teams need supplier-level certifica',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Private label brands should reference the master brand entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Private label brand P&L is tracked by profit center for banner/segment performance reporting. Grocery operators measure private label margin contribution by profit center to support strategic decision',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Brand-level marketing spend, slotting fees, and trade promotion costs are tracked against cost centers. Grocery category management requires brand-level cost center assignment to measure trade spend e',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Brands are owned by legal entities; linking enables brand‑level profit and expense reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Brand performance reporting maps brands to profit centers for banner/segment P&L analysis. Grocery operators track brand sales contribution by profit center to support category captain negotiations, p',
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
    `cost_schedule_id` BIGINT COMMENT 'Foreign key linking to vendor.cost_schedule. Business justification: Buyers must validate that the retailers item cost reflects the correct bracket tier and allowances from the active cost schedule. A direct FK from item_cost to cost_schedule enables the cost schedul',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Item cost records must be period-stamped for inventory valuation, COGS calculation, and period-end cost accounting. Grocery retailers use fiscal-period-level cost data for LIFO/FIFO inventory accounti',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps each item cost to the appropriate GL expense account for automatic posting in the general ledger.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Multi-banner grocery operators maintain entity-specific item costs for intercompany transfer pricing and legal-entity-level COGS reporting. Each legal entity (banner/subsidiary) may have distinct nego',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotional event or campaign during which this promotional cost applies. Used to measure promotional lift and incremental margin impact.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this cost record applies. Links to the product master catalog.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier providing this item at the specified cost. Each SKU-vendor combination may have distinct cost structures.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Item costs in grocery retail are negotiated under specific trade agreements. AP and procurement teams must trace which trade agreement governs each item cost for contract compliance audits, cost varia',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: AP and buying teams run cost variance reconciliation reports comparing the retailers item_cost record against the vendors catalog cost in vendor_item. A direct FK enables this reconciliation without',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this cost record was approved. Part of the audit trail for cost change management and financial controls.',
    `base_unit_cost` DECIMAL(18,2) COMMENT 'The fundamental unit cost from the vendor before any allowances, discounts, or additional charges. This is the invoice line item cost per unit as stated by the supplier.',
    `billback_allowance` DECIMAL(18,2) COMMENT 'Post-invoice allowance claimed back from the vendor after the sale or promotion period. Requires submission of proof-of-performance documentation. Expressed in the same currency and unit basis as base cost.',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`drug_item` (
    `drug_item_id` BIGINT COMMENT 'Unique identifier for the pharmacy drug item record. Primary key for the drug item master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pharmacy drug items are allocated to pharmacy cost centers for drug cost tracking and formulary management. Grocery pharmacy operators require drug-item-level cost center assignment to track drug spen',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: drug_item is the retail product catalog entry; pharmacy.drug is the authoritative clinical dispensing record with NDC, formulary status, REMS indicator, DEA schedule, and AWP. Linking them enables for',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pharmacy drug items map to specific GL accounts for drug COGS, controlled substance inventory, and hazardous drug expense. Grocery pharmacy finance requires drug-item-level GL assignment for DEA-compl',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Pharmacy operations require direct linkage between drug items and their pharmaceutical distributor/manufacturer (McKesson, Cardinal Health) for DEA controlled substance reporting, FDA drug supply chai',
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
    `mckesson_drug_code` STRING COMMENT 'McKesson proprietary drug identifier used for ordering, inventory management, and integration with McKesson Pharmacy Systems drug database.',
    `multi_source_code` STRING COMMENT 'FDA Orange Book code indicating generic availability. Y = generic available, N = no generic available, O = original brand with generic equivalents.. Valid values are `Y|N|O`',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`product`.`item_vendor` (
    `item_vendor_id` BIGINT COMMENT 'Unique identifier for the item-vendor association record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor item costs and allowances post to GL accounts for AP accruals and COGS recording. Grocery retailers require GL-level item_vendor posting to support vendor invoice matching, billback allowance a',
    `product_item_id` BIGINT COMMENT 'Reference to the item (SKU) in this vendor relationship.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier providing this item.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: A supplier may have multiple sites (East/West DC, farm, co-manufacturer). The specific sourcing site determines lead time, cold chain capability, and freight cost for each item-vendor relationship. Gr',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Item-vendor sourcing terms (MOQ, lead time, cost) are governed by a specific trade agreement. Procurement and legal teams need to link item-vendor records to their governing contracts for renewal trac',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_drug_item_id` FOREIGN KEY (`drug_item_id`) REFERENCES `grocery_ecm`.`product`.`drug_item`(`drug_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_plu_code_id` FOREIGN KEY (`plu_code_id`) REFERENCES `grocery_ecm`.`product`.`plu_code`(`plu_code_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_upc_barcode_id` FOREIGN KEY (`upc_barcode_id`) REFERENCES `grocery_ecm`.`product`.`upc_barcode`(`upc_barcode_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_fulfillment_slot_id` FOREIGN KEY (`fulfillment_slot_id`) REFERENCES `grocery_ecm`.`product`.`fulfillment_slot`(`fulfillment_slot_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_order_fulfillment_id` FOREIGN KEY (`order_fulfillment_id`) REFERENCES `grocery_ecm`.`product`.`order_fulfillment`(`order_fulfillment_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_fulfillment_slot_id` FOREIGN KEY (`fulfillment_slot_id`) REFERENCES `grocery_ecm`.`product`.`fulfillment_slot`(`fulfillment_slot_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_order_fulfillment_id` FOREIGN KEY (`order_fulfillment_id`) REFERENCES `grocery_ecm`.`product`.`order_fulfillment`(`order_fulfillment_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_fulfillment_slot_id` FOREIGN KEY (`fulfillment_slot_id`) REFERENCES `grocery_ecm`.`product`.`fulfillment_slot`(`fulfillment_slot_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_drug_item_id` FOREIGN KEY (`drug_item_id`) REFERENCES `grocery_ecm`.`product`.`drug_item`(`drug_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_plu_code_id` FOREIGN KEY (`plu_code_id`) REFERENCES `grocery_ecm`.`product`.`plu_code`(`plu_code_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_private_label_id` FOREIGN KEY (`private_label_id`) REFERENCES `grocery_ecm`.`product`.`private_label`(`private_label_id`);
ALTER TABLE `grocery_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_parent_node_item_hierarchy_id` FOREIGN KEY (`parent_node_item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ADD CONSTRAINT `fk_product_upc_barcode_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ADD CONSTRAINT `fk_product_item_attribute_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ADD CONSTRAINT `fk_product_nutritional_info_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ADD CONSTRAINT `fk_product_allergen_declaration_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`private_label` ADD CONSTRAINT `fk_product_private_label_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ADD CONSTRAINT `fk_product_drug_item_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `grocery_ecm`.`product`.`order_header` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_header` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `ad_circular_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_header` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `drug_item_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `plu_code_id` SET TAGS ('dbx_business_glossary_term' = 'Plu Code Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `price_change_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `upc_barcode_id` SET TAGS ('dbx_business_glossary_term' = 'Upc Barcode Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `void_flag` SET TAGS ('dbx_business_glossary_term' = 'Void Flag');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `weight_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'lb|kg|oz|g');
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `order_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
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
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `contact_info_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Info Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `fulfillment_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Slot Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `order_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
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
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `pickup_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Appointment ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `fulfillment_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Slot Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `order_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Patient Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `service_capability_id` SET TAGS ('dbx_business_glossary_term' = 'Service Capability Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `order_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Wave ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `fulfillment_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Slot Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `mfc_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mfc Profile Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ALTER COLUMN `snap_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Amount');
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
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Gift Card Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Refunded Product Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Claim Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Customer ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `policy_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Exception Flag');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_channel` SET TAGS ('dbx_business_glossary_term' = 'Refund Channel');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_channel` SET TAGS ('dbx_value_regex' = 'pos|online|mobile_app|customer_service|pharmacy|curbside');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_denied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Denied Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ALTER COLUMN `refund_notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
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
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `drug_item_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `pharmacy_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Patient Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_number` SET TAGS ('dbx_business_glossary_term' = 'Fill Number');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_status` SET TAGS ('dbx_business_glossary_term' = 'Fill Status');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fill Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_type` SET TAGS ('dbx_business_glossary_term' = 'Fill Type');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `fill_type` SET TAGS ('dbx_value_regex' = 'new|refill|transfer_in|transfer_out|partial_fill');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `insurance_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Paid Amount');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `mckesson_rx_system_ref` SET TAGS ('dbx_business_glossary_term' = 'McKesson Pharmacy System Rx ID');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Expiration Date');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ALTER COLUMN `prescription_expiration_date` SET TAGS ('dbx_pii_health' = 'true');
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
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_item_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Substitute Item Stock Level');
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ALTER COLUMN `substitute_quantity` SET TAGS ('dbx_business_glossary_term' = 'Substitute Quantity');
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
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `fulfillment_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Slot ID');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `service_capability_id` SET TAGS ('dbx_business_glossary_term' = 'Service Capability Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`product_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`product_item` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item ID');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `plu_code_id` SET TAGS ('dbx_business_glossary_term' = 'Plu Code Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `private_label_id` SET TAGS ('dbx_business_glossary_term' = 'Private Label Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`product_item` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Supplier Site Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`product`.`sku` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy ID');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `upc_barcode_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC) Barcode ID');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`plu_code` SET TAGS ('dbx_subdomain' = 'item_catalog');
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
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `item_attribute_id` SET TAGS ('dbx_business_glossary_term' = 'Item Attribute Identifier');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ALTER COLUMN `nutritional_info_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Information ID');
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
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ALTER COLUMN `allergen_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration ID');
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
ALTER TABLE `grocery_ecm`.`product`.`private_label` SET TAGS ('dbx_subdomain' = 'brand_registry');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `private_label_id` SET TAGS ('dbx_business_glossary_term' = 'Private Label ID');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`private_label` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`brand` SET TAGS ('dbx_subdomain' = 'brand_registry');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Vendor Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_co_manufacturer_vendor_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Manufacturer Vendor Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `brand_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`brand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`item_cost` SET TAGS ('dbx_subdomain' = 'brand_registry');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `item_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Item Cost ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `cost_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Schedule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Event ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `base_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Cost');
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ALTER COLUMN `billback_allowance` SET TAGS ('dbx_business_glossary_term' = 'Billback Allowance');
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
ALTER TABLE `grocery_ecm`.`product`.`drug_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` SET TAGS ('dbx_subdomain' = 'brand_registry');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `drug_item_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Item ID');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Supplier Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `mckesson_drug_code` SET TAGS ('dbx_business_glossary_term' = 'McKesson Drug Code');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_business_glossary_term' = 'Multi-Source Code');
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_value_regex' = 'Y|N|O');
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
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` SET TAGS ('dbx_subdomain' = 'brand_registry');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `item_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Item Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
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
