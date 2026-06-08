-- Schema for Domain: fulfillment | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`fulfillment` COMMENT 'Manages e-commerce and D2D fulfillment execution including order orchestration, pick-pack-ship workflows, last-mile dispatch, carrier selection for parcel delivery, returns processing (RMA), advanced shipping notices (ASN), COD collections, and SLA breach tracking. Owns fulfillment orders, parcel manifests, delivery attempts, ePOD capture, and omnichannel integration via EDI and API channels with merchant e-commerce platforms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` (
    `last_mile_dispatch_id` BIGINT COMMENT 'Unique identifier for the last-mile dispatch record. Primary key for the last_mile_dispatch product.',
    `cod_collection_id` BIGINT COMMENT 'Foreign key linking to billing.cod_collection. Business justification: Last-mile dispatch events trigger COD collection records when cash is collected at delivery. Real business process: COD remittance reconciliation, agent settlement, and cash flow management requiring ',
    `rate_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.rate_agreement. Business justification: Last-mile delivery costs are governed by carrier rate agreements. Essential for cost allocation, margin analysis, and invoice validation in final-mile logistics operations.',
    `consignee_id` BIGINT COMMENT 'Foreign key linking to fulfillment.consignee. Business justification: Last-mile dispatch delivers to consignees (end recipients). The recipient_name and recipient_contact_phone should be normalized to consignee_id FK referencing consignee.consignee_id. This enables leve',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment being dispatched for final delivery. Links to the shipment or parcel being delivered.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Last-mile delivery operations incur direct costs (courier wages, fuel, vehicle maintenance) that must be tracked to cost centers for operational cost control. Cost per delivery KPIs and route optimiza',
    `employee_id` BIGINT COMMENT 'Reference to the employee (driver or delivery agent) assigned to execute this dispatch. Links to workforce employee master data.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Last-mile delivery agent assignment requires driver profile lookup for license validation, HOS compliance verification, performance tracking, and route authorization. Existing delivery_agent_employee_',
    `driver_safety_event_id` BIGINT COMMENT 'Foreign key linking to safety.driver_safety_event. Business justification: Last-mile delivery drivers generate safety events (speeding, harsh braking) during dispatch execution. Operations teams link dispatch records to safety events for driver coaching, route safety analysi',
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_zone. Business justification: Last-mile dispatch assignments are zone-based. Adding delivery_zone_id FK enables proper zone-based routing, SLA tracking, and delivery agent assignment. The delivery address fields remain (execution-',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that this dispatch is executing. Links to the e-commerce or D2D order.',
    `hold_id` BIGINT COMMENT 'Foreign key linking to customs.customs_hold. Business justification: Last-mile dispatch is blocked when customs holds exist. Enables delivery agents to understand delay root cause, provide accurate customer updates, and reschedule delivery attempts based on expected cu',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Dispatches originate from specific network nodes (depots, hubs). Enables dispatch origin tracking, node-level performance analysis, and depot capacity planning. Standard in last-mile operations manage',
    `service_level_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.service_level_rate. Business justification: Last-mile dispatches are costed using service-level-specific rates for profitability analysis. Business process: last-mile cost allocation assigns delivery costs based on service level for route profi',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Last-mile dispatch operations assign specific fleet vehicles to delivery routes. Dispatch planning, vehicle utilization tracking, and operational reporting require authoritative link to fleet.transpor',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Last-mile dispatch requires delivery documentation (dispatch manifest, delivery notes, ePOD forms). Real process: driver receives dispatch paperwork for route execution and proof-of-delivery capture.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the consignment was successfully delivered to the recipient. Null if delivery not yet completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `actual_pickup_timestamp` TIMESTAMP COMMENT 'Actual date and time when the delivery agent picked up the consignment from the depot or hub. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cod_amount` DECIMAL(18,2) COMMENT 'Cash on Delivery amount to be collected from the recipient at the time of delivery. Null if not a COD shipment.',
    `cod_collected_flag` BOOLEAN COMMENT 'Indicates whether the COD amount was successfully collected from the recipient. True if collected, False if not collected or not applicable.',
    `cod_currency_code` STRING COMMENT 'Three-letter ISO currency code for the COD amount. Format: ISO 4217.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dispatch record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delivery_address_line1` STRING COMMENT 'First line of the delivery destination address. Typically contains street number and street name.',
    `delivery_address_line2` STRING COMMENT 'Second line of the delivery destination address. May contain apartment, suite, or building information.',
    `delivery_attempt_number` STRING COMMENT 'Sequential count of delivery attempts for this consignment. Increments with each failed delivery attempt. First attempt = 1.',
    `delivery_city` STRING COMMENT 'City or municipality of the delivery destination address.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code of the delivery destination. Format: ISO 3166-1 alpha-3.. Valid values are `^[A-Z]{3}$`',
    `delivery_failure_reason_code` STRING COMMENT 'Standardized code indicating the reason for delivery failure. Null if delivery was successful. [ENUM-REF-CANDIDATE: recipient_unavailable|address_incorrect|access_denied|refused_by_recipient|damaged_package|weather_delay|vehicle_breakdown — promote to reference product]',
    `delivery_instructions` STRING COMMENT 'Special instructions provided by the customer or shipper for the delivery. May include gate codes, safe drop locations, or contact preferences.',
    `delivery_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery destination. Used for GPS tracking and route optimization.',
    `delivery_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery destination. Used for GPS tracking and route optimization.',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code of the delivery destination address.',
    `delivery_route_code` STRING COMMENT 'Code identifying the planned delivery route or zone for this dispatch. Used for route optimization and territory management.',
    `delivery_state_province` STRING COMMENT 'State, province, or region of the delivery destination address.',
    `dispatch_date` DATE COMMENT 'The calendar date on which the consignment was dispatched for last-mile delivery. Primary business event date for this transaction.',
    `dispatch_number` STRING COMMENT 'Externally-visible unique dispatch reference number used for tracking and communication. Format: DSP-XXXXXXXXXX.. Valid values are `^DSP-[0-9]{10}$`',
    `dispatch_sequence_number` STRING COMMENT 'Sequential position of this dispatch within the delivery route. Determines the order in which deliveries should be attempted.',
    `dispatch_status` STRING COMMENT 'Current lifecycle status of the dispatch. Tracks progression from dispatch through delivery or return. Values: dispatched (assigned to driver), in_transit (en route to delivery area), out_for_delivery (active delivery attempt), delivered (successfully completed), failed (delivery unsuccessful), returned_to_depot (consignment returned).. Valid values are `dispatched|in_transit|out_for_delivery|delivered|failed|returned_to_depot`',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Precise date and time when the consignment was dispatched from the depot or hub for final delivery. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `epod_photo_captured_flag` BOOLEAN COMMENT 'Indicates whether a photo was captured as proof of delivery. True if photo captured, False otherwise.',
    `epod_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether an electronic signature was captured as proof of delivery. True if signature captured, False otherwise.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this dispatch record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `planned_delivery_time_window_end` TIMESTAMP COMMENT 'End of the planned delivery time window communicated to the customer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `planned_delivery_time_window_start` TIMESTAMP COMMENT 'Start of the planned delivery time window communicated to the customer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `return_to_depot_timestamp` TIMESTAMP COMMENT 'Date and time when the consignment was returned to the depot after a failed delivery attempt. Null if not returned. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the delivery missed the SLA target delivery timestamp. True if breached, False if met or not yet determined.',
    `sla_target_delivery_timestamp` TIMESTAMP COMMENT 'The committed delivery date and time per the service level agreement. Used to measure on-time delivery performance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that created this dispatch record. Primary source is Oracle TMS last-mile dispatch module.. Valid values are `ORACLE_TMS|SAP_TM|MANHATTAN_WMS|OTHER`',
    CONSTRAINT pk_last_mile_dispatch PRIMARY KEY(`last_mile_dispatch_id`)
) COMMENT 'Last-mile delivery dispatch record assigning a consignment to a delivery agent/driver for final delivery execution. Captures dispatch date, delivery agent employee ID, vehicle registration, delivery route code, dispatch sequence number within the route, planned delivery time window, actual pickup time from depot, delivery attempt number, dispatch status (dispatched/in_transit/delivered/failed/returned), and return-to-depot timestamp if undelivered. Sourced from Oracle TMS last-mile dispatch module. Enables D2D delivery performance tracking and driver productivity measurement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` (
    `fulfillment_order_id` BIGINT COMMENT 'Unique identifier for the fulfillment order. Primary key for the order entity within the fulfillment domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Orders are fulfilled under master service agreements governing rates, SLAs, and service terms. Essential for rate lookup, SLA enforcement, billing validation, and dispute resolution. Logistics operato',
    `consignee_id` BIGINT COMMENT 'Foreign key linking to fulfillment.consignee. Business justification: Fulfillment orders are delivered to consignees (end recipients). The recipient_name, recipient_contact_phone, and recipient_email should be normalized to consignee_id FK referencing consignee.consigne',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fulfillment orders incur operational costs (labor, packaging, handling) that must be allocated to cost centers for P&L reporting, budget variance analysis, and service line profitability. Monthly oper',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Cross-border e-commerce fulfillment orders require customs declarations for international shipments. Enables tracking customs clearance status from order management, critical for international deliver',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: International and regulated shipments require complete document packages (commercial invoice, packing list, certificates of origin). Real process: export order fulfillment assembles and validates requ',
    `ecommerce_seller_id` BIGINT COMMENT 'Reference to the e-commerce seller or merchant platform that submitted this order.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Fulfillment orders are processed at specific fulfillment centers. The warehouse_location_code STRING should be normalized to FK referencing center.fulfillment_center_id. This enables proper order-to-f',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Fulfillment orders generate customer invoices for freight charges, COD fees, and service charges. Core billing process: invoice generation from completed fulfillment orders. Essential for revenue reco',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Fulfillment orders require lane assignment for transportation planning from fulfillment center to delivery destination. Enables order-to-lane routing for freight booking, carrier selection, and transi',
    `customer_account_id` BIGINT COMMENT 'Reference to the merchant or customer account that originated this fulfillment order.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to fulfillment.merchant. Business justification: Fulfillment orders are placed by merchants (e-commerce sellers). Adding merchant_id FK is critical for linking orders to the merchant partner. The merchant_order_reference remains as it captures the m',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Fulfillment orders for internal logistics supplies (packaging materials, labels, consumables) are procured via purchase orders. Enables supply chain cost allocation and inventory replenishment trackin',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Orders generate revenue and costs that roll up to profit centers for segment reporting and EBITDA analysis. Financial reporting by service line, geography, or customer segment requires linking orders ',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Orders requiring multi-leg transportation are assigned to service corridors for end-to-end routing. Enables corridor-based order routing for complex shipments, cross-border movements, and multi-modal ',
    `spot_quote_id` BIGINT COMMENT 'Foreign key linking to pricing.spot_quote. Business justification: E-commerce fulfillment orders originate from spot quotes for ad-hoc shipping. Business process: quote-to-order conversion tracking for sales pipeline analysis and quote acceptance rate reporting.',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Fulfillment orders are released in waves for coordinated pick-pack-ship execution. Adding wave_id FK is critical for linking orders to their wave assignment. This enables wave-based performance tracki',
    `allocated_timestamp` TIMESTAMP COMMENT 'The date and time when inventory was allocated to this order in the Warehouse Management System (WMS).',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for order cancellation (customer request, inventory unavailable, address invalid, etc.).',
    `carrier_service_provider_code` STRING COMMENT 'The code identifying the carrier or third-party logistics (3PL) provider selected for last-mile delivery.',
    `cod_amount` DECIMAL(18,2) COMMENT 'The total amount to be collected from the recipient at delivery for cash-on-delivery orders.',
    `cod_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the COD collection amount.. Valid values are `^[A-Z]{3}$`',
    `cod_flag` BOOLEAN COMMENT 'Indicates whether this order requires cash-on-delivery collection at the time of delivery (True = COD required, False = prepaid).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this order record was first created in the fulfillment system.',
    `delivered_timestamp` TIMESTAMP COMMENT 'The date and time when the order was successfully delivered to the recipient and proof of delivery (POD) was captured.',
    `delivery_address_line1` STRING COMMENT 'The primary street address line for the delivery destination.',
    `delivery_address_line2` STRING COMMENT 'The secondary address line for the delivery destination (apartment, suite, building number).',
    `delivery_city` STRING COMMENT 'The city or municipality name for the delivery destination.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery destination.. Valid values are `^[A-Z]{3}$`',
    `delivery_instructions` STRING COMMENT 'Customer-provided delivery instructions for the last-mile delivery agent (gate code, safe drop location, contact preferences).',
    `delivery_postal_code` STRING COMMENT 'The postal or ZIP code for the delivery destination, used for routing and zone determination.',
    `delivery_state_province` STRING COMMENT 'The state, province, or administrative region for the delivery destination.',
    `dispatched_timestamp` TIMESTAMP COMMENT 'The date and time when the order was handed over to the carrier or last-mile delivery agent.',
    `fulfillment_mode` STRING COMMENT 'The operational fulfillment method used to execute this order (warehouse pick, dropship, cross-dock, etc.).. Valid values are `warehouse|dropship|cross_dock|store_pickup|locker`',
    `integration_message_code` STRING COMMENT 'The unique identifier of the EDI or API message that transmitted this order, used for omnichannel integration traceability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this order record was last modified in the fulfillment system.',
    `merchant_order_reference` STRING COMMENT 'The merchants original order reference number or identifier from their e-commerce platform.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the fulfillment order, used for tracking and customer communication.',
    `order_status` STRING COMMENT 'Current lifecycle status of the fulfillment order within the pick-pack-ship workflow. [ENUM-REF-CANDIDATE: received|validated|allocated|picking|packed|manifested|dispatched|in_transit|delivered|cancelled|returned — 11 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the fulfillment order by business channel and fulfillment mode.. Valid values are `d2d|ecommerce|b2b|b2c|return|exchange`',
    `original_order_reference` STRING COMMENT 'For return or exchange orders, the reference to the original fulfillment order being returned or exchanged.',
    `packed_timestamp` TIMESTAMP COMMENT 'The date and time when the order was packed and ready for dispatch.',
    `picked_timestamp` TIMESTAMP COMMENT 'The date and time when warehouse picking was completed for this order.',
    `promised_delivery_date` DATE COMMENT 'The date promised to the customer for delivery, forming the basis of the Service Level Agreement (SLA).',
    `received_timestamp` TIMESTAMP COMMENT 'The date and time when the fulfillment order was first received into the system from the merchant or customer platform.',
    `return_flag` BOOLEAN COMMENT 'Indicates whether this order is a return merchandise authorization (RMA) order (True = return, False = forward shipment).',
    `rma_number` STRING COMMENT 'The return merchandise authorization number issued for return orders, linking back to the original order.',
    `service_type` STRING COMMENT 'The delivery service level selected for this order, determining speed and handling priority.. Valid values are `standard|express|same_day|next_day|economy|premium`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the order delivery breached the promised SLA window (True = breach occurred, False = SLA met).',
    `sla_window_end_timestamp` TIMESTAMP COMMENT 'The end of the promised delivery time window for SLA compliance tracking.',
    `sla_window_start_timestamp` TIMESTAMP COMMENT 'The start of the promised delivery time window for SLA compliance tracking.',
    `source_channel` STRING COMMENT 'The technical channel through which the order was received (EDI, API, web portal, mobile app, manual entry).. Valid values are `edi|api|web_portal|mobile_app|manual`',
    `source_system_code` STRING COMMENT 'The code identifying the upstream system of record that originated this order (WMS, TMS, merchant platform).',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements for this order (fragile, temperature-controlled, signature required, etc.).',
    `total_item_quantity` STRING COMMENT 'The total number of individual items (SKUs) included in this fulfillment order across all order lines.',
    `total_package_count` STRING COMMENT 'The total number of packages or parcels created for this order during the packing process.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'The total volumetric measurement of the order in cubic meters (CBM), used for dimensional weight calculation.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the order in kilograms, including packaging materials.',
    `tracking_number` STRING COMMENT 'The carrier-assigned tracking number for shipment visibility and customer tracking.',
    `validated_timestamp` TIMESTAMP COMMENT 'The date and time when the order passed validation checks (inventory availability, address verification, payment authorization).',
    `value_amount` DECIMAL(18,2) COMMENT 'The total declared value of goods in this fulfillment order, used for insurance and customs purposes.',
    `value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value amount.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_fulfillment_order PRIMARY KEY(`fulfillment_order_id`)
) COMMENT 'Core master entity representing an e-commerce or D2D fulfillment order received from a merchant or customer platform. Captures the full order lifecycle from receipt through completion, including order source channel (EDI/API), merchant reference, service type, fulfillment mode, order status, promised SLA window, COD flag and amount, special handling instructions, and omnichannel integration metadata. This is the SSOT for fulfillment order identity within the fulfillment domain — distinct from freight forwarding orders owned by the freight domain.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique identifier for the individual order line item within the fulfillment system. Primary key for the order line entity.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that contains this line item. Links the line to its header transaction for order orchestration and tracking.',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Order line items need HS classification for automated customs documentation generation. Enables duty calculation, restricted goods screening, and customs declaration pre-population from order data, cr',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: Order line items are packed into parcels during the pack stage. The carton_id and tracking_number strings should be normalized to parcel_id FK referencing parcel.parcel_id. This enables tracking which',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse employee who picked this line item. Used for labor productivity tracking and quality accountability.',
    `back_order_expected_date` DATE COMMENT 'Expected date when back-ordered inventory will be available for fulfillment. Used for customer communication and inventory planning.',
    `back_order_flag` BOOLEAN COMMENT 'Indicates whether this line item is on back order due to insufficient inventory. True if the item will be fulfilled in a subsequent shipment.',
    `bin_location` STRING COMMENT 'Specific bin, shelf, or slot location within the warehouse where the SKU is stored. Used by WMS for pick path optimization and inventory accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order line record was first created in the fulfillment system. Used for audit trail and order lifecycle analysis.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether this line item contains dangerous goods or hazardous materials requiring special handling, labeling, and carrier compliance per IMDG or IATA regulations.',
    `declared_value` DECIMAL(18,2) COMMENT 'Declared monetary value of the line item for insurance, customs declaration, and liability purposes. Used for cargo insurance and claims processing.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared value. Supports multi-currency e-commerce fulfillment operations.. Valid values are `^[A-Z]{3}$`',
    `dimension_uom` STRING COMMENT 'Unit of measure for length, width, and height dimensions. Common values include CM (centimeter), IN (inch), M (meter), FT (foot).. Valid values are `CM|IN|M|FT`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for perishable or time-sensitive products. Used for FEFO (First Expired First Out) picking strategies and quality control.',
    `gift_message` STRING COMMENT 'Customer-provided gift message to be included with this line item. Used for personalized fulfillment in e-commerce gift orders.',
    `gift_wrap_flag` BOOLEAN COMMENT 'Indicates whether gift wrapping service was requested for this line item. Triggers special handling instructions during packing operations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this order line record was last modified. Used for change tracking and data synchronization across systems.',
    `line_number` STRING COMMENT 'Sequential line number within the fulfillment order. Determines the ordering and processing sequence of line items within a multi-line order.',
    `line_status` STRING COMMENT 'Current fulfillment status of the order line. Tracks progression through pick-pack-ship workflow and supports partial fulfillment scenarios. [ENUM-REF-CANDIDATE: pending|allocated|picked|packed|shipped|delivered|cancelled|returned|back_ordered — 9 candidates stripped; promote to reference product]',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for the picked inventory. Critical for traceability, recalls, and FIFO/LIFO inventory management.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU ordered by the customer or merchant. Represents the target fulfillment quantity before any adjustments or substitutions.',
    `original_sku` STRING COMMENT 'The originally ordered SKU if this line represents a substitution. Null if no substitution occurred. Used for customer communication and substitution analytics.',
    `pack_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was packed and prepared for shipment. Used for pack productivity analysis and order cycle time measurement.',
    `packed_quantity` DECIMAL(18,2) COMMENT 'Quantity successfully packed and prepared for shipment. May differ from picked quantity due to quality control rejections or packing errors.',
    `pick_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was picked from warehouse inventory. Used for pick productivity analysis and SLA tracking.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'Actual quantity picked from warehouse inventory for this line. May differ from ordered quantity due to stock availability, damage, or operational constraints.',
    `product_name` STRING COMMENT 'Human-readable name or description of the product being fulfilled on this line. Used for pick-pack documentation and customer communication.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the ordered quantity. Common values include EA (each), CS (case), PK (pack), BX (box), PL (pallet), KG (kilogram), LB (pound), LT (liter), GL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PK|BX|PL|KG|LB|LT|GL — 9 candidates stripped; promote to reference product]',
    `return_flag` BOOLEAN COMMENT 'Indicates whether this line item has been returned by the customer. True if an RMA (Return Merchandise Authorization) was processed for this line.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for return. Values include DAMAGED, WRONG_ITEM, NOT_NEEDED, DEFECTIVE, SIZE_ISSUE, LATE_DELIVERY. Used for returns analytics and quality improvement.. Valid values are `DAMAGED|WRONG_ITEM|NOT_NEEDED|DEFECTIVE|SIZE_ISSUE|LATE_DELIVERY`',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items. Enables unit-level tracking for high-value goods, electronics, and regulated products.',
    `ship_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was dispatched from the fulfillment center. Used for carrier handoff tracking and delivery ETA calculation.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Final quantity dispatched to the customer. Represents the actual fulfilled quantity for billing and delivery confirmation purposes.',
    `sku` STRING COMMENT 'Unique product identifier representing the specific item to be fulfilled. Used for inventory lookup, pick instructions, and product master reference.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `source_system_code` STRING COMMENT 'Code identifying the upstream system or channel that originated this order line (e.g., WMS, OMS, e-commerce platform). Used for data lineage and integration troubleshooting.',
    `special_handling_code` STRING COMMENT 'Code indicating special handling requirements for this line item. Values include FRAGILE, HAZMAT (hazardous materials), REFRIGERATED, HIGH_VALUE, OVERSIZED, or NONE.. Valid values are `FRAGILE|HAZMAT|REFRIGERATED|HIGH_VALUE|OVERSIZED|NONE`',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether this line item is a substitution for an out-of-stock SKU. True if a substitute product was picked instead of the originally ordered SKU.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying dangerous goods classification. Required for hazmat shipping documentation and carrier acceptance.. Valid values are `^UN[0-9]{4}$`',
    `unit_height` DECIMAL(18,2) COMMENT 'Height dimension of a single unit of the SKU. Used for dimensional weight calculations and warehouse slotting optimization.',
    `unit_length` DECIMAL(18,2) COMMENT 'Length dimension of a single unit of the SKU. Used for dimensional weight (DIM weight) calculations and packaging optimization.',
    `unit_weight` DECIMAL(18,2) COMMENT 'Weight of a single unit of the SKU. Used for dimensional weight calculations, carrier selection, and freight cost estimation.',
    `unit_width` DECIMAL(18,2) COMMENT 'Width dimension of a single unit of the SKU. Used for dimensional weight calculations and carton selection during packing.',
    `warehouse_location_code` STRING COMMENT 'Code identifying the warehouse or fulfillment center location where this line item is being processed. Used for inventory allocation and pick routing.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `weight_uom` STRING COMMENT 'Unit of measure for unit weight. Common values include KG (kilogram), LB (pound), G (gram), OZ (ounce).. Valid values are `KG|LB|G|OZ`',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line item within a fulfillment order representing a specific SKU, quantity, unit weight, dimensions, declared value, and fulfillment instruction. Tracks per-line status (picked, packed, shipped, returned), substitution flags, and back-order indicators. Supports multi-line order orchestration and partial fulfillment scenarios common in e-commerce fulfillment operations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` (
    `parcel_id` BIGINT COMMENT 'Unique identifier for the parcel. Primary key for the parcel entity.',
    `billing_invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Each parcel generates specific invoice line items for weight-based charges, dimensional weight surcharges, and accessorial fees. Real business process: parcel-level freight audit, billing reconciliati',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Parcels are physical units tendered to carriers. Direct FK enables parcel-level carrier performance analysis, invoice reconciliation, service level compliance tracking. Business process: carrier billi',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Parcels containing regulated goods (food, pharma, hazmat, plants) require compliance certificates (phytosanitary, origin, dangerous goods). Real process: compliance documentation for restricted commod',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: International parcels require customs declarations for clearance. Supports parcel-level customs status tracking, essential for last-mile delivery planning and exception management when parcels are hel',
    `dg_declaration_id` BIGINT COMMENT 'Foreign key linking to customs.dg_declaration. Business justification: Dangerous goods parcels require DG declarations for customs and transport compliance. Links parcel hazmat attributes to formal customs DG documentation, mandatory for international air/sea shipments o',
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_zone. Business justification: Parcels are routed to specific delivery zones based on destination address. Adding delivery_zone_id FK enables zone-based routing, carrier selection, and SLA management. Destination address fields rem',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that this parcel is part of. Links parcel to the order orchestration workflow.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Individual parcels are routed via specific lanes for carrier assignment and transit time calculation. Critical for parcel routing optimization, carrier selection algorithms, and delivery promise calcu',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Tracks packaging material supplier for each parcel. Critical for quality control, cost analysis, and supplier performance evaluation in logistics operations. Enables root cause analysis when packaging',
    `parcel_manifest_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel_manifest. Business justification: Parcels are grouped into carrier manifests for scheduled dispatch. Adding parcel_manifest_id FK is critical for tracking which manifest a parcel belongs to, enabling manifest reconciliation, carrier h',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Parcels are rated against published tariffs for carrier billing reconciliation. Business process: tariff-based rating validation ensures billed rates match published tariff schedules for audit complia',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Each parcel requires transport documentation for carrier acceptance, tracking, and delivery proof. Business process: parcel manifesting creates shipping labels and carrier tender documents.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Actual physical weight of the parcel measured in kilograms. Used for carrier rating and freight charge calculation.',
    `carrier_service_code` STRING COMMENT 'Specific service level selected for parcel delivery (e.g., express, standard, economy, next_day, two_day). Determines transit time and service level agreement (SLA).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `carrier_service_name` STRING COMMENT 'Human-readable name of the carrier service (e.g., FedEx Priority Overnight, UPS Ground, DHL Express Worldwide).',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual weight or dimensional weight, used for carrier billing and freight charge calculation.',
    `cod_amount` DECIMAL(18,2) COMMENT 'Amount to be collected from the recipient at delivery. Applicable only when cod_flag is true.',
    `cod_currency_code` STRING COMMENT 'Three-letter ISO currency code for the COD amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cod_flag` BOOLEAN COMMENT 'Indicates whether this parcel requires cash on delivery (COD) collection at the time of delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the parcel record was first created in the system. Used for audit trail and data lineage.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Declared value of the parcel contents for insurance and liability purposes. Used to determine carrier liability limits and insurance premiums.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO currency code for the declared value amount.. Valid values are `^[A-Z]{3}$`',
    `destination_address_line1` STRING COMMENT 'First line of the delivery address (street address, building number). Used for last-mile routing and electronic proof of delivery (ePOD).',
    `destination_address_line2` STRING COMMENT 'Second line of the delivery address (apartment, suite, floor). Optional field for additional address details.',
    `destination_city` STRING COMMENT 'City or municipality of the delivery address. Used for geographic routing and service area determination.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the delivery destination (e.g., USA, GBR, DEU). Used for customs clearance and cross-border compliance.. Valid values are `^[A-Z]{3}$`',
    `destination_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the delivery address. Used for GPS-based route optimization and real-time tracking.',
    `destination_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the delivery address. Used for GPS-based route optimization and real-time tracking.',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the delivery address. Critical for carrier routing and service level determination.',
    `destination_state_province` STRING COMMENT 'State, province, or region of the delivery address. Used for tax calculation and regulatory compliance.',
    `dimensional_weight_kg` DECIMAL(18,2) COMMENT 'Dimensional weight (DIM weight) calculated based on parcel volume and carrier-specific DIM factor. Used for freight rating when DIM weight exceeds actual weight.',
    `hazmat_class` STRING COMMENT 'UN hazard class for dangerous goods (e.g., 3 for flammable liquids, 9 for miscellaneous). Applicable only when hazmat_flag is true.. Valid values are `^(1|2|3|4|5|6|7|8|9)(.d)?$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the parcel contains hazardous materials (dangerous goods) requiring special handling and compliance with IMDG Code or ICAO Technical Instructions.',
    `hazmat_un_number` STRING COMMENT 'Four-digit UN number identifying the dangerous goods substance (e.g., UN1203 for gasoline). Required for hazmat compliance and carrier acceptance.. Valid values are `^UNd{4}$`',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the parcel in centimeters. Used to calculate cubic meter (CBM) and dimensional weight (DIM weight).',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether additional cargo insurance is required for this parcel beyond standard carrier liability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the parcel record was last modified. Used for audit trail and change tracking.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the parcel in centimeters. Used to calculate cubic meter (CBM) and dimensional weight (DIM weight).',
    `manifest_timestamp` TIMESTAMP COMMENT 'Date and time when the parcel was manifested and handed over to the carrier. Used for carrier billing and service level agreement (SLA) tracking.',
    `origin_facility_code` STRING COMMENT 'Code of the warehouse or fulfillment center where the parcel was packed and dispatched. Used for operational reporting and network optimization.. Valid values are `^[A-Z0-9]{3,10}$`',
    `pack_timestamp` TIMESTAMP COMMENT 'Date and time when the parcel was packed and sealed at the fulfillment center. Marks the completion of the pack stage in the pick-pack-ship workflow.',
    `packaging_material` STRING COMMENT 'Primary material used in the packaging. Relevant for sustainability reporting and greenhouse gas (GHG) emissions tracking.. Valid values are `cardboard|plastic|paper|wood|metal|composite`',
    `packaging_type` STRING COMMENT 'Type of packaging material used for the parcel (e.g., box, envelope, poly bag). Influences handling requirements and carrier service eligibility. [ENUM-REF-CANDIDATE: box|envelope|poly_bag|tube|pallet|crate|custom — 7 candidates stripped; promote to reference product]',
    `parcel_status` STRING COMMENT 'Current lifecycle status of the parcel in the pick-pack-ship and last-mile delivery workflow. [ENUM-REF-CANDIDATE: packed|manifested|dispatched|in_transit|out_for_delivery|delivered|failed_delivery|returned|cancelled — 9 candidates stripped; promote to reference product]',
    `recipient_contact_email` STRING COMMENT 'Email address of the recipient for delivery notifications and electronic proof of delivery (ePOD) transmission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_contact_phone` STRING COMMENT 'Phone number of the recipient for delivery coordination and failed delivery notifications.',
    `recipient_name` STRING COMMENT 'Full name of the person or organization receiving the parcel. Used for delivery verification and electronic proof of delivery (ePOD).',
    `seal_number` STRING COMMENT 'Unique seal or tamper-evident identifier applied to the parcel for security and customs compliance. Required for high-value or regulated shipments.. Valid values are `^[A-Z0-9]{6,20}$`',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether a recipient signature is required for proof of delivery (POD). Used for high-value or regulated shipments.',
    `sla_target_delivery_date` DATE COMMENT 'Target delivery date committed to the customer based on the selected carrier service and service level agreement (SLA).',
    `sla_target_delivery_time_window_end` TIMESTAMP COMMENT 'End of the committed delivery time window for time-definite services (e.g., 12:00 PM for morning delivery).',
    `sla_target_delivery_time_window_start` TIMESTAMP COMMENT 'Start of the committed delivery time window for time-definite services (e.g., 9:00 AM for morning delivery).',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that created this parcel record (e.g., Manhattan WMS, SAP TM). Used for data lineage and integration troubleshooting.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements (e.g., fragile, keep upright, temperature-sensitive, signature required).',
    `tracking_number` STRING COMMENT 'Unique barcode or tracking number assigned to the parcel for end-to-end visibility and proof of delivery (POD). Used by carriers and customers to track parcel movement.. Valid values are `^[A-Z0-9]{10,35}$`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the parcel in cubic meters (CBM). Calculated as length × width × height. Used for warehouse space planning and carrier capacity management.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the parcel in centimeters. Used to calculate cubic meter (CBM) and dimensional weight (DIM weight).',
    CONSTRAINT pk_parcel PRIMARY KEY(`parcel_id`)
) COMMENT 'Physical parcel or package created during the pack stage of pick-pack-ship workflow. Captures parcel dimensions (CBM), actual weight, DIM weight, packaging type, barcode/tracking number, seal number, hazmat flag (IMDG/ICAO compliance), and assigned carrier service. Each parcel is linked to one or more order lines and is the unit of last-mile dispatch. Distinct from freight containers managed in the freight domain.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` (
    `parcel_manifest_id` BIGINT COMMENT 'Unique identifier for the parcel manifest record. Primary key.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Manifests are dispatched under specific carrier agreements defining capacity, rates, and service levels. Required for rate application, capacity validation, performance tracking, and invoice reconcili',
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: Manifests are reconciled against negotiated carrier buy rates for cost accounting. Business process: carrier invoice validation compares manifested shipments to contracted buy rates for payment accura',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier or last-mile delivery partner assigned to this manifest.',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: Parcel manifests drive carrier invoice generation and payables. Real business process: carrier invoice reconciliation, manifest-to-invoice matching, and freight cost accrual requiring manifest-to-paya',
    `rate_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.rate_agreement. Business justification: Parcel manifests execute against negotiated carrier rate agreements. Essential for freight cost calculation, invoice reconciliation, and rate compliance verification. Core operational link in transpor',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Manifests are tendered under specific carrier service contracts (express/standard/economy). Business process: service-level capacity planning, rate application, transit time SLA enforcement, manifest-',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Manifests represent dispatch operations with direct costs (driver wages, fuel, vehicle depreciation) that must be allocated to cost centers. Transportation cost accounting and carrier performance anal',
    `employee_id` BIGINT COMMENT 'Identifier of the driver or delivery agent assigned to this manifest.',
    `center_id` BIGINT COMMENT 'Identifier of the warehouse, fulfillment center, or distribution hub from which this manifest originates.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Manifests consolidate parcels for specific lanes to optimize carrier capacity utilization. Enables manifest planning, lane allocation, and carrier tender processes. Standard practice in consolidation ',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Manifest handoff and carrier tender require driver identification with license validation, HOS compliance verification, and certification checks (hazmat, dangerous goods). Existing driver_employee_id ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Manifests are created at origin nodes for node-to-node movement tracking. Enables origin node performance analysis, capacity planning, and network flow optimization. Core to manifest management system',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Manifests for long-haul or multi-modal shipments are assigned to service corridors. Enables corridor-based manifest planning, capacity allocation, and multi-leg routing for consolidated shipments in l',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Parcel manifest consolidation for carrier handoff requires tracking which fleet vehicle transported the manifest from fulfillment center to carrier hub. Fleet utilization reporting, cost allocation, a',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Parcel manifest is itself a formal transport document (carrier tender, dispatch manifest). Business reality: manifest generation creates regulatory and operational documentation for carrier handoff.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the manifest arrived at the destination zone or carrier hub.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the vehicle or carrier departed from the origin facility.',
    `carrier_acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier acknowledged receipt of the manifest via EDI 997 functional acknowledgement or API response.',
    `carrier_iata_code` STRING COMMENT 'Two or three-character airline designator code assigned by IATA for air freight carriers.. Valid values are `^[A-Z0-9]{2,3}$`',
    `carrier_scac_code` STRING COMMENT 'Four-letter unique identifier assigned by the National Motor Freight Traffic Association (NMFTA) for the carrier. Used for EDI transmission and regulatory reporting.. Valid values are `^[A-Z]{2,4}$`',
    `cod_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total COD amount.. Valid values are `^[A-Z]{3}$`',
    `contains_hazmat_flag` BOOLEAN COMMENT 'Indicates whether this manifest contains any parcels with hazardous materials requiring special handling and regulatory compliance.',
    `contains_high_value_flag` BOOLEAN COMMENT 'Indicates whether this manifest contains parcels exceeding the high-value threshold requiring enhanced security and insurance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was first created in the system.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total declared value amount.. Valid values are `^[A-Z]{3}$`',
    `destination_city` STRING COMMENT 'Primary destination city for parcels in this manifest.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the destination zone.. Valid values are `^[A-Z]{3}$`',
    `destination_state_province` STRING COMMENT 'State or province of the destination zone.',
    `destination_zone_code` STRING COMMENT 'Geographic zone, service lane, or last-mile delivery area code to which this manifest is routed. Used for carrier route optimization and zone-based pricing.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `discrepancy_notes` STRING COMMENT 'Free-text notes documenting any discrepancies found during reconciliation (e.g., missing parcels, weight variance, damaged items).',
    `dispatch_date` DATE COMMENT 'Scheduled date when the manifest is to be dispatched to the carrier.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Actual date and time when the manifest was handed over to the carrier. Principal business event timestamp for this transaction.',
    `edi_transmission_status` STRING COMMENT 'Status of EDI manifest transmission to the carrier system. Tracks whether manifest data has been successfully communicated via EDI 214, 315, or API.. Valid values are `pending|transmitted|acknowledged|failed|not_required`',
    `edi_transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest was transmitted to the carrier via EDI or API.',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Predicted date and time when the manifest will arrive at the destination zone or carrier hub. May be updated in real-time via carrier tracking systems.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was last modified.',
    `manifest_number` STRING COMMENT 'Externally-known unique manifest number assigned to this carrier dispatch grouping. Used for carrier handover documentation and freight audit reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `manifest_status` STRING COMMENT 'Current lifecycle status of the manifest. Open: accepting parcels; Closed: no further additions; Dispatched: handed to carrier; In Transit: en route; Delivered: completed; Reconciled: audit complete; Cancelled: voided. [ENUM-REF-CANDIDATE: open|closed|dispatched|in_transit|delivered|reconciled|cancelled — 7 candidates stripped; promote to reference product]',
    `manifest_type` STRING COMMENT 'Classification of the manifest based on its operational purpose. Outbound: customer deliveries; Inbound: returns; Transfer: inter-facility; Return: RMA; Cross-dock: direct transfer.. Valid values are `outbound|inbound|transfer|return|cross_dock`',
    `planned_departure_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the vehicle or carrier to depart from the origin facility.',
    `reconciliation_status` STRING COMMENT 'Status of freight audit reconciliation comparing manifest details with carrier billing and delivery confirmations. Discrepancy indicates count or weight mismatch.. Valid values are `pending|matched|discrepancy|resolved`',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest reconciliation process was completed.',
    `route_code` STRING COMMENT 'Identifier of the delivery route or service lane assigned to this manifest for network optimization and performance tracking.. Valid values are `^[A-Z0-9_]{3,15}$`',
    `seal_number` STRING COMMENT 'Unique security seal number applied to the container or vehicle for tamper-evidence and customs compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that created this manifest record (e.g., WMS, TMS, OMS).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `special_handling_instructions` STRING COMMENT 'Instructions for carrier regarding special handling requirements for this manifest (e.g., temperature control, fragile, hazardous materials, high-value).',
    `total_chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Total chargeable weight used for billing, calculated as the greater of actual weight or volumetric weight.',
    `total_cod_amount` DECIMAL(18,2) COMMENT 'Sum of all COD collection amounts for parcels in this manifest. Carrier is responsible for collecting and remitting these funds.',
    `total_declared_value_amount` DECIMAL(18,2) COMMENT 'Sum of declared values of all parcels in the manifest. Used for insurance coverage and liability determination.',
    `total_parcel_count` STRING COMMENT 'Total number of individual parcels included in this manifest. Used for carrier handover verification and freight audit.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total cubic volume of all parcels in the manifest, measured in cubic meters. Used for load planning and carrier capacity allocation.',
    `total_volumetric_weight_kg` DECIMAL(18,2) COMMENT 'Total dimensional weight (DIM weight) of all parcels calculated using carrier-specific volumetric divisor. Used for freight rating when volumetric weight exceeds actual weight.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total actual weight of all parcels in the manifest, measured in kilograms. Used for carrier billing and capacity planning.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this manifest.. Valid values are `road|air|rail|ocean|multimodal`',
    CONSTRAINT pk_parcel_manifest PRIMARY KEY(`parcel_manifest_id`)
) COMMENT 'Carrier manifest grouping parcels for a scheduled dispatch run to a specific carrier, service lane, or last-mile zone. Records manifest number, carrier SCAC/IATA code, dispatch date-time, origin facility, destination zone, total parcel count, total weight, total CBM, manifest status (open, closed, dispatched, reconciled), and EDI transmission status to carrier. Supports carrier handover and freight audit processes.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` (
    `delivery_attempt_id` BIGINT COMMENT 'Unique identifier for each physical delivery attempt. Primary key for the delivery attempt record.',
    `cod_collection_id` BIGINT COMMENT 'Foreign key linking to billing.cod_collection. Business justification: Each delivery attempt where COD is collected must link to billing COD collection record for audit trail. Real business process: COD collection verification, variance investigation, and agent accountab',
    `consignment_id` BIGINT COMMENT 'Reference to the parent consignment being delivered. Links this attempt to the shipment package.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (driver, courier) who performed this delivery attempt. Used for performance tracking and accountability.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Each delivery attempt is performed by a driver whose profile (license validity, certifications, performance rating, HOS status) must be validated for operational compliance and audit trail. Existing d',
    `digital_signature_id` BIGINT COMMENT 'Foreign key linking to document.digital_signature. Business justification: Delivery attempts capture electronic proof-of-delivery signatures. Real process: driver app captures consignee signature as digital signature record for delivery confirmation and dispute resolution.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the e-commerce fulfillment order driving this delivery. Links attempt to the original order.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Delivery attempts can result in incidents (dog bites, slips/falls on customer property, vehicle accidents, confrontations). Workers compensation claims, liability management, and driver safety progra',
    `last_mile_dispatch_id` BIGINT COMMENT 'Reference to the last-mile dispatch run that included this delivery attempt. Links to the route execution.',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Delivery attempts occur within specific delivery zones for performance tracking. Enables zone-level delivery performance analysis, failure rate tracking, and zone-based service improvement initiatives',
    `access_code` STRING COMMENT 'Building or gate access code provided to enable delivery agent entry to restricted premises. Confidential information for delivery execution.',
    `attempt_date` DATE COMMENT 'Calendar date on which this delivery attempt occurred. Used for daily delivery performance reporting.',
    `attempt_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate captured at the moment of delivery attempt. Used for geolocation verification and route optimization analysis.',
    `attempt_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate captured at the moment of delivery attempt. Used for geolocation verification and route optimization analysis.',
    `attempt_number` STRING COMMENT 'Sequential number of this delivery attempt for the consignment (1 for first attempt, 2 for second, etc.). Used to track re-delivery attempts.',
    `attempt_outcome_code` STRING COMMENT 'Standardized code indicating the result of the delivery attempt. Core field for OTD and OTIF KPI calculation. [ENUM-REF-CANDIDATE: delivered|failed|refused|no_access|redirected|damaged|address_incorrect — 7 candidates stripped; promote to reference product]',
    `attempt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the delivery agent arrived at the delivery location and initiated the attempt. Primary business event timestamp for SLA calculation.',
    `cod_amount` DECIMAL(18,2) COMMENT 'Amount to be collected from the recipient at delivery. Null if this is not a COD shipment.',
    `cod_collected_flag` BOOLEAN COMMENT 'Indicates whether the COD payment was successfully collected from the recipient. True if collected, false if not collected or not applicable.',
    `cod_currency_code` STRING COMMENT 'Three-letter ISO currency code for the COD amount (e.g., USD, EUR, GBP). Null if not a COD shipment.. Valid values are `^[A-Z]{3}$`',
    `cod_payment_method` STRING COMMENT 'Method used by recipient to pay the COD amount (cash, credit card, mobile payment, check). Null if COD was not collected.. Valid values are `cash|card|mobile_payment|check`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery attempt record was first created in the system. Used for audit trail and data lineage.',
    `delivery_address_line1` STRING COMMENT 'Primary street address line where the delivery attempt was made. May differ from consignment address if redirected.',
    `delivery_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, building) where the delivery attempt was made.',
    `delivery_city` STRING COMMENT 'City or municipality where the delivery attempt was made.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code of the delivery location (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `delivery_instructions` STRING COMMENT 'Special instructions provided by the consignee or shipper for this delivery (e.g., leave at door, call on arrival, deliver to reception). Guides delivery agent behavior.',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code of the delivery location. Used for geographic analysis and route optimization.',
    `delivery_state_province` STRING COMMENT 'State, province, or region where the delivery attempt was made.',
    `depot_location_code` STRING COMMENT 'Code identifying the depot or distribution center from which this delivery attempt was dispatched. Used for operational reporting and network analysis.',
    `epod_photo_captured_flag` BOOLEAN COMMENT 'Indicates whether a photo of the delivered parcel was captured at the delivery location. True if photo was taken, false otherwise.',
    `epod_reference_number` STRING COMMENT 'Unique reference number linking to the electronic proof of delivery record (signature, photo, barcode scan). Null if delivery was not completed.',
    `epod_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a digital signature was captured from the recipient at delivery. True if signature was obtained, false otherwise.',
    `failure_reason_code` STRING COMMENT 'Detailed reason code explaining why a delivery attempt failed (e.g., recipient_not_home, business_closed, access_denied, incorrect_address). Null if attempt was successful. [ENUM-REF-CANDIDATE: recipient_not_home|business_closed|access_denied|incorrect_address|security_restriction|weather_delay|vehicle_breakdown — promote to reference product]',
    `failure_reason_description` STRING COMMENT 'Free-text description providing additional context about the delivery failure. Captured by delivery agent for customer service follow-up.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery attempt record was last modified. Used for audit trail and change tracking.',
    `next_action_instruction` STRING COMMENT 'Instruction code indicating the next step to be taken following this attempt (e.g., schedule re-attempt, hold at depot, return to sender). Drives workflow automation.. Valid values are `reattempt|hold_at_facility|return_to_sender|redirect|contact_customer|escalate`',
    `reattempt_scheduled_date` DATE COMMENT 'Date on which the next delivery re-attempt is scheduled. Null if no re-attempt is planned or if delivery was successful.',
    `recipient_contact_phone` STRING COMMENT 'Phone number of the person who received the parcel or was contacted during the delivery attempt. Used for delivery confirmation and follow-up.',
    `recipient_name` STRING COMMENT 'Name of the person who received the parcel or who was present at the delivery location during the attempt. May differ from consignee if alternate recipient accepted delivery.',
    `recipient_relationship` STRING COMMENT 'Relationship of the actual recipient to the consignee (e.g., consignee themselves, family member, neighbor, building security). Used for delivery authorization validation.. Valid values are `consignee|family_member|neighbor|security|receptionist|other`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this delivery attempt resulted in an SLA breach (delivery not completed by target time). True if SLA was breached, false otherwise. Critical for customer service and penalty tracking.',
    `sla_target_delivery_timestamp` TIMESTAMP COMMENT 'Contractual target date and time by which delivery must be completed to meet SLA commitments. Used for OTIF and OTD KPI calculation.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that captured this delivery attempt record (e.g., mobile delivery app, handheld scanner, TMS). Used for data lineage and quality tracking.',
    `time_at_location_minutes` STRING COMMENT 'Duration in minutes that the delivery agent spent at the delivery location during this attempt. Used for productivity analysis and route optimization.',
    `vehicle_registration_number` STRING COMMENT 'License plate or registration number of the vehicle used for this delivery attempt. Supports fleet tracking and incident investigation.',
    `weather_condition_code` STRING COMMENT 'Weather condition at the time of delivery attempt. Used to analyze weather impact on delivery success rates and SLA performance. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|storm|extreme_heat|extreme_cold — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_delivery_attempt PRIMARY KEY(`delivery_attempt_id`)
) COMMENT 'Records each physical attempt to deliver a parcel to the consignee address. Captures attempt sequence number, attempt date-time, delivery agent ID, GPS coordinates at attempt, outcome code (delivered, failed, refused, no-access, redirected), failure reason, next-action instruction (re-attempt, hold at facility, return to sender), and ePOD reference. Central to last-mile SLA tracking and OTD/OTIF KPI computation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` (
    `fulfillment_carrier_assignment_id` BIGINT COMMENT 'Unique identifier for the carrier assignment record. Primary key for this entity.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Carrier selection must reference specific agreement for automated rate lookup and contract compliance validation. Essential for TMS rate shopping, capacity allocation, and ensuring assignments comply ',
    `carrier_id` BIGINT COMMENT 'Reference to the selected carrier organization responsible for transporting this fulfillment order or parcel. Links to the carrier master data.',
    `rate_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.rate_agreement. Business justification: Carrier assignments must reference the applicable rate agreement to apply correct pricing, service levels, and contractual terms. Critical for cost accuracy and contract compliance in carrier selectio',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Carrier assignments select specific services (not just carriers). Business process: rate shopping, service level selection, transit time commitment, carrier service performance tracking. Removes denor',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment or parcel shipment unit for which the carrier is assigned. May be null if assignment is at order level rather than parcel level.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or operator who performed the manual override of the carrier selection, used for audit trail and accountability. Populated only when override_flag is true.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order for which the carrier is being assigned. Links this assignment to the parent order being fulfilled.',
    `parcel_manifest_id` BIGINT COMMENT 'Reference to the parcel manifest or carrier manifest document that includes this carrier assignment, used for batch handover and carrier reconciliation. May be null if not yet manifested.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for this carrier assignment, used for tracking and reference in operational systems and customer communications.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the carrier assignment indicating whether the assignment is pending confirmation, confirmed and active, dispatched to carrier, cancelled, or failed.. Valid values are `pending|confirmed|dispatched|cancelled|failed`',
    `assignment_timestamp` TIMESTAMP COMMENT 'The date and time when the carrier was assigned to this fulfillment order or parcel, representing the moment the selection decision was made.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for cancellation of the carrier assignment (e.g., order_cancelled, carrier_rejected, capacity_unavailable, customer_change, address_correction). Populated only when assignment is cancelled. [ENUM-REF-CANDIDATE: order_cancelled|carrier_rejected|capacity_unavailable|customer_change|address_correction|service_downgrade|cost_optimization — promote to reference product]',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when this carrier assignment was cancelled. Null if the assignment has not been cancelled.',
    `carrier_account_number` STRING COMMENT 'The specific carrier account number or contract identifier under which this shipment is being tendered, used for billing reconciliation and rate application.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the carrier assignment was confirmed, either by the carrier accepting the tender or by system validation. May be null if not yet confirmed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this carrier assignment record was first created in the data platform, used for data lineage and audit trail.',
    `estimated_delivery_timestamp` TIMESTAMP COMMENT 'The estimated date and time of arrival (ETA) when the carrier is expected to deliver the shipment to the destination, used for SLA tracking and customer communication.',
    `estimated_pickup_timestamp` TIMESTAMP COMMENT 'The estimated date and time when the carrier is expected to pick up the shipment from the fulfillment center or origin location.',
    `estimated_transit_time_hours` DECIMAL(18,2) COMMENT 'The estimated transit time in hours from pickup to delivery as quoted by the carrier or calculated by the TMS at the time of assignment.',
    `integration_reference_code` STRING COMMENT 'External reference identifier from the source system or integration layer, used to trace this record back to the originating transaction in SAP TM, Oracle TMS, or other operational systems.',
    `label_generated_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipping label has been generated for this carrier assignment, signaling readiness for physical dispatch.',
    `label_generated_timestamp` TIMESTAMP COMMENT 'The date and time when the shipping label was generated for this carrier assignment. Null if label has not yet been generated.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this carrier assignment record was most recently updated in the data platform, used for change tracking and data freshness monitoring.',
    `master_tracking_number` STRING COMMENT 'The master tracking number or Master Air Waybill (MAWB) / Master Bill of Lading (MBL) number when this shipment is part of a consolidated load. May be null for direct shipments.',
    `override_flag` BOOLEAN COMMENT 'Boolean indicator of whether this carrier assignment was a manual override of the system-recommended carrier selection, requiring additional justification and audit.',
    `override_reason_code` STRING COMMENT 'Standardized code indicating the reason for manual override of the carrier selection (e.g., customer_request, capacity_constraint, service_failure, cost_exception, regulatory_requirement). Populated only when override_flag is true. [ENUM-REF-CANDIDATE: customer_request|capacity_constraint|service_failure|cost_exception|regulatory_requirement|quality_issue|strategic_partnership — promote to reference product]',
    `override_reason_description` STRING COMMENT 'Free-text description providing additional context and justification for the manual override of carrier selection. Populated only when override_flag is true.',
    `quoted_rate_amount` DECIMAL(18,2) COMMENT 'The freight rate amount quoted by the carrier for this shipment at the time of assignment, used for cost estimation and freight audit reconciliation.',
    `quoted_rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted rate amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `selection_method` STRING COMMENT 'Indicates whether the carrier was selected automatically by the Transportation Management System (TMS) optimization engine, manually by an operator, or as a manual override of the system recommendation.. Valid values are `automatic|manual|override`',
    `selection_priority_score` DECIMAL(18,2) COMMENT 'Numerical score calculated by the carrier selection algorithm representing the priority or ranking of this carrier for this shipment, used for optimization and decision audit.',
    `selection_rule_applied` STRING COMMENT 'The specific carrier selection rule or optimization criterion that was applied to choose this carrier (e.g., lowest_cost, fastest_transit, sla_compliant, preferred_carrier, customer_specified, zone_based).',
    `sla_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether the selected carrier and service level are expected to meet the SLA target delivery timestamp based on estimated transit time.',
    `sla_target_delivery_timestamp` TIMESTAMP COMMENT 'The contractual or committed delivery timestamp per the Service Level Agreement (SLA) with the customer, used to determine SLA compliance and breach detection.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that created this carrier assignment (e.g., SAP_TM, ORACLE_TMS, MANHATTAN_WMS), used for data lineage and integration troubleshooting.',
    `tender_status` STRING COMMENT 'Status of the carrier tender process indicating whether the shipment has been tendered to the carrier and the carriers response (not tendered, tendered, accepted, rejected).. Valid values are `not_tendered|tendered|accepted|rejected`',
    `tender_timestamp` TIMESTAMP COMMENT 'The date and time when the shipment was tendered to the carrier via EDI, API, or manual process. Null if not yet tendered.',
    `tracking_number` STRING COMMENT 'The unique tracking number or waybill number assigned by the carrier for this shipment, used for shipment visibility and proof of delivery (POD) tracking.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this carrier assignment (air, road, rail, ocean, multimodal).. Valid values are `air|road|rail|ocean|multimodal`',
    CONSTRAINT pk_fulfillment_carrier_assignment PRIMARY KEY(`fulfillment_carrier_assignment_id`)
) COMMENT 'Records the carrier selection decision for a fulfillment order or parcel, capturing the selected carrier, service level (express, standard, economy), carrier account number, rate quoted, selection rule applied (cheapest, fastest, SLA-compliant), assignment timestamp, and override flag with override reason. Supports carrier selection logic driven by SAP TM and Oracle TMS and enables freight audit reconciliation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` (
    `dispatch_run_id` BIGINT COMMENT 'Unique identifier for the dispatch run. Primary key for this entity representing a scheduled last-mile delivery route or courier trip.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Dispatch runs are executed by carriers (or internal fleet). Business process: carrier performance by run, carrier payment reconciliation, carrier capacity utilization tracking. Removes denormalized SC',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Courier assignment for last-mile dispatch runs requires driver profile validation including license type, HOS compliance status, performance rating, and certification eligibility (hazmat, temperature-',
    `employee_id` BIGINT COMMENT 'The unique identifier of the courier or delivery agent assigned to execute this dispatch run.',
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_zone. Business justification: Dispatch runs operate within specific delivery zones. The service_area_code STRING should be normalized to FK referencing delivery_zone.fulfillment_delivery_zone_id. This enables proper zone-based rou',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Dispatch run planning assigns specific fleet vehicles to courier routes. Fleet utilization analysis, vehicle maintenance scheduling coordination, and operational cost allocation require authoritative ',
    `actual_distance_km` DECIMAL(18,2) COMMENT 'The actual total distance traveled in kilometers during this dispatch run, captured from GPS or vehicle telematics.',
    `actual_duration_minutes` STRING COMMENT 'The actual total duration in minutes for this dispatch run, calculated from dispatch timestamp to return timestamp.',
    `actual_stop_count` STRING COMMENT 'The actual number of delivery stops completed during this dispatch run, which may differ from planned due to failed deliveries or route changes.',
    `cod_collection_count` STRING COMMENT 'The number of Cash on Delivery transactions collected during this dispatch run.',
    `cod_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for COD collections on this dispatch run.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this dispatch run record was first created in the system.',
    `dispatch_notes` STRING COMMENT 'Free-text operational notes or special instructions for this dispatch run, used for communication between dispatch coordinators and couriers.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'The actual date and time when the dispatch run departed from the origin depot or facility, marking the start of the last-mile delivery route.',
    `dispatch_type` STRING COMMENT 'The type or service level of this dispatch run, indicating the delivery speed and priority classification.. Valid values are `standard|express|same_day|scheduled|on_demand`',
    `edi_transmission_status` STRING COMMENT 'The status of EDI manifest transmission to the carrier system, indicating whether the dispatch run manifest has been successfully communicated.. Valid values are `pending|transmitted|acknowledged|failed`',
    `edi_transmission_timestamp` TIMESTAMP COMMENT 'The date and time when the EDI manifest was transmitted to the carrier system for this dispatch run.',
    `epod_capture_count` STRING COMMENT 'The number of electronic proof of delivery records captured during this dispatch run, including signatures and photos.',
    `failed_delivery_count` STRING COMMENT 'The number of parcels that could not be delivered during this dispatch run due to recipient unavailability, address issues, or other delivery exceptions.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator of whether this dispatch run includes hazardous materials requiring special handling and compliance documentation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this dispatch run record was most recently updated in the system.',
    `manifest_number` STRING COMMENT 'The manifest document number generated for carrier handover, listing all parcels loaded onto this dispatch run for last-mile delivery.',
    `manifest_reconciliation_status` STRING COMMENT 'The status of manifest reconciliation indicating whether all parcels loaded have been accounted for through delivery, return, or exception processing.. Valid values are `pending|reconciled|discrepancy|closed`',
    `origin_depot_code` STRING COMMENT 'The facility or depot code from which the dispatch run originates, representing the starting point for the last-mile delivery route.',
    `planned_distance_km` DECIMAL(18,2) COMMENT 'The planned total distance in kilometers for this dispatch run based on route optimization.',
    `planned_duration_minutes` STRING COMMENT 'The planned total duration in minutes for this dispatch run based on route optimization and historical performance.',
    `planned_stop_count` STRING COMMENT 'The number of delivery stops planned for this dispatch run based on route optimization and order allocation.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'The date and time when the manifest reconciliation was completed for this dispatch run.',
    `return_timestamp` TIMESTAMP COMMENT 'The actual date and time when the dispatch run returned to the origin depot or facility, marking the completion of the last-mile delivery route.',
    `returned_parcel_count` STRING COMMENT 'The number of parcels returned to the depot at the end of this dispatch run due to failed delivery attempts or customer refusal.',
    `route_code` STRING COMMENT 'The predefined route code or zone identifier for this dispatch run, used for route planning and optimization.',
    `run_date` DATE COMMENT 'The scheduled date for this dispatch run, representing the business day on which the last-mile delivery route is planned to execute.',
    `run_number` STRING COMMENT 'Business-facing unique identifier or manifest number for the dispatch run, used for operational tracking and carrier handover documentation.',
    `run_status` STRING COMMENT 'Current lifecycle status of the dispatch run indicating its operational state in the last-mile delivery workflow.. Valid values are `planned|dispatched|in_transit|completed|cancelled|returned`',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether this dispatch run breached its SLA target completion time.',
    `sla_target_completion_time` TIMESTAMP COMMENT 'The target completion timestamp for this dispatch run based on service level agreements and operational commitments.',
    `source_system_code` STRING COMMENT 'The code identifying the operational system of record that created this dispatch run record.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this dispatch run requires temperature-controlled transport for perishable or sensitive goods.',
    `total_cod_amount` DECIMAL(18,2) COMMENT 'The total monetary value of Cash on Delivery payments collected during this dispatch run.',
    `total_parcels_delivered` STRING COMMENT 'The total number of parcels successfully delivered during this dispatch run, representing successful last-mile completions.',
    `total_parcels_loaded` STRING COMMENT 'The total number of parcels loaded onto the vehicle or assigned to the courier for this dispatch run at departure.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'The total volume in cubic meters of all parcels loaded onto this dispatch run, used for vehicle capacity planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total weight in kilograms of all parcels loaded onto this dispatch run.',
    `vehicle_utilization_percentage` DECIMAL(18,2) COMMENT 'The percentage of vehicle capacity utilized by this dispatch run, calculated based on weight, volume, or parcel count constraints.',
    CONSTRAINT pk_dispatch_run PRIMARY KEY(`dispatch_run_id`)
) COMMENT 'Operational dispatch run representing a scheduled last-mile delivery route or courier trip, including the carrier manifest documentation for handover. Captures run date, origin depot/facility, assigned vehicle or courier, carrier SCAC/IATA code, manifest number, planned and actual stop counts, departure and return times, total parcels loaded and delivered, failed delivery count, run status, EDI transmission status to carrier, and manifest reconciliation status. Serves as the unit of carrier handover for parcel dispatch and feeds fleet domain for vehicle utilization tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`rma` (
    `rma_id` BIGINT COMMENT 'Unique identifier for the return merchandise authorization record. Primary key for the RMA entity.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Returns incur accessorial charges like restocking fees and reverse logistics handling. Business process: RMA cost recovery applies defined accessorial charges to return authorizations for merchant bil',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Returns are processed under agreement-defined return policies specifying return windows, restocking fees, and refund terms. Required for validating return eligibility, calculating restocking fees, and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Returns processing incurs warehouse labor, inspection, and restocking costs that must be allocated to cost centers. Reverse logistics cost analysis and returns cost budgeting require linking RMAs to c',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this return. Links to customer master data for account management and history.',
    `ecommerce_seller_id` BIGINT COMMENT 'Identifier of the e-commerce merchant or seller whose product is being returned. Used in marketplace fulfillment scenarios.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the originating fulfillment order that this return is associated with. Links the RMA back to the original shipment.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Returns of damaged/leaking dangerous goods, defective products causing customer injuries, or hazmat packaging failures trigger HSE incidents. Product safety teams need this link for recall decisions, ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Returns are shipped via carriers. Business process: reverse logistics carrier selection, return carrier performance tracking, return shipping cost allocation. Role-prefixed to distinguish from potenti',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: International returns require customs declarations for re-import processing. Supports reverse logistics customs clearance tracking, duty drawback claims, and RMA processing timelines that depend on cu',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Return shipments require return labels and documentation. Real process: RMA approval triggers return label generation and return shipping documentation for reverse logistics.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse employee who performed the condition inspection. Used for quality control and accountability.',
    `rma_received_by_employee_id` BIGINT COMMENT 'Identifier of the warehouse employee who processed the receipt of the returned merchandise. Used for accountability and audit trails.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: RMA processing may involve supplier coordination for defective goods, warranty claims, or vendor returns. Enables vendor return authorization tracking and supplier quality issue escalation.',
    `actual_receipt_date` DATE COMMENT 'Actual date when the returned merchandise was physically received at the return processing facility. Nullable if not yet received.',
    `actual_receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the returned merchandise was scanned into the warehouse management system upon receipt.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the return request was approved by the merchant or logistics provider. Nullable if not yet approved or if rejected.',
    `condition_assessment_code` STRING COMMENT 'Assessment of the physical condition of the returned merchandise upon inspection. Determines disposition and restocking eligibility.. Valid values are `sealed|opened|damaged|defective|missing_parts|unsellable`',
    `condition_assessment_notes` STRING COMMENT 'Free-text notes from the warehouse inspector describing the condition of the returned merchandise in detail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RMA record was first created in the system. Audit trail for data lineage.',
    `disposition_instruction` STRING COMMENT 'Instruction for how the returned merchandise should be handled. Determines the next step in the reverse logistics workflow. [ENUM-REF-CANDIDATE: restock|destroy|return_to_merchant|liquidate|donate|repair|quarantine — 7 candidates stripped; promote to reference product]',
    `expected_return_date` DATE COMMENT 'Estimated date when the returned merchandise is expected to arrive at the return processing facility or merchant location.',
    `external_rma_reference` STRING COMMENT 'External reference number from the merchant or e-commerce platform system. Used for cross-system reconciliation.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the returned merchandise was inspected and condition assessment was completed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this RMA record was most recently modified. Audit trail for change tracking.',
    `merchant_approved_flag` BOOLEAN COMMENT 'Indicates whether the merchant has approved the return request. True if approved, False if rejected or pending.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount to be refunded to the customer or credited to the merchant. May differ from original order value based on restocking fees or partial returns.',
    `refund_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `refund_method` STRING COMMENT 'Method by which the refund will be issued to the customer. Typically matches the original payment method.. Valid values are `original_payment|store_credit|gift_card|bank_transfer|check`',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was successfully processed and funds were released. Nullable if refund not yet processed.',
    `refund_trigger_status` STRING COMMENT 'Status of the refund or credit process triggered by this RMA. Tracks whether financial settlement has been initiated and completed.. Valid values are `not_triggered|triggered|processing|completed|failed`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the customer or merchant initiated the return request. Marks the beginning of the RMA lifecycle.',
    `restocked_flag` BOOLEAN COMMENT 'Indicates whether the returned merchandise has been restocked into sellable inventory. True if restocked, False otherwise.',
    `restocked_timestamp` TIMESTAMP COMMENT 'Date and time when the returned merchandise was restocked into inventory. Nullable if not restocked.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer or merchant for processing the return. Deducted from the refund amount.',
    `return_label_generated_flag` BOOLEAN COMMENT 'Indicates whether a return shipping label has been generated for the customer. True if label has been created and provided to the customer.',
    `return_label_generated_timestamp` TIMESTAMP COMMENT 'Date and time when the return shipping label was generated. Nullable if label has not yet been created.',
    `return_policy_compliant_flag` BOOLEAN COMMENT 'Indicates whether the return request complies with the applicable return policy terms. True if compliant, False if exception or policy violation.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for the return. Used for root cause analysis and quality improvement initiatives. [ENUM-REF-CANDIDATE: defective|wrong_item|damaged_in_transit|not_as_described|customer_remorse|size_fit_issue|duplicate_order|other — 8 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Free-text description providing additional details about the reason for the return. Captures customer or merchant comments.',
    `return_service_level` STRING COMMENT 'Service level selected for the return shipment. Determines transit time and cost for the return.. Valid values are `standard|expedited|express|economy`',
    `return_tracking_number` STRING COMMENT 'Unique tracking number assigned by the return carrier for shipment visibility. Used to monitor return shipment progress.. Valid values are `^[A-Z0-9]{10,35}$`',
    `return_warehouse_location_code` STRING COMMENT 'Code identifying the warehouse or return processing center where the merchandise was received. Links to facility master data.. Valid values are `^[A-Z0-9]{3,10}$`',
    `return_window_days` STRING COMMENT 'Number of days from original delivery within which the return was initiated. Used to validate compliance with return policy.',
    `rma_number` STRING COMMENT 'Externally visible business identifier for the return authorization. Used by customers, merchants, and customer service teams to track the return.. Valid values are `^RMA-[A-Z0-9]{8,12}$`',
    `rma_status` STRING COMMENT 'Current lifecycle status of the return authorization. Tracks the return from initial request through final disposition. [ENUM-REF-CANDIDATE: requested|approved|rejected|label_generated|in_transit|received|inspected|completed|cancelled — 9 candidates stripped; promote to reference product]',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the return processing exceeded the SLA target timeline. True if SLA was breached, False if met.',
    `sla_target_processing_days` STRING COMMENT 'Target number of days within which the return should be processed from receipt to disposition. Defined by service level agreement.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this RMA record. Examples: WMS, OMS, CRM, ECOM_PLATFORM.. Valid values are `^[A-Z0-9_]{2,10}$`',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Merchandise Authorization record managing the end-to-end returns processing workflow. Captures RMA number, originating fulfillment order reference, return reason code, merchant-approved return flag, return label generated flag, return carrier and tracking number, expected return date, actual receipt date, condition assessment on receipt (sealed, opened, damaged), disposition instruction (restock, destroy, return-to-merchant), and refund/credit trigger status. Supports reverse logistics and e-commerce returns SLA compliance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` (
    `pack_task_id` BIGINT COMMENT 'Unique identifier for the warehouse pack task. Primary key.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order being packed.',
    `parcel_id` BIGINT COMMENT 'Reference to the resulting parcel created by this pack task.',
    `pick_task_id` BIGINT COMMENT 'Reference to the pick task that supplied items for this pack task.',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse employee who performed the packing activity.',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Pack tasks are executed as part of wave processing. Adding wave_id FK enables tracking which wave the pack task belongs to, supporting wave-based performance metrics and labor allocation. No columns t',
    `billable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual weight or dimensional weight, used for carrier billing and freight charge calculation.',
    `carrier_code` STRING COMMENT 'Code identifying the selected carrier for parcel delivery (e.g., FedEx, UPS, DHL, USPS).',
    `carrier_service_level` STRING COMMENT 'Service level selected for delivery (e.g., express, standard, economy, same-day).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was first created in the warehouse management system.',
    `dim_weight_kg` DECIMAL(18,2) COMMENT 'Calculated dimensional weight based on parcel volume, used for freight rating when greater than actual weight.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator whether an exception or issue occurred during the pack task execution.',
    `exception_notes` STRING COMMENT 'Free-text notes describing the exception details, resolution actions, or special handling instructions.',
    `exception_reason_code` STRING COMMENT 'Code identifying the type of exception encountered (e.g., damaged_item, missing_item, wrong_item, packaging_shortage).',
    `fragile_flag` BOOLEAN COMMENT 'Boolean indicator whether the parcel contains fragile items requiring special handling and cushioning.',
    `gift_wrap_flag` BOOLEAN COMMENT 'Boolean indicator whether gift wrapping service was applied to the parcel per customer request.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator whether the parcel contains hazardous materials requiring special handling and labeling.',
    `item_quantity_packed` STRING COMMENT 'Total number of individual items or Stock Keeping Units packed into this parcel.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was last modified or updated in the warehouse management system.',
    `pack_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task was completed and the parcel was sealed and labeled.',
    `pack_duration_seconds` STRING COMMENT 'Total time in seconds taken to complete the pack task, calculated from start to completion timestamp.',
    `pack_method` STRING COMMENT 'Method used for packing: manual by employee, semi-automated with assistance, fully automated, or robotic.. Valid values are `manual|semi_automated|automated|robotic`',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the packer scanned the first item or initiated the pack task at the pack station.',
    `pack_station_code` STRING COMMENT 'Identifier of the physical pack station or workstation where the packing activity occurred.',
    `pack_task_number` STRING COMMENT 'Human-readable business identifier for the pack task, typically system-generated or barcode-scanned.',
    `pack_task_status` STRING COMMENT 'Current lifecycle status of the pack task in the warehouse management system workflow.. Valid values are `pending|in_progress|completed|cancelled|on_hold|exception`',
    `pack_zone_code` STRING COMMENT 'Code identifying the specific packing zone or area within the warehouse.',
    `packaging_material_code` STRING COMMENT 'Code identifying the type of packaging material used (box, envelope, poly mailer, etc.).',
    `packaging_material_sku` STRING COMMENT 'Stock Keeping Unit identifier for the specific packaging material used from inventory.',
    `packing_slip_included_flag` BOOLEAN COMMENT 'Boolean indicator whether a packing slip or invoice document was included in the parcel.',
    `parcel_weight_kg` DECIMAL(18,2) COMMENT 'Actual weight of the packed parcel measured at the pack station in kilograms.',
    `quality_check_passed_flag` BOOLEAN COMMENT 'Boolean indicator whether the packed parcel passed the quality inspection criteria.',
    `quality_check_performed_flag` BOOLEAN COMMENT 'Boolean indicator whether a quality inspection was performed on the packed parcel before dispatch.',
    `return_label_included_flag` BOOLEAN COMMENT 'Boolean indicator whether a prepaid return label was included in the parcel for Return Merchandise Authorization.',
    `shipping_label_number` STRING COMMENT 'Tracking number or barcode printed on the shipping label for carrier scanning and tracking.',
    `shipping_label_printed_flag` BOOLEAN COMMENT 'Boolean indicator whether the shipping label was successfully printed at the pack station.',
    `source_system_code` STRING COMMENT 'Code identifying the source Warehouse Management System or operational system that created this pack task record.',
    `void_fill_type` STRING COMMENT 'Type of void fill or cushioning material used to protect items during transit.. Valid values are `air_pillows|bubble_wrap|paper|foam|none|biodegradable`',
    `warehouse_location_code` STRING COMMENT 'Code identifying the warehouse or fulfillment center where the pack task was executed.',
    CONSTRAINT pk_pack_task PRIMARY KEY(`pack_task_id`)
) COMMENT 'Warehouse pack task capturing the packing activity for one or more picked items into a parcel. Records pack station ID, packer employee ID, packaging material used, void fill type, parcel weight at pack, DIM measurement, label printed flag, pack start and completion timestamps, quality check flag, and exception notes. Links pick tasks to resulting parcels and supports pack-station throughput tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` (
    `sla_breach_id` BIGINT COMMENT 'Unique identifier for the SLA breach event record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: SLA breaches trigger contractual penalties, credits, or service guarantees defined in master agreements. Required for penalty calculation, customer compensation, dispute resolution, and performance re',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for the delivery, if the breach is carrier-related.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: SLA breaches already track carrier; adding service enables service-level performance measurement (express vs standard). Business process: service-tier SLA tracking, penalty calculation by service leve',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment or parcel shipment associated with this SLA breach, if applicable.',
    `contract_sla_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_sla_commitment. Business justification: Breaches must reference the specific SLA commitment clause violated for accurate penalty calculation and performance measurement. Essential for automated penalty processing, SLA reporting, and linking',
    `credit_note_id` BIGINT COMMENT 'Foreign key linking to billing.credit_note. Business justification: SLA breaches trigger contractual service credits and penalty credit notes. Real business process: SLA penalty administration, customer compensation, and contract compliance tracking requiring breach-t',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account impacted by this SLA breach.',
    `delivery_attempt_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_attempt. Business justification: SLA breaches often occur during delivery attempts (e.g., failed delivery causing missed SLA). Adding delivery_attempt_id FK enables tracking which specific delivery attempt caused or is associated wit',
    `document_exception_id` BIGINT COMMENT 'Foreign key linking to document.document_exception. Business justification: Document-related issues cause SLA breaches (delayed customs clearance due to missing or incorrect documentation). Real process: root cause analysis links delivery failures to documentation problems.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order associated with this SLA breach event.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: SLA breaches are analyzed by lane to identify routing performance issues. Enables lane-level SLA performance monitoring, carrier accountability, and routing optimization. Critical for service quality ',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: SLA breaches can be tracked at parcel level (e.g., parcel not delivered within SLA window). Adding parcel_id FK enables parcel-level SLA tracking and breach analysis. No columns to remove as this is a',
    `employee_id` BIGINT COMMENT 'Reference to the employee who resolved and closed the SLA breach record.',
    `service_case_id` BIGINT COMMENT 'Reference to the customer service case opened to address this SLA breach, if applicable.',
    `sla_entitlement_id` BIGINT COMMENT 'Reference to the specific SLA entitlement or service level agreement contract that was breached.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'The actual date and time when the service level milestone was completed, resulting in the breach.',
    `breach_detected_timestamp` TIMESTAMP COMMENT 'Date and time when the SLA breach was first detected by the system or operations team.',
    `breach_duration_minutes` STRING COMMENT 'The duration of the SLA breach measured in minutes, calculated as the difference between actual completion and promised SLA timestamp.',
    `breach_number` STRING COMMENT 'Externally visible unique business identifier for the SLA breach event, used for tracking and reporting.. Valid values are `^BRH-[0-9]{10}$`',
    `breach_severity` STRING COMMENT 'Severity classification of the SLA breach based on business impact: minor (within tolerance), major (significant delay), or critical (severe customer impact).. Valid values are `minor|major|critical`',
    `breach_status` STRING COMMENT 'Current lifecycle status of the SLA breach record: open (newly detected), under-review (investigation in progress), closed (resolved), escalated (sent to management), or disputed (customer challenge).. Valid values are `open|under-review|closed|escalated|disputed`',
    `breach_type` STRING COMMENT 'Classification of the SLA breach by operational stage: OTD (On-Time Delivery), OTIF (On-Time In-Full), pick-SLA, pack-SLA, dispatch-SLA, or delivery-SLA.. Valid values are `on-time-delivery|on-time-in-full|pick-sla|pack-sla|dispatch-sla|delivery-sla`',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether formal corrective action is required to prevent recurrence of this type of SLA breach. True if required, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA breach record was first created in the system.',
    `customer_notification_channel` STRING COMMENT 'The communication channel used to notify the customer of the SLA breach: email, SMS, phone, customer portal, mobile app, or EDI.. Valid values are `email|sms|phone|portal|mobile-app|edi`',
    `customer_notification_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified of the SLA breach. True if notified, False if not.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified of the SLA breach, if applicable.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer or carrier has disputed the SLA breach determination. True if disputed, False otherwise.',
    `dispute_reason` STRING COMMENT 'Free-text explanation of the reason for disputing the SLA breach, provided by the disputing party.',
    `dispute_resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute regarding the SLA breach was resolved, if applicable.',
    `escalation_level` STRING COMMENT 'The escalation tier to which this SLA breach has been escalated: none (no escalation), tier-1 (supervisor), tier-2 (manager), tier-3 (director), or executive (C-level).. Valid values are `none|tier-1|tier-2|tier-3|executive`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the SLA breach was escalated to a higher management tier, if applicable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA breach record was last modified or updated.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty or credit amount owed to the customer as a result of the SLA breach, if applicable.',
    `penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether a contractual penalty or credit is applicable for this SLA breach. True if penalty applies, False otherwise.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `promised_sla_timestamp` TIMESTAMP COMMENT 'The contractually committed or customer-promised date and time by which the service level was to be met.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution actions taken, corrective measures implemented, and final outcome of the SLA breach investigation.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the SLA breach was resolved and closed.',
    `responsible_party` STRING COMMENT 'The party or entity responsible for the SLA breach: carrier, warehouse, customs authority, weather (force majeure), customer, internal operations, or third-party vendor. [ENUM-REF-CANDIDATE: carrier|warehouse|customs|weather|customer|internal-operations|third-party-vendor — 7 candidates stripped; promote to reference product]',
    `root_cause_category` STRING COMMENT 'Primary root cause category for the SLA breach, used for trend analysis and corrective action planning. [ENUM-REF-CANDIDATE: carrier-delay|warehouse-capacity|customs-hold|weather|system-failure|labor-shortage|traffic-congestion|incorrect-address|customer-unavailable|operational-error|vehicle-breakdown|security-incident|documentation-error — promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed free-text description of the specific circumstances and factors that led to the SLA breach.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that generated or detected this SLA breach event (e.g., WMS, TMS, OMS).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `warehouse_location_code` STRING COMMENT 'Code identifying the warehouse or fulfillment center where the breach occurred, if warehouse-related.. Valid values are `^[A-Z]{3}-[A-Z0-9]{4}$`',
    CONSTRAINT pk_sla_breach PRIMARY KEY(`sla_breach_id`)
) COMMENT 'Operational record of an SLA breach event for a fulfillment order or parcel. Captures breach type (OTD, OTIF, pick-SLA, pack-SLA, dispatch-SLA, delivery-SLA), breach severity (minor, major, critical), promised SLA timestamp, actual completion timestamp, breach duration in minutes, root cause category, responsible party (carrier, warehouse, customs, weather), breach status (open, under-review, closed), and customer notification flag. Feeds contract domain SLA penalty calculations and customer service case management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` (
    `fulfillment_exception_id` BIGINT COMMENT 'Unique identifier for the fulfillment exception record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or resolution owner assigned to investigate and resolve this exception.',
    `billing_dispute_id` BIGINT COMMENT 'Foreign key linking to billing.dispute. Business justification: Fulfillment exceptions (damaged goods, lost parcels, service failures) generate customer billing disputes. Real business process: exception-to-dispute workflow, root cause analysis, and dispute resolu',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment associated with this exception, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exceptions incur resolution costs (expedited shipping, additional labor, customer service) that must be tracked to cost centers. Exception cost analysis, quality improvement ROI, and root cause cost a',
    `delivery_attempt_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_attempt. Business justification: Fulfillment exceptions can occur during specific delivery attempts (e.g., access denied, recipient unavailable). Adding delivery_attempt_id FK enables tracking which delivery attempt triggered the exc',
    `document_exception_id` BIGINT COMMENT 'Foreign key linking to document.document_exception. Business justification: Fulfillment exceptions often stem from document issues (missing paperwork, incorrect declarations causing customs holds). Real process: exception management tracks both operational and documentary roo',
    `hold_id` BIGINT COMMENT 'Foreign key linking to customs.customs_hold. Business justification: Fulfillment exceptions are frequently caused by customs holds. Links exception records to customs hold details for root cause analysis, resolution tracking, and accurate customer communication about c',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Fulfillment exceptions (damaged goods, spills, worker injuries during handling, equipment failures) often trigger HSE incidents. Operations must link these for workers compensation claims, OSHA recor',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: Fulfillment exceptions often relate to specific parcels (e.g., damaged parcel, missing parcel, incorrect labeling). Adding parcel_id FK enables tracking which parcel is affected by the exception. No c',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that experienced this exception.',
    `related_exception_fulfillment_exception_id` BIGINT COMMENT 'Reference to a related or parent exception record if this exception is linked to or caused by another exception.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to fulfillment.rma. Business justification: Fulfillment exceptions can trigger or relate to RMA processes. The rma_number STRING should be normalized to FK referencing rma.rma_id. This enables tracking exceptions that result in returns processi',
    `assigned_to_team_code` STRING COMMENT 'Code identifying the team or department responsible for resolving this exception, such as customer service, warehouse operations, or carrier management.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was assigned to a resolution owner or team.',
    `carrier_code` STRING COMMENT 'Code identifying the carrier involved in the exception, if the exception is carrier-related such as carrier rejection or delivery failure.',
    `carrier_reference_number` STRING COMMENT 'Carrier-provided tracking or reference number associated with the exception event, used for coordination with carrier on resolution.',
    `compliance_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether the exception resulted in a regulatory or contractual compliance breach requiring formal reporting or remediation.',
    `compliance_framework_code` STRING COMMENT 'Code identifying the regulatory or compliance framework breached by this exception, such as Customs-Trade Partnership Against Terrorism (C-TPAT), Authorized Economic Operator (AEO), or General Data Protection Regulation (GDPR).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was first created in the system. Audit trail field for data lineage and compliance.',
    `customer_notification_channel` STRING COMMENT 'Communication channel used to notify the customer about the exception, such as email, Short Message Service (SMS), phone, customer portal, Application Programming Interface (API), or Electronic Data Interchange (EDI).. Valid values are `EMAIL|SMS|PHONE|PORTAL|API|EDI`',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified about the exception, if applicable.',
    `customer_notified_flag` BOOLEAN COMMENT 'Boolean indicator whether the customer or consignee was notified about this exception and its impact on their order.',
    `detected_by_source` STRING COMMENT 'System or process that detected and raised the exception, such as Warehouse Management System (WMS), Transportation Management System (TMS), carrier scan, customer report, quality inspection, automated validation, or manual audit. [ENUM-REF-CANDIDATE: WMS|TMS|CARRIER_SCAN|CUSTOMER_REPORT|QUALITY_INSPECTION|AUTOMATED_VALIDATION|MANUAL_AUDIT — 7 candidates stripped; promote to reference product]',
    `detection_location_code` STRING COMMENT 'Code identifying the physical or logical location where the exception was detected, such as warehouse code, depot code, or carrier facility code.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator whether this exception was escalated to higher management or specialized teams due to complexity, severity, or resolution delays.',
    `escalation_reason` STRING COMMENT 'Explanation of why the exception required escalation, such as exceeding resolution time threshold, high customer impact, or requiring specialized expertise.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was escalated, if applicable.',
    `exception_category` STRING COMMENT 'High-level categorization of the exception by functional area: operational, quality, carrier, customs, system, or customer-related.. Valid values are `OPERATIONAL|QUALITY|CARRIER|CUSTOMS|SYSTEM|CUSTOMER`',
    `exception_description` STRING COMMENT 'Detailed narrative description of the exception event, including context, circumstances, and any relevant observations at the time of detection.',
    `exception_number` STRING COMMENT 'Business-facing unique identifier for the exception, used for tracking and communication with stakeholders.. Valid values are `^EXC-[0-9]{10}$`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception indicating whether it is open, in progress, resolved, escalated, closed, or cancelled.. Valid values are `OPEN|IN_PROGRESS|RESOLVED|ESCALATED|CLOSED|CANCELLED`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the exception in the base currency, including costs for rework, reshipment, refunds, or penalties.',
    `financial_impact_currency_code` STRING COMMENT 'Three-letter International Organization for Standardization (ISO) 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was last modified. Audit trail field for data lineage and compliance.',
    `preventable_flag` BOOLEAN COMMENT 'Boolean indicator whether the exception was preventable through better processes, controls, or system validations, used for continuous improvement analysis.',
    `raised_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was first detected and recorded in the system. Primary business event timestamp for this transaction.',
    `recovery_action_required_flag` BOOLEAN COMMENT 'Boolean indicator whether recovery actions such as reshipment, replacement, or refund are required to resolve the exception.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean indicator whether this exception is a recurrence of a previously resolved exception for the same order or consignment.',
    `resolution_action_taken` STRING COMMENT 'Detailed description of the corrective action or resolution steps taken to address the exception, including any process changes or compensatory measures.',
    `resolution_duration_minutes` STRING COMMENT 'Total time in minutes from exception raised to resolution, used for Key Performance Indicator (KPI) tracking and Service Level Agreement (SLA) compliance.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was successfully resolved and closed.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the underlying root cause of the exception, determined during investigation and used for trend analysis and process improvement.',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings, including contributing factors and systemic issues identified.',
    `severity` STRING COMMENT 'Severity level of the exception indicating the urgency and business impact. Critical exceptions require immediate intervention.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated this exception record, such as Manhattan Warehouse Management System (WMS), Oracle Transportation Management System (TMS), or FourKites visibility platform.',
    `type_code` STRING COMMENT 'Standardized code classifying the type of exception encountered during fulfillment. Includes address validation failure, undeliverable parcel, damaged parcel, missing item, mispick, carrier rejection, customs hold, and system integration failure. [ENUM-REF-CANDIDATE: ADDRESS_VALIDATION_FAILURE|UNDELIVERABLE_PARCEL|DAMAGED_PARCEL|MISSING_ITEM|MISPICK|CARRIER_REJECTION|CUSTOMS_HOLD|SYSTEM_INTEGRATION_FAILURE — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_fulfillment_exception PRIMARY KEY(`fulfillment_exception_id`)
) COMMENT 'Operational exception record capturing any non-standard event during the fulfillment lifecycle that requires intervention. Covers exception types including address validation failure, undeliverable parcel, damaged parcel, missing item, mispick, carrier rejection, customs hold, and system integration failure. Records exception raised timestamp, exception type, severity, assigned resolution owner, resolution action taken, resolution timestamp, and escalation flag. Distinct from SLA breaches which are time-based; exceptions are event-based operational disruptions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` (
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant partner. Primary key for the merchant entity within the fulfillment domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Merchants operate under master fulfillment agreements defining rate schedules, service scope, billing terms, and SLA commitments. Fundamental relationship for pricing, service entitlements, and mercha',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account used for invoicing and payment processing for this merchants fulfillment services.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Links fulfillment merchant entity to customer domains account master. Core business need: merchant onboarding validation, billing account reconciliation, credit limit enforcement, SLA entitlement loo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Merchants/customers may be organized into profit centers for segment reporting (e.g., e-commerce vs. B2B logistics, vertical markets). Customer profitability analysis, segment EBITDA reporting, and st',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Merchants may also be suppliers in reverse logistics scenarios (returns, exchanges, vendor-managed inventory). Enables consolidated vendor management and financial reconciliation across forward and re',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Merchants often use 3PL providers for fulfillment operations. Business process: 3PL performance tracking per merchant, cost allocation, SLA management, merchant-3PL contract management.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Merchants acting as exporters/importers are registered customs trade parties. Links merchant accounts to their customs identifiers (EORI, importer number, AEO status) for compliance verification, cust',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Merchants have default fulfillment centers where their inventory is stored and orders are processed. The warehouse_location_code STRING should be normalized to FK referencing center.fulfillment_center',
    `aeo_certified_flag` BOOLEAN COMMENT 'Indicates whether the merchant holds AEO certification for expedited customs clearance and reduced inspections in international trade.',
    `api_key_hash` STRING COMMENT 'Hashed API authentication key for merchants using API integration channel. Stored as hash for security; actual key provided to merchant separately.',
    `average_daily_order_volume` STRING COMMENT 'The merchants average number of fulfillment orders processed per day, used for capacity planning and service tier assignment.',
    `business_address_line1` STRING COMMENT 'First line of the merchants registered business address including street number and street name.',
    `business_address_line2` STRING COMMENT 'Second line of the merchants business address for additional address details such as suite, floor, or building name.',
    `business_city` STRING COMMENT 'City or municipality of the merchants registered business address.',
    `business_country_code` STRING COMMENT 'Three-letter ISO country code for the merchants business address country.. Valid values are `^[A-Z]{3}$`',
    `business_postal_code` STRING COMMENT 'Postal code or ZIP code of the merchants business address.',
    `business_registration_number` STRING COMMENT 'Official government-issued business registration or company registration number for the merchant entity, used for compliance and verification.',
    `business_state_province` STRING COMMENT 'State, province, or administrative region of the merchants business address.',
    `cod_enabled_flag` BOOLEAN COMMENT 'Indicates whether the merchant is enabled for COD (Cash on Delivery) payment collection at the point of delivery. True if COD is available for this merchants orders.',
    `contract_end_date` DATE COMMENT 'The scheduled end date of the merchants fulfillment services contract. Null for open-ended or evergreen contracts.',
    `contract_start_date` DATE COMMENT 'The effective start date of the merchants fulfillment services contract with Transport Shipping.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant record was first created in the fulfillment system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit extended to the merchant for fulfillment services before payment is required. Used for financial risk management.',
    `credit_limit_currency_code` STRING COMMENT 'Three-letter ISO currency code for the credit limit amount.. Valid values are `^[A-Z]{3}$`',
    `customs_broker_required_flag` BOOLEAN COMMENT 'Indicates whether the merchants shipments require customs brokerage services for cross-border fulfillment. True if customs broker assignment is mandatory.',
    `default_service_level` STRING COMMENT 'The default delivery service level applied to merchant orders unless otherwise specified: standard (3-5 days), express (1-2 days), same_day, next_day, economy (5-7 days).. Valid values are `standard|express|same_day|next_day|economy`',
    `edi_identifier` STRING COMMENT 'Unique EDI interchange identifier (ISA ID) assigned to the merchant for EDI transaction routing and acknowledgment.. Valid values are `^[A-Z0-9]{8,15}$`',
    `industry_vertical` STRING COMMENT 'The primary industry vertical or business sector of the merchant (e.g., fashion, electronics, health and beauty, home goods, food and beverage).',
    `integration_channel` STRING COMMENT 'The technical channel through which the merchant integrates with Transport Shipping fulfillment systems: EDI (Electronic Data Interchange), API (Application Programming Interface), portal (web-based), SFTP (Secure File Transfer Protocol), or manual entry.. Valid values are `edi|api|portal|sftp|manual`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant record was most recently modified or updated.',
    `legal_name` STRING COMMENT 'The full legal registered name of the merchant entity as it appears on official business registration documents and contracts.',
    `merchant_code` STRING COMMENT 'Externally-facing unique alphanumeric code assigned to the merchant for identification in fulfillment operations, manifests, and integration channels.. Valid values are `^[A-Z0-9]{6,12}$`',
    `merchant_status` STRING COMMENT 'Current lifecycle status of the merchant relationship: active (operational), inactive (temporarily paused), suspended (compliance hold), onboarding (setup in progress), terminated (contract ended).. Valid values are `active|inactive|suspended|onboarding|terminated`',
    `merchant_tier` STRING COMMENT 'Classification of merchant based on business size and volume: enterprise (large corporate), SME (small-medium enterprise), marketplace (multi-vendor platform), startup (emerging business).. Valid values are `enterprise|sme|marketplace|startup`',
    `onboarding_date` DATE COMMENT 'The date when the merchant was successfully onboarded and activated for fulfillment services with Transport Shipping.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment of fulfillment service invoices (e.g., 30 for Net 30 terms).',
    `peak_season_multiplier` DECIMAL(18,2) COMMENT 'Multiplier factor representing the merchants order volume increase during peak seasons (e.g., 2.5 means 250% of average volume). Used for capacity forecasting.',
    `platform_type` STRING COMMENT 'The e-commerce platform technology used by the merchant to manage their online store and order processing. [ENUM-REF-CANDIDATE: shopify|magento|woocommerce|custom|sap_commerce|salesforce_commerce|bigcommerce — 7 candidates stripped; promote to reference product]',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for operational communications, order notifications, and issue escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the merchant organization responsible for fulfillment operations coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the merchant business contact, formatted according to E.164 international standard.. Valid values are `^+?[1-9]d{1,14}$`',
    `returns_enabled_flag` BOOLEAN COMMENT 'Indicates whether the merchant has returns processing (RMA - Return Merchandise Authorization) enabled through Transport Shipping fulfillment services.',
    `returns_policy_code` STRING COMMENT 'Reference code to the merchants returns policy configuration defining return windows, conditions, and processing rules.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sla_on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'Contractual target percentage for on-time delivery performance (e.g., 95.00 means 95% of orders must be delivered on time).',
    `sla_order_accuracy_target_pct` DECIMAL(18,2) COMMENT 'Contractual target percentage for order accuracy (correct items, quantities, and condition) in fulfillment operations.',
    `special_handling_requirements` STRING COMMENT 'Free-text description of any special handling requirements for the merchants products (e.g., fragile items, temperature control, hazardous materials, oversized goods).',
    `tax_identification_number` STRING COMMENT 'Tax identification number (TIN) or VAT registration number for the merchant, used for tax compliance and invoicing purposes.',
    `termination_date` DATE COMMENT 'The date when the merchant relationship was terminated or the contract ended. Null for active merchants.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for merchant relationship termination: contract_expiry, mutual_agreement, breach (contract violation), non_payment, business_closure, migration (moved to another provider).. Valid values are `contract_expiry|mutual_agreement|breach|non_payment|business_closure|migration`',
    `trading_name` STRING COMMENT 'The commercial trading name or brand name under which the merchant operates and is known to consumers. May differ from legal name.',
    CONSTRAINT pk_merchant PRIMARY KEY(`merchant_id`)
) COMMENT 'Master record for merchant partners whose e-commerce orders are fulfilled by Transport Shipping. Captures merchant legal name, trading name, merchant tier (enterprise, SME, marketplace), platform type (Shopify, Magento, WooCommerce, custom), integration channel (EDI, API, portal), account manager reference, onboarding date, active status, default service level, COD enabled flag, returns policy reference, and billing account reference. SSOT for merchant identity within the fulfillment domain — distinct from the customer domain which owns end-consumer identity.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` (
    `merchant_integration_id` BIGINT COMMENT 'Unique identifier for the merchant integration configuration record. Primary key.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant customer account that owns this integration channel.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Integration troubleshooting, escalation routing, and on-call support require identifying the employee who is the technical owner of each merchant integration. Real logistics operations need to page th',
    `activation_date` DATE COMMENT 'Date when the integration channel was first activated and began processing live transactions.',
    `api_endpoint_url` STRING COMMENT 'Base URL or endpoint address for REST/SOAP API integration. Contains the target server address for API calls.',
    `api_version` STRING COMMENT 'Version identifier of the API specification being used (e.g., v1, v2.1, 2023-Q4). Ensures compatibility between systems.',
    `authentication_credential` STRING COMMENT 'Encrypted or hashed authentication credential (API key, token, certificate reference) used to authenticate with the merchant platform. Stored securely.',
    `authentication_method` STRING COMMENT 'Security authentication mechanism used to establish identity and authorize access to the integration endpoint.. Valid values are `OAUTH2|API_KEY|BASIC_AUTH|CERTIFICATE|TOKEN|NONE`',
    `average_response_time_ms` STRING COMMENT 'Average response time in milliseconds for API calls or message exchanges through this integration channel. Performance metric.',
    `batch_processing_enabled_flag` BOOLEAN COMMENT 'Indicates whether messages are processed in batches rather than individually. Improves throughput for high-volume integrations.',
    `batch_size_limit` STRING COMMENT 'Maximum number of messages or records that can be included in a single batch transmission. Applicable when batch processing is enabled.',
    `compression_enabled_flag` BOOLEAN COMMENT 'Indicates whether message payloads are compressed before transmission to reduce bandwidth usage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration configuration record was first created in the system.',
    `cumulative_error_count` BIGINT COMMENT 'Total number of integration errors or failures since activation. Used for reliability metrics and trend analysis.',
    `data_encryption_enabled_flag` BOOLEAN COMMENT 'Indicates whether data transmitted through this integration channel is encrypted in transit (TLS/SSL).',
    `deactivation_date` DATE COMMENT 'Date when the integration channel was deactivated or suspended. Null if currently active.',
    `edi_identifier` STRING COMMENT 'EDI interchange sender or receiver ID used in ISA segment to uniquely identify the trading partner in EDI transactions.',
    `edi_qualifier` STRING COMMENT 'EDI interchange ID qualifier code identifying the type of sender/receiver identifier (e.g., ZZ for mutually defined, 01 for DUNS number). Used in ISA segment.',
    `edi_transaction_set` STRING COMMENT 'Comma-separated list of supported EDI transaction set codes (e.g., 204 for Motor Carrier Load Tender, 856 for Advanced Shipping Notice, 997 for Functional Acknowledgment). Applicable only when integration_type is EDI.',
    `error_count_24h` STRING COMMENT 'Number of integration errors or failed synchronization attempts in the last 24 hours. Used for health monitoring and alerting.',
    `integration_name` STRING COMMENT 'Business-friendly name or label for this integration channel, used for identification and reporting purposes.',
    `integration_status` STRING COMMENT 'Current operational status of the integration channel. Determines whether messages are processed or queued.. Valid values are `ACTIVE|SUSPENDED|DEGRADED|INACTIVE|TESTING|PENDING_ACTIVATION`',
    `integration_type` STRING COMMENT 'Technical protocol or method used for data exchange with the merchant platform. Determines message format and connectivity requirements.. Valid values are `EDI|REST_API|SFTP|WEBHOOK|SOAP_API|FLAT_FILE`',
    `last_error_code` STRING COMMENT 'Error code or identifier for the most recent integration failure. Used for diagnostics and root cause analysis.',
    `last_error_message` STRING COMMENT 'Detailed error message or description for the most recent integration failure. Provides context for troubleshooting.',
    `last_error_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent integration error or failure occurred.',
    `last_successful_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful data synchronization or message exchange through this integration channel.',
    `last_sync_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent synchronization attempt, regardless of success or failure. Used for monitoring and troubleshooting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration configuration record was most recently modified.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of automatic retry attempts for failed synchronization before escalating to manual intervention.',
    `message_format` STRING COMMENT 'Data serialization format used for message payloads exchanged through this integration channel.. Valid values are `JSON|XML|CSV|FIXED_WIDTH|EDI_X12|EDIFACT`',
    `message_format_version` STRING COMMENT 'Version identifier of the message format specification or schema being used (e.g., 1.0, 4010 for EDI X12).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special configuration details, or operational instructions related to this integration channel.',
    `polling_frequency_minutes` STRING COMMENT 'Interval in minutes at which the system polls or checks the integration endpoint for new messages or data. Null for push-based integrations.',
    `rate_limit_requests_per_minute` STRING COMMENT 'Maximum number of API requests or message transmissions allowed per minute. Prevents overloading the merchant platform.',
    `retry_policy` STRING COMMENT 'Strategy for retrying failed integration attempts. Defines timing and behavior for automatic retry logic.. Valid values are `IMMEDIATE|EXPONENTIAL_BACKOFF|FIXED_INTERVAL|NO_RETRY`',
    `sftp_directory_path` STRING COMMENT 'Remote directory path on SFTP server where files are exchanged (inbound and outbound).',
    `sftp_host` STRING COMMENT 'SFTP server hostname or IP address for file-based integration. Applicable when integration_type is SFTP.',
    `sftp_port` STRING COMMENT 'TCP port number for SFTP connection. Standard port is 22.',
    `success_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of successful synchronization attempts over a defined measurement period. Key performance indicator for integration reliability.',
    `supported_transaction_types` STRING COMMENT 'Comma-separated list of business transaction types supported by this integration (e.g., ORDER_INGEST, ASN_OUTBOUND, SHIPMENT_STATUS, INVENTORY_SYNC, RMA_NOTIFICATION).',
    `timeout_threshold_seconds` STRING COMMENT 'Maximum time in seconds to wait for a response from the integration endpoint before timing out and marking the attempt as failed.',
    `webhook_callback_url` STRING COMMENT 'URL endpoint on the fulfillment platform that receives push notifications from the merchant system. Applicable when integration_type is WEBHOOK.',
    CONSTRAINT pk_merchant_integration PRIMARY KEY(`merchant_integration_id`)
) COMMENT 'Configuration and operational record for a merchants integration channel with the fulfillment platform. Captures integration type (EDI 204/856/997, REST API, SFTP, webhook), endpoint URL or EDI qualifier/ISA ID, authentication method, message format version, polling frequency, last successful sync timestamp, error count, integration status (active, suspended, degraded), and supported transaction types. Enables omnichannel order ingestion from merchant e-commerce platforms.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` (
    `consignee_id` BIGINT COMMENT 'Unique identifier for the consignee record. Primary key.',
    `consignee_profile_id` BIGINT COMMENT 'Foreign key linking to customer.consignee_profile. Business justification: Links fulfillment-side delivery recipient entity to customers consignee master profile. Essential for delivery planning, address validation, delivery preference enforcement, denied-party screening, a',
    `access_code` STRING COMMENT 'Security access code or gate code required to enter the delivery location (e.g., building entry code, gated community code).',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this consignee record is currently active and available for use in fulfillment operations. True if active, false if deactivated or archived.',
    `address_line1` STRING COMMENT 'Primary street address line for delivery location. Includes street number, street name, and building identifier.',
    `address_line2` STRING COMMENT 'Secondary address line for additional location details such as apartment number, suite, floor, building name, or care-of information.',
    `address_type` STRING COMMENT 'Classification of the delivery address type: residential home, commercial business, automated locker, PUDO (Pick-Up Drop-Off) point, CFS (Container Freight Station), or ICD (Inland Container Depot).. Valid values are `residential|commercial|locker|pudo|cfs|icd`',
    `address_validation_status` STRING COMMENT 'Status of address validation process: validated (confirmed accurate), unvalidated (not yet checked), corrected (modified by validation service), or failed (could not be validated).. Valid values are `validated|unvalidated|corrected|failed`',
    `alternate_contact_phone` STRING COMMENT 'Secondary contact phone number for the consignee. Used when primary contact is unavailable or for escalation during delivery attempts.',
    `blacklist_flag` BOOLEAN COMMENT 'Indicates whether this consignee is blacklisted due to fraud, repeated delivery failures, abusive behavior, or security concerns. True if blacklisted, false otherwise.',
    `blacklist_reason` STRING COMMENT 'Explanation of why the consignee was blacklisted (e.g., fraud, repeated refusal to accept delivery, security threat, denied party screening match).',
    `business_hours_end` STRING COMMENT 'End time of business hours for commercial consignees in HH:MM format (24-hour clock). Used for scheduling delivery attempts during operating hours.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `business_hours_start` STRING COMMENT 'Start time of business hours for commercial consignees in HH:MM format (24-hour clock). Used for scheduling delivery attempts during operating hours.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `city` STRING COMMENT 'City or municipality name for the delivery address.',
    `cod_eligible_flag` BOOLEAN COMMENT 'Indicates whether this consignee is eligible to receive COD (Cash on Delivery) shipments. True if COD is permitted, false if COD is restricted due to payment history or risk assessment.',
    `cod_payment_method_preference` STRING COMMENT 'Preferred payment method for COD (Cash on Delivery) collections: cash, card (credit/debit), mobile_payment (digital wallet), or bank_transfer.. Valid values are `cash|card|mobile_payment|bank_transfer`',
    `consignee_name` STRING COMMENT 'Full legal name or business name of the delivery recipient (consignee). May be an individual person or a company name.',
    `consignee_type` STRING COMMENT 'Classification of the consignee entity type: individual person, business organization, government entity, or non-governmental organization.. Valid values are `individual|business|government|ngo`',
    `contact_email` STRING COMMENT 'Primary email address for the consignee. Used for delivery notifications, ePOD (Electronic Proof of Delivery) transmission, and customer communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the consignee. Used for delivery coordination, notifications, and exception handling.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the delivery address (e.g., USA, GBR, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consignee record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customs_id_number` STRING COMMENT 'Customs-specific identifier for the consignee (e.g., importer of record number, customs registration number). Used for cross-border shipments and customs declarations.',
    `delivery_instructions` STRING COMMENT 'Free-text special instructions for the delivery agent regarding access, location, handling, or recipient preferences (e.g., ring doorbell twice, use side entrance, fragile items).',
    `delivery_preference_leave_at_door` BOOLEAN COMMENT 'Indicates whether the consignee permits unattended delivery at the door. True if leave-at-door is acceptable, false if recipient presence is required.',
    `delivery_preference_neighbor_delivery` BOOLEAN COMMENT 'Indicates whether the consignee permits delivery to a neighbor if the primary recipient is unavailable. True if neighbor delivery is acceptable.',
    `delivery_preference_safe_place` STRING COMMENT 'Free-text instructions specifying a safe place to leave the parcel if the consignee is not present (e.g., back porch, garage, with building concierge).',
    `delivery_preference_signature_required` BOOLEAN COMMENT 'Indicates whether the consignee requires a signature for delivery confirmation. True if signature is mandatory, false if signature can be waived.',
    `delivery_time_window_preference` STRING COMMENT 'Preferred time window for delivery attempts: morning (before noon), afternoon (noon to 5pm), evening (after 5pm), business_hours (9am-5pm weekdays), or anytime (no preference).. Valid values are `morning|afternoon|evening|business_hours|anytime`',
    `denied_party_screening_status` STRING COMMENT 'Result of screening against denied party lists (e.g., OFAC, EU sanctions, UN sanctions): cleared (no match), flagged (potential match requiring review), pending (screening in progress), or not_screened.. Valid values are `cleared|flagged|pending|not_screened`',
    `failed_delivery_count` STRING COMMENT 'Total number of failed delivery attempts recorded for this consignee address across all historical shipments. Used for delivery risk scoring.',
    `failed_delivery_history_flag` BOOLEAN COMMENT 'Indicates whether this consignee has a history of failed delivery attempts. True if previous deliveries have failed, false otherwise. Used for risk assessment and route planning.',
    `geocode_accuracy` STRING COMMENT 'Precision level of the geocoded coordinates: rooftop (exact building), street (street-level), postal_code (postal code centroid), city (city centroid), or region (regional approximation).. Valid values are `rooftop|street|postal_code|city|region`',
    `geocode_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery address in decimal degrees. Used for route optimization and GPS (Global Positioning System) navigation.',
    `geocode_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery address in decimal degrees. Used for route optimization and GPS (Global Positioning System) navigation.',
    `language_preference` STRING COMMENT 'Two-letter ISO language code for the consignees preferred communication language (e.g., en, es, fr, de, zh). Used for delivery notifications and customer communications.. Valid values are `^[a-z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this consignee record was most recently modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notification_preference_email` BOOLEAN COMMENT 'Indicates whether the consignee has opted in to receive delivery notifications via email. True if email notifications are enabled.',
    `notification_preference_push` BOOLEAN COMMENT 'Indicates whether the consignee has opted in to receive delivery notifications via mobile app push notifications. True if push notifications are enabled.',
    `notification_preference_sms` BOOLEAN COMMENT 'Indicates whether the consignee has opted in to receive delivery notifications via SMS text message. True if SMS notifications are enabled.',
    `postal_code` STRING COMMENT 'Postal code or ZIP code for the delivery address. Format varies by country (e.g., 5-digit US ZIP, alphanumeric UK postcode).',
    `residential_commercial_indicator` STRING COMMENT 'Classification of the delivery location as residential (home address), commercial (business address), or mixed_use (building with both residential and commercial units). Affects delivery routing and surcharges.. Valid values are `residential|commercial|mixed_use`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated this consignee record (e.g., SAP_TM, ORACLE_TMS, MANHATTAN_WMS, SALESFORCE_CRM, ECOMMERCE_API).',
    `special_handling_requirements` STRING COMMENT 'Free-text description of any special handling requirements for deliveries to this consignee (e.g., temperature-sensitive, fragile, hazardous materials, security protocols).',
    `state_province` STRING COMMENT 'State, province, or administrative region for the delivery address. Format varies by country (e.g., two-letter US state codes, full province names).',
    `tax_id_number` STRING COMMENT 'Tax identification number for the consignee (e.g., EIN, VAT number, GST number). Required for customs clearance and DDP (Delivered Duty Paid) shipments.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the consignee location (e.g., America/New_York, Europe/London, Asia/Shanghai). Used for accurate delivery time window calculations and notifications.',
    CONSTRAINT pk_consignee PRIMARY KEY(`consignee_id`)
) COMMENT 'Master record for the end recipient (consignee) of a fulfillment delivery. Captures consignee name, structured delivery address (street, city, state, postal code, country ISO), address validation status and geocode, address type (residential, commercial, locker, PUDO point), contact phone, contact email, delivery preferences (leave at door, signature required, neighbor, time-slot preference), failed delivery history flag, and blacklist flag. Distinct from the customer domains account/profile — the consignee is the physical delivery recipient, not necessarily the ordering customer or merchant.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`center` (
    `center_id` BIGINT COMMENT 'Primary key for center',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fulfillment centers are physical facilities with operating costs (rent, utilities, labor, equipment) that must be tracked to cost centers. Facility cost allocation, overhead absorption rates, and capi',
    `facility_id` BIGINT COMMENT 'FK to warehouse.facility.facility_id — MUST-HAVE: Links fulfillment centers to the warehouse facility master. Required for inventory visibility, capacity planning, and operational reporting across fulfillment and warehouse domains.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the facility manager responsible for the operational management of this fulfillment center.',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Fulfillment centers connect to network hubs/gateways for linehaul operations. Business process: network planning, hub-to-spoke routing, capacity allocation, inter-facility transfer planning. Removes d',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Fulfillment centers procure MRO supplies, equipment, and consumables from suppliers. Tracks primary supplier relationship for facility operations, enabling spend analysis and supplier performance mana',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Fulfillment centers are network nodes in the routing topology. Enables facility integration into network design, routing optimization, and capacity planning. Standard practice in integrated logistics ',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Fulfillment centers may be operated by 3PL providers. Business process: 3PL facility management, operational oversight, cost center allocation. Role-prefixed as centers may have multiple 3PL relations',
    `address_line1` STRING COMMENT 'Primary street address line for the fulfillment center facility location. Organizational contact data classified as confidential.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential.',
    `annual_throughput_capacity_units` BIGINT COMMENT 'Maximum annual throughput capacity of the fulfillment center measured in units (SKUs) that can be processed per year, representing operational capacity for planning purposes.',
    `automation_level` STRING COMMENT 'Classification of the degree of automation deployed in the fulfillment center operations, ranging from manual labor-intensive to fully robotic systems.. Valid values are `manual|semi_automated|fully_automated|robotic`',
    `city` STRING COMMENT 'City or municipality where the fulfillment center is located. Organizational contact data classified as confidential.',
    `contact_email` STRING COMMENT 'Primary email address for operational communications with the fulfillment center. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the fulfillment center facility. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the fulfillment center is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment center record was first created in the system, used for audit trail and data lineage tracking.',
    `customs_bonded_warehouse_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment center operates as a customs bonded warehouse, allowing storage of imported goods before customs duties are paid.',
    `facility_type` STRING COMMENT 'Classification of the fulfillment center based on ownership and operational model. Owned = company-operated, 3PL = Third-Party Logistics provider, 4PL = Fourth-Party Logistics provider, cross_dock = transshipment facility, dark_store = retail-to-fulfillment conversion, micro_fulfillment = urban compact facility.. Valid values are `owned|3pl|4pl|cross_dock|dark_store|micro_fulfillment`',
    `ftz_designation` STRING COMMENT 'Free Trade Zone designation or license number if the fulfillment center operates within an FTZ, enabling duty deferral and trade facilitation benefits.',
    `go_live_date` DATE COMMENT 'Date when the fulfillment center commenced operational activities and began processing orders.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment center is certified to handle and store hazardous materials according to IMDG, IATA, and local regulations.',
    `labor_workforce_size` STRING COMMENT 'Total workforce size at the fulfillment center measured in Full-Time Equivalent (FTE) employees, including permanent and temporary staff.',
    `last_mile_zone_coverage` STRING COMMENT 'Comma-separated list of last-mile delivery zone codes or postal code prefixes that this fulfillment center serves, defining its geographic service area for direct delivery.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment center record was last modified, used for audit trail and change tracking purposes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the fulfillment center location in decimal degrees, used for routing, distance calculations, and geospatial analytics.',
    `lease_expiry_date` DATE COMMENT 'Date when the lease agreement for the fulfillment center facility expires, applicable for leased or 3PL/4PL facilities. Null for owned facilities.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the fulfillment center location in decimal degrees, used for routing, distance calculations, and geospatial analytics.',
    `operating_days_per_week` STRING COMMENT 'Number of days per week the fulfillment center operates, typically ranging from 5 (weekdays only) to 7 (continuous operations).',
    `operating_hours_end` STRING COMMENT 'Daily operating hours end time for the fulfillment center in HH:MM format (24-hour clock), representing when the facility ceases operations.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Daily operating hours start time for the fulfillment center in HH:MM format (24-hour clock), representing when the facility begins operations.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_status` STRING COMMENT 'Current lifecycle status of the fulfillment center indicating whether it is operational and available for order fulfillment activities.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|maintenance`',
    `pallet_positions` STRING COMMENT 'Total number of pallet storage positions available in the fulfillment center, representing discrete storage locations for palletized inventory.',
    `peak_daily_order_capacity` STRING COMMENT 'Maximum number of orders the fulfillment center can process in a single day during peak periods, used for capacity planning and load balancing.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the fulfillment center address. Organizational contact data classified as confidential.',
    `quality_certification` STRING COMMENT 'Quality management certifications held by the fulfillment center (e.g., ISO 9001, Six Sigma), demonstrating adherence to quality standards. [ENUM-REF-CANDIDATE: iso_9001|six_sigma|lean|tqm|gmp|haccp|brc — promote to reference product]',
    `security_certification` STRING COMMENT 'Security certifications held by the fulfillment center (e.g., C-TPAT, AEO, ISO 28000), demonstrating compliance with supply chain security standards. [ENUM-REF-CANDIDATE: c_tpat|aeo|iso_28000|tapa_a|tapa_b|tapa_c|pip — promote to reference product]',
    `source_system_code` STRING COMMENT 'Identifier of the source operational system from which this fulfillment center master record originated (e.g., Manhattan WMS, SAP TM).',
    `state_province` STRING COMMENT 'State, province, or administrative region where the fulfillment center is located. Organizational contact data classified as confidential.',
    `storage_capacity_cbm` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity of the fulfillment center measured in cubic meters (CBM), representing the three-dimensional space available for inventory storage.',
    `supported_service_types` STRING COMMENT 'Comma-separated list of service types supported by this fulfillment center (e.g., standard_delivery, express_delivery, same_day, next_day, cod, returns_processing). [ENUM-REF-CANDIDATE: standard_delivery|express_delivery|same_day|next_day|two_day|cod|returns_processing|gift_wrapping|kitting — promote to reference product]',
    `sustainability_certification` STRING COMMENT 'Environmental and sustainability certifications held by the fulfillment center (e.g., LEED, ISO 14001, carbon neutral), demonstrating commitment to environmental responsibility.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment center has temperature-controlled storage zones for perishable or temperature-sensitive goods.',
    `total_floor_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area of the fulfillment center facility measured in square meters, representing the physical footprint available for operations.',
    `wms_instance_code` STRING COMMENT 'Unique instance identifier for the WMS deployment at this facility, used for system integration and data lineage tracking.',
    `wms_system_code` STRING COMMENT 'Identifier for the WMS system instance deployed at this fulfillment center. Used to route integration messages and identify the source system for inventory and order data.',
    CONSTRAINT pk_center PRIMARY KEY(`center_id`)
) COMMENT 'Master record for fulfillment center facilities operated or contracted by Transport Shipping for e-commerce fulfillment and D2D operations. Captures facility code, facility name, address, facility type (owned, 3PL, 4PL, cross-dock, dark store), total floor area (sqm), storage capacity (CBM and pallet positions), WMS system instance, operating hours, supported service types, last-mile zone coverage, and operational status. Distinct from warehouse domains general warehouse master — this entity is scoped to fulfillment-specific facilities.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` (
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Unique identifier for the delivery zone record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Delivery zones may have dedicated cost centers for zone-specific operations and cost tracking. Zone-level P&L analysis, service pricing optimization, and cost-to-serve modeling require linking zones t',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Delivery zones are served by specific fulfillment centers (hubs). The hub_location_code STRING should be normalized to FK referencing center.fulfillment_center_id. This enables proper zone-to-hub assi',
    `lane_rate_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.lane_rate_zone. Business justification: Delivery zones map to pricing rate zones for zone-based tariff application. Business process: zone-based rating applies distance/geography-based pricing to delivery zones for accurate freight costing.',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Fulfillment delivery zones map to route delivery zones for service coverage alignment and SLA management. Enables zone harmonization across fulfillment and routing systems, critical for multi-system l',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this delivery zone record is active in the system. Inactive zones are retained for historical reference.',
    `average_delivery_attempts` DECIMAL(18,2) COMMENT 'Historical average number of delivery attempts required to successfully complete deliveries in this zone. Used for operational planning.',
    `carrier_coverage_level` STRING COMMENT 'Level of carrier network coverage available in this zone. Affects service availability and delivery reliability.. Valid values are `full|partial|limited|none`',
    `city_name` STRING COMMENT 'Primary city or municipality name associated with this delivery zone.',
    `cod_service_available_flag` BOOLEAN COMMENT 'Indicates whether Cash on Delivery (COD) service is available for deliveries in this zone based on carrier capabilities and risk assessment.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country in which this delivery zone is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery zone record was first created in the system.',
    `delivery_cutoff_time` TIMESTAMP COMMENT 'Local time cutoff for same-day or next-day delivery eligibility in this zone. Format HH:MM in 24-hour notation.',
    `effective_end_date` DATE COMMENT 'Date on which this delivery zone configuration ceases to be effective. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this delivery zone configuration becomes effective for operational use.',
    `epod_required_flag` BOOLEAN COMMENT 'Indicates whether electronic Proof of Delivery (ePOD) capture is mandatory for deliveries in this zone.',
    `express_transit_days` STRING COMMENT 'Number of business days for express delivery service to this zone from the fulfillment center. Used for expedited SLA promise calculation.',
    `fuel_surcharge_applicable_flag` BOOLEAN COMMENT 'Indicates whether fuel surcharge (Bunker Adjustment Factor - BAF) applies to shipments in this zone.',
    `holiday_delivery_available_flag` BOOLEAN COMMENT 'Indicates whether delivery service is available on public holidays in this zone.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery zone record was last modified in the system.',
    `max_parcel_dimensions_cm` STRING COMMENT 'Maximum parcel dimensions (length x width x height) in centimeters that can be delivered to this zone. Format: LxWxH.',
    `max_parcel_weight_kg` DECIMAL(18,2) COMMENT 'Maximum parcel weight in kilograms that can be delivered to this zone based on carrier and infrastructure constraints.',
    `next_day_eligible_flag` BOOLEAN COMMENT 'Indicates whether this zone is eligible for next-day delivery service based on cutoff times and carrier network coverage.',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, constraints, or operational considerations for this delivery zone.',
    `postal_code_range_end` STRING COMMENT 'Ending postal code of the range covered by this delivery zone. Used for zone lookup during order processing.',
    `postal_code_range_start` STRING COMMENT 'Starting postal code of the range covered by this delivery zone. Used for zone lookup during order processing.',
    `primary_carrier_code` STRING COMMENT 'Code identifying the primary carrier assigned to service this delivery zone. Used in carrier selection logic.',
    `remote_area_surcharge_flag` BOOLEAN COMMENT 'Indicates whether a remote area surcharge applies to deliveries in this zone due to distance or accessibility constraints.',
    `residential_surcharge_flag` BOOLEAN COMMENT 'Indicates whether residential delivery surcharge applies to addresses in this zone.',
    `restricted_goods_allowed_flag` BOOLEAN COMMENT 'Indicates whether restricted or regulated goods (e.g., hazardous materials, alcohol, pharmaceuticals) can be delivered to this zone based on local regulations.',
    `same_day_eligible_flag` BOOLEAN COMMENT 'Indicates whether this zone is eligible for same-day delivery service based on proximity to fulfillment centers and carrier availability.',
    `secondary_carrier_code` STRING COMMENT 'Code identifying the backup carrier for this delivery zone when primary carrier is unavailable or at capacity.',
    `serviceable_flag` BOOLEAN COMMENT 'Indicates whether this delivery zone is currently serviceable for deliveries. False indicates zone is temporarily or permanently out of service.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether recipient signature is required for deliveries in this zone as a default service requirement.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this delivery zone data originated (e.g., SAP TM, Oracle TMS, Manhattan WMS).',
    `standard_transit_days` STRING COMMENT 'Number of business days for standard delivery service to this zone from the fulfillment center. Used for Service Level Agreement (SLA) promise calculation.',
    `state_province_code` STRING COMMENT 'State or province code within the country. Format varies by country (e.g., US state codes, Canadian province codes).',
    `time_zone_code` STRING COMMENT 'IANA time zone identifier for this delivery zone. Used for scheduling delivery windows and cutoff time calculations.',
    `weekend_delivery_available_flag` BOOLEAN COMMENT 'Indicates whether Saturday and Sunday delivery service is available in this zone.',
    `zone_centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geographic centroid of the delivery zone. Used for distance calculations and route optimization.',
    `zone_centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geographic centroid of the delivery zone. Used for distance calculations and route optimization.',
    `zone_name` STRING COMMENT 'Human-readable name of the delivery zone for display and reporting purposes.',
    `zone_priority_rank` STRING COMMENT 'Priority ranking of this zone for resource allocation and route sequencing. Lower numbers indicate higher priority.',
    `zone_type` STRING COMMENT 'Classification of the delivery zone based on geographic and population density characteristics. Determines service level and surcharge applicability.. Valid values are `urban|suburban|rural|remote|island|restricted`',
    CONSTRAINT pk_fulfillment_delivery_zone PRIMARY KEY(`fulfillment_delivery_zone_id`)
) COMMENT 'Reference master defining geographic delivery zones used for last-mile dispatch planning and carrier assignment. Captures zone code, zone name, country, state/province, postal code ranges covered, zone type (urban, suburban, rural, remote), serviceable flag, standard transit days, express transit days, carrier coverage map, and surcharge applicability flag. Used by carrier assignment logic and SLA promise calculation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`wave` (
    `wave_id` BIGINT COMMENT 'Unique identifier for the warehouse wave release record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wave picking operations incur labor and equipment costs that must be allocated to cost centers. Warehouse productivity analysis, labor cost per unit picked, and wave efficiency metrics require linking',
    `center_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center where this wave is executed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Wave planning accountability, performance analysis, and operational coordination require tracking which employee planned and released each wave. Real warehouse operations need to identify the planner ',
    `template_id` BIGINT COMMENT 'Identifier of the wave planning template or rule set used to generate this wave. Links to wave configuration and optimization rules.',
    `actual_parcels_shipped` STRING COMMENT 'Actual count of parcels successfully packed and manifested from this wave. May differ from expected due to order cancellations or inventory shortages.',
    `assigned_labor_pool_code` BIGINT COMMENT 'Identifier of the labor pool or team assigned to execute this wave. Links to workforce scheduling and labor management systems.',
    `assigned_zone_code` STRING COMMENT 'Warehouse zone or picking area code where this wave is executed. Used for zone-based wave planning and slotting optimization.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for wave cancellation (e.g., inventory shortage, system error, operational constraint). Null if wave not cancelled.',
    `carrier_service_type` STRING COMMENT 'Primary carrier service type for orders in this wave (e.g., express, standard, economy). Used for carrier-specific wave grouping and manifest preparation.',
    `completed_timestamp` TIMESTAMP COMMENT 'Actual date and time when all orders in the wave were fully picked, packed, and manifested. Used for cycle time and throughput KPI calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wave record was first created in the WMS. Audit field for data lineage and wave planning analysis.',
    `cutoff_timestamp` TIMESTAMP COMMENT 'Deadline timestamp by which all orders in this wave must be picked, packed, and ready for dispatch to meet carrier pickup schedules and SLA commitments.',
    `efficiency_percent` DECIMAL(18,2) COMMENT 'Calculated efficiency percentage of wave execution based on planned vs actual cycle time and labor utilization. Used for continuous improvement and wave planning optimization.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this wave record was last modified. Audit field for change tracking and data freshness verification.',
    `manifest_generated_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier shipping manifest was generated for parcels in this wave. Critical for carrier pickup coordination and EDI transmission.',
    `notes` STRING COMMENT 'Free-text operational notes or special instructions for wave execution, such as handling requirements, priority rationale, or coordination notes.',
    `pack_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the last packing task in this wave was completed. Used for pack cycle time and throughput KPI calculation.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the first packing task in this wave was started. Used for packing station utilization and cycle time analysis.',
    `pick_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the last pick task in this wave was completed. Used for pick cycle time and throughput KPI calculation.',
    `pick_method` STRING COMMENT 'Picking methodology applied for this wave: discrete (order-by-order), batch (multiple orders picked together), cluster (cart-based multi-order), zone (zone-to-zone handoff), or wave (coordinated multi-zone).. Valid values are `discrete|batch|cluster|zone|wave`',
    `pick_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the first pick task in this wave was started by warehouse staff. Used for labor productivity and cycle time analysis.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for wave execution to begin. Used for labor planning and capacity scheduling.',
    `priority_level` STRING COMMENT 'Numeric priority ranking for wave execution sequencing. Lower numbers indicate higher priority. Used for SLA-driven wave scheduling.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the wave was released to the warehouse floor for pick-pack-ship execution. Key event timestamp for throughput analysis.',
    `short_pick_count` STRING COMMENT 'Count of order lines that could not be fully picked due to inventory shortage or location discrepancies. Key metric for inventory accuracy and fulfillment quality.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether this wave breached its cutoff timestamp or target ship date, resulting in SLA violations for included orders.',
    `source_system_code` STRING COMMENT 'Code identifying the source WMS or fulfillment system that generated this wave record (e.g., Manhattan WMS, SAP EWM). Used for multi-system integration and data lineage.',
    `target_ship_date` DATE COMMENT 'Target date by which all parcels in this wave must be shipped to meet customer delivery commitments and SLA windows.',
    `total_order_lines` STRING COMMENT 'Total count of individual order line items (SKUs) across all orders in the wave. Used for pick task volume estimation.',
    `total_orders` STRING COMMENT 'Total count of fulfillment orders included in this wave release. Core metric for wave size and labor allocation.',
    `total_parcels_expected` STRING COMMENT 'Expected total count of shipping parcels or packages to be generated from this wave. Used for packing station capacity planning and carrier manifest preparation.',
    `total_units` STRING COMMENT 'Total quantity of individual units (eaches) to be picked across all orders in the wave. Key metric for labor productivity and pick rate calculation.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total cubic volume in cubic meters (CBM) of all items in the wave. Used for space utilization planning and packing optimization.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight in kilograms of all items in the wave. Used for labor planning, equipment selection, and carrier capacity allocation.',
    `wave_number` STRING COMMENT 'Business-assigned unique wave number or code for tracking and reference within the fulfillment center.',
    `wave_status` STRING COMMENT 'Current lifecycle status of the wave: planned (scheduled but not released), released (active for picking), in-progress (picking underway), completed (all orders picked and packed), cancelled (wave aborted), or on-hold (temporarily suspended).. Valid values are `planned|released|in-progress|completed|cancelled|on-hold`',
    `wave_type` STRING COMMENT 'Classification of the wave strategy: single-order (discrete pick), multi-order (batch pick), batch (grouped orders), zone (zone-based picking), replenishment (inventory replenishment), or cross-dock (direct transfer).. Valid values are `single-order|multi-order|batch|zone|replenishment|cross-dock`',
    CONSTRAINT pk_wave PRIMARY KEY(`wave_id`)
) COMMENT 'Warehouse wave release record grouping fulfillment orders for coordinated pick-pack-ship execution within a defined time window. Captures wave number, wave type (single-order, multi-order, batch, zone, replenishment), release and cut-off timestamps, fulfillment center, total orders, total units, total parcels expected, wave status (planned, released, in-progress, completed, cancelled), priority level, and assigned labor pool. Core to Manhattan WMS wave planning, labor scheduling, and fulfillment throughput optimization.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` (
    `delivery_confirmation_id` BIGINT COMMENT 'Unique identifier for the delivery confirmation record. Primary key.',
    `charge_event_id` BIGINT COMMENT 'Foreign key linking to billing.charge_event. Business justification: Delivery confirmation (proof of delivery) triggers billable charge event creation. Real business process: event-based billing trigger, revenue recognition upon delivery, and billing automation requiri',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment that was delivered.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who performed the delivery and captured the proof of delivery.',
    `delivery_attempt_id` BIGINT COMMENT 'Reference to the specific delivery attempt that resulted in this confirmation.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Proof of delivery (ePOD) requires driver profile linkage for audit trail, performance metrics, and compliance verification. Existing delivery_agent_employee_id links to workforce.employee but lacks dr',
    `digital_signature_id` BIGINT COMMENT 'Foreign key linking to document.digital_signature. Business justification: Delivery confirmation includes digital signature capture for proof-of-delivery. Business process: ePOD signature links delivery event to formal signature record for legal and audit purposes.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order associated with this delivery.',
    `last_mile_dispatch_id` BIGINT COMMENT 'Reference to the last mile dispatch run during which this delivery was completed.',
    `parcel_id` BIGINT COMMENT 'Reference to the specific parcel that was delivered.',
    `reattempt_delivery_confirmation_id` BIGINT COMMENT 'Self-referencing FK on delivery_confirmation (reattempt_delivery_confirmation_id)',
    `carrier_code` STRING COMMENT 'Standard code identifying the carrier responsible for the delivery.',
    `cod_amount` DECIMAL(18,2) COMMENT 'The monetary amount collected from the recipient at the time of delivery for Cash on Delivery transactions.',
    `cod_collected_flag` BOOLEAN COMMENT 'Indicates whether the COD payment was successfully collected from the recipient at delivery.',
    `cod_collection_timestamp` TIMESTAMP COMMENT 'The precise date and time when the COD payment was collected from the recipient.',
    `cod_currency_code` STRING COMMENT 'Three-letter ISO currency code for the COD amount collected.. Valid values are `^[A-Z]{3}$`',
    `cod_flag` BOOLEAN COMMENT 'Indicates whether this delivery involved a Cash on Delivery payment collection.',
    `cod_payment_method` STRING COMMENT 'The payment instrument used by the recipient to pay the COD amount at delivery.. Valid values are `cash|card|mobile_payment|bank_transfer|check|other`',
    `cod_receipt_number` STRING COMMENT 'Unique receipt number issued to the recipient for the COD payment collected.',
    `confirmation_number` STRING COMMENT 'Unique business identifier for the delivery confirmation, used for external reference and customer communication.',
    `confirmation_status` STRING COMMENT 'Current status of the delivery confirmation record in its lifecycle.. Valid values are `confirmed|pending_verification|disputed|voided|amended`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery confirmation record was first created in the system.',
    `delivery_address_line1` STRING COMMENT 'Primary street address line where the delivery was completed.',
    `delivery_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, building) where the delivery was completed.',
    `delivery_agent_name` STRING COMMENT 'Full name of the delivery agent who completed the delivery, captured for audit and customer service purposes.',
    `delivery_city` STRING COMMENT 'City or municipality where the delivery was completed.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code of the delivery location.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'The calendar date on which the delivery was completed, used for daily reporting and SLA tracking.',
    `delivery_instructions` STRING COMMENT 'Special instructions provided by the consignee for the delivery, such as safe place location or access codes.',
    `delivery_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the actual delivery location, captured via GPS at the point of delivery.',
    `delivery_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the actual delivery location, captured via GPS at the point of delivery.',
    `delivery_notes` STRING COMMENT 'Free-text notes recorded by the delivery agent about the delivery circumstances, conditions, or any issues encountered.',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code of the delivery location.',
    `delivery_state_province` STRING COMMENT 'State, province, or administrative region where the delivery was completed.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The precise date and time when the parcel was delivered to the recipient, captured at the point of delivery.',
    `epod_photo_captured_flag` BOOLEAN COMMENT 'Indicates whether a photo of the delivered parcel was captured as visual proof of delivery.',
    `epod_photo_image_url` STRING COMMENT 'Storage location URL or path to the delivery photo image file showing the parcel at the delivery location.',
    `epod_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a digital signature was captured from the recipient as proof of delivery.',
    `epod_signature_image_url` STRING COMMENT 'Storage location URL or path to the digital signature image file captured at delivery.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery confirmation record was most recently modified.',
    `recipient_contact_phone` STRING COMMENT 'Phone number of the person who received the parcel, captured for verification and follow-up purposes.',
    `recipient_name` STRING COMMENT 'Full name of the person who received the parcel at the delivery location.',
    `recipient_relationship` STRING COMMENT 'Relationship of the person who received the parcel to the intended consignee. [ENUM-REF-CANDIDATE: self|family_member|neighbor|colleague|receptionist|security_guard|other — 7 candidates stripped; promote to reference product]',
    `service_level_code` STRING COMMENT 'Code representing the service level under which the delivery was completed (e.g., express, standard, same-day).',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the delivery was completed after the SLA target timestamp, constituting a service level breach.',
    `sla_target_delivery_timestamp` TIMESTAMP COMMENT 'The promised delivery timestamp according to the service level agreement with the customer.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this delivery confirmation record.',
    `tracking_number` STRING COMMENT 'The tracking number of the parcel that was delivered, used for shipment visibility and customer tracking.',
    `vehicle_registration_number` STRING COMMENT 'Registration plate number of the vehicle used to complete the delivery.',
    CONSTRAINT pk_delivery_confirmation PRIMARY KEY(`delivery_confirmation_id`)
) COMMENT 'Consolidated delivery confirmation record capturing electronic proof of delivery (ePOD) evidence and any Cash on Delivery (COD) payment collection at the point of delivery. Stores recipient signature, photo evidence, delivery timestamp, COD amount collected, and payment method.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` (
    `merchant_compliance_enrollment_id` BIGINT COMMENT 'Unique identifier for this merchant-program enrollment record. Primary key for the association.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to the compliance program in which the merchant is enrolled',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to the merchant partner enrolled in the compliance program',
    `audit_frequency` STRING COMMENT 'The frequency at which this merchant is audited for compliance within this specific program. Identified in detection phase relationship data.',
    `benefits_active_flag` BOOLEAN COMMENT 'Indicates whether this merchant is currently receiving the preferential treatment benefits (reduced examination rates, expedited release) associated with this program enrollment.',
    `certification_expiry_date` DATE COMMENT 'Date when this merchants certification in this specific program expires and requires renewal.',
    `certification_status` STRING COMMENT 'Current status of the merchants certification within this specific program (pending, active, suspended, expired, revoked, under_review). Identified in detection phase relationship data.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numerical compliance score or rating assigned to this merchant for this specific program based on audit results and ongoing compliance monitoring. Identified in detection phase relationship data.',
    `enrollment_date` DATE COMMENT 'Date when the merchant was enrolled or registered in this specific compliance program. Identified in detection phase relationship data.',
    `enrollment_notes` STRING COMMENT 'Free-text notes regarding this specific merchant-program enrollment including special conditions, audit findings, or compliance issues.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit conducted for this merchant within this specific program. Identified in detection phase relationship data.',
    `merchant_certificate_number` STRING COMMENT 'Unique certificate or membership number issued to this merchant for this specific program enrollment.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit for this merchant within this specific program.',
    `program_tier` STRING COMMENT 'The tier or level at which this merchant participates in this specific program (e.g., Tier 1, Tier 2, Tier 3 for C-TPAT; different programs have different tier structures). Identified in detection phase relationship data.',
    CONSTRAINT pk_merchant_compliance_enrollment PRIMARY KEY(`merchant_compliance_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between merchants and customs compliance programs. It captures the participation of merchant partners in trade compliance certification programs (C-TPAT, AEO, Trusted Trader) with enrollment-specific attributes including certification status, audit history, compliance scores, and program-specific benefits. Each record links one merchant to one compliance program with attributes that exist only in the context of this enrollment relationship.. Existence Justification: In the logistics industry, merchant partners commonly participate in multiple customs compliance programs simultaneously across different jurisdictions (e.g., a merchant may hold C-TPAT certification in the US, AEO status in the EU, and participate in a national Trusted Trader program in Asia). Each compliance program has multiple merchant participants. The business actively manages these enrollments, tracking certification status, audit schedules, compliance scores, and program-specific benefits for each merchant-program combination to determine eligibility for preferential customs treatment and risk-based processing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` (
    `merchant_carrier_agreement_id` BIGINT COMMENT 'Primary key for merchant_carrier_agreement',
    `agreement_id` BIGINT COMMENT 'Primary key uniquely identifying each merchant-carrier agreement record',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier partner in the network domain',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to the merchant partner in the fulfillment domain',
    `account_number` STRING COMMENT 'Merchant-specific account number assigned by the carrier for billing and tracking purposes. Each merchant-carrier combination has a unique account number.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this agreement record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this merchant-carrier agreement became effective and the merchant was authorized to use this carrier.',
    `expiry_date` DATE COMMENT 'Date when this merchant-carrier agreement expires or is scheduled for renewal. Null for evergreen agreements.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this agreement record was last updated.',
    `merchant_carrier_agreement_status` STRING COMMENT 'Current lifecycle status of this merchant-carrier agreement: active (operational), suspended (temporarily inactive), expired (past expiry_date), terminated (ended before expiry).',
    `performance_tier` STRING COMMENT 'Performance classification for this merchant-carrier relationship based on volume, on-time delivery, and service quality metrics. Used for performance tracking and incentive programs.',
    `rate_card_reference` STRING COMMENT 'Reference code to the negotiated rate card document or pricing schedule applicable to this merchant-carrier relationship. Rates vary by merchant volume and contract terms.',
    `service_levels_authorized` STRING COMMENT 'Comma-separated list of service levels the merchant is authorized to use with this carrier (e.g., express, standard, economy, freight). Varies by merchant-carrier agreement.',
    CONSTRAINT pk_merchant_carrier_agreement PRIMARY KEY(`merchant_carrier_agreement_id`)
) COMMENT 'This association product represents the contractual agreement between a merchant and a carrier partner. It captures merchant-specific carrier account numbers, authorized service levels, negotiated rate cards, and contract periods that exist only in the context of this merchant-carrier relationship. Each record links one merchant to one carrier with relationship-specific attributes that enable merchant carrier selection, rate management, and performance tracking.. Existence Justification: In Transport Shipping logistics operations, merchants maintain contractual agreements with multiple carrier partners to ensure redundancy, enable rate shopping, and support diverse service level requirements across different shipping lanes and product types. Conversely, each carrier serves multiple merchant clients under separate contractual terms. The business actively manages these merchant-carrier agreements as operational entities, tracking merchant-specific carrier account numbers, authorized service levels, negotiated rate cards, contract periods, and performance tiers.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` (
    `fulfillment_allocation_id` BIGINT COMMENT 'Primary key for fulfillment_allocation',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to the commercial agreement that governs this capacity allocation',
    `allocation_id` BIGINT COMMENT 'Unique identifier for this facility allocation record. Primary key.',
    `center_id` BIGINT COMMENT 'Foreign key linking to the fulfillment center facility providing capacity under this allocation',
    `allocation_status` STRING COMMENT 'Current operational status of this allocation, controlling whether orders under this agreement can be routed to this center.',
    `capacity_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the fulfillment centers total capacity allocated to this agreement, used for capacity planning and order prioritization. Identified in detection phase as relationship-specific data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this facility allocation becomes active and the center begins servicing this agreement. Identified in detection phase as relationship-specific data.',
    `expiry_date` DATE COMMENT 'Date when this facility allocation terminates. Nullable for open-ended allocations. Identified in detection phase as relationship-specific data.',
    `priority_level` STRING COMMENT 'Priority tier for order processing and capacity allocation when multiple agreements compete for center resources. Identified in detection phase as relationship-specific data.',
    `service_scope` STRING COMMENT 'Defines the range of fulfillment services this center will provide under this agreement (e.g., full fulfillment, storage only, cross-dock, returns processing). Identified in detection phase as relationship-specific data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified.',
    CONSTRAINT pk_fulfillment_allocation PRIMARY KEY(`fulfillment_allocation_id`)
) COMMENT 'This association product represents the contractual allocation of fulfillment center capacity to specific commercial agreements. It captures the service scope, capacity commitment, and priority level for each agreement-center pairing. Each record links one fulfillment center to one agreement with attributes that exist only in the context of this capacity allocation relationship.. Existence Justification: In Transport Shippings logistics operations, fulfillment centers operate as multi-tenant facilities serving multiple customer agreements simultaneously (e-commerce clients, 3PL contracts, enterprise fulfillment agreements). Conversely, large commercial agreements typically utilize multiple fulfillment centers to achieve geographic coverage, redundancy, and capacity scaling. The business actively manages these allocations by assigning capacity percentages, defining service scopes per center-agreement pair, and setting priority levels for order routing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` (
    `fulfillment_program_enrollment_id` BIGINT COMMENT 'Primary key for fulfillment_program_enrollment',
    `center_id` BIGINT COMMENT 'Foreign key linking to the fulfillment center facility enrolled in the safety program',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned as the local coordinator for this program at this specific fulfillment center. Explicitly identified in detection data as relationship attribute.',
    `program_id` BIGINT COMMENT 'Foreign key linking to the safety program in which the fulfillment center is enrolled',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score or rating from the most recent audit of this facility-program combination (e.g., percentage score, 0-100 scale).',
    `certification_level` STRING COMMENT 'Level or tier of certification achieved by the fulfillment center for this program (e.g., Bronze, Silver, Gold, Platinum for tiered programs; or certification grade). Explicitly identified in detection data as relationship attribute.',
    `compliance_status` STRING COMMENT 'Current compliance status of the fulfillment center for this specific safety program. Explicitly identified in detection data as relationship attribute.',
    `corrective_actions_pending` STRING COMMENT 'Number of corrective actions currently open and pending closure for this facility-program enrollment.',
    `effective_end_date` DATE COMMENT 'Date on which this enrollment ended or is scheduled to end. Null for active enrollments.',
    `effective_start_date` DATE COMMENT 'Date from which this enrollment became operationally effective and binding for the facility.',
    `enrollment_date` DATE COMMENT 'Date on which the fulfillment center was formally enrolled in this safety program. Corresponds to program_enrollment_date from detection data.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment relationship (distinct from compliance_status which tracks regulatory compliance).',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit conducted for this facility-program combination. Explicitly identified in detection data as relationship attribute.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next audit of this facility-program enrollment.',
    `non_conformance_count` STRING COMMENT 'Number of non-conformances or findings identified in the most recent audit for this enrollment.',
    `notes` STRING COMMENT 'Free-text notes or comments specific to this enrollment relationship, such as special conditions, exemptions, or historical context.',
    CONSTRAINT pk_fulfillment_program_enrollment PRIMARY KEY(`fulfillment_program_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between fulfillment centers and safety programs. It captures the formal participation of a fulfillment center in a specific safety program, including compliance tracking, audit results, certification levels, and coordinator assignments. Each record links one fulfillment center to one safety program with attributes that exist only in the context of this enrollment relationship.. Existence Justification: In Transport Shipping logistics operations, fulfillment centers participate in multiple safety programs simultaneously (OSHA VPP, ISO 45001, hazmat handling certifications, driver safety programs), and each safety program covers multiple facilities across the network. Safety managers actively manage these enrollments as operational entities, tracking compliance status, conducting facility-specific audits, assigning local coordinators, and monitoring certification levels for each facility-program combination. This is not a reference relationship but an actively managed business process with substantial relationship-specific data.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`service` (
    `service_id` BIGINT COMMENT 'Unique identifier for this center-carrier service agreement. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier partner providing service',
    `center_id` BIGINT COMMENT 'Foreign key linking to the fulfillment center facility being served',
    `capacity_allocation` DECIMAL(18,2) COMMENT 'Daily shipment capacity (in cubic meters or weight units) allocated to this carrier at this fulfillment center. Used for capacity planning and load balancing across multiple carrier partners.',
    `days` STRING COMMENT 'Comma-separated list of days of the week this carrier provides pickup service at this fulfillment center (e.g., Mon,Tue,Wed,Thu,Fri). Service days vary by facility location and carrier route coverage.',
    `effective_date` DATE COMMENT 'Date when this center-carrier service agreement became effective. Used to track historical service configurations and support time-based queries.',
    `expiry_date` DATE COMMENT 'Date when this center-carrier service agreement expires or was terminated. Null indicates an active ongoing agreement. Used for contract lifecycle management.',
    `pickup_cutoff_time` TIMESTAMP COMMENT 'Daily cutoff time (HH:MM 24-hour format) by which shipments must be ready for carrier pickup at this specific fulfillment center. Varies by carrier and facility based on route schedules.',
    `priority_rank` STRING COMMENT 'Priority ranking of this carrier for shipments from this fulfillment center (1=highest priority). Used in carrier selection logic when multiple carriers serve the same center.',
    `service_status` STRING COMMENT 'Current operational status of this center-carrier service relationship. Values: active (operational), suspended (temporarily paused), terminated (ended), pending (not yet active).',
    CONSTRAINT pk_service PRIMARY KEY(`service_id`)
) COMMENT 'This association product represents the operational service agreement between a fulfillment center and a carrier partner. It captures center-specific pickup schedules, service day configurations, and capacity allocations that exist only in the context of this facility-carrier relationship. Each record links one fulfillment center to one carrier with operational parameters that govern how that carrier serves that specific facility.. Existence Justification: In Transport Shipping logistics operations, fulfillment centers are served by multiple carrier partners simultaneously for redundancy, capacity, and service coverage, and each carrier serves multiple fulfillment centers across the network. The business actively manages center-specific service agreements that define pickup schedules, cutoff times, service days, and capacity allocations that vary by facility-carrier combination. These operational parameters cannot be stored on either the center or carrier entity alone because they exist only in the context of the specific facility-carrier relationship.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` (
    `merchant_safety_certification_id` BIGINT COMMENT 'Unique identifier for this merchant-training certification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the Transport Shipping employee (typically compliance manager or account manager) who assigned this training requirement to the merchant.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to the merchant partner who must complete the safety training',
    `safety_training_id` BIGINT COMMENT 'Foreign key to safety.safety_training.safety_training_id',
    `training_id` BIGINT COMMENT 'Foreign key linking to the safety training course that the merchant must complete',
    `assignment_date` DATE COMMENT 'Date when this training requirement was assigned to the merchant, triggering the compliance obligation.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion of the training. Sourced from detection phase relationship_data: certificate_number. Used for regulatory audit trail.',
    `completion_date` DATE COMMENT 'Date when the merchant (or their designated personnel) successfully completed this safety training course. Sourced from detection phase relationship_data: training_completion_date.',
    `compliance_status` STRING COMMENT 'Current compliance status of the merchant for this training requirement. Sourced from detection phase relationship_data: compliance_status. Values: compliant (current and valid), expired (certification lapsed), pending (training scheduled but not completed), non_compliant (required but not completed).',
    `cost_allocation` DECIMAL(18,2) COMMENT 'Cost allocated to this specific merchant for completing this training course. Sourced from detection phase relationship_data: training_cost_allocation. May differ from standard cost_per_participant if group discounts or merchant-specific pricing applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost_allocation amount (e.g., USD, EUR, GBP).',
    `next_recertification_date` DATE COMMENT 'Scheduled date when the merchant must recertify or renew this training to maintain compliance. Sourced from detection phase relationship_data: next_recertification_date. Calculated based on completion_date plus refresher_frequency_months from the training course master.',
    `notes` STRING COMMENT 'Free-text notes regarding this certification record, including special circumstances, exemptions, or audit findings.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Percentage score achieved by the merchant on the competency assessment for this training course. Null if assessment method does not produce a numeric score.',
    `training_delivery_mode_used` STRING COMMENT 'The actual delivery mode used for this specific merchant completion. May differ from the course default if multiple modes are offered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last updated.',
    CONSTRAINT pk_merchant_safety_certification PRIMARY KEY(`merchant_safety_certification_id`)
) COMMENT 'This association product represents the compliance certification relationship between merchant partners and safety training courses required for handling dangerous goods shipments. It captures the completion status, certification validity, and recertification scheduling for each merchant-training combination. Each record links one merchant to one safety training course with attributes that exist only in the context of this compliance relationship.. Existence Justification: In Transport Shipping logistics operations, merchants who ship dangerous goods (lithium batteries, hazmat, etc.) must maintain multiple safety training certifications mandated by different regulatory bodies (IATA DGR, DOT, ADR). Each training course applies to multiple merchants based on their product mix and shipping lanes. The compliance team actively manages this many-to-many relationship by tracking completion dates, certificate numbers, recertification schedules, and cost allocation for each merchant-training combination, generating training matrix reports for regulatory audits.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_parcel_manifest_id` FOREIGN KEY (`parcel_manifest_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel_manifest`(`parcel_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_parcel_manifest_id` FOREIGN KEY (`parcel_manifest_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel_manifest`(`parcel_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_delivery_attempt_id` FOREIGN KEY (`delivery_attempt_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`delivery_attempt`(`delivery_attempt_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_delivery_attempt_id` FOREIGN KEY (`delivery_attempt_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`delivery_attempt`(`delivery_attempt_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_related_exception_fulfillment_exception_id` FOREIGN KEY (`related_exception_fulfillment_exception_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception`(`fulfillment_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`rma`(`rma_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ADD CONSTRAINT `fk_fulfillment_merchant_integration_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_delivery_attempt_id` FOREIGN KEY (`delivery_attempt_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`delivery_attempt`(`delivery_attempt_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_reattempt_delivery_confirmation_id` FOREIGN KEY (`reattempt_delivery_confirmation_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation`(`delivery_confirmation_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ADD CONSTRAINT `fk_fulfillment_merchant_compliance_enrollment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ADD CONSTRAINT `fk_fulfillment_merchant_carrier_agreement_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ADD CONSTRAINT `fk_fulfillment_fulfillment_allocation_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation`(`fulfillment_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ADD CONSTRAINT `fk_fulfillment_fulfillment_allocation_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ADD CONSTRAINT `fk_fulfillment_fulfillment_program_enrollment_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ADD CONSTRAINT `fk_fulfillment_service_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ADD CONSTRAINT `fk_fulfillment_merchant_safety_certification_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`fulfillment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`fulfillment` SET TAGS ('dbx_domain' = 'fulfillment');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `cod_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cod Collection Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `rate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `driver_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Event Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `service_level_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `actual_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `cod_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Collected Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Latitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Longitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_route_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Route Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_value_regex' = 'dispatched|in_transit|out_for_delivery|delivered|failed|returned_to_depot');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `epod_photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Photo Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `epod_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Signature Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `planned_delivery_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time Window End');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `planned_delivery_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time Window Start');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `return_to_depot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return to Depot Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `sla_target_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ORACLE_TMS|SAP_TM|MANHATTAN_WMS|OTHER');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `ecommerce_seller_id` SET TAGS ('dbx_business_glossary_term' = 'E-Commerce Seller ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `allocated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Allocated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_service_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Provider Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cod_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Delivered Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `dispatched_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Dispatched Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Mode');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_value_regex' = 'warehouse|dropship|cross_dock|store_pickup|locker');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `integration_message_code` SET TAGS ('dbx_business_glossary_term' = 'Integration Message ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `merchant_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Merchant Order Reference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'd2d|ecommerce|b2b|b2c|return|exchange');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `original_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Order Reference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `packed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Packed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `picked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Picked Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `return_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|next_day|economy|premium');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_window_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Window End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_window_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Window Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Source Channel');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'edi|api|web_portal|mobile_app|manual');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_item_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Item Quantity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_package_count` SET TAGS ('dbx_business_glossary_term' = 'Total Package Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Validated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Value Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Order Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Picker Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `back_order_expected_date` SET TAGS ('dbx_business_glossary_term' = 'Back Order Expected Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `back_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Back Order Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `dimension_uom` SET TAGS ('dbx_business_glossary_term' = 'Dimension Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `dimension_uom` SET TAGS ('dbx_value_regex' = 'CM|IN|M|FT');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `gift_wrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `return_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'DAMAGED|WRONG_ITEM|NOT_NEEDED|DEFECTIVE|SIZE_ISSUE|LATE_DELIVERY');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = 'FRAGILE|HAZMAT|REFRIGERATED|HIGH_VALUE|OVERSIZED|NONE');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `unit_height` SET TAGS ('dbx_business_glossary_term' = 'Unit Height');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `unit_length` SET TAGS ('dbx_business_glossary_term' = 'Unit Length');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `unit_weight` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `unit_width` SET TAGS ('dbx_business_glossary_term' = 'Unit Width');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'KG|LB|G|OZ');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `billing_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `dg_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `carrier_service_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `carrier_service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `carrier_service_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `cod_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `cod_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `cod_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_latitude` SET TAGS ('dbx_business_glossary_term' = 'Destination Latitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_longitude` SET TAGS ('dbx_business_glossary_term' = 'Destination Longitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `dimensional_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (DIM Weight) in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^(1|2|3|4|5|6|7|8|9)(.d)?$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_value_regex' = '^UNd{4}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `manifest_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `origin_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `origin_facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `packaging_material` SET TAGS ('dbx_value_regex' = 'cardboard|plastic|paper|wood|metal|composite');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `parcel_status` SET TAGS ('dbx_business_glossary_term' = 'Parcel Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `sla_target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `sla_target_delivery_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Time Window End');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `sla_target_delivery_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Time Window Start');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Parcel Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` SET TAGS ('dbx_subdomain' = 'carrier_services');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `rate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Acknowledgement Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `contains_hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `contains_high_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains High Value Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `destination_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Zone Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `destination_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_value_regex' = 'pending|transmitted|acknowledged|failed|not_required');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `edi_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `manifest_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `manifest_type` SET TAGS ('dbx_business_glossary_term' = 'Manifest Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `manifest_type` SET TAGS ('dbx_value_regex' = 'outbound|inbound|transfer|return|cross_dock');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `planned_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|discrepancy|resolved');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,15}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `total_chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `total_cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `total_declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `total_parcel_count` SET TAGS ('dbx_business_glossary_term' = 'Total Parcel Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `total_volumetric_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Volumetric Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|air|rail|ocean|multimodal');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_attempt_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `cod_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cod Collection Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `digital_signature_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `access_code` SET TAGS ('dbx_business_glossary_term' = 'Access Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `access_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_date` SET TAGS ('dbx_business_glossary_term' = 'Attempt Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_latitude` SET TAGS ('dbx_business_glossary_term' = 'Attempt Location Latitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_longitude` SET TAGS ('dbx_business_glossary_term' = 'Attempt Location Longitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Attempt Outcome Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attempt Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `cod_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Collected Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `cod_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Payment Method');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `cod_payment_method` SET TAGS ('dbx_value_regex' = 'cash|card|mobile_payment|check');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `depot_location_code` SET TAGS ('dbx_business_glossary_term' = 'Depot Location Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `epod_photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Photo Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `epod_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `epod_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Signature Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `failure_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Description');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `next_action_instruction` SET TAGS ('dbx_business_glossary_term' = 'Next Action Instruction');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `next_action_instruction` SET TAGS ('dbx_value_regex' = 'reattempt|hold_at_facility|return_to_sender|redirect|contact_customer|escalate');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `reattempt_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Attempt Scheduled Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_relationship` SET TAGS ('dbx_business_glossary_term' = 'Recipient Relationship');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `recipient_relationship` SET TAGS ('dbx_value_regex' = 'consignee|family_member|neighbor|security|receptionist|other');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `sla_target_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `time_at_location_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time at Location in Minutes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `vehicle_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `weather_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` SET TAGS ('dbx_subdomain' = 'carrier_services');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `fulfillment_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Carrier Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `rate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Override User ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Assignment Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|dispatched|cancelled|failed');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_account_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Account Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp (ETA)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `estimated_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Pickup Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `estimated_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Time Hours');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `integration_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Integration Reference ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `label_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Generated Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `label_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Generated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `master_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Master Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `override_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Description');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `quoted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Quoted Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `quoted_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `quoted_rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quoted Rate Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `quoted_rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `selection_method` SET TAGS ('dbx_business_glossary_term' = 'Selection Method');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `selection_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|override');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `selection_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Selection Priority Score');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `selection_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Selection Rule Applied');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `sla_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliant Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `sla_target_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `tender_status` SET TAGS ('dbx_business_glossary_term' = 'Tender Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `tender_status` SET TAGS ('dbx_value_regex' = 'not_tendered|tendered|accepted|rejected');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `tender_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tender Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|road|rail|ocean|multimodal');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `dispatch_run_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Run Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Courier Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Courier Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `actual_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Actual Distance in Kilometers (KM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `actual_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Stop Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `cod_collection_count` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Collection Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `dispatch_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|scheduled|on_demand');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_value_regex' = 'pending|transmitted|acknowledged|failed');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `edi_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `epod_capture_count` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Capture Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `failed_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Delivery Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Manifest Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `manifest_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `manifest_reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|closed');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `origin_depot_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Depot Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `planned_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Planned Distance in Kilometers (KM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `planned_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `planned_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Stop Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Reconciliation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return to Depot Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `returned_parcel_count` SET TAGS ('dbx_business_glossary_term' = 'Returned Parcel Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Route Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Run Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Run Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Run Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'planned|dispatched|in_transit|completed|cancelled|returned');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `sla_target_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Time');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `total_cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `total_parcels_delivered` SET TAGS ('dbx_business_glossary_term' = 'Total Parcels Delivered');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `total_parcels_loaded` SET TAGS ('dbx_business_glossary_term' = 'Total Parcels Loaded');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `vehicle_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Utilization Percentage');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` SET TAGS ('dbx_subdomain' = 'carrier_services');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `ecommerce_seller_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Seller ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Return Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Return Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Return Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspected By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_received_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_received_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_received_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `actual_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `condition_assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `condition_assessment_code` SET TAGS ('dbx_value_regex' = 'sealed|opened|damaged|defective|missing_parts|unsellable');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `condition_assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instruction');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `external_rma_reference` SET TAGS ('dbx_business_glossary_term' = 'External Return Merchandise Authorization (RMA) Reference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `merchant_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Merchant Approved Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment|store_credit|gift_card|bank_transfer|check');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_trigger_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Trigger Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `refund_trigger_status` SET TAGS ('dbx_value_regex' = 'not_triggered|triggered|processing|completed|failed');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Request Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `restocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Restocked Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `restocked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restocked Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_label_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Label Generated Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_label_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Label Generated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_policy_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Compliant Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_service_level` SET TAGS ('dbx_business_glossary_term' = 'Return Service Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|express|economy');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Return Warehouse Location Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_warehouse_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `sla_target_processing_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Processing Days');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Task ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Packer Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `billable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Billable Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `dim_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (DIM Weight) in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `fragile_flag` SET TAGS ('dbx_business_glossary_term' = 'Fragile Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `gift_wrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `item_quantity_packed` SET TAGS ('dbx_business_glossary_term' = 'Item Quantity Packed');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Pack Duration in Seconds');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_method` SET TAGS ('dbx_business_glossary_term' = 'Pack Method');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_method` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|automated|robotic');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_number` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|on_hold|exception');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Zone Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packaging_material_sku` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Stock Keeping Unit (SKU)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packing_slip_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Included Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `parcel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Parcel Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `quality_check_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Passed Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `quality_check_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Performed Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `return_label_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Label Included Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `shipping_label_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `shipping_label_printed_flag` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Printed Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `void_fill_type` SET TAGS ('dbx_business_glossary_term' = 'Void Fill Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `void_fill_type` SET TAGS ('dbx_value_regex' = 'air_pillows|bubble_wrap|paper|foam|none|biodegradable');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `sla_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `contract_sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sla Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `delivery_attempt_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `document_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Document Exception Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Entitlement ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Detected Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_number` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_number` SET TAGS ('dbx_value_regex' = '^BRH-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Severity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|under-review|closed|escalated|disputed');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'on-time-delivery|on-time-in-full|pick-sla|pack-sla|dispatch-sla|delivery-sla');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Channel');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|portal|mobile-app|edi');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `customer_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `dispute_resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|tier-1|tier-2|tier-3|executive');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `promised_sla_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promised SLA Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `fulfillment_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Exception ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Dispute Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `delivery_attempt_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `document_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Document Exception Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `related_exception_fulfillment_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Related Exception ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `assigned_to_team_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `carrier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `compliance_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `compliance_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Channel');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_value_regex' = 'EMAIL|SMS|PHONE|PORTAL|API|EDI');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `detected_by_source` SET TAGS ('dbx_business_glossary_term' = 'Detected By Source');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `detection_location_code` SET TAGS ('dbx_business_glossary_term' = 'Detection Location Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_business_glossary_term' = 'Exception Category');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_value_regex' = 'OPERATIONAL|QUALITY|CARRIER|CUSTOMS|SYSTEM|CUSTOMER');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^EXC-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'OPEN|IN_PROGRESS|RESOLVED|ESCALATED|CLOSED|CANCELLED');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `raised_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Raised Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `recovery_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `resolution_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Taken');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `resolution_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Type Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` SET TAGS ('dbx_subdomain' = 'merchant_partners');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `aeo_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Certified Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `api_key_hash` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Key Hash');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `api_key_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `average_daily_order_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Order Volume');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Business State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `cod_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `customs_broker_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `default_service_level` SET TAGS ('dbx_business_glossary_term' = 'Default Service Level Agreement (SLA)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `default_service_level` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|next_day|economy');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `integration_channel` SET TAGS ('dbx_business_glossary_term' = 'Integration Channel');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `integration_channel` SET TAGS ('dbx_value_regex' = 'edi|api|portal|sftp|manual');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Legal Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_status` SET TAGS ('dbx_business_glossary_term' = 'Merchant Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|onboarding|terminated');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_tier` SET TAGS ('dbx_business_glossary_term' = 'Merchant Tier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_tier` SET TAGS ('dbx_value_regex' = 'enterprise|sme|marketplace|startup');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Merchant Onboarding Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `peak_season_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Volume Multiplier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'E-Commerce Platform Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `returns_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Returns Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `returns_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Returns Policy Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `returns_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `sla_on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) On-Time Delivery Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `sla_order_accuracy_target_pct` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Order Accuracy Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Merchant Termination Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'contract_expiry|mutual_agreement|breach|non_payment|business_closure|migration');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Trading Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` SET TAGS ('dbx_subdomain' = 'merchant_partners');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint URL');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `authentication_credential` SET TAGS ('dbx_business_glossary_term' = 'Authentication Credential');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `authentication_credential` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `authentication_credential` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'OAUTH2|API_KEY|BASIC_AUTH|CERTIFICATE|TOKEN|NONE');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `average_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Milliseconds');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `batch_processing_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `batch_size_limit` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Limit');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `compression_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `cumulative_error_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Error Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `data_encryption_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Encryption Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Qualifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `error_count_24h` SET TAGS ('dbx_business_glossary_term' = 'Error Count 24 Hours');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `integration_name` SET TAGS ('dbx_business_glossary_term' = 'Integration Channel Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|SUSPENDED|DEGRADED|INACTIVE|TESTING|PENDING_ACTIVATION');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `integration_type` SET TAGS ('dbx_value_regex' = 'EDI|REST_API|SFTP|WEBHOOK|SOAP_API|FLAT_FILE');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `last_error_code` SET TAGS ('dbx_business_glossary_term' = 'Last Error Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `last_error_message` SET TAGS ('dbx_business_glossary_term' = 'Last Error Message');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `last_error_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Error Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `last_successful_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Sync Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `last_sync_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sync Attempt Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `message_format` SET TAGS ('dbx_business_glossary_term' = 'Message Format');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `message_format` SET TAGS ('dbx_value_regex' = 'JSON|XML|CSV|FIXED_WIDTH|EDI_X12|EDIFACT');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `message_format_version` SET TAGS ('dbx_business_glossary_term' = 'Message Format Version');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Integration Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `polling_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Polling Frequency Minutes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `rate_limit_requests_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Requests Per Minute');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'IMMEDIATE|EXPONENTIAL_BACKOFF|FIXED_INTERVAL|NO_RETRY');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `sftp_directory_path` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Directory Path');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `sftp_host` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Host');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `sftp_host` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `sftp_port` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Port');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `success_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Success Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `supported_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `timeout_threshold_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout Threshold Seconds');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `webhook_callback_url` SET TAGS ('dbx_business_glossary_term' = 'Webhook Callback URL');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `webhook_callback_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `consignee_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `access_code` SET TAGS ('dbx_business_glossary_term' = 'Access Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `access_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|locker|pudo|cfs|icd');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|corrected|failed');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `alternate_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Alternate Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `alternate_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `alternate_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `blacklist_flag` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `blacklist_reason` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `business_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Business Hours End Time');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `business_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `business_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Business Hours Start Time');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `business_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `cod_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `cod_payment_method_preference` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Payment Method Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `cod_payment_method_preference` SET TAGS ('dbx_value_regex' = 'cash|card|mobile_payment|bank_transfer');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Full Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `consignee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `consignee_type` SET TAGS ('dbx_business_glossary_term' = 'Consignee Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `consignee_type` SET TAGS ('dbx_value_regex' = 'individual|business|government|ngo');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `customs_id_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Identification Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `customs_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `customs_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `delivery_preference_leave_at_door` SET TAGS ('dbx_business_glossary_term' = 'Leave at Door Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `delivery_preference_neighbor_delivery` SET TAGS ('dbx_business_glossary_term' = 'Neighbor Delivery Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `delivery_preference_safe_place` SET TAGS ('dbx_business_glossary_term' = 'Safe Place Delivery Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `delivery_preference_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `delivery_time_window_preference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time Window Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `delivery_time_window_preference` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|business_hours|anytime');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `failed_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Delivery Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `failed_delivery_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Failed Delivery History Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|street|postal_code|city|region');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geocode Latitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geocode Longitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `notification_preference_email` SET TAGS ('dbx_business_glossary_term' = 'Email Notification Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `notification_preference_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `notification_preference_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `notification_preference_push` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `notification_preference_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Notification Preference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `residential_commercial_indicator` SET TAGS ('dbx_business_glossary_term' = 'Residential or Commercial Indicator');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `residential_commercial_indicator` SET TAGS ('dbx_value_regex' = 'residential|commercial|mixed_use');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Mro Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `annual_throughput_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Annual Throughput Capacity (Units)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|robotic');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `customs_bonded_warehouse_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Bonded Warehouse Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'owned|3pl|4pl|cross_dock|dark_store|micro_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `ftz_designation` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Designation');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `labor_workforce_size` SET TAGS ('dbx_business_glossary_term' = 'Labor Workforce Size (Full-Time Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `last_mile_zone_coverage` SET TAGS ('dbx_business_glossary_term' = 'Last-Mile Zone Coverage');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `operating_days_per_week` SET TAGS ('dbx_business_glossary_term' = 'Operating Days Per Week');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|maintenance');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Pallet Positions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `peak_daily_order_capacity` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Order Capacity');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `security_certification` SET TAGS ('dbx_business_glossary_term' = 'Security Certification');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `storage_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `supported_service_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Service Types');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `total_floor_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Total Floor Area (Square Meters)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `wms_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Instance ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `wms_system_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Delivery Zone ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `lane_rate_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Rate Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `average_delivery_attempts` SET TAGS ('dbx_business_glossary_term' = 'Average Delivery Attempts');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `carrier_coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Coverage Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `carrier_coverage_level` SET TAGS ('dbx_value_regex' = 'full|partial|limited|none');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `cod_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Service Available Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `delivery_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Cutoff Time');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `epod_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `express_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Express Transit Days');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `fuel_surcharge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `holiday_delivery_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Delivery Available Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `max_parcel_dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Parcel Dimensions in Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `max_parcel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Parcel Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `next_day_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Next Day Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Zone Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range End');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range Start');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `primary_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `remote_area_surcharge_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Area Surcharge Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `residential_surcharge_flag` SET TAGS ('dbx_business_glossary_term' = 'Residential Surcharge Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `restricted_goods_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Goods Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `same_day_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Same Day Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `secondary_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Serviceable Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `standard_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Transit Days');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `time_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `weekend_delivery_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Delivery Available Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Zone Centroid Latitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Zone Centroid Longitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Zone Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|remote|island|restricted');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Template ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `actual_parcels_shipped` SET TAGS ('dbx_business_glossary_term' = 'Actual Parcels Shipped');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `assigned_labor_pool_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Labor Pool ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `assigned_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Zone Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Cancellation Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `carrier_service_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wave Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `cutoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wave Cutoff Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Wave Efficiency Percent');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `manifest_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Generated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Wave Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `pack_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `pick_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `pick_method` SET TAGS ('dbx_value_regex' = 'discrete|batch|cluster|zone|wave');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wave Planned Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wave Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `short_pick_count` SET TAGS ('dbx_business_glossary_term' = 'Short Pick Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `target_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Target Ship Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_order_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Order Lines');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Orders');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_parcels_expected` SET TAGS ('dbx_business_glossary_term' = 'Total Parcels Expected');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_business_glossary_term' = 'Wave Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_value_regex' = 'planned|released|in-progress|completed|cancelled|on-hold');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_business_glossary_term' = 'Wave Type');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_value_regex' = 'single-order|multi-order|batch|zone|replenishment|cross-dock');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `charge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Event Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent Employee Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_attempt_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `digital_signature_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `reattempt_delivery_confirmation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Collected Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Collection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Payment Method');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_payment_method` SET TAGS ('dbx_value_regex' = 'cash|card|mobile_payment|bank_transfer|check|other');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `cod_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Receipt Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending_verification|disputed|voided|amended');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Latitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Longitude');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `epod_photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Photo Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `epod_photo_image_url` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Photo Image URL');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `epod_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Signature Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `epod_signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Signature Image URL');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `recipient_relationship` SET TAGS ('dbx_business_glossary_term' = 'Recipient Relationship');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `sla_target_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Parcel Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ALTER COLUMN `vehicle_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` SET TAGS ('dbx_subdomain' = 'merchant_partners');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` SET TAGS ('dbx_association_edges' = 'fulfillment.merchant,customs.compliance_program');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `merchant_compliance_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Compliance Enrollment Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Compliance Enrollment - Compliance Program Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Compliance Enrollment - Merchant Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `benefits_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Active Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `merchant_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Merchant Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` SET TAGS ('dbx_subdomain' = 'merchant_partners');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` SET TAGS ('dbx_association_edges' = 'fulfillment.merchant,network.carrier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `merchant_carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'merchant_carrier_agreement Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Carrier Agreement - Carrier Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Carrier Agreement - Merchant Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Merchant Carrier Account Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `merchant_carrier_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Reference');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ALTER COLUMN `service_levels_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service Levels');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` SET TAGS ('dbx_association_edges' = 'fulfillment.center,contract.agreement');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `fulfillment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'fulfillment_allocation Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Agreement Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Fulfillment Center Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `capacity_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` SET TAGS ('dbx_association_edges' = 'fulfillment.center,safety.safety_program');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `fulfillment_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'fulfillment_program_enrollment Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Fulfillment Center Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Coordinator Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Safety Program Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `corrective_actions_pending` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Pending');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` SET TAGS ('dbx_subdomain' = 'carrier_services');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` SET TAGS ('dbx_association_edges' = 'fulfillment.center,network.carrier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Service - Carrier Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Service - Fulfillment Center Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `capacity_allocation` SET TAGS ('dbx_business_glossary_term' = 'Daily Capacity Allocation');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `days` SET TAGS ('dbx_business_glossary_term' = 'Service Days');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `pickup_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Pickup Cutoff Time');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Carrier Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` SET TAGS ('dbx_subdomain' = 'merchant_partners');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` SET TAGS ('dbx_association_edges' = 'fulfillment.merchant,safety.safety_training');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `merchant_safety_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Safety Certification ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Safety Certification - Merchant Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `safety_training_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Safety Certification - Safety Training Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `cost_allocation` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Allocation');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `next_recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recertification Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `score_achieved` SET TAGS ('dbx_business_glossary_term' = 'Score Achieved');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `training_delivery_mode_used` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Mode Used');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
