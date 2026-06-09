-- Schema for Domain: logistics | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`logistics` COMMENT 'Owns transportation planning and carrier execution across the supply chain. Manages last-mile delivery, carrier selection, route optimization, FTL/LTL shipment planning, shipment tracking, delivery confirmation, EDI carrier integrations, cross-border WTO-compliant customs documentation, and transportation cost management. Integrates with TMS for real-time tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'System-generated unique identifier for the carrier record.',
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
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Carrier invoices for each shipment are processed through AP. Linking logistics_shipment to accounts_payable enables freight invoice 3-way matching (shipment vs. carrier invoice vs. rate card), a stand',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed for Marketing ROI attribution linking each shipment to the campaign that generated the order, enabling shipment‑level performance reporting.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: A logistics shipment is executed under a specific carrier contract that governs the commercial terms, SLAs, and rates. Linking logistics_shipment to carrier_contract enables contract compliance monito',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link logistics_shipment to carrier for carrier ownership; carrier_name string becomes redundant.',
    `carrier_rate_card_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_rate_card. Business justification: A logistics shipment is priced using a specific carrier rate card at the time of booking. Linking logistics_shipment to carrier_rate_card enables shipping cost reconciliation (actual cost vs. contract',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: A logistics shipment is executed using exactly one carrier service (e.g., FedEx Ground, UPS Express). logistics_shipment currently stores carrier_service_code (STRING) and service_level (STRING) as de',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for internal accounting: allocate each shipments cost to a cost center for expense reporting and profitability analysis.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Required for shipment fulfillment reports linking each shipment to the customers shipping address used for origin, enabling address‑level delivery performance analysis.',
    `delivery_zone_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_zone. Business justification: A logistics shipment is assigned to a delivery zone for carrier routing, SLA determination, and rate calculation. delivery_zone defines geographic zones with SLA days, delivery windows, and surcharge ',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the shipment in the Transportation Management System.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Inbound Shipment Receipt Matching report ties each shipment to the Goods Receipt that records quantity received in the warehouse.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Linking shipments to the originating order is essential for order‑to‑shipment tracking reports and customer service dashboards.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller shipment performance reporting, SLA compliance tracking per seller, and shipping cost attribution require direct seller identification on each shipment. Marketplace operations track late shipme',
    `actual_delivery_date` DATE COMMENT 'Date the shipment was delivered to the recipient.',
    `actual_ship_date` DATE COMMENT 'Date the shipment actually left the origin.',
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
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: In multi-package shipments, individual packages may use different carrier service levels (e.g., one package express, another standard). shipment_package has carrier_service_level (STRING) as a denorma',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the primary product contained in the package.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: shipment_package is a child entity of logistics_shipment — a single shipment may contain multiple packages (cartons). Currently shipment_package has no FK to logistics_shipment, only to fulfillment.fu',
    `actual_delivery_date` DATE COMMENT 'Date on which the package was actually delivered.',
    `barcode_image_url` STRING COMMENT 'Link to the barcode image used on the package label.',
    `carrier_code` STRING COMMENT 'Standard code representing the shipping carrier (e.g., UPS, FedEx).',
    `carrier_name` STRING COMMENT 'Human‑readable name of the shipping carrier.',
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
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Shipment-level SKU traceability is required for hazmat compliance checks, export control classification, returns processing, and carrier audit reconciliation. E-commerce logistics experts expect shipm',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: shipment_item carries hs_tariff_code, export_control_classification, and hazmat_classification — item-level attributes that determine customs duty and import tax calculations stored in tax_record. Cro',
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
    `length_cm` DECIMAL(18,2) COMMENT 'Physical length of the item in centimeters.',
    `line_sequence` STRING COMMENT 'Sequential number of the line item within the shipment for ordering.',
    `line_value` DECIMAL(18,2) COMMENT 'Total monetary value for the line (quantity × declared unit value).',
    `quantity` BIGINT COMMENT 'Number of units of the SKU shipped in this line.',
    `restricted_flag` BOOLEAN COMMENT 'True if the item is subject to export restrictions.',
    `shipment_item_status` STRING COMMENT 'Current processing status of the shipment line item.. Valid values are `pending|in_transit|delivered|returned|canceled`',
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
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: tracking_event records all shipment lifecycle events (EDI 214, carrier integrations). Each tracking event belongs to a specific logistics shipment. Currently tracking_event only has carrier_id FK — th',
    `shipment_package_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_package. Business justification: In e-commerce multi-package shipments, each package has its own tracking number and generates its own tracking events. tracking_event needs a package-level FK to support package-granularity event trac',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` (
    `carrier_rate_card_id` BIGINT COMMENT 'Unique system-generated identifier for the carrier rate card record.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Rate cards are negotiated and governed under carrier contracts. carrier_rate_card has negotiation_reference (STRING) and rate_card_reference (STRING on carrier_contract) as loose text references. Addi',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier organization that owns this rate card.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: A carrier rate card defines contracted rates for a specific carrier service (e.g., FedEx Ground rates for lane X). carrier_rate_card currently stores service_level_code (STRING) and service_level_desc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate‑card charges are allocated to cost centers for chargeback and profitability reporting.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Carrier rate cards drive freight cost postings to specific GL freight expense accounts. Finance teams reconcile carrier spend against GL during period-end close. Rate card charges must map to GL accou',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: In e-commerce, carrier rate cards map to customer-facing price lists for shipping fee pass-through at checkout. This link enables shipping cost pricing reports, dynamic shipping fee calculation by zon',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` (
    `carrier_contract_id` BIGINT COMMENT 'System-generated unique identifier for each carrier contract record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to seller.seller_agreement. Business justification: When a platform negotiates a carrier contract on behalf of a seller, the carrier contract must reference the seller agreement governing shipping obligations, SLA commitments, and termination condition',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier entity associated with this contract.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carrier contracts are budgeted to specific cost centers; this FK supports cost‑center level budgeting and variance tracking.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Contract expenses must be posted to a GL account; linking contracts to general_ledger enables accurate financial statements.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Carrier contracts are executed by specific legal entities — critical for intercompany logistics arrangements, regulatory compliance (CTPAT, IATA, WTO), and multi-entity e-commerce operations. Legal en',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ADD CONSTRAINT `fk_logistics_carrier_service_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_rate_card_id` FOREIGN KEY (`carrier_rate_card_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_rate_card`(`carrier_rate_card_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ADD CONSTRAINT `fk_logistics_shipment_package_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ADD CONSTRAINT `fk_logistics_shipment_package_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_shipment_package_id` FOREIGN KEY (`shipment_package_id`) REFERENCES `ecommerce_ecm`.`logistics`.`shipment_package`(`shipment_package_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_shipment_package_id` FOREIGN KEY (`shipment_package_id`) REFERENCES `ecommerce_ecm`.`logistics`.`shipment_package`(`shipment_package_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ADD CONSTRAINT `fk_logistics_delivery_zone_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
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
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Card Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'TMS Shipment ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
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
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `barcode_image_url` SET TAGS ('dbx_business_glossary_term' = 'Barcode Image URL');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
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
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `line_value` SET TAGS ('dbx_business_glossary_term' = 'Line Total Value');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Restricted Flag');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Status');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|delivered|returned|canceled');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` SET TAGS ('dbx_subdomain' = 'shipment_tracking');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`tracking_event` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Card ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `weight_tier_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Tier Maximum (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ALTER COLUMN `weight_tier_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Tier Minimum (kg)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` SET TAGS ('dbx_subdomain' = 'carrier_management');
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
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Agreement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
