-- Schema for Domain: fulfillment | Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`fulfillment` COMMENT 'Manages e-commerce and D2D fulfillment execution including order orchestration, pick-pack-ship workflows, last-mile dispatch, carrier selection for parcel delivery, returns processing (RMA), advanced shipping notices (ASN), COD collections, and SLA breach tracking. Owns fulfillment orders, parcel manifests, delivery attempts, ePOD capture, and omnichannel integration via EDI and API channels with merchant e-commerce platforms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` (
    `last_mile_dispatch_id` BIGINT COMMENT 'Unique identifier for the last-mile dispatch record. Primary key for the last_mile_dispatch product.',
    `consignee_id` BIGINT COMMENT 'Foreign key linking to fulfillment.consignee. Business justification: Last-mile dispatch delivers to consignees (end recipients). The recipient_name and recipient_contact_phone should be normalized to consignee_id FK referencing consignee.consignee_id. This enables leve',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment being dispatched for final delivery. Links to the shipment or parcel being delivered.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Last-mile delivery agent assignment requires driver profile lookup for license validation, HOS compliance verification, performance tracking, and route authorization. Existing delivery_agent_employee_',
    `dispatch_run_id` BIGINT COMMENT 'Foreign key linking to fulfillment.dispatch_run. Business justification: A dispatch_run is the operational route/courier trip that groups multiple last-mile dispatches. last_mile_dispatch assigns a single consignment to a driver, while dispatch_run represents the full sche',
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_zone. Business justification: Last-mile dispatch assignments are zone-based. Adding delivery_zone_id FK enables proper zone-based routing, SLA tracking, and delivery agent assignment. The delivery address fields remain (execution-',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that this dispatch is executing. Links to the e-commerce or D2D order.',
    `hold_id` BIGINT COMMENT 'Foreign key linking to customs.customs_hold. Business justification: Last-mile dispatch is blocked when customs holds exist. Enables delivery agents to understand delay root cause, provide accurate customer updates, and reschedule delivery attempts based on expected cu',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Dispatches originate from specific network nodes (depots, hubs). Enables dispatch origin tracking, node-level performance analysis, and depot capacity planning. Standard in last-mile operations manage',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.plan. Business justification: Last-mile dispatches execute the final delivery leg of multi-leg route plans. Linking enables end-to-end plan execution tracking, actual-vs-planned variance analysis, and closed-loop feedback for rout',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Last-mile dispatches require rate card linkage for delivery zone pricing application, COD fee calculation, accessorial charge determination, and driver settlement in final-mile delivery operations.',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Last-mile dispatch executes a specific shipment leg. Operations teams link dispatch events to shipment legs for SLA breach attribution, delay root-cause analysis, and carrier performance reporting. A ',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Last-mile dispatch operations assign specific fleet vehicles to delivery routes. Dispatch planning, vehicle utilization tracking, and operational reporting require authoritative link to fleet.transpor',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Delivery exception notifications, POD confirmation requests, and SLA breach alerts during order execution require a named customer contact on the fulfillment order. Logistics operations teams universa',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.contract_rate. Business justification: Orders under contract agreements reference specific contract rates for pricing execution, volume commitment tracking, margin analysis, and contracted service-level enforcement during order fulfillment',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Fulfillment orders are processed at specific fulfillment centers. The warehouse_location_code STRING should be normalized to FK referencing center.fulfillment_center_id. This enables proper order-to-f',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Fulfillment orders require lane assignment for transportation planning from fulfillment center to delivery destination. Enables order-to-lane routing for freight booking, carrier selection, and transi',
    `customer_account_id` BIGINT COMMENT 'Reference to the merchant or customer account that originated this fulfillment order.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to fulfillment.merchant. Business justification: Fulfillment orders are placed by merchants (e-commerce sellers). Adding merchant_id FK is critical for linking orders to the merchant partner. The merchant_order_reference remains as it captures the m',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Fulfillment orders for internal logistics supplies (packaging materials, labels, consumables) are procured via purchase orders. Enables supply chain cost allocation and inventory replenishment trackin',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Fulfillment orders require rate card reference for service-level pricing validation, billing accuracy verification, and margin calculation during order execution and invoicing processes.',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Orders requiring multi-leg transportation are assigned to service corridors for end-to-end routing. Enables corridor-based order routing for complex shipments, cross-border movements, and multi-modal ',
    `shipper_profile_id` BIGINT COMMENT 'Foreign key linking to customer.shipper_profile. Business justification: Shipper profile governs hazmat authorization, temperature control requirements, preferred carrier, and default incoterms applied at order creation. Fulfillment systems resolve shipper-specific handlin',
    `sla_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_sla_commitment. Business justification: Orders must track which specific SLA commitment applies (next-day, 2-day, express) for compliance measurement, breach detection, and penalty/incentive calculation. Essential for SLA performance report',
    `sla_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_entitlement. Business justification: fulfillment_order carries sla_breach_flag and sla_window timestamps whose targets derive from the customers contracted SLA entitlement. Without this FK, the fulfillment system cannot resolve which tr',
    `spot_quote_id` BIGINT COMMENT 'Foreign key linking to pricing.spot_quote. Business justification: E-commerce fulfillment orders originate from spot quotes for ad-hoc shipping. Business process: quote-to-order conversion tracking for sales pipeline analysis and quote acceptance rate reporting.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Orders claiming preferential tariff treatment under trade agreements require agreement-specific documentation and origin criteria. Enables preferential duty calculation, certificate of origin generati',
    `transit_time_standard_id` BIGINT COMMENT 'Foreign key linking to route.transit_time_standard. Business justification: Fulfillment orders must validate promised delivery dates against published carrier transit time standards for the origin-destination pair and service level. Critical for SLA compliance verification an',
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
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: In LCL and express consolidation operations, individual parcels are grouped into a consolidation for transport. Parcel must reference its consolidation for deconsolidation planning, freight charge all',
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_zone. Business justification: Parcels are routed to specific delivery zones based on destination address. Adding delivery_zone_id FK enables zone-based routing, carrier selection, and SLA management. Destination address fields rem',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order that this parcel is part of. Links parcel to the order orchestration workflow.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Individual parcels are routed via specific lanes for carrier assignment and transit time calculation. Critical for parcel routing optimization, carrier selection algorithms, and delivery promise calcu',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Tracks packaging material supplier for each parcel. Critical for quality control, cost analysis, and supplier performance evaluation in logistics operations. Enables root cause analysis when packaging',
    `parcel_manifest_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel_manifest. Business justification: Parcels are grouped into carrier manifests for scheduled dispatch. Adding parcel_manifest_id FK is critical for tracking which manifest a parcel belongs to, enabling manifest reconciliation, carrier h',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Parcels need rate card linkage for chargeable weight calculation using dim weight rules, service-level pricing application, and carrier billing reconciliation in multi-carrier fulfillment operations.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.rate_schedule. Business justification: Parcels are rated against specific carrier rate schedules from agreements. Billing audit, rate verification, and dispute resolution require direct schedule reference to validate applied rates match co',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Parcels are rated against published tariffs for carrier billing reconciliation. Business process: tariff-based rating validation ensures billed rates match published tariff schedules for audit complia',
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
    `broker_assignment_id` BIGINT COMMENT 'Foreign key linking to customs.broker_assignment. Business justification: Manifests requiring customs clearance are assigned to customs brokers for declaration filing. Enables manifest-level broker performance tracking, filing status monitoring, clearance timeline managemen',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Manifests are dispatched under specific carrier agreements defining capacity, rates, and service levels. Required for rate application, capacity validation, performance tracking, and invoice reconcili',
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: Manifests are reconciled against negotiated carrier buy rates for cost accounting. Business process: carrier invoice validation compares manifested shipments to contracted buy rates for payment accura',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier or last-mile delivery partner assigned to this manifest.',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: Parcel manifests drive carrier invoice generation and payables. Real business process: carrier invoice reconciliation, manifest-to-invoice matching, and freight cost accrual requiring manifest-to-paya',
    `carrier_schedule_id` BIGINT COMMENT 'Foreign key linking to route.carrier_schedule. Business justification: Manifests must reference specific carrier pickup schedules to enforce cutoff times, validate departure windows, and coordinate handover timing. Essential for carrier tender management and on-time disp',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Manifests are tendered under specific carrier service contracts (express/standard/economy). Business process: service-level capacity planning, rate application, transit time SLA enforcement, manifest-',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Manifests are often consolidated by 3PLs for linehaul before final carrier delivery. Tracking which 3PL handled manifest sortation/consolidation is required for cost allocation, performance tracking, ',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: International manifests require customs agent assignment for AES filing, ISF submissions, and entry summaries at the manifest level. Tracking which agent handles each manifests customs clearance is m',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Consolidated manifests often share single customs declaration for multiple parcels in international shipments. Enables manifest-level customs clearance reporting, audit trails, and regulatory complian',
    `freight_audit_id` BIGINT COMMENT 'Foreign key linking to billing.freight_audit. Business justification: Manifests are primary source documents for carrier invoice audit. Direct link required for freight audit workflow, rate validation, weight/dimension verification, and carrier payable reconciliation in',
    `center_id` BIGINT COMMENT 'Identifier of the warehouse, fulfillment center, or distribution hub from which this manifest originates.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Manifests consolidate parcels for specific lanes to optimize carrier capacity utilization. Enables manifest planning, lane allocation, and carrier tender processes. Standard practice in consolidation ',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Manifest handoff and carrier tender require driver identification with license validation, HOS compliance verification, and certification checks (hazmat, dangerous goods). Existing driver_employee_id ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Manifests are created at origin nodes for node-to-node movement tracking. Enables origin node performance analysis, capacity planning, and network flow optimization. Core to manifest management system',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Manifests aggregate parcels for carrier handoff and require rate card reference for consolidated billing validation, carrier settlement reconciliation, and service-level compliance verification across',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Manifests for long-haul or multi-modal shipments are assigned to service corridors. Enables corridor-based manifest planning, capacity allocation, and multi-leg routing for consolidated shipments in l',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Parcel manifest consolidation for carrier handoff requires tracking which fleet vehicle transported the manifest from fulfillment center to carrier hub. Fleet utilization reporting, cost allocation, a',
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
    `consignment_id` BIGINT COMMENT 'Reference to the parent consignment being delivered. Links this attempt to the shipment package.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Each delivery attempt is performed by a driver whose profile (license validity, certifications, performance rating, HOS status) must be validated for operational compliance and audit trail. Existing d',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the e-commerce fulfillment order driving this delivery. Links attempt to the original order.',
    `last_mile_dispatch_id` BIGINT COMMENT 'Reference to the last-mile dispatch run that included this delivery attempt. Links to the route execution.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: A delivery attempt is fundamentally the act of delivering a specific physical parcel to the consignee. delivery_attempt already links to fulfillment_order and last_mile_dispatch, but has no direct FK ',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Delivery attempts occur within specific delivery zones for performance tracking. Enables zone-level delivery performance analysis, failure rate tracking, and zone-based service improvement initiatives',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: delivery_attempt stores vehicle_registration_number as a denormalized string. A FK to fleet.transport_asset enables per-vehicle delivery performance reporting, incident correlation with fleet records,',
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
    `weather_condition_code` STRING COMMENT 'Weather condition at the time of delivery attempt. Used to analyze weather impact on delivery success rates and SLA performance. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|storm|extreme_heat|extreme_cold — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_delivery_attempt PRIMARY KEY(`delivery_attempt_id`)
) COMMENT 'Records each physical attempt to deliver a parcel to the consignee address. Captures attempt sequence number, attempt date-time, delivery agent ID, GPS coordinates at attempt, outcome code (delivered, failed, refused, no-access, redirected), failure reason, next-action instruction (re-attempt, hold at facility, return to sender), and ePOD reference. Central to last-mile SLA tracking and OTD/OTIF KPI computation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` (
    `fulfillment_carrier_assignment_id` BIGINT COMMENT 'Unique identifier for the carrier assignment record. Primary key for this entity.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Carrier selection must reference specific agreement for automated rate lookup and contract compliance validation. Essential for TMS rate shopping, capacity allocation, and ensuring assignments comply ',
    `carrier_id` BIGINT COMMENT 'Reference to the selected carrier organization responsible for transporting this fulfillment order or parcel. Links to the carrier master data.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Carrier assignments select specific services (not just carriers). Business process: rate shopping, service level selection, transit time commitment, carrier service performance tracking. Removes denor',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment or parcel shipment unit for which the carrier is assigned. May be null if assignment is at order level rather than parcel level.',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.contract_rate. Business justification: Carrier assignments under contract agreements directly reference specific contract rates for pricing execution, volume commitment tracking, and contracted service-level enforcement during carrier sele',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order for which the carrier is being assigned. Links this assignment to the parent order being fulfilled.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Carrier assignment decisions require lane-specific routing rules, capacity allocations, and contracted service levels. The assignment engine evaluates carrier performance and availability per lane to ',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: fulfillment_carrier_assignment records carrier selection for a fulfillment order OR a specific parcel. The product description explicitly states for a fulfillment order or parcel. Currently it has f',
    `parcel_manifest_id` BIGINT COMMENT 'Reference to the parcel manifest or carrier manifest document that includes this carrier assignment, used for batch handover and carrier reconciliation. May be null if not yet manifested.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Carrier assignments validate quoted rates against applicable rate cards during carrier selection optimization, ensuring pricing compliance and enabling margin analysis for multi-carrier routing decisi',
    `sla_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_entitlement. Business justification: Carrier selection must satisfy the customers contracted SLA entitlement (transit time guarantee, delivery window). fulfillment_carrier_assignment carries sla_compliant_flag and sla_target_delivery_ti',
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
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: Dispatch runs require carrier buy rate linkage for cost allocation per route, profitability analysis, carrier settlement reconciliation, and margin tracking in last-mile delivery operations.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Dispatch runs are executed by carriers (or internal fleet). Business process: carrier performance by run, carrier payment reconciliation, carrier capacity utilization tracking. Removes denormalized SC',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Courier assignment for last-mile dispatch runs requires driver profile validation including license type, HOS compliance status, performance rating, and certification eligibility (hazmat, temperature-',
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_zone. Business justification: Dispatch runs operate within specific delivery zones. The service_area_code STRING should be normalized to FK referencing delivery_zone.fulfillment_delivery_zone_id. This enables proper zone-based rou',
    `depot_id` BIGINT COMMENT 'Foreign key linking to fleet.depot. Business justification: Dispatch runs originate from a fleet depot; origin_depot_code is a denormalized string on dispatch_run. A proper FK to fleet.depot enables depot-level dispatch volume reporting, capacity planning, and',
    `parcel_manifest_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel_manifest. Business justification: A dispatch_run (operational driver route) is associated with a parcel_manifest (carrier manifest grouping parcels for a scheduled dispatch). The parcel_manifest defines what parcels are loaded onto th',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Dispatch run planning assigns specific fleet vehicles to courier routes. Fleet utilization analysis, vehicle maintenance scheduling coordination, and operational cost allocation require authoritative ',
    `trip_id` BIGINT COMMENT 'Foreign key linking to fleet.trip. Business justification: A last-mile dispatch run IS a fleet trip. Linking dispatch_run to fleet.trip enables reconciliation of delivery performance against fleet actuals (fuel consumed, distance, emissions, cost) — essential',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: RMA authorization, return label delivery, refund notification, and return policy compliance communication all require a named customer contact. Returns management in logistics mandates tracking the co',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this return. Links to customer master data for account management and history.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the originating fulfillment order that this return is associated with. Links the RMA back to the original shipment.',
    `penalty_clause_id` BIGINT COMMENT 'Foreign key linking to contract.penalty_clause. Business justification: Return violations (late processing, non-compliance with return SLA, restocking delays) trigger penalty clauses in merchant agreements. RMA must reference applicable penalty terms for automated enforce',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Returns are shipped via carriers. Business process: reverse logistics carrier selection, return carrier performance tracking, return shipping cost allocation. Role-prefixed to distinguish from potenti',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: An RMA generates a return consignment for physical goods movement back to the warehouse. Linking rma to the return consignment enables return shipment tracking, customs documentation for returned good',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: International returns require customs declarations for re-import processing. Supports reverse logistics customs clearance tracking, duty drawback claims, and RMA processing timelines that depend on cu',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Returns of imported goods require HS classification for duty drawback claims, re-export declarations, and customs valuation. Enables automated return customs documentation generation, duty recovery pr',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: An RMA (Return Merchandise Authorization) involves the physical return of goods in a parcel. The rma table has return_tracking_number (a string) but no FK to the parcel entity that represents the retu',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: RMAs require rate card reference for return shipping cost calculation, customer refund amount determination, restocking fee application, and reverse logistics billing in returns management operations.',
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
    `pick_task_id` BIGINT COMMENT 'Reference to the pick task that supplied items for this pack task.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` (
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant partner. Primary key for the merchant entity within the fulfillment domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Merchants operate under master fulfillment agreements defining rate schedules, service scope, billing terms, and SLA commitments. Fundamental relationship for pricing, service entitlements, and mercha',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Links fulfillment merchant entity to customer domains account master. Core business need: merchant onboarding validation, billing account reconciliation, credit limit enforcement, SLA entitlement loo',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Merchants shipping internationally require assigned freight forwarding/customs agents for cross-border compliance, AES filing, ISF submissions, and entry documentation. Tracking the merchants primary',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Merchants negotiate specific payment terms (net days, early payment discounts). Direct link required for credit management, invoice generation with correct terms, and merchant onboarding workflow in 3',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: merchant.primary_contact_email/name/phone are denormalized representations of a customer.contact record. Logistics merchant account management requires a proper FK to the CRM contact for escalation ro',
    `sla_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_entitlement. Business justification: merchant.sla_on_time_delivery_target_pct and sla_order_accuracy_target_pct are denormalized from the contracted SLA entitlement. In logistics, merchant SLA commitments are governed by the entitlement ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Merchants may also be suppliers in reverse logistics scenarios (returns, exchanges, vendor-managed inventory). Enables consolidated vendor management and financial reconciliation across forward and re',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Merchants often use 3PL providers for fulfillment operations. Business process: 3PL performance tracking per merchant, cost allocation, SLA management, merchant-3PL contract management.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Merchants acting as exporters/importers are registered customs trade parties. Links merchant accounts to their customs identifiers (EORI, importer number, AEO status) for compliance verification, cust',
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
    `returns_enabled_flag` BOOLEAN COMMENT 'Indicates whether the merchant has returns processing (RMA - Return Merchandise Authorization) enabled through Transport Shipping fulfillment services.',
    `returns_policy_code` STRING COMMENT 'Reference code to the merchants returns policy configuration defining return windows, conditions, and processing rules.. Valid values are `^[A-Z0-9]{4,10}$`',
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
    `fulfillment_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_delivery_zone. Business justification: A consignees address maps to a specific fulfillment delivery zone, which drives carrier selection, SLA windows, COD availability, and surcharge applicability. Storing fulfillment_delivery_zone_id on ',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Consignees receiving international shipments are registered trade parties for customs purposes. Enables denied party screening, AEO certification verification, importer-of-record validation, and custo',
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
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Fulfillment centers in FTZs or bonded warehouses have assigned customs agents for facility-level clearance operations, entry filing, and compliance audits. Tracking the facilitys customs agent is req',
    `facility_id` BIGINT COMMENT 'FK to warehouse.facility.facility_id — MUST-HAVE: Links fulfillment centers to the warehouse facility master. Required for inventory visibility, capacity planning, and operational reporting across fulfillment and warehouse domains.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Fulfillment centers procure MRO supplies, equipment, and consumables from suppliers. Tracks primary supplier relationship for facility operations, enabling spend analysis and supplier performance mana',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Fulfillment centers are network nodes in the routing topology. Enables facility integration into network design, routing optimization, and capacity planning. Standard practice in integrated logistics ',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Fulfillment centers may be operated by 3PL providers. Business process: 3PL facility management, operational oversight, cost center allocation. Role-prefixed as centers may have multiple 3PL relations',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Fulfillment centers operating as importers/exporters, bonded warehouses, or FTZ operators are registered trade parties. Enables facility-level customs compliance tracking, AEO certification management',
    `depot_id` BIGINT COMMENT 'Foreign key linking to fleet.depot. Business justification: Fulfillment centers are operationally served by a fleet depot for vehicle staging, dispatch, and returns. This FK enables fleet capacity planning relative to fulfillment throughput and is a standard o',
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
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Delivery zones are served by specific fulfillment centers (hubs). The hub_location_code STRING should be normalized to FK referencing center.fulfillment_center_id. This enables proper zone-to-hub assi',
    `lane_rate_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.lane_rate_zone. Business justification: Delivery zones map to pricing rate zones for zone-based tariff application. Business process: zone-based rating applies distance/geography-based pricing to delivery zones for accurate freight costing.',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Fulfillment delivery zones map to route delivery zones for service coverage alignment and SLA management. Enables zone harmonization across fulfillment and routing systems, critical for multi-system l',
    `service_scope_id` BIGINT COMMENT 'Foreign key linking to contract.service_scope. Business justification: Delivery zones must map to contracted service scopes to determine serviceability, rate applicability, SLA targets, and service restrictions per agreement terms. Critical for order acceptance decisions',
    `depot_id` BIGINT COMMENT 'Foreign key linking to fleet.depot. Business justification: Delivery zones are covered by vehicles dispatched from a specific fleet depot. This FK drives depot-to-zone routing assignments, fleet capacity planning per zone, and SLA commitment analysis — a funda',
    `tax_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.tax_schedule. Business justification: Delivery zones determine applicable tax rates for cross-border and domestic shipments. Direct link required for accurate tax calculation, customs duty assessment, and regulatory compliance in internat',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Primary key uniquely identifying each merchant-center allocation record',
    `center_id` BIGINT COMMENT 'Foreign key linking to the fulfillment center facility that serves this merchant under this allocation',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to the merchant partner whose orders and inventory are allocated to this fulfillment center',
    `allocation_status` STRING COMMENT 'Current operational status of this allocation: active (in use), inactive (ended), pending (future-dated), suspended (temporarily disabled). Drives operational routing logic.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first created in the system',
    `effective_end_date` DATE COMMENT 'Date when this merchant-center allocation was or will be terminated. Null for currently active allocations. Required for audit trail and billing reconciliation.',
    `effective_start_date` DATE COMMENT 'Date when this merchant-center allocation became or will become operationally active. Required for historical tracking and future-dated allocation changes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was most recently modified',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage of the merchants total order volume or inventory allocated to this specific fulfillment center. Used for load balancing and capacity planning across multi-center merchants.',
    `priority_rank` STRING COMMENT 'Priority ranking of this fulfillment center for the merchant (1 = primary, 2 = secondary, etc.). Determines fulfillment center selection logic when multiple centers serve overlapping zones.',
    `service_types_enabled` STRING COMMENT 'Comma-separated list of fulfillment service types enabled for this merchant at this center (e.g., standard_fulfillment,express_fulfillment,COD,returns_processing). Service type availability varies by merchant-center combination based on contract terms and center capabilities.',
    `storage_allocation_cbm` DECIMAL(18,2) COMMENT 'Cubic meters of storage capacity allocated to this merchant at this fulfillment center. Used for capacity planning, billing, and inventory placement decisions.',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'This association product represents the operational assignment between a merchant and a fulfillment center. It captures the formal allocation of merchant inventory and order fulfillment capacity across Transport Shippings fulfillment network. Each record links one merchant to one center with allocation percentages, priority rankings, service type enablement, and storage capacity assignments that exist only in the context of this specific merchant-center pairing.. Existence Justification: In Transport Shippings fulfillment operations, merchants are formally allocated to one or more fulfillment centers based on geographic coverage, capacity, and service requirements. This is an actively managed operational relationship where fulfillment planners assign merchants to centers with specific allocation percentages (for load balancing), priority rankings (for routing logic), storage capacity allocations, and service type enablement. The business tracks both current and historical allocations for billing reconciliation, SLA audit, and capacity planning purposes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_dispatch_run_id` FOREIGN KEY (`dispatch_run_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`dispatch_run`(`dispatch_run_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_parcel_manifest_id` FOREIGN KEY (`parcel_manifest_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel_manifest`(`parcel_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_parcel_manifest_id` FOREIGN KEY (`parcel_manifest_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel_manifest`(`parcel_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_parcel_manifest_id` FOREIGN KEY (`parcel_manifest_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel_manifest`(`parcel_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ADD CONSTRAINT `fk_fulfillment_merchant_integration_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ADD CONSTRAINT `fk_fulfillment_consignee_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ADD CONSTRAINT `fk_fulfillment_allocation_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ADD CONSTRAINT `fk_fulfillment_allocation_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`fulfillment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`fulfillment` SET TAGS ('dbx_domain' = 'fulfillment');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `dispatch_run_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Run Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sla Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Entitlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `transit_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Standard Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `broker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `freight_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ALTER COLUMN `weather_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `fulfillment_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Carrier Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Entitlement Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Courier Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Depot Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `penalty_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Return Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Return Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Return Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Return Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Return Rate Card Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task ID');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` SET TAGS ('dbx_subdomain' = 'merchant_integration');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Entitlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `returns_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Returns Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `returns_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Returns Policy Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `returns_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Merchant Termination Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'contract_expiry|mutual_agreement|breach|non_payment|business_closure|migration');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Trading Name');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` SET TAGS ('dbx_subdomain' = 'merchant_integration');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration ID');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account ID');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `fulfillment_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` SET TAGS ('dbx_subdomain' = 'merchant_integration');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Mro Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Servicing Depot Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `lane_rate_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Rate Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `service_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Servicing Depot Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ALTER COLUMN `tax_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` SET TAGS ('dbx_subdomain' = 'merchant_integration');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` SET TAGS ('dbx_association_edges' = 'fulfillment.merchant,fulfillment.center');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Center Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Merchant Id');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `service_types_enabled` SET TAGS ('dbx_business_glossary_term' = 'Service Types Enabled');
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`allocation` ALTER COLUMN `storage_allocation_cbm` SET TAGS ('dbx_business_glossary_term' = 'Storage Allocation (CBM)');
