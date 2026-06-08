-- Schema for Domain: returns | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`returns` COMMENT 'Manages reverse logistics, RMA/RTV processing, restocking workflows, disposition of returned merchandise, refund processing, and return reason analytics. Owns the complete returns lifecycle from customer initiation through final disposition including vendor returns and liquidation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`rma` (
    `rma_id` BIGINT COMMENT 'Primary key for rma',
    `exchange_order_id` BIGINT COMMENT 'Reference to the new order created for an exchange transaction, linking the return to the replacement order.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: RMAs must be associated with a financial period for return rate reporting, refund accrual recognition, and period-close financial statements. Retail finance teams use this for returns-as-percentage-of',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: RMAs must trace back to the specific fulfillment that generated the return for carrier performance analysis, fulfillment quality metrics by node/method, and root-cause analysis of returns. Essential f',
    `header_id` BIGINT COMMENT 'Reference to the original sales order from which the items are being returned.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: RMA processing triggers journal entries for inventory write-downs and refund liability accruals. Retail finance teams require RMA-to-journal-entry traceability for period-close reconciliation and audi',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_membership. Business justification: RMA processing requires the customers loyalty membership to reverse points earned on the returned purchase, apply tier-sensitive return policies, and flag return-abuse patterns against the loyalty pr',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to store.pos_terminal. Business justification: In-store return processing: RMAs initiated at a POS terminal require terminal-level audit trails for loss prevention, POS end-of-day reconciliation, and fraud detection. Retail operations teams routin',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: In-store return desk workflows require linking the RMA directly to the original POS transaction for receipt validation, return policy enforcement, and loss prevention auditing. Retail store associates',
    `profile_id` BIGINT COMMENT 'Reference to the customer who is initiating the return.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: When a returned item was obtained via a loyalty redemption (free reward item), the RMA must reference the original redemption to trigger its reversal. Retail operations require this link for the retu',
    `location_id` BIGINT COMMENT 'Reference to the store or distribution center where the returned merchandise will be received and processed.',
    `service_case_id` BIGINT COMMENT 'Reference to the customer service case associated with this return, if the return was initiated through customer service interaction.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: An RMA is raised against a specific shipment. Multiple shipments can exist per fulfillment_order, so shipment-level linkage enables precise carrier return-rate analysis, SLA breach attribution, and sh',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: RMAs initiated via e-commerce channels must be attributed to the originating storefront for channel-level return rate reporting, return policy enforcement, and fraud analytics. rma.return_channel is a',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to order.subscription. Business justification: Subscription orders returned require the RMA linked to the subscription for auto-pause/cancellation logic, subscription return rate analytics, and churn management. Retail subscription operations team',
    `authorization_date` DATE COMMENT 'The date when the return merchandise authorization was approved and issued to the customer.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the RMA was authorized, capturing the exact moment of approval for audit and SLA tracking purposes.',
    `closed_date` DATE COMMENT 'The date when the RMA was closed and all return processing activities were completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the expected return value amount.. Valid values are `^[A-Z]{3}$`',
    `customer_comments` STRING COMMENT 'Free-text comments provided by the customer explaining the reason for return or providing additional details about the issue.',
    `disposition_code` STRING COMMENT 'Code indicating the final disposition of the returned merchandise: restock to inventory, liquidate through clearance channel, rework/refurbish, scrap/destroy, RTV (Return to Vendor), or donate to charity.. Valid values are `restock|liquidate|rework|scrap|rtv|donate`',
    `expected_return_value_amount` DECIMAL(18,2) COMMENT 'The total monetary value of merchandise expected to be returned under this RMA, calculated from the original order line items.',
    `expiry_date` DATE COMMENT 'The date by which the customer must return the merchandise. After this date, the RMA becomes invalid and the return may not be accepted.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the likelihood that this return is fraudulent, generated by fraud detection algorithms.',
    `inspection_date` DATE COMMENT 'The date when the returned merchandise was inspected to determine its condition and disposition.',
    `inspection_status` STRING COMMENT 'Result of the merchandise inspection indicating whether items meet return acceptance criteria.. Valid values are `pending|passed|failed|partial`',
    `is_fraudulent` BOOLEAN COMMENT 'Boolean flag indicating whether this return has been identified as potentially fraudulent based on fraud detection rules or manual review.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was last updated, used for audit trail and change tracking.',
    `priority_level` STRING COMMENT 'Processing priority assigned to this RMA based on customer tier, return value, or business rules.. Valid values are `low|normal|high|urgent`',
    `received_date` DATE COMMENT 'The date when the returned merchandise was physically received at the return location.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the returned merchandise was received, used for SLA tracking and operational metrics.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The actual refund amount to be issued to the customer after inspection and approval, which may differ from expected return value due to restocking fees or partial returns.',
    `refund_method` STRING COMMENT 'The method by which the refund is issued to the customer.. Valid values are `original_payment|store_credit|gift_card|check`',
    `refund_processed_date` DATE COMMENT 'The date when the refund payment was processed and issued to the customer.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing the return, typically applied to non-defective returns or opened merchandise.',
    `return_method` STRING COMMENT 'The logistics method by which the customer will return the merchandise (ship to distribution center, drop at store, carrier pickup from customer location, or direct return to vendor).. Valid values are `ship_to_dc|drop_at_store|carrier_pickup|vendor_direct`',
    `return_reason_code` STRING COMMENT 'Standardized code representing the primary reason for the return (e.g., defective, wrong item, size issue, customer remorse, damaged in transit).. Valid values are `^[A-Z]{3}[0-9]{3}$`',
    `return_reason_description` STRING COMMENT 'Detailed textual description of the reason for return, providing additional context beyond the standardized reason code.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost of shipping the returned merchandise back to the retailer, which may be borne by customer or retailer depending on return reason and policy.',
    `return_shipping_paid_by` STRING COMMENT 'Indicates which party is responsible for paying the return shipping cost.. Valid values are `customer|retailer|vendor`',
    `return_type` STRING COMMENT 'The type of resolution requested or authorized for this return: full refund to original payment method, exchange for different item, store credit, or replacement of defective item.. Valid values are `refund|exchange|store_credit|replacement`',
    `rma_number` STRING COMMENT 'Externally-visible unique business identifier for the return authorization issued to the customer. Used in customer communications and tracking.. Valid values are `^RMA[0-9]{10}$`',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA. Tracks progression from initial request through final disposition. [ENUM-REF-CANDIDATE: pending|authorized|received|inspected|approved|denied|closed|cancelled|expired — 9 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The operational system that originated this RMA record (e.g., Salesforce Service Cloud, Oracle Retail, Store POS system).',
    `store_credit_issued_amount` DECIMAL(18,2) COMMENT 'The amount of store credit issued to the customer as part of the return resolution.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Merchandise Authorization master record representing the formal authorization issued to a customer to return one or more items. Captures the RMA number, originating order reference, customer identity, return channel (in-store, online, BOPIS), authorization date, expiry date, return reason code, return type (refund, exchange, store credit), total expected return value, and current RMA status (pending, authorized, received, closed, denied). Primary master entity for the returns domain and the anchor for all downstream return processing workflows.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`rma_line` (
    `rma_line_id` BIGINT COMMENT 'Primary key for rma_line',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to inventory.adjustment. Business justification: Each RMA line resulting in a restock or write-off generates an inventory adjustment. Linking rma_line to adjustment enables end-to-end traceability from customer return line to inventory correction — ',
    `buying_order_line_id` BIGINT COMMENT 'Foreign key linking to merchandising.buying_order_line. Business justification: Enables vendor quality scorecarding and defect-driven cost recovery. Retail operations track defective returns back to the original buying order (not just customer order) to support vendor chargebacks',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Returns processing requires original landed cost for refund calculations, margin impact analysis, vendor credit determination (RTV), and financial reconciliation. Core operational link between returns',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Returns processing at DC facilities requires tracking which DC received and inspected returned items for disposition routing, inventory restocking, and warehouse operations. Essential for RTV shipment',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Department-level return rate analysis drives vendor chargeback decisions, markdown planning, and shrinkage reporting. Retail merchandising and buying teams require return line items attributed to a de',
    `fulfillment_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_line. Business justification: Line-level traceability from return to original fulfillment line enables picker/packer quality scoring, defect tracking by associate, lot/serial reconciliation for recalls, and substitution error anal',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_receipt. Business justification: Connects returned item to original receipt for cost basis validation, vendor chargeback processing, and defect tracking to specific inbound shipments. Critical for vendor performance management and qu',
    `header_id` BIGINT COMMENT 'Reference to the original sales order from which this item is being returned. Links the return to the originating transaction.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Lot-tracked returns (food, pharma, cosmetics) require linking to original lot for recall traceability, FEFO compliance, and quality root-cause analysis. Regulatory requirement for perishable goods. En',
    `order_line_id` BIGINT COMMENT 'Reference to the specific line item on the original sales order. Enables precise traceability from return to original purchase.',
    `pos_transaction_line_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction_line. Business justification: In-store returns require line-level reference to the original POS transaction line for unit price validation, tax recalculation, and return policy enforcement per item. rma_line has original_order_lin',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: rma_line.unit_retail_price is denormalized from sku_price. Retail returns processing and refund calculation require the authoritative sku_price record for the original selling price to validate refund',
    `rma_id` BIGINT COMMENT 'Foreign key reference to the parent RMA header. Links this line item to the overall return authorization.',
    `rtv_request_id` BIGINT COMMENT 'Foreign key linking to supplier.rtv_request. Business justification: rma_line.rtv_authorization_number is a denormalized string reference to rtv_request. Replacing it with a proper FK enables line-level RTV-to-return reconciliation, vendor credit audit trails, and char',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Return lines must reference the product SKU being returned. The product_description column becomes redundant as it can be joined from product.sku. This links returns processing to the product catalog.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: When an RMA line is processed, the returned SKU must be traced to the originating or destination stock position — especially for VMI, serialized, or lot-controlled items — to update available inventor',
    `vendor_id` BIGINT COMMENT 'Supplier identifier for the vendor who originally supplied this product. Used when disposition is Return to Vendor (RTV).',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: Return line processing requires vendor item record to validate unit_cost, RTV eligibility (dsd_eligible_flag), and pack configuration for credit memo calculation. A retail AP team reconciling vendor c',
    `vendor_promo_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_promo_agreement. Business justification: When a vendor-funded promoted item is returned, the rma_line must reference the vendor_promo_agreement to calculate vendor chargeback credits and recover vendor funding. Retail accounts payable and ve',
    `warehouse_zone_id` BIGINT COMMENT 'Foreign key linking to supplychain.warehouse_zone. Business justification: rma_line.warehouse_location_code is a denormalized warehouse zone reference. Linking rma_line to warehouse_zone enables DC returns processing reports showing which zones handle which return types, sup',
    `condition_code` STRING COMMENT 'Physical condition of the item upon receipt at the returns facility. Determines restocking eligibility and disposition path.. Valid values are `NEW|OPENED|DAMAGED|DEFECTIVE|MISSING_PARTS|EXPIRED`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RMA line record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Ensures proper currency handling in multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `disposition_code` STRING COMMENT 'Final disposition instruction for the returned merchandise. Determines the next step in the reverse logistics workflow (restock to inventory, return to vendor, liquidate, destroy, repair, or donate).. Valid values are `RESTOCK|RTV|LIQUIDATE|DESTROY|REPAIR|DONATE`',
    `extended_cost_amount` DECIMAL(18,2) COMMENT 'Total cost value for this line (quantity × unit cost). Used for inventory and cost of goods sold adjustments.',
    `extended_retail_amount` DECIMAL(18,2) COMMENT 'Total retail value for this line (quantity × unit retail price). Represents the total refund exposure for this line item.',
    `gtin` STRING COMMENT '14-digit Global Trade Item Number for the returned product. International standard for product identification across supply chains.. Valid values are `^[0-9]{14}$`',
    `inspection_date` DATE COMMENT 'Date when the returned item was physically inspected and condition assessed. Key milestone in the returns processing workflow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this RMA line record was last updated. Audit trail for tracking changes to return line details.',
    `line_number` STRING COMMENT 'Sequential line number within the RMA. Determines the ordering and position of this item in the multi-item return authorization.',
    `line_status` STRING COMMENT 'Current processing status of this RMA line item. Tracks the line through the returns workflow from authorization through final disposition. [ENUM-REF-CANDIDATE: AUTHORIZED|RECEIVED|INSPECTED|PROCESSED|RESTOCKED|COMPLETED|CANCELLED — 7 candidates stripped; promote to reference product]',
    `liquidation_sale_amount` DECIMAL(18,2) COMMENT 'Amount recovered from selling the returned item through liquidation channels (discount outlets, third-party liquidators, online auctions). Used to calculate net return loss.',
    `quantity_authorized` STRING COMMENT 'Number of units authorized for return on this RMA line. Represents the maximum quantity the customer is permitted to return.',
    `quantity_received` STRING COMMENT 'Actual number of units physically received back from the customer for this line item. May differ from quantity authorized.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Actual amount refunded to the customer for this line item. May differ from extended retail amount due to restocking fees, partial returns, or prorated refunds.',
    `restocking_eligible_flag` BOOLEAN COMMENT 'Indicates whether the returned item is in suitable condition to be restocked and resold. True if item can return to sellable inventory.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing the return of this line item. May be waived based on return reason or customer status.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why the customer is returning this item. Used for root cause analysis and quality improvement initiatives. [ENUM-REF-CANDIDATE: DEFECTIVE|DAMAGED|WRONG_ITEM|NOT_AS_DESCRIBED|CHANGED_MIND|SIZE_FIT|DUPLICATE_ORDER|LATE_DELIVERY|OTHER — 9 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Free-text explanation of the return reason provided by the customer or service representative. Provides additional context beyond the standardized code.',
    `sku` STRING COMMENT 'Internal stock keeping unit identifier for the product being returned. Used for inventory tracking and product identification.. Valid values are `^[A-Z0-9]{6,20}$`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost of goods sold per unit. Used for inventory valuation adjustments and margin analysis on returned merchandise.',
    `upc` STRING COMMENT '12-digit Universal Product Code for the returned item. Standard barcode identifier used in North American retail.. Valid values are `^[0-9]{12}$`',
    `vendor_credit_amount` DECIMAL(18,2) COMMENT 'Credit amount expected or received from the vendor for this returned item. Used in accounts payable adjustments and vendor chargeback reconciliation.',
    CONSTRAINT pk_rma_line PRIMARY KEY(`rma_line_id`)
) COMMENT 'Individual line-item detail within an RMA, representing a single SKU being returned. Captures the SKU, UPC, GTIN, product description, quantity authorized versus quantity received, unit retail price, unit cost, return reason at the line level, condition code upon receipt (new, opened, damaged, defective), restocking eligibility flag, and disposition instruction. Enables granular tracking of each item in a multi-item return authorization.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`return_request` (
    `return_request_id` BIGINT COMMENT 'Unique identifier for the return request. Primary key for the return request entity.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Return requests reference specific fulfillment to identify shipping damage, wrong item picked, or carrier issues during pre-authorization. Enables fraud detection based on fulfillment method patterns ',
    `header_id` BIGINT COMMENT 'Identifier of the original order from which items are being returned.',
    `location_id` BIGINT COMMENT 'Identifier of the store location where the customer intends to return the items, if in-store return method is selected.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_membership. Business justification: Return eligibility decisions depend on loyalty tier (VIP members get extended windows, waived fees). Linking return_request to loyalty_membership at request time enables tier-based policy application ',
    `address_id` BIGINT COMMENT 'Identifier of the address from which the return items should be picked up, if pickup was requested.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who initiated the return request.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: At return request intake, the system must validate whether the original purchase was under a final-sale or restricted promo_offer. Customer service and automated return portals depend on this link to ',
    `return_policy_id` BIGINT COMMENT 'Foreign key linking to returns.return_policy. Business justification: return_request.return_policy_code is a denormalized STRING reference to the governing return policy. Adding return_policy_id as a proper FK to return_policy normalizes this relationship, enabling JOIN',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Return request is the customer-initiated intent to return merchandise before formal RMA authorization. Once approved, a return_request results in an RMA (formal authorization). Currently, return_reque',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Return eligibility validation requires the originating shipments delivery date and carrier confirmation. Linking return_request to shipment enables return window SLA calculation and carrier-level ret',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Return requests submitted through the e-commerce portal must be attributed to the specific storefront for channel return rate KPIs, SLA enforcement, and return policy lookup. return_request.request_ch',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the return request was approved, triggering the generation of an RMA (Return Merchandise Authorization).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated refund amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_contact_email` STRING COMMENT 'Email address provided by the customer for communication regarding this return request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_contact_phone` STRING COMMENT 'Phone number provided by the customer for communication regarding this return request.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for denial if the return request was rejected (e.g., outside return window, final sale item, missing proof of purchase, item condition not acceptable).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `denial_reason_description` STRING COMMENT 'Detailed explanation provided to the customer explaining why the return request was denied.',
    `denial_timestamp` TIMESTAMP COMMENT 'Date and time when the return request was denied, if applicable.',
    `estimated_refund_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the refund if the return request is approved, calculated based on original purchase price and applicable return policy rules.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this return request has been flagged for potential fraud and requires additional verification before approval.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score (0-100) indicating the likelihood that this return request is fraudulent, based on customer history, return patterns, and fraud detection algorithms.',
    `is_within_return_window` BOOLEAN COMMENT 'Boolean flag indicating whether the return request was submitted within the eligible return window defined by the applicable return policy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this return request record was last modified.',
    `original_purchase_date` DATE COMMENT 'Date when the original order was placed, used to validate return eligibility against return window policies.',
    `pickup_requested_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has requested carrier pickup of the return items from their location.',
    `preferred_resolution_type` STRING COMMENT 'Customer-indicated preference for how they would like the return to be resolved (refund to original payment method, exchange for different item, store credit, or replacement of same item).. Valid values are `refund|exchange|store_credit|replacement`',
    `priority_level` STRING COMMENT 'Priority classification for processing this return request, typically based on customer tier, order value, or issue severity.. Valid values are `standard|high|urgent`',
    `request_number` STRING COMMENT 'Human-readable business identifier for the return request, typically displayed to customers and service representatives. Format: RR followed by 10 digits.. Valid values are `^RR[0-9]{10}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the return request in the approval workflow.. Valid values are `submitted|under_review|approved|denied|cancelled|expired`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the customer initiated the return request. Represents the principal business event timestamp for this transaction.',
    `return_method` STRING COMMENT 'Method by which the customer will return the merchandise (carrier pickup, drop-off at designated location, in-store return, mail).. Valid values are `carrier_pickup|drop_off|in_store|mail`',
    `return_reason_code` STRING COMMENT 'Standardized code representing the customer-stated reason for the return (e.g., defective, wrong item, size issue, changed mind, damaged in transit).. Valid values are `^[A-Z0-9]{2,10}$`',
    `return_reason_description` STRING COMMENT 'Detailed free-text description provided by the customer explaining the reason for the return.',
    `return_window_expiry_date` DATE COMMENT 'Last date by which the return request must be submitted to be eligible under the applicable return policy (typically 30, 60, or 90 days from purchase).',
    `review_notes` STRING COMMENT 'Internal notes added by the returns specialist during the review process, documenting decision rationale, policy exceptions, or special handling instructions.',
    `sla_response_due_timestamp` TIMESTAMP COMMENT 'Target date and time by which the return request must be reviewed and responded to, based on applicable SLA (Service Level Agreement) commitments.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this return request originated (e.g., Salesforce Service Cloud, e-commerce platform, store POS system).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `total_items_requested` STRING COMMENT 'Total count of distinct line items included in this return request.',
    `total_quantity_requested` STRING COMMENT 'Total quantity of units across all line items requested for return.',
    CONSTRAINT pk_return_request PRIMARY KEY(`return_request_id`)
) COMMENT 'Customer-initiated return request capturing the initial intent to return merchandise before formal RMA authorization. Records the request channel (e-commerce portal, store associate, call center), request timestamp, customer-stated reason, items and quantities requested for return, preferred resolution type (refund, exchange, store credit), and request status (submitted, under review, approved, denied). Serves as the intake record that triggers the RMA authorization workflow.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`return_receipt` (
    `return_receipt_id` BIGINT COMMENT 'Unique identifier for the return receipt record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the shipping carrier that delivered the returned merchandise. Applicable for mail-in and shipped returns.',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Return receipts at DC facilities (vs store locations) require facility tracking for receiving dock scheduling, inspection workflow routing, quality hold processing, and disposition decision execution.',
    `fulfillment_node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_node. Business justification: Returns are physically received at a fulfillment node (DC or ship-from-store node). return_receipt has receiving_location_id → store.location but no fulfillment_node link. Node-level return volume rep',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Return receipts must link to original fulfillment for closed-loop cycle time analysis (order→fulfill→return→receipt), reverse logistics SLA measurement, and carrier damage claim validation. Enables co',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_receipt. Business justification: Links return receipt to original inbound receipt for discrepancy analysis, vendor performance scoring, and cost basis validation. Retail operations use this for vendor chargeback processing and qualit',
    `header_id` BIGINT COMMENT 'Identifier of the original sales order from which the returned merchandise originated. Links return to original transaction.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Returned perishable or serialized items received at a DC must be assigned to a lot for quality control, expiry tracking, and FEFO compliance. return_receipt currently has no lot FK; this link is neede',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who initiated the return. Used for return analytics, fraud detection, and customer service.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Returned goods received in-store are routed to a specific department (e.g., customer service, receiving dock). Department-level return volume reporting drives staffing decisions and shrinkage rate cal',
    `receiving_event_id` BIGINT COMMENT 'Foreign key linking to supplychain.receiving_event. Business justification: When returned goods arrive at a DC, the WMS generates a receiving_event to track physical receipt. Linking return_receipt to receiving_event is the standard integration point between the returns manag',
    `location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro-fulfillment center where the returned merchandise was received.',
    `rma_id` BIGINT COMMENT 'Reference to the RMA that authorized this return. Links the physical receipt event to the return authorization.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Return receipts are triggered by a specific outbound shipment. Retailers track which shipment generated the return for carrier return-rate reporting, shipment-level return analytics, and carrier charg',
    `stock_ledger_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_ledger. Business justification: When a return is physically received at a DC or store, a stock ledger entry is posted to record the inbound inventory movement. Linking return_receipt to stock_ledger supports financial reconciliation',
    `authorized_quantity` DECIMAL(18,2) COMMENT 'Total quantity of items authorized for return in the original RMA. Used to detect over-returns and under-returns.',
    `carrier_tracking_number` STRING COMMENT 'Tracking number from the shipping carrier for mail-in or shipped returns. Used to reconcile carrier delivery events with physical receipt.',
    `condition_assessment` STRING COMMENT 'Assessment of the physical condition of the returned merchandise at the time of receipt. Drives disposition decision and restocking eligibility. [ENUM-REF-CANDIDATE: new_unopened|like_new|good|fair|poor|damaged|defective|unsellable — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return receipt record was first created in the data platform. Audit trail for data lineage.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was detected between authorized and received items. Triggers exception handling workflows.',
    `discrepancy_notes` STRING COMMENT 'Free-text notes describing the nature of the discrepancy. Provides context for exception resolution and audit trail.',
    `discrepancy_type` STRING COMMENT 'Classification of the discrepancy detected at receipt. Determines resolution workflow and financial adjustments.. Valid values are `over_return|under_return|wrong_item|damaged_in_transit|missing_components|no_discrepancy`',
    `disposition_recommendation` STRING COMMENT 'Recommended disposition action for the returned merchandise based on condition, value, and business rules. May be overridden by final disposition decision. [ENUM-REF-CANDIDATE: restock|liquidate|donate|destroy|rtv|repair|pending — 7 candidates stripped; promote to reference product]',
    `estimated_recovery_value` DECIMAL(18,2) COMMENT 'Estimated financial recovery value of the returned merchandise based on condition and disposition recommendation. Used for financial planning and shrinkage analysis.',
    `inspection_completed_timestamp` TIMESTAMP COMMENT 'Date and time when detailed quality inspection was completed. Null if inspection not required or not yet performed.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether detailed quality inspection is required before disposition. Triggered by high-value items, electronics, or condition concerns.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this return receipt record was last modified in the data platform. Audit trail for change tracking.',
    `packaging_condition` STRING COMMENT 'Condition of the product packaging at receipt. Impacts resale value and disposition options.. Valid values are `original_sealed|original_opened|repackaged|damaged|missing`',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the quantity fields. Ensures consistent interpretation of quantity values across different product types. [ENUM-REF-CANDIDATE: each|case|pallet|pound|kilogram|liter|gallon — 7 candidates stripped; promote to reference product]',
    `receipt_number` STRING COMMENT 'Business-facing unique receipt number generated when returned merchandise is physically received. Used for tracking and customer communication.. Valid values are `^RR[0-9]{10}$`',
    `receipt_source_system` STRING COMMENT 'Name of the operational system that captured the return receipt event. Supports data lineage and reconciliation.',
    `receipt_source_system_code` STRING COMMENT 'Unique identifier of this receipt record in the source operational system. Enables traceability and reconciliation.',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the return receipt. Tracks progression from initial receipt through inspection and final disposition decision.. Valid values are `received|inspected|discrepancy_flagged|accepted|rejected|pending_disposition`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the returned merchandise was physically received at the receiving location. Primary business event timestamp for the receipt.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of items physically received at the receiving location. Compared against authorized quantity to flag discrepancies.',
    `receiving_location_type` STRING COMMENT 'Type of facility that received the returned merchandise. Determines downstream processing workflows and disposition options.. Valid values are `store|dc|mfc|dark_store|vendor_location`',
    `recovery_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated recovery value. Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `refund_hold_reason` STRING COMMENT 'Reason why customer refund is being held pending resolution. Null or none if refund processed immediately upon receipt.. Valid values are `pending_inspection|discrepancy_review|fraud_review|policy_violation|none`',
    `refund_triggered_flag` BOOLEAN COMMENT 'Indicates whether the receipt event triggered a customer refund workflow. Links physical receipt to financial refund processing.',
    `restocking_eligible_flag` BOOLEAN COMMENT 'Indicates whether the returned merchandise is eligible for restocking and resale. Based on condition assessment and business rules.',
    `return_method` STRING COMMENT 'Method by which the customer returned the merchandise. Determines receipt workflow and processing requirements.. Valid values are `in_store|mail_in|drop_off|carrier_pickup|vendor_direct`',
    CONSTRAINT pk_return_receipt PRIMARY KEY(`return_receipt_id`)
) COMMENT 'Physical or digital receipt record generated when returned merchandise is received at a store, DC, or MFC. Captures the receiving location, receiving associate, receipt timestamp, carrier tracking number (for mail-in returns), actual items and quantities received versus authorized, condition assessment at receipt, discrepancy flags (over-return, under-return, wrong item), and receipt status. Links the physical goods receipt event to the RMA and triggers downstream disposition and refund workflows.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`disposition` (
    `disposition_id` BIGINT COMMENT 'Unique identifier for the disposition record. Primary key for the disposition entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Disposition handling costs (destruction fees, liquidation processing, refurbishment) are charged to cost centers. Retail operations track disposition costs by cost center for shrink budget management ',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Disposition decisions (restock vs liquidate vs RTV) require comparing estimated recovery value to original landed cost. Drives financial optimization of returned inventory. Removes denormalized origin',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Disposition decisions (restock/liquidate/RTV/scrap) execute at specific DC facilities. Tracking the facility is required for inventory movements, warehouse task generation, and GL posting. Replaces de',
    `vendor_id` BIGINT COMMENT 'Identifier of the third-party liquidation partner if disposition type is liquidation. Tracks which liquidator handled the item for recovery value reconciliation.',
    `disposition_vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom the item will be returned if disposition type is return_to_vendor. Used for vendor compliance and credit processing.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Disposition recovery values and inventory write-downs are recognized in specific financial periods. Retail finance requires period assignment for accurate inventory valuation, shrink reporting, and pe',
    `fulfillment_node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_node. Business justification: Disposition actions (restock, liquidate, destroy) are executed at a fulfillment node. Linking disposition to fulfillment_node enables node-level disposition reporting, capacity planning for returns pr',
    `stock_ledger_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_ledger. Business justification: Return dispositions (restock, liquidate, destroy) generate inventory transactions that should be tracked in the stock ledger. This links returns disposition decisions to inventory accounting. No visib',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Lot-tracked dispositions enable batch-level quality analysis, vendor chargeback validation, and compliance documentation for perishable/regulated goods. Retail operations require lot linkage for vendo',
    `rma_line_id` BIGINT COMMENT 'Reference to the specific return line item that this disposition decision applies to. Links disposition to the originating return merchandise authorization line.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Disposition processing (restock, liquidate, destroy, RTV) requires direct SKU reference for recovery value calculation, hazmat routing, and vendor return eligibility checks. Retail operations teams ru',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Disposition decisions (restock, liquidate, destroy) directly affect specific stock positions. Linking disposition to stock_position enables inventory planners to see which stock positions are impacted',
    `rtv_request_id` BIGINT COMMENT 'Foreign key linking to supplier.rtv_request. Business justification: Disposition decisions (restock/RTV/liquidate) directly trigger supplier RTV requests. Loss prevention teams measure recovery rates by linking disposition outcomes to vendor credit receipts. Enables cl',
    `actual_recovery_value` DECIMAL(18,2) COMMENT 'Realized financial recovery value after disposition execution. Populated after liquidation sale, vendor credit, or restock completion. Used for variance analysis against estimates.',
    `completion_date` DATE COMMENT 'Date when the disposition action was fully executed (item restocked, shipped to vendor, transferred to liquidator, or destroyed). Used for cycle time measurement.',
    `condition_grade` STRING COMMENT 'Quality assessment grade assigned during inspection. A=New/Unopened, B=Like New/Minor Packaging Damage, C=Good/Visible Wear, D=Fair/Functional Defects, F=Unsellable/Damaged. Drives disposition type and recovery value estimation.. Valid values are `A|B|C|D|F`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disposition record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for recovery value amounts. Supports multi-currency operations for global retail operations.. Valid values are `^[A-Z]{3}$`',
    `decision_date` DATE COMMENT 'The date when the disposition decision was made by the returns processing team or system. Key timestamp for cycle time analytics.',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the disposition decision was recorded in the system. Used for audit trail and process timing analysis.',
    `defect_code` STRING COMMENT 'Standardized code identifying the specific defect or damage type found during inspection. Used for quality analytics and vendor chargeback justification.. Valid values are `^[A-Z0-9]{2,6}$`',
    `disposition_status` STRING COMMENT 'Current lifecycle status of the disposition action. Tracks progress from decision through execution.. Valid values are `pending|approved|in_progress|completed|cancelled`',
    `disposition_type` STRING COMMENT 'The final fate decision for the returned item. Determines the next step in the reverse logistics workflow and impacts inventory valuation and recovery value.. Valid values are `restock_sellable|restock_clearance|return_to_vendor|liquidation|donation|destruction`',
    `estimated_recovery_value` DECIMAL(18,2) COMMENT 'Projected financial recovery value for the item based on disposition type and condition grade. Used for shrinkage forecasting and reverse logistics ROI analysis.',
    `inspection_date` DATE COMMENT 'Date when the returned item was physically inspected and condition grade was assigned. Precedes disposition decision date.',
    `is_hazmat` BOOLEAN COMMENT 'Flag indicating whether the returned item is classified as hazardous material requiring special disposition handling and compliance with EPA and DOT regulations.',
    `is_serialized` BOOLEAN COMMENT 'Flag indicating whether the item has a unique serial number requiring individual tracking through disposition process. Common for electronics and high-value goods.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this disposition record was last updated. Tracks changes to disposition decisions or status updates.',
    `notes` STRING COMMENT 'Free-text notes from the returns processor providing additional context about the disposition decision, item condition, or special handling requirements.',
    `quantity` STRING COMMENT 'Number of units of the SKU being dispositioned under this record. Typically 1 for individual item returns, may be greater for bulk returns.',
    `reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the disposition decision. Used for root cause analysis and process improvement.. Valid values are `^[A-Z0-9]{2,6}$`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of restocking fee charged if restocking_fee_applied is true. Contributes to reverse logistics cost recovery.',
    `restocking_fee_applied` BOOLEAN COMMENT 'Flag indicating whether a restocking fee was charged to the customer for this return. Impacts refund amount and customer satisfaction metrics.',
    `rma_number` STRING COMMENT 'The return merchandise authorization number associated with this disposition. Links to the customer-facing return authorization.. Valid values are `^RMA[0-9]{8,12}$`',
    `serial_number` STRING COMMENT 'Unique serial number of the returned item if is_serialized is true. Used for warranty tracking, theft prevention, and individual item lifecycle management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `source_system` STRING COMMENT 'Identifier of the operational system that created this disposition record. WMS=Manhattan WMS, OMS=Order Management System, RMS=Returns Management System, SFSC=Salesforce Service Cloud.. Valid values are `WMS|OMS|RMS|SFSC`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the disposition quantity. EA=Each, CS=Case, PK=Pack, BX=Box. Aligns with inventory management standards.. Valid values are `EA|CS|PK|BX`',
    CONSTRAINT pk_disposition PRIMARY KEY(`disposition_id`)
) COMMENT 'Disposition record governing the final fate of each returned item after receipt and inspection. Captures disposition type (restock to sellable inventory, restock to clearance, return to vendor via RTV, liquidation, donation, destruction/write-off), decision date, disposition location, responsible associate, estimated and actual recovery value, and disposition status. Central to reverse logistics cost recovery, shrinkage management, and inventory reintegration decisions. Now also carries condition grade assessment (A-New through F-Unsellable) previously in a separate reference table.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`refund` (
    `refund_id` BIGINT COMMENT 'Primary key for refund',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Refunds are applied against original AR invoices as credit memos. Retail AR teams require this link for revenue reversal, tax credit processing, and open-item clearing in accounts receivable aging rep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Refund processing costs (labor, payment processing fees, fraud review) are allocated to cost centers for departmental P&L and budget variance analysis. Essential for retail operations financial manage',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Refunds must be posted to a specific financial period for period-close revenue reversal and refund accrual reporting. Retail finance teams require this link for accurate period-end financial statement',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Refunds post directly to GL accounts for merchandise returns, tax adjustments, and restocking fees. Required for daily financial close, reconciliation, and audit trail. Replaces denormalized gl_accoun',
    `header_id` BIGINT COMMENT 'Reference to the original sales order that is being refunded. Enables traceability to the original purchase transaction.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Every refund generates a journal entry (debit refund liability, credit cash/AR). Retail finance requires refund-to-journal-entry linkage for period-close reconciliation, SOX audit trails, and refund a',
    `location_id` BIGINT COMMENT 'Reference to the retail store location where the refund was processed, if applicable. Used for store-level financial reconciliation and performance analysis.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_membership. Business justification: Refund processing must identify the loyalty membership to debit points earned on the original transaction. Retail loyalty programs require points reversal on refunds; this link drives the refund-trig',
    `markdown_event_id` BIGINT COMMENT 'Foreign key linking to merchandising.markdown_event. Business justification: Price protection refund process: when a markdown occurs post-purchase, customers request price adjustment refunds tied to that markdown event. Linking refund to markdown_event supports price protectio',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: Refund amounts are calculated from the original selling price. Retail finance reconciliation and refund audit processes require linking each refund to the authoritative sku_price record that was activ',
    `payment_id` BIGINT COMMENT 'Foreign key linking to order.payment. Business justification: Retail refund processing requires tracing back to the original payment instrument to execute the correct reversal (card credit, digital wallet, BNPL). Refund operations teams and finance reconciliatio',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to customer.payment_method. Business justification: Refund processing requires the original tokenized payment method to route funds back to the correct card/wallet/BNPL account. Payment processors need payment_method_id to execute refunds. Retail finan',
    `points_ledger_id` BIGINT COMMENT 'Foreign key linking to loyalty.points_ledger. Business justification: A refund event generates a points reversal entry in the points ledger. Linking refund to the specific points_ledger entry enables the loyalty liability reconciliation audit trail, required for finance',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to store.pos_terminal. Business justification: In-store refund issuance is tied to a specific POS terminal for POS end-of-day cash/tender balancing, PCI-DSS audit trails, and fraud detection. Retail loss prevention requires knowing which terminal ',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: In-store refunds issued at POS must reference the original POS transaction for daily cash drawer reconciliation, return receipt printing, and fraud detection. Retail store operations and end-of-day re',
    `price_override_id` BIGINT COMMENT 'Foreign key linking to pricing.price_override. Business justification: When the original sale had a POS price override, the refund must be computed against the overridden price, not the list price. Retail loss-prevention and finance audit processes require refunds to ref',
    `profile_id` BIGINT COMMENT 'Reference to the customer receiving the refund. Links refund to customer master data for reconciliation and customer lifetime value analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Refunds reduce profit center revenue and margin metrics. Required for accurate P&L reporting by channel, region, or store. Enables management reporting on return rates and profitability impact by busi',
    `promo_redemption_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_redemption. Business justification: Refund processing must reference original promotional redemption to calculate correct refund amount (excluding promotional discount), update vendor funding obligations, and enforce promotional terms. ',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: When a customer returns an item purchased with a loyalty redemption discount, the refund must reverse the redemption. This redemption reversal on refund workflow is a standard retail loyalty operati',
    `return_request_id` BIGINT COMMENT 'Reference to the parent return transaction that triggered this refund. Links refund to the originating return merchandise authorization (RMA).',
    `rma_id` BIGINT COMMENT 'FK to returns.rma.rma_id — Refund to RMA linkage is required for return financial reconciliation — every refund must trace back to its authorizing RMA for audit and financial controls.',
    `tax_posting_id` BIGINT COMMENT 'Foreign key linking to finance.tax_posting. Business justification: Refunds generate tax reversals recorded as tax postings. Retail tax compliance requires linking refunds to their tax_posting records for sales tax return filings, nexus reporting, and tax audit defens',
    `actual_settlement_date` DATE COMMENT 'Actual date when the refund funds were confirmed as settled and available to the customer. Used for SLA compliance measurement and financial reconciliation. Format: yyyy-MM-dd.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional positive or negative adjustment applied to the refund for reasons such as damage, missing components, promotional credits, or goodwill gestures.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was approved by authorized personnel or automated business rules. Represents authorization milestone in the refund workflow. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `authorization_code` STRING COMMENT 'Unique authorization or approval code issued by the payment processor confirming the refund transaction was approved. Used for audit trail and dispute resolution.',
    `channel` STRING COMMENT 'The customer-facing channel or touchpoint through which the refund was initiated and processed. Enables omnichannel analytics and channel performance measurement.. Valid values are `store|online|mobile_app|call_center|kiosk`',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was successfully completed and funds were transferred to the customer. Represents final settlement of the refund transaction. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this refund record was first created in the database. Used for data lineage and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this refund transaction. Ensures proper financial reconciliation in multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `expected_settlement_date` DATE COMMENT 'Anticipated date when the refund funds will be available to the customer in their account. Used for customer communication and service level agreement (SLA) tracking. Format: yyyy-MM-dd.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical fraud risk score assigned by fraud detection system, typically ranging from 0 to 100. Higher scores indicate higher fraud risk. Used for risk-based decisioning.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the refund transaction was first created or initiated in the system. Marks the beginning of the refund lifecycle. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `is_fraudulent` BOOLEAN COMMENT 'Boolean flag indicating whether the refund was identified as fraudulent or suspicious. Used for fraud analytics and loss prevention reporting.',
    `merchandise_amount` DECIMAL(18,2) COMMENT 'The gross value of returned merchandise being refunded, before any fees, taxes, or adjustments. Represents the base product value from the original transaction.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by customer service representatives or system users providing additional context about the refund transaction.',
    `payment_processor` STRING COMMENT 'Name of the payment gateway or financial institution processing the refund transaction. Used for reconciliation and troubleshooting payment failures.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was submitted to the payment processor for execution. Indicates when the financial transaction was initiated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `processor_response_code` STRING COMMENT 'Standardized response code returned by the payment processor indicating success, failure, or specific error condition. Used for operational monitoring and troubleshooting.',
    `processor_response_message` STRING COMMENT 'Human-readable message from the payment processor providing additional context about the transaction result. Used for customer service and technical support.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for issuing the refund. Used for root cause analysis, quality management, and vendor chargeback processing. Format: AAA999.. Valid values are `^[A-Z]{3}[0-9]{3}$`',
    `reason_description` STRING COMMENT 'Detailed textual explanation of why the refund was issued. Provides context beyond the standardized reason code for customer service and quality analysis.',
    `refund_method` STRING COMMENT 'The financial instrument or mechanism used to issue the refund to the customer. Determines processing workflow and reconciliation requirements.. Valid values are `original_payment|store_credit|gift_card|check|cash|bank_transfer`',
    `refund_number` STRING COMMENT 'Human-readable business identifier for the refund transaction. Used for customer communication, customer service lookup, and external reporting. Format: RFN-XXXXXXXXXX.. Valid values are `^RFN-[0-9]{10}$`',
    `refund_status` STRING COMMENT 'Current lifecycle status of the refund transaction. Tracks progression from initiation through final settlement or failure. Used for operational monitoring and customer service inquiries. [ENUM-REF-CANDIDATE: pending|approved|processing|completed|failed|reversed|cancelled — 7 candidates stripped; promote to reference product]',
    `refund_type` STRING COMMENT 'Classification of the refund based on the portion of the original transaction being refunded and any adjustments applied.. Valid values are `full|partial|restocking_adjusted|exchange_credit`',
    `restocking_fee` DECIMAL(18,2) COMMENT 'Fee deducted from the refund amount to cover costs of processing, inspecting, and restocking returned merchandise. Applied per return policy terms.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'The shipping or delivery fee amount being refunded, if applicable per return policy. May be zero if shipping is non-refundable.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The sales tax or value-added tax (VAT) amount being refunded to the customer. Must align with original tax calculation and jurisdiction requirements.',
    `total_refund_amount` DECIMAL(18,2) COMMENT 'The final net amount refunded to the customer after all fees, taxes, and adjustments. This is the actual monetary value transferred back to the customer.',
    `transaction_reference` STRING COMMENT 'External transaction identifier or reference number from the payment processor. Links internal refund record to external payment system for reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this refund record was last modified. Used for change tracking and data quality monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Financial refund transaction record representing the monetary reimbursement issued to a customer as resolution of a return. Captures refund method (original payment method, store credit, gift card, check), refund amount, restocking fee deducted, original transaction reference, refund authorization code, processing timestamp, refund status (pending, processed, failed, reversed), and payment processor response. Integrates with financial accounting for accounts payable and revenue reversal under ASC 606.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`exchange_order` (
    `exchange_order_id` BIGINT COMMENT 'Unique identifier for the exchange order. Primary key.',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the distribution center, store, or fulfillment location from which the replacement item will be shipped.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: An exchange order spawns a new fulfillment order for the replacement item. Linking exchange_order to the generated fulfillment_order enables end-to-end exchange tracking, fulfillment SLA monitoring, a',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Exchange orders with price differentials create journal entries for revenue adjustment and cost recognition. Retail finance requires this link for exchange transaction accounting, price differential r',
    `location_id` BIGINT COMMENT 'Reference to the retail store location where the exchange was initiated or will be fulfilled, if applicable.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_membership. Business justification: Exchange orders require loyalty membership to recalculate points: original item points may be reversed and replacement item points accrued. Retail loyalty programs track exchanges as distinct events a',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Exchange processing requires line-level reference to the original order line for price differential calculation, tax recalculation, and inventory allocation of the replacement item. exchange_order lin',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_order. Business justification: Exchange orders require DC fulfillment of replacement items via an outbound_order. Retail operations track exchange fulfillment through the WMS outbound order to manage DC pick/pack/ship for replaceme',
    `header_id` BIGINT COMMENT 'Reference to the original order from which the returned item originated.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who initiated the exchange.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Exchange orders for replacement items may apply an active promotional offer (e.g., upgrade exchange promotion). Retail operations teams need this link to apply correct pricing on replacement SKUs and ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Exchange fulfillment requires direct replacement SKU reference for inventory allocation, ATP (available-to-promise) checking, and like-for-like exchange policy enforcement. Essential for retail exchan',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: Exchange orders require the replacement SKUs current sku_price to compute the price differential the customer owes or is owed. price_differential_amount is denormalized from sku_price comparison. Ret',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: An exchange order generates an outbound shipment for the replacement item. Linking exchange_order to its fulfillment shipment enables exchange delivery tracking, carrier SLA compliance monitoring, and',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Exchange orders require a shipping address for replacement item delivery. Fulfillment operations depend on this link to route exchange shipments correctly. While exchange_order.profile_id provides ind',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Exchange orders originating from an e-commerce storefront require channel attribution for fulfillment routing, storefront-specific exchange policy enforcement, and channel profitability reporting. exc',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the exchange order record was first created in the system.',
    `exchange_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the exchange request was approved by the returns management system or customer service representative.',
    `exchange_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the entire exchange transaction was finalized, including receipt of returned item and delivery of replacement.',
    `exchange_delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the replacement item was successfully delivered to the customer.',
    `exchange_initiated_date` DATE COMMENT 'Date when the customer first requested the exchange, typically when the RMA was created.',
    `exchange_order_number` STRING COMMENT 'Human-readable business identifier for the exchange order, used for customer communication and tracking.. Valid values are `^EXO-[0-9]{10}$`',
    `exchange_order_status` STRING COMMENT 'Current lifecycle status of the exchange order in the fulfillment workflow. [ENUM-REF-CANDIDATE: pending|approved|processing|shipped|delivered|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `exchange_reason_code` STRING COMMENT 'Standardized code indicating the primary reason the customer requested an exchange rather than a refund.. Valid values are `wrong_size|wrong_color|defective|damaged|preference_change|other`',
    `exchange_reason_description` STRING COMMENT 'Free-text description providing additional context about why the customer requested an exchange.',
    `exchange_shipped_timestamp` TIMESTAMP COMMENT 'Date and time when the replacement item was shipped to the customer.',
    `exchange_type` STRING COMMENT 'Classification of the exchange based on the relationship between returned and replacement items.. Valid values are `same_sku|different_sku|upgrade|downgrade`',
    `expedited_shipping_flag` BOOLEAN COMMENT 'Indicates whether expedited shipping was used for the replacement item delivery.',
    `fulfillment_channel` STRING COMMENT 'Method by which the replacement item will be delivered to the customer.. Valid values are `ship_to_home|in_store_pickup|curbside_pickup|bopis|ropis`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the exchange order record was most recently modified.',
    `price_differential_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the price differential amount.. Valid values are `^[A-Z]{3}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount to be refunded to the customer if the replacement item costs less than the returned item (downgrade scenario).',
    `refund_method` STRING COMMENT 'Method by which any refund amount will be returned to the customer.. Valid values are `original_payment_method|store_credit|gift_card|check|bank_transfer`',
    `replacement_quantity` STRING COMMENT 'Number of units of the replacement SKU being sent to the customer.',
    `returned_quantity` STRING COMMENT 'Number of units of the returned SKU being sent back by the customer.',
    `returned_sku` STRING COMMENT 'SKU of the product being returned by the customer as part of the exchange.. Valid values are `^[A-Z0-9]{8,14}$`',
    `shipping_cost_waived_flag` BOOLEAN COMMENT 'Indicates whether shipping costs for the replacement item have been waived as a customer service gesture.',
    `special_instructions` STRING COMMENT 'Free-text field for any special handling instructions or notes related to the exchange order.',
    CONSTRAINT pk_exchange_order PRIMARY KEY(`exchange_order_id`)
) COMMENT 'Exchange order created when a return is resolved via product replacement rather than monetary refund. Captures the originating RMA reference, replacement SKU(s) and quantities, price differential (upgrade or downgrade), exchange order status, fulfillment channel (ship-to-home, in-store pickup, curbside), and the linked replacement order identifier. Enables tracking of exchange fulfillment as a distinct resolution path separate from standard order flow.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`return_policy` (
    `return_policy_id` BIGINT COMMENT 'Unique identifier for the return policy record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Return policies in retail are defined at the category level (e.g., electronics 15-day vs. apparel 30-day windows). Linking return_policy to merchandising.category enables category-level return rate re',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Retail return policies are differentiated by customer segment — VIP/loyalty tiers receive extended return windows and waived restocking fees. The existing plain-text customer_segment column is a den',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.format. Business justification: Return policies are differentiated by store format (hypermarket vs. discount outlet vs. e-commerce). Format-level policy assignment drives customer-facing return windows and accepted conditions. Retai',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Return policies vary by merchandise category (electronics 30-day vs apparel 90-day vs grocery no-return). Essential for POS policy enforcement, return window calculation, restocking fee application, a',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Return policies in retail are scoped to price lists — clearance price list items have restricted return windows or all sales final rules. Retail policy managers configure return_policy records tied ',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: Return policies can be scoped to a specific loyalty program (e.g., co-branded credit card program members have distinct return terms). Linking return_policy to loyalty_program enables program-specific',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Campaign-specific return policies (e.g., Black Friday extended 90-day return window, holiday no-receipt return policy) require return_policy to reference the governing promo_campaign. Retail policy ma',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Retail return policies are routinely differentiated by loyalty tier — Gold/Platinum members receive extended return windows and waived restocking fees. Linking return_policy to tier enables the system',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Return policies for vendor-supplied goods are governed by vendor contract terms (return windows, restocking fees, RTV eligibility). Compliance reporting and policy-vs-contract alignment audits require',
    `accepted_condition` STRING COMMENT 'Required condition of merchandise for return acceptance. Defines whether items must be unopened, unused, or can be returned in any condition.. Valid values are `unopened|unused_with_tags|gently_used|any_condition|defective_only`',
    `approval_required` BOOLEAN COMMENT 'Indicates whether returns under this policy require manager or supervisor approval before processing. Common for high-value items or out-of-window returns.',
    `created_by_user` STRING COMMENT 'User ID or system identifier of the person or process that created this return policy record. Used for audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return policy record was first created in the system. Used for audit trail and policy lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'Date when this return policy expires and is no longer applicable to new transactions. Nullable for open-ended policies.',
    `effective_start_date` DATE COMMENT 'Date when this return policy becomes active and applicable to transactions. Policies are not enforced before this date.',
    `exchange_allowed` BOOLEAN COMMENT 'Indicates whether direct product exchanges (size, color, model) are permitted under this policy without requiring a full return and repurchase.',
    `extended_window_days` STRING COMMENT 'Extended return window duration for premium loyalty tier members or special promotional periods. Nullable if no extension applies.',
    `holiday_extension_applicable` BOOLEAN COMMENT 'Indicates whether this policy includes extended return windows for holiday season purchases (e.g., purchases made in November-December returnable through mid-January).',
    `inspection_sla_hours` STRING COMMENT 'Target time in hours for completing merchandise inspection and condition assessment after return receipt. Used for operational SLA measurement.',
    `last_modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this return policy record. Used for audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this return policy record was last updated. Used for audit trail and change tracking.',
    `liquidation_eligible` BOOLEAN COMMENT 'Indicates whether returned merchandise under this policy can be sent to liquidation channels (discount outlets, bulk resellers) for recovery.',
    `non_returnable_item_exceptions` STRING COMMENT 'Comma-separated list of item types or SKU patterns that are explicitly excluded from returns under this policy (e.g., perishables, intimate apparel, custom orders, clearance items).',
    `original_packaging_required` BOOLEAN COMMENT 'Indicates whether the item must be returned in its original packaging for acceptance. Common for electronics and high-value items.',
    `policy_code` STRING COMMENT 'Business identifier for the return policy, used in operational systems and customer communications. Unique alphanumeric code.. Valid values are `^[A-Z0-9]{6,12}$`',
    `policy_description` STRING COMMENT 'Detailed text description of the return policy terms and conditions, including any special provisions, exclusions, or customer-facing language.',
    `policy_name` STRING COMMENT 'Human-readable name of the return policy (e.g., Standard 30-Day Return, Electronics Extended Return, Final Sale No Return).',
    `policy_type` STRING COMMENT 'Classification of the return policy indicating the policy category and applicability scope.. Valid values are `standard|extended|restricted|no_return|seasonal|promotional`',
    `policy_url` STRING COMMENT 'Web URL where the full return policy terms are published for customer reference. Required for e-commerce compliance.. Valid values are `^https?://.*$`',
    `priority_level` STRING COMMENT 'Priority level for processing returns under this policy. Premium and VIP customers may receive expedited processing.. Valid values are `standard|expedited|premium|vip`',
    `proof_of_purchase_required` BOOLEAN COMMENT 'Indicates whether proof of purchase (receipt, order confirmation, transaction lookup) is mandatory for return processing.',
    `refund_method` STRING COMMENT 'Method by which refunds are issued under this policy. May restrict refunds to store credit or exchange for certain categories or conditions.. Valid values are `original_payment|store_credit|exchange_only|gift_card`',
    `refund_processing_sla_hours` STRING COMMENT 'Target time in hours for completing refund processing from return acceptance to funds disbursement. Used for operational SLA measurement.',
    `restocking_fee_applicable` BOOLEAN COMMENT 'Indicates whether a restocking fee is charged for returns under this policy. Common for high-value electronics and special-order items.',
    `restocking_fee_flat_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount charged as a restocking fee, regardless of purchase price. Nullable if percentage-based or no fee applies.',
    `restocking_fee_percent` DECIMAL(18,2) COMMENT 'Percentage of the original purchase price charged as a restocking fee. Nullable if no restocking fee applies. Typical range is 10-25%.',
    `restocking_sla_hours` STRING COMMENT 'Target time in hours for restocking accepted returned merchandise back into available inventory. Used for operational SLA measurement.',
    `return_policy_status` STRING COMMENT 'Current lifecycle status of the return policy. Only active policies are applied to new transactions.. Valid values are `active|inactive|draft|expired|suspended`',
    `return_shipping_paid_by` STRING COMMENT 'Party responsible for paying return shipping costs. Retailer-paid shipping is common for defective items or retailer errors; customer-paid for buyer remorse.. Valid values are `customer|retailer|shared|not_applicable`',
    `return_window_days` STRING COMMENT 'Number of days from purchase date during which a return is accepted under this policy. Standard retail windows range from 14 to 90 days.',
    `rma_auto_approval_enabled` BOOLEAN COMMENT 'Indicates whether RMA requests are automatically approved based on policy rules without manual review. Drives automated return authorization logic.',
    `sales_channel` STRING COMMENT 'Sales channel(s) to which this return policy applies. Policies may vary by channel (e.g., online purchases may have different return windows than in-store). [ENUM-REF-CANDIDATE: in_store|online|mobile_app|bopis|ropis|call_center|all_channels — 7 candidates stripped; promote to reference product]',
    `store_credit_expiry_days` STRING COMMENT 'Number of days until store credit issued for returns expires. Nullable if store credit does not expire. Subject to state-specific gift card laws.',
    `vendor_return_eligible` BOOLEAN COMMENT 'Indicates whether merchandise returned under this policy is eligible for Return to Vendor (RTV) processing to recover costs from suppliers.',
    CONSTRAINT pk_return_policy PRIMARY KEY(`return_policy_id`)
) COMMENT 'Master record defining return policy rules by merchandise category, sales channel, and customer segment. Captures return window duration, restocking fee rules, accepted return conditions, proof-of-purchase requirements, non-returnable item exceptions, channel applicability (in-store, online, BOPIS), loyalty tier overrides (extended windows for premium members), SLA processing targets by return stage, and policy effective/expiry dates. Drives automated RMA authorization logic and operational SLA measurement.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`restock_event` (
    `restock_event_id` BIGINT COMMENT 'Unique identifier for the restock event. Primary key for this operational record capturing the restocking of a returned item back into sellable or clearance inventory.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to inventory.adjustment. Business justification: Restocking a returned item generates an inventory adjustment record to formally record the quantity change. Linking restock_event to adjustment provides end-to-end traceability from return event to in',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Restocking returned merchandise into DC inventory requires linking to the specific facility for putaway task routing, bin assignment, inventory ledger posting, and cycle count reconciliation. Critical',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Restocked returned items are placed back into a specific store department. Department-level inventory accuracy reporting, shrinkage rate tracking, and planogram compliance audits all require knowing w',
    `disposition_id` BIGINT COMMENT 'Reference to the disposition decision record that determined this item should be restocked. Links to the disposition workflow that evaluated the returned merchandise condition and routing.',
    `inventory_node_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_node. Business justification: Restock events occur at specific nodes (DC, store, warehouse). Essential for location-level inventory reconciliation, return processing KPIs by facility, and capacity planning. Retail operations track',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Restocking returned items triggers inventory adjustment journal entries. restock_event has inventory_adjustment_posted flag indicating a journal entry was created. Retail finance requires this link fo',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Returned perishable or serialized items restocked into inventory must be assigned to a specific lot for FEFO/expiry tracking and quality control. restock_event has a denormalized lot_number plain attr',
    `markdown_event_id` BIGINT COMMENT 'Foreign key linking to merchandising.markdown_event. Business justification: Return-to-shelf markdown workflow: restocked returned items require a markdown event to clear at reduced price. Retail operations teams link restock events to the governing markdown_event for margin i',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: Returned items restocked at reduced prices are governed by a markdown record. restock_event.markdown_amount and markdown_percentage are denormalized from the markdown entity. Retail markdown managemen',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Returned items restocked at a markdown are linked to a clearance or liquidation promo_offer that drives the markdown_amount and markdown_percentage. Retail merchandising and inventory teams use this l',
    `location_id` BIGINT COMMENT 'Reference to the specific store, distribution center, or fulfillment node where the item was restocked into inventory. Links to the location master data.',
    `rma_id` BIGINT COMMENT 'Reference to the originating return merchandise authorization that triggered this restock event. Links the restock back to the customer return or vendor return transaction.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Restock operations require SKU reference for inventory accuracy, markdown decision workflows, and return-to-stock cycle time measurement. Critical for retail inventory management, condition-based pric',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: When returned items are restocked for resale, the active sku_price record governs the resale price. Retail operations teams must link restock events to the applicable sku_price to ensure correct repri',
    `stock_ledger_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_ledger. Business justification: When a returned item is restocked, a stock ledger transaction is posted recording the inbound inventory movement. Linking restock_event to stock_ledger enables financial reconciliation of returned-goo',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Restocking returned merchandise updates specific inventory positions at bin/location level. Critical for real-time ATP calculation, inventory accuracy, and reconciling physical stock after return proc',
    `warehouse_zone_id` BIGINT COMMENT 'Foreign key linking to supplychain.warehouse_zone. Business justification: Returns-to-stock operations require linking each restock event to the specific DC warehouse zone where the item is placed. Retail WMS integration tracks zone assignment for returned goods putaway, ena',
    `aisle_number` STRING COMMENT 'The aisle identifier where the restocked item was placed on the sales floor or in the warehouse. Supports store operations and inventory locating.. Valid values are `^[A-Z0-9]{1,10}$`',
    `bin_location` STRING COMMENT 'The specific bin, shelf, or storage location identifier within the warehouse or store where the item was placed during restocking. Used for precise inventory tracking and picking operations.. Valid values are `^[A-Z0-9]{1,20}$`',
    `condition_grade` STRING COMMENT 'The assessed condition grade of the returned item at the time of restocking. Determines whether the item goes back to full-price inventory, clearance, or requires further disposition.. Valid values are `new|like_new|good|fair|damaged|defective`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this restock event record was first created in the data platform. Audit field for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this restock event. Supports multi-currency operations for international retail.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'The expiration or best-by date for perishable or time-sensitive products being restocked. Critical for food safety, pharmaceutical compliance, and inventory rotation (FIFO/FEFO).',
    `inspection_completed` BOOLEAN COMMENT 'Boolean flag indicating whether required quality inspection has been completed for the restocked item. True when inspection is finished and item is cleared for sale.',
    `inspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether the restocked item requires additional quality inspection before being made available for sale. True for items with condition concerns or regulatory requirements.',
    `inspection_timestamp` TIMESTAMP COMMENT 'The date and time when quality inspection was completed for the restocked item. Null if no inspection was required or inspection is still pending.',
    `inventory_adjustment_posted` BOOLEAN COMMENT 'Boolean flag indicating whether the inventory adjustment transaction has been successfully posted to the warehouse management system and inventory ledger. True when the on-hand quantity has been updated.',
    `inventory_adjustment_timestamp` TIMESTAMP COMMENT 'The date and time when the inventory adjustment transaction was posted to the WMS and inventory systems. May differ from restock_timestamp if there is a processing delay.',
    `inventory_status` STRING COMMENT 'The inventory status assigned to the restocked item. Determines whether the item is available for sale at full price, marked for clearance, held for inspection, or quarantined.. Valid values are `available|clearance|damaged|quarantine|hold`',
    `notes` STRING COMMENT 'Free-text notes or comments about the restock event. Captures special handling instructions, condition observations, or operational exceptions noted by the restocking associate.',
    `original_cost` DECIMAL(18,2) COMMENT 'The original cost of goods sold (COGS) for the restocked item. Used for inventory valuation and financial reconciliation of returned merchandise.',
    `quantity_restocked` DECIMAL(18,2) COMMENT 'The quantity of units restocked back into inventory in this event. Supports fractional quantities for items sold by weight or volume.',
    `restock_location_type` STRING COMMENT 'The type of facility where the item was restocked. Indicates whether restocking occurred at a retail store, distribution center (DC), micro-fulfillment center (MFC), dark store, or was returned to vendor.. Valid values are `store|dc|mfc|dark_store|vendor`',
    `restock_reason_code` STRING COMMENT 'The reason code explaining why this item was restocked. Distinguishes between customer returns that passed inspection, vendor returns, warranty exchanges, and other restock scenarios.. Valid values are `customer_return|vendor_return|quality_pass|warranty_return|overstock`',
    `restock_timestamp` TIMESTAMP COMMENT 'The date and time when the restocking action was completed and the item was placed back into available inventory. This is the principal business event timestamp for the restock transaction.',
    `restocked_value` DECIMAL(18,2) COMMENT 'The inventory value assigned to the restocked item after any markdown or condition adjustment. Represents the expected recoverable value of the returned merchandise.',
    `serial_number` STRING COMMENT 'The unique serial number for serialized items such as electronics, appliances, or high-value goods. Enables individual unit tracking and warranty management.. Valid values are `^[A-Z0-9]{1,30}$`',
    `shelf_position` STRING COMMENT 'The specific shelf or position identifier within the aisle where the item was restocked. Enables precise planogram compliance and inventory locating.. Valid values are `^[A-Z0-9]{1,10}$`',
    `source_system` STRING COMMENT 'The operational system that originated this restock event record. Identifies whether the event was captured by the warehouse management system (WMS), order management system (OMS), retail merchandising system (RMS), point of sale (POS), or entered manually.. Valid values are `wms|oms|rms|pos|manual`',
    `source_transaction_reference` STRING COMMENT 'The unique transaction identifier from the source system that generated this restock event. Enables traceability back to the originating system record for audit and reconciliation.. Valid values are `^[A-Z0-9]{1,50}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the restocked quantity. Defines whether the quantity represents individual units, cases, pallets, or weight/volume measures.. Valid values are `each|case|pallet|pound|kilogram|liter`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this restock event record was last modified in the data platform. Audit field for tracking record changes and data quality monitoring.',
    CONSTRAINT pk_restock_event PRIMARY KEY(`restock_event_id`)
) COMMENT 'Operational record capturing the restocking of a returned item back into sellable or clearance inventory. Records the SKU, quantity restocked, restocking location (store, DC, MFC), bin/shelf location, restocking timestamp, condition grade at restock, restocking associate, markdown applied (if any), and the originating RMA and disposition references. Triggers inventory adjustment transactions to update on-hand quantities in the warehouse management and inventory systems.';

CREATE OR REPLACE TABLE `retail_ecm`.`returns`.`store_credit` (
    `store_credit_id` BIGINT COMMENT 'Unique identifier for the store credit instrument. Primary key.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Store credit breakage and escheatment are recognized in specific financial periods per ASC 606. Retail finance requires period assignment for accurate deferred revenue reporting and unclaimed property',
    `header_id` BIGINT COMMENT 'Reference to the original order that was returned and resulted in this store credit issuance. Provides full traceability from purchase through return to credit.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Store credit issued by a specific e-commerce storefront carries channel-specific redemption restrictions (store_credit.redemption_channel_restriction). Linking to the issuing storefront enables channe',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Store credit issuance creates a journal entry (debit refund expense, credit store credit liability). Retail finance requires this link for breakage revenue recognition, escheatment compliance, and lia',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Store credits create deferred revenue liability requiring specific GL account tracking for balance sheet reporting, breakage estimation, and escheatment compliance. Replaces denormalized liability_acc',
    `location_id` BIGINT COMMENT 'Reference to the physical store location where the store credit was issued. Null for credits issued through digital channels.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_membership. Business justification: Store credit issued as return resolution is tied to a loyalty membership for redemption tracking, combinability rules with points, and loyalty liability accounting. Retail operations track store credi',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: Store credits issued as in-store return resolutions must link to the originating POS transaction for store-level liability tracking, fraud prevention, and audit compliance. Retail loss prevention and ',
    `profile_id` BIGINT COMMENT 'Reference to the customer to whom this store credit was issued. Enables customer-level credit balance tracking and redemption history.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Bonus store credit promotions (e.g., return and get 20% extra as store credit) require store_credit to reference the promo_offer that drove the bonus issuance. Retail loyalty and marketing teams tra',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: Store credit is frequently issued as fulfillment of a loyalty redemption (points redeemed for store credit voucher). Linking store_credit to the originating redemption tracks reward fulfillment status',
    `rma_id` BIGINT COMMENT 'Reference to the originating RMA that triggered this store credit issuance. Links the credit back to the return transaction.',
    `barcode` STRING COMMENT 'Machine-readable barcode representation of the store credit code for POS scanning. Supports omnichannel redemption workflows.',
    `breakage_estimate_applied_flag` BOOLEAN COMMENT 'Indicates whether a breakage revenue estimate (expected non-redemption) has been applied to this store credit for financial reporting purposes under ASC 606.',
    `combinable_with_promotions_flag` BOOLEAN COMMENT 'Indicates whether the store credit can be combined with other promotional discounts during redemption. Supports pricing and promotion policy enforcement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the store credit record was first created in the system. Supports audit trail and data lineage.',
    `credit_code` STRING COMMENT 'Externally-visible unique alphanumeric code printed on the store credit instrument or provided digitally. Used for redemption at POS or e-commerce checkout.. Valid values are `^[A-Z0-9]{10,20}$`',
    `credit_type` STRING COMMENT 'Classification of the reason or business context for issuing this store credit. Distinguishes between return-driven credits, promotional incentives, and service recovery gestures.. Valid values are `return_resolution|promotional|goodwill|price_adjustment|damaged_goods|service_recovery`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the store credit monetary values. Supports multi-currency retail operations.. Valid values are `^[A-Z]{3}$`',
    `escheatment_date` DATE COMMENT 'Calendar date on which the unredeemed balance must be reported and remitted to the state as unclaimed property. Null if not subject to escheatment.',
    `escheatment_eligible_flag` BOOLEAN COMMENT 'Indicates whether the unredeemed balance is subject to state escheatment (unclaimed property) laws. Supports regulatory compliance for abandoned store credits.',
    `expiration_date` DATE COMMENT 'Calendar date on which the store credit expires and can no longer be redeemed. Nullable for credits with no expiration policy.',
    `issue_date` DATE COMMENT 'Calendar date on which the store credit was issued to the customer. Marks the start of the credits validity period.',
    `issued_amount` DECIMAL(18,2) COMMENT 'Original monetary value of the store credit at the time of issuance. Represents the full stored-value balance before any redemptions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the store credit record was most recently updated. Supports audit trail and change tracking.',
    `last_redemption_date` DATE COMMENT 'Calendar date of the most recent partial or full redemption transaction. Null if the credit has never been redeemed.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or customer service notes related to the store credit issuance or redemption.',
    `pin_code` STRING COMMENT 'Optional security PIN required for redemption of the store credit. Protects against unauthorized use if the credit code is compromised.. Valid values are `^[0-9]{4,8}$`',
    `redemption_channel_restriction` STRING COMMENT 'Policy constraint on where the store credit can be redeemed. Supports business rules for channel-specific credits.. Valid values are `any|store_only|online_only|issuing_store_only`',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Current unredeemed monetary value available on the store credit. Decreases with each partial redemption until fully redeemed or expired.',
    `store_credit_status` STRING COMMENT 'Current lifecycle state of the store credit. Tracks progression from issuance through redemption, expiration, or voiding. [ENUM-REF-CANDIDATE: issued|active|partially_redeemed|fully_redeemed|expired|voided|suspended — 7 candidates stripped; promote to reference product]',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the store credit can be transferred or gifted to another customer. False means the credit is locked to the original recipient.',
    `void_date` DATE COMMENT 'Calendar date on which the store credit was voided. Null if the credit has not been voided.',
    `void_reason_code` STRING COMMENT 'Standardized code indicating the reason the store credit was voided. Null if the credit has not been voided.. Valid values are `fraud|duplicate_issuance|customer_request|system_error|policy_violation|expired_unused`',
    CONSTRAINT pk_store_credit PRIMARY KEY(`store_credit_id`)
) COMMENT 'Store credit instrument issued as return resolution in lieu of cash or card refund. Functions as a stored-value financial instrument with its own lifecycle: issuance, partial redemption, full redemption, expiration, or voiding. Captures credit code, issued and remaining balance, issue/expiry dates, issuing channel and location, customer and originating RMA references. Integrates with POS and e-commerce systems for omnichannel redemption.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_exchange_order_id` FOREIGN KEY (`exchange_order_id`) REFERENCES `retail_ecm`.`returns`.`exchange_order`(`exchange_order_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_rma_line_id` FOREIGN KEY (`rma_line_id`) REFERENCES `retail_ecm`.`returns`.`rma_line`(`rma_line_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_return_request_id` FOREIGN KEY (`return_request_id`) REFERENCES `retail_ecm`.`returns`.`return_request`(`return_request_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_disposition_id` FOREIGN KEY (`disposition_id`) REFERENCES `retail_ecm`.`returns`.`disposition`(`disposition_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`returns` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `retail_ecm`.`returns` SET TAGS ('dbx_domain' = 'returns');
ALTER TABLE `retail_ecm`.`returns`.`rma` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`returns`.`rma` SET TAGS ('dbx_subdomain' = 'return_authorization');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Identifier');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `exchange_order_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order ID');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Order ID');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Return Location ID');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `customer_comments` SET TAGS ('dbx_business_glossary_term' = 'Customer Comments');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'restock|liquidate|rework|scrap|rtv|donate');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `expected_return_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Value Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Expiry Date');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|partial');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Is Fraudulent Return Flag');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment|store_credit|gift_card|check');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `refund_processed_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Date');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'ship_to_dc|drop_at_store|carrier_pickup|vendor_direct');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_shipping_paid_by` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Paid By');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_shipping_paid_by` SET TAGS ('dbx_value_regex' = 'customer|retailer|vendor');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'refund|exchange|store_credit|replacement');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA[0-9]{10}$');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Status');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`returns`.`rma` ALTER COLUMN `store_credit_issued_amount` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Issued Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` SET TAGS ('dbx_subdomain' = 'return_authorization');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Line Identifier');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `buying_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Buying Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `fulfillment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order ID');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order Line ID');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `pos_transaction_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Pos Transaction Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Original Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `rtv_request_id` SET TAGS ('dbx_business_glossary_term' = 'Rtv Request Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promo Agreement Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `warehouse_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'NEW|OPENED|DAMAGED|DEFECTIVE|MISSING_PARTS|EXPIRED');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'RESTOCK|RTV|LIQUIDATE|DESTROY|REPAIR|DONATE');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `extended_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `extended_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `extended_retail_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Retail Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `liquidation_sale_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Sale Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `liquidation_sale_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `quantity_authorized` SET TAGS ('dbx_business_glossary_term' = 'Quantity Authorized');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `restocking_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Restocking Eligible Flag');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `vendor_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Credit Amount');
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ALTER COLUMN `vendor_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`returns`.`return_request` SET TAGS ('dbx_subdomain' = 'return_authorization');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_request_id` SET TAGS ('dbx_business_glossary_term' = 'Return Request ID');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Address ID');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email Address');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `denial_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Denial Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `estimated_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Refund Amount');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `is_within_return_window` SET TAGS ('dbx_business_glossary_term' = 'Is Within Return Window Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `original_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Original Purchase Date');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `pickup_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Pickup Requested Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `preferred_resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Resolution Type');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `preferred_resolution_type` SET TAGS ('dbx_value_regex' = 'refund|exchange|store_credit|replacement');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Return Request Number');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^RR[0-9]{10}$');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Return Request Status');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|denied|cancelled|expired');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Request Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'carrier_pickup|drop_off|in_store|mail');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `return_window_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Return Window Expiry Date');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `sla_response_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Due Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `total_items_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Items Requested for Return');
ALTER TABLE `retail_ecm`.`returns`.`return_request` ALTER COLUMN `total_quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Requested for Return');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` SET TAGS ('dbx_subdomain' = 'return_authorization');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `return_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt ID');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order ID');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receiving_event_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location ID');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `stock_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Return Quantity');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Condition Assessment');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'over_return|under_return|wrong_item|damaged_in_transit|missing_components|no_discrepancy');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `disposition_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Disposition Recommendation');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `estimated_recovery_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Recovery Value');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `estimated_recovery_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `inspection_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `packaging_condition` SET TAGS ('dbx_business_glossary_term' = 'Packaging Condition');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `packaging_condition` SET TAGS ('dbx_value_regex' = 'original_sealed|original_opened|repackaged|damaged|missing');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Number');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^RR[0-9]{10}$');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receipt_source_system` SET TAGS ('dbx_business_glossary_term' = 'Receipt Source System');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receipt_source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Receipt Source System ID');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Status');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'received|inspected|discrepancy_flagged|accepted|rejected|pending_disposition');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Return Quantity');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receiving_location_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Type');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `receiving_location_type` SET TAGS ('dbx_value_regex' = 'store|dc|mfc|dark_store|vendor_location');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `recovery_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Recovery Value Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `recovery_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `refund_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Hold Reason');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `refund_hold_reason` SET TAGS ('dbx_value_regex' = 'pending_inspection|discrepancy_review|fraud_review|policy_violation|none');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `refund_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Triggered Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `restocking_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Restocking Eligible Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method');
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'in_store|mail_in|drop_off|carrier_pickup|vendor_direct');
ALTER TABLE `retail_ecm`.`returns`.`disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`returns`.`disposition` SET TAGS ('dbx_subdomain' = 'merchandise_recovery');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Disposition ID');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Partner ID');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `disposition_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `stock_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Line ID');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `rtv_request_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Rtv Request Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `actual_recovery_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Recovery Value');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Completion Date');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision Date');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `defect_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|in_progress|completed|cancelled');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Type');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'restock_sellable|restock_clearance|return_to_vendor|liquidation|donation|destruction');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `estimated_recovery_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Recovery Value');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `is_serialized` SET TAGS ('dbx_business_glossary_term' = 'Is Serialized Item');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Disposition Quantity');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `restocking_fee_applied` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Applied');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA[0-9]{8,12}$');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WMS|OMS|RMS|SFSC');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `retail_ecm`.`returns`.`disposition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PK|BX');
ALTER TABLE `retail_ecm`.`returns`.`refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`returns`.`refund` SET TAGS ('dbx_subdomain' = 'customer_resolution');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Identifier');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order ID');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `markdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Original Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `price_override_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `return_request_id` SET TAGS ('dbx_business_glossary_term' = 'Return ID');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `actual_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Refund Channel');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'store|online|mobile_app|call_center|kiosk');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Completed Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `expected_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Settlement Date');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Initiated Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Is Fraudulent Flag');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `merchandise_amount` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Amount');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `processor_response_code` SET TAGS ('dbx_business_glossary_term' = 'Processor Response Code');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `processor_response_message` SET TAGS ('dbx_business_glossary_term' = 'Processor Response Message');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment|store_credit|gift_card|check|cash|bank_transfer');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_value_regex' = '^RFN-[0-9]{10}$');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'full|partial|restocking_adjusted|exchange_credit');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `restocking_fee` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Amount');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `total_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Refund Amount');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`refund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` SET TAGS ('dbx_subdomain' = 'customer_resolution');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_order_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order ID');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order ID');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Approved Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Completed Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Delivered Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Initiated Date');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_order_number` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order Number');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_order_number` SET TAGS ('dbx_value_regex' = '^EXO-[0-9]{10}$');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_order_status` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order Status');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_reason_code` SET TAGS ('dbx_value_regex' = 'wrong_size|wrong_color|defective|damaged|preference_change|other');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exchange Reason Description');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Shipped Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'same_sku|different_sku|upgrade|downgrade');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `expedited_shipping_flag` SET TAGS ('dbx_business_glossary_term' = 'Expedited Shipping Flag');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'ship_to_home|in_store_pickup|curbside_pickup|bopis|ropis');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `price_differential_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Differential Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `price_differential_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment_method|store_credit|gift_card|check|bank_transfer');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `replacement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replacement Quantity');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `returned_sku` SET TAGS ('dbx_business_glossary_term' = 'Returned Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `returned_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,14}$');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `shipping_cost_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Waived Flag');
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` SET TAGS ('dbx_subdomain' = 'merchandise_recovery');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `return_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Return Policy ID');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Format Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `accepted_condition` SET TAGS ('dbx_business_glossary_term' = 'Accepted Return Condition');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `accepted_condition` SET TAGS ('dbx_value_regex' = 'unopened|unused_with_tags|gently_used|any_condition|defective_only');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Required Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective End Date');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Start Date');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `exchange_allowed` SET TAGS ('dbx_business_glossary_term' = 'Exchange Allowed Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `extended_window_days` SET TAGS ('dbx_business_glossary_term' = 'Extended Return Window Duration in Days');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `holiday_extension_applicable` SET TAGS ('dbx_business_glossary_term' = 'Holiday Extension Applicable Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `inspection_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Return Inspection Service Level Agreement (SLA) in Hours');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `liquidation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Eligible Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `non_returnable_item_exceptions` SET TAGS ('dbx_business_glossary_term' = 'Non-Returnable Item Exceptions');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `original_packaging_required` SET TAGS ('dbx_business_glossary_term' = 'Original Packaging Required Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Code');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Description');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Name');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Type');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'standard|extended|restricted|no_return|seasonal|promotional');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_url` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Uniform Resource Locator (URL)');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `policy_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Return Processing Priority Level');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|premium|vip');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `proof_of_purchase_required` SET TAGS ('dbx_business_glossary_term' = 'Proof of Purchase Required Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment|store_credit|exchange_only|gift_card');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `refund_processing_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Refund Processing Service Level Agreement (SLA) in Hours');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `restocking_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Applicable Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `restocking_fee_flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Flat Amount');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `restocking_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Percentage');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `restocking_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Restocking Service Level Agreement (SLA) in Hours');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `return_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Status');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `return_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|expired|suspended');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `return_shipping_paid_by` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Paid By');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `return_shipping_paid_by` SET TAGS ('dbx_value_regex' = 'customer|retailer|shared|not_applicable');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Duration in Days');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `rma_auto_approval_enabled` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Auto-Approval Enabled Flag');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sales Channel');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `store_credit_expiry_days` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Expiry Duration in Days');
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ALTER COLUMN `vendor_return_eligible` SET TAGS ('dbx_business_glossary_term' = 'Vendor Return Eligible Flag');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` SET TAGS ('dbx_subdomain' = 'merchandise_recovery');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `restock_event_id` SET TAGS ('dbx_business_glossary_term' = 'Restock Event ID');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Disposition ID');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inventory_node_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `markdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Restock Location ID');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `stock_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `warehouse_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `aisle_number` SET TAGS ('dbx_business_glossary_term' = 'Aisle Number');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `aisle_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `bin_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'new|like_new|good|fair|damaged|defective');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inspection_completed` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inventory_adjustment_posted` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Posted');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inventory_adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|clearance|damaged|quarantine|hold');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Restock Notes');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `quantity_restocked` SET TAGS ('dbx_business_glossary_term' = 'Quantity Restocked');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `restock_location_type` SET TAGS ('dbx_business_glossary_term' = 'Restock Location Type');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `restock_location_type` SET TAGS ('dbx_value_regex' = 'store|dc|mfc|dark_store|vendor');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `restock_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Restock Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `restock_reason_code` SET TAGS ('dbx_value_regex' = 'customer_return|vendor_return|quality_pass|warranty_return|overstock');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `restock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restock Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `restocked_value` SET TAGS ('dbx_business_glossary_term' = 'Restocked Value');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,30}$');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `shelf_position` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `shelf_position` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'wms|oms|rms|pos|manual');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,50}$');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|pound|kilogram|liter');
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` SET TAGS ('dbx_subdomain' = 'customer_resolution');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `store_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Store Credit ID');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order ID');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Store ID');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `breakage_estimate_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakage Estimate Applied Flag');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `combinable_with_promotions_flag` SET TAGS ('dbx_business_glossary_term' = 'Combinable with Promotions Flag');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `credit_code` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Code');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `credit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Type');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'return_resolution|promotional|goodwill|price_adjustment|damaged_goods|service_recovery');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `escheatment_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Date');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `issued_amount` SET TAGS ('dbx_business_glossary_term' = 'Issued Amount');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `last_redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Redemption Date');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `pin_code` SET TAGS ('dbx_business_glossary_term' = 'Personal Identification Number (PIN) Code');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `pin_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `pin_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `redemption_channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel Restriction');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `redemption_channel_restriction` SET TAGS ('dbx_value_regex' = 'any|store_only|online_only|issuing_store_only');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `store_credit_status` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Status');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_value_regex' = 'fraud|duplicate_issuance|customer_request|system_error|policy_violation|expired_unused');
