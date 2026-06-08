-- Schema for Domain: fulfillment | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`fulfillment` COMMENT 'Manages pick-pack-ship operations, warehouse workflows, order allocation, packing slips, shipping labels, and fulfillment SLA tracking. Supports FBA-style fulfillment center operations, 3PL partner coordination, BOPIS orchestration, and proof-of-delivery records. Integrates with WMS and TMS for end-to-end fulfillment execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`center` (
    `center_id` BIGINT COMMENT 'Unique identifier for the fulfillment center. Primary key for the center entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maps each fulfillment center to its operational cost center, essential for budgeting, cost allocation, and expense tracking.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Default carrier per fulfillment center drives automated carrier selection in the Shipment Creation workflow.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to service.agent. Business justification: Each fulfillment center is overseen by a manager agent responsible for operations; linking enables manager‑level performance dashboards and incident escalation.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: 3PL-operated fulfillment centers must be linked to their supplier record for contract management, performance scoring, and invoice reconciliation. partner_operator_name is a denormalized text field th',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Fulfillment centers operate within geographic price zones that govern regional shipping rates and delivery cost structures. E-commerce domain experts expect each fulfillment center to be mapped to a p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fulfillment centers are managed as profit centers in e-commerce operations — each centers revenue, cost, and margin are tracked separately for management reporting. center has cost_center_id but no p',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contract. Business justification: Each 3PL-operated fulfillment center is governed by a specific vendor contract covering capacity commitments, service levels, and fees. Direct FK enables contract renewal tracking, expiry alerts, and ',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Maps each fulfillment center to its physical warehouse node, essential for inventory balance reports and location‑based replenishment.',
    `address_line_1` STRING COMMENT 'Primary street address line for the fulfillment center physical location, including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building, suite, or floor number.',
    `automation_level` STRING COMMENT 'Degree of automation in fulfillment operations: manual (human-driven), semi-automated (mix of manual and automated processes), fully automated (end-to-end automation), or robotic (advanced robotics and AI).. Valid values are `manual|semi_automated|fully_automated|robotic`',
    `available_capacity_units` BIGINT COMMENT 'Current available storage capacity in the fulfillment center, representing unused storage units available for new inventory allocation.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measurement used to quantify storage capacity: pallets, bins, cubic feet, cubic meters, square feet, or square meters.. Valid values are `pallets|bins|cubic_feet|cubic_meters|square_feet|square_meters`',
    `center_code` STRING COMMENT 'Externally-known unique alphanumeric code for the fulfillment center, used in operational systems and partner integrations.. Valid values are `^[A-Z0-9]{3,10}$`',
    `center_name` STRING COMMENT 'Human-readable name of the fulfillment center, used for display and reporting purposes.',
    `center_type` STRING COMMENT 'Classification of the fulfillment center based on operational model: FBA-style (Fulfillment By Amazon-style), 3PL (Third-Party Logistics), BOPIS (Buy Online Pick Up In Store) hub, dark store, micro-fulfillment center, or returns processing center.. Valid values are `fba_style|third_party_logistics|bopis_hub|dark_store|micro_fulfillment|returns_center`',
    `city` STRING COMMENT 'City or municipality where the fulfillment center is located.',
    `closed_date` DATE COMMENT 'Date when the fulfillment center ceased operations, applicable only if the center has been decommissioned or permanently closed.',
    `contact_email` STRING COMMENT 'Primary contact email address for the fulfillment center operations team, used for internal coordination and partner communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the fulfillment center operations team, used for internal coordination and partner communication.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the fulfillment center is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment center record was first created in the system, used for audit trail and data lineage tracking.',
    `cutoff_time_local` STRING COMMENT 'Daily cutoff time in local time zone (HH:MM format) by which orders must be received to qualify for same-day processing and shipment.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `daily_throughput_capacity` STRING COMMENT 'Maximum number of orders or units the fulfillment center can process per day under normal operating conditions, used for capacity planning and order allocation.',
    `erp_site_code` STRING COMMENT 'Site or plant code in the ERP system (e.g., SAP S/4HANA) that corresponds to this fulfillment center, used for financial and supply chain integration.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the fulfillment center location, used for distance calculations and route optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the fulfillment center location, used for distance calculations and route optimization.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or facility-specific information relevant to fulfillment operations.',
    `opened_date` DATE COMMENT 'Date when the fulfillment center commenced operations and began processing orders.',
    `operates_24_7` BOOLEAN COMMENT 'Boolean flag indicating whether the fulfillment center operates continuously (true) or has scheduled operating hours (false).',
    `operating_hours` STRING COMMENT 'Standard operating hours for the fulfillment center if not 24/7, formatted as day ranges and time ranges (e.g., Mon-Fri 08:00-18:00, Sat 09:00-15:00).',
    `operational_status` STRING COMMENT 'Current operational state of the fulfillment center in its lifecycle: active (fully operational), inactive (not processing orders), under construction (pre-launch), temporarily closed (planned downtime), decommissioned (permanently closed), or seasonal (operates during peak periods only).. Valid values are `active|inactive|under_construction|temporarily_closed|decommissioned|seasonal`',
    `ownership_model` STRING COMMENT 'Ownership and operational model of the fulfillment center: owned (company-owned and operated), leased (company-operated but leased facility), third-party operated (3PL partner), or hybrid (shared operations).. Valid values are `owned|leased|third_party_operated|hybrid`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the fulfillment center address, used for shipping and logistics routing.',
    `sla_tier` STRING COMMENT 'Service level tier assigned to this fulfillment center, defining performance commitments for order processing and delivery speed: premium (fastest), standard, economy, regional, express, or custom.. Valid values are `premium|standard|economy|regional|express|custom`',
    `standard_processing_time_hours` STRING COMMENT 'Standard time in hours from order receipt to shipment dispatch under normal operating conditions, used for SLA calculations and customer promise dates.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the fulfillment center is located.',
    `supported_fulfillment_methods` STRING COMMENT 'Comma-separated list of fulfillment methods supported by this center: standard_shipping, expedited_shipping, same_day_delivery, next_day_delivery, bopis, ship_from_store, white_glove, etc.',
    `supports_cold_storage` BOOLEAN COMMENT 'Boolean flag indicating whether the fulfillment center has refrigerated or frozen storage capabilities for temperature-sensitive products.',
    `supports_hazmat` BOOLEAN COMMENT 'Boolean flag indicating whether the fulfillment center is certified and equipped to handle hazardous materials shipments.',
    `supports_returns_processing` BOOLEAN COMMENT 'Boolean flag indicating whether the fulfillment center is equipped to receive, inspect, and process customer returns and RMA (Return Merchandise Authorization) requests.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the fulfillment center location, used for scheduling and SLA calculations.',
    `tms_integration_reference` STRING COMMENT 'External system identifier used to integrate with the Transportation Management System (TMS) for carrier selection and shipment tracking.',
    `total_capacity_units` BIGINT COMMENT 'Maximum storage capacity of the fulfillment center measured in storage units (pallets, bins, or cubic feet), representing the total inventory holding capacity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment center record was last modified, used for audit trail and change tracking.',
    `wms_integration_reference` STRING COMMENT 'External system identifier used to integrate with the WMS for real-time inventory synchronization and order orchestration.',
    `wms_system_name` STRING COMMENT 'Name of the Warehouse Management System (WMS) software deployed at this fulfillment center for inventory and operations management.',
    CONSTRAINT pk_center PRIMARY KEY(`center_id`)
) COMMENT 'Master record for each physical fulfillment center (FC) or warehouse node in the fulfillment network. Captures FC identity, type (FBA-style, 3PL, BOPIS hub, dark store), geographic location, operational capacity, supported fulfillment methods, WMS integration identifiers, and SLA tier assignments. SSOT for all warehouse facility master data within the fulfillment domain.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` (
    `fulfillment_order_id` BIGINT COMMENT 'Unique identifier for the fulfillment order. Primary key for the fulfillment order entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: B2B e-commerce fulfillment orders are placed against a customer account for credit limit validation, account-level order history, and B2B invoicing. A domain expert expects fulfillment_order to refere',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: AR is created upon fulfillment completion in e-commerce. Finance teams reconcile AR aging against fulfilled orders to confirm cash application. accounts_receivable.header_id links to order header, but',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle fulfillment is a distinct e-commerce process requiring kit assembly, multi-SKU picking coordination, and bundle-level SLA tracking. Operations teams need to identify which fulfillment orders ar',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for order‑to‑campaign ROI attribution report; e‑commerce analysts need to trace each fulfillment order back to the marketing campaign that generated it.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Order‑level carrier assignment is used in the Order Fulfillment Planning process and carrier performance dashboards.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Tracking the specific carrier service (e.g., Express, Ground) per order supports SLA compliance reporting and rate calculations.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.customer_address. Business justification: Links fulfillment orders to the structured customer address record for carrier serviceability checks (serviceable_by_carrier), BOPIS eligibility validation, and address-level fulfillment analytics. Sn',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer who placed the order being fulfilled. Links to the Customer master data entity.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: A fulfillment order is issued to a specific fulfillment center for execution. This is a core operational relationship — every fulfillment instruction must be assigned to a physical FC node. No center_',
    `header_id` BIGINT COMMENT 'Reference to the originating sales order in the Order Management System (OMS) that triggered this fulfillment instruction.',
    `product_listing_id` BIGINT COMMENT 'Foreign key linking to product.product_listing. Business justification: Fulfillment orders originate from a specific product listing (channel, condition, seller). Marketplace sellers track fulfillment performance per listing for SLA compliance, buy-box eligibility, and ch',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables order‑level profit attribution, allowing profitability analysis per profit center in financial statements.',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: Fulfillment orders generated during promotional campaigns (flash sales, event-driven surges) must reference the pricing promotional_campaign for SLA prioritization, cost allocation, and campaign perfo',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_sla. Business justification: Each fulfillment order is governed by a specific SLA definition (fulfillment_sla) that determines pick/pack/ship time targets and breach thresholds based on fulfillment method, carrier service level, ',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the fulfillment center or warehouse node assigned to execute this fulfillment order. Links to the warehouse node master data.',
    `allocated_timestamp` TIMESTAMP COMMENT 'The timestamp when inventory was successfully allocated to this fulfillment order in the WMS. Marks transition from received to allocated status.',
    `cancellation_reason` STRING COMMENT 'The business reason why this fulfillment order was cancelled. Used for root cause analysis and process improvement.. Valid values are `customer_request|out_of_stock|address_issue|payment_failure|fraud_detected|duplicate_order`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The timestamp when the fulfillment order was cancelled. Triggers inventory de-allocation and order management system notification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fulfillment order record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivered_timestamp` TIMESTAMP COMMENT 'The timestamp when the package was successfully delivered to the customer destination address. Sourced from carrier proof-of-delivery records.',
    `fulfillment_method` STRING COMMENT 'The fulfillment execution strategy for this order. Determines Service Level Agreement (SLA) targets, routing logic, and carrier selection. BOPIS = Buy Online Pick Up In Store, FBA = Fulfillment By Amazon-style, 3PL = Third-Party Logistics. [ENUM-REF-CANDIDATE: standard|expedited|same_day|next_day|bopis|fba|3pl — 7 candidates stripped; promote to reference product]',
    `fulfillment_order_number` STRING COMMENT 'Human-readable business identifier for the fulfillment order, typically displayed on packing slips, shipping labels, and in Warehouse Management System (WMS) interfaces.. Valid values are `^FO-[A-Z0-9]{8,12}$`',
    `fulfillment_order_status` STRING COMMENT 'Current lifecycle status of the fulfillment order. Tracks progression through warehouse workflow stages from receipt to delivery. [ENUM-REF-CANDIDATE: received|allocated|picking|packed|shipped|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `gift_message` STRING COMMENT 'Optional personalized message to be included with gift orders. Printed on packing slip or gift card insert.',
    `is_gift` BOOLEAN COMMENT 'Boolean flag indicating whether this order is a gift. When true, pricing information is excluded from packing slip and gift wrapping may be applied.',
    `order_type` STRING COMMENT 'Classification of the order based on business context. B2C = Business to Consumer, B2B = Business to Business. Determines packing requirements, documentation, and invoicing rules.. Valid values are `b2c|b2b|replacement|sample|gift`',
    `package_count` STRING COMMENT 'The number of individual packages or parcels created for this fulfillment order. Orders may be split into multiple packages based on size, weight, or inventory location.',
    `packing_completed_timestamp` TIMESTAMP COMMENT 'The timestamp when all items were packed, shipping label applied, and the package was ready for carrier pickup.',
    `packing_slip_url` STRING COMMENT 'URL to the generated packing slip document that accompanies the shipment. Contains itemized order details for customer reference.. Valid values are `^https?://.*$`',
    `packing_started_timestamp` TIMESTAMP COMMENT 'The timestamp when packing operations began for this fulfillment order at the packing station.',
    `picking_completed_timestamp` TIMESTAMP COMMENT 'The timestamp when all items for this fulfillment order were successfully picked from warehouse locations.',
    `picking_started_timestamp` TIMESTAMP COMMENT 'The timestamp when warehouse personnel began picking items for this fulfillment order. Marks start of physical fulfillment execution.',
    `priority_level` STRING COMMENT 'Priority classification for warehouse pick-pack-ship sequencing. High and urgent priorities are expedited through the fulfillment workflow.. Valid values are `low|normal|high|urgent`',
    `promised_delivery_date` DATE COMMENT 'The date by which the order is promised to be delivered to the customer. Used for SLA tracking and customer communication.',
    `promised_ship_date` DATE COMMENT 'The date by which the fulfillment center committed to ship this order to meet customer Service Level Agreement (SLA) expectations.',
    `received_timestamp` TIMESTAMP COMMENT 'The timestamp when the fulfillment order was received by the Warehouse Management System (WMS) from the Order Management System (OMS).',
    `recipient_name` STRING COMMENT 'The full name of the person or business receiving the shipment. Printed on shipping label for carrier delivery verification.',
    `recipient_phone` STRING COMMENT 'Contact phone number for the shipment recipient. Used by carriers for delivery coordination and customer notification.',
    `shipped_timestamp` TIMESTAMP COMMENT 'The timestamp when the package was handed over to the carrier and departed the fulfillment center. Triggers customer shipment notification.',
    `shipping_address_line1` STRING COMMENT 'The primary street address line for the delivery destination. Contains street number, street name, and unit/apartment number if applicable.',
    `shipping_address_line2` STRING COMMENT 'Secondary address line for additional delivery instructions, building name, or suite information.',
    `shipping_city` STRING COMMENT 'The city or municipality name for the delivery destination address.',
    `shipping_country_code` STRING COMMENT 'Three-letter ISO country code for the delivery destination. Determines customs requirements and international shipping regulations.. Valid values are `^[A-Z]{3}$`',
    `shipping_label_url` STRING COMMENT 'URL to the generated shipping label document stored in the Content Delivery Network (CDN) or document management system.. Valid values are `^https?://.*$`',
    `shipping_postal_code` STRING COMMENT 'The postal code or ZIP code for the delivery destination address. Used for carrier routing and delivery zone determination.',
    `shipping_state_province` STRING COMMENT 'The state, province, or administrative region for the delivery destination address.',
    `special_instructions` STRING COMMENT 'Free-text field for special handling requirements, delivery instructions, or customer notes. Examples: fragile, signature required, leave at door.',
    `total_item_quantity` STRING COMMENT 'The total number of individual units (across all Stock Keeping Units or SKUs) included in this fulfillment order.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'The total packed volume of the fulfillment order in cubic meters. Used for warehouse space planning and transportation optimization.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total packed weight of the fulfillment order in kilograms. Used for carrier rate calculation and capacity planning.',
    `tracking_number` STRING COMMENT 'The carrier-provided tracking number for this shipment. Used for customer self-service tracking and proof-of-delivery verification.. Valid values are `^[A-Z0-9]{10,35}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fulfillment order record was last modified. Tracks the most recent change to any field in the record.',
    CONSTRAINT pk_fulfillment_order PRIMARY KEY(`fulfillment_order_id`)
) COMMENT 'Core operational record representing a fulfillment instruction issued to a warehouse or 3PL partner for a specific customer order or sub-order. Tracks fulfillment order status (received, allocated, picking, packed, shipped, delivered, cancelled), assigned fulfillment center, fulfillment method (standard, expedited, BOPIS, FBA-style, 3PL), promised SLA window, actual pick/pack/ship timestamps, and WMS/OMS reference identifiers. Central entity for pick-pack-ship orchestration.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique identifier for each line item within a fulfillment order. Primary key for the order line entity.',
    `bin_location_id` BIGINT COMMENT 'Foreign key linking to fulfillment.bin_location. Business justification: During the pick operation, each fulfillment order line is picked from a specific physical bin location within the fulfillment center. Linking fulfillment_order_line to bin_location enables pick-path o',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle assembly picking requires each order line to know which parent bundle it belongs to. Warehouse systems use this to group component picks, enforce bundle completeness before packing, and report ',
    `catalog_item_id` BIGINT COMMENT 'Internal product master identifier linking this line to the product catalog. Used for product attribute enrichment and reporting.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that contains this line item. Links line-level detail to the order header.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Line-level fulfillment traceability: each fulfillment_order_line must map to its originating order_line for partial fulfillment tracking, returns eligibility, revenue recognition per line, and fulfill',
    `listing_offer_id` BIGINT COMMENT 'Foreign key linking to marketplace.listing_offer. Business justification: Supports Offer Performance Analytics by linking each order line to the specific listing offer purchased, enabling pricing and conversion analysis.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Each sales order line is sourced from a specific PO line item; linking enables cost allocation, inventory traceability, and three‑way matching.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Traceability of the exact price list item used for each order line; needed for the Line‑Level Price Audit report.',
    `price_override_id` BIGINT COMMENT 'Foreign key linking to pricing.price_override. Business justification: Individual fulfillment order lines may carry price overrides (manual discounts, B2B negotiated prices, CS adjustments). Linking to price_override enables audit trails and approval workflow tracking fo',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for the Pick and Pack process to map each order line to the exact SKU for inventory allocation and performance reporting.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: In e-commerce WMS pick operations, each order line resolves to a specific stock_position (lot, condition, location) for ATP validation, inventory deduction, and lot traceability. fulfillment_order_lin',
    `warehouse_location_id` BIGINT COMMENT 'Identifier for the specific bin, slot, or location within the warehouse where the item was picked from. Critical for inventory accuracy and replenishment.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory allocated to this order line from warehouse stock. May differ from ordered quantity due to availability constraints.',
    `confirmation_status` STRING COMMENT 'Status indicating whether the pick has been confirmed and validated. Used for quality control and accuracy verification.. Valid values are `PENDING|CONFIRMED|REJECTED|REQUIRES_REVIEW`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was first created in the system. Marks the beginning of the line item lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the line item pricing. Supports multi-currency fulfillment operations.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Expiration or best-before date of the picked item. Critical for perishable goods and FEFO inventory rotation.',
    `gift_message` STRING COMMENT 'Customer-provided gift message to be included with this line item. Contains personal message content for gift orders.',
    `gift_wrap_flag` BOOLEAN COMMENT 'Indicates whether gift wrapping service was requested for this line item. True if gift wrap required, false otherwise.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this line item contains hazardous materials requiring special handling and shipping compliance. True if hazardous, false otherwise.',
    `line_status` STRING COMMENT 'Current fulfillment status of this order line. Tracks the line through the pick-pack-ship workflow lifecycle. [ENUM-REF-CANDIDATE: PENDING|ALLOCATED|PICKING|PICKED|PACKED|SHIPPED|CANCELLED|SHORT_PICK — 8 candidates stripped; promote to reference product]',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this line item calculated as unit price multiplied by packed quantity. Represents the line-level revenue.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the picked item. Critical for traceability, recalls, and expiration management.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU originally ordered by the customer. Represents the demand that must be fulfilled.',
    `pack_timestamp` TIMESTAMP COMMENT 'Timestamp when this line item was packed into a shipping container. Indicates readiness for shipment.',
    `packed_quantity` DECIMAL(18,2) COMMENT 'Quantity successfully packed into shipping containers. Represents the final quantity being shipped to the customer.',
    `pick_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task for this line item was completed. Marks the end of the picking phase for this line.',
    `pick_exception_code` STRING COMMENT 'Code indicating any exception or issue encountered during the pick process. Used for root cause analysis and process improvement.. Valid values are `SHORT_PICK|MISPICK|DAMAGED|EXPIRED|LOCATION_EMPTY|NONE`',
    `pick_exception_notes` STRING COMMENT 'Free-text notes providing additional context about pick exceptions or issues. Captured by warehouse associates for investigation.',
    `pick_method` STRING COMMENT 'The picking strategy used for this line item. Determines how the pick task was organized and executed within the WMS workflow.. Valid values are `SINGLE_ORDER|BATCH|ZONE|WAVE|CLUSTER`',
    `pick_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task for this line item was initiated. Used for calculating pick duration and SLA compliance.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'Actual quantity picked by warehouse associate or automation system. May differ from allocated quantity due to short picks or inventory discrepancies.',
    `return_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for return based on product category and business rules. True if returnable, false otherwise.',
    `serial_number` STRING COMMENT 'Unique serial number of the individual item picked. Used for high-value or serialized inventory tracking.. Valid values are `^[A-Z0-9-]{6,40}$`',
    `source_system` STRING COMMENT 'The operational system that originated or last updated this order line record. Used for data lineage and integration troubleshooting.. Valid values are `WMS|OMS|ERP|TMS|MARKETPLACE`',
    `special_handling_instructions` STRING COMMENT 'Any special handling requirements or instructions for this line item such as fragile, keep refrigerated, or this side up.',
    `substituted_sku` STRING COMMENT 'The SKU of the substitute product that was picked in place of the originally ordered SKU. Null if no substitution occurred.. Valid values are `^[A-Z0-9]{8,20}$`',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether a product substitution was made for this line item due to stockout or customer preference. True if substituted, false otherwise.',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are measured for this line item. Defines how the product is counted and handled in the warehouse.. Valid values are `EACH|CASE|PALLET|BOX|PACK|UNIT`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit for this line item at the time of order placement. Used for order value calculation and financial reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was last modified. Used for change tracking and data synchronization.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume of the picked quantity for this line item in cubic meters. Used for cartonization and space optimization.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the picked quantity for this line item in kilograms. Used for shipping cost calculation and carrier selection.',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Line-level detail for each SKU within a fulfillment order, serving as the unified pick-and-allocate record. Captures SKU identifier, ordered/allocated/picked/packed quantities, unit of measure, bin/slot location at time of pick, substitution flags, line-level fulfillment status, assigned picker (associate ID or robot unit), pick zone, pick method (single-order, batch, zone, wave), pick start/completion timestamps, pick exceptions (short pick, mispick), and confirmation status. SSOT for SKU-level fulfillment execution including pick task assignment and completion within the WMS workflow.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` (
    `packing_slip_id` BIGINT COMMENT 'Unique identifier for the packing slip record. Primary key for the packing slip entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier assignment for packing slips is required for carrier billing and performance reporting; linking provides authoritative carrier data.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: A packing slip is the operational document for the packing lifecycle of a fulfillment order. The direct link to fulfillment_order (the instruction) is essential for packing workflow management and ord',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this packing slip. Links the packed carton to the outbound shipment.',
    `header_id` BIGINT COMMENT 'Reference to the parent fulfillment order that this packing slip belongs to. Links the packing slip to the originating customer order.',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the fulfillment center or warehouse where the packing operation was performed.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Actual measured weight of the packed carton in kilograms, including all contents and packing materials. Captured at the pack station scale.',
    `branded_insert_included` BOOLEAN COMMENT 'Boolean flag indicating whether branded marketing inserts, promotional materials, or catalog cards were included in the shipment.',
    `carton_code` STRING COMMENT 'Unique identifier or barcode of the specific carton or container used for this shipment. Used for tracking and inventory management of packing materials.',
    `carton_type` STRING COMMENT 'Type or size classification of the shipping carton or box used for packing. Examples include small box, medium box, large box, envelope, poly mailer.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the packing slip record was first created in the system. Represents the initial record creation for audit and tracking purposes.',
    `customer_notes` STRING COMMENT 'Free-text field containing any customer-provided delivery instructions or notes that should be visible to the packer or carrier. Examples include gate codes, delivery preferences, or special requests.',
    `dimensional_weight_kg` DECIMAL(18,2) COMMENT 'Calculated dimensional weight of the packed carton in kilograms, based on carton dimensions. Used for carrier billing and rate calculation.',
    `document_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the packing slip document was generated and printed. Represents the official creation time of the customer-facing packing slip.',
    `gift_message_included` BOOLEAN COMMENT 'Boolean flag indicating whether a gift message was included in the shipment. True if a gift message card or note was packed with the order.',
    `gift_wrap_applied` BOOLEAN COMMENT 'Boolean flag indicating whether gift wrapping was applied to the items in this shipment. True if gift wrap service was requested and applied.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the shipment contains hazardous materials requiring special handling, labeling, or carrier compliance. True if any packed item is classified as hazmat.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the packed carton in centimeters. Used for dimensional weight calculation and carrier compliance.',
    `invoice_included` BOOLEAN COMMENT 'Boolean flag indicating whether a printed invoice or receipt was included in the shipment. Typically false for B2C gift orders, true for B2B orders.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the packed carton in centimeters. Used for dimensional weight calculation and carrier compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the packing slip record was last modified or updated. Used for audit trail and change tracking.',
    `pack_end_timestamp` TIMESTAMP COMMENT 'Date and time when the packing operation was completed and the carton was sealed. Used for cycle time analysis and productivity tracking.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Date and time when the packing operation began at the pack station. Used for cycle time analysis and productivity tracking.',
    `packing_exception_code` STRING COMMENT 'Code indicating any exception or issue encountered during the packing process, such as damaged item, missing item, substitution made, or oversized package. Null if no exceptions occurred.',
    `packing_exception_notes` STRING COMMENT 'Free-text description of any packing exceptions or issues, providing additional context beyond the exception code. Null if no exceptions occurred.',
    `packing_materials_used` STRING COMMENT 'Comma-separated list or description of packing materials used in the shipment, such as bubble wrap, air pillows, packing peanuts, paper fill, or dunnage. Used for cost tracking and sustainability reporting.',
    `packing_slip_number` STRING COMMENT 'Human-readable business identifier for the packing slip document. Printed on the physical packing slip and used for customer service reference.',
    `packing_slip_status` STRING COMMENT 'Current lifecycle status of the packing slip record. Tracks the progression from draft through completion and any subsequent actions like reprinting or voiding.. Valid values are `draft|in_progress|completed|verified|voided|reprinted`',
    `qc_scan_result` STRING COMMENT 'Result of the quality control scan or verification performed during or after packing. Indicates whether the packed contents match the order requirements.. Valid values are `passed|failed|bypassed|not_required`',
    `qc_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control scan or verification was completed. Null if QC was not performed.',
    `return_label_included` BOOLEAN COMMENT 'Boolean flag indicating whether a prepaid return shipping label was included in the shipment for customer convenience.',
    `service_level` STRING COMMENT 'Shipping service level or speed selected for this shipment. Examples include standard ground, two-day, next-day, same-day, or economy.',
    `shipping_label_printed` BOOLEAN COMMENT 'Boolean flag indicating whether the shipping label has been printed for this packing slip. True once the label is generated and printed at the pack station.',
    `signature_required` BOOLEAN COMMENT 'Boolean flag indicating whether a delivery signature is required for this shipment. True for high-value or restricted items.',
    `special_handling_instructions` STRING COMMENT 'Free-text field containing any special handling instructions for the packing operation, such as fragile item handling, temperature control, or hazmat requirements.',
    `total_item_quantity` STRING COMMENT 'Total count of individual items (units) packed in this carton across all SKUs. Sum of quantities for all line items in the packing slip.',
    `total_sku_count` STRING COMMENT 'Total count of distinct SKUs packed in this carton. Represents the variety of products in the shipment.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for the shipment. Used by customers and customer service to track package delivery status.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the packed carton in centimeters. Used for dimensional weight calculation and carrier compliance.',
    CONSTRAINT pk_packing_slip PRIMARY KEY(`packing_slip_id`)
) COMMENT 'Consolidated operational record and SSOT for the full packing lifecycle of a fulfillment order — from pack station assignment and carton selection through QC verification and packing slip document generation. Stores pack station ID, packer associate, carton/box type, dimensional and actual weight, packing materials, QC scan results, packed SKUs with quantities, special handling instructions, gift message and branded insert flags, pack start/end timestamps, and generation timestamp. Serves as both the operational pack execution record (replacing standalone pack task) and the customer-facing documentation reference for shipment contents and returns processing.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` (
    `shipping_label_id` BIGINT COMMENT 'Unique system-generated identifier for the shipping label record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Shipping label generation needs carrier reference for tracking, customs, and cost allocation; FK ensures consistency with carrier master.',
    `carrier_rate_card_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_rate_card. Business justification: Carrier cost reconciliation and rate audit: each shipping label is generated using a specific rate card. Finance and ops teams run carrier invoice reconciliation reports that require tracing which rat',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Label rate selection and SLA compliance reporting: a shipping label is generated for a specific carrier service (e.g., overnight, ground). Carrier performance dashboards and SLA breach analysis requir',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: A shipping label is generated for a fulfillment orders outbound shipment. The direct in-domain link to fulfillment_order enables label-to-order traceability without requiring a join through fulfillme',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the outbound shipment associated with this label.',
    `header_id` BIGINT COMMENT 'Identifier of the order associated with this shipping label.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any surcharge, discount, or fee applied to the base carrier rate.',
    `carrier_rate_amount` DECIMAL(18,2) COMMENT 'Base rate quoted by the carrier before adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipping label record was first created in the system.',
    `customs_declaration_flag` BOOLEAN COMMENT 'True if a customs declaration is required for the shipment.',
    `customs_value` DECIMAL(18,2) COMMENT 'Declared monetary value for customs purposes.',
    `destination_address_snapshot` STRING COMMENT 'Serialized snapshot of the destination address at label generation time.',
    `dimensions_cm` STRING COMMENT 'Package dimensions formatted as LxWxH in centimeters.. Valid values are `^d+xd+xd+$`',
    `generated_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipping label was generated.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'Monetary value of the insurance coverage for the shipment.',
    `insurance_flag` BOOLEAN COMMENT 'Indicates whether the shipment is insured.',
    `label_format` STRING COMMENT 'File format of the generated shipping label.. Valid values are `ZPL|PDF|PNG`',
    `label_number` STRING COMMENT 'Business identifier assigned to the shipping label, used for tracking and reference.. Valid values are `^[A-Z0-9-]+$`',
    `manual_override_flag` BOOLEAN COMMENT 'Indicates whether a user manually overrode the automated carrier selection.',
    `origin_address_snapshot` STRING COMMENT 'Serialized snapshot of the origin address at label generation time.',
    `package_type` STRING COMMENT 'Physical packaging type used for the shipment.. Valid values are `box|envelope|pallet`',
    `rate_basis` STRING COMMENT 'Basis used for carrier rate calculation (weight, dimensional weight, or zone).. Valid values are `weight|dim_weight|zone`',
    `rate_currency` STRING COMMENT 'Three‑letter ISO currency code for the carrier rate.. Valid values are `^[A-Z]{3}$`',
    `selection_method` STRING COMMENT 'Algorithm or rule used to select the carrier for this label.. Valid values are `cheapest|fastest|preferred|tms_optimized`',
    `selection_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier selection (automated or manual) occurred.',
    `shipping_label_status` STRING COMMENT 'Current lifecycle state of the shipping label.. Valid values are `generated|voided|reprinted|cancelled`',
    `tms_reference_code` STRING COMMENT 'Identifier linking this label to the TMS transaction or batch.. Valid values are `^[A-Z0-9-]+$`',
    `total_amount` DECIMAL(18,2) COMMENT 'Final cost of the shipping label after adjustments, in the specified currency.',
    `tracking_number` STRING COMMENT 'Tracking number assigned by the carrier for shipment visibility.. Valid values are `^[A-Z0-9]+$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipping label record.',
    `void_flag` BOOLEAN COMMENT 'True if the label has been voided or cancelled.',
    `void_timestamp` TIMESTAMP COMMENT 'Timestamp when the label was voided, if applicable.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the package in kilograms used for rate calculation.',
    CONSTRAINT pk_shipping_label PRIMARY KEY(`shipping_label_id`)
) COMMENT 'Master record and SSOT for each shipping label generated for an outbound shipment, incorporating the full carrier selection, rate-shopping, and label generation lifecycle. Stores carrier SCAC code, tracking number, label format (ZPL, PDF), service level (ground, 2-day, overnight, same-day), origin and destination address snapshots, label generation timestamp, carrier rate quoted, rate basis (weight, dimensional weight, zone), carrier selection method (cheapest, fastest, preferred, TMS-optimized), manual override flag, selection timestamp, label void status, and TMS reference identifier. Unified record for carrier assignment decision and physical label artifact; integrates with TMS for carrier selection and rate shopping.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` (
    `fulfillment_shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Each shipment generates a carrier freight invoice that creates an AP record. Three-way matching (shipment proof + carrier invoice + AP record) is a standard freight audit process. Direct shipment→AP l',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Carrier contract compliance and volume commitment tracking: e-commerce operators must report shipment volumes against contracted minimums and verify SLA terms per contract. Linking each shipment to it',
    `carrier_id` BIGINT COMMENT 'FK to logistics.carrier',
    `carrier_rate_card_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_rate_card. Business justification: Freight audit and carrier invoice reconciliation: fulfillment_shipment records shipping_cost_gross/net/tax but has no FK to the rate card that produced those costs. Finance teams require this link to ',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Carrier performance reporting and freight cost allocation by service tier: fulfillment_shipment has carrier_id but no carrier_service_id. service_level and shipping_method are denormalized representat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating outbound shipping expenses to the appropriate cost center for accurate cost accounting and financial reporting.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.customer_address. Business justification: Links shipments to the structured customer address for failed delivery tracking (failed_delivery_count on customer_address), carrier serviceability reporting, and address-level shipment performance an',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who will receive the shipment.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: A fulfillment shipment is dispatched FROM a specific fulfillment center. This is a fundamental operational link for FC-level shipment tracking, throughput reporting, and SLA monitoring. No center_id e',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: A fulfillment shipment is the physical execution of a fulfillment order. This direct in-domain link is essential for end-to-end fulfillment traceability — connecting the instruction (fulfillment_order',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Order‑to‑Shipment association needed for shipping status dashboard and carrier billing reconciliation.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Required for shipment‑payment reconciliation report linking each shipment to the payment transaction that funded it.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Shipping cost calculations reference a price list; required for the Shipment Cost Allocation process.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Shipment shipping costs are calculated based on the destination price zone in e-commerce rate engines. Linking fulfillment_shipment to price_zone enables accurate shipping cost attribution, carrier ra',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: Shipping tax (shipping_cost_tax) must be linked to a tax_record for marketplace facilitator tax compliance and remittance reporting. E-commerce tax nexus rules require shipment-level tax tracking. No ',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse from which the shipment originated.',
    `actual_delivery_date` DATE COMMENT 'Date when the shipment was actually delivered.',
    `carrier_tracking_url` STRING COMMENT 'Web URL to the carriers tracking page for this shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `declared_value` DECIMAL(18,2) COMMENT 'Monetary value declared for customs and liability purposes.',
    `declared_value_currency` STRING COMMENT 'Three-letter ISO currency code for the declared value.',
    `delivery_attempts` STRING COMMENT 'Number of delivery attempts made for this shipment.',
    `delivery_status_detail` STRING COMMENT 'Additional detail about the delivery outcome (e.g., left with neighbor, held at depot).',
    `destination_address_line1` STRING COMMENT 'First line of the shipment destination address.',
    `destination_city` STRING COMMENT 'City component of the destination address.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the destination.. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the destination address.',
    `destination_state` STRING COMMENT 'State or province component of the destination address.',
    `estimated_delivery_date` DATE COMMENT 'Projected date when the shipment is expected to be delivered.',
    `freight_class` STRING COMMENT 'Classification of freight for pricing and handling (e.g., Class 70).',
    `freight_terms` STRING COMMENT 'Terms of payment for freight charges.. Valid values are `prepaid|collect|third_party`',
    `fulfillment_shipment_status` STRING COMMENT 'Current lifecycle status of the shipment.. Valid values are `manifested|in_transit|out_for_delivery|delivered|exception|returned`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height of the shipment package in centimeters.',
    `insurance_flag` BOOLEAN COMMENT 'Indicates whether the shipment is insured.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length of the shipment package in centimeters.',
    `package_count` STRING COMMENT 'Number of individual packages in the shipment.',
    `proof_of_delivery_reference` STRING COMMENT 'Reference to the proof-of-delivery document or image.',
    `return_reason` STRING COMMENT 'Reason provided for a returned shipment, if applicable.',
    `ship_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment was dispatched from the fulfillment center.',
    `shipment_number` STRING COMMENT 'Business identifier assigned to the shipment for tracking and reference.',
    `shipment_type` STRING COMMENT 'Indicates whether the shipment is a normal outbound, a return, or an internal transfer.. Valid values are `outbound|return|transfer`',
    `shipping_cost_currency` STRING COMMENT 'Three-letter ISO currency code for the shipping cost.',
    `shipping_cost_gross` DECIMAL(18,2) COMMENT 'Total shipping cost before taxes and adjustments.',
    `shipping_cost_net` DECIMAL(18,2) COMMENT 'Net shipping cost after tax adjustments.',
    `shipping_cost_tax` DECIMAL(18,2) COMMENT 'Tax component of the shipping cost.',
    `shipping_priority` STRING COMMENT 'Priority level assigned to the shipment.. Valid values are `standard|expedited|overnight`',
    `tracking_number` STRING COMMENT 'Unique tracking identifier provided by the carrier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width of the shipment package in centimeters.',
    CONSTRAINT pk_fulfillment_shipment PRIMARY KEY(`fulfillment_shipment_id`)
) COMMENT 'Core transactional record representing a physical outbound shipment dispatched from a fulfillment center to a customer or intermediate hub. Tracks shipment status (manifested, in-transit, out-for-delivery, delivered, exception, returned), carrier, tracking number, ship date, estimated delivery date, actual delivery date, shipment weight, dimensions, declared value, and proof-of-delivery reference. Bridges fulfillment execution and last-mile logistics; integrates with TMS for carrier tracking events.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` (
    `shipment_event_id` BIGINT COMMENT 'Unique identifier for the shipment tracking event record. Primary key for the shipment event log.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier (e.g., FedEx, UPS, USPS, DHL) that reported this tracking event. Links to carrier master data.',
    `center_id` BIGINT COMMENT 'Reference to the warehouse, fulfillment center, or carrier facility where the event occurred. Links to facility master data for internal events.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the parent shipment container that this event belongs to. Links this tracking event to the overall shipment record.',
    `header_id` BIGINT COMMENT 'Reference to the customer order associated with this shipment event. Enables order-level tracking and SLA monitoring.',
    `carrier_event_code` STRING COMMENT 'The carrier-specific status code or event identifier from the carriers tracking system. Raw code as provided by carrier API or EDI message.',
    `carrier_event_description` STRING COMMENT 'The human-readable description of the tracking event as provided by the carrier. Raw scan message or status text from carrier system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this shipment event record was first created in the system. Immutable audit field for data governance and compliance.',
    `delivery_location_type` STRING COMMENT 'The specific location where the package was left upon delivery. Applicable only to delivered events. Provides proof-of-delivery detail for customer service and claims. [ENUM-REF-CANDIDATE: front_door|back_door|side_door|mailroom|reception|neighbor|parcel_locker|carrier_facility — 8 candidates stripped; promote to reference product]',
    `estimated_delivery_date` DATE COMMENT 'The carriers current estimated delivery date for the shipment as of this event. Updated dynamically as the shipment progresses. Used for customer communication and SLA tracking.',
    `event_location_city` STRING COMMENT 'The city where the tracking event was recorded by the carrier. May be null for certain event types that do not have precise location data.',
    `event_location_country` STRING COMMENT 'Three-letter ISO country code where the tracking event occurred (e.g., USA, CAN, MEX). Supports international shipment tracking.. Valid values are `^[A-Z]{3}$`',
    `event_location_postal_code` STRING COMMENT 'The postal or ZIP code of the location where the tracking event was recorded. Enables geographic analysis of shipment flow.',
    `event_location_state` STRING COMMENT 'The state or province where the tracking event occurred. Uses standard postal abbreviations (e.g., CA, NY, TX).',
    `event_source` STRING COMMENT 'The system or channel through which the tracking event was received: carrier_api (direct carrier integration), tms_webhook (Transportation Management System callback), edi_214 (Electronic Data Interchange shipment status), manual_entry (operator input), wms_scan (Warehouse Management System scan).. Valid values are `carrier_api|tms_webhook|edi_214|manual_entry|wms_scan`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the tracking event occurred in the carriers system. This is the real-world event time, not the system ingestion time.',
    `event_type` STRING COMMENT 'The category of tracking event representing the shipment milestone: picked_up (carrier collected package), in_transit (package moving through network), out_for_delivery (on vehicle for final delivery), delivered (successfully received), exception (delay or issue), attempted_delivery (delivery tried but failed).. Valid values are `picked_up|in_transit|out_for_delivery|delivered|exception|attempted_delivery`',
    `exception_reason` STRING COMMENT 'Detailed explanation of the exception condition if is_exception is True. Describes the nature of the delay, damage, or delivery issue. Null for non-exception events.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'The timestamp when this event record was ingested into the data platform. Distinct from event_timestamp (when the event actually occurred). Used for data lineage and latency monitoring.',
    `is_customer_visible` BOOLEAN COMMENT 'Boolean flag indicating whether this event should be displayed to the customer in tracking interfaces. False for internal-only events (warehouse scans, carrier facility transfers).',
    `is_exception` BOOLEAN COMMENT 'Boolean flag indicating whether this event represents an exception or problem condition (delay, damage, lost package, address issue, weather delay, etc.). True if exception, False for normal milestone events.',
    `is_sla_breach` BOOLEAN COMMENT 'Boolean flag indicating whether this event represents or contributes to an SLA breach. True if the event timestamp exceeds the SLA target, False otherwise.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the event location in decimal degrees. Enables precise geospatial analysis and mapping of shipment routes.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the event location in decimal degrees. Used with latitude for route optimization and delivery zone analysis.',
    `raw_payload` STRING COMMENT 'The complete raw JSON or XML payload received from the carrier API, TMS webhook, or EDI message. Preserved for audit, troubleshooting, and reprocessing. May contain additional carrier-specific metadata.',
    `signature_name` STRING COMMENT 'Name of the person who signed for the delivery. Captured for delivered events requiring proof of delivery. Null for events that do not involve signature capture.',
    `sla_target_delivery_timestamp` TIMESTAMP COMMENT 'The promised delivery date and time per the service level agreement. Used to detect SLA breaches by comparing against actual delivery timestamp.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient or package temperature in degrees Celsius recorded at the time of the event. Critical for cold-chain shipments (pharmaceuticals, perishables). Null for non-temperature-controlled shipments.',
    `tracking_number` STRING COMMENT 'The carrier-assigned tracking number for the shipment. Used for customer-facing tracking and carrier API queries.',
    `weight_actual_kg` DECIMAL(18,2) COMMENT 'The actual measured weight of the shipment in kilograms as recorded during this event. May be captured at pickup, in-transit weighing, or delivery. Used for freight cost reconciliation.',
    CONSTRAINT pk_shipment_event PRIMARY KEY(`shipment_event_id`)
) COMMENT 'Immutable event log capturing carrier-reported and internal tracking milestones for a shipment throughout its transit lifecycle. Each record represents a discrete tracking event: event type (picked up, in-transit, out-for-delivery, delivered, exception, attempted delivery), event timestamp, event location (city, state, country), carrier event code, raw carrier scan message, and data source (carrier API, TMS webhook, EDI 214). Enables SLA breach detection and customer-facing tracking updates.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'Unique identifier for the proof of delivery record.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.customer_address. Business justification: POD records must reference the structured customer address to update failed_delivery_count, validate delivery confirmation against the registered address, and support address-level delivery success ra',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the party who received the shipment.',
    `delivery_confirmation_id` BIGINT COMMENT 'Foreign key linking to order.delivery_confirmation. Business justification: POD reconciliation: proof_of_delivery (carrier-side record) must be reconciled against delivery_confirmation (order-side record) for customer dispute resolution, SLA compliance audits, and chargeback ',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: A proof of delivery confirms the delivery of a fulfillment order. The direct in-domain link to fulfillment_order provides clean order-level delivery confirmation traceability and supports SLA complian',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the shipment that this proof of delivery belongs to.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Proof‑of‑Delivery must be tied to originating order for compliance audit and customer dispute resolution.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: Buyer protection and seller settlement confirmation: POD records close marketplace transactions for payment release and dispute prevention. Marketplace ops teams need direct POD-to-transaction traceab',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: Under ASC 606/IFRS 15, delivery confirmation (POD) is the performance obligation satisfaction event triggering revenue recognition in e-commerce. Auditors require a direct audit trail from POD to reve',
    `carrier_code` STRING COMMENT 'Identifier code of the carrier that performed the final delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proof of delivery record was first created in the system.',
    `delivery_country_code` STRING COMMENT 'Three‑letter ISO country code of the delivery location. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN|IND|BRA — promote to reference product]',
    `delivery_method` STRING COMMENT 'Mode of delivery used for the order.. Valid values are `standard|express|same_day|pickup`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery was confirmed (actual event time).',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether an exception occurred during delivery (e.g., failed attempt, damage).',
    `exception_notes` STRING COMMENT 'Free‑text notes describing any delivery exception details.',
    `gps_accuracy_meters` STRING COMMENT 'Reported accuracy of the GPS coordinate in meters.',
    `is_bopis` BOOLEAN COMMENT 'True if the delivery was part of a Buy‑Online‑Pick‑Up‑In‑Store fulfillment.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the delivery location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the delivery location.',
    `otp_verified` BOOLEAN COMMENT 'True if a one‑time password was successfully verified at delivery.',
    `photo_captured` BOOLEAN COMMENT 'True if a photo of the delivered package was captured.',
    `pod_version` STRING COMMENT 'Version identifier of the proof‑of‑delivery data format.',
    `proof_asset_url` STRING COMMENT 'Link to the digital asset (image, signature file, etc.) that serves as proof.',
    `proof_of_delivery_status` STRING COMMENT 'Current lifecycle status of the delivery proof record.. Valid values are `pending|delivered|exception|returned|cancelled`',
    `proof_type` STRING COMMENT 'Method used to capture delivery proof (e.g., signature, photo, GPS coordinate, one‑time password).. Valid values are `signature|photo|gps|otp`',
    `recipient_name` STRING COMMENT 'Full legal name of the delivery recipient.',
    `recipient_phone` STRING COMMENT 'Contact phone number of the delivery recipient.',
    `signature_captured` BOOLEAN COMMENT 'True if a handwritten signature was captured as proof.',
    `sla_actual_minutes` STRING COMMENT 'Actual time in minutes taken to complete the delivery.',
    `sla_compliance` STRING COMMENT 'Result of SLA evaluation for this delivery.. Valid values are `met|missed|not_applicable`',
    `sla_target_minutes` STRING COMMENT 'Target service‑level agreement time in minutes for delivery completion.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the proof of delivery record.',
    CONSTRAINT pk_proof_of_delivery PRIMARY KEY(`proof_of_delivery_id`)
) COMMENT 'Transactional record capturing confirmed delivery evidence for a shipment. Stores confirmation type (signature, photo, GPS, OTP), recipient name, delivery timestamp, location coordinates, photo/signature asset references, carrier confirmation code, and exception notes. Critical for dispute resolution, chargeback defense, RMA initiation, and last-mile SLA compliance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` (
    `bin_location_id` BIGINT COMMENT 'System-generated unique identifier for each physical storage location.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Bin locations belong to a specific fulfillment center; adding center_id FK enables hierarchy and eliminates silo.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: bin_location (fulfillment WES) and warehouse_location (inventory WMS) represent the same physical space in two domain systems. E-commerce operations require cross-system location reconciliation for cy',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the fulfillment center or warehouse that owns this bin.',
    `aisle` STRING COMMENT 'Alphanumeric identifier of the aisle containing the bin.',
    `bay` STRING COMMENT 'Alphanumeric identifier of the bay within the aisle.',
    `bin_location_level` STRING COMMENT 'Vertical level or tier where the bin is located.',
    `bin_location_status` STRING COMMENT 'Operational status of the bin (e.g., active, inactive, under maintenance).. Valid values are `active|inactive|maintenance`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bin location record was first created.',
    `current_units` STRING COMMENT 'Current count of units stored in the bin.',
    `current_volume_cubic_m` DECIMAL(18,2) COMMENT 'Current total volume of inventory in the bin.',
    `current_weight_kg` DECIMAL(18,2) COMMENT 'Current total weight of inventory in the bin.',
    `effective_from` DATE COMMENT 'Date when the bin became available for use.',
    `effective_until` DATE COMMENT 'Date when the bin is scheduled to be decommissioned or repurposed (nullable).',
    `is_accessible` BOOLEAN COMMENT 'Indicates whether the bin is accessible to standard picking equipment (e.g., wheelchair‑accessible).',
    `is_hazmat_allowed` BOOLEAN COMMENT 'Indicates whether hazardous materials are permitted in this location.',
    `is_temperature_controlled` BOOLEAN COMMENT 'True if the bin resides in a temperature‑controlled environment.',
    `last_inventory_check_date` DATE COMMENT 'Date of the most recent physical inventory verification for this bin.',
    `location_code` STRING COMMENT 'Human‑readable alphanumeric code that uniquely identifies the bin within the fulfillment center.',
    `location_description` STRING COMMENT 'Free‑form text describing special characteristics or notes about the bin.',
    `location_name` STRING COMMENT 'Descriptive name for the storage location, often used in UI displays and pick‑lists.',
    `location_type` STRING COMMENT 'Physical form factor of the storage element (e.g., bin, shelf, pallet, rack).. Valid values are `bin|shelf|pallet|rack`',
    `max_units` STRING COMMENT 'Maximum number of individual units the bin can hold.',
    `max_volume_cubic_m` DECIMAL(18,2) COMMENT 'Maximum volume in cubic meters that the bin can accommodate.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms that the bin can safely store.',
    `position` STRING COMMENT 'Specific position index within the level (e.g., slot number).',
    `temperature_zone` STRING COMMENT 'Temperature classification of the zone, required for perishable or temperature‑sensitive inventory.. Valid values are `ambient|refrigerated|frozen`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bin location record.',
    `zone_type` STRING COMMENT 'Classification of the zone where the bin resides, driving pick path and handling rules.. Valid values are `pick|bulk|staging|returns|hazmat|cold_chain`',
    CONSTRAINT pk_bin_location PRIMARY KEY(`bin_location_id`)
) COMMENT 'Master record for each physical storage location (bin, slot, shelf, pallet position) within a fulfillment center. Captures location code, zone classification (pick, bulk, staging, returns, hazmat, cold chain), aisle/bay/level/position coordinates, location type, capacity constraints (units, weight, volume), temperature zone, hazmat flag, and active status. SSOT for warehouse slotting and zone-based pick path optimization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`sla` (
    `sla_id` BIGINT COMMENT 'Unique system-generated identifier for the SLA record.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: SLA configuration and automated SLA assignment: fulfillment_sla.carrier_service_level is a plain-text denormalization of carrier_service. Automated SLA assignment engines and SLA-to-carrier-capability',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: E-commerce SLA policies are routinely defined per product category — perishables require same-day fulfillment, hazmat requires specialized handling windows, electronics may have premium SLAs. Category',
    `center_id` BIGINT COMMENT 'Identifier of the fulfillment center or warehouse to which the SLA applies.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: SLA tiers are defined per customer segment (e.g., loyalty gold gets same-day, standard gets 3-day). Linking fulfillment_sla to customer.segment enables segment-driven SLA assignment and compliance rep',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contract. Business justification: 3PL SLA terms (pick/pack/ship targets, breach thresholds) are contractually defined in vendor contracts. Linking fulfillment_sla to vendor_contract enables automated SLA breach penalty enforcement and',
    `breach_threshold_days` DECIMAL(18,2) COMMENT 'Tolerance window in days for delivery‑time breaches.',
    `breach_threshold_hours` DECIMAL(18,2) COMMENT 'Tolerance window in hours beyond the target after which the SLA is considered breached.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA record was first created in the system.',
    `delivery_time_target_days` DECIMAL(18,2) COMMENT 'Maximum allowed days from shipment dispatch to customer receipt.',
    `effective_from` DATE COMMENT 'Date when the SLA becomes binding.',
    `effective_until` DATE COMMENT 'Date when the SLA expires or is superseded (null for open‑ended).',
    `fulfillment_method` STRING COMMENT 'Method of order fulfillment to which the SLA applies.. Valid values are `standard|express|same_day|bopis`',
    `fulfillment_sla_description` STRING COMMENT 'Free‑form description of the SLA purpose and scope.',
    `notes` STRING COMMENT 'Additional operational notes, exceptions, or special handling instructions.',
    `pack_time_target_hours` DECIMAL(18,2) COMMENT 'Maximum allowed time from pick completion to packing completion.',
    `pick_time_target_hours` DECIMAL(18,2) COMMENT 'Maximum allowed time from order receipt to item pick completion.',
    `same_day_cutoff_time` TIMESTAMP COMMENT 'Latest order‑placement time (HH:MM) for same‑day fulfillment eligibility.',
    `ship_time_target_hours` DECIMAL(18,2) COMMENT 'Maximum allowed time from packing completion to shipment dispatch.',
    `sla_code` STRING COMMENT 'Human‑readable business code for the SLA, used in operational reporting and carrier selection.',
    `sla_name` STRING COMMENT 'Descriptive name of the SLA offering (e.g., "Prime Express SLA").',
    `sla_status` STRING COMMENT 'Current lifecycle status of the SLA.. Valid values are `active|inactive|retired|pending`',
    `sla_type` STRING COMMENT 'Classification of the SLA (e.g., standard, premium, custom).. Valid values are `standard|premium|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the SLA record.',
    `version` STRING COMMENT 'Version number for change‑management and audit tracking.',
    CONSTRAINT pk_sla PRIMARY KEY(`sla_id`)
) COMMENT 'Reference record defining SLA commitments by fulfillment method, carrier service level, customer segment, and fulfillment center. Captures promised pick/pack/ship SLA windows (hours), delivery window (days), same-day cutoff time, breach thresholds, and effective date range. Drives SLA compliance monitoring, fulfillment_exception breach detection, and carrier selection logic.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_bin_location_id` FOREIGN KEY (`bin_location_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`bin_location`(`bin_location_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ADD CONSTRAINT `fk_fulfillment_bin_location_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`fulfillment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`fulfillment` SET TAGS ('dbx_domain' = 'fulfillment');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center (FC) ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Default Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Agent Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|robotic');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `available_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Units');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'pallets|bins|cubic_feet|cubic_meters|square_feet|square_meters');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `center_code` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center (FC) Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `center_name` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `center_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `center_type` SET TAGS ('dbx_value_regex' = 'fba_style|third_party_logistics|bopis_hub|dark_store|micro_fulfillment|returns_center');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_business_glossary_term' = 'Order Cutoff Time (Local)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `daily_throughput_capacity` SET TAGS ('dbx_business_glossary_term' = 'Daily Throughput Capacity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `erp_site_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Site Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `operates_24_7` SET TAGS ('dbx_business_glossary_term' = 'Operates 24/7 Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|decommissioned|seasonal');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_operated|hybrid');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|economy|regional|express|custom');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `standard_processing_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Processing Time (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `supported_fulfillment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Fulfillment Methods');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `supports_cold_storage` SET TAGS ('dbx_business_glossary_term' = 'Supports Cold Storage Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `supports_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Supports Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `supports_returns_processing` SET TAGS ('dbx_business_glossary_term' = 'Supports Returns Processing Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `tms_integration_reference` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Integration ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `total_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity Units');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `wms_integration_reference` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Integration ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `wms_system_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `product_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Product Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Sla Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `allocated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|out_of_stock|address_issue|payment_failure|fraud_detected|duplicate_order');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_number` SET TAGS ('dbx_value_regex' = '^FO-[A-Z0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Is Gift Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'b2c|b2b|replacement|sample|gift');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `packing_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packing Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `packing_slip_url` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `packing_slip_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `packing_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packing Started Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `picking_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `picking_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking Started Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Priority Level');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `promised_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Ship Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Received Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipped Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 1');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 2');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_business_glossary_term' = 'Shipping City');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Country Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_label_url` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_label_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Postal Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_business_glossary_term' = 'Shipping State or Province');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_item_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Item Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (m³)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `bin_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Location Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `listing_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Offer Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `price_override_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'PENDING|CONFIRMED|REJECTED|REQUIRES_REVIEW');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `gift_wrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Fulfillment Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Pick Exception Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_exception_code` SET TAGS ('dbx_value_regex' = 'SHORT_PICK|MISPICK|DAMAGED|EXPIRED|LOCATION_EMPTY|NONE');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Pick Exception Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_method` SET TAGS ('dbx_value_regex' = 'SINGLE_ORDER|BATCH|ZONE|WAVE|CLUSTER');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `return_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,40}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WMS|OMS|ERP|TMS|MARKETPLACE');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_business_glossary_term' = 'Substituted Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EACH|CASE|PALLET|BOX|PACK|UNIT');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (KG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_slip_id` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Kilograms)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `branded_insert_included` SET TAGS ('dbx_business_glossary_term' = 'Branded Insert Included Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `carton_type` SET TAGS ('dbx_business_glossary_term' = 'Carton Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `customer_notes` SET TAGS ('dbx_business_glossary_term' = 'Customer Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `dimensional_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (Kilograms)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `document_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Generation Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `gift_message_included` SET TAGS ('dbx_business_glossary_term' = 'Gift Message Included Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `gift_wrap_applied` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Applied Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Carton Height (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `invoice_included` SET TAGS ('dbx_business_glossary_term' = 'Invoice Included Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Carton Length (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `pack_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack End Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Packing Exception Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Packing Exception Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_materials_used` SET TAGS ('dbx_business_glossary_term' = 'Packing Materials Used');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_slip_status` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_slip_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|verified|voided|reprinted');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `qc_scan_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Scan Result');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `qc_scan_result` SET TAGS ('dbx_value_regex' = 'passed|failed|bypassed|not_required');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `qc_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `return_label_included` SET TAGS ('dbx_business_glossary_term' = 'Return Label Included Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `shipping_label_printed` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Printed Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `signature_required` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `total_item_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Item Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Carton Width (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `shipping_label_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Identifier (SLID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `carrier_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Card Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (SID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (OID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Amount (Adjustment)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `carrier_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Amount (CRA)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `customs_declaration_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Flag (Customs Decl)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `customs_value` SET TAGS ('dbx_business_glossary_term' = 'Customs Declared Value (Customs Value)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `destination_address_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Snapshot (Dest Addr)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `destination_address_snapshot` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `destination_address_snapshot` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Dimensions (cm)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_value_regex' = '^d+xd+xd+$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Generation Timestamp (LGT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount (Insurance Amt)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `insurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag (Insurance)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `label_format` SET TAGS ('dbx_business_glossary_term' = 'Label Format (Format)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `label_format` SET TAGS ('dbx_value_regex' = 'ZPL|PDF|PNG');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `label_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Number (SLN)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `label_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `manual_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag (Manual Override)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `origin_address_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Origin Address Snapshot (Origin Addr)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `origin_address_snapshot` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `origin_address_snapshot` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type (Pkg Type)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'box|envelope|pallet');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis (RB)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'weight|dim_weight|zone');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `selection_method` SET TAGS ('dbx_business_glossary_term' = 'Carrier Selection Method (CSM)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `selection_method` SET TAGS ('dbx_value_regex' = 'cheapest|fastest|preferred|tms_optimized');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `selection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Selection Timestamp (CST)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `shipping_label_status` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Lifecycle Status (SL Status)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `shipping_label_status` SET TAGS ('dbx_value_regex' = 'generated|voided|reprinted|cancelled');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `tms_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System Reference ID (TMS Ref)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `tms_reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Label Cost Amount (Total Cost)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number (Tracking No)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]+$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `void_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Void Flag (Void)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Void Timestamp (Void TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Package Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `carrier_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Card Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Customer ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `carrier_tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking URL');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency (CUR)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `delivery_attempts` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempts');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `delivery_status_detail` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status Detail');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_state` SET TAGS ('dbx_business_glossary_term' = 'Destination State/Province');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `destination_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `fulfillment_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status (STAT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `fulfillment_shipment_status` SET TAGS ('dbx_value_regex' = 'manifested|in_transit|out_for_delivery|delivered|exception|returned');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (cm)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `insurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (cm)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `proof_of_delivery_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Reference');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `return_reason` SET TAGS ('dbx_business_glossary_term' = 'Return Reason');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp (SHIP_TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number (SN)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'outbound|return|transfer');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Currency (CUR)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_gross` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Gross');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_net` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Net');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_tax` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Tax');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_priority` SET TAGS ('dbx_business_glossary_term' = 'Shipping Priority');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (cm)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `shipment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Event ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `carrier_event_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Event Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `carrier_event_description` SET TAGS ('dbx_business_glossary_term' = 'Carrier Event Description');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `delivery_location_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_location_city` SET TAGS ('dbx_business_glossary_term' = 'Event Location City');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_location_country` SET TAGS ('dbx_business_glossary_term' = 'Event Location Country Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Event Location Postal Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_location_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_location_state` SET TAGS ('dbx_business_glossary_term' = 'Event Location State or Province');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Data Source');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'carrier_api|tms_webhook|edi_214|manual_entry|wms_scan');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Event Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'picked_up|in_transit|out_for_delivery|delivered|exception|attempted_delivery');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Ingestion Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `is_customer_visible` SET TAGS ('dbx_business_glossary_term' = 'Customer Visible Event Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `is_exception` SET TAGS ('dbx_business_glossary_term' = 'Exception Event Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `is_sla_breach` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Event Location Latitude');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Event Location Longitude');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `raw_payload` SET TAGS ('dbx_business_glossary_term' = 'Raw Event Payload');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `signature_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Signature Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `signature_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `signature_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `sla_target_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `weight_actual_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight in Kilograms (KG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|pickup');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (Meters)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `is_bopis` SET TAGS ('dbx_business_glossary_term' = 'BOPIS Indicator');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Latitude');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Longitude');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `otp_verified` SET TAGS ('dbx_business_glossary_term' = 'OTP Verified Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `photo_captured` SET TAGS ('dbx_business_glossary_term' = 'Photo Captured Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `pod_version` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Version');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `proof_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Proof Asset URL');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_value_regex' = 'pending|delivered|exception|returned|cancelled');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `proof_type` SET TAGS ('dbx_business_glossary_term' = 'Proof Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `proof_type` SET TAGS ('dbx_value_regex' = 'signature|photo|gps|otp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Full Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Minutes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_value_regex' = 'met|missed|not_applicable');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `bin_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Location Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (WAREHOUSE_ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier (AISLE_ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier (BAY_ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `bin_location_level` SET TAGS ('dbx_business_glossary_term' = 'Level Identifier (LEVEL_ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `bin_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `bin_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `current_units` SET TAGS ('dbx_business_glossary_term' = 'Current Units Stored (CUR_UNITS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `current_volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Current Volume Stored (CUBIC_M) (CUR_VOLUME_CU_M)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `current_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Current Weight Stored (KG) (CUR_WEIGHT_KG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `is_accessible` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Flag (ACCESSIBLE_FLAG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `is_hazmat_allowed` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Allowed Flag (HAZMAT_FLAG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TEMP_CTRL_FLAG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `last_inventory_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Check Date (LAST_INV_CHECK)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code (LOC_CODE)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description (LOC_DESC)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name (LOC_NAME)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type (LOC_TYPE)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bin|shelf|pallet|rack');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `max_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Units Capacity (MAX_UNITS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `max_volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Capacity (CUBIC_M) (MAX_VOLUME_CU_M)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Capacity (KG) (MAX_WEIGHT_KG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (POS_ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone (TEMP_ZONE)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type (ZONE_TYPE)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'pick|bulk|staging|returns|hazmat|cold_chain');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `breach_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold (Days)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `breach_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `delivery_time_target_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time Target (Days)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|bopis');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `fulfillment_sla_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `pack_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Pack Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `pick_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Pick Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `same_day_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Same‑Day Cutoff Time');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `ship_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Ship Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'standard|premium|custom');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Version');
