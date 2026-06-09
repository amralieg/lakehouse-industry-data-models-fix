-- Schema for Domain: logistics | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`logistics` COMMENT 'Owns transportation planning and carrier execution across the supply chain. Manages last-mile delivery, carrier selection, route optimization, FTL/LTL shipment planning, shipment tracking, delivery confirmation, EDI carrier integrations, cross-border WTO-compliant customs documentation, and transportation cost management. Integrates with TMS for real-time tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'System-generated unique identifier for the carrier record.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: UI displays carrier logo on tracking pages; each carrier must reference a single digital asset containing its logo.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Required for Carrier Compliance Program enrollment; carriers must be linked to a compliance program to track certification and audit status.',
    `address_line1` STRING COMMENT 'First line of the carriers primary business address.',
    `address_line2` STRING COMMENT 'Second line of the carriers primary business address (optional).',
    `capacity_tons` DECIMAL(18,2) COMMENT 'Maximum weight capacity the carrier can transport per shipment.',
    `carrier_name` STRING COMMENT 'Full legal name of the transportation carrier.',
    `carrier_status` STRING COMMENT 'Current lifecycle status of the carrier (e.g., active, inactive, suspended, pending onboarding).. Valid values are `active|inactive|suspended|pending`',
    `carrier_tier` STRING COMMENT 'Internal tier used to prioritize carriers based on performance, volume, and strategic importance.. Valid values are `tier1|tier2|tier3|tier4`',
    `carrier_type` STRING COMMENT 'Primary service category the carrier provides (e.g., Full‑Truck‑Load, Less‑Truck‑Load, parcel, last‑mile, cross‑border).. Valid values are `ftl|ltl|parcel|last_mile|cross_border`',
    `city` STRING COMMENT 'City component of the carriers primary address.',
    `compliance_ctpat` BOOLEAN COMMENT 'Indicates whether the carrier holds a valid C‑TPAT certification.',
    `compliance_iata` BOOLEAN COMMENT 'Indicates whether the carrier is certified by IATA for air freight operations.',
    `compliance_wto` BOOLEAN COMMENT 'Indicates whether the carrier complies with WTO trade regulations for cross‑border shipments.',
    `contact_email` STRING COMMENT 'Email address for the carriers primary contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary business contact for the carrier.',
    `contact_phone` STRING COMMENT 'Phone number for the carriers primary contact.',
    `contract_end_date` DATE COMMENT 'Date when the carrier contract expires or is scheduled for renewal (nullable for open‑ended contracts).',
    `contract_number` STRING COMMENT 'Unique identifier for the active contract with the carrier.',
    `contract_start_date` DATE COMMENT 'Date when the carrier contract becomes effective.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the carrier is headquartered.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the carrier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for carrier contract financials.. Valid values are `^[A-Z]{3}$`',
    `dot_number` STRING COMMENT 'Seven‑digit identifier assigned by the U.S. Department of Transportation to the carrier.. Valid values are `^[0-9]{7}$`',
    `edi_integration_status` STRING COMMENT 'Current status of Electronic Data Interchange integration with the carrier.. Valid values are `integrated|pending|none`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the carriers liability insurance coverage.',
    `insurance_expiry_date` DATE COMMENT 'Date when the carriers insurance coverage expires.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Date‑time when the carrier record was last reviewed for compliance or data quality.',
    `max_weight_lbs` DECIMAL(18,2) COMMENT 'Maximum weight in pounds the carrier can handle for a single shipment.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the carrier.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the carrier.. Valid values are `net30|net45|net60|prepaid`',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the carriers primary address.. Valid values are `^[A-Z0-9]{3,10}$`',
    `rating_score` DECIMAL(18,2) COMMENT 'Aggregated performance rating (0‑5) based on on‑time delivery, damage rate, and service quality.',
    `scac_code` STRING COMMENT 'Four‑character alphanumeric code that uniquely identifies the carrier in industry systems.. Valid values are `^[A-Z0-9]{2,4}$`',
    `service_capabilities` STRING COMMENT 'Free‑text description of the carriers capabilities (e.g., temperature‑controlled, hazardous‑material, LTL consolidation).',
    `sla_delivery_time_actual` STRING COMMENT 'Actual delivery time in minutes recorded for the carrier.',
    `sla_delivery_time_target` STRING COMMENT 'Target delivery time in minutes defined in the carrier SLA.',
    `state` STRING COMMENT 'State or province component of the carriers primary address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the carrier record.',
    `website_url` STRING COMMENT 'Public website address of the carrier.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for all transportation carriers (FTL, LTL, parcel, last-mile, cross-border) contracted by Ecommerce. Captures carrier identity (SCAC, DOT number), service capabilities, EDI integration status, compliance certifications (C-TPAT, IATA, WTO), carrier tier classification, performance SLA thresholds, and active contract references. SSOT for carrier identity across TMS and logistics operations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier_service` (
    `carrier_service_id` BIGINT COMMENT 'Unique surrogate key for each carrier service offering.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier that provides this service.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service fees are allocated to cost centers to reflect true cost of carrier services per business unit.',
    `base_rate_usd` DECIMAL(18,2) COMMENT 'Base price for the service before any surcharges or discounts, in US dollars.',
    `carrier_service_description` STRING COMMENT 'Free‑form description of the service, including any special handling notes.',
    `carrier_service_status` STRING COMMENT 'Current lifecycle status of the service offering.. Valid values are `active|inactive|suspended|pending`',
    `cost_per_kg_usd` DECIMAL(18,2) COMMENT 'Variable cost component calculated per kilogram of shipment weight.',
    `cost_per_mile_usd` DECIMAL(18,2) COMMENT 'Variable cost component calculated per mile of distance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier service record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for pricing.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `customs_document_required` BOOLEAN COMMENT 'True if shipments using this service require customs paperwork.',
    `destination_zone` STRING COMMENT 'Geographic zone or region where shipments are delivered for this service.',
    `dimension_limit_cm` DECIMAL(18,2) COMMENT 'Maximum linear dimension (e.g., longest side) allowed for the service, in centimeters.',
    `effective_from` DATE COMMENT 'Date when the service offering becomes active.',
    `effective_until` DATE COMMENT 'Date when the service offering is retired or expires (null if indefinite).',
    `fuel_surcharge_percent` DECIMAL(18,2) COMMENT 'Percentage surcharge applied to the base rate to account for fuel price volatility.',
    `is_express` BOOLEAN COMMENT 'True if the service is classified as express (priority handling).',
    `level_code` STRING COMMENT 'Carrier‑specific code representing the service level tier.',
    `max_height_cm` DECIMAL(18,2) COMMENT 'Maximum height of a package for this service, in centimeters.',
    `max_length_cm` DECIMAL(18,2) COMMENT 'Maximum length of a package for this service, in centimeters.',
    `max_volume_cbm` DECIMAL(18,2) COMMENT 'Maximum cargo volume allowed for the service, expressed in cubic meters.',
    `max_width_cm` DECIMAL(18,2) COMMENT 'Maximum width of a package for this service, in centimeters.',
    `notes` STRING COMMENT 'Additional free‑form remarks or special conditions for the service.',
    `origin_zone` STRING COMMENT 'Geographic zone or region where shipments originate for this service.',
    `service_category` STRING COMMENT 'Broad classification of the service based on geographic scope.. Valid values are `domestic|international|cross_border|regional|global`',
    `service_code` STRING COMMENT 'Carrier‑assigned alphanumeric code that uniquely identifies the service.',
    `service_name` STRING COMMENT 'Human‑readable name of the service (e.g., "Express Overnight").',
    `service_type` STRING COMMENT 'Categorization of the service offering (e.g., standard ground, express, LTL, FTL).. Valid values are `standard_ground|express|overnight|same_day|ltl|ftl`',
    `sla_transit_time_days` STRING COMMENT 'Service Level Agreement guaranteed transit time in days.',
    `surcharge_eligible` BOOLEAN COMMENT 'Indicates whether the service is subject to surcharges (e.g., fuel, residential).',
    `tracking_supported` BOOLEAN COMMENT 'Indicates whether real‑time shipment tracking is available for this service.',
    `transit_time_days` STRING COMMENT 'Typical number of calendar days from pickup to delivery for this service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the carrier service record.',
    `weight_limit_kg` DECIMAL(18,2) COMMENT 'Maximum allowable shipment weight for the service, expressed in kilograms.',
    CONSTRAINT pk_carrier_service PRIMARY KEY(`carrier_service_id`)
) COMMENT 'Defines the specific service offerings provided by each carrier — e.g., standard ground, express, overnight, same-day, LTL freight, FTL, cross-border. Captures service code, transit time SLA, weight/dimension limits, supported origin-destination lanes, surcharge eligibility, and carrier-assigned service level identifiers. Enables carrier selection logic in TMS route optimization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` (
    `logistics_shipment_id` BIGINT COMMENT 'Unique surrogate key for the shipment record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed for Marketing ROI attribution linking each shipment to the campaign that generated the order, enabling shipment‑level performance reporting.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link logistics_shipment to carrier for carrier ownership; carrier_name string becomes redundant.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for internal accounting: allocate each shipments cost to a cost center for expense reporting and profitability analysis.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Required for shipment fulfillment reports linking each shipment to the customers shipping address used for origin, enabling address‑level delivery performance analysis.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the shipment in the Transportation Management System.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Linking shipments to the originating order is essential for order‑to‑shipment tracking reports and customer service dashboards.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Inbound Shipment Receipt Matching report ties each shipment to the Goods Receipt that records quantity received in the warehouse.',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Link logistics_shipment to route for route planning reference.',
    `actual_delivery_date` DATE COMMENT 'Date the shipment was delivered to the recipient.',
    `actual_ship_date` DATE COMMENT 'Date the shipment actually left the origin.',
    `carrier_service_code` STRING COMMENT 'Code representing the specific service level offered by the carrier (e.g., UPS Ground, FedEx Express).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was initially created in the TMS.',
    `customs_document_number` STRING COMMENT 'Reference number for customs paperwork.',
    `customs_value_amount` DECIMAL(18,2) COMMENT 'Declared monetary value for customs duty calculation.',
    `customs_value_currency` STRING COMMENT 'Three‑letter ISO currency code for the customs value.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value declared for customs and insurance purposes.',
    `declared_value_currency` STRING COMMENT 'Three‑letter ISO currency code for the declared value.',
    `delivery_confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when delivery was confirmed by the carrier.',
    `destination_address` STRING COMMENT 'Full delivery address of the customer.',
    `destination_country` STRING COMMENT 'Three‑letter ISO country code of the delivery destination.',
    `dimension_height_cm` DECIMAL(18,2) COMMENT 'Height of the shipment package in centimeters.',
    `dimension_length_cm` DECIMAL(18,2) COMMENT 'Length of the shipment package in centimeters.',
    `dimension_width_cm` DECIMAL(18,2) COMMENT 'Width of the shipment package in centimeters.',
    `estimated_delivery_date` DATE COMMENT 'Planned date for delivery to the destination.',
    `estimated_ship_date` DATE COMMENT 'Planned date for the shipment to leave the origin.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the insurance coverage.',
    `insurance_currency` STRING COMMENT 'Three‑letter ISO currency code for the insurance amount.',
    `insurance_required` BOOLEAN COMMENT 'True if the shipment is insured.',
    `is_hazardous_material` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous goods.',
    `logistics_shipment_status` STRING COMMENT 'Current lifecycle state of the shipment.. Valid values are `pending|in_transit|delivered|exception|cancelled`',
    `origin_address` STRING COMMENT 'Full address of the shipment origin (warehouse or fulfillment center).',
    `origin_country` STRING COMMENT 'Three‑letter ISO country code of the origin location.',
    `proof_of_delivery_url` STRING COMMENT 'Link to the electronic proof of delivery document.',
    `record_audit_created` TIMESTAMP COMMENT 'System timestamp when the record was first captured.',
    `record_audit_updated` TIMESTAMP COMMENT 'System timestamp of the most recent update to the record.',
    `route_optimization_reference` STRING COMMENT 'Identifier for the route optimization run used for this shipment.',
    `service_level` STRING COMMENT 'Delivery speed commitment for the shipment.. Valid values are `standard|express|overnight`',
    `shipment_number` STRING COMMENT 'External reference number assigned to the shipment by the transportation management system.',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on load size.. Valid values are `parcel|ftl|ltl`',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Base shipping charge before taxes and fees.',
    `shipping_cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the shipping cost.',
    `shipping_cost_tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the shipping charge.',
    `shipping_cost_total_amount` DECIMAL(18,2) COMMENT 'Total shipping charge including taxes and fees.',
    `signature_required` BOOLEAN COMMENT 'Indicates whether a recipient signature is required on delivery.',
    `tracking_number` STRING COMMENT 'Unique tracking identifier provided by the carrier.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    CONSTRAINT pk_logistics_shipment PRIMARY KEY(`logistics_shipment_id`)
) COMMENT 'Core transactional entity representing a physical shipment dispatched from a fulfillment node to a destination. Captures shipment reference number, origin/destination addresses, carrier assignment, service level, tracking number, weight, dimensions, declared value, shipment status (derived from tracking_event stream), estimated and actual ship/delivery dates, FTL/LTL indicator, and TMS shipment ID. Central logistics record linking orders to physical movement. SSOT for shipment identity and carrier assignment. Status is derived from tracking_event — this entity owns the shipment header, not the event history.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`shipment_package` (
    `shipment_package_id` BIGINT COMMENT 'Unique identifier for the shipment package record.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the primary product contained in the package.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the parent shipment to which this package belongs.',
    `actual_delivery_date` DATE COMMENT 'Date on which the package was actually delivered.',
    `barcode_image_url` STRING COMMENT 'Link to the barcode image used on the package label.',
    `carrier_code` STRING COMMENT 'Standard code representing the shipping carrier (e.g., UPS, FedEx).',
    `carrier_name` STRING COMMENT 'Human‑readable name of the shipping carrier.',
    `carrier_service_level` STRING COMMENT 'Service tier selected for the shipment (e.g., standard, express, overnight).. Valid values are `standard|express|overnight`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the package record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the declared value.',
    `customs_document_url` STRING COMMENT 'Link to electronic customs documentation associated with the package.',
    `declared_value_usd` DECIMAL(18,2) COMMENT 'Monetary value declared for customs and insurance purposes, expressed in US dollars.',
    `delivery_confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when delivery was confirmed by the carrier or recipient.',
    `estimated_delivery_date` DATE COMMENT 'Planned date for package delivery based on carrier service level.',
    `height_cm` STRING COMMENT 'External height of the package in centimeters.',
    `insurance_amount_usd` DECIMAL(18,2) COMMENT 'Monetary amount of insurance coverage for the package, in US dollars.',
    `insurance_coverage_flag` BOOLEAN COMMENT 'True if the package is insured for loss or damage.',
    `is_return` BOOLEAN COMMENT 'Indicates whether the package is part of a return shipment.',
    `label_generated_timestamp` TIMESTAMP COMMENT 'Date‑time when the shipping label was created.',
    `label_url` STRING COMMENT 'Link to the generated shipping label PDF or image.',
    `length_cm` STRING COMMENT 'External length of the package in centimeters.',
    `package_type` STRING COMMENT 'Physical form factor of the package.. Valid values are `box|pallet|envelope|crate`',
    `quantity` STRING COMMENT 'Number of units of the product shipped in this package.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the package.',
    `sequence_number` STRING COMMENT 'Ordinal position of the package within the shipment.',
    `shipment_package_status` STRING COMMENT 'Current lifecycle status of the package.. Valid values are `in_transit|delivered|exception|pending|lost`',
    `signature_required` BOOLEAN COMMENT 'Indicates if a recipient signature is required for delivery.',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking identifier for the package.',
    `tracking_url` STRING COMMENT 'Web URL where the package tracking status can be viewed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the package record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the package in kilograms.',
    `width_cm` STRING COMMENT 'External width of the package in centimeters.',
    CONSTRAINT pk_shipment_package PRIMARY KEY(`shipment_package_id`)
) COMMENT 'Individual physical packages within a shipment. A single shipment may contain multiple packages (cartons, pallets, parcels, envelopes). Captures package sequence number, dimensions (L×W×H), weight, package type, tracking barcode, carrier label format and file reference URL, label generation timestamp, seal number, hazmat flag, and package-level status. Subsumes shipping label data — label attributes are properties of the package, not a separate entity. Enables parcel-level tracking, carrier billing reconciliation, and manifest generation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`shipment_item` (
    `shipment_item_id` BIGINT COMMENT 'Unique surrogate key for each line item within a shipment.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the parent shipment record to which this line belongs.',
    `shipment_package_id` BIGINT COMMENT 'Identifier of the physical package/container that holds this line item.',
    `carrier_code` STRING COMMENT 'Identifier of the carrier responsible for transporting the shipment.',
    `country_of_origin` STRING COMMENT 'Three‑letter country code indicating where the product was manufactured.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment item record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter currency code of the declared value (e.g., USD, EUR).',
    `declared_value` DECIMAL(18,2) COMMENT 'Monetary value declared for a single unit of the item for customs purposes.',
    `export_control_classification` STRING COMMENT 'Regulatory export classification (e.g., EAR99, ITAR) for the item.',
    `hazmat_classification` STRING COMMENT 'Classification code indicating hazardous material type, if applicable.',
    `height_cm` DECIMAL(18,2) COMMENT 'Physical height of the item in centimeters.',
    `hs_tariff_code` STRING COMMENT 'International customs classification code for the product.',
    `is_hazmat` BOOLEAN COMMENT 'True if the item is classified as hazardous material.',
    `item_description` STRING COMMENT 'Free‑form description of the product for customs and carrier manifests.',
    `length_cm` DECIMAL(18,2) COMMENT 'Physical length of the item in centimeters.',
    `line_sequence` STRING COMMENT 'Sequential number of the line item within the shipment for ordering.',
    `line_value` DECIMAL(18,2) COMMENT 'Total monetary value for the line (quantity × declared unit value).',
    `product_name` STRING COMMENT 'Human‑readable name of the product included in the shipment line.',
    `quantity` BIGINT COMMENT 'Number of units of the SKU shipped in this line.',
    `restricted_flag` BOOLEAN COMMENT 'True if the item is subject to export restrictions.',
    `shipment_item_status` STRING COMMENT 'Current processing status of the shipment line item.. Valid values are `pending|in_transit|delivered|returned|canceled`',
    `sku` STRING COMMENT 'Standardized product identifier used across the ecommerce platform.',
    `tracking_number` STRING COMMENT 'Unique tracking number assigned by the carrier for this shipment line.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., EA for each, KG for kilograms).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment item record.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Calculated volume of the line item in cubic meters (derived from dimensions).',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the line item in kilograms, used for freight calculations.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width of the item in centimeters.',
    CONSTRAINT pk_shipment_item PRIMARY KEY(`shipment_item_id`)
) COMMENT 'Line-level detail of SKUs included within a shipment package. Captures SKU reference, quantity shipped, unit of measure, item description, HS tariff code for customs, country of origin, declared unit value, and hazmat classification. Supports customs documentation, carrier manifests, and shipment-to-order reconciliation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`tracking_event` (
    `tracking_event_id` BIGINT COMMENT 'Globally unique surrogate key for each shipment tracking event.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link tracking_event to carrier for carrier reference; carrier_code becomes redundant.',
    `carrier_facility_code` STRING COMMENT 'Identifier of the carriers hub or facility where the event occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the tracking event record was first ingested into the lakehouse.',
    `delivery_attempt_outcome` STRING COMMENT 'Result of the delivery attempt.. Valid values are `success|failed|no_answer|refused|rescheduled`',
    `delivery_attempt_sequence` STRING COMMENT 'Ordinal number of the delivery attempt for this shipment.',
    `event_status` STRING COMMENT 'Current processing status of the event record.. Valid values are `pending|processed|error`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier generated the tracking event.',
    `event_type_code` STRING COMMENT 'Standardized code representing the type of shipment event.. Valid values are `pickup|in_transit|out_for_delivery|delivery_attempt|exception|proof_of_delivery`',
    `event_type_description` STRING COMMENT 'Human‑readable description of the event type.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating why an exception event occurred.. Valid values are `address_correction|customs_hold|damage|carrier_delay|other`',
    `exception_reason_description` STRING COMMENT 'Human‑readable explanation of the exception cause.',
    `exception_resolution_action` STRING COMMENT 'Action taken to resolve the exception (e.g., address corrected, customs cleared).',
    `exception_resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was resolved.',
    `exception_responsible_party` STRING COMMENT 'Entity accountable for resolving the exception.. Valid values are `carrier|sender|receiver|customs`',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the event location in decimal degrees.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the event location in decimal degrees.',
    `proof_of_delivery_photo_url` STRING COMMENT 'Link to the delivery confirmation photo.',
    `proof_of_delivery_recipient_name` STRING COMMENT 'Name of the person who received the shipment.',
    `proof_of_delivery_signature_url` STRING COMMENT 'Link to the captured signature image for the delivery.',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when proof of delivery was captured.',
    `raw_event_description` STRING COMMENT 'Original free‑text payload received from the carrier.',
    `reattempt_scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time for the next delivery attempt after a failure.',
    `scan_location` STRING COMMENT 'Physical address or location description where the scan was performed.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the shipment met the SLA delivery time (true) or missed it (false).',
    `sla_target_timestamp` TIMESTAMP COMMENT 'Committed delivery time defined by the SLA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the tracking event record.',
    CONSTRAINT pk_tracking_event PRIMARY KEY(`tracking_event_id`)
) COMMENT 'Unified event stream recording all shipment lifecycle events from carrier integrations (EDI 214, carrier APIs). Event types include: pickup scan, in-transit scan, out-for-delivery, delivery attempt (with attempt sequence, outcome, and reattempt scheduling), exception (address correction, customs hold, damage, carrier delay — with exception reason code, responsible party, resolution action, and resolution timestamp), and proof-of-delivery confirmation (recipient name, signature capture, delivery photo URL, GPS coordinates). Captures event timestamp, event type code, scan location, carrier facility code, GPS coordinates, and raw carrier event description. SSOT for ALL shipment status derivation, last-mile visibility, exception management, delivery confirmation, and SLA compliance monitoring. No other entity in this domain records shipment events or delivery outcomes.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`route` (
    `route_id` BIGINT COMMENT 'Unique system-generated identifier for the transportation route.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Tracking UI shows a visual map of the route; each route needs a reference to one map‑image digital asset.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Route operating costs are charged to a cost center to enable route‑level cost analysis.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link route to primary carrier; primary_carrier_code becomes redundant.',
    `average_cost_per_mile` DECIMAL(18,2) COMMENT 'Historical average cost incurred per mile for operating the route (currency unit omitted for brevity).',
    `average_transit_days` DECIMAL(18,2) COMMENT 'Historical average number of days the route has taken to complete.',
    `corridor_type` STRING COMMENT 'Classification of the transportation corridor (e.g., last‑mile, linehaul, cross‑dock, domestic, international, cross‑border).. Valid values are `last-mile|linehaul|cross-dock|domestic|international|cross-border`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the route record was first created.',
    `cross_border` BOOLEAN COMMENT 'True if the route traverses an international border.',
    `customs_document_required` BOOLEAN COMMENT 'Indicates whether customs documentation is mandatory for the route.',
    `customs_tariff_code` STRING COMMENT 'HS or tariff code applicable to shipments on this route.',
    `destination_hub_code` STRING COMMENT 'Code of the destination hub, facility, or region where the route ends.',
    `destination_region` STRING COMMENT 'Geographic region of the destination hub.',
    `effective_end_date` DATE COMMENT 'Date when the route is retired or no longer usable (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the route becomes active for planning and execution.',
    `estimated_distance_km` DECIMAL(18,2) COMMENT 'Planned travel distance for the route in kilometers.',
    `estimated_transit_days` STRING COMMENT 'Planned number of calendar days required to complete the route.',
    `lane_volume_tier` STRING COMMENT 'Classification of expected shipment volume on the lane (e.g., low, medium, high, very high).. Valid values are `low|medium|high|very_high`',
    `last_mile_type` STRING COMMENT 'Mode of final delivery to the consumer (e.g., door‑to‑door, locker, pickup point).. Valid values are `door_to_door|locker|pickup_point`',
    `max_load_weight_tons` DECIMAL(18,2) COMMENT 'Maximum permissible weight for a single shipment on the route, expressed in metric tons.',
    `max_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum cargo volume that can be transported on the route.',
    `optimization_algorithm_version` STRING COMMENT 'Version identifier of the algorithm used to generate or optimize the route.',
    `origin_hub_code` STRING COMMENT 'Code of the origin hub, facility, or region where the route starts.',
    `origin_region` STRING COMMENT 'Geographic region of the origin hub.',
    `owner_department` STRING COMMENT 'Internal department responsible for the routes governance and performance.',
    `risk_level` STRING COMMENT 'Risk classification for the route based on factors such as security, weather, and regulatory exposure.. Valid values are `low|medium|high`',
    `route_code` STRING COMMENT 'External business code used to reference the route in logistics and carrier contracts.',
    `route_description` STRING COMMENT 'Free‑form description of the route, including notable characteristics or constraints.',
    `route_name` STRING COMMENT 'Human‑readable name describing the route.',
    `route_status` STRING COMMENT 'Current lifecycle status of the route.. Valid values are `active|inactive|planned|retired`',
    `stop_sequence` STRING COMMENT 'Ordered list of stop identifiers for multi‑stop routes, stored as a delimited string.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite score (0‑100) reflecting the environmental impact of the route.',
    `updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the route record.',
    `vehicle_type_requirement` STRING COMMENT 'Required vehicle type for the route (e.g., truck, van, bike, drone, container).. Valid values are `truck|van|bike|drone|container`',
    `created_by` STRING COMMENT 'User or system that created the route record.',
    CONSTRAINT pk_route PRIMARY KEY(`route_id`)
) COMMENT 'Master definition of all origin-to-destination transportation corridors — including last-mile delivery routes with stop sequences, linehaul lanes, inter-facility transfer lanes, and cross-border corridors. Captures route/lane code, origin hub/facility/region, destination zone/facility/region, stop sequence (for multi-stop routes), estimated distance and transit duration, corridor type (last-mile, linehaul, cross-dock, domestic, international, cross-border), lane volume tier, primary and backup carrier assignment, vehicle type requirement, average transit days, active status, and route optimization algorithm version. SSOT for ALL transportation lane and route definitions supporting TMS route optimization, capacity planning, carrier assignment, rate management, and DSR planning. Subsumes both point-to-point lanes and multi-stop delivery routes.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`route_stop` (
    `route_stop_id` BIGINT COMMENT 'Unique identifier for the route stop record.',
    `document_id` BIGINT COMMENT 'Identifier for customs documentation associated with cross‑border stops.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver handling the stop.',
    `pod_document_id` BIGINT COMMENT 'Reference identifier for the POD document.',
    `route_id` BIGINT COMMENT 'Identifier of the parent delivery route.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle serving the stop.',
    `actual_arrival_time` TIMESTAMP COMMENT 'Timestamp when the vehicle actually arrived at the stop.',
    `actual_departure_time` TIMESTAMP COMMENT 'Timestamp when the vehicle left the stop.',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier responsible for the stop.',
    `city` STRING COMMENT 'City component of the stops delivery address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the stop location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the route stop record was created.',
    `customs_status` STRING COMMENT 'Current status of customs clearance for the stop.. Valid values are `pending|cleared|held`',
    `delivery_address_line1` STRING COMMENT 'First line of the stops delivery address.',
    `delivery_address_line2` STRING COMMENT 'Second line of the stops delivery address, if applicable.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether an exception occurred at the stop.',
    `exception_reason` STRING COMMENT 'Free‑text description of the exception, if any.',
    `fuel_consumption_liters` DECIMAL(18,2) COMMENT 'Fuel consumed by the vehicle up to this stop.',
    `is_last_stop` BOOLEAN COMMENT 'Indicates whether this stop is the final stop on the route.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the stop location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the stop location.',
    `notes` STRING COMMENT 'Free‑form notes entered by the driver or operations staff.',
    `odometer_reading_km` DECIMAL(18,2) COMMENT 'Vehicle odometer reading at arrival at the stop.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the stops delivery address.',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when proof of delivery was captured.',
    `scheduled_arrival_end` TIMESTAMP COMMENT 'Planned end time of the arrival window for the stop.',
    `scheduled_arrival_start` TIMESTAMP COMMENT 'Planned start time of the arrival window for the stop.',
    `scheduled_departure_time` TIMESTAMP COMMENT 'Planned departure time from the stop.',
    `signature_captured` BOOLEAN COMMENT 'Indicates whether a customer signature was captured at the stop.',
    `signature_image_reference` STRING COMMENT 'Reference to the stored image of the captured signature.',
    `sla_actual_minutes` STRING COMMENT 'Actual duration measured against the SLA target.',
    `sla_target_minutes` STRING COMMENT 'Service level agreement target duration for the stop.',
    `state_province` STRING COMMENT 'State or province component of the stops delivery address.',
    `stop_sequence` STRING COMMENT 'Ordinal position of the stop within the route.',
    `stop_status` STRING COMMENT 'Current operational status of the stop.. Valid values are `scheduled|in_progress|completed|exception|canceled`',
    `stop_type` STRING COMMENT 'Classification of the stop purpose (e.g., pickup, delivery).. Valid values are `pickup|delivery|cross_dock|return|other`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Recorded temperature at the stop for temperature‑sensitive shipments.',
    `time_on_site_minutes` STRING COMMENT 'Total minutes the vehicle spent at the stop location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the route stop record.',
    `version` STRING COMMENT 'Version number for optimistic concurrency control.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the load measured at the stop.',
    CONSTRAINT pk_route_stop PRIMARY KEY(`route_stop_id`)
) COMMENT 'Individual stop records within a planned delivery route. Captures stop sequence number, delivery address, scheduled arrival window, actual arrival time, stop type (pickup, delivery, cross-dock), stop status, time-on-site duration, and exception flag. Enables granular last-mile route execution tracking and SLA compliance monitoring.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'System-generated unique identifier for the freight order record.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier party responsible for transporting the freight.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight orders generate expenses that need to be booked against the appropriate cost center for budgeting.',
    `center_id` BIGINT COMMENT 'Identifier of the facility where the freight is to be delivered.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Freight orders are subject to specific compliance obligations (e.g., hazardous material handling); linking enables obligation tracking and reporting.',
    `primary_freight_center_id` BIGINT COMMENT 'Identifier of the facility where the freight is picked up.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for Freight Order tracking of each Purchase Order; PO fulfillment teams need to trace logistics execution back to the originating PO.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the shipper (originating party) for the freight.',
    `agreed_rate_amount` DECIMAL(18,2) COMMENT 'Monetary rate agreed with the carrier for the shipment, before any adjustments.',
    `bill_of_lading_number` STRING COMMENT 'Document reference number for the shipments bill of lading.',
    `carrier_acceptance_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier accepted the freight tender.',
    `carrier_rate_type` STRING COMMENT 'Classification of the carriers rate (spot, contract, or negotiated).. Valid values are `spot|contract|negotiated`',
    `carrier_rejection_reason` STRING COMMENT 'Free‑text reason supplied by the carrier if the tender was rejected.',
    `carrier_response_deadline_timestamp` TIMESTAMP COMMENT 'Latest timestamp by which the carrier must accept or reject the tender.',
    `commodity_description` STRING COMMENT 'Free‑text description of the goods being transported.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values on the freight order.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `delivery_appointment_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the carrier to deliver the freight.',
    `equipment_type` STRING COMMENT 'Type of trailer or container used for the shipment.. Valid values are `dry_van|reefer|flatbed|container|tanker`',
    `freight_class` STRING COMMENT 'Standard freight classification (e.g., NMFC) used for pricing and routing.',
    `freight_order_status` STRING COMMENT 'Current lifecycle state of the freight order.. Valid values are `pending|accepted|rejected|in_transit|completed|cancelled`',
    `freight_order_type` STRING COMMENT 'Indicates whether the order is a tender, contract, or spot shipment.. Valid values are `tender|contract|spot`',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the shipment contains hazardous materials requiring special handling.',
    `load_type` STRING COMMENT 'Indicates whether the shipment is Full Truckload (FTL) or Less‑Than‑Truckload (LTL).. Valid values are `FTL|LTL`',
    `mode_of_transport` STRING COMMENT 'Primary transportation mode for the freight.. Valid values are `road|rail|air|sea`',
    `order_number` STRING COMMENT 'External business identifier assigned to the freight order, used in carrier communications and audit.',
    `pickup_appointment_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the carrier to pick up the freight.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether the shipment is marked as high priority.',
    `shipping_terms` STRING COMMENT 'Incoterm governing responsibility and cost allocation for the shipment.. Valid values are `EXW|FCA|CPT|DAP|DDP`',
    `special_handling_instructions` STRING COMMENT 'Additional instructions for carrier regarding loading, temperature control, or safety.',
    `tender_timestamp` TIMESTAMP COMMENT 'Date and time when the freight order was tendered to the carrier.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Final charge amount billed to the shipper after rate, surcharges, and discounts.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Aggregate volume of the shipment in cubic meters.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of the shipment in kilograms.',
    `tracking_number` STRING COMMENT 'Unique tracking identifier provided by the carrier for real‑time visibility.',
    `trailer_number` STRING COMMENT 'Identifier printed on the trailer used for the shipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the freight order record.',
    `volume_uom` STRING COMMENT 'Unit of measure for volume values.. Valid values are `m3|ft3`',
    `weight_uom` STRING COMMENT 'Unit of measure for weight values.. Valid values are `kg|lb`',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Represents a planned FTL or LTL freight movement order tendered to a carrier via EDI 204 Load Tender. Captures freight order number, shipment references, origin/destination facilities, tender date, carrier acceptance status, agreed rate, load type (FTL/LTL), commodity description, total weight/volume, pickup and delivery appointments, and carrier response deadline. Bridges TMS load planning with carrier execution and supports freight audit.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` (
    `customs_declaration_id` BIGINT COMMENT 'Unique surrogate key for the customs declaration record.',
    `carrier_id` BIGINT COMMENT 'FK to logistics.carrier',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Customs expenses are allocated to the cost center responsible for the import operation.',
    `customs_broker_id` BIGINT COMMENT 'Identifier of the customs broker handling the declaration.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Customs duties and taxes are posted to GL accounts; linking declarations to general_ledger enables accurate tax reporting.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Customs Clearance process must be linked to the Goods Receipt to verify that cleared items match received inventory.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Customs declarations must reference the governing regulation to ensure correct duty calculation and legal compliance.',
    `audit_trail` STRING COMMENT 'JSON string capturing change history for compliance.',
    `clearance_date` DATE COMMENT 'Date when customs clearance was completed.',
    `clearance_status` STRING COMMENT 'Current status of customs clearance.. Valid values are `cleared|pending|rejected|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter currency code for declared value.. Valid values are `[A-Z]{3}`',
    `customs_declaration_status` STRING COMMENT 'Operational status of the declaration record.. Valid values are `active|inactive|cancelled|archived`',
    `declaration_date` DATE COMMENT 'Date when the customs declaration was submitted.',
    `declaration_number` STRING COMMENT 'Official customs declaration number assigned by authorities.',
    `declared_value` DECIMAL(18,2) COMMENT 'Monetary value of goods as declared for customs.',
    `destination_port_code` STRING COMMENT 'Code of the port where goods are imported.',
    `duties_amount` DECIMAL(18,2) COMMENT 'Total customs duties assessed on the shipment.',
    `ead_flag` BOOLEAN COMMENT 'Indicates if an electronic advance declaration was submitted.',
    `exporting_country_code` STRING COMMENT 'Three-letter code of the country exporting the goods.. Valid values are `[A-Z]{3}`',
    `goods_description` STRING COMMENT 'Narrative description of the declared goods.',
    `hs_tariff_code` STRING COMMENT 'Internationally standardized code for classifying goods.',
    `importing_country_code` STRING COMMENT 'Three-letter code of the country importing the goods.. Valid values are `[A-Z]{3}`',
    `incoterms_code` STRING COMMENT 'International commercial terms governing the shipment. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAT|DAP|DDP — 7 candidates stripped; promote to reference product]',
    `inspection_hold_flag` BOOLEAN COMMENT 'Indicates whether the shipment is on hold for inspection.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the record.',
    `number_of_packages` STRING COMMENT 'Count of individual packages in the shipment.',
    `origin_port_code` STRING COMMENT 'Code of the port where goods are exported.',
    `package_type` STRING COMMENT 'Standard type of packaging used.. Valid values are `box|pallet|crate|bag|drum`',
    `party_code` BIGINT COMMENT 'Identifier of the party (e.g., exporter or importer) associated with the declaration.',
    `pre_clearance_flag` BOOLEAN COMMENT 'Indicates if pre-clearance procedures were performed.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text notes on compliance issues or special requirements.',
    `shipment_reference` STRING COMMENT 'Reference identifier linking the declaration to the shipment.',
    `taxes_amount` DECIMAL(18,2) COMMENT 'Total taxes (e.g., VAT, GST) assessed on the shipment.',
    `total_amount` DECIMAL(18,2) COMMENT 'Sum of duties, taxes, and any additional fees.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment.. Valid values are `air|sea|road|rail|parcel`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    CONSTRAINT pk_customs_declaration PRIMARY KEY(`customs_declaration_id`)
) COMMENT 'WTO-compliant customs documentation for cross-border shipments. Captures declaration number, shipment reference, exporting/importing country codes, HS tariff codes, declared goods value, currency, duties and taxes assessed, customs broker reference, clearance status, inspection hold flag, and regulatory compliance notes. Required for international e-commerce shipments under WTO and EU Electronic Commerce Directive.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`transport_cost` (
    `transport_cost_id` BIGINT COMMENT 'System-generated unique identifier for each transport cost record.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier providing the transportation service.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the shipment or freight order to which this cost line belongs.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Transport costs contribute to profit‑center profitability; linking enables P&L attribution per profit center.',
    `route_id` BIGINT COMMENT 'Identifier of the transportation route used.',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: Finance reconciliation of transport cost requires a direct FK to the Supplier Invoice that records the freight charge.',
    `billing_status` STRING COMMENT 'Current billing state of the cost line.. Valid values are `billed|unbilled|pending|rejected`',
    `cost_allocation_center` STRING COMMENT 'Internal cost center or accounting code to which the cost is allocated.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary value of the cost component.',
    `cost_category` STRING COMMENT 'Classification of the cost component (e.g., base freight, fuel surcharge).. Valid values are `base_freight|fuel_surcharge|residential_surcharge|dimensional_weight|accessorial|other`',
    `cost_date` DATE COMMENT 'Date on which the cost was incurred or recorded.',
    `cost_source` STRING COMMENT 'Origin of the cost data (e.g., system generated, manually entered, partner feed).. Valid values are `system|manual|partner`',
    `cost_type` STRING COMMENT 'Indicates whether the cost is an actual incurred amount or an estimated forecast.. Valid values are `actual|estimated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transport cost record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost amount.',
    `customs_document_number` STRING COMMENT 'Reference number for customs clearance documentation.',
    `customs_duty_amount` DECIMAL(18,2) COMMENT 'Duty charged by customs for cross‑border shipments.',
    `delivery_confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when delivery was confirmed by the recipient.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance of the shipment leg in kilometers.',
    `effective_date` DATE COMMENT 'Date when an estimated cost becomes effective for planning.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate applied when cost currency differs from reporting currency.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was sourced.',
    `is_late_delivery` BOOLEAN COMMENT 'Indicates whether the delivery was later than the promised date.',
    `line_sequence` STRING COMMENT 'Sequential order of cost lines within the same shipment.',
    `mode_of_transport` STRING COMMENT 'Primary mode used for the shipment (e.g., air, sea, road).. Valid values are `air|sea|road|rail|intermodal`',
    `original_currency_code` STRING COMMENT 'Currency code of the original cost before conversion.',
    `payment_term` STRING COMMENT 'Payment terms associated with the carrier invoice.. Valid values are `net30|net45|net60|prepaid`',
    `quantity` STRING COMMENT 'Number of units (e.g., pallets, containers) associated with this cost line.',
    `service_level` STRING COMMENT 'Service tier agreed with the carrier.. Valid values are `standard|express|overnight|economy`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the cost.',
    `tax_code` STRING COMMENT 'Tax jurisdiction or code used for the cost.',
    `transport_cost_description` STRING COMMENT 'Free‑form text describing the cost line or any special notes.',
    `transport_cost_status` STRING COMMENT 'Current lifecycle status of the cost line.. Valid values are `active|inactive|closed|void`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transport cost record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual cost and contracted/estimated amount.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage representation of the cost variance.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Cubic meter volume of the shipment.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the shipment used for cost calculations.',
    CONSTRAINT pk_transport_cost PRIMARY KEY(`transport_cost_id`)
) COMMENT 'Records actual and estimated transportation costs per shipment or freight order. Captures base freight charge, fuel surcharge, residential delivery surcharge, dimensional weight adjustment, accessorial charges, carrier invoice number, billing status, cost allocation center, currency, and variance against contracted rate. Feeds finance domain for freight cost accruals and carrier invoice reconciliation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` (
    `carrier_rate_card_id` BIGINT COMMENT 'Unique system-generated identifier for the carrier rate card record.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier organization that owns this rate card.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate‑card charges are allocated to cost centers for chargeback and profitability reporting.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller‑specific rate cards are used in the Rate Card Assignment workflow for volume‑based pricing and discount calculations.',
    `accessorial_charges_included` STRING COMMENT 'Flag indicating whether standard accessorial fees are bundled into the base rate.. Valid values are `yes|no`',
    `accessorial_rate_schedule` STRING COMMENT 'Reference to the schedule or code list that defines additional fees (e.g., lift‑gate, residential delivery).',
    `base_rate` DECIMAL(18,2) COMMENT 'Fundamental freight charge per kilogram before surcharges, expressed in the specified currency.',
    `carrier_rate_card_status` STRING COMMENT 'Current lifecycle state of the rate card (e.g., active, inactive, expired, pending approval).. Valid values are `active|inactive|expired|pending`',
    `compliance_regulation` STRING COMMENT 'Regulatory frameworks applicable to the rate card (e.g., WTO, ISO 27001, PCI DSS).',
    `contract_type` STRING COMMENT 'Classification of the agreement (master agreement, spot rate, or contract rate).. Valid values are `master|spot|contract`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate card record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for all monetary values in the rate card.',
    `effective_from` DATE COMMENT 'Date on which the rate card becomes legally binding and usable for pricing.',
    `effective_until` DATE COMMENT 'Date on which the rate card expires; null indicates an open‑ended agreement.',
    `fuel_surcharge_pct` DECIMAL(18,2) COMMENT 'Percentage applied to the base rate to account for fuel price volatility.',
    `incoterm` STRING COMMENT 'International Commercial Term governing responsibility and cost allocation (e.g., EXW, FCA, CPT, CIP, DAT, DAP, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAT|DAP|DDP — promote to reference product]',
    `is_accessorial_applicable` BOOLEAN COMMENT 'Indicates whether accessorial rates from the schedule are applicable for this lane.',
    `is_fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether the fuel surcharge percentage should be applied to shipments under this rate.',
    `lane_destination` STRING COMMENT 'Standardized code (e.g., IATA, UN/LOCODE) representing the shipment destination point for the lane.',
    `lane_origin` STRING COMMENT 'Standardized code (e.g., IATA, UN/LOCODE) representing the shipment origin point for the lane.',
    `lane_type` STRING COMMENT 'Indicates whether the origin‑destination lane is domestic or crosses international borders.. Valid values are `domestic|international`',
    `negotiation_reference` STRING COMMENT 'Internal reference or document ID linking the rate card to its contract negotiation record.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, exceptions, or special conditions related to the rate card.',
    `rate_card_category` STRING COMMENT 'Logical grouping of the rate card such as lane‑based, zone‑based, or region‑based.',
    `rate_card_number` STRING COMMENT 'External reference number assigned to the rate card by the carrier or logistics contract team.',
    `rate_card_source_system` STRING COMMENT 'System of record that originated the rate card (e.g., Transportation Management System, ERP).',
    `service_level_code` STRING COMMENT 'Code indicating the service commitment (e.g., standard, express, overnight) for this rate.. Valid values are `standard|express|overnight`',
    `service_level_description` STRING COMMENT 'Human‑readable description of the service level associated with the rate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rate card record.',
    `version_number` STRING COMMENT 'Incremental version identifier for the rate card to track revisions over time.',
    `weight_tier_max_kg` DECIMAL(18,2) COMMENT 'Upper bound of the weight range (in kilograms) for which the base rate applies.',
    `weight_tier_min_kg` DECIMAL(18,2) COMMENT 'Lower bound of the weight range (in kilograms) for which the base rate applies.',
    CONSTRAINT pk_carrier_rate_card PRIMARY KEY(`carrier_rate_card_id`)
) COMMENT 'Contracted rate structures negotiated with carriers for specific lanes, service levels, and weight breaks. Captures rate card version, effective/expiry dates, origin-destination lane, service level code, weight tier, base rate, fuel surcharge percentage, accessorial rate schedule, currency, and negotiation reference. SSOT for freight cost estimation and carrier selection optimization in TMS.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` (
    `delivery_zone_id` BIGINT COMMENT 'Unique surrogate key for each delivery zone record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link delivery_zone to its preferred carrier; carrier_preferred string becomes redundant.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Zone‑level delivery costs are charged to cost centers for regional budgeting and performance tracking.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Allows the Default Delivery Zone setting for each seller, used in shipping cost and SLA calculations.',
    `carrier_zone_mapping` STRING COMMENT 'Mapping string that links carrier‑specific zone identifiers to this internal zone.',
    `cost_per_shipment` DECIMAL(18,2) COMMENT 'Standard base cost charged for a shipment to this zone before surcharges.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code representing the country covered by the zone.. Valid values are `USA|CAN|MEX|GBR|DEU|FRA`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values associated with the zone.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `delivery_sla_days` STRING COMMENT 'Committed number of calendar days for delivery within this zone.',
    `delivery_window_end_time` TIMESTAMP COMMENT 'Latest time of day (HH:MM) when delivery can be performed in this zone.',
    `delivery_window_start_time` TIMESTAMP COMMENT 'Earliest time of day (HH:MM) when delivery can be performed in this zone.',
    `delivery_zone_description` STRING COMMENT 'Free‑form description of the zone, including any special handling notes.',
    `delivery_zone_status` STRING COMMENT 'Current lifecycle status of the zone record.. Valid values are `active|inactive|deprecated|pending`',
    `effective_from` DATE COMMENT 'Date when the zone definition becomes active.',
    `effective_until` DATE COMMENT 'Date when the zone definition expires or is superseded (null if open‑ended).',
    `is_default` BOOLEAN COMMENT 'Indicates whether this zone is the default fallback for unmapped addresses.',
    `is_express_available` BOOLEAN COMMENT 'Indicates whether express (same‑day/next‑day) service is offered in this zone.',
    `max_volume_cbm` DECIMAL(18,2) COMMENT 'Maximum total shipment volume allowed for a single package in this zone.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum total shipment weight allowed for a single package in this zone.',
    `postal_code_range` STRING COMMENT 'Range of postal codes (e.g., 10000‑19999) included in the zone.',
    `region` STRING COMMENT 'State, province, or region name within the country that the zone covers.',
    `requires_signature` BOOLEAN COMMENT 'Indicates whether a recipient signature is required for deliveries in this zone.',
    `surcharge_remote_area` BOOLEAN COMMENT 'Indicates whether a remote‑area surcharge applies to shipments in this zone.',
    `surcharge_residential` BOOLEAN COMMENT 'Indicates whether a residential‑delivery surcharge applies to this zone.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the zone record.',
    `zone_code` STRING COMMENT 'Business identifier code for the delivery zone, used in carrier rate tables and routing logic.',
    `zone_name` STRING COMMENT 'Human‑readable name of the delivery zone.',
    `zone_tier` STRING COMMENT 'Tier classification used for pricing and service level differentiation.. Valid values are `tier1|tier2|tier3|tier4`',
    CONSTRAINT pk_delivery_zone PRIMARY KEY(`delivery_zone_id`)
) COMMENT 'Geographic delivery zone definitions used for carrier assignment, rate calculation, and SLA determination. Captures zone code, zone name, country/region/state coverage, postal code ranges, carrier-specific zone mapping, delivery day SLA, surcharge applicability (remote area, residential), and zone tier classification. Reference entity supporting route optimization and last-mile planning.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` (
    `shipment_exception_id` BIGINT COMMENT 'System-generated unique identifier for the shipment exception record.',
    `carrier_id` BIGINT COMMENT 'Identifier of the party (carrier, customer, seller, or warehouse) responsible for the exception.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exception handling incurs costs that must be charged to the responsible cost center for variance analysis.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the shipment to which this exception relates.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: When an exception occurs, the system presents a relevant help article; link exception to the appropriate content item.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the estimated loss amount.. Valid values are `^[A-Z]{3}$`',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Monetary estimate of loss or cost impact caused by the exception.',
    `exception_code` STRING COMMENT 'Business identifier code for the exception type, used for reporting and analytics.',
    `exception_description` STRING COMMENT 'Free‑text description providing details about the exception.',
    `exception_timestamp` TIMESTAMP COMMENT 'Exact time when the exception was first detected in the shipment lifecycle.',
    `exception_type` STRING COMMENT 'Category of the shipment exception describing the root cause.. Valid values are `address_correction|delivery_failure|damaged_goods|customs_hold|carrier_delay|other`',
    `is_critical` BOOLEAN COMMENT 'True if the exception is deemed critical to business operations.',
    `location_code` STRING COMMENT 'Code of the geographic location (e.g., warehouse, hub, city) where the exception occurred.',
    `priority` STRING COMMENT 'Business priority assigned to the exception for handling urgency.. Valid values are `low|medium|high|critical`',
    `resolution_action` STRING COMMENT 'Action taken to resolve the exception.. Valid values are `address_updated|re_dispatch|refund|hold|escalated|other`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the resolution action was completed.',
    `responsible_party_type` STRING COMMENT 'Entity type responsible for addressing the exception.. Valid values are `carrier|customer|seller|warehouse`',
    `root_cause` STRING COMMENT 'Detailed analysis of the underlying cause of the exception.',
    `shipment_exception_status` STRING COMMENT 'Current lifecycle status of the exception handling process.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the exception caused a breach of the service‑level agreement.',
    `tracking_number` STRING COMMENT 'Shipment tracking number associated with the exception.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exception record.',
    CONSTRAINT pk_shipment_exception PRIMARY KEY(`shipment_exception_id`)
) COMMENT 'Operational records of shipment exceptions requiring intervention — e.g., address correction, delivery failure, damaged goods, customs hold, carrier delay. Captures exception type, exception timestamp, shipment reference, exception description, responsible party, resolution action taken, resolution timestamp, and exception status. Drives exception management workflows and SLA breach tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`return_shipment` (
    `return_shipment_id` BIGINT COMMENT 'Unique system-generated identifier for the return shipment record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link return_shipment to carrier; carrier_name and carrier_code become redundant.',
    `center_id` BIGINT COMMENT 'Identifier of the warehouse or facility where the returned items are received.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return processing costs are allocated to a cost center for accurate return expense reporting.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who initiated the return.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the forward shipment that is being returned.',
    `rma_id` BIGINT COMMENT 'Identifier of the RMA record authorizing this return.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when the return shipment was actually received.',
    `compliance_check_status` STRING COMMENT 'Result of compliance validation for the return (e.g., hazardous material checks).. Valid values are `passed|failed|pending`',
    `condition_assessment_flag` BOOLEAN COMMENT 'Indicates whether the returned item has been inspected for condition.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether the return shipment involves international transit.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the refund.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `customs_document_number` STRING COMMENT 'Reference number for customs documentation when the return crosses borders.',
    `estimated_delivery_date` DATE COMMENT 'Projected date when the return shipment will arrive at the destination facility.',
    `height_cm` STRING COMMENT 'Height dimension of the returned package.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'Monetary amount covered by insurance for the return.',
    `insurance_claim_flag` BOOLEAN COMMENT 'True if an insurance claim is filed for the returned item.',
    `is_expedited_return` BOOLEAN COMMENT 'Indicates whether the return is being processed on an expedited basis.',
    `label_generated_timestamp` TIMESTAMP COMMENT 'Timestamp when the return shipping label was created.',
    `length_cm` STRING COMMENT 'Length dimension of the returned package.',
    `notes` STRING COMMENT 'Free‑form text notes entered by staff or the customer regarding the return.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the return shipment record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the return shipment record.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount to be refunded to the customer for this return.',
    `refund_method` STRING COMMENT 'How the refund is issued to the customer.. Valid values are `original|store_credit|gift_card`',
    `refund_status` STRING COMMENT 'Current processing status of the refund.. Valid values are `pending|processed|failed`',
    `return_initiated_timestamp` TIMESTAMP COMMENT 'Timestamp when the return process was initiated by the customer or system.',
    `return_method` STRING COMMENT 'Method by which the customer returns the item.. Valid values are `pickup|dropoff|carrier_pickup`',
    `return_reason_code` STRING COMMENT 'Standardized code describing why the item is being returned.. Valid values are `defective|wrong_item|size_issue|other`',
    `return_shipment_number` STRING COMMENT 'Business identifier assigned to the return shipment for tracking and reference.',
    `return_shipment_status` STRING COMMENT 'Current lifecycle status of the return shipment.. Valid values are `initiated|in_transit|delivered|closed|cancelled`',
    `tracking_number` STRING COMMENT 'Tracking number assigned by the carrier for the return shipment.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the returned package measured in kilograms.',
    `width_cm` STRING COMMENT 'Width dimension of the returned package.',
    CONSTRAINT pk_return_shipment PRIMARY KEY(`return_shipment_id`)
) COMMENT 'Manages reverse logistics shipments initiated via RMA (Return Merchandise Authorization). Captures return shipment number, original shipment reference, RMA reference, return reason code, carrier assignment, return label generation timestamp, return tracking number, return destination facility, condition assessment flag, and return shipment status. SSOT for reverse logistics movement distinct from forward shipment.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`transport_lane` (
    `transport_lane_id` BIGINT COMMENT 'Unique system-generated identifier for the transportation lane.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lane operating costs are charged to the cost center that owns the lane for cost‑center level analysis.',
    `center_id` BIGINT COMMENT 'Identifier of the facility where the lane terminates.',
    `carrier_id` BIGINT COMMENT 'Carrier assigned as the primary service provider for this lane.',
    `primary_transport_center_id` BIGINT COMMENT 'Identifier of the facility where the lane originates.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Lane profitability is measured against profit centers; linking enables lane‑level P&L reporting.',
    `active_status` STRING COMMENT 'Current operational status of the lane.. Valid values are `active|inactive|deprecated`',
    `average_load_factor_pct` DECIMAL(18,2) COMMENT 'Average percentage of capacity utilized on the lane based on historical shipments.',
    `average_transit_days` STRING COMMENT 'Typical number of calendar days shipments take to travel the lane.',
    `carrier_service_level` STRING COMMENT 'Service tier offered by the primary carrier for this lane.. Valid values are `standard|express|overnight`',
    `compliance_ctpat` STRING COMMENT 'Customs‑Trade Partnership Against Terrorism compliance indicator for the lane.. Valid values are `compliant|non_compliant|pending`',
    `compliance_wto` STRING COMMENT 'Indicates whether the lane meets World Trade Organization cross‑border regulations.. Valid values are `compliant|non_compliant|pending`',
    `cost_per_mile_usd` DECIMAL(18,2) COMMENT 'Standard cost charged per mile for transportation on this lane, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lane record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for lane cost calculations.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `customs_documentation_required` BOOLEAN COMMENT 'True when shipments on the lane must include customs paperwork.',
    `destination_region` STRING COMMENT 'Geographic region or state code of the destination facility.',
    `effective_end_date` DATE COMMENT 'Date when the lane definition expires or is retired; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the lane definition becomes effective.',
    `is_cross_border` BOOLEAN COMMENT 'True if the lane involves international border crossing.',
    `lane_category` STRING COMMENT 'Primary freight classification for the lane.. Valid values are `full_truck_load|less_than_truck_load|parcel`',
    `lane_code` STRING COMMENT 'Business code used to uniquely identify the lane in external and internal systems.',
    `lane_name` STRING COMMENT 'Human‑readable name or description of the transportation lane.',
    `lane_type` STRING COMMENT 'Classification of the lane based on geography and customs requirements.. Valid values are `domestic|international|cross_border`',
    `lane_volume_tier` STRING COMMENT 'Categorized tier of shipment volume historically observed on the lane.. Valid values are `low|medium|high|very_high`',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the last audit or compliance check performed on the lane.',
    `last_review_date` DATE COMMENT 'Date when the lane definition was last reviewed for relevance or changes.',
    `max_volume_cubic_ft` DECIMAL(18,2) COMMENT 'Maximum cargo volume permitted for a shipment on the lane.',
    `max_weight_lbs` DECIMAL(18,2) COMMENT 'Maximum total weight allowed for a single shipment on the lane.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special handling instructions.',
    `origin_region` STRING COMMENT 'Geographic region or state code of the origin facility.',
    `route_optimization_flag` BOOLEAN COMMENT 'Indicates whether the lane is considered in automated route optimization algorithms.',
    `sla_delivery_time_actual_days` STRING COMMENT 'Most recent measured delivery time in days for shipments on this lane.',
    `sla_delivery_time_target_days` STRING COMMENT 'Target number of days promised to customers for delivery via this lane.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lane record.',
    CONSTRAINT pk_transport_lane PRIMARY KEY(`transport_lane_id`)
) COMMENT 'Master definition of origin-to-destination transportation lanes used for capacity planning, carrier assignment, and rate management. Captures lane code, origin facility/region, destination facility/region, lane type (domestic, international, cross-border), primary carrier, backup carrier, average transit days, lane volume tier, and active status. Foundational reference for TMS routing logic.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` (
    `carrier_contract_id` BIGINT COMMENT 'System-generated unique identifier for each carrier contract record.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier entity associated with this contract.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carrier contracts are budgeted to specific cost centers; this FK supports cost‑center level budgeting and variance tracking.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Contract expenses must be posted to a GL account; linking contracts to general_ledger enables accurate financial statements.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Contracts are negotiated per seller; the Carrier Contract Management process requires linking each contract to the seller it serves.',
    `amendment_date` DATE COMMENT 'Date when the latest amendment was executed.',
    `amendment_description` STRING COMMENT 'Summary of changes introduced by the latest amendment.',
    `amendment_number` STRING COMMENT 'Sequential number of the most recent amendment to the contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiry.',
    `carrier_contract_status` STRING COMMENT 'Current lifecycle state of the contract.. Valid values are `active|inactive|suspended|terminated|pending|draft`',
    `compliance_ctpat` BOOLEAN COMMENT 'Indicates whether the carrier complies with the Customs‑Trade Partnership Against Terrorism program.',
    `compliance_iata` BOOLEAN COMMENT 'Indicates compliance with International Air Transport Association standards where applicable.',
    `compliance_wto` BOOLEAN COMMENT 'Indicates compliance with World Trade Organization regulations for cross‑border shipments.',
    `confidentiality_flag` BOOLEAN COMMENT 'Marks the contract as confidential for internal handling.',
    `contract_category` STRING COMMENT 'Indicates whether the contract applies to domestic or international shipments.. Valid values are `domestic|international`',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic copy of the signed contract.',
    `contract_manager_email` STRING COMMENT 'Email address of the contract manager.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contract_manager_name` STRING COMMENT 'Name of the person managing day‑to‑day contract activities.',
    `contract_manager_phone` STRING COMMENT 'Phone number of the contract manager.',
    `contract_number` STRING COMMENT 'External contract reference number assigned by the carrier or Ecommerce.',
    `contract_owner` STRING COMMENT 'Internal stakeholder responsible for the contracts overall performance.',
    `contract_region` STRING COMMENT 'Geographic region covered by the contract.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `contract_signed_date` DATE COMMENT 'Date when the contract was formally signed by both parties.',
    `contract_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract status last changed.',
    `contract_status_reason` STRING COMMENT 'Reason or narrative explaining the most recent status change.',
    `contract_type` STRING COMMENT 'Classification of the contract: master, spot, or dedicated.. Valid values are `master|spot|dedicated`',
    `contracted_volume` DECIMAL(18,2) COMMENT 'Total volume of freight (e.g., tons) the carrier commits to transport under the contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts in the contract.',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or is terminated; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes binding.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the contract grants exclusive rights to the carrier.',
    `is_preferred` BOOLEAN COMMENT 'Marks the carrier as a preferred partner for routing decisions.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the last audit or compliance review of the contract.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or special conditions.',
    `payment_terms` STRING COMMENT 'Standard payment condition (e.g., Net30) agreed with the carrier.. Valid values are `Net30|Net45|Net60`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied for SLA breaches or contract violations.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.',
    `rate_card_reference` STRING COMMENT 'Identifier linking to the carriers rate card that defines pricing structures.',
    `renewal_term_months` STRING COMMENT 'Number of months for each renewal period when auto‑renewal is enabled.',
    `sla_delivery_time_actual_hours` STRING COMMENT 'Actual delivery time recorded for the contract period.',
    `sla_delivery_time_target_hours` STRING COMMENT 'Targeted delivery time in hours as defined in the SLA.',
    `termination_notice_period_days` STRING COMMENT 'Required notice period in days before contract termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `volume_unit` STRING COMMENT 'Unit of measure for the contracted volume.. Valid values are `tons|cubic_meters|pallets`',
    CONSTRAINT pk_carrier_contract PRIMARY KEY(`carrier_contract_id`)
) COMMENT 'Master records of commercial contracts with transportation carriers. Captures contract number, carrier reference, contract type (master, spot, dedicated), effective and expiry dates, contracted volume commitments, rate card references, SLA terms, penalty clauses, auto-renewal flag, and contract status. Distinct from carrier_rate_card which holds rate structures — this entity holds the legal and commercial agreement metadata.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` (
    `carrier_tag_assignment_id` BIGINT COMMENT 'Primary key for the carrier_tag_assignment association',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to carrier',
    `tag_id` BIGINT COMMENT 'Foreign key linking to tag',
    `assignment_timestamp` TIMESTAMP COMMENT 'When the tag was assigned to the carrier',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level of the tag assignment from ML or rule‑based process',
    CONSTRAINT pk_carrier_tag_assignment PRIMARY KEY(`carrier_tag_assignment_id`)
) COMMENT 'This association captures the assignment of tags to carriers. Each record links one carrier to one tag and stores the timestamp of the assignment and the confidence score from the tagging process.. Existence Justification: Carriers are classified with multiple tags (e.g., express, eco‑friendly) to support routing and reporting decisions. Each tag can be applied to many carriers, and the assignment is actively managed with timestamps and confidence scores. The relationship itself is a managed entity that business users query and update.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` (
    `carrier_cost_center_contract_id` BIGINT COMMENT 'Primary key for the carrier_cost_center_contract association',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to carrier',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to cost center',
    `contract_number` STRING COMMENT 'Unique identifier for the carrier‑cost_center contract',
    `currency_code` STRING COMMENT 'ISO currency code for contract pricing',
    `effective_from` DATE COMMENT 'Date when the contract becomes effective',
    `effective_until` DATE COMMENT 'Date when the contract expires or is scheduled for renewal',
    `rate_card_reference` STRING COMMENT 'Reference to the rate card governing pricing for the carrier',
    CONSTRAINT pk_carrier_cost_center_contract PRIMARY KEY(`carrier_cost_center_contract_id`)
) COMMENT 'This association product represents the contract between a logistics carrier and a finance cost center. It captures the contractual terms, effective dates, rate references and currency that are specific to each carrier‑cost_center pairing.. Existence Justification: Carriers negotiate and sign contracts with one or more cost centers, and each cost center can have contracts with multiple carriers. The contract itself carries attributes such as contract number, effective dates, rate information and currency, which are not intrinsic to either the carrier or the cost center. The business actively creates, updates, and retires these contracts as a distinct operational entity.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`customs_broker` (
    `customs_broker_id` BIGINT COMMENT 'Primary key for customs_broker',
    `tax_id` BIGINT COMMENT 'Tax identification number for the broker (e.g., EIN).',
    `parent_customs_broker_id` BIGINT COMMENT 'Self-referencing FK on customs_broker (parent_customs_broker_id)',
    `address_line1` STRING COMMENT 'First line of the brokers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the brokers mailing address (optional).',
    `broker_type` STRING COMMENT 'Category of services the broker provides.',
    `city` STRING COMMENT 'City component of the brokers address.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the customs broker.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the customs broker.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the brokers location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the broker became an active partner.',
    `effective_until` DATE COMMENT 'Date when the broker relationship ends or is scheduled to end (null if ongoing).',
    `is_preferred` BOOLEAN COMMENT 'Indicates whether this broker is a preferred partner for the organization.',
    `customs_broker_name` STRING COMMENT 'Legal name of the customs brokerage organization.',
    `notes` STRING COMMENT 'Free‑form text for additional information or remarks about the broker.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the brokers address.',
    `rating` DECIMAL(18,2) COMMENT 'Average performance rating of the broker (scale 0.00‑5.00).',
    `registration_number` STRING COMMENT 'Official registration or license number issued to the broker.',
    `service_coverage_region` STRING COMMENT 'Geographic region(s) where the broker provides customs services.',
    `state` STRING COMMENT 'State or province component of the brokers address.',
    `customs_broker_status` STRING COMMENT 'Current operational status of the broker.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the broker record.',
    `website_url` STRING COMMENT 'Public website address of the customs broker.',
    CONSTRAINT pk_customs_broker PRIMARY KEY(`customs_broker_id`)
) COMMENT 'Master reference table for customs_broker. Referenced by customs_broker_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Primary key for vehicle',
    `depot_id` BIGINT COMMENT 'Identifier of the depot or hub where the vehicle is based.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver currently assigned to the vehicle.',
    `replaced_vehicle_id` BIGINT COMMENT 'Self-referencing FK on vehicle (replaced_vehicle_id)',
    `acquisition_date` DATE COMMENT 'Date the vehicle was purchased or otherwise acquired.',
    `capacity_kg` DECIMAL(18,2) COMMENT 'Maximum payload weight the vehicle is rated to carry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle record was first created in the system.',
    `current_value` DECIMAL(18,2) COMMENT 'Net book value of the vehicle after accumulated depreciation.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the vehicle over its useful life.',
    `dimensions_height_m` DECIMAL(18,2) COMMENT 'External height of the vehicle in metres.',
    `dimensions_length_m` DECIMAL(18,2) COMMENT 'External length of the vehicle in metres.',
    `dimensions_width_m` DECIMAL(18,2) COMMENT 'External width of the vehicle in metres.',
    `emission_standard` STRING COMMENT 'Regulatory emission classification applicable to the vehicle.',
    `emissions_kg_co2_per_km` DECIMAL(18,2) COMMENT 'Average carbon dioxide emissions per kilometre traveled.',
    `fuel_capacity_liters` DECIMAL(18,2) COMMENT 'Maximum volume of fuel the vehicle can hold.',
    `fuel_type` STRING COMMENT 'Primary energy source used by the vehicle.',
    `gps_device_code` STRING COMMENT 'Unique identifier of the telematics GPS unit installed on the vehicle.',
    `gps_last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent location transmission from the GPS device.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Most recent latitude coordinate reported by the GPS device.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Most recent longitude coordinate reported by the GPS device.',
    `insurance_expiry_date` DATE COMMENT 'Date the current insurance policy expires.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the vehicles insurance coverage.',
    `last_service_date` DATE COMMENT 'Date the vehicle most recently completed a scheduled service.',
    `license_plate` STRING COMMENT 'State‑issued license plate identifier displayed on the vehicle.',
    `maintenance_last_date` DATE COMMENT 'Date the vehicle most recently underwent maintenance.',
    `maintenance_next_due` DATE COMMENT 'Planned date for the next maintenance event.',
    `maintenance_status` STRING COMMENT 'Current status of scheduled maintenance activities.',
    `make` STRING COMMENT 'Manufacturer of the vehicle (e.g., Ford, Toyota).',
    `mileage_since_service_km` DECIMAL(18,2) COMMENT 'Distance traveled since the most recent service.',
    `model` STRING COMMENT 'Model designation of the vehicle (e.g., F‑150, Corolla).',
    `vehicle_name` STRING COMMENT 'Human‑readable name or designation of the vehicle used in operations and reporting.',
    `next_service_due` DATE COMMENT 'Planned date for the next routine service.',
    `odometer_km` DECIMAL(18,2) COMMENT 'Cumulative distance traveled by the vehicle in kilometres.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Initial cost paid to acquire the vehicle.',
    `registration_expiry_date` DATE COMMENT 'Date the vehicles registration registration expires.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the transport authority.',
    `vehicle_status` STRING COMMENT 'Current operational state of the vehicle.',
    `telematics_last_sync` TIMESTAMP COMMENT 'Timestamp of the most recent successful data sync from the telematics system.',
    `telematics_status` STRING COMMENT 'Current connectivity state of the vehicles telematics system.',
    `vehicle_type` STRING COMMENT 'Category of vehicle based on size and purpose.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vehicle record.',
    `vin` STRING COMMENT 'Globally unique 17‑character identifier for the vehicle chassis.',
    `year` STRING COMMENT 'Calendar year the vehicle was manufactured.',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Master reference table for vehicle. Referenced by vehicle_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`driver` (
    `driver_id` BIGINT COMMENT 'Primary key for driver',
    `supervisor_driver_id` BIGINT COMMENT 'Self-referencing FK on driver (supervisor_driver_id)',
    `address` STRING COMMENT 'Full residential address of the driver for routing and compliance.',
    `availability_status` STRING COMMENT 'Current availability of the driver for assignments.',
    `background_check_date` DATE COMMENT 'Date the background check was performed.',
    `background_check_status` STRING COMMENT 'Result of the driver’s background screening.',
    `certifications` STRING COMMENT 'Comma‑separated list of certifications held by the driver (e.g., HAZMAT, CDL).',
    `date_of_birth` DATE COMMENT 'Birth date of the driver for age verification and compliance.',
    `driver_license_class` STRING COMMENT 'Class of driver’s license indicating vehicle type eligibility.',
    `driver_status_reason` STRING COMMENT 'Free‑text explanation for the current status of the driver.',
    `driver_type` STRING COMMENT 'Classification of driver employment relationship.',
    `email` STRING COMMENT 'Primary email address used for driver communications.',
    `emergency_contact_name` STRING COMMENT 'Name of the driver’s emergency contact.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the driver’s emergency contact.',
    `hire_date` DATE COMMENT 'Date the driver was hired or onboarded.',
    `insurance_expiration` DATE COMMENT 'Expiration date of the driver’s insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the driver’s personal liability insurance.',
    `language_spoken` STRING COMMENT 'Languages the driver is proficient in, comma‑separated.',
    `license_expiration` DATE COMMENT 'Expiration date of the driver license.',
    `license_number` STRING COMMENT 'Government-issued driver license number.',
    `license_state` STRING COMMENT 'US state that issued the driver license. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `driver_name` STRING COMMENT 'Legal full name of the driver.',
    `payroll_status` STRING COMMENT 'Current payroll processing status for the driver.',
    `phone` STRING COMMENT 'Primary contact phone number for the driver.',
    `primary_contact_method` STRING COMMENT 'Preferred method for contacting the driver.',
    `rating` DECIMAL(18,2) COMMENT 'Average performance rating (0.00‑5.00) from post‑delivery feedback.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the driver record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the driver record.',
    `shift_preference` STRING COMMENT 'Driver’s preferred working shift.',
    `driver_status` STRING COMMENT 'Current lifecycle status of the driver.',
    `termination_date` DATE COMMENT 'Date the driver’s employment or contract ended, if applicable.',
    `total_miles_driven` DECIMAL(18,2) COMMENT 'Cumulative miles driven by the driver across all assignments.',
    `training_completed_date` DATE COMMENT 'Date the driver completed mandatory safety and compliance training.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle currently assigned to the driver.',
    CONSTRAINT pk_driver PRIMARY KEY(`driver_id`)
) COMMENT 'Master reference table for driver. Referenced by driver_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`depot` (
    `depot_id` BIGINT COMMENT 'Primary key for depot',
    `parent_depot_id` BIGINT COMMENT 'Self-referencing FK on depot (parent_depot_id)',
    `address_line1` STRING COMMENT 'Primary street address of the depot.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable storage area in square feet.',
    `city` STRING COMMENT 'City where the depot is located.',
    `closing_date` DATE COMMENT 'Date the depot ceased operations, if applicable.',
    `depot_code` STRING COMMENT 'External business code used to reference the depot in operational systems.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the depot.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the depot resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the depot record was first created in the system.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the depot location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the depot location.',
    `manager_email` STRING COMMENT 'Email address of the depot manager.',
    `manager_name` STRING COMMENT 'Name of the person responsible for depot operations.',
    `manager_phone` STRING COMMENT 'Contact phone number for the depot manager.',
    `depot_name` STRING COMMENT 'Human‑readable name of the depot.',
    `opening_date` DATE COMMENT 'Date the depot began operations.',
    `operational_hours` STRING COMMENT 'Standard daily operating window expressed as HH:mm‑HH:mm.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the depot address.',
    `region` STRING COMMENT 'Higher‑level region grouping (e.g., West Coast, EU Central).',
    `state` STRING COMMENT 'State or province of the depot location.',
    `depot_status` STRING COMMENT 'Current operational status of the depot.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the depot (e.g., America/Los_Angeles).',
    `depot_type` STRING COMMENT 'Category of the depot indicating its primary logistics function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the depot record.',
    CONSTRAINT pk_depot PRIMARY KEY(`depot_id`)
) COMMENT 'Master reference table for depot. Referenced by depot_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ADD CONSTRAINT `fk_logistics_carrier_service_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_route_id` FOREIGN KEY (`route_id`) REFERENCES `ecommerce_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_shipment_package_id` FOREIGN KEY (`shipment_package_id`) REFERENCES `ecommerce_ecm`.`logistics`.`shipment_package`(`shipment_package_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `ecommerce_ecm`.`logistics`.`driver`(`driver_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_route_id` FOREIGN KEY (`route_id`) REFERENCES `ecommerce_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `ecommerce_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `ecommerce_ecm`.`logistics`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ADD CONSTRAINT `fk_logistics_transport_cost_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ADD CONSTRAINT `fk_logistics_transport_cost_route_id` FOREIGN KEY (`route_id`) REFERENCES `ecommerce_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ADD CONSTRAINT `fk_logistics_delivery_zone_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ADD CONSTRAINT `fk_logistics_shipment_exception_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ADD CONSTRAINT `fk_logistics_transport_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` ADD CONSTRAINT `fk_logistics_carrier_tag_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ADD CONSTRAINT `fk_logistics_carrier_cost_center_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ADD CONSTRAINT `fk_logistics_customs_broker_parent_customs_broker_id` FOREIGN KEY (`parent_customs_broker_id`) REFERENCES `ecommerce_ecm`.`logistics`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `ecommerce_ecm`.`logistics`.`depot`(`depot_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `ecommerce_ecm`.`logistics`.`driver`(`driver_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_replaced_vehicle_id` FOREIGN KEY (`replaced_vehicle_id`) REFERENCES `ecommerce_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ADD CONSTRAINT `fk_logistics_driver_supervisor_driver_id` FOREIGN KEY (`supervisor_driver_id`) REFERENCES `ecommerce_ecm`.`logistics`.`driver`(`driver_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ADD CONSTRAINT `fk_logistics_depot_parent_depot_id` FOREIGN KEY (`parent_depot_id`) REFERENCES `ecommerce_ecm`.`logistics`.`depot`(`depot_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Logo Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Carrier Address Line 1');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Carrier Address Line 2');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Load Capacity (Tons)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_tier` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tier Classification');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'ftl|ltl|parcel|last_mile|cross_border');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Carrier City');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `compliance_ctpat` SET TAGS ('dbx_business_glossary_term' = 'C‑TPAT Certification');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `compliance_iata` SET TAGS ('dbx_business_glossary_term' = 'IATA Certification');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `compliance_wto` SET TAGS ('dbx_business_glossary_term' = 'WTO Compliance');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Carrier Country Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'DOT Registration Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `edi_integration_status` SET TAGS ('dbx_business_glossary_term' = 'EDI Integration Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `edi_integration_status` SET TAGS ('dbx_value_regex' = 'integrated|pending|none');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Audited Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `max_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Load Weight (Pounds)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Carrier Notes');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payment Terms');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepaid');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Postal Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rating Score');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `service_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Capabilities');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `sla_delivery_time_actual` SET TAGS ('dbx_business_glossary_term' = 'SLA Delivery Time Actual (Minutes)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `sla_delivery_time_target` SET TAGS ('dbx_business_glossary_term' = 'SLA Delivery Time Target (Minutes)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Carrier State/Province');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Carrier Website URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `base_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Rate (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `carrier_service_description` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `carrier_service_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `carrier_service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `cost_per_kg_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost per Kilogram (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `cost_per_mile_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost per Mile (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `customs_document_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Documentation Requirement Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `destination_zone` SET TAGS ('dbx_business_glossary_term' = 'Destination Zone');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `dimension_limit_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dimension (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `fuel_surcharge_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `is_express` SET TAGS ('dbx_business_glossary_term' = 'Express Service Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `level_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `max_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Height (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `max_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `max_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume (cubic meters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `max_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Width (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Notes');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `origin_zone` SET TAGS ('dbx_business_glossary_term' = 'Origin Zone');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Category');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'domestic|international|cross_border|regional|global');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'standard_ground|express|overnight|same_day|ltl|ftl');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `sla_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Transit Time (Days)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `surcharge_eligible` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `tracking_supported` SET TAGS ('dbx_business_glossary_term' = 'Tracking Support Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Days)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ALTER COLUMN `weight_limit_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'TMS Shipment ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_service_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipment Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customs_document_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customs_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customs_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Currency');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `delivery_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_business_glossary_term' = 'Destination Address');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `dimension_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `dimension_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `dimension_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `estimated_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ship Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `insurance_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `is_hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|delivered|exception|cancelled');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_business_glossary_term' = 'Origin Address');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_country` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `proof_of_delivery_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `route_optimization_reference` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'parcel|ftl|ltl');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipping_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Currency');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipping_cost_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Tax Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipping_cost_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Total Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `signature_required` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `barcode_image_url` SET TAGS ('dbx_business_glossary_term' = 'Barcode Image URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `customs_document_url` SET TAGS ('dbx_business_glossary_term' = 'Customs Document URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Declared Value (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `delivery_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Height (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `insurance_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `is_return` SET TAGS ('dbx_business_glossary_term' = 'Return Package Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `label_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Generation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `label_url` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Length (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'box|pallet|envelope|crate');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Package Quantity');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Package Sequence Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `shipment_package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `shipment_package_status` SET TAGS ('dbx_value_regex' = 'in_transit|delivered|exception|pending|lost');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `signature_required` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Tracking URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Package Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Width (cm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Unit Value');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Classification');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `hs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `line_value` SET TAGS ('dbx_business_glossary_term' = 'Line Total Value');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Restricted Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|delivered|returned|canceled');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `carrier_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Facility Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `delivery_attempt_outcome` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Outcome');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `delivery_attempt_outcome` SET TAGS ('dbx_value_regex' = 'success|failed|no_answer|refused|rescheduled');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `delivery_attempt_sequence` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Sequence');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|processed|error');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Event Type Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_value_regex' = 'pickup|in_transit|out_for_delivery|delivery_attempt|exception|proof_of_delivery');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_type_description` SET TAGS ('dbx_business_glossary_term' = 'Event Type Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_value_regex' = 'address_correction|customs_hold|damage|carrier_delay|other');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Action');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Exception Responsible Party');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_responsible_party` SET TAGS ('dbx_value_regex' = 'carrier|sender|receiver|customs');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `proof_of_delivery_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Proof‑of‑Delivery Photo URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `proof_of_delivery_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Proof‑of‑Delivery Recipient Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `proof_of_delivery_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `proof_of_delivery_recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `proof_of_delivery_signature_url` SET TAGS ('dbx_business_glossary_term' = 'Proof‑of‑Delivery Signature URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof‑of‑Delivery Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `raw_event_description` SET TAGS ('dbx_business_glossary_term' = 'Raw Event Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `reattempt_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Re‑attempt Scheduled Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `scan_location` SET TAGS ('dbx_business_glossary_term' = 'Scan Location');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Map Image Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `average_cost_per_mile` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Mile');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `average_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Average Transit Days');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `corridor_type` SET TAGS ('dbx_business_glossary_term' = 'Corridor Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `corridor_type` SET TAGS ('dbx_value_regex' = 'last-mile|linehaul|cross-dock|domestic|international|cross-border');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Route Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `customs_document_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Required');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Tariff Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `destination_hub_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Hub Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `estimated_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Estimated Distance (KM)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `estimated_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Days');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `lane_volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Lane Volume Tier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `lane_volume_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `last_mile_type` SET TAGS ('dbx_business_glossary_term' = 'Last‑Mile Delivery Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `last_mile_type` SET TAGS ('dbx_value_regex' = 'door_to_door|locker|pickup_point');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `max_load_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Load Weight (Tons)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `max_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Maximum Load Volume (Cubic Meters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `optimization_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Algorithm Version');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `origin_hub_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Hub Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Route Owner Department');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Route Risk Level');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `route_description` SET TAGS ('dbx_business_glossary_term' = 'Route Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `stop_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Route Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `vehicle_type_requirement` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type Requirement');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `vehicle_type_requirement` SET TAGS ('dbx_value_regex' = 'truck|van|bike|drone|container');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `route_stop_id` SET TAGS ('dbx_business_glossary_term' = 'Route Stop Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `driver_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `driver_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `pod_document_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Document ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑3)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `customs_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `customs_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|held');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (Liters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `is_last_stop` SET TAGS ('dbx_business_glossary_term' = 'Is Last Stop Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Degrees)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Degrees)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Stop Notes');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `odometer_reading_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (Kilometers)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `scheduled_arrival_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Window End');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `scheduled_arrival_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Window Start');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `scheduled_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `signature_image_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Duration (Minutes)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Duration (Minutes)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `stop_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_business_glossary_term' = 'Stop Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|exception|canceled');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_business_glossary_term' = 'Stop Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_value_regex' = 'pickup|delivery|cross_dock|return|other');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `time_on_site_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time On Site (Minutes)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Route Stop Record Version');
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'transport_planning');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `primary_freight_center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `agreed_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Rate Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number (BOL)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Acceptance Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_rate_type` SET TAGS ('dbx_value_regex' = 'spot|contract|negotiated');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rejection Reason');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_response_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Response Deadline Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `delivery_appointment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Appointment Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'dry_van|reefer|flatbed|container|tanker');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|in_transit|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_type` SET TAGS ('dbx_value_regex' = 'tender|contract|spot');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'FTL|LTL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_value_regex' = 'road|rail|air|sea');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number (FON)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `pickup_appointment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pickup Appointment Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Shipment Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `shipping_terms` SET TAGS ('dbx_business_glossary_term' = 'Shipping Terms (Incoterms)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `shipping_terms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|CPT|DAP|DDP');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `tender_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freight Tender Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Charge Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (m³)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'm3|ft3');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'kg|lb');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` SET TAGS ('dbx_subdomain' = 'transport_planning');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|rejected|under_review');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|cancelled|archived');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Declaration Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Goods Value');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `destination_port_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Port Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `duties_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duties Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `ead_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Advance Declaration Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `exporting_country_code` SET TAGS ('dbx_business_glossary_term' = 'Exporting Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `exporting_country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `hs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `importing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Importing Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `importing_country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `inspection_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Hold Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `origin_port_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Port Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'box|pallet|crate|bag|drum');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `pre_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Clearance Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `taxes_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Taxes Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Customs Charges');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail|parcel');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (cubic meters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` SET TAGS ('dbx_subdomain' = 'transport_planning');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `transport_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Cost ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'billed|unbilled|pending|rejected');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_allocation_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Center');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'base_freight|fuel_surcharge|residential_surcharge|dimensional_weight|accessorial|other');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_source` SET TAGS ('dbx_business_glossary_term' = 'Cost Source');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_source` SET TAGS ('dbx_value_regex' = 'system|manual|partner');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'actual|estimated');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `customs_document_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `customs_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `delivery_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance (km)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `is_late_delivery` SET TAGS ('dbx_business_glossary_term' = 'Late Delivery Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail|intermodal');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `payment_term` SET TAGS ('dbx_business_glossary_term' = 'Payment Term');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `payment_term` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepaid');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight|economy');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `transport_cost_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `transport_cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `transport_cost_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|void');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (cbm)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Card ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `accessorial_charges_included` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Included');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `accessorial_charges_included` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `accessorial_rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Rate Schedule');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate (Currency per kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_rate_card_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master|spot|contract');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `fuel_surcharge_pct` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `is_accessorial_applicable` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Applicable');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `is_fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `lane_destination` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `lane_origin` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `lane_type` SET TAGS ('dbx_value_regex' = 'domestic|international');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `negotiation_reference` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Reference');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `rate_card_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Category');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `rate_card_source_system` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Source System');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `service_level_code` SET TAGS ('dbx_value_regex' = 'standard|express|overnight');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `service_level_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `weight_tier_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Tier Maximum (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `weight_tier_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Tier Minimum (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `carrier_zone_mapping` SET TAGS ('dbx_business_glossary_term' = 'Carrier Zone Mapping');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `cost_per_shipment` SET TAGS ('dbx_business_glossary_term' = 'Base Cost Per Shipment');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|DEU|FRA');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `delivery_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery SLA (Days)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `delivery_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Time');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `delivery_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Time');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `delivery_zone_description` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `delivery_zone_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `delivery_zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Zone Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `is_express_available` SET TAGS ('dbx_business_glossary_term' = 'Express Service Availability Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `max_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume (cubic meters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `postal_code_range` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `postal_code_range` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `postal_code_range` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region / State / Province');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `requires_signature` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `surcharge_remote_area` SET TAGS ('dbx_business_glossary_term' = 'Remote Area Surcharge Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `surcharge_residential` SET TAGS ('dbx_business_glossary_term' = 'Residential Surcharge Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `zone_tier` SET TAGS ('dbx_business_glossary_term' = 'Zone Tier Classification');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ALTER COLUMN `zone_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `shipment_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Exception ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Help Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'address_correction|delivery_failure|damaged_goods|customs_hold|carrier_delay|other');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Exception Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Exception Priority');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'address_updated|re_dispatch|refund|hold|escalated|other');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'carrier|customer|seller|warehouse');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `shipment_exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `shipment_exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment ID (RS_ID)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier (DFI)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Shipment Identifier (OSI)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization Identifier (RMA)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp (ADT)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status (CCS)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `condition_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Flag (CAF)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Return Flag (CBF)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CUR)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `customs_document_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Number (CDN)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date (EDD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (HGT_CM)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount (IA)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `insurance_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Flag (ICF)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `is_expedited_return` SET TAGS ('dbx_business_glossary_term' = 'Expedited Return Flag (ERF)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `label_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Label Generation Timestamp (RLGT)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (LEN_CM)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Notes (RSN)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount (RA)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method (RFM)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original|store_credit|gift_card');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status (RS)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Initiated Timestamp (RIT)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method (RM)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'pickup|dropoff|carrier_pickup');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code (RRC)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defective|wrong_item|size_issue|other');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Number (RSN)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Status (RSS)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_shipment_status` SET TAGS ('dbx_value_regex' = 'initiated|in_transit|delivered|closed|cancelled');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number (RTN)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (WT_KG)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (WID_CM)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` SET TAGS ('dbx_subdomain' = 'transport_planning');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `transport_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Lane Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `primary_transport_center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Active Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `average_load_factor_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Load Factor (%)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `average_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Average Transit Days');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `compliance_ctpat` SET TAGS ('dbx_business_glossary_term' = 'CTPAT Compliance Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `compliance_ctpat` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `compliance_wto` SET TAGS ('dbx_business_glossary_term' = 'WTO Compliance Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `compliance_wto` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `cost_per_mile_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mile (USD)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `customs_documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Documentation Required');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_category` SET TAGS ('dbx_business_glossary_term' = 'Lane Category');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_category` SET TAGS ('dbx_value_regex' = 'full_truck_load|less_than_truck_load|parcel');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_business_glossary_term' = 'Lane Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_business_glossary_term' = 'Lane Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_value_regex' = 'domestic|international|cross_border');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Lane Volume Tier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `lane_volume_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `max_volume_cubic_ft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume (cubic ft)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `max_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight (lbs)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lane Notes');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `route_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `sla_delivery_time_actual_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Delivery Time Actual (days)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `sla_delivery_time_target_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Delivery Time Target (days)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending|draft');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `compliance_ctpat` SET TAGS ('dbx_business_glossary_term' = 'CTPAT Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `compliance_iata` SET TAGS ('dbx_business_glossary_term' = 'IATA Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `compliance_wto` SET TAGS ('dbx_business_glossary_term' = 'WTO Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'domestic|international');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Email');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Name');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Phone');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_region` SET TAGS ('dbx_business_glossary_term' = 'Contract Region');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_region` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Change Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master|spot|dedicated');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contracted_volume` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Carrier Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `is_preferred` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net30|Net45|Net60');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Reference');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `sla_delivery_time_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Delivery Time Actual (Hours)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `sla_delivery_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Delivery Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'tons|cubic_meters|pallets');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` SET TAGS ('dbx_association_edges' = 'logistics.carrier,content.tag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` ALTER COLUMN `carrier_tag_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tag Assignment - Carrier Tag Assignment Id');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tag Assignment - Carrier Id');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` ALTER COLUMN `tag_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tag Assignment - Tag Id');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Tag Confidence Score');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` SET TAGS ('dbx_association_edges' = 'logistics.carrier,finance.cost_center');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `carrier_cost_center_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Cost Center Contract - Carrier Cost Center Contract Id');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Cost Center Contract - Carrier Id');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Cost Center Contract - Cost Center Id');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Reference');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` SET TAGS ('dbx_subdomain' = 'transport_planning');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `parent_customs_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` ALTER COLUMN `replaced_vehicle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `supervisor_driver_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`driver` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `parent_depot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`depot` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
