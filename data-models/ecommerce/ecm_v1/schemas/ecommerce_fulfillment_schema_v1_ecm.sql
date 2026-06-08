-- Schema for Domain: fulfillment | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`fulfillment` COMMENT 'Manages pick-pack-ship operations, warehouse workflows, order allocation, packing slips, shipping labels, and fulfillment SLA tracking. Supports FBA-style fulfillment center operations, 3PL partner coordination, BOPIS orchestration, and proof-of-delivery records. Integrates with WMS and TMS for end-to-end fulfillment execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`center` (
    `center_id` BIGINT COMMENT 'Unique identifier for the fulfillment center. Primary key for the center entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maps each fulfillment center to its operational cost center, essential for budgeting, cost allocation, and expense tracking.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Default carrier per fulfillment center drives automated carrier selection in the Shipment Creation workflow.',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Center‑specific default route is used by the routing engine to optimize outbound shipments; required for route‑based cost analysis.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to service.agent. Business justification: Each fulfillment center is overseen by a manager agent responsible for operations; linking enables manager‑level performance dashboards and incident escalation.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Each fulfillment center must be associated with a compliance program for safety, labor and data protection audits.',
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
    `partner_operator_name` STRING COMMENT 'Name of the third-party logistics (3PL) partner or operator managing the fulfillment center, if applicable.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for order‑to‑campaign ROI attribution report; e‑commerce analysts need to trace each fulfillment order back to the marketing campaign that generated it.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Order‑level carrier assignment is used in the Order Fulfillment Planning process and carrier performance dashboards.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Tracking the specific carrier service (e.g., Express, Ground) per order supports SLA compliance reporting and rate calculations.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer who placed the order being fulfilled. Links to the Customer master data entity.',
    `header_id` BIGINT COMMENT 'Reference to the originating sales order in the Order Management System (OMS) that triggered this fulfillment instruction.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Required for Fulfillment Attribution Report linking each fulfillment order to its originating marketplace listing for seller performance and inventory forecasting.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Order‑level compliance checks (age‑restricted, hazardous) are enforced by associating each order with relevant obligations.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Needed for fulfillment order payment status dashboard to show which payment transaction covers each order.',
    `pick_wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.pick_wave. Business justification: Pick wave groups many fulfillment orders; adding pick_wave_id to fulfillment_order creates the required parent-child link and eliminates the siloed pick_wave table.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Order pricing engine selects a price list for each fulfillment order; required for the Order Pricing Report linking orders to applied price lists.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables order‑level profit attribution, allowing profitability analysis per profit center in financial statements.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Drop‑ship fulfillment requires linking each fulfillment order to the purchase order that supplies the items for financial reconciliation and SLA tracking.',
    `third_party_fulfillment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.third_party_fulfillment. Business justification: A fulfillment order may be outsourced to a third‑party logistics partner; linking allows tracking of the partner per order.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` (
    `fulfillment_order_line_id` BIGINT COMMENT 'Unique identifier for each line item within a fulfillment order. Primary key for the order line entity.',
    `carton_id` BIGINT COMMENT 'Identifier of the shipping carton or container into which this line item was packed. Links line items to physical packages.. Valid values are `^[A-Z0-9]{8,25}$`',
    `catalog_item_id` BIGINT COMMENT 'Internal product master identifier linking this line to the product catalog. Used for product attribute enrichment and reporting.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that contains this line item. Links line-level detail to the order header.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Posts each order lines revenue and COGS to a specific GL account, supporting detailed financial statements and revenue recognition.',
    `listing_offer_id` BIGINT COMMENT 'Foreign key linking to marketplace.listing_offer. Business justification: Supports Offer Performance Analytics by linking each order line to the specific listing offer purchased, enabling pricing and conversion analysis.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Individual line items may be subject to specific regulations (e.g., controlled substances), requiring line‑level obligation linkage.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Each sales order line is sourced from a specific PO line item; linking enables cost allocation, inventory traceability, and three‑way matching.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Traceability of the exact price list item used for each order line; needed for the Line‑Level Price Audit report.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for the Pick and Pack process to map each order line to the exact SKU for inventory allocation and performance reporting.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier for the specific bin, slot, or location within the warehouse where the item was picked from. Critical for inventory accuracy and replenishment.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory allocated to this order line from warehouse stock. May differ from ordered quantity due to availability constraints.',
    `confirmation_status` STRING COMMENT 'Status indicating whether the pick has been confirmed and validated. Used for quality control and accuracy verification.. Valid values are `PENDING|CONFIRMED|REJECTED|REQUIRES_REVIEW`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was first created in the system. Marks the beginning of the line item lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the line item pricing. Supports multi-currency fulfillment operations.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Expiration or best-before date of the picked item. Critical for perishable goods and FEFO inventory rotation.',
    `gift_message` STRING COMMENT 'Customer-provided gift message to be included with this line item. Contains personal message content for gift orders.',
    `gift_wrap_flag` BOOLEAN COMMENT 'Indicates whether gift wrapping service was requested for this line item. True if gift wrap required, false otherwise.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this line item contains hazardous materials requiring special handling and shipping compliance. True if hazardous, false otherwise.',
    `line_number` STRING COMMENT 'Sequential line number within the fulfillment order. Used for ordering and referencing specific line items.',
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
    `pick_zone` STRING COMMENT 'Warehouse zone designation where the item is located. Used for zone-based picking strategies and workforce assignment.. Valid values are `^[A-Z0-9]{1,10}$`',
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
    CONSTRAINT pk_fulfillment_order_line PRIMARY KEY(`fulfillment_order_line_id`)
) COMMENT 'Line-level detail for each SKU within a fulfillment order, serving as the unified pick-and-allocate record. Captures SKU identifier, ordered/allocated/picked/packed quantities, unit of measure, bin/slot location at time of pick, substitution flags, line-level fulfillment status, assigned picker (associate ID or robot unit), pick zone, pick method (single-order, batch, zone, wave), pick start/completion timestamps, pick exceptions (short pick, mispick), and confirmation status. SSOT for SKU-level fulfillment execution including pick task assignment and completion within the WMS workflow.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` (
    `packing_slip_id` BIGINT COMMENT 'Unique identifier for the packing slip record. Primary key for the packing slip entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier assignment for packing slips is required for carrier billing and performance reporting; linking provides authoritative carrier data.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Needed for packing slip generation: links each slip to its template asset in content for audit and versioning.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this packing slip. Links the packed carton to the outbound shipment.',
    `header_id` BIGINT COMMENT 'Reference to the parent fulfillment order that this packing slip belongs to. Links the packing slip to the originating customer order.',
    `pack_station_id` BIGINT COMMENT 'Identifier of the physical pack station or workstation where the order was packed. Used for operational tracking and productivity analysis.',
    `agent_id` BIGINT COMMENT 'Employee or associate identifier of the warehouse worker who performed the packing operation. Used for quality tracking and performance management.',
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
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Required for label generation: each shipping label references the digital asset template stored in content for version control and compliance.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the outbound shipment associated with this label.',
    `header_id` BIGINT COMMENT 'Identifier of the order associated with this shipping label.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Label generation uses pricing rules from a price list; needed for the Shipping Label Pricing audit.',
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
    `carrier_id` BIGINT COMMENT 'FK to logistics.carrier',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating outbound shipping expenses to the appropriate cost center for accurate cost accounting and financial reporting.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who will receive the shipment.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Order‑to‑Shipment association needed for shipping status dashboard and carrier billing reconciliation.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Required for shipment‑payment reconciliation report linking each shipment to the payment transaction that funded it.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Shipping cost calculations reference a price list; required for the Shipment Cost Allocation process.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Outbound shipments for drop‑ship orders must be associated with the originating purchase order to align carrier billing and delivery performance metrics.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Regulatory compliance reporting for each shipment (customs, hazardous material) requires linking shipment to the applicable regulation.',
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
    `service_level` STRING COMMENT 'Service level agreement for delivery speed.. Valid values are `standard|priority|same_day`',
    `ship_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment was dispatched from the fulfillment center.',
    `shipment_number` STRING COMMENT 'Business identifier assigned to the shipment for tracking and reference.',
    `shipment_type` STRING COMMENT 'Indicates whether the shipment is a normal outbound, a return, or an internal transfer.. Valid values are `outbound|return|transfer`',
    `shipping_cost_currency` STRING COMMENT 'Three-letter ISO currency code for the shipping cost.',
    `shipping_cost_gross` DECIMAL(18,2) COMMENT 'Total shipping cost before taxes and adjustments.',
    `shipping_cost_net` DECIMAL(18,2) COMMENT 'Net shipping cost after tax adjustments.',
    `shipping_cost_tax` DECIMAL(18,2) COMMENT 'Tax component of the shipping cost.',
    `shipping_method` STRING COMMENT 'Method used to transport the shipment.. Valid values are `ground|air|sea|express`',
    `shipping_priority` STRING COMMENT 'Priority level assigned to the shipment.. Valid values are `standard|expedited|overnight`',
    `tracking_number` STRING COMMENT 'Unique tracking identifier provided by the carrier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width of the shipment package in centimeters.',
    CONSTRAINT pk_fulfillment_shipment PRIMARY KEY(`fulfillment_shipment_id`)
) COMMENT 'Core transactional record representing a physical outbound shipment dispatched from a fulfillment center to a customer or intermediate hub. Tracks shipment status (manifested, in-transit, out-for-delivery, delivered, exception, returned), carrier, tracking number, ship date, estimated delivery date, actual delivery date, shipment weight, dimensions, declared value, and proof-of-delivery reference. Bridges fulfillment execution and last-mile logistics; integrates with TMS for carrier tracking events.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` (
    `shipment_event_id` BIGINT COMMENT 'Unique identifier for the shipment tracking event record. Primary key for the shipment event log.',
    `agent_id` BIGINT COMMENT 'Reference to the warehouse or carrier employee who performed the scan or recorded the event. Used for internal audit and quality tracking. Null for automated or carrier-reported events.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier (e.g., FedEx, UPS, USPS, DHL) that reported this tracking event. Links to carrier master data.',
    `center_id` BIGINT COMMENT 'Reference to the warehouse, fulfillment center, or carrier facility where the event occurred. Links to facility master data for internal events.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the parent shipment container that this event belongs to. Links this tracking event to the overall shipment record.',
    `header_id` BIGINT COMMENT 'Reference to the customer order associated with this shipment event. Enables order-level tracking and SLA monitoring.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Event‑level incidents (e.g., customs holds) must be linked to the governing compliance obligation for reporting.',
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
    `customer_profile_id` BIGINT COMMENT 'Identifier of the party who received the shipment.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the shipment that this proof of delivery belongs to.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Proof‑of‑Delivery must be tied to originating order for compliance audit and customer dispute resolution.',
    `carrier_code` STRING COMMENT 'Identifier code of the carrier that performed the final delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proof of delivery record was first created in the system.',
    `delivery_address` STRING COMMENT 'Street address where the delivery was made.',
    `delivery_confirmation_code` STRING COMMENT 'Code provided by the carrier confirming successful delivery.',
    `delivery_confirmation_number` STRING COMMENT 'External reference number assigned to the delivery confirmation event.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` (
    `receiving_record_id` BIGINT COMMENT 'Unique identifier for the receiving record.',
    `fulfillment_shipment_id` BIGINT COMMENT 'System‑generated identifier for the inbound shipment batch.',
    `inventory_goods_receipt_id` BIGINT COMMENT 'FK to inventory.goods_receipt.goods_receipt_id — Dock receipt to stock putaway traceability. Links the physical receiving event at the dock to the inventory systems goods receipt for stock position updates — essential for inbound supply chain visib',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Receiving records must reference the purchase order they fulfill to support three‑way match, invoice validation, and supplier performance tracking.',
    `agent_id` BIGINT COMMENT 'Identifier of the warehouse associate who performed the receipt.',
    `receiving_putaway_associate_agent_id` BIGINT COMMENT 'Identifier of the associate who performed the putaway operation.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Supports the Receiving and Put‑away workflow, linking each inbound receipt to the SKU for inventory reconciliation.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier who shipped the goods.',
    `asn_number` STRING COMMENT 'Identifier of the ASN sent by the supplier for this inbound shipment.',
    `condition_code` STRING COMMENT 'Condition of the received items (e.g., new, damaged, quarantine).. Valid values are `new|damaged|quarantine`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost associated with the received goods (pre‑tax, pre‑discount).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `discrepancy_flag` STRING COMMENT 'Flag indicating any quantity or condition discrepancy detected during receiving.. Valid values are `none|overage|shortage|damage`',
    `dock_door` STRING COMMENT 'Code of the dock door where the shipment was received.',
    `po_number` STRING COMMENT 'External purchase order identifier associated with the inbound shipment.',
    `putaway_bin` STRING COMMENT 'Location bin/slot where items were placed after receiving.',
    `putaway_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the putaway task was completed.',
    `putaway_method` STRING COMMENT 'Method used to assign the putaway location (directed, random, or fixed).. Valid values are `directed|random|fixed`',
    `putaway_status` STRING COMMENT 'Current status of the putaway task.. Valid values are `pending|assigned|completed|failed`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was physically received at the dock.',
    `receipt_type` STRING COMMENT 'Classification of the receipt (e.g., purchase order, transfer, return).. Valid values are `purchase_order|transfer|return`',
    `received_sku_count` STRING COMMENT 'Number of distinct SKU types received in this transaction.',
    `receiving_record_status` STRING COMMENT 'Current lifecycle status of the receiving record.. Valid values are `pending|in_progress|completed|cancelled`',
    `total_quantity_received` BIGINT COMMENT 'Aggregate count of all units received in this transaction.',
    `total_volume_cubic_m` DECIMAL(18,2) COMMENT 'Combined volume of all items received, measured in cubic meters.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Combined weight of all items received, measured in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the receiving record.',
    CONSTRAINT pk_receiving_record PRIMARY KEY(`receiving_record_id`)
) COMMENT 'Transactional record and SSOT for the complete inbound receiving-through-putaway process at a fulfillment center. Tracks PO reference, ASN reference, received SKUs and quantities, condition codes (new, damaged, quarantine), receiving associate ID, dock door, receipt timestamp, discrepancy flags (over/short/damaged), assigned putaway bin/slot location, putaway method (directed, random, fixed), putaway associate ID, putaway task status, and putaway completion timestamp. Unified inbound flow record from dock receipt through inventory slotting, eliminating the need for separate putaway task tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` (
    `bin_location_id` BIGINT COMMENT 'System-generated unique identifier for each physical storage location.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Bin locations belong to a specific fulfillment center; adding center_id FK enables hierarchy and eliminates silo.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` (
    `fulfillment_sla_id` BIGINT COMMENT 'Unique system-generated identifier for the SLA record.',
    `center_id` BIGINT COMMENT 'Identifier of the fulfillment center or warehouse to which the SLA applies.',
    `breach_threshold_days` DECIMAL(18,2) COMMENT 'Tolerance window in days for delivery‑time breaches.',
    `breach_threshold_hours` DECIMAL(18,2) COMMENT 'Tolerance window in hours beyond the target after which the SLA is considered breached.',
    `carrier_service_level` STRING COMMENT 'Carrier service tier (e.g., ground, 2‑day, overnight) covered by the SLA.. Valid values are `ground|2day|overnight|same_day`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment (e.g., consumer, prime) for which the SLA is defined.. Valid values are `consumer|prime|business|enterprise`',
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
    CONSTRAINT pk_fulfillment_sla PRIMARY KEY(`fulfillment_sla_id`)
) COMMENT 'Reference record defining SLA commitments by fulfillment method, carrier service level, customer segment, and fulfillment center. Captures promised pick/pack/ship SLA windows (hours), delivery window (days), same-day cutoff time, breach thresholds, and effective date range. Drives SLA compliance monitoring, fulfillment_exception breach detection, and carrier selection logic.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` (
    `third_party_fulfillment_id` BIGINT COMMENT 'Unique surrogate key for the third‑party fulfillment partner record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Third‑party partners are required to meet specific compliance obligations; linking enables monitoring and reporting.',
    `billing_model` STRING COMMENT 'Billing arrangement with the partner.. Valid values are `per_shipment|per_volume|flat_fee|subscription`',
    `compliance_certifications` STRING COMMENT 'List of compliance certifications held by the partner (e.g., ISO 27001, PCI DSS).',
    `contract_end_date` DATE COMMENT 'Date when the contract expires or is terminated.',
    `contract_number` STRING COMMENT 'External contract reference number.',
    `contract_start_date` DATE COMMENT 'Date when the contract becomes effective.',
    `contracted_sla_tier` STRING COMMENT 'Service level agreement tier contracted with the partner.. Valid values are `standard|gold|platinum|custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner record was created.',
    `data_privacy_agreement` BOOLEAN COMMENT 'Indicates whether a data privacy agreement is in place.',
    `escalation_contact_email` STRING COMMENT 'Email for escalation contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'Name of the contact for issue escalation.',
    `escalation_contact_phone` STRING COMMENT 'Phone number for escalation contact.',
    `fee_currency` STRING COMMENT 'Currency of the billing fees.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `fee_per_shipment` DECIMAL(18,2) COMMENT 'Cost charged per shipment processed by the partner.',
    `geographic_coverage_zones` STRING COMMENT 'Regions or zones the partner serves.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum insurance coverage amount provided by the partner.',
    `insurance_currency` STRING COMMENT 'Currency of the insurance coverage amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `integration_type` STRING COMMENT 'Method used to integrate with the partners system.. Valid values are `EDI|API|Portal|FTP`',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks about the partner.',
    `onboarding_status` STRING COMMENT 'Current status of the partner onboarding process.. Valid values are `pending|in_progress|completed|rejected`',
    `partner_name` STRING COMMENT 'Legal name of the 3PL partner.',
    `partner_type` STRING COMMENT 'Classification of the partner (e.g., logistics provider, carrier).. Valid values are `logistics|carrier|fulfillment_center|broker`',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the partner.. Valid values are `net_30|net_45|net_60|prepaid|upon_delivery`',
    `performance_score` DECIMAL(18,2) COMMENT 'Overall performance score (0‑100) based on scorecard metrics.',
    `primary_contact_email` STRING COMMENT 'Email address for the primary contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the main operational contact at the partner.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the primary contact.',
    `sla_target_time_minutes` STRING COMMENT 'Target time in minutes for order fulfillment as per SLA.',
    `supported_fulfillment_methods` STRING COMMENT 'Fulfillment methods the partner can perform.. Valid values are `pick_pack|ship_to_customer|drop_ship|BOPIS|store_delivery`',
    `third_party_fulfillment_status` STRING COMMENT 'Current lifecycle status of the partner relationship.. Valid values are `active|inactive|suspended|terminated|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner record.',
    CONSTRAINT pk_third_party_fulfillment PRIMARY KEY(`third_party_fulfillment_id`)
) COMMENT 'Master record representing a 3PL (Third-Party Logistics) partner engagement for fulfillment outsourcing. Captures 3PL partner name, integration type (EDI, API, portal), supported fulfillment methods, geographic coverage zones, contracted SLA tiers, onboarding status, performance scorecard metrics, billing model, and operational contact details. SSOT for 3PL partner configuration within the fulfillment domain; distinct from seller domain marketplace partner records.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` (
    `bopis_order_id` BIGINT COMMENT 'Unique surrogate key for the BOPIS order record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed to attribute BOPIS sales to specific campaigns for performance dashboards; marketing budgets are allocated based on in‑store pickup conversions.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: BOPIS orders are picked up at a specific fulfillment center; linking provides clear center association.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Links BOPIS order to the in‑store pickup signage asset, enabling consistent branding and localized asset management.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who initiated the BOPIS order.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: BOPIS orders are a subset of standard orders; linking to order header allows inventory allocation and sales reporting.',
    `store_id` BIGINT COMMENT 'Identifier of the physical store where the customer will collect the order.',
    `associate_handoff_timestamp` TIMESTAMP COMMENT 'Timestamp when the store associate handed the order to the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOPIS order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the order.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `customer_checkin_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer checked in at the store to collect the order.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Timestamp after which an unclaimed BOPIS order is automatically cancelled.',
    `final_disposition` STRING COMMENT 'Outcome of the BOPIS order after the pickup window closes.. Valid values are `picked_up|cancelled|converted_to_ship|expired|no_show`',
    `fraud_check_status` STRING COMMENT 'Result of automated fraud screening for the order.. Valid values are `clear|review|blocked`',
    `gift_message` STRING COMMENT 'Message entered by the purchaser to be included with the gift.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the order before taxes, discounts, or fees.',
    `is_contactless` BOOLEAN COMMENT 'Indicates whether the pickup was performed without physical contact.',
    `is_expedited` BOOLEAN COMMENT 'True if the customer selected an expedited handling option.',
    `is_gift` BOOLEAN COMMENT 'True if the order was marked as a gift for another recipient.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes, discounts, and fees.',
    `notes` STRING COMMENT 'Free‑form notes added by staff for internal reference.',
    `order_number` STRING COMMENT 'External order identifier used in customer communications and tracking.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOPIS order was initially placed by the customer.',
    `order_source` STRING COMMENT 'Channel through which the BOPIS order was created.. Valid values are `online|mobile_app|in_store_kiosk`',
    `order_status` STRING COMMENT 'Current lifecycle state of the BOPIS order.. Valid values are `created|ready|picked_up|cancelled|converted_to_ship|expired`',
    `payment_method` STRING COMMENT 'Payment instrument used for the order.. Valid values are `credit_card|debit_card|paypal|apple_pay|google_pay|gift_card`',
    `payment_status` STRING COMMENT 'Current processing state of the payment.. Valid values are `authorized|captured|settled|failed|refunded`',
    `pickup_confirmation_method` STRING COMMENT 'Method used to verify the customer at pickup.. Valid values are `qr_code|id_check|pin|signature`',
    `pickup_location_code` STRING COMMENT 'Alphanumeric code representing the specific pickup area or locker within the store.',
    `pickup_window_end` TIMESTAMP COMMENT 'End of the customer‑selected time window for order pickup.',
    `pickup_window_start` TIMESTAMP COMMENT 'Start of the customer‑selected time window for order pickup.',
    `ready_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was marked ready for customer pickup.',
    `shipping_method` STRING COMMENT 'Method selected for delivering the order when not picked up in store.. Valid values are `standard|express|same_day|store_pickup`',
    `sla_actual_minutes` STRING COMMENT 'Actual time (in minutes) taken to make the order ready for pickup.',
    `sla_target_minutes` STRING COMMENT 'Service level agreement target time (in minutes) for order readiness.',
    `special_instructions` STRING COMMENT 'Any additional handling or customer‑provided instructions for the order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the order.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BOPIS order record.',
    CONSTRAINT pk_bopis_order PRIMARY KEY(`bopis_order_id`)
) COMMENT 'Transactional record managing the Buy Online Pick Up In Store (BOPIS) fulfillment workflow. Captures BOPIS order reference, designated pickup store/location, customer-selected pickup window, order ready notification timestamp, customer check-in timestamp, associate-assisted handoff timestamp, pickup confirmation method (QR code, ID check, PIN), expiry timestamp for unclaimed orders, and final disposition (picked up, cancelled, converted to ship). Distinct from standard fulfillment orders due to its store-based pickup workflow.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` (
    `return_receipt_id` BIGINT COMMENT 'Unique identifier for the return receipt record.',
    `agent_id` BIGINT COMMENT 'Identifier of the associate who logged the receipt.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who initiated the return.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Return receipts are generated for returns of a fulfillment order; linking enables traceability back to the original order.',
    `header_id` BIGINT COMMENT 'Identifier of the original order linked to this return.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Return receipts are linked to the original purchase order to reconcile refunds, restocking fees, and supplier credit.',
    `authorization_id` BIGINT COMMENT 'Identifier of the refund authorization workflow.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Enables the Return Processing system to attribute refunds and restocking decisions to the specific SKU returned.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse where the return was received.',
    `carrier_code` STRING COMMENT 'Code of the carrier used for the return shipment.',
    `condition_assessment` STRING COMMENT 'Assessment of the returned items condition for disposition.. Valid values are `resellable|refurbish|liquidate|destroy|damaged|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the return receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the refund.. Valid values are `^[A-Z]{3}$`',
    `disposition_route` STRING COMMENT 'Routing decision for the returned items after inspection.. Valid values are `stock|quarantine|vendor_return|disposal`',
    `gross_refund_amount` DECIMAL(18,2) COMMENT 'Total refund amount before deductions.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp when the returned items were inspected.',
    `is_priority_return` BOOLEAN COMMENT 'True if the return is marked for expedited processing.',
    `location_code` STRING COMMENT 'Specific location or bin code within the warehouse.',
    `net_refund_amount` DECIMAL(18,2) COMMENT 'Refund amount after tax and any fees.',
    `notes` STRING COMMENT 'Free‑form notes entered by the associate during receipt.',
    `original_order_number` STRING COMMENT 'Human‑readable order number of the original purchase.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Timestamp when the physical return was received at the fulfillment center.',
    `refund_status` STRING COMMENT 'Current status of the refund process.. Valid values are `pending|approved|rejected|completed`',
    `restocking_eligible` BOOLEAN COMMENT 'Indicates whether the returned items can be restocked.',
    `return_reason_code` STRING COMMENT 'Standardized code describing why the item was returned.. Valid values are `defective|unsatisfied|wrong_item|other`',
    `return_receipt_status` STRING COMMENT 'Current processing status of the return receipt.. Valid values are `received|inspected|processed|closed|rejected`',
    `return_type` STRING COMMENT 'High‑level classification of the return.. Valid values are `defective|unsatisfied|wrong_item|other`',
    `rma_number` STRING COMMENT 'External RMA reference number associated with the return.',
    `sla_actual_hours` STRING COMMENT 'Actual number of hours taken to process the return.',
    `sla_target_hours` STRING COMMENT 'Target number of hours to complete return processing per SLA.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the refund.',
    `total_items` STRING COMMENT 'Number of distinct SKU identifiers in the return.',
    `total_quantity` STRING COMMENT 'Aggregate quantity of all returned items.',
    `tracking_number` STRING COMMENT 'Tracking number for the inbound return shipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the return receipt record.',
    CONSTRAINT pk_return_receipt PRIMARY KEY(`return_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt and inspection of a customer return at a fulfillment center or returns processing hub. Records RMA reference, returned SKUs and quantities, condition assessment per item (resellable, refurbish, liquidate, destroy), return reason codes, restocking eligibility flags, receiving associate ID, inspection timestamp, and disposition routing (back to stock, quarantine, vendor return, disposal). Feeds inventory reintegration and refund authorization workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` (
    `fulfillment_exception_id` BIGINT COMMENT 'System-generated unique identifier for each fulfillment exception record.',
    `compliance_exception_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_exception. Business justification: Operational exceptions often trigger a formal compliance exception record for audit and risk tracking.',
    `fulfillment_order_id` BIGINT COMMENT 'Identifier of the order associated with the exception.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the shipment linked to the exception.',
    `team_id` BIGINT COMMENT 'Foreign key linking to service.team. Business justification: Exceptions are assigned to a service team for resolution; storing the handling team ID supports workload balancing, SLA monitoring, and root‑cause reporting.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Fulfillment exceptions are analyzed per order to calculate SLA breach impact; linking enables Order Exception Summary report.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Needed for the Exception Management report to identify which SKU caused the fulfillment exception and drive corrective actions.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the specific location (e.g., dock, zone) related to the exception.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse where the exception originated.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the activity actually completed.',
    `breach_duration_minutes` DECIMAL(18,2) COMMENT 'Length of SLA breach measured in minutes.',
    `breach_duration_seconds` BIGINT COMMENT 'Length of SLA breach measured in seconds.',
    `carrier_name` STRING COMMENT 'Name of the carrier involved in the exception, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was first created in the system.',
    `customer_impact` BOOLEAN COMMENT 'True if the exception directly affected the customer experience.',
    `escalated_to` STRING COMMENT 'Role or individual to whom the exception was escalated.. Valid values are `manager|director|vp|cxo`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception was escalated to a higher authority.',
    `exception_code` STRING COMMENT 'Internal code used to classify the exception for reporting.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception record.. Valid values are `open|in_progress|resolved|closed`',
    `exception_timestamp` TIMESTAMP COMMENT 'Exact time when the exception was detected in the fulfillment process.',
    `exception_type` STRING COMMENT 'Category of the exception (e.g., short pick, damaged item, mispick, label error, carrier refusal, address undeliverable, lost in transit, dock delay, SLA breach types). [ENUM-REF-CANDIDATE: short_pick|damaged_item|mispick|label_error|carrier_refusal|address_undeliverable|lost_in_transit|dock_delay|pick_sla_breach|pack_sla_breach|ship_sla_breach|delivery_sla_breach — promote to reference product]',
    `expected_completion_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the activity that was breached (used for SLA calculations).',
    `fulfillment_exception_description` STRING COMMENT 'Free‑text description providing details of the exception event.',
    `impact_metric` STRING COMMENT 'Metric used to quantify the business impact of the exception.. Valid values are `order_delay|inventory_impact|customer_complaint|financial_loss|operational_disruption`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the exception is deemed critical for business continuity.',
    `is_repeat` BOOLEAN COMMENT 'Indicates if this exception is a repeat occurrence for the same order or shipment.',
    `is_sla_breach` BOOLEAN COMMENT 'Indicates whether the exception resulted in an SLA breach.',
    `notes` STRING COMMENT 'Free‑form notes captured by the handling team.',
    `priority_level` STRING COMMENT 'Operational priority assigned to the exception.. Valid values are `low|medium|high|urgent`',
    `repeat_count` STRING COMMENT 'Number of times the same exception has recurred.',
    `resolution_action` STRING COMMENT 'Action taken to remediate or mitigate the exception.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception was resolved.',
    `responsible_party` STRING COMMENT 'Entity accountable for the exception (e.g., fulfillment center, carrier, 3PL, seller, system).. Valid values are `fulfillment_center|carrier|third_party_logistics|seller|system`',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause of the exception.. Valid values are `process_error|system_error|human_error|carrier_issue|inventory_issue|unknown`',
    `severity_level` STRING COMMENT 'Impact severity of the exception on fulfillment operations.. Valid values are `low|medium|high|critical`',
    `sla_actual_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA‑bound activity actually finished.',
    `sla_target_timestamp` TIMESTAMP COMMENT 'Timestamp representing the SLA promised completion time.',
    `sla_type` STRING COMMENT 'Specific SLA category the exception relates to.. Valid values are `pick_sla|pack_sla|ship_sla|delivery_sla`',
    `source_system` STRING COMMENT 'Originating operational system that generated the exception record.. Valid values are `OMS|WMS|TMS|ERP|SCP`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exception record.',
    CONSTRAINT pk_fulfillment_exception PRIMARY KEY(`fulfillment_exception_id`)
) COMMENT 'Operational record capturing all exceptions and disruptions during the fulfillment lifecycle, including SLA breaches. Records exception type (short pick, damaged item, mispick, label error, carrier refusal, address undeliverable, lost in transit, dock delay, pick_sla_breach, pack_sla_breach, ship_sla_breach, delivery_sla_breach), severity level, affected fulfillment order or shipment, exception timestamp, expected vs actual completion timestamps (for SLA breaches), breach duration, root cause category, responsible party (FC, carrier, 3PL), resolution action, and resolution timestamp. Enables unified exception management, SLA compliance monitoring, and root cause analysis for operational improvement.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`store` (
    `store_id` BIGINT COMMENT 'Primary key for store',
    `pickup_store_id` BIGINT COMMENT 'Self-referencing FK on store (pickup_store_id)',
    `address_line1` STRING COMMENT 'Primary street address of the store.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_per_day` STRING COMMENT 'Maximum number of orders the store can process per day.',
    `city` STRING COMMENT 'City where the store is located.',
    `closing_date` DATE COMMENT 'Date when the store ceased operations (null if still open).',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the store location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the store record was first created.',
    `email` STRING COMMENT 'Primary email address for store communications.',
    `has_parking` BOOLEAN COMMENT 'True if the store provides customer parking.',
    `is_24h_operation` BOOLEAN COMMENT 'Indicates whether the store operates 24 hours a day.',
    `is_accessible` BOOLEAN COMMENT 'True if the store meets accessibility standards (e.g., ADA).',
    `last_inventory_audit_date` DATE COMMENT 'Date of the most recent inventory audit for the store.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the store (decimal degrees).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the store (decimal degrees).',
    `manager_email` STRING COMMENT 'Email address of the store manager.',
    `manager_name` STRING COMMENT 'Full name of the store manager.',
    `manager_phone` STRING COMMENT 'Phone number of the store manager.',
    `store_name` STRING COMMENT 'Human‑readable name of the store.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the store.',
    `opening_date` DATE COMMENT 'Date when the store began operations.',
    `operating_hours` STRING COMMENT 'Daily operating window expressed as HH:MM-HH:MM.',
    `phone_number` STRING COMMENT 'Primary telephone number for the store.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the store address.',
    `square_footage` STRING COMMENT 'Total floor area of the store in square feet.',
    `state` STRING COMMENT 'State or province of the store location.',
    `store_status` STRING COMMENT 'Current operational status of the store.',
    `store_code` STRING COMMENT 'External code used to reference the store in operational systems.',
    `store_group` STRING COMMENT 'Logical grouping of stores for operational management.',
    `store_region` STRING COMMENT 'Geographic region grouping for reporting (e.g., North America, EMEA).',
    `store_sla_minutes` STRING COMMENT 'Target fulfillment service‑level agreement time in minutes for orders processed at this store.',
    `store_type` STRING COMMENT 'Category of the store indicating its fulfillment role.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the store (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the store record.',
    CONSTRAINT pk_store PRIMARY KEY(`store_id`)
) COMMENT 'Master reference table for store. Referenced by pickup_store_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`carton` (
    `carton_id` BIGINT COMMENT 'Primary key for carton',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse location where the carton is stored.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order that was used to acquire the carton.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier that provided the carton.',
    `parent_carton_id` BIGINT COMMENT 'Self-referencing FK on carton (parent_carton_id)',
    `aisle` STRING COMMENT 'Aisle where the carton is located.',
    `barcode` STRING COMMENT 'Alphanumeric barcode printed on the carton for scanning.',
    `batch_number` STRING COMMENT 'Batch identifier for the production run of the carton.',
    `carton_code` STRING COMMENT 'External reference code or barcode printed on the carton.',
    `carton_type` STRING COMMENT 'Category describing the physical characteristics or special requirements of the carton.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of compliance or safety certifications applicable to the carton.',
    `cost` DECIMAL(18,2) COMMENT 'Acquisition cost of the carton.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp of initial record creation in the data lake.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost.',
    `disposal_date` DATE COMMENT 'Date on which the carton was removed from inventory and disposed.',
    `expiration_date` DATE COMMENT 'Date after which the carton is considered expired or unsuitable.',
    `handling_instructions` STRING COMMENT 'Textual instructions for safe handling of the carton.',
    `hazardous_classification` STRING COMMENT 'Regulatory classification of the hazardous material inside the carton.',
    `height_cm` STRING COMMENT 'Height of the carton in centimeters.',
    `humidity_controlled_flag` BOOLEAN COMMENT 'True if the carton requires humidity‑controlled storage.',
    `inspection_status` STRING COMMENT 'Outcome of the latest inspection of the carton.',
    `is_fragile_flag` BOOLEAN COMMENT 'True when the carton holds fragile goods.',
    `is_hazardous_flag` BOOLEAN COMMENT 'True when the carton contains hazardous items.',
    `last_inspected_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent physical inspection.',
    `length_cm` STRING COMMENT 'Length of the carton in centimeters.',
    `lot_number` STRING COMMENT 'Lot number for traceability of the carton.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactures the carton.',
    `material` STRING COMMENT 'Material from which the carton is constructed (e.g., cardboard, plastic).',
    `max_load_kg` DECIMAL(18,2) COMMENT 'Maximum permissible load weight for the carton.',
    `carton_name` STRING COMMENT 'Descriptive name of the carton used in reports and UI.',
    `production_date` DATE COMMENT 'Calendar date when the carton was manufactured.',
    `recycle_status` STRING COMMENT 'Current recycling disposition of the carton.',
    `rfid_tag` STRING COMMENT 'RFID tag identifier attached to the carton.',
    `shelf` STRING COMMENT 'Shelf on which the carton rests.',
    `slot` STRING COMMENT 'Slot position on the shelf for the carton.',
    `carton_status` STRING COMMENT 'Indicates whether the carton is in service, damaged, lost, etc.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'True if the carton must be stored in a temperature‑controlled environment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the carton record.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Internal cubic meter capacity of the carton.',
    `warranty_expiration_date` DATE COMMENT 'Date when the carton’s warranty expires.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the empty carton in kilograms.',
    `width_cm` STRING COMMENT 'Width of the carton in centimeters.',
    `zone` STRING COMMENT 'Zone designation within the warehouse.',
    CONSTRAINT pk_carton PRIMARY KEY(`carton_id`)
) COMMENT 'Master reference table for carton. Referenced by carton_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` (
    `pack_station_id` BIGINT COMMENT 'Primary key for pack_station',
    `overflow_pack_station_id` BIGINT COMMENT 'Self-referencing FK on pack_station (overflow_pack_station_id)',
    `address_line1` STRING COMMENT 'Primary street address of the pack station.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit).',
    `capacity_per_hour` DECIMAL(18,2) COMMENT 'Maximum number of orders the station can pack per hour.',
    `city` STRING COMMENT 'City where the pack station is located.',
    `compliance_certification` STRING COMMENT 'Certification(s) the station complies with.',
    `compliance_expiration_date` DATE COMMENT 'Date when the current compliance certification expires.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the station location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack station record was created.',
    `current_load_kg` DECIMAL(18,2) COMMENT 'Current total weight of items being processed at the station.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in emergencies at the station.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `equipment_printer_model` STRING COMMENT 'Model identifier of the label printer used at the station.',
    `equipment_scanner_model` STRING COMMENT 'Model identifier of the barcode scanner used at the station.',
    `floor_area_sqft` DECIMAL(18,2) COMMENT 'Physical floor area occupied by the station.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the station is currently active in the fulfillment network.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the station operates fully automatically.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `last_sla_breach_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent SLA breach event.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate.',
    `maintenance_status` STRING COMMENT 'Current status of the maintenance schedule.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum total weight the station can handle at one time.',
    `network_ip` STRING COMMENT 'IP address assigned to the station for network connectivity.',
    `network_mac` STRING COMMENT 'MAC address of the stations network interface.',
    `next_maintenance_due` DATE COMMENT 'Scheduled date for the next maintenance.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the station.',
    `operating_hours` STRING COMMENT 'Daily operating window (e.g., 08:00-17:00).',
    `postal_code` STRING COMMENT 'Postal code for the pack station address.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Electrical power rating of the station.',
    `shift` STRING COMMENT 'Work shift assigned to the station.',
    `sla_actual_minutes` STRING COMMENT 'Actual time taken to complete packing.',
    `sla_target_minutes` STRING COMMENT 'Target time in minutes for packing SLA.',
    `state` STRING COMMENT 'State or province of the pack station location.',
    `station_code` STRING COMMENT 'External code used to reference the pack station in operational systems.',
    `station_name` STRING COMMENT 'Human‑readable name of the pack station.',
    `station_type` STRING COMMENT 'Classification of the station based on automation level.',
    `pack_station_status` STRING COMMENT 'Current lifecycle status of the pack station.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Current ambient temperature at the station.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of capacity currently utilized.',
    CONSTRAINT pk_pack_station PRIMARY KEY(`pack_station_id`)
) COMMENT 'Master reference table for pack_station. Referenced by pack_station_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` (
    `pick_wave_id` BIGINT COMMENT 'Primary key for pick_wave',
    `agent_id` BIGINT COMMENT 'Identifier of the primary picker or team lead responsible for the wave.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse where the wave is being executed.',
    `split_from_pick_wave_id` BIGINT COMMENT 'Self-referencing FK on pick_wave (split_from_pick_wave_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick wave record was first persisted.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the wave was generated automatically by the system (true) or manually by an operator (false).',
    `operator_notes` STRING COMMENT 'Free‑form notes entered by the operator during wave creation or execution.',
    `priority` STRING COMMENT 'Numeric priority used by the WMS to order wave execution; lower numbers indicate higher priority.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end time for the wave execution.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start time for the wave execution.',
    `sla_actual_minutes` STRING COMMENT 'Actual elapsed time in minutes from wave start to completion.',
    `sla_target_minutes` STRING COMMENT 'Target time in minutes to complete the wave as defined by service level agreements.',
    `pick_wave_status` STRING COMMENT 'Current lifecycle state of the wave.',
    `total_items` BIGINT COMMENT 'Total number of individual line items across all orders in the wave.',
    `total_orders` BIGINT COMMENT 'Count of distinct orders included in the wave.',
    `total_quantity` BIGINT COMMENT 'Aggregate quantity (units) of all items to be picked in the wave.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the pick wave record.',
    `wave_description` STRING COMMENT 'Free‑form text describing the waves characteristics, special handling instructions, or business rationale.',
    `wave_initiated_timestamp` TIMESTAMP COMMENT 'Timestamp when the wave was created and released for picking.',
    `wave_name` STRING COMMENT 'Descriptive name given to the wave to convey its purpose or grouping.',
    `wave_number` STRING COMMENT 'Human‑readable identifier or code assigned to the pick wave for operational tracking.',
    `wave_type` STRING COMMENT 'Category of the wave indicating its operational priority or purpose.',
    CONSTRAINT pk_pick_wave PRIMARY KEY(`pick_wave_id`)
) COMMENT 'Master reference table for pick_wave. Referenced by pick_wave_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_pick_wave_id` FOREIGN KEY (`pick_wave_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`pick_wave`(`pick_wave_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_third_party_fulfillment_id` FOREIGN KEY (`third_party_fulfillment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment`(`third_party_fulfillment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_carton_id` FOREIGN KEY (`carton_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`carton`(`carton_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_pack_station_id` FOREIGN KEY (`pack_station_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`pack_station`(`pack_station_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ADD CONSTRAINT `fk_fulfillment_receiving_record_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ADD CONSTRAINT `fk_fulfillment_bin_location_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ADD CONSTRAINT `fk_fulfillment_fulfillment_sla_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ADD CONSTRAINT `fk_fulfillment_bopis_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ADD CONSTRAINT `fk_fulfillment_bopis_order_store_id` FOREIGN KEY (`store_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`store`(`store_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ADD CONSTRAINT `fk_fulfillment_store_pickup_store_id` FOREIGN KEY (`pickup_store_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`store`(`store_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` ADD CONSTRAINT `fk_fulfillment_carton_parent_carton_id` FOREIGN KEY (`parent_carton_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`carton`(`carton_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ADD CONSTRAINT `fk_fulfillment_pack_station_overflow_pack_station_id` FOREIGN KEY (`overflow_pack_station_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`pack_station`(`pack_station_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` ADD CONSTRAINT `fk_fulfillment_pick_wave_split_from_pick_wave_id` FOREIGN KEY (`split_from_pick_wave_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`pick_wave`(`pick_wave_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`fulfillment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`fulfillment` SET TAGS ('dbx_domain' = 'fulfillment');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` SET TAGS ('dbx_subdomain' = 'center_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center (FC) ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Default Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Default Route Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Agent Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `partner_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Operator Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `partner_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ALTER COLUMN `partner_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `pick_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Wave Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `third_party_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Fulfillment Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `fulfillment_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `carton_id` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `carton_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,25}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `listing_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Offer Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'PENDING|CONFIRMED|REJECTED|REQUIRES_REVIEW');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `gift_wrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Fulfillment Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Pick Exception Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_exception_code` SET TAGS ('dbx_value_regex' = 'SHORT_PICK|MISPICK|DAMAGED|EXPIRED|LOCATION_EMPTY|NONE');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Pick Exception Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_method` SET TAGS ('dbx_value_regex' = 'SINGLE_ORDER|BATCH|ZONE|WAVE|CLUSTER');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_zone` SET TAGS ('dbx_business_glossary_term' = 'Pick Zone');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_zone` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `return_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,40}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WMS|OMS|ERP|TMS|MARKETPLACE');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_business_glossary_term' = 'Substituted Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EACH|CASE|PALLET|BOX|PACK|UNIT');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (KG)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `packing_slip_id` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `pack_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Station ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Packer Associate ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ALTER COLUMN `agent_id` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `shipping_label_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Identifier (SLID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (SID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (OID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Customer ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|priority|same_day');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp (SHIP_TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number (SN)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'outbound|return|transfer');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Currency (CUR)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_gross` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Gross');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_net` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Net');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_cost_tax` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Tax');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|sea|express');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_priority` SET TAGS ('dbx_business_glossary_term' = 'Shipping Priority');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `shipping_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (cm)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `shipment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Event ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Scan Operator ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_confirmation_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ALTER COLUMN `delivery_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Number');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` SET TAGS ('dbx_subdomain' = 'center_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `receiving_record_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Record ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Associate ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `receiving_putaway_associate_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Putaway Associate ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice Number (ASN)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'new|damaged|quarantine');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_value_regex' = 'none|overage|shortage|damage');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `dock_door` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `putaway_bin` SET TAGS ('dbx_business_glossary_term' = 'Putaway Bin Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `putaway_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Putaway Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `putaway_method` SET TAGS ('dbx_business_glossary_term' = 'Putaway Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `putaway_method` SET TAGS ('dbx_value_regex' = 'directed|random|fixed');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `putaway_status` SET TAGS ('dbx_business_glossary_term' = 'Putaway Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `putaway_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|completed|failed');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'purchase_order|transfer|return');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `received_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Received SKU Count');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `receiving_record_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `receiving_record_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `total_quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Received');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `total_volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (cubic meters)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` SET TAGS ('dbx_subdomain' = 'center_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `bin_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Location Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `fulfillment_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `breach_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold (Days)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `breach_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'ground|2day|overnight|same_day');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|prime|business|enterprise');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `delivery_time_target_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time Target (Days)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|bopis');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `fulfillment_sla_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `pack_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Pack Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `pick_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Pick Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `same_day_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Same‑Day Cutoff Time');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `ship_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Ship Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'standard|premium|custom');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_sla` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Version');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `third_party_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Fulfillment ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model (TPF Billing Model)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'per_shipment|per_volume|flat_fee|subscription');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications (TPF Certifications)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date (TPF Contract End Date)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (TPF Contract Number)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date (TPF Contract Start Date)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `contracted_sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Contracted SLA Tier (TPF SLA Tier)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `contracted_sla_tier` SET TAGS ('dbx_value_regex' = 'standard|gold|platinum|custom');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (TPF Created Timestamp)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `data_privacy_agreement` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Agreement (TPF Data Privacy Agreement)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email (TPF Escalation Email)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name (TPF Escalation Contact)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone (TPF Escalation Phone)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (TPF Fee Currency)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `fee_per_shipment` SET TAGS ('dbx_business_glossary_term' = 'Fee Per Shipment (TPF Fee Per Shipment)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `geographic_coverage_zones` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Zones (TPF Coverage Zones)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount (TPF Insurance Coverage)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `insurance_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency (TPF Insurance Currency)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `insurance_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type (TPF Integration Type)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `integration_type` SET TAGS ('dbx_value_regex' = 'EDI|API|Portal|FTP');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date (TPF Review Date)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (TPF Notes)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status (TPF Onboarding Status)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Fulfillment Partner Name (TPF Partner Name)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type (TPF Partner Type)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'logistics|carrier|fulfillment_center|broker');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (TPF Payment Terms)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|prepaid|upon_delivery');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score (TPF Performance Score)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (TPF Primary Contact Email)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (TPF Primary Contact Name)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (TPF Primary Contact Phone)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `sla_target_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Time (Minutes) (TPF SLA Target Time)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `supported_fulfillment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Fulfillment Methods (TPF Supported Methods)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `supported_fulfillment_methods` SET TAGS ('dbx_value_regex' = 'pick_pack|ship_to_customer|drop_ship|BOPIS|store_delivery');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `third_party_fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status (TPF Status)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `third_party_fulfillment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (TPF Updated Timestamp)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `bopis_order_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Order ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Store ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `associate_handoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Associate Handoff Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `customer_checkin_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Check‑In Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Expiry Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'picked_up|cancelled|converted_to_ship|expired|no_show');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Check Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_value_regex' = 'clear|review|blocked');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Order Amount');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `is_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Pickup Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Pickup Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Gift Order Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Order Amount');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'online|mobile_app|in_store_kiosk');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'created|ready|picked_up|cancelled|converted_to_ship|expired');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|paypal|apple_pay|google_pay|gift_card');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|failed|refunded');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `pickup_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Pickup Confirmation Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `pickup_confirmation_method` SET TAGS ('dbx_value_regex' = 'qr_code|id_check|pin|signature');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `pickup_location_code` SET TAGS ('dbx_business_glossary_term' = 'Pickup Location Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `pickup_window_end` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window End Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `pickup_window_start` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `ready_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ready for Pickup Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|store_pickup');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Minutes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `return_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Associate ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Authorization ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Return Carrier Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment of Returned Items');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_value_regex' = 'resellable|refurbish|liquidate|destroy|damaged|unknown');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `disposition_route` SET TAGS ('dbx_business_glossary_term' = 'Disposition Routing');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `disposition_route` SET TAGS ('dbx_value_regex' = 'stock|quarantine|vendor_return|disposal');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `gross_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Refund Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `is_priority_return` SET TAGS ('dbx_business_glossary_term' = 'Priority Return Indicator');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `net_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Refund Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Notes');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `original_order_number` SET TAGS ('dbx_business_glossary_term' = 'Original Order Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Capture Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `restocking_eligible` SET TAGS ('dbx_business_glossary_term' = 'Restocking Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defective|unsatisfied|wrong_item|other');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `return_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Status');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `return_receipt_status` SET TAGS ('dbx_value_regex' = 'received|inspected|processed|closed|rejected');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'defective|unsatisfied|wrong_item|other');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Processing Time (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Processing Time (Hours)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Tax Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `total_items` SET TAGS ('dbx_business_glossary_term' = 'Total Distinct SKUs Returned');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity of Items Returned');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Tracking Number');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `fulfillment_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Exception ID (FEID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `compliance_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Exception Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID (FOID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID (SID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Team Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID (LID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID (WID)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp (ACT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration (Minutes) (BD_M)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `breach_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration (Seconds) (BD_S)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name (CN)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag (CIF)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `escalated_to` SET TAGS ('dbx_business_glossary_term' = 'Escalated To (ET)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `escalated_to` SET TAGS ('dbx_value_regex' = 'manager|director|vp|cxo');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp (ET)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code (EC)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status (ES)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Occurrence Timestamp (EOT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type (ET)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `expected_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Completion Timestamp (ECT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `fulfillment_exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description (ED)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `impact_metric` SET TAGS ('dbx_business_glossary_term' = 'Impact Metric (IM)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `impact_metric` SET TAGS ('dbx_value_regex' = 'order_delay|inventory_impact|customer_complaint|financial_loss|operational_disruption');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Flag (ICF)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `is_repeat` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Flag (IRF)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `is_sla_breach` SET TAGS ('dbx_business_glossary_term' = 'Is SLA Breach Flag (ISB)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PL)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `repeat_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Count (RC)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action (RA)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp (RT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party (RP)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'fulfillment_center|carrier|third_party_logistics|seller|system');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (RCC)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process_error|system_error|human_error|carrier_issue|inventory_issue|unknown');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SL)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `sla_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Timestamp (SLAAT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Timestamp (SLAT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Type (SLAT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'pick_sla|pack_sla|ship_sla|delivery_sla');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OMS|WMS|TMS|ERP|SCP');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` SET TAGS ('dbx_subdomain' = 'center_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `pickup_store_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`store` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` SET TAGS ('dbx_subdomain' = 'center_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` ALTER COLUMN `carton_id` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` ALTER COLUMN `parent_carton_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` SET TAGS ('dbx_subdomain' = 'center_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `pack_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `overflow_pack_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `network_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `network_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `network_mac` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `network_mac` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pack_station` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` SET TAGS ('dbx_subdomain' = 'center_operations');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` ALTER COLUMN `pick_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Wave Identifier');
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` ALTER COLUMN `split_from_pick_wave_id` SET TAGS ('dbx_self_ref_fk' = 'true');
