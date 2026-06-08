-- Schema for Domain: shipment | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`shipment` COMMENT 'Core operational domain managing end-to-end shipment lifecycle from booking through delivery across express parcel, freight, and cross-border movements. Owns shipment identity, tracking events, POD/ePOD, ETA/ETD milestones, exception management, and AWB/BOL/HAWB/MAWB document references. Serves as the transactional backbone integrating TMS, FourKites visibility, and carrier execution data for D2D services.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`consignment` (
    `consignment_id` BIGINT COMMENT 'Unique identifier for the consignment record. Primary key for the consignment entity representing a shipment booking from origin to destination.',
    `consignee_profile_id` BIGINT COMMENT 'Reference to the consignee profile entity representing the receiver of this consignment.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that booked or is responsible for this consignment.',
    `freight_order_id` BIGINT COMMENT 'FK to freight.freight_order.freight_order_id — MUST-HAVE: Enables tracing any shipment/consignment back to its originating freight booking/order. Required for end-to-end shipment visibility, freight cost allocation, and operational reconciliation ',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Rating engine applies rate cards to consignments based on service type, origin/destination zones, weight breaks, and service level. Essential for automated pricing, quote generation, and revenue calcu',
    `shipper_profile_id` BIGINT COMMENT 'Reference to the shipper profile entity representing the sender of this consignment.',
    `awb_number` STRING COMMENT 'The unique air waybill number assigned to this consignment for air freight shipments. Format: 3-digit airline prefix followed by 8-digit serial number.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'The bill of lading number for ocean or ground freight shipments. Serves as the contract of carriage and receipt of goods.',
    `booking_channel` STRING COMMENT 'The channel through which the consignment was booked: web portal, mobile app, API integration, EDI, call center, branch office, or partner system. [ENUM-REF-CANDIDATE: web_portal|mobile_app|api|edi|call_center|branch|partner — 7 candidates stripped; promote to reference product]',
    `booking_date` DATE COMMENT 'The date when the consignment was booked by the customer or shipper.',
    `booking_reference` STRING COMMENT 'The customer-facing booking reference or tracking number provided at the time of shipment booking.',
    `booking_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consignment booking was created in the system.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The weight used for freight charge calculation, which is the greater of declared weight or volumetric weight.',
    `cod_amount` DECIMAL(18,2) COMMENT 'The amount to be collected from the consignee upon delivery if COD service is enabled.',
    `cod_currency_code` STRING COMMENT 'The three-letter ISO currency code for the COD amount.. Valid values are `^[A-Z]{3}$`',
    `committed_delivery_date` DATE COMMENT 'The date by which delivery is committed to the customer per the service level agreement.',
    `committed_delivery_time` TIMESTAMP COMMENT 'The precise date and time by which delivery is committed to the customer per the service level agreement.',
    `commodity_description` STRING COMMENT 'A textual description of the goods or commodities being shipped in this consignment.',
    `consignee_contact_phone` STRING COMMENT 'The contact phone number for the consignee or receiver.',
    `consignee_name` STRING COMMENT 'The full name of the consignee or receiver of the consignment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this consignment record was first created in the system.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'The declared value of the goods in the consignment for insurance and customs purposes.',
    `declared_value_currency_code` STRING COMMENT 'The three-letter ISO currency code for the declared value amount.. Valid values are `^[A-Z]{3}$`',
    `declared_weight_kg` DECIMAL(18,2) COMMENT 'The actual or declared gross weight of the consignment in kilograms as provided by the shipper.',
    `delivery_instruction_type` STRING COMMENT 'The type of special delivery instruction provided by the customer (e.g., signature required, leave at door, call before delivery, safe place).',
    `delivery_time_window_end` TIMESTAMP COMMENT 'The end of the preferred delivery time window specified by the customer or consignee.',
    `delivery_time_window_start` TIMESTAMP COMMENT 'The start of the preferred delivery time window specified by the customer or consignee.',
    `destination_address_line1` STRING COMMENT 'The first line of the delivery or destination address for the consignment.',
    `destination_city` STRING COMMENT 'The city or municipality of the consignment destination location.',
    `destination_country_code` STRING COMMENT 'The three-letter ISO country code for the consignment destination country.. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code` STRING COMMENT 'The postal or ZIP code of the consignment destination location.',
    `hawb_number` STRING COMMENT 'House air waybill number issued by freight forwarders for consolidated shipments under a master air waybill.',
    `hs_code` STRING COMMENT 'The Harmonized System tariff classification code for the primary commodity in the consignment, used for customs and trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'The Incoterms code defining the responsibilities, costs, and risks between buyer and seller for this consignment (e.g., EXW, FOB, CIF, DDP, DAP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_cod` BOOLEAN COMMENT 'Indicates whether this consignment requires cash on delivery payment collection from the consignee.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Indicates whether the consignment contains dangerous goods or hazardous materials requiring special handling.',
    `is_otd_target` BOOLEAN COMMENT 'Indicates whether this consignment is included in on-time delivery performance measurement and reporting.',
    `is_otif_target` BOOLEAN COMMENT 'Indicates whether this consignment is included in on-time in-full performance measurement and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this consignment record was last updated or modified in the system.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the consignment from booking through final delivery or cancellation. [ENUM-REF-CANDIDATE: booked|confirmed|in_transit|out_for_delivery|delivered|cancelled|returned|exception — 8 candidates stripped; promote to reference product]',
    `mawb_number` STRING COMMENT 'Master air waybill number issued by the airline for consolidated shipments containing multiple house air waybills.',
    `number_of_pieces` STRING COMMENT 'The total number of individual pieces, packages, or handling units in the consignment.',
    `origin_address_line1` STRING COMMENT 'The first line of the pickup or origin address for the consignment.',
    `origin_city` STRING COMMENT 'The city or municipality of the consignment origin location.',
    `origin_country_code` STRING COMMENT 'The three-letter ISO country code for the consignment origin country.. Valid values are `^[A-Z]{3}$`',
    `origin_postal_code` STRING COMMENT 'The postal or ZIP code of the consignment origin location.',
    `priority_level` STRING COMMENT 'The priority level assigned to the consignment for operational handling and resource allocation.. Valid values are `standard|high|urgent|critical`',
    `service_level` STRING COMMENT 'The specific service level or product offering selected by the customer (e.g., next-day, two-day, economy, priority, same-day).',
    `service_type` STRING COMMENT 'The type of logistics service provided for this consignment: express parcel delivery, air freight, ocean freight, road freight, rail freight, or cross-border shipping.. Valid values are `express_parcel|air_freight|ocean_freight|road_freight|rail_freight|cross_border`',
    `shipper_contact_phone` STRING COMMENT 'The contact phone number for the shipper or sender.',
    `shipper_name` STRING COMMENT 'The full name of the shipper or sender of the consignment.',
    `sla_source` STRING COMMENT 'The source of the service level commitment: customer contract, published rate card, spot booking, or standard terms.. Valid values are `customer_contract|rate_card|spot_booking|standard_terms`',
    `special_handling_notes` STRING COMMENT 'Free-text notes describing any special handling requirements, access instructions, or delivery preferences for the consignment.',
    `transit_time_days` STRING COMMENT 'The committed or expected transit time for the consignment from origin to destination, measured in days.',
    `un_number` STRING COMMENT 'The four-digit UN number identifying the dangerous goods classification if the consignment contains hazardous materials.. Valid values are `^UN[0-9]{4}$`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'The total volume of the consignment measured in cubic meters.',
    `volumetric_weight_kg` DECIMAL(18,2) COMMENT 'The dimensional or volumetric weight calculated based on the consignment dimensions, used for pricing when it exceeds actual weight.',
    CONSTRAINT pk_consignment PRIMARY KEY(`consignment_id`)
) COMMENT 'Core master entity representing a shipment booking/consignment record — the primary business object in the shipment domain. Captures the full lifecycle identity of a shipment from booking through final delivery, including service type (express parcel, freight, cross-border), origin/destination, declared weight, volumetric/DIM weight, CBM, number of pieces, incoterms code, COD flag, DDP/DAP/FOB terms, booking channel, booking date, committed SLA type, committed delivery date, transit time commitment, SLA source (customer contract/rate card/spot booking), priority level, delivery instructions (instruction type, preferred time window, special access notes, safe place, alternative address, contact phone), current lifecycle status, and OTD/OTIF target. Serves as the anchor entity integrating SAP TM freight orders, Oracle TMS shipment execution records, and FourKites visibility events. SSOT for shipment identity and service commitment across the enterprise.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` (
    `shipment_leg_id` BIGINT COMMENT 'Unique identifier for the shipment leg. Primary key for this entity representing a single transport segment within a multi-leg shipment journey.',
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: Each leg incurs carrier buy costs determined by carrier agreement, mode, lane, and weight. Critical for cost allocation, margin analysis, carrier invoice reconciliation, and profitability reporting at',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Shipment legs are operated by specific carriers - fundamental to transport execution, routing decisions, performance tracking, and carrier invoice reconciliation. Normalizes carrier_scac_code/carrier_',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment that this leg belongs to. Links this transport segment to the overall end-to-end shipment journey.',
    `agent_id` BIGINT COMMENT 'Reference to the delivery agent or driver assigned to execute this leg. Primarily used for last-mile delivery legs to track individual courier performance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Road transport legs require assigned driver tracking for HOS compliance (FMCSA regulations), driver performance metrics, route optimization, and DOT audit trails. Essential for fleet operations and sa',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Each shipment leg executes on a specific network lane defining the origin-destination pair, service level, and routing. Essential for dispatcher lane assignment, lane-level performance measurement, ca',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Shipment legs originate from specific hub/gateway facilities - essential for network planning, capacity management, sort operations, and transit time calculations. Origin_location_code maps to hub inf',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment arrived at the destination location for this leg. Captured from carrier EDI, GPS tracking, or manual gate-in events.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment departed from the origin location for this leg. Captured from carrier EDI, GPS tracking, or manual gate-out events.',
    `booking_reference_number` STRING COMMENT 'Carrier-issued booking confirmation number for this leg. Links to the carriers reservation system for capacity allocation and schedule confirmation.',
    `carbon_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide equivalent emissions for this leg measured in kilograms. Calculated based on transport mode, distance, and fuel type for sustainability reporting.',
    `container_number` STRING COMMENT 'Unique identifier for the shipping container used on this leg. Follows ISO 6346 format with four-letter owner code and seven-digit serial number. Applicable for ocean and intermodal legs.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this transport leg including carrier charges, fuel surcharges, and accessorial fees. Used for freight cost allocation and profitability analysis.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the leg cost amount. Enables multi-currency cost tracking and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this leg record was first created in the system. Audit field for data lineage and compliance tracking.',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether this leg crosses an international border requiring customs clearance. True for cross-border legs.',
    `delay_duration_minutes` STRING COMMENT 'Total delay time in minutes calculated as the difference between planned and actual timestamps. Used for SLA breach detection and performance reporting.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the root cause of any delay on this leg (e.g., weather, traffic, mechanical failure, customs hold). Used for exception management and carrier performance analysis.',
    `delivery_attempt_number` STRING COMMENT 'Count of delivery attempts made for this leg. Increments with each failed delivery attempt. Used for last-mile legs to track delivery success rates and customer availability.',
    `destination_location_code` STRING COMMENT 'Standardized code identifying the arrival location for this leg. May be UN/LOCODE for ports/terminals, IATA code for airports, or internal facility code for warehouses.. Valid values are `^[A-Z]{3,5}$`',
    `dispatch_sequence_number` STRING COMMENT 'Order of this delivery within the drivers daily dispatch route. Used for last-mile legs to optimize delivery sequence and track route adherence.',
    `distance_km` DECIMAL(18,2) COMMENT 'Planned or actual distance traveled for this leg measured in kilometers. Used for cost calculation, carbon footprint estimation, and performance analytics.',
    `equipment_type_code` STRING COMMENT 'Code identifying the type of transport equipment used (e.g., 20ft container, 40ft reefer, flatbed truck, pallet). Follows ISO 6346 for containers or internal classification for other equipment.',
    `eta_prediction_source` STRING COMMENT 'System or method that generated the predicted ETA. Identifies whether the prediction came from FourKites AI engine, carrier EDI feed, manual operator input, TMS route calculation, GPS tracking, or IoT sensor data.. Valid values are `fourkites_ai|carrier_edi|manual_estimate|tms_calculation|gps_tracking|iot_sensor`',
    `flight_number` STRING COMMENT 'Commercial flight number for air freight legs. Combines carrier code and flight number (e.g., AA1234, LH456).. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `gps_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether real-time GPS tracking is active for this leg. True when vehicle/container has active GPS device transmitting location data.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this leg transports dangerous goods requiring special handling per IMDG Code or ICAO Technical Instructions. True for hazmat shipments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this leg record was last modified. Audit field for change tracking and data quality monitoring.',
    `leg_status` STRING COMMENT 'Current operational status of this transport leg. Tracks the lifecycle state from planning through completion or cancellation.. Valid values are `planned|in_transit|completed|delayed|cancelled|failed`',
    `origin_location_code` STRING COMMENT 'Standardized code identifying the departure location for this leg. May be UN/LOCODE for ports/terminals, IATA code for airports, or internal facility code for warehouses.. Valid values are `^[A-Z]{3,5}$`',
    `planned_arrival_timestamp` TIMESTAMP COMMENT 'Scheduled arrival date and time for this leg as planned at booking or route optimization. Represents the original ETA before any real-time adjustments.',
    `planned_departure_timestamp` TIMESTAMP COMMENT 'Scheduled departure date and time for this leg as planned at booking or route optimization. Represents the original ETD before any real-time adjustments.',
    `predicted_eta_confidence_score` DECIMAL(18,2) COMMENT 'Confidence level of the predicted ETA expressed as a percentage (0.00 to 100.00). Higher scores indicate greater certainty in the prediction based on data quality and model accuracy.',
    `predicted_eta_timestamp` TIMESTAMP COMMENT 'Real-time predicted arrival timestamp generated by AI/ML models or carrier systems. Updated dynamically based on current location, traffic, weather, and historical patterns.',
    `seal_number` STRING COMMENT 'Unique identifier for the security seal applied to the container or trailer. Used for cargo security verification and customs compliance.',
    `sequence_number` STRING COMMENT 'Sequential order of this leg within the shipment journey. Indicates the position in the multi-leg route (e.g., 1 for first-mile pickup, 2 for origin hub, 3 for linehaul, 4 for destination hub, 5 for last-mile delivery).',
    `service_level_code` STRING COMMENT 'Code representing the service level commitment for this leg (e.g., express, standard, economy). Links to SLA definitions and performance targets.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system that created or last updated this leg record. Indicates data provenance from SAP TM, Oracle TMS, FourKites, carrier EDI, or manual entry.. Valid values are `sap_tm|oracle_tms|fourkites|carrier_edi|manual_entry`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this leg requires temperature-controlled transport (reefer container, refrigerated truck). True for cold chain shipments.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for real-time shipment visibility on this leg. Used for customer self-service tracking and exception alerts.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for this leg. Indicates whether the shipment moves by air, ocean, road, rail, or a combination of modes.. Valid values are `air|ocean|road|rail|multimodal|courier`',
    `vehicle_reference_number` STRING COMMENT 'Identifier for the vehicle, vessel, aircraft, or rail car used for this leg. May be truck license plate, vessel IMO number, aircraft tail number, or rail car number.',
    `voyage_number` STRING COMMENT 'Unique identifier for the ocean vessel voyage. Used for ocean freight legs to track specific sailing schedules.',
    CONSTRAINT pk_shipment_leg PRIMARY KEY(`shipment_leg_id`)
) COMMENT 'Represents an individual transport leg within a multi-leg shipment journey, including ETA/ETD milestone predictions and last-mile dispatch details. Each consignment may traverse multiple legs (e.g., first-mile pickup → origin hub → linehaul → destination hub → last-mile delivery). Captures leg sequence number, transport mode (air/ocean/road/rail), carrier SCAC/IATA code, origin and destination location codes, planned and actual departure/arrival timestamps (ETD/ETA), predicted ETA with confidence score and prediction source (FourKites AI/carrier EDI/manual), vehicle/vessel/flight reference, leg status, distance, delivery agent ID (for last-mile legs), route code, dispatch sequence, and delivery attempt number. Enables end-to-end route visibility, SLA milestone tracking per leg, ETA prediction, and last-mile delivery performance measurement. Sourced from SAP TM route segments, Oracle TMS load plans, and FourKites predictive ETA engine.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` (
    `tracking_event_id` BIGINT COMMENT 'Unique identifier for the tracking event record. Primary key. Immutable once assigned.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment this tracking event belongs to. Links event to parent shipment entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee, driver, or system operator who performed or recorded the event. Used for labor tracking and accountability. Nullable for automated system events.',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Tracking events occur at hub/gateway facilities during transit - critical for real-time visibility, dwell time analysis, hub performance metrics, and exception management. Facility_code maps to hub_ga',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Tracking events occur during specific transport legs of a shipments journey. Adding shipment_leg_id allows precise attribution of scan events to transport segments (e.g., departed origin is end of ',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the vehicle, truck, aircraft, or vessel involved in the event. Used for fleet management and route optimization. Nullable for stationary hub events.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time of final delivery to consignee. Only populated for DELIVERED event types. Used for OTD (On-Time Delivery) and OTIF (On-Time In-Full) KPI calculation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `api_transaction_reference` STRING COMMENT 'Unique identifier of the API call or transaction that created this event record. Used for API audit trail and troubleshooting. Nullable for non-API events.',
    `awb_number` STRING COMMENT 'Air waybill number associated with this event, if applicable. Used for air freight shipments. May be MAWB (Master Air Waybill) or HAWB (House Air Waybill).',
    `bol_number` STRING COMMENT 'Bill of lading number associated with this event, if applicable. Used for ocean and ground freight shipments. May be MBL (Master Bill of Lading) or HBL (House Bill of Lading).',
    `carrier_code` STRING COMMENT 'Standard code identifying the transportation carrier responsible for the shipment at the time of this event. Examples: IATA airline codes, SCAC codes for ocean/trucking. Nullable for internal hub operations.',
    `container_number` STRING COMMENT 'ISO container number for ocean freight shipments. Format: 4-letter owner code + 6-digit serial number + check digit. Only populated for containerized freight events.',
    `customs_clearance_status` STRING COMMENT 'Status of customs clearance at the time of this event. Only populated for cross-border shipments and customs-related events. Cleared: customs released; Held: under inspection; Rejected: entry denied.. Valid values are `pending|cleared|held|released|rejected`',
    `damage_description` STRING COMMENT 'Free-text description of the damage observed. Only populated when damage_reported = True. Used for claims investigation and root cause analysis.',
    `damage_reported` BOOLEAN COMMENT 'Indicates whether damage to the shipment was observed and reported during this event. True if damage detected, False otherwise. Triggers claims workflow.',
    `edi_message_reference` STRING COMMENT 'Unique identifier of the EDI message that generated this event, if applicable. Used for EDI 214 carrier status messages and event reconciliation.',
    `estimated_delivery_timestamp` TIMESTAMP COMMENT 'Updated ETA (Estimated Time of Arrival) for final delivery, recalculated at the time of this event. Predictive ETA updates from FourKites or carrier systems. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_category` STRING COMMENT 'High-level classification of the event type. Tracking events are carrier-reported milestones; hub operations are internal facility scans; exceptions are deviations or delays; lifecycle events are status transitions.. Valid values are `tracking|hub_operation|exception|lifecycle`',
    `event_description` STRING COMMENT 'Human-readable narrative description of the event. May include raw event text from carrier or system source. Used for audit trail and customer communication.',
    `event_source` STRING COMMENT 'System or channel that generated the event. Examples: FourKites, carrier EDI feed, Manhattan WMS scan, sortation system, SAP TM, manual entry. Enables event provenance and quality assessment.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the tracking event occurred in the real world. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. This is the business event time, distinct from record creation time.',
    `event_type_code` STRING COMMENT 'Standardized code representing the specific event type. Examples: PICKUP, DEPARTED, ARRIVED, IN_TRANSIT, SORTED, LOADED_OUTBOUND, OUT_FOR_DELIVERY, DELIVERED, EXCEPTION_DELAY, EXCEPTION_DAMAGE, STATUS_CHANGE. Aligns with IATA and carrier EDI standards.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating the root cause of the exception. Examples: WEATHER_DELAY, CUSTOMS_HOLD, ADDRESS_INCORRECT, DAMAGE_IN_TRANSIT, REFUSED_BY_CONSIGNEE. Only populated for exception events.',
    `exception_resolution_notes` STRING COMMENT 'Free-text notes documenting how the exception was resolved, actions taken, and any follow-up required. Only populated for exception events.',
    `exception_resolution_status` STRING COMMENT 'Current resolution state of the exception. Only populated for exception events. Tracks whether the issue has been addressed.. Valid values are `open|in_progress|resolved|escalated`',
    `exception_resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was resolved. Only populated for exception events that have been closed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `exception_severity` STRING COMMENT 'Severity level of the exception event. Only populated for event_category = exception. Low: minor delay; Medium: moderate delay or documentation issue; High: significant delay or damage; Critical: shipment at risk or lost.. Valid values are `low|medium|high|critical`',
    `facility_code` STRING COMMENT 'Internal code identifying the facility, hub, sortation center, or warehouse where the event occurred. Nullable for in-transit or external carrier events.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the event location in decimal degrees. Range: -90.0000000 to +90.0000000. Captured from GPS-enabled devices or FourKites real-time tracking.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the event location in decimal degrees. Range: -180.0000000 to +180.0000000. Captured from GPS-enabled devices or FourKites real-time tracking.',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'Relative humidity percentage recorded at the time of the event. Used for sensitive cargo monitoring. Range: 0.00 to 100.00. Nullable for non-humidity-controlled shipments.',
    `location_city` STRING COMMENT 'City name where the tracking event occurred. Used for customer visibility and geographic analytics.',
    `location_country_code` STRING COMMENT 'Three-letter ISO country code where the event occurred. Examples: USA, CAN, GBR, DEU, CHN.. Valid values are `^[A-Z]{3}$`',
    `location_postal_code` STRING COMMENT 'Postal or ZIP code of the event location. Used for last-mile delivery precision and route optimization.',
    `location_state_province` STRING COMMENT 'State or province code where the event occurred. ISO 3166-2 subdivision code preferred.',
    `new_status` STRING COMMENT 'The shipment status after this lifecycle event. Only populated for event_category = lifecycle. Represents the state transition target.',
    `pieces_count` STRING COMMENT 'Number of pieces, packages, or handling units scanned or processed in this event. Used for piece-level tracking and inventory reconciliation.',
    `pod_image_url` STRING COMMENT 'URL or storage path to the scanned or photographed proof of delivery document. Used for audit and claims resolution.',
    `pod_recipient_name` STRING COMMENT 'Name of the person who received and signed for the shipment. Only populated for delivered events with POD. Personally identifiable information.',
    `pod_signature_captured` BOOLEAN COMMENT 'Indicates whether a physical or electronic signature was captured at delivery. True if signature obtained, False otherwise. Used for delivery verification and dispute resolution.',
    `previous_status` STRING COMMENT 'The shipment status immediately before this lifecycle event. Only populated for event_category = lifecycle. Enables status transition audit trail.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this tracking event record was first inserted into the data platform. Immutable. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Distinct from event_timestamp which is the business event time.',
    `record_source_system` STRING COMMENT 'Name of the operational system that originally created this event record. Examples: SAP TM, Oracle TMS, Manhattan WMS, FourKites, carrier EDI gateway. Used for data lineage and quality assessment.',
    `scan_type` STRING COMMENT 'Method used to capture the tracking event. Barcode: handheld or fixed scanner; RFID: radio frequency identification; Manual: keyboard entry; OCR: optical character recognition.. Valid values are `barcode|rfid|manual|ocr`',
    `seal_number` STRING COMMENT 'Security seal number applied to container or trailer. Used for customs compliance and tamper detection. Recorded at sealing and verified at unsealing events.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient or cargo temperature recorded at the time of the event, in degrees Celsius. Used for cold chain monitoring and compliance. Nullable for non-temperature-controlled shipments.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Actual or verified weight of the shipment at the time of the event, in kilograms. May differ from booking weight. Used for weight reconciliation and billing adjustments.',
    CONSTRAINT pk_tracking_event PRIMARY KEY(`tracking_event_id`)
) COMMENT 'Immutable, append-only record of any shipment event captured throughout the shipment lifecycle — including carrier-reported tracking milestones, internal hub/sortation operational events, exception/deviation events, and business lifecycle state transitions. Each event records the event category (tracking/hub_operation/exception/lifecycle), event type code (e.g., PICKUP, DEPARTED, ARRIVED, SORTED, LOADED_OUTBOUND, EXCEPTION_DELAY, STATUS_CHANGE), event timestamp, location (facility code, city, country, GPS coordinates), event source (FourKites, carrier EDI, WMS scan, sortation system, TMS), operator ID, severity (for exceptions), resolution fields (for exceptions), previous/new status (for lifecycle transitions), and raw event description. Serves as the unified event log enabling OTD calculation, predictive ETA updates, exception detection, and full shipment audit trail. Never updated after insert.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`pod` (
    `pod_id` BIGINT COMMENT 'Unique identifier for the proof of delivery record. Primary key for the POD entity.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: COD collections (cod_amount, amount_collected, remittance_batch_id) are deposited to specific bank accounts. FK enables cash application, bank reconciliation, and remittance tracking per treasury mana',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the cargo claim record if a claim was filed related to this delivery. Links POD to claims management process.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment for which this proof of delivery was captured. Links POD to the parent shipment transaction.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Proof of delivery must record which vehicle performed the delivery for driver accountability, vehicle performance tracking, and dispute resolution. Role-prefixed because delivery context is specific. ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: COD collection and remittance transactions must be recognized in correct fiscal period per collection_timestamp. Essential for revenue cutoff, period-end close, and cash flow statement accuracy per ac',
    `employee_id` BIGINT COMMENT 'Reference to the employee (driver, courier, or delivery agent) who executed the delivery and captured the POD.',
    `pod_verified_by_employee_id` BIGINT COMMENT 'Reference to the employee who verified or approved the POD record. Supports quality control and audit requirements.',
    `amount_collected` DECIMAL(18,2) COMMENT 'The actual amount collected from the recipient at delivery. May differ from COD amount if partial payment or variance occurred.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with the shipment for which this POD was captured. Links POD to air freight documentation.',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the shipment for which this POD was captured. Links POD to ocean or ground freight documentation.',
    `cod_amount` DECIMAL(18,2) COMMENT 'The total amount to be collected from the recipient at the time of delivery as per the COD terms. This is the target collection amount agreed upon at shipment booking.',
    `cod_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the COD amount to be collected.. Valid values are `^[A-Z]{3}$`',
    `collection_timestamp` TIMESTAMP COMMENT 'The exact date and time when the COD payment was collected from the recipient. May differ slightly from delivery timestamp if payment processing occurred after handover.',
    `collection_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the COD amount and the amount collected. Positive value indicates over-collection, negative indicates under-collection or shortfall.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this POD record was first created in the system. Supports audit trail and data lineage tracking.',
    `delivery_address_line1` STRING COMMENT 'First line of the physical address where the delivery was completed. Captures street number and street name.',
    `delivery_address_line2` STRING COMMENT 'Second line of the delivery address. May include apartment number, suite, building name, or other secondary address details.',
    `delivery_city` STRING COMMENT 'City or municipality where the delivery was completed.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the delivery location.. Valid values are `^[A-Z]{3}$`',
    `delivery_exception_code` STRING COMMENT 'Standardized code indicating any exception or deviation from normal delivery process noted at the time of delivery (e.g., damaged package, partial delivery, refused).',
    `delivery_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the exact delivery location captured by the delivery agents device at the time of delivery.',
    `delivery_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the exact delivery location captured by the delivery agents device at the time of delivery.',
    `delivery_notes` STRING COMMENT 'Free-text notes entered by the delivery agent at the time of delivery. May include special instructions followed, access issues, or recipient comments.',
    `delivery_postal_code` STRING COMMENT 'Postal code or ZIP code of the delivery location.',
    `delivery_state_province` STRING COMMENT 'State, province, or region where the delivery was completed.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The exact date and time when the shipment was delivered to the recipient. This is the principal business event timestamp for the POD transaction, distinct from audit timestamps.',
    `delivery_type` STRING COMMENT 'Classification of the delivery method used to complete the shipment handover. Indicates where and how the package was left.. Valid values are `door|reception|locker|neighbor|safe_place|collection_point`',
    `device_code` STRING COMMENT 'Unique identifier of the mobile device or handheld scanner used by the delivery agent to capture the POD. Supports audit trail and device tracking.',
    `dispute_raised_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipper or recipient has raised a dispute regarding this delivery or COD collection. True indicates an active or historical dispute.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the delivery or COD dispute, if one was raised. Supports claims management and customer service resolution.',
    `document_number` STRING COMMENT 'External business identifier or document number for the POD record. May be printed on physical POD forms or referenced in customer communications.',
    `epod_image_reference` STRING COMMENT 'URI or storage path reference to the digital photograph of the delivered package taken at the delivery location. Supports ePOD standards for visual delivery confirmation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this POD record was last modified. Supports audit trail and change tracking for POD status updates or dispute resolution.',
    `payment_method` STRING COMMENT 'The payment instrument used by the recipient to settle the COD amount at delivery (e.g., cash, credit card, mobile wallet).. Valid values are `cash|card|digital_wallet|bank_transfer|cheque`',
    `pod_status` STRING COMMENT 'Current lifecycle status of the POD record. Indicates whether the delivery evidence has been accepted by the shipper, is under dispute, or is pending verification.. Valid values are `accepted|disputed|pending|verified|rejected`',
    `recipient_contact_number` STRING COMMENT 'Phone number of the recipient who accepted the delivery. Used for delivery confirmation and follow-up communication.',
    `recipient_email` STRING COMMENT 'Email address of the recipient who accepted the delivery. Used for sending electronic proof of delivery confirmation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_id_number` STRING COMMENT 'Identification document number presented by the recipient at delivery. Captured for high-value shipments or regulatory compliance.',
    `recipient_id_type` STRING COMMENT 'Type of identification document presented by the recipient at delivery for high-value or restricted shipments.. Valid values are `national_id|passport|drivers_license|employee_badge|none`',
    `recipient_name` STRING COMMENT 'Full name of the person who received the shipment at the delivery location. This is the identity label for the receiving party.',
    `recipient_signature` STRING COMMENT 'Base64-encoded signature image or reference URI to the signature captured at delivery. Serves as biometric proof of receipt.',
    `remittance_batch_number` STRING COMMENT 'Identifier of the financial batch in which this COD collection was remitted to the shipper. Supports reconciliation and audit of COD settlements.',
    `remittance_date` DATE COMMENT 'The date on which the collected COD amount was remitted to the shipper. Used for financial settlement tracking and Service Level Agreement (SLA) compliance.',
    `remittance_status` STRING COMMENT 'Current status of the COD amount remittance back to the shipper. Tracks the financial settlement lifecycle from collection through to shipper payment.. Valid values are `pending|remitted|reconciled|disputed|failed`',
    `transaction_reference_number` STRING COMMENT 'External payment transaction reference number or receipt number for non-cash COD payments. Links POD to payment gateway or card processor transaction.',
    `variance_reason_code` STRING COMMENT 'Standardized code explaining why the collected amount differs from the COD amount (e.g., partial payment, pricing dispute, damaged goods discount).',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the POD record was verified or approved by operations or quality control staff.',
    CONSTRAINT pk_pod PRIMARY KEY(`pod_id`)
) COMMENT 'Proof of Delivery (POD / ePOD) record capturing evidence of successful shipment delivery and any Cash on Delivery (COD) collection at the point of delivery. Stores delivery timestamp, recipient name, recipient signature (base64 or reference URI), delivery location coordinates (GPS), delivery type (door/reception/locker/neighbour), ePOD image reference, delivery agent employee ID, device ID used for capture, delivery notes or exceptions noted at delivery, POD status (accepted/disputed/pending), COD amount, COD currency, payment method (cash/card/digital wallet), amount collected, collection timestamp, remittance status, and any variance between COD amount and collected amount. Aligns with ePOD standards and supports COD reconciliation, remittance tracking to shippers, claims management, and financial settlement. SSOT for delivery confirmation evidence and COD collection.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` (
    `eta_milestone_id` BIGINT COMMENT 'Unique identifier for the ETA/ETD milestone record. Primary key for the eta_milestone product.',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment for which this milestone applies. Links to the shipment product.',
    `contract_sla_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_sla_commitment. Business justification: ETA milestones directly measure on-time delivery performance against specific contractual SLA commitments. This link enables automated SLA breach detection, penalty calculation, and customer performan',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: ETA milestones track predicted arrival times for transport legs. The product already has freight_leg_id (cross-domain FK to freight domain), but shipment_leg is the in-domain leg entity. Adding shipme',
    `actual_datetime` TIMESTAMP COMMENT 'The actual recorded datetime when the milestone event occurred (e.g., actual departure, actual arrival). Populated after the event has been confirmed. Null until the event is completed.',
    `carrier_code` STRING COMMENT 'IATA or SCAC carrier code for the carrier responsible for this leg of transport. Used to track carrier-specific performance.. Valid values are `^[A-Z0-9]{2,4}$`',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system. Audit field for record lifecycle tracking.',
    `current_predicted_datetime` TIMESTAMP COMMENT 'The most recent predicted ETA or ETD datetime based on real-time tracking, AI/ML models, or carrier updates. This value is continuously updated as new information becomes available.',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether customs clearance is required at this milestone location. True = customs clearance required, False = no customs clearance required.',
    `customs_clearance_status` STRING COMMENT 'Current status of customs clearance at this milestone location. NOT_REQUIRED = no customs clearance needed, PENDING = awaiting customs processing, IN_PROGRESS = customs processing underway, CLEARED = customs clearance completed, HELD = shipment held by customs, REJECTED = customs clearance rejected.. Valid values are `NOT_REQUIRED|PENDING|IN_PROGRESS|CLEARED|HELD|REJECTED`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score (0.00 to 100.00) indicating the completeness and reliability of the data used to generate this milestone prediction. Higher scores indicate better data quality.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for delay if the milestone is at risk or delayed. WEATHER = adverse weather conditions, TRAFFIC = road/air/sea traffic congestion, CUSTOMS_DELAY = customs clearance delays, MECHANICAL = vehicle/equipment breakdown, CAPACITY = capacity constraints, PORT_CONGESTION = port or terminal congestion, DOCUMENTATION = missing or incorrect documentation, SECURITY = security screening delays, LABOR_STRIKE = labor action or strike, OTHER = other unspecified reasons. [ENUM-REF-CANDIDATE: WEATHER|TRAFFIC|CUSTOMS_DELAY|MECHANICAL|CAPACITY|PORT_CONGESTION|DOCUMENTATION|SECURITY|LABOR_STRIKE|OTHER — 10 candidates stripped; promote to reference product]',
    `delay_reason_description` STRING COMMENT 'Free-text description providing additional detail about the delay reason. Supplements the delay_reason_code with specific context.',
    `distance_remaining_km` DECIMAL(18,2) COMMENT 'Estimated distance remaining in kilometers from current position to the milestone location. Updated in real-time based on GPS tracking data.',
    `exception_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an exception event has been recorded for this milestone. True = exception exists, False = no exception.',
    `exception_type` STRING COMMENT 'Type of exception event if exception_flag is true. DELAY = shipment delay, ROUTE_CHANGE = route deviation, DAMAGE = cargo damage, LOSS = cargo loss or theft, SECURITY_INCIDENT = security breach, DOCUMENTATION_ERROR = documentation issues, NONE = no exception. [ENUM-REF-CANDIDATE: DELAY|ROUTE_CHANGE|DAMAGE|LOSS|SECURITY_INCIDENT|DOCUMENTATION_ERROR|NONE — 7 candidates stripped; promote to reference product]',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this shipment contains hazardous materials requiring special handling. True = hazmat shipment, False = non-hazmat shipment.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified. Audit field for tracking changes to milestone data.',
    `location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE location code for the milestone location (airport, seaport, or inland terminal).. Valid values are `^[A-Z]{3}$`',
    `location_name` STRING COMMENT 'Human-readable name of the milestone location (e.g., Los Angeles International Airport, Port of Rotterdam).',
    `milestone_sequence_number` STRING COMMENT 'Sequential order number of this milestone within the overall shipment journey. Used to track progression through the shipment lifecycle (e.g., 1 = first milestone, 2 = second milestone).',
    `milestone_type` STRING COMMENT 'Type of milestone event in the shipment lifecycle. ETD_ORIGIN = Estimated Time of Departure from origin, ETA_TRANSIT_HUB = Estimated Time of Arrival at transit hub, ETD_TRANSIT_HUB = Estimated Time of Departure from transit hub, ETA_DESTINATION = Estimated Time of Arrival at destination facility, ETA_DELIVERY = Estimated Time of Arrival for final delivery to consignee, ETD_PICKUP = Estimated Time of Departure for pickup from shipper.. Valid values are `ETD_ORIGIN|ETA_TRANSIT_HUB|ETD_TRANSIT_HUB|ETA_DESTINATION|ETA_DELIVERY|ETD_PICKUP`',
    `notification_sent_datetime` TIMESTAMP COMMENT 'Timestamp when the customer notification was sent for this milestone update. Null if no notification has been sent.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a proactive customer notification has been sent for this milestone update. True = notification sent, False = notification not yet sent.',
    `original_committed_datetime` TIMESTAMP COMMENT 'The original committed ETA or ETD datetime provided at booking or shipment creation. This is the baseline SLA commitment against which performance is measured.',
    `prediction_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00 to 100.00) indicating the reliability of the current predicted datetime. Higher scores indicate greater confidence based on data quality, historical accuracy, and real-time signal strength.',
    `prediction_last_updated_datetime` TIMESTAMP COMMENT 'Timestamp when the current predicted datetime was last updated. Used to track the freshness of prediction data and trigger re-prediction cycles.',
    `prediction_source` STRING COMMENT 'Source system or method that generated the current predicted datetime. FOURKITES_AI = FourKites predictive analytics engine, CARRIER_EDI = Electronic Data Interchange from carrier, TMS_CALCULATION = Transportation Management System route calculation, MANUAL_OVERRIDE = Manual adjustment by operations team, GPS_TRACKING = Real-time GPS device data, HISTORICAL_AVERAGE = Statistical average based on historical performance.. Valid values are `FOURKITES_AI|CARRIER_EDI|TMS_CALCULATION|MANUAL_OVERRIDE|GPS_TRACKING|HISTORICAL_AVERAGE`',
    `prediction_update_frequency_minutes` STRING COMMENT 'Frequency in minutes at which the prediction is updated for this milestone. Varies based on transport mode, priority, and data availability (e.g., 15 minutes for air, 60 minutes for ocean).',
    `priority_level` STRING COMMENT 'Priority classification for this shipment milestone. STANDARD = normal priority, EXPEDITED = faster than standard, URGENT = high priority requiring special attention, CRITICAL = highest priority requiring immediate action.. Valid values are `STANDARD|EXPEDITED|URGENT|CRITICAL`',
    `sla_status` STRING COMMENT 'Current SLA compliance status for this milestone. ON_TIME = predicted to meet commitment, AT_RISK = potential delay within threshold, DELAYED = predicted or actual breach of commitment, EARLY = predicted or actual early completion.. Valid values are `ON_TIME|AT_RISK|DELAYED|EARLY`',
    `sla_threshold_hours` DECIMAL(18,2) COMMENT 'The acceptable variance threshold in hours for this milestone as defined in the customer SLA. Variance beyond this threshold triggers SLA breach status.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this shipment leg requires temperature-controlled handling. True = temperature control required, False = no temperature control required.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the milestone location (e.g., America/Los_Angeles, Europe/Amsterdam). Used to ensure accurate local time representation.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `transport_mode` STRING COMMENT 'Mode of transportation for this milestone leg. AIR = air freight, OCEAN = ocean freight, ROAD = road/truck transport, RAIL = rail transport, INTERMODAL = combination of multiple modes.. Valid values are `AIR|OCEAN|ROAD|RAIL|INTERMODAL`',
    `variance_hours` DECIMAL(18,2) COMMENT 'Variance in hours between the current predicted datetime and the original committed datetime. Positive values indicate delay (late), negative values indicate early arrival/departure. Used for SLA breach prediction and OTIF measurement.',
    `vehicle_identifier` STRING COMMENT 'Identifier for the specific vehicle, vessel, aircraft, or container handling this leg (e.g., flight number, vessel name, truck license plate, container number).',
    `weather_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether adverse weather conditions are impacting or predicted to impact this milestone. True = weather impact detected, False = no weather impact.',
    CONSTRAINT pk_eta_milestone PRIMARY KEY(`eta_milestone_id`)
) COMMENT 'Stores planned and predicted ETA/ETD milestone records for each shipment leg and overall consignment. Captures milestone type (ETD_ORIGIN, ETA_TRANSIT_HUB, ETD_TRANSIT_HUB, ETA_DESTINATION, ETA_DELIVERY), original committed datetime, current predicted datetime, prediction source (FourKites AI, carrier EDI, manual override), prediction confidence score, variance in hours from original commitment, and last updated timestamp. Enables SLA breach prediction, proactive customer notification, and OTIF performance measurement. Sourced from FourKites predictive ETA engine.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`exception_event` (
    `exception_event_id` BIGINT COMMENT 'Unique identifier for the exception event record. Primary key.',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the cargo claim record created as a result of this exception event, if applicable.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for the shipment leg where the exception occurred.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment that experienced this exception. Links to the shipment master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exception events with financial_impact_amount (delays, damages, SLA breaches) require cost center attribution for operational variance analysis, budget impact assessment, and management reporting of e',
    `employee_id` BIGINT COMMENT 'Reference to the user or team member currently assigned to manage and resolve this exception.',
    `related_exception_event_id` BIGINT COMMENT 'Reference to another exception event that is related to or caused by this exception, enabling exception chain analysis.',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Exceptions occur during specific transport legs (e.g., flight delayed is leg 2 air segment, customs hold is leg 3 cross-border segment). Adding shipment_leg_id enables leg-level exception analytic',
    `assigned_to_team` STRING COMMENT 'Name or code of the operational team responsible for handling this exception event.',
    `claim_eligible_flag` BOOLEAN COMMENT 'Indicator of whether this exception event qualifies for a cargo claim or insurance claim filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this exception event record was first created in the system.',
    `customer_notification_channel` STRING COMMENT 'Communication channel used to notify the customer about the exception event.. Valid values are `EMAIL|SMS|PHONE|PORTAL|API|EDI`',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicator of whether the customer has been notified about this exception event.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified about the exception event.',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of delay caused by this exception, measured in hours, used for performance reporting and claims calculation.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator of whether this exception has been escalated to higher management or specialized teams for resolution.',
    `escalation_tier` STRING COMMENT 'Level of escalation indicating the organizational tier handling the exception resolution.. Valid values are `TIER_1|TIER_2|TIER_3|EXECUTIVE`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was escalated to a higher tier or specialized team.',
    `estimated_recovery_timestamp` TIMESTAMP COMMENT 'Projected date and time when the shipment is expected to return to normal schedule after exception resolution.',
    `exception_location_code` STRING COMMENT 'Code identifying the facility, terminal, or geographic location where the exception occurred.',
    `exception_location_country_code` STRING COMMENT 'Three-letter ISO country code for the location where the exception occurred.. Valid values are `^[A-Z]{3}$`',
    `exception_location_name` STRING COMMENT 'Human-readable name of the location where the exception occurred.',
    `exception_notes` STRING COMMENT 'Free-text field for operational notes, observations, and additional context about the exception event and its resolution.',
    `exception_number` STRING COMMENT 'Business-facing unique identifier for the exception event, used for tracking and communication with stakeholders.',
    `exception_raised_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was first detected and recorded in the system. Primary business event timestamp for this transaction.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception event indicating whether it is active, being worked on, or resolved.. Valid values are `OPEN|IN_PROGRESS|RESOLVED|CLOSED|ESCALATED|CANCELLED`',
    `exception_type` STRING COMMENT 'Classification of the exception event indicating the nature of the deviation from planned shipment execution. [ENUM-REF-CANDIDATE: DELAY|DAMAGE|LOST|CUSTOMS_HOLD|ADDRESS_ISSUE|WEATHER|MECHANICAL|REFUSED_DELIVERY|ATTEMPTED_DELIVERY|DOCUMENTATION_ISSUE|SECURITY_HOLD — 11 candidates stripped; promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the exception in the shipment currency, including potential claims, penalties, or recovery costs.',
    `financial_impact_currency_code` STRING COMMENT 'Three-letter ISO currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this exception event record was last updated in the system.',
    `preventable_flag` BOOLEAN COMMENT 'Indicator of whether this exception could have been prevented through better planning, execution, or controls, used for continuous improvement analysis.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicator of whether this exception is a repeat occurrence for the same shipment or route, signaling systemic issues.',
    `resolution_action_code` STRING COMMENT 'Standardized code identifying the corrective action taken to resolve the exception.',
    `resolution_action_description` STRING COMMENT 'Detailed narrative of the actions taken to resolve the exception and restore normal shipment flow.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was successfully resolved and the shipment returned to normal execution.',
    `responsible_party` STRING COMMENT 'Entity or stakeholder determined to be responsible for the exception occurrence, used for accountability and claims processing. [ENUM-REF-CANDIDATE: CARRIER|SHIPPER|CONSIGNEE|CUSTOMS|WAREHOUSE|THIRD_PARTY|INTERNAL — 7 candidates stripped; promote to reference product]',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the underlying cause of the exception, used for analytics and process improvement.',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause analysis findings for this exception event.',
    `severity_level` STRING COMMENT 'Business impact severity of the exception, used for prioritization and escalation decisions.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether this exception caused a breach of the committed service level agreement with the customer.',
    `sla_breach_type` STRING COMMENT 'Classification of the type of SLA commitment that was breached due to this exception.. Valid values are `DELIVERY_TIME|PICKUP_TIME|TRANSIT_TIME|NOTIFICATION|NONE`',
    `source_system` STRING COMMENT 'System or platform that originated the exception event record.. Valid values are `FOURKITES|ORACLE_TMS|SAP_TM|CARRIER_API|MANUAL`',
    `source_system_reference_code` STRING COMMENT 'Unique identifier of this exception event in the originating source system, used for data lineage and reconciliation.',
    CONSTRAINT pk_exception_event PRIMARY KEY(`exception_event_id`)
) COMMENT 'Operational exception record raised during shipment execution when a deviation from the planned journey occurs. Captures exception type (DELAY, DAMAGE, LOST, CUSTOMS_HOLD, ADDRESS_ISSUE, WEATHER, MECHANICAL, REFUSED_DELIVERY, ATTEMPTED_DELIVERY), severity level, exception raised timestamp, location at time of exception, root cause code, responsible party (carrier/shipper/consignee/customs), resolution action taken, resolution timestamp, and escalation flag. Sourced from FourKites exception management module and Oracle TMS exception workflows. Feeds into claims and SLA breach reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` (
    `consignment_status_id` BIGINT COMMENT 'Unique identifier for the consignment status transition record. Primary key for the consignment status history table.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or transportation provider responsible for the consignment at the time of this status transition. Relevant for carrier-driven status updates.',
    `consignment_id` BIGINT COMMENT 'Reference to the parent consignment whose status is being tracked. Links this status transition to the shipment consignment entity.',
    `employee_id` BIGINT COMMENT 'Reference to the user or operator who triggered the status change, if the transition was manual. Null for automated system-triggered transitions.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse, hub, or facility location where the status transition occurred. Captures the physical location context of the lifecycle event.',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Status transitions can be leg-specific (e.g., departed origin marks end of leg 1, arrived at hub marks end of leg 2) or consignment-level (e.g., booking confirmed, delivered). Adding shipment_',
    `customs_cleared_flag` BOOLEAN COMMENT 'Boolean indicator of whether customs clearance was completed at this status transition. Relevant for cross-border shipments and international freight.',
    `customs_reference_number` STRING COMMENT 'The customs declaration or clearance reference number associated with this status transition, if applicable. Links to customs brokerage and trade compliance records.',
    `delay_duration_minutes` STRING COMMENT 'The duration in minutes by which the actual status transition was delayed compared to the planned timestamp. Positive values indicate delay, negative values indicate early arrival.',
    `device_code` STRING COMMENT 'Identifier of the mobile device, scanner, or IoT sensor that captured or triggered the status transition. Used for device tracking and audit trail purposes.',
    `dwell_time_minutes` STRING COMMENT 'The duration in minutes that the consignment remained in the previous status before this transition. Measures processing time and identifies bottlenecks in the supply chain.',
    `eta_updated_flag` BOOLEAN COMMENT 'Boolean indicator of whether the estimated time of arrival was recalculated or updated as a result of this status transition. Used to track predictive ETA accuracy.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator of whether this status transition represents an exception or deviation from the normal consignment flow. True for exception events, false for standard lifecycle progression.',
    `external_reference_code` STRING COMMENT 'The unique identifier for this status transition in the source system or carrier system. Used for cross-system reconciliation and EDI message correlation.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate where the status transition occurred, captured from GPS or RFID tracking systems. Enables spatial analysis of consignment movements.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate where the status transition occurred, captured from GPS or RFID tracking systems. Enables spatial analysis of consignment movements.',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'The relative humidity percentage recorded at the time of the status transition. Relevant for sensitive cargo requiring environmental monitoring.',
    `milestone_code` STRING COMMENT 'Standardized milestone code representing the key checkpoint in the consignment lifecycle. Used for ETA/ETD tracking and SLA milestone compliance reporting. [ENUM-REF-CANDIDATE: BOOKING|PICKUP|ORIGIN_HUB|IN_TRANSIT|DESTINATION_HUB|OUT_FOR_DELIVERY|DELIVERED|POD — 8 candidates stripped; promote to reference product]',
    `new_eta_timestamp` TIMESTAMP COMMENT 'The updated estimated time of arrival calculated at this status transition. Reflects the latest predictive delivery time based on current consignment progress.',
    `new_status_code` STRING COMMENT 'The lifecycle status code of the consignment after this transition. Represents the current state following the status change event. [ENUM-REF-CANDIDATE: BOOKED|PICKED_UP|IN_TRANSIT|AT_HUB|OUT_FOR_DELIVERY|DELIVERED|EXCEPTION|CANCELLED|RETURNED|ON_HOLD — 10 candidates stripped; promote to reference product]',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the customer or stakeholder about this status transition. Null if no notification was sent.. Valid values are `EMAIL|SMS|PUSH|PORTAL|NONE`',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether a customer notification (email, SMS, push) was sent for this status transition. Used to track communication compliance and customer experience.',
    `photo_captured_flag` BOOLEAN COMMENT 'Boolean indicator of whether a photo was captured as proof of delivery or condition at this status transition. Used for ePOD and claims evidence.',
    `planned_timestamp` TIMESTAMP COMMENT 'The originally planned or scheduled date and time for this status transition to occur. Used to measure on-time performance by comparing against actual status_transition_timestamp.',
    `previous_status_code` STRING COMMENT 'The lifecycle status code of the consignment immediately before this transition. Represents the prior state in the consignment workflow. [ENUM-REF-CANDIDATE: BOOKED|PICKED_UP|IN_TRANSIT|AT_HUB|OUT_FOR_DELIVERY|DELIVERED|EXCEPTION|CANCELLED|RETURNED|ON_HOLD — 10 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this status transition record was first created in the data platform. Represents the system audit timestamp for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this status transition record was last modified in the data platform. Tracks the most recent change for audit trail and data quality monitoring.',
    `route_deviation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the consignment deviated from the planned route at this status transition. Used for exception management and route optimization analysis.',
    `scan_type` STRING COMMENT 'The method or technology used to capture the status transition event. Indicates whether the update was via barcode scan, RFID read, manual entry, GPS tracking, or API integration.. Valid values are `BARCODE|RFID|MANUAL|GPS|API`',
    `signature_captured_flag` BOOLEAN COMMENT 'Boolean indicator of whether an electronic proof of delivery signature was captured at this status transition. Typically true for DELIVERED status transitions.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether this status transition resulted in or indicates a breach of the committed service level agreement. Used for SLA compliance tracking and dispute resolution.',
    `source_system_code` STRING COMMENT 'The operational system of record that originated this status transition record. Identifies the authoritative source for data lineage and reconciliation purposes.. Valid values are `SAP_TM|ORACLE_TMS|MANHATTAN_WMS|FOURKITES|CARRIER_EDI|MOBILE_APP`',
    `status_notes` STRING COMMENT 'Free-text notes or comments providing additional context about the status transition. May include operator remarks, exception details, or customer instructions.',
    `status_reason_code` STRING COMMENT 'Standardized code indicating the reason or cause for the status transition. Provides context for why the consignment moved to the new status, especially for exceptions. [ENUM-REF-CANDIDATE: NORMAL_FLOW|CUSTOMER_REQUEST|EXCEPTION_DELAY|WEATHER|CUSTOMS_HOLD|ADDRESS_CORRECTION|DAMAGED|REFUSED|SECURITY_HOLD — 9 candidates stripped; promote to reference product]',
    `status_transition_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consignment status changed from the previous status to the new status. Represents the real-world business event time of the lifecycle transition.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'The ambient or cargo temperature in degrees Celsius recorded at the time of the status transition. Relevant for temperature-controlled shipments and cold chain compliance.',
    `triggered_by_source` STRING COMMENT 'The originating system or channel that initiated the status transition. Identifies whether the change was automated (system/EDI), manual (user), or via integration (API/WMS).. Valid values are `SYSTEM|USER|CARRIER_EDI|API|MOBILE_APP|WMS`',
    CONSTRAINT pk_consignment_status PRIMARY KEY(`consignment_status_id`)
) COMMENT 'Lifecycle status history table tracking every status transition of a consignment from booking through delivery. Each record captures the previous status, new status, transition timestamp, triggered-by source (system/user/carrier EDI), operator ID, and any status notes. Provides a complete audit trail of the consignment lifecycle enabling SLA compliance analysis, dispute resolution, and operational reporting. Distinct from tracking_event which captures carrier scan events — this table captures business-level lifecycle state transitions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` (
    `shipment_package_id` BIGINT COMMENT 'Unique identifier for the individual package or piece within a consignment. Primary key for the shipment package entity.',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment or consignment that this package belongs to. Links the package to its master shipment record.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the package was successfully delivered to the consignee. Used for proof of delivery (POD) and on-time delivery (OTD) performance measurement.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Physical gross weight of the package measured in kilograms. Used for freight charge calculation, load planning, and carrier capacity management.',
    `barcode_number` STRING COMMENT 'Unique barcode or label number assigned to the package for scanning and tracking throughout the logistics network. Used for piece-level visibility and warehouse operations.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual weight or volumetric weight, used as the basis for freight charge calculation. Determines the billable weight for rating and invoicing.',
    `contents_description` STRING COMMENT 'Textual description of the declared contents within the package. Used for customs declarations, dangerous goods screening, and handling instructions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this package record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_location_code` STRING COMMENT 'Code identifying the current physical location of the package (warehouse, hub, terminal, or in-transit vehicle). Updated by scan events for real-time visibility.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the package contains dangerous goods (DG) requiring special handling, labeling, and regulatory compliance per IMDG or IATA DG regulations.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value declared by the shipper for the package contents. Used for insurance coverage, customs valuation, and liability limits.',
    `declared_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared value amount. Enables multi-currency valuation and customs reporting.',
    `delivery_signature_name` STRING COMMENT 'Name of the person who signed for the package upon delivery. Part of electronic proof of delivery (ePOD) record.',
    `estimated_delivery_date` DATE COMMENT 'Predicted date when the package will be delivered to the final consignee. Used for customer notifications and SLA monitoring.',
    `exception_code` STRING COMMENT 'Standardized code identifying the type of exception or delay affecting the package (e.g., address incorrect, recipient unavailable, customs hold). Used for exception management and root cause analysis.',
    `exception_description` STRING COMMENT 'Detailed textual description of the exception or issue affecting the package. Provides context for customer service and operations teams.',
    `fragile_flag` BOOLEAN COMMENT 'Indicates whether the package contains fragile items requiring special handling care. Triggers warehouse handling instructions and carrier notifications.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the package in centimeters. Used for volumetric weight calculation, load optimization, and warehouse space planning.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the package contents. Used for customs clearance, duty calculation, and trade compliance reporting.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'Monetary amount of insurance coverage purchased for the package. Used for claims processing and liability determination.',
    `insurance_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the insurance coverage amount.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the shipper has purchased additional insurance coverage for this package beyond standard carrier liability limits.',
    `last_scan_location_code` STRING COMMENT 'Location code where the most recent scan event occurred. Used for tracking history and route verification.',
    `last_scan_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent barcode scan event for this package. Provides real-time tracking visibility and exception detection.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the package in centimeters. Used for volumetric weight calculation, load optimization, and warehouse space planning.',
    `max_stack_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms that can be stacked on top of this package without causing damage. Used for warehouse stacking rules and load optimization.',
    `package_status` STRING COMMENT 'Current lifecycle status of the package in the logistics network. Tracks the package from booking through final delivery or exception resolution. [ENUM-REF-CANDIDATE: booked|picked_up|in_transit|at_hub|out_for_delivery|delivered|exception|returned|damaged|lost — 10 candidates stripped; promote to reference product]',
    `package_type` STRING COMMENT 'Classification of the physical packaging unit. Determines handling requirements, stacking rules, and warehouse slotting strategies. [ENUM-REF-CANDIDATE: carton|pallet|drum|envelope|crate|box|bag|bundle|container|skid — 10 candidates stripped; promote to reference product]',
    `pod_image_url` STRING COMMENT 'URL reference to the stored proof of delivery image (signature, photo, or scan). Used for delivery verification and dispute resolution.',
    `sequence_number` STRING COMMENT 'Sequential position of this package within the parent consignment (e.g., package 1 of 5). Used for piece count verification and delivery confirmation.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this package data (Manhattan WMS for warehouse scans, Oracle TMS for load manifests, FourKites for tracking updates). Used for data lineage and reconciliation.. Valid values are `manhattan_wms|oracle_tms|sap_tm|fourkites|manual_entry`',
    `special_handling_instructions` STRING COMMENT 'Free-text field for additional handling instructions specific to this package (e.g., This Side Up, Keep Dry, Handle with Care). Used by warehouse and delivery personnel.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether the package can be stacked with other packages during storage and transportation. Affects warehouse slotting and load planning.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the package requires temperature-controlled transportation and storage (e.g., pharmaceuticals, perishables). Determines equipment assignment and routing.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-sensitive packages. Used for cold chain monitoring and compliance verification.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-sensitive packages. Used for cold chain monitoring and compliance verification.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for dangerous goods classification. Required for DG shipments to identify hazardous materials and handling requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this package record was last modified. Used for audit trail and change tracking.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total cubic volume of the package in cubic meters (CBM). Calculated from length × width × height. Used for container load planning and warehouse capacity management.',
    `volumetric_weight_kg` DECIMAL(18,2) COMMENT 'Dimensional weight (DIM weight) calculated from package dimensions using carrier-specific conversion factors (typically length × width × height / divisor). Used for billing reconciliation when volumetric weight exceeds actual weight.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the package in centimeters. Used for volumetric weight calculation, load optimization, and warehouse space planning.',
    CONSTRAINT pk_shipment_package PRIMARY KEY(`shipment_package_id`)
) COMMENT 'Individual package/piece-level master record within a consignment. Captures package sequence number within the consignment, barcode/label number, package type (carton, pallet, drum, envelope, crate), actual weight, volumetric weight (DIM weight), dimensions (L×W×H in cm), declared contents description, fragile flag, temperature-sensitive flag, and current package status. Enables piece-level tracking, DIM weight billing reconciliation, and warehouse handling instructions. Sourced from Manhattan WMS scan data and Oracle TMS load manifests.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` (
    `shipment_carrier_assignment_id` BIGINT COMMENT 'Unique identifier for the shipment carrier assignment record. Primary key.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Freight forwarding agents book and coordinate carrier assignments on behalf of shippers - critical for commission calculation, agent performance tracking, and multi-modal coordination in forwarding op',
    `agreement_id` BIGINT COMMENT 'Reference to the carrier contract under which this assignment was made, if applicable.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (airline, ocean carrier, road haulier, rail operator) assigned to transport this shipment leg.',
    `rate_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.rate_agreement. Business justification: Carrier assignments for shipments should reference negotiated rate agreements to ensure contracted rates are applied, support freight audit and payment (FAP) processes, track volume commitments, and v',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment for which this carrier assignment is made.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created this carrier assignment.',
    `shipment_leg_id` BIGINT COMMENT 'Reference to the specific shipment leg (origin-destination segment) to which this carrier is assigned. Enables multi-leg shipment tracking.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Carrier assignments specify the exact vehicle/container executing the shipment. Essential for execution tracking, carrier performance measurement, and asset utilization. vehicle_number and container_n',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Carrier booking confirmations are contractual transport documents required for rate verification, service level disputes, capacity allocation audits, and invoice reconciliation. Operations must retain',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier arrived at the destination with the shipment.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier departed with the shipment.',
    `assignment_date` DATE COMMENT 'Date on which the carrier was assigned to this shipment leg.',
    `assignment_method` STRING COMMENT 'Method by which the carrier was assigned to this shipment leg. Auto-optimized indicates algorithmic carrier selection via SAP TM or Oracle TMS; manual override indicates planner intervention; contract based indicates assignment per existing carrier contract; spot market indicates ad-hoc market rate booking; tender indicates competitive bidding process; preferred carrier indicates selection from preferred carrier list.. Valid values are `auto_optimized|manual_override|contract_based|spot_market|tender|preferred_carrier`',
    `assignment_status` STRING COMMENT 'Current status of the carrier assignment. Confirmed indicates the carrier has accepted the booking; tentative indicates provisional assignment pending confirmation; cancelled indicates the assignment was revoked; pending indicates awaiting carrier response; rejected indicates carrier declined; expired indicates assignment lapsed without confirmation.. Valid values are `confirmed|tentative|cancelled|pending|rejected|expired`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the carrier assignment was created in the system.',
    `booking_reference_number` STRING COMMENT 'Unique booking or reservation number issued by the carrier for this shipment leg. Used for carrier communication and tracking.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier assignment was cancelled.',
    `carrier_iata_code` STRING COMMENT 'IATA two or three-character airline designator code for air carriers.. Valid values are `^[A-Z0-9]{2,3}$`',
    `carrier_performance_rating` DECIMAL(18,2) COMMENT 'Performance rating assigned to the carrier for this shipment leg, typically on a scale of 0.00 to 5.00. Used for carrier scorecard and future selection optimization.',
    `carrier_scac_code` STRING COMMENT 'Standard Carrier Alpha Code uniquely identifying the carrier in North American freight systems. 2-4 uppercase letters.. Valid values are `^[A-Z]{2,4}$`',
    `carrier_service_code` STRING COMMENT 'Service product code offered by the carrier (e.g., express, standard, economy, next-day, two-day). Defines the service level agreement.',
    `carrier_service_name` STRING COMMENT 'Human-readable name of the carrier service product (e.g., FedEx Priority Overnight, UPS Ground, Maersk Saver).',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier confirmed acceptance of the booking.',
    `contract_rate_flag` BOOLEAN COMMENT 'Indicates whether the rate applied is a contracted rate (true) or a spot market rate (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier assignment record was first created in the system.',
    `equipment_type` STRING COMMENT 'Type of equipment or container used by the carrier (e.g., 20ft container, 40ft container, refrigerated, flatbed, dry van, tanker).',
    `estimated_arrival_date` DATE COMMENT 'Estimated date of arrival for this carrier leg as provided by the carrier.',
    `estimated_departure_date` DATE COMMENT 'Estimated date of departure for this carrier leg as provided by the carrier.',
    `flight_number` STRING COMMENT 'Flight number assigned by the airline for air freight transport.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Bunker Adjustment Factor (BAF) or fuel surcharge applied by the carrier to account for fuel cost fluctuations.',
    `mode_of_transport` STRING COMMENT 'Primary mode of transport for this carrier assignment (air, ocean, road, rail, multimodal, courier).. Valid values are `air|ocean|road|rail|multimodal|courier`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this carrier assignment, including special instructions, exceptions, or operational remarks.',
    `on_time_delivery_flag` BOOLEAN COMMENT 'Indicates whether the carrier delivered the shipment on time per the agreed service level agreement (true) or late (false).',
    `rate_amount` DECIMAL(18,2) COMMENT 'Agreed freight rate amount charged by the carrier for this shipment leg. Base rate before surcharges and adjustments.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `rate_unit_of_measure` STRING COMMENT 'Unit of measure for the rate (e.g., per kilogram, per cubic meter, per TEU, per shipment, per pallet, per mile, per kilometer). [ENUM-REF-CANDIDATE: per_kg|per_cbm|per_teu|per_shipment|per_pallet|per_mile|per_km — 7 candidates stripped; promote to reference product]',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer to ensure cargo integrity.',
    `service_type` STRING COMMENT 'Type of carrier service: Full Truckload (FTL), Less Than Truckload (LTL), Full Container Load (FCL), Less Than Container Load (LCL), parcel, express, standard, or economy. [ENUM-REF-CANDIDATE: ftl|ltl|fcl|lcl|parcel|express|standard|economy — 8 candidates stripped; promote to reference product]',
    `total_carrier_charge` DECIMAL(18,2) COMMENT 'Total amount charged by the carrier for this shipment leg, including base rate, fuel surcharge, and other carrier fees.',
    `train_number` STRING COMMENT 'Train service number assigned for rail freight transport.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier assignment record was last modified in the system.',
    `vessel_imo_number` STRING COMMENT 'Unique seven-digit IMO number assigned to the vessel for identification and tracking.. Valid values are `^IMO[0-9]{7}$`',
    `vessel_name` STRING COMMENT 'Name of the ocean vessel assigned for sea freight transport.',
    `voyage_number` STRING COMMENT 'Voyage or sailing number for ocean freight, identifying the specific vessel journey.',
    CONSTRAINT pk_shipment_carrier_assignment PRIMARY KEY(`shipment_carrier_assignment_id`)
) COMMENT 'Records the assignment of a carrier (airline, ocean carrier, road haulier, rail operator) to a specific shipment leg. Captures carrier SCAC/IATA code, carrier name, service product code, booking reference number with the carrier, assigned vehicle/vessel/flight number, assignment date, assignment method (auto-optimized via SAP TM carrier selection / manual override), rate agreed, and assignment status (confirmed/tentative/cancelled). Enables carrier performance tracking, freight audit, and carrier spend analysis per shipment.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` (
    `delivery_instruction_id` BIGINT COMMENT 'Unique identifier for the delivery instruction record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment or consignment to which this delivery instruction applies. Links delivery preferences to the specific shipment being transported.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Delivery instructions frequently specify customer contact person for access coordination, delivery authorization, and issue resolution. Normalizes denormalized contact fields. Critical for last-mile d',
    `alternative_delivery_address_line1` STRING COMMENT 'First line of an alternative delivery address specified by the consignee if the primary delivery address is unavailable. Includes street number and street name.',
    `alternative_delivery_address_line2` STRING COMMENT 'Second line of the alternative delivery address. May include apartment number, suite, floor, or building name.',
    `alternative_delivery_city` STRING COMMENT 'City or locality of the alternative delivery address.',
    `alternative_delivery_country_code` STRING COMMENT 'Three-letter ISO country code of the alternative delivery address.. Valid values are `^[A-Z]{3}$`',
    `alternative_delivery_postal_code` STRING COMMENT 'Postal code or ZIP code of the alternative delivery address.',
    `alternative_delivery_state_province` STRING COMMENT 'State, province, or region of the alternative delivery address.',
    `authority_to_leave_flag` BOOLEAN COMMENT 'Indicates whether the delivery driver has authority to leave the shipment unattended at the delivery location without obtaining a signature. True if authority is granted, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery instruction record was first created in the system. Used for audit trail and data lineage.',
    `delivery_notification_preference` STRING COMMENT 'Preferred method for receiving delivery notifications. Specifies whether the consignee wants to be notified via SMS, email, phone call, mobile app push notification, or no notification.. Valid values are `SMS|EMAIL|PHONE_CALL|MOBILE_APP|NONE`',
    `id_verification_required_flag` BOOLEAN COMMENT 'Indicates whether government-issued identification must be verified at delivery. Typically required for age-restricted or high-value shipments.',
    `instruction_effective_date` DATE COMMENT 'The date from which this delivery instruction becomes effective. Supports future-dated instructions and instruction scheduling.',
    `instruction_expiry_date` DATE COMMENT 'The date on which this delivery instruction expires and is no longer valid. Nullable for instructions with no expiration.',
    `instruction_priority` STRING COMMENT 'Priority level assigned to this delivery instruction. High priority instructions take precedence in case of conflicting instructions or operational constraints.. Valid values are `HIGH|MEDIUM|LOW`',
    `instruction_source` STRING COMMENT 'The origin or channel through which the delivery instruction was captured. Indicates whether the instruction came from the shipper, consignee, customer portal, call center, mobile app, or Electronic Data Interchange (EDI) system.. Valid values are `SHIPPER|CONSIGNEE|CUSTOMER_PORTAL|CALL_CENTER|MOBILE_APP|EDI`',
    `instruction_status` STRING COMMENT 'Current lifecycle status of the delivery instruction. Tracks whether the instruction is active, has been cancelled, completed, superseded by a newer instruction, or is pending activation.. Valid values are `ACTIVE|CANCELLED|COMPLETED|SUPERSEDED|PENDING`',
    `instruction_type` STRING COMMENT 'The type of delivery instruction specified by the shipper or consignee. Defines the primary delivery handling requirement for last-mile execution.. Valid values are `LEAVE_AT_DOOR|REQUIRE_SIGNATURE|DELIVER_TO_NEIGHBOUR|LOCKER_DELIVERY|APPOINTMENT_REQUIRED|CALL_BEFORE_DELIVERY`',
    `last_modified_by` STRING COMMENT 'Identifier of the user, system, or process that last modified this delivery instruction record. Supports audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery instruction record was last updated. Used for audit trail and change tracking.',
    `locker_code` STRING COMMENT 'Identifier of the parcel locker or automated pickup point where the shipment should be delivered if locker delivery is selected.',
    `locker_location_code` STRING COMMENT 'Geographic or facility code identifying the location of the parcel locker. Used for routing and last-mile optimization.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age of the recipient required for delivery. Used for age-restricted goods such as alcohol, tobacco, or pharmaceuticals.',
    `neighbour_delivery_allowed_flag` BOOLEAN COMMENT 'Indicates whether the shipment can be delivered to a neighbor if the consignee is not available. True if neighbor delivery is permitted, False otherwise.',
    `preferred_delivery_date` DATE COMMENT 'The date on which the consignee prefers to receive the delivery. Used for appointment scheduling and delivery planning.',
    `preferred_neighbour_address` STRING COMMENT 'Address of a preferred neighbor to whom the shipment can be delivered if the consignee is unavailable.',
    `preferred_time_window_end` TIMESTAMP COMMENT 'The end of the preferred delivery time window specified by the consignee. Defines the latest acceptable time for delivery within the preferred window.',
    `preferred_time_window_start` TIMESTAMP COMMENT 'The start of the preferred delivery time window specified by the consignee. Enables time-definite delivery services and appointment-based deliveries.',
    `return_if_absent_flag` BOOLEAN COMMENT 'Indicates whether the shipment should be returned to the depot or origin if the consignee is not present. True if return is required, False if alternative delivery options should be attempted.',
    `safe_place_description` STRING COMMENT 'Description of a safe place where the parcel can be left if the consignee is not present. Examples include porch, garage, side door, or with a specific neighbor.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether a signature is required upon delivery. True if signature is mandatory, False if delivery can be completed without signature.',
    `signature_type` STRING COMMENT 'The type of signature required for delivery. Specifies whether the consignee must sign, any adult can sign, an indirect signature is acceptable, or an electronic signature is permitted.. Valid values are `CONSIGNEE|ADULT|INDIRECT|ELECTRONIC`',
    `special_access_instructions` STRING COMMENT 'Free-text instructions provided by the consignee for accessing the delivery location. May include gate codes, building entry procedures, parking instructions, or security protocols.',
    `special_handling_notes` STRING COMMENT 'Additional free-text notes or special handling instructions for the delivery. May include fragile handling, temperature requirements, or other consignee-specific requests.',
    `version_number` STRING COMMENT 'Version number of this delivery instruction record. Incremented each time the instruction is modified, supporting optimistic locking and change history.',
    `created_by` STRING COMMENT 'Identifier of the user, system, or process that created this delivery instruction record. May be a user ID, system name, or API client identifier.',
    CONSTRAINT pk_delivery_instruction PRIMARY KEY(`delivery_instruction_id`)
) COMMENT 'Shipper or consignee-specified delivery instructions associated with a consignment. Captures instruction type (LEAVE_AT_DOOR, REQUIRE_SIGNATURE, DELIVER_TO_NEIGHBOUR, LOCKER_DELIVERY, APPOINTMENT_REQUIRED, CALL_BEFORE_DELIVERY, RETURN_IF_ABSENT), preferred delivery time window (start/end), special access instructions, safe place description, alternative delivery address, contact phone for delivery, and instruction source (shipper/consignee/customer portal). Enables last-mile delivery agents to execute D2D delivery per customer preferences and reduces failed delivery attempts.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` (
    `return_shipment_id` BIGINT COMMENT 'Unique identifier for the return shipment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RMA authorizations require employee approval for fraud prevention, return policy compliance, and refund authorization workflows. Tracks who approved the return/refund, distinct from physical processin',
    `consignee_id` BIGINT COMMENT 'Reference to the original consignee (receiver) of the outbound shipment who is now returning the goods.',
    `consignment_id` BIGINT COMMENT 'Reference to the original outbound shipment that this return is associated with. Links to the forward shipment record.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this return shipment.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Return transactions must be recognized in correct fiscal period per return_received_timestamp for revenue reversal timing. Essential for period-end close, revenue recognition compliance, and accurate ',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order. Business justification: Return shipments in e-commerce operations must reference the original fulfillment order for return authorization, refund processing, and inventory restocking. Critical for RMA-to-order matching, retur',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Return shipments executed by specific carriers - required for reverse logistics operations, return label generation, carrier billing, and RMA processing. Normalizes return_carrier_scac_code and return',
    `shipper_profile_id` BIGINT COMMENT 'Reference to the original shipper (sender) who will receive the returned goods.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Return labels are transport documents that must be stored for reprinting, customer service inquiries, carrier disputes, and audit. Real-world returns operations require accessing the actual label docu',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this return shipment record was first created in the system.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this return shipment record was last modified.',
    `original_awb_number` STRING COMMENT 'Air Waybill number of the original outbound shipment that is being returned.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `original_bol_number` STRING COMMENT 'Bill of Lading number of the original outbound shipment that is being returned.. Valid values are `^[A-Z0-9]{6,20}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded or credited to the customer for the returned goods.',
    `refund_currency_code` STRING COMMENT 'Three-letter ISO currency code for the refund amount.. Valid values are `^[A-Z]{3}$`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing and restocking the returned items, if applicable per return policy.',
    `restocking_fee_currency_code` STRING COMMENT 'Three-letter ISO currency code for the restocking fee.. Valid values are `^[A-Z]{3}$`',
    `return_authorized_timestamp` TIMESTAMP COMMENT 'Date and time when the return was officially authorized and RMA number was issued.',
    `return_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the return process was fully completed including inspection, disposition, and refund/credit processing.',
    `return_condition_assessment` STRING COMMENT 'Assessment of the physical condition of the returned goods upon receipt at the return destination. [ENUM-REF-CANDIDATE: undamaged|damaged|missing_items|incomplete|opened|unopened|defective — 7 candidates stripped; promote to reference product]',
    `return_destination_location_code` STRING COMMENT 'Standardized code identifying the specific warehouse, distribution center, or facility where the return will be received.. Valid values are `^[A-Z0-9]{3,10}$`',
    `return_destination_type` STRING COMMENT 'Type of facility where the returned goods will be sent for processing, inspection, restocking, repair, or disposal.. Valid values are `warehouse|supplier|manufacturer|disposal_center|repair_center|distribution_center`',
    `return_disposition_code` STRING COMMENT 'Code indicating the final disposition decision for the returned goods: restock for resale, repair, refurbish, dispose, donate, return to vendor, or scrap. [ENUM-REF-CANDIDATE: restock|repair|refurbish|dispose|donate|return_to_vendor|scrap — 7 candidates stripped; promote to reference product]',
    `return_freight_charge_amount` DECIMAL(18,2) COMMENT 'Freight charge amount for the return shipment, which may be borne by the customer, shipper, or carrier depending on return policy.',
    `return_freight_charge_currency_code` STRING COMMENT 'Three-letter ISO currency code for the return freight charge.. Valid values are `^[A-Z]{3}$`',
    `return_freight_paid_by` STRING COMMENT 'Party responsible for paying the return freight charges: customer, shipper, carrier, or third-party.. Valid values are `customer|shipper|carrier|third_party`',
    `return_initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the return request was first initiated by the customer, shipper, or e-commerce platform.',
    `return_initiator` STRING COMMENT 'Party who initiated the return request: consignee (receiver), shipper (sender), e-commerce platform, carrier, or third-party logistics provider.. Valid values are `consignee|shipper|ecommerce_platform|carrier|third_party`',
    `return_inspection_notes` STRING COMMENT 'Detailed notes from the inspection process documenting the condition, completeness, and quality of the returned items.',
    `return_label_generated_flag` BOOLEAN COMMENT 'Indicates whether a return shipping label has been generated and provided to the customer for the return shipment.',
    `return_label_tracking_number` STRING COMMENT 'Tracking number assigned to the return shipment label for visibility and proof of return.. Valid values are `^[A-Z0-9]{10,35}$`',
    `return_pickup_address_line1` STRING COMMENT 'First line of the address where the return shipment will be picked up from the customer or consignee.',
    `return_pickup_address_line2` STRING COMMENT 'Second line of the return pickup address (suite, apartment, building).',
    `return_pickup_city` STRING COMMENT 'City where the return shipment will be picked up.',
    `return_pickup_country_code` STRING COMMENT 'Three-letter ISO country code for the return pickup location.. Valid values are `^[A-Z]{3}$`',
    `return_pickup_postal_code` STRING COMMENT 'Postal or ZIP code for the return pickup location.',
    `return_pickup_state_province` STRING COMMENT 'State or province where the return shipment will be picked up.',
    `return_policy_reference` STRING COMMENT 'Reference to the specific return policy or terms and conditions governing this return (e.g., 30-day return policy, warranty terms).',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the return as declared by the initiator. [ENUM-REF-CANDIDATE: damaged|defective|wrong_item|not_as_described|customer_remorse|excess_inventory|quality_issue — 7 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Detailed free-text explanation of the return reason provided by the customer or shipper.',
    `return_received_timestamp` TIMESTAMP COMMENT 'Date and time when the returned goods were physically received at the return destination facility.',
    `return_service_type` STRING COMMENT 'Type of return service selected: standard return, expedited return, scheduled pickup, customer drop-off, or prepaid label.. Valid values are `standard|expedited|scheduled_pickup|drop_off|prepaid_label`',
    `return_status` STRING COMMENT 'Current lifecycle status of the return shipment in the reverse logistics workflow. [ENUM-REF-CANDIDATE: initiated|authorized|pickup_scheduled|in_transit|received|inspected|processed|completed|cancelled|rejected — 10 candidates stripped; promote to reference product]',
    `return_transport_mode` STRING COMMENT 'Primary mode of transportation used for the return shipment.. Valid values are `air|ocean|road|rail|parcel|courier`',
    `return_type` STRING COMMENT 'Classification of the return indicating whether it is a full return of all items, partial return of some items, exchange, warranty claim, or product recall.. Valid values are `full|partial|exchange|warranty|recall`',
    `rma_number` STRING COMMENT 'Unique return authorization number issued to the customer or shipper to initiate the return process. Business identifier for the return.. Valid values are `^RMA[0-9]{8,12}$`',
    `wms_return_receipt_number` STRING COMMENT 'Receipt number generated by the warehouse management system when the return is physically received and logged into inventory.. Valid values are `^RR[0-9]{8,12}$`',
    CONSTRAINT pk_return_shipment PRIMARY KEY(`return_shipment_id`)
) COMMENT 'Return merchandise authorization (RMA) and reverse logistics shipment record. Captures return reason code, return authorization number (RMA number), original consignment reference, return initiator (consignee/shipper/e-commerce platform), return type (full/partial), return condition assessment (undamaged/damaged/missing items), return pickup address, return destination (warehouse/supplier/disposal), return service type, return label generated flag, and return status. Supports e-commerce fulfillment reverse logistics workflows and integrates with Manhattan WMS returns processing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` (
    `shipment_sla_commitment_id` BIGINT COMMENT 'Unique identifier for the SLA commitment record applied to a specific consignment. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the master customer contract from which this SLA commitment is derived, if applicable.',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment or consignment to which this SLA commitment applies.',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.contract_rate. Business justification: SLA commitments often tied to specific contracted rates with negotiated transit times and pricing terms. Links service performance obligations to contracted pricing for compliance verification, penalt',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that holds the contractual relationship for this SLA commitment.',
    `rate_card_id` BIGINT COMMENT 'Reference to the rate card or pricing schedule that defines this SLA commitment, if applicable.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual timestamp when the shipment was delivered, used to determine SLA compliance.',
    `breach_penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount applicable if the SLA commitment is breached, in the specified currency.',
    `breach_penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the breach penalty amount.. Valid values are `^[A-Z]{3}$`',
    `breach_penalty_flag` BOOLEAN COMMENT 'Indicates whether financial or service penalties apply if this SLA commitment is breached.',
    `breach_reason_code` STRING COMMENT 'Standardized code indicating the root cause or reason for the SLA breach (e.g., weather delay, customs hold, carrier failure).',
    `breach_reason_description` STRING COMMENT 'Detailed textual description of the circumstances that led to the SLA breach.',
    `business_days_flag` BOOLEAN COMMENT 'Indicates whether the SLA commitment is measured in business days (excluding weekends and holidays) or calendar days.',
    `committed_delivery_date` DATE COMMENT 'The contractually committed date by which the shipment must be delivered to meet the SLA.',
    `committed_delivery_time_window_end` TIMESTAMP COMMENT 'The end of the committed delivery time window, specifying the latest acceptable delivery timestamp to meet SLA.',
    `committed_delivery_time_window_start` TIMESTAMP COMMENT 'The start of the committed delivery time window, specifying the earliest acceptable delivery timestamp.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SLA commitment record was first created in the system.',
    `customs_clearance_included_flag` BOOLEAN COMMENT 'Indicates whether customs clearance time is included within the SLA commitment or excluded from the measurement period.',
    `destination_location_code` STRING COMMENT 'The location code (IATA, UN/LOCODE, or internal) representing the shipment destination for SLA calculation purposes.',
    `force_majeure_flag` BOOLEAN COMMENT 'Indicates whether a force majeure event (natural disaster, war, pandemic, etc.) has been declared that exempts this SLA from breach penalties.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this SLA commitment applies to a shipment containing hazardous materials requiring special handling and compliance.',
    `holiday_calendar_code` STRING COMMENT 'Reference code for the holiday calendar used to calculate business days for this SLA commitment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this SLA commitment record was last modified or updated.',
    `measurement_end_event` STRING COMMENT 'The specific milestone event that marks the end of the SLA measurement period.. Valid values are `delivery|pod_signature|arrival|final_scan`',
    `measurement_start_event` STRING COMMENT 'The specific milestone event that marks the beginning of the SLA measurement period.. Valid values are `pickup|booking_confirmation|departure|customs_clearance`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification has been sent to the customer regarding the SLA status (breach, at-risk, or met).',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA status notification was sent to the customer.',
    `origin_location_code` STRING COMMENT 'The location code (IATA, UN/LOCODE, or internal) representing the shipment origin for SLA calculation purposes.',
    `otd_threshold_percentage` DECIMAL(18,2) COMMENT 'The minimum percentage threshold for on-time delivery performance required to meet the SLA commitment.',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'The target percentage for on-time and in-full delivery performance as specified in the SLA.',
    `pickup_timestamp` TIMESTAMP COMMENT 'The actual or planned timestamp when the shipment was picked up, marking the start of the SLA measurement period.',
    `priority_level` STRING COMMENT 'The priority classification of this SLA commitment indicating urgency and resource allocation requirements.. Valid values are `critical|high|standard|low`',
    `service_level_code` STRING COMMENT 'Standardized service level code representing the delivery speed and service tier (e.g., NDA, 2DA, GRD).',
    `sla_breach_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA commitment was determined to be breached, if applicable.',
    `sla_reference_number` STRING COMMENT 'Externally-known business identifier for this SLA commitment instance, used for tracking and customer communication.',
    `sla_source` STRING COMMENT 'The origin or basis of this SLA commitment, indicating whether it derives from a customer contract, standard rate card, or spot booking.. Valid values are `customer_contract|rate_card|spot_booking|promotional|custom_quote`',
    `sla_status` STRING COMMENT 'Current lifecycle status of the SLA commitment indicating whether it is active, fulfilled, breached, or waived.. Valid values are `active|met|breached|at_risk|waived|cancelled`',
    `sla_type_code` STRING COMMENT 'Classification of the SLA commitment type defining the service tier and delivery speed expectation. [ENUM-REF-CANDIDATE: express_next_day|express_same_day|economy_3day|economy_5day|freight_standard|freight_expedited|custom — 7 candidates stripped; promote to reference product]',
    `sla_version_number` STRING COMMENT 'Version identifier for the SLA template or contract terms from which this commitment instance was created.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this SLA commitment applies to a temperature-controlled or cold-chain shipment with special handling requirements.',
    `transit_time_hours` DECIMAL(18,2) COMMENT 'The committed maximum transit time in hours from pickup to delivery as defined in the SLA.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the person or role who approved the SLA breach penalty waiver.',
    `waiver_approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA breach penalty waiver was officially approved.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the SLA breach penalty has been waived by mutual agreement or due to force majeure conditions.',
    `waiver_reason` STRING COMMENT 'Explanation or justification for waiving the SLA breach penalty, if applicable.',
    CONSTRAINT pk_shipment_sla_commitment PRIMARY KEY(`shipment_sla_commitment_id`)
) COMMENT 'Service Level Agreement commitment record for a specific consignment, defining the contracted delivery performance targets. Captures SLA type (express_next_day, economy_3day, freight_standard, same_day), committed delivery date, committed delivery time window, transit time in hours, OTD threshold percentage, OTIF target, priority level, SLA source (customer contract / rate card / spot booking), breach penalty indicator, and SLA version reference. Distinct from the contract domains SLA templates — this is the instance-level commitment applied to a specific consignment. Enables OTD and OTIF measurement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` (
    `shipment_charge_id` BIGINT COMMENT 'Unique identifier for the shipment charge record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Freight charges must reference the governing contract agreement for rate validation, audit compliance, and dispute resolution. Billing systems validate charges against contracted rates. Essential for ',
    `billing_account_id` BIGINT COMMENT 'Identifier of the customer account responsible for paying this charge.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Freight charges post to specific GL accounts for revenue recognition and financial reporting. gl_account_code is denormalized; proper FK enables accurate P&L classification and audit trail per GAAP/IF',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment to which this charge applies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transport operations allocate freight costs to cost centers for internal management reporting and budget variance analysis. cost_center_code is denormalized; FK enables proper cost allocation and cont',
    `duty_assessment_id` BIGINT COMMENT 'Identifier linking this charge to a specific customs duty assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this charge for billing.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Revenue and expense recognition must occur in correct accounting period per revenue_recognition_date. FK to fiscal_period enables period-end close, cutoff testing, and ensures charges post to open per',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Logistics operations track profitability by service line, lane, and region mapped to profit centers. Essential for segment reporting, EBITDA analysis, and management P&L by business unit per financial',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Some charges are leg-specific (e.g., air freight leg 1 LHR-JFK, ocean freight leg 2 JFK-LAX, fuel surcharge leg 3) while others are consignment-level (e.g., customs duty, insurance). Adding ',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: Freight charges on inbound supplier shipments (freight collect, DDP terms) often appear as line items on supplier invoices. Links freight charge to AP invoice for 3-way match, accrual accuracy, and la',
    `amount` DECIMAL(18,2) COMMENT 'Base monetary value of the charge before any adjustments, taxes, or discounts.',
    `application_level` STRING COMMENT 'The level at which this charge is applied within the shipment hierarchy.. Valid values are `shipment|leg|package|container|pallet`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this charge requires managerial or financial approval before invoicing.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this charge was approved.',
    `audit_timestamp` TIMESTAMP COMMENT 'Date and time when this charge record was last audited or reviewed for accuracy.',
    `basis` STRING COMMENT 'The calculation method or basis on which the charge is determined. [ENUM-REF-CANDIDATE: weight|volume|distance|time|flat_rate|percentage|per_unit — 7 candidates stripped; promote to reference product]',
    `billable_weight_kg` DECIMAL(18,2) COMMENT 'Chargeable weight used for freight calculation, which may be actual weight or dimensional (DIM) weight, whichever is greater.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when this charge was calculated or rated by the system.',
    `carrier_iata_code` STRING COMMENT 'Two or three-character code identifying the air carrier responsible for this charge.. Valid values are `^[A-Z0-9]{2,3}$`',
    `carrier_scac_code` STRING COMMENT 'Four-letter code identifying the carrier responsible for this charge, used primarily for ocean and rail freight.. Valid values are `^[A-Z]{2,4}$`',
    `charge_category` STRING COMMENT 'High-level classification of the charge type for reporting and analysis purposes. [ENUM-REF-CANDIDATE: freight|surcharge|accessorial|duty_tax|insurance|handling|storage|documentation|penalty|discount|other — 11 candidates stripped; promote to reference product]',
    `charge_code` STRING COMMENT 'Standard code identifying the type of charge (e.g., freight, fuel surcharge, handling, customs duty, insurance). Aligns with carrier tariff and internal billing codes.',
    `charge_description` STRING COMMENT 'Human-readable description of the charge, providing additional context beyond the charge code.',
    `charge_status` STRING COMMENT 'Current lifecycle status of the charge in the billing and payment workflow. [ENUM-REF-CANDIDATE: pending|approved|invoiced|paid|disputed|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this charge record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the charge is denominated.. Valid values are `^[A-Z]{3}$`',
    `customs_declaration_number` STRING COMMENT 'Reference number of the customs declaration associated with this charge, if the charge relates to customs duties or fees.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discount applied to this charge, reducing the net payable amount.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this charge is currently under dispute by the customer or payer.',
    `dispute_reason` STRING COMMENT 'Explanation or reason provided for disputing this charge.',
    `invoice_date` DATE COMMENT 'Date on which the invoice containing this charge was issued.',
    `invoice_number` STRING COMMENT 'Reference number of the invoice on which this charge appears or will appear.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this charge record was last modified or updated.',
    `net_charge_amount` DECIMAL(18,2) COMMENT 'Final charge amount after applying discounts and adding taxes. This is the amount invoiced to the customer.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or special instructions related to this charge.',
    `origin_system` STRING COMMENT 'Source system or process that generated or recorded this charge. [ENUM-REF-CANDIDATE: tms|wms|customs|carrier_invoice|manual|rating_engine|erp — 7 candidates stripped; promote to reference product]',
    `payment_term_code` STRING COMMENT 'Indicates who is responsible for paying this charge and when payment is due (e.g., prepaid by shipper, collect from consignee).. Valid values are `prepaid|collect|third_party|freight_collect|freight_prepaid`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity or volume on which the charge is based (e.g., weight in kg, volume in CBM, number of pallets, distance in km).',
    `rate_per_unit` DECIMAL(18,2) COMMENT 'Unit rate applied to the quantity to calculate the base charge amount.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue from this charge is recognized in the financial statements.',
    `service_provider_name` STRING COMMENT 'Name of the carrier, vendor, or service provider who levied or is responsible for this charge.',
    `tariff_code` STRING COMMENT 'Carrier tariff or rate schedule code under which this charge is applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to this charge, including VAT, GST, sales tax, or other applicable taxes.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate of tax applied to the charge amount.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured, determining the basis for charge calculation. [ENUM-REF-CANDIDATE: kg|lb|cbm|m3|pallet|piece|km|mile|teu|container|hour|day — 12 candidates stripped; promote to reference product]',
    `waived_flag` BOOLEAN COMMENT 'Indicates whether this charge has been waived and will not be billed to the customer.',
    `waiver_reason` STRING COMMENT 'Business justification or reason for waiving this charge.',
    CONSTRAINT pk_shipment_charge PRIMARY KEY(`shipment_charge_id`)
) COMMENT 'Shipment-level charge record capturing all freight charges, surcharges, accessorial fees, and customs duty references applied to a consignment. Captures charge code, amount, currency, tax, and any linked customs declaration references.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` (
    `shipment_asn_id` BIGINT COMMENT 'Unique identifier for the Advanced Shipping Notice record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: ASNs document inbound shipments with the carrier performing transport - required for receiving operations, carrier performance tracking, and EDI 856 processing. Normalizes carrier_name and carrier_sca',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment record in the shipment domain.',
    `facility_id` BIGINT COMMENT 'Identifier of the receiving warehouse facility where this ASN will be processed.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order. Business justification: ASNs in e-commerce fulfillment must reference the fulfillment order being shipped to enable warehouse receiving to match inbound shipments to expected orders. Critical for ASN-to-order reconciliation ',
    `trade_party_id` BIGINT COMMENT 'Identifier of the party (shipper or supplier) who originated and sent the ASN.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Advance Ship Notices for inbound supplier shipments must reference the originating PO to enable dock appointment scheduling, cross-docking decisions, automated receiving workflows, and pre-receipt val',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: ASNs notify receiving facilities of incoming shipments. Linking receiver location to network node master enables dock scheduling, capacity planning, facility performance tracking, and inbound logistic',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ASN receipt confirmation requires a receiving clerk to verify physical goods against advance notice. Critical for warehouse accountability, discrepancy resolution (discrepancy_flag/notes), labor produ',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving party acknowledged receipt of the ASN.',
    `actual_receipt_timestamp` TIMESTAMP COMMENT 'Timestamp when the physical shipment was actually received at the warehouse dock.',
    `appointment_number` STRING COMMENT 'Scheduled dock appointment reference number for receiving this ASN.',
    `asn_number` STRING COMMENT 'Externally-known unique identifier for the ASN, typically transmitted via EDI 856 transaction.',
    `asn_status` STRING COMMENT 'Current lifecycle status of the ASN in the receiving workflow.. Valid values are `sent|acknowledged|received|discrepant|cancelled|pending`',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with this ASN shipment.',
    `container_number` STRING COMMENT 'ISO container number if the ASN shipment is containerized.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ASN record was first created in the system.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether discrepancies were found between the ASN and the actual received goods.',
    `discrepancy_notes` STRING COMMENT 'Free-text description of any discrepancies found during receiving (quantity, damage, missing items).',
    `dock_door_number` STRING COMMENT 'Assigned dock door or bay number for receiving this ASN shipment.',
    `edi_transaction_reference` STRING COMMENT 'Reference identifier for the EDI 856 transmission that carried this ASN.',
    `expected_arrival_date` DATE COMMENT 'Planned date when the inbound shipment is expected to arrive at the receiving location for dock scheduling and inbound planning.',
    `expected_arrival_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the inbound shipment is expected to arrive, used for dock appointment scheduling.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this ASN shipment contains dangerous goods requiring special handling.',
    `incoterms_code` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk for this ASN shipment. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `number_of_cartons` STRING COMMENT 'Total count of cartons included in this ASN shipment.',
    `number_of_pallets` STRING COMMENT 'Total count of pallets included in this ASN shipment.',
    `pro_number` STRING COMMENT 'Freight bill number assigned by the carrier for LTL or FTL shipments.',
    `receiver_party_name` STRING COMMENT 'Name of the consignee or receiving warehouse.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer for this ASN shipment.',
    `sender_location_code` STRING COMMENT 'Code identifying the origin facility or warehouse from which the shipment is dispatched.',
    `sender_party_name` STRING COMMENT 'Name of the shipper or supplier who sent the ASN.',
    `ship_date` DATE COMMENT 'Date when the shipment was dispatched from the sender location.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements during receiving and put-away.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this ASN shipment requires temperature-controlled handling.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the entire ASN shipment in cubic meters, used for warehouse space planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the entire ASN shipment in kilograms.',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the shipment associated with this ASN.',
    `trailer_number` STRING COMMENT 'Trailer or vehicle identification number used to transport this ASN shipment.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN was transmitted via EDI to the receiving party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ASN record was last modified.',
    CONSTRAINT pk_shipment_asn PRIMARY KEY(`shipment_asn_id`)
) COMMENT 'Advanced Shipping Notice (ASN) record sent by a shipper or supplier to notify the consignee or warehouse of an inbound shipment. Captures ASN number, sender party, receiver party, expected arrival date, number of cartons/pallets, total weight, total CBM, SKU-level line items (SKU code, quantity, unit of measure), purchase order references, ASN status (sent/acknowledged/received/discrepant), and EDI transmission reference. Sourced via EDI 856 transactions. Enables Manhattan WMS inbound receiving planning and dock scheduling.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` (
    `freight_manifest_id` BIGINT COMMENT 'Unique identifier for the freight manifest record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Freight manifests are carrier-specific consolidations for line-haul movements - essential for carrier billing, capacity planning, and manifest transmission. Normalizes carrier_scac_code/carrier_iata_c',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: Freight manifest is the physical execution artifact (vehicle/flight/vessel load) of a commercial consolidation in NVOCC and freight forwarding operations. Links manifest to its commercial consolidatio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight manifests with manifest_cost_amount represent consolidated transport costs allocated to cost centers (by route, hub, carrier). FK enables transport cost allocation, budget tracking, and operat',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Freight manifests originating from or destined to fulfillment centers require this link for manifest routing, capacity planning, and cross-dock operations. Enables fulfillment center load planning and',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this manifest record in the TMS.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Freight manifests are loaded onto specific vehicles/containers for transport. Fundamental to freight operations for load planning, asset tracking, customs clearance, and manifest reconciliation. vehic',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Freight manifests are regulatory transport documents required for customs, carrier acceptance, and cross-border compliance. Operations must store, version, and retrieve the formal manifest document ar',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the manifest load arrived at the destination facility, captured from TMS or carrier systems.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the manifest load departed from the origin facility, captured from TMS or carrier systems.',
    `carbon_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated or calculated carbon dioxide equivalent emissions (CO2e) for this manifest transport leg, supporting sustainability reporting per GHG Protocol and CORSIA.',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether this manifest crosses international borders and requires customs clearance at origin or destination.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether this manifest contains any dangerous goods (hazmat) requiring special handling and documentation per IMDG or IATA DGR.',
    `delay_duration_minutes` STRING COMMENT 'Total delay duration in minutes, calculated as the difference between planned and actual departure or arrival times.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for any departure or arrival delay (e.g., weather, customs hold, mechanical failure).',
    `destination_facility_code` STRING COMMENT 'Code identifying the warehouse, terminal, port, or distribution center where the manifest load is destined.',
    `destination_facility_name` STRING COMMENT 'Full name of the destination facility, terminal, or port where the manifest will be unloaded.',
    `equipment_type_code` STRING COMMENT 'Code identifying the type of transport equipment used (e.g., 20ft container, 40ft container, reefer, flatbed, dry van) per ISO 6346 or industry standards.',
    `flight_number` STRING COMMENT 'Airline flight number for air freight manifests, combining carrier code and flight number (e.g., AA1234).',
    `gps_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether real-time GPS tracking is enabled for this manifest via FourKites or other visibility platforms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was last updated or modified.',
    `load_plan_reference` STRING COMMENT 'Reference identifier to the load optimization plan generated by Oracle TMS or SAP TM that produced this manifest.',
    `manifest_closed_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest was closed and locked for departure, preventing further additions or changes.',
    `manifest_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest was marked as completed after successful delivery and unloading at destination.',
    `manifest_cost_amount` DECIMAL(18,2) COMMENT 'Total transportation cost allocated to this manifest, including carrier charges, fuel surcharges, and accessorial fees.',
    `manifest_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the manifest cost amount.. Valid values are `^[A-Z]{3}$`',
    `manifest_created_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was first created in the TMS or WMS system.',
    `manifest_number` STRING COMMENT 'Externally-known unique manifest number assigned by the carrier or TMS for this consolidated load. Used for carrier handover documentation and regulatory compliance.',
    `manifest_status` STRING COMMENT 'Current lifecycle status of the manifest indicating its operational state from creation through completion. [ENUM-REF-CANDIDATE: draft|open|closed|departed|in_transit|arrived|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `origin_facility_code` STRING COMMENT 'Code identifying the warehouse, terminal, port, or distribution center where the manifest load originates.',
    `origin_facility_name` STRING COMMENT 'Full name of the origin facility, terminal, or port where the manifest is loaded.',
    `planned_arrival_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the manifest load is expected to arrive at the destination facility.',
    `planned_departure_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the manifest load is planned to depart from the origin facility.',
    `predicted_eta_timestamp` TIMESTAMP COMMENT 'Real-time predicted arrival timestamp generated by visibility platforms such as FourKites based on GPS tracking and predictive analytics.',
    `route_code` STRING COMMENT 'Identifier for the planned transportation route or service lane assigned to this manifest by the TMS.',
    `seal_number` STRING COMMENT 'Unique seal number applied by the carrier to secure the container or trailer, used for tamper detection and security compliance (C-TPAT, AEO).',
    `service_level_code` STRING COMMENT 'Code representing the service level commitment for this manifest (e.g., express, standard, economy) tied to SLA requirements.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this manifest includes temperature-sensitive cargo requiring refrigerated or climate-controlled transport.',
    `total_chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Total chargeable weight for billing purposes, calculated as the greater of actual weight or dimensional (DIM) weight, summed across all consignments.',
    `total_consignments` STRING COMMENT 'Total number of individual consignments (AWBs, BOLs, HAWBs) consolidated into this manifest.',
    `total_pieces` STRING COMMENT 'Total number of individual pieces, packages, or handling units loaded onto this manifest across all consignments.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of all consignments on this manifest, measured in cubic meters, used for load optimization and capacity planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all consignments on this manifest, measured in kilograms.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this manifest (air, ocean, road, rail, multimodal, or parcel express).. Valid values are `air|ocean|road|rail|multimodal|parcel`',
    `vessel_name` STRING COMMENT 'Name of the ocean vessel or aircraft carrying this manifest for sea or air freight.',
    `voyage_number` STRING COMMENT 'Vessel voyage identifier for ocean freight manifests, assigned by the shipping line.',
    CONSTRAINT pk_freight_manifest PRIMARY KEY(`freight_manifest_id`)
) COMMENT 'Freight manifest record consolidating all consignments loaded onto a specific transport vehicle, vessel, or aircraft for a given departure. Captures manifest number, transport mode, vehicle/vessel/flight reference, origin facility, destination facility, departure date, total pieces, total weight, total CBM, number of consignments, dangerous goods indicator, temperature-controlled indicator, manifest status (open/closed/departed/arrived), and carrier seal number. Sourced from SAP TM and Oracle TMS load optimization outputs. Enables load reconciliation and carrier handover documentation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` (
    `transit_hub_event_id` BIGINT COMMENT 'Unique identifier for the transit hub event record. Primary key for this entity.',
    `consignment_id` BIGINT COMMENT 'Reference to the consignment (AWB/BOL/HAWB/MAWB) being processed. Links to the consignment entity for document traceability.',
    `employee_id` BIGINT COMMENT 'Employee or system operator identifier who performed or recorded the hub event. Used for accountability and labor tracking.',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Transit hub events by definition occur at specific hub/gateway facilities - fundamental for sort operations, hub throughput tracking, and network performance analysis. Normalizes hub_facility_code and',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Hub events occur at specific network nodes (terminals, sort facilities). Essential for hub performance analysis, dwell time measurement, throughput tracking, and network optimization. Links operationa',
    `freight_manifest_id` BIGINT COMMENT 'Foreign key linking to shipment.freight_manifest. Business justification: Transit hub events record when consignments are loaded onto outbound vehicles. The product currently has outbound_manifest_number (STRING) which should be normalized to a FK. Adding outbound_freight_m',
    `shipment_consignment_id` BIGINT COMMENT 'Reference to the shipment being processed through the hub. Links this hub event to the parent shipment entity.',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Transit hub events (sorting, loading, unloading) occur as part of specific transport legs. A hub event at LHR during a multi-leg shipment belongs to the leg that passes through LHR. Nullable because s',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hub event record was first created in the data system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `customs_clearance_flag` BOOLEAN COMMENT 'Boolean indicator whether customs clearance processing occurred at this hub during this event. True if customs processing, False otherwise.',
    `customs_status` STRING COMMENT 'Status of customs clearance if customs_clearance_flag is True. CLEARED: customs released. PENDING: awaiting clearance. HELD: customs hold. INSPECTION_REQUIRED: physical inspection requested. Null if no customs processing.. Valid values are `CLEARED|PENDING|HELD|INSPECTION_REQUIRED`',
    `damage_description` STRING COMMENT 'Free-text description of the damage observed, entered by the operator. Null if no damage detected.',
    `damage_detected_flag` BOOLEAN COMMENT 'Boolean indicator whether physical damage to the shipment or packaging was detected during this hub event. True if damage detected, False otherwise.',
    `event_date` DATE COMMENT 'Calendar date of the hub event, derived from event_timestamp for day-level reporting and partitioning. Format: yyyy-MM-dd.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hub event occurred, captured from the WMS or sortation system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Type of hub operational event. INBOUND_SCAN: shipment scanned upon arrival at hub. SORTED: shipment processed through sortation system. LOADED_OUTBOUND: shipment loaded onto outbound vehicle. TRANSFERRED: shipment transferred to another carrier or facility. HELD: shipment placed on hold. RETURNED_TO_SENDER: shipment marked for return.. Valid values are `INBOUND_SCAN|SORTED|LOADED_OUTBOUND|TRANSFERRED|HELD|RETURNED_TO_SENDER`',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator whether this hub event represents an exception condition (hold, damage, delay) requiring intervention. True if exception, False if normal processing.',
    `exception_severity` STRING COMMENT 'Severity level of the exception if exception_flag is True. LOW: minor delay. MEDIUM: requires attention within shift. HIGH: impacts SLA. CRITICAL: immediate escalation required. Null for non-exception events.. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the hub facility where the event occurred, for geospatial analysis and mapping.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the hub facility where the event occurred, for geospatial analysis and mapping.',
    `handling_unit_barcode` STRING COMMENT 'Barcode or RFID tag identifier of the physical handling unit (parcel, pallet, container) scanned during the event. Used for item-level tracking within the hub.. Valid values are `^[A-Z0-9]{10,30}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator whether the shipment is classified as dangerous goods or hazardous materials, requiring special handling during hub operations. True if hazmat, False otherwise.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating why a shipment was placed on hold during a HELD event. Null for non-hold events. CUSTOMS_HOLD: awaiting customs clearance. DAMAGED: physical damage detected. ADDRESS_CORRECTION: address validation required. PAYMENT_REQUIRED: COD or duty payment pending. SECURITY_SCREENING: additional security checks. WEATHER_DELAY: weather-related hold.. Valid values are `CUSTOMS_HOLD|DAMAGED|ADDRESS_CORRECTION|PAYMENT_REQUIRED|SECURITY_SCREENING|WEATHER_DELAY`',
    `hold_reason_description` STRING COMMENT 'Free-text description providing additional context for the hold reason, entered by the operator.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage recorded during the hub event, applicable for humidity-sensitive shipments.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the operator regarding this hub event, providing additional context not captured in structured fields.',
    `operator_name` STRING COMMENT 'Full name of the operator who performed the hub event, for human-readable audit trails.',
    `outbound_vehicle_number` STRING COMMENT 'Identifier of the vehicle (truck, trailer, aircraft, container) onto which the shipment was loaded during LOADED_OUTBOUND event.. Valid values are `^[A-Z0-9]{5,15}$`',
    `photo_captured_flag` BOOLEAN COMMENT 'Boolean indicator whether a photo or image of the shipment was captured during this hub event (e.g., for damage documentation, security, or quality control). True if photo captured, False otherwise.',
    `photo_reference_code` STRING COMMENT 'Unique identifier or storage path reference for the photo captured during the hub event. Null if no photo captured.. Valid values are `^[A-Z0-9]{10,30}$`',
    `processing_duration_seconds` STRING COMMENT 'Time in seconds taken to complete this hub event, measured from scan-in to scan-out or event completion. Used for labor productivity and throughput analysis.',
    `security_screening_flag` BOOLEAN COMMENT 'Boolean indicator whether the shipment underwent security screening (X-ray, physical inspection) during this hub event. True if screened, False otherwise.',
    `security_screening_result` STRING COMMENT 'Result of the security screening if performed. PASSED: cleared for onward movement. FAILED: security concern identified. MANUAL_REVIEW: requires manual inspection. Null if not screened.. Valid values are `PASSED|FAILED|MANUAL_REVIEW`',
    `sort_destination_code` STRING COMMENT 'Destination facility or zone code assigned by the sortation system, indicating where the shipment should be routed next.. Valid values are `^[A-Z0-9]{3,10}$`',
    `sort_lane_code` STRING COMMENT 'Identifier of the sortation lane, belt, or chute where the shipment was routed during the SORTED event. Null for non-sortation events.. Valid values are `^[A-Z0-9]{1,10}$`',
    `source_system` STRING COMMENT 'Name of the operational system that generated this hub event record. MANHATTAN_WMS: warehouse management system. SAP_TM: transportation management. SORTATION_SYSTEM: automated sortation equipment. HANDHELD_SCANNER: mobile scanning device. AUTOMATED_SORTER: high-speed sorter.. Valid values are `MANHATTAN_WMS|SAP_TM|SORTATION_SYSTEM|HANDHELD_SCANNER|AUTOMATED_SORTER`',
    `source_system_transaction_reference` STRING COMMENT 'Unique transaction or event identifier from the source system, used for traceability and reconciliation back to the originating system.. Valid values are `^[A-Z0-9]{10,30}$`',
    `special_handling_code` STRING COMMENT 'Code indicating special handling requirements for the shipment during hub operations. FRAGILE: handle with care. PERISHABLE: time/temperature sensitive. HIGH_VALUE: security escort required. LIVE_ANIMALS: live cargo. MEDICAL: medical supplies. PRIORITY: expedited processing.. Valid values are `FRAGILE|PERISHABLE|HIGH_VALUE|LIVE_ANIMALS|MEDICAL|PRIORITY`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient or shipment temperature in degrees Celsius recorded during the hub event, applicable for temperature-controlled shipments.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous material classification, applicable if hazmat_flag is True. Format: UN followed by 4 digits (e.g., UN1203).. Valid values are `^UN[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this hub event record was last modified in the data system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Volume of the handling unit in cubic meters, captured during the hub event if dimensioning equipment is used.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Actual weight of the handling unit in kilograms, captured during the hub event if weigh-in-motion or scale scanning is performed.',
    CONSTRAINT pk_transit_hub_event PRIMARY KEY(`transit_hub_event_id`)
) COMMENT 'Records operational events at transit hubs and sorting facilities during a shipments journey — including inbound scan, sortation, outbound loading, and transfer events. Captures hub facility code, event type (INBOUND_SCAN, SORTED, LOADED_OUTBOUND, TRANSFERRED, HELD, RETURNED_TO_SENDER), event timestamp, sort lane/belt assignment, outbound manifest reference, handling unit barcode, operator ID, and any hold reason code. Distinct from tracking_event (carrier-reported external events) — this captures internal hub operational processing events from WMS and sortation systems.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` (
    `shipment_document_id` BIGINT COMMENT 'Unique identifier for the shipment document record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Shipping documents (commercial invoices, certificates of origin, insurance certificates) often reference the governing trade agreement for customs compliance, preferential tariff claims, and regulator',
    `consignment_id` BIGINT COMMENT 'Reference to the parent consignment (shipment) to which this document is attached. Links the document to the primary shipment record.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration record to which this document is attached as supporting evidence. Nullable if not linked to a specific declaration.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that uploaded or submitted the document. Used for audit trail and accountability. Confidential as it may identify internal or customer personnel.',
    `superseded_by_document_shipment_document_id` BIGINT COMMENT 'Reference to the shipment_document_id of the newer version that supersedes this document. Nullable if this is the current version.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Shipment_document tracks document associations for consignments but lacks FK to the actual document record. Real-world operations require retrieving document content for customs clearance, carrier han',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the document was approved or accepted by the reviewing authority (customs, carrier, compliance officer). Nullable if not yet approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether the document meets all regulatory and carrier compliance requirements. True=compliant, False=non-compliant or pending review.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this shipment document record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document in the shipment workflow. Pending=awaiting upload or review, Submitted=sent to customs or carrier, Approved=accepted by authority, Rejected=not accepted, Expired=past validity date, Cancelled=voided by shipper or system.. Valid values are `pending|submitted|approved|rejected|expired|cancelled`',
    `expiry_date` DATE COMMENT 'The date on which the document expires or is no longer valid for use in customs clearance or carrier acceptance. Nullable for documents without expiration. Format: yyyy-MM-dd.',
    `file_format` STRING COMMENT 'File format or MIME type of the stored document. PDF=Portable Document Format, JPEG/PNG/TIFF=image formats, XML=structured data, EDI=Electronic Data Interchange message.. Valid values are `PDF|JPEG|PNG|TIFF|XML|EDI`',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes. Used for storage management and upload validation.',
    `file_uri` STRING COMMENT 'Uniform Resource Identifier (URI) or file path pointing to the stored digital copy of the document in the document management system or cloud storage. Confidential as it may expose internal storage architecture.',
    `hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the document file content, used for integrity verification and tamper detection.',
    `issue_date` DATE COMMENT 'The date on which the document was officially issued or certified by the issuing authority. Format: yyyy-MM-dd.',
    `issuing_authority_name` STRING COMMENT 'Name of the organization, government agency, or entity that issued or certified the document (e.g., Chamber of Commerce, Ministry of Agriculture, Insurance Company).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the document was issued.. Valid values are `^[A-Z]{3}$`',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language in which the document is written (e.g., en=English, es=Spanish, zh=Chinese).. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this shipment document record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mandatory_flag` BOOLEAN COMMENT 'Boolean indicator whether this document is mandatory for the shipment to proceed (e.g., commercial invoice for customs clearance). True=mandatory, False=optional or supplementary.',
    `reference_number` STRING COMMENT 'The unique reference or control number assigned to this document by the issuing authority or system. Used for tracking and retrieval.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for document rejection. INCOMPLETE=missing required fields, EXPIRED=document past validity, INVALID=does not meet regulatory requirements, MISMATCH=data does not match shipment details, ILLEGIBLE=poor quality scan, UNAUTHORIZED=issuer not recognized.. Valid values are `INCOMPLETE|EXPIRED|INVALID|MISMATCH|ILLEGIBLE|UNAUTHORIZED`',
    `rejection_reason_description` STRING COMMENT 'Free-text explanation provided by the reviewing authority detailing why the document was rejected and what corrective action is required.',
    `rejection_timestamp` TIMESTAMP COMMENT 'The date and time when the document was rejected by the reviewing authority. Nullable if not rejected. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `retention_expiry_date` DATE COMMENT 'The date after which the document may be archived or purged according to regulatory retention policies (e.g., 7 years for customs records). Format: yyyy-MM-dd.',
    `reviewed_by_authority_name` STRING COMMENT 'Name of the customs office, carrier, or compliance authority that reviewed and approved or rejected the document.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the document was officially submitted to customs, carrier, or other external authority for review. Nullable if not yet submitted. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `translation_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the document requires translation into the destination country language for customs clearance or carrier acceptance. True=translation required, False=no translation needed.',
    `type_code` STRING COMMENT 'Classification code identifying the type of document. CINV=Commercial Invoice, PLIST=Packing List, COO=Certificate of Origin, PHYTO=Phytosanitary Certificate, DGM=Dangerous Goods Manifest, INSC=Insurance Certificate. [ENUM-REF-CANDIDATE: CINV|PLIST|COO|PHYTO|DGM|INSC|LOC|EXPL|IMPP|CUST|HAWB|MAWB|BOL|AWB|POD|CMR|TIR — promote to reference product]. Valid values are `CINV|PLIST|COO|PHYTO|DGM|INSC`',
    `upload_source` STRING COMMENT 'The channel or system through which the document was uploaded or received. Shipper_portal=customer web portal, EDI=Electronic Data Interchange, API=Application Programming Interface integration, Email=email attachment, Manual=manual entry by operations, Carrier_system=received from carrier system.. Valid values are `shipper_portal|edi|api|email|manual|carrier_system`',
    `upload_timestamp` TIMESTAMP COMMENT 'The date and time when the document was uploaded or received into the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `version_number` STRING COMMENT 'Sequential version number of the document if it has been revised or resubmitted. Starts at 1 for the original submission and increments with each revision.',
    CONSTRAINT pk_shipment_document PRIMARY KEY(`shipment_document_id`)
) COMMENT 'Registry of all transport and trade documents associated with a consignment beyond the primary AWB/BOL. Captures document type (commercial invoice, packing list, certificate of origin, phytosanitary certificate, dangerous goods manifest, insurance certificate, letter of credit, export license, import permit), document reference number, issuing authority, issue date, expiry date, document file URI, upload source, and document status (pending/submitted/approved/rejected). Provides a complete document envelope for a shipment enabling customs compliance and carrier acceptance checks.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` (
    `temperature_log_id` BIGINT COMMENT 'Unique identifier for the temperature log record. Primary key for the temperature monitoring event.',
    `consignment_id` BIGINT COMMENT 'Reference to the parent shipment being monitored for temperature compliance. Links this temperature reading to the specific shipment in cold-chain transit.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operator, driver, or personnel responsible for the shipment at the time of temperature reading. Used for accountability and training purposes.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Temperature-controlled shipments (pharma, food, biologics) require sensor calibration certificates for GDP compliance, regulatory audits, and quality assurance. Real-world cold chain operations must l',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Temperature monitoring occurs during transport legs, with each leg potentially having different vehicle/container/carrier. Adding shipment_leg_id enables leg-level cold-chain compliance tracking and i',
    `alert_recipient_list` STRING COMMENT 'Comma-separated list of email addresses or user IDs who were notified when a temperature breach alert was triggered. Used for audit trail and escalation tracking.',
    `alert_triggered_flag` BOOLEAN COMMENT 'Indicates whether this temperature reading triggered an automated alert to operations or customer service teams. True if alert was sent, false if no alert required.',
    `breach_duration_minutes` STRING COMMENT 'Cumulative duration in minutes that the temperature has been outside the acceptable range during the current breach event. Used for compliance reporting and insurance claims.',
    `breach_flag` BOOLEAN COMMENT 'Indicates whether the measured temperature falls outside the acceptable setpoint range (min/max). True if temperature is out of compliance, false if within acceptable range.',
    `breach_severity_code` STRING COMMENT 'Classification of the temperature breach severity based on deviation magnitude and duration. Minor: slight deviation, Moderate: significant deviation, Critical: severe deviation requiring immediate action.. Valid values are `minor|moderate|critical`',
    `commodity_type` STRING COMMENT 'Category of temperature-sensitive cargo being monitored. Determines applicable regulatory requirements and acceptable temperature ranges for compliance verification. [ENUM-REF-CANDIDATE: pharmaceutical|perishable_food|chemical|biological|vaccine|frozen_goods|chilled_goods — 7 candidates stripped; promote to reference product]',
    `container_number` STRING COMMENT 'ISO container number for ocean or intermodal freight shipments. Links temperature readings to specific reefer containers for FCL and LCL cold-chain cargo.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action taken in response to a temperature breach event. Documents operational response for compliance reporting and insurance claims.',
    `corrective_action_timestamp` TIMESTAMP COMMENT 'Date and time when corrective action was initiated in response to a temperature breach. Used to calculate response time for SLA compliance and operational performance metrics.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated quality score (0.00 to 1.00) assessing the reliability of this temperature reading based on sensor calibration status, battery level, signal strength, and data completeness.',
    `data_source` STRING COMMENT 'Origin system or method by which the temperature reading was captured. Distinguishes between automated IoT sensors, RFID tags, manual operator entry, and system integrations.. Valid values are `iot_sensor|rfid_tag|manual_entry|bluetooth_beacon|data_logger|tms_integration`',
    `facility_code` STRING COMMENT 'Unique code of the warehouse, terminal, or facility where the temperature reading was captured. Populated when location_type is facility-based, null for in-transit readings.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate where the temperature reading was captured. Populated for in-transit readings from GPS-enabled sensors, null for facility-based readings.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate where the temperature reading was captured. Populated for in-transit readings from GPS-enabled sensors, null for facility-based readings.',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'Relative humidity percentage measured at the time of temperature reading. Critical for pharmaceutical shipments and moisture-sensitive cargo integrity.',
    `location_type` STRING COMMENT 'Type of location where the temperature reading was captured. Distinguishes between facility-based readings and in-transit GPS-based readings.. Valid values are `facility|in_transit|warehouse|terminal|customs|delivery_vehicle`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the temperature reading was captured by the sensor device. Critical for cold-chain compliance verification and breach timeline analysis.',
    `package_reference_number` STRING COMMENT 'Specific package or container identifier within the shipment being monitored. Enables granular tracking when a shipment contains multiple temperature-controlled units.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this temperature log record was first inserted into the data platform. Used for data lineage tracking and audit trail purposes.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this temperature reading meets all applicable regulatory requirements for the commodity type. True if compliant, false if non-compliant or requires review.',
    `sensor_battery_level_percentage` DECIMAL(18,2) COMMENT 'Remaining battery charge percentage of the IoT sensor device at the time of reading. Used for predictive maintenance and data quality assurance to prevent sensor failures.',
    `sensor_calibration_date` DATE COMMENT 'Date when the sensor device was last calibrated for accuracy. Critical for regulatory compliance and ensuring measurement reliability for pharmaceutical and perishable cargo.',
    `sensor_device_code` STRING COMMENT 'Unique identifier of the IoT sensor or RFID device that captured this temperature reading. Used for device calibration tracking and data quality assurance.',
    `setpoint_max_celsius` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable temperature range for this shipment as defined by the shipper or regulatory requirement. Used to determine temperature breach conditions.',
    `setpoint_min_celsius` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable temperature range for this shipment as defined by the shipper or regulatory requirement. Used to determine temperature breach conditions.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Measured temperature value in degrees Celsius at the time of reading. Core metric for cold-chain integrity verification for pharmaceutical and perishable cargo.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the temperature reading was transmitted from the sensor device to the central monitoring system. Used to calculate data latency and identify transmission delays.',
    `vehicle_reference_number` STRING COMMENT 'Identifier of the transport vehicle (truck, aircraft, vessel) carrying the shipment at the time of temperature reading. Links temperature data to fleet management systems.',
    CONSTRAINT pk_temperature_log PRIMARY KEY(`temperature_log_id`)
) COMMENT 'IoT/sensor temperature monitoring log for cold-chain and temperature-controlled shipments. Captures sensor device ID, shipment/package reference, measurement timestamp, temperature reading (°C), humidity reading (%), set point temperature range (min/max), breach flag (true if outside acceptable range), breach duration in minutes, location at time of reading (GPS coordinates or facility code), and data source (IoT device/RFID/manual entry). Enables cold-chain compliance verification, pharmaceutical and perishable cargo integrity assurance, and insurance claim evidence.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` (
    `shipment_driver_assignment_id` BIGINT COMMENT 'Primary key for shipment_driver_assignment',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to the consignment record that this driver is assigned to handle for a specific leg or segment of the shipment journey.',
    `fleet_driver_assignment_id` BIGINT COMMENT 'Unique identifier for this driver assignment record. Primary key for the association.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to the driver profile record of the driver assigned to this consignment leg.',
    `plan_id` BIGINT COMMENT 'Foreign key reference to the planned route or route template used for this assignment leg. Links to route planning system. Used for route adherence analysis and optimization.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key reference to the vehicle asset used by the driver for this assignment. Links to the fleet vehicle master. Used for vehicle utilization tracking and maintenance scheduling.',
    `actual_departure_datetime` TIMESTAMP COMMENT 'The actual date and time when the driver departed with the consignment for this leg. Used for performance tracking and variance analysis against planned departure.',
    `actual_return_datetime` TIMESTAMP COMMENT 'The actual date and time when the driver completed this assignment leg and returned or handed off the consignment. Used for performance tracking and labor hour calculation.',
    `assignment_status` STRING COMMENT 'Current operational status of this driver assignment: scheduled (planned but not yet dispatched), dispatched (driver notified and en route), in_transit (actively transporting), completed (leg finished successfully), cancelled (assignment cancelled before completion), failed (assignment could not be completed). Used for real-time operational visibility and exception management.',
    `assignment_type` STRING COMMENT 'The type of assignment or leg that this driver is responsible for: pickup (origin collection), linehaul (long-distance transport), delivery (final mile), relay (driver handoff point), handoff (transfer between drivers), consolidation (multi-pickup route). Defines the drivers role in the consignment lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this driver assignment record was created in the system. Used for audit trail and operational reporting.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment was dispatched to the driver (notification sent, assignment confirmed). Used for dispatch efficiency tracking and driver response time analysis.',
    `distance_actual_km` DECIMAL(18,2) COMMENT 'Actual distance traveled by the driver in kilometers during this assignment leg. Captured from vehicle telematics or GPS tracking. Used for fuel cost allocation, route optimization analysis, and driver performance metrics.',
    `driving_hours` DECIMAL(18,2) COMMENT 'Total hours the driver spent actively driving during this assignment leg. Used for labor cost allocation, compliance monitoring (hours of service regulations), and driver performance analysis. Calculated from telematics or driver logs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this driver assignment record was last modified. Used for change tracking and data freshness monitoring.',
    `planned_departure_datetime` TIMESTAMP COMMENT 'The scheduled date and time when the driver is planned to depart with the consignment for this leg. Used for dispatch planning and SLA management.',
    `planned_return_datetime` TIMESTAMP COMMENT 'The scheduled date and time when the driver is planned to return or complete this assignment leg. Used for route planning and driver availability forecasting.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this driver assignment record. Used for audit trail and accountability.',
    CONSTRAINT pk_shipment_driver_assignment PRIMARY KEY(`shipment_driver_assignment_id`)
) COMMENT 'This association product represents the operational assignment of a driver to a consignment for a specific leg or segment of the shipment journey. It captures the driver scheduling, dispatch, and performance tracking for each driver-consignment pairing. Each record links one consignment to one driver with attributes that exist only in the context of this specific assignment, including planned and actual departure/return times, assignment status, driving hours, and distance traveled. Critical for driver scheduling, labor cost allocation, compliance monitoring, and operational performance analysis.. Existence Justification: In Transport Shipping logistics operations, consignments frequently require multiple drivers across their journey due to relay operations, handoffs between pickup/linehaul/delivery legs, and consolidated routing where drivers handle multiple consignments per shift. Conversely, each driver is assigned to multiple consignments throughout their shift or workday. The business actively manages these assignments as operational records with specific attributes like assignment type, planned/actual departure times, driving hours, and distance traveled.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` (
    `manifest_line_item_id` BIGINT COMMENT 'Unique identifier for this manifest line item record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to the consignment that is loaded onto this manifest',
    `freight_manifest_id` BIGINT COMMENT 'Foreign key linking to the freight manifest that this consignment is loaded onto',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest line item record was first created in the TMS or WMS system.',
    `handling_notes` STRING COMMENT 'Free-text notes specific to the handling of this consignment on this manifest, such as special handling instructions, damage observations, or loading exceptions. Explicitly identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest line item record was last modified.',
    `line_item_status` STRING COMMENT 'Current status of this manifest line item indicating its operational state (planned, loaded, in_transit, unloaded, exception). Tracks the lifecycle of this specific consignment on this specific manifest.',
    `load_position` STRING COMMENT 'Physical position or location where this consignment is loaded within the transport equipment (e.g., container position, pallet location, bay/row/tier). Explicitly identified in detection phase relationship data.',
    `loaded_timestamp` TIMESTAMP COMMENT 'Date and time when this specific consignment was physically loaded onto the manifest. Explicitly identified in detection phase relationship data.',
    `manifest_sequence_number` STRING COMMENT 'Sequential line number of this consignment on the manifest, used for customs documentation and loading order reference. Explicitly identified in detection phase relationship data.',
    `piece_count_on_manifest` STRING COMMENT 'Number of pieces from this consignment that were actually loaded onto this specific manifest. May differ from consignment.number_of_pieces if the consignment is split across multiple manifests. Explicitly identified in detection phase relationship data.',
    `unloaded_timestamp` TIMESTAMP COMMENT 'Date and time when this specific consignment was physically unloaded from the manifest at the destination facility. Explicitly identified in detection phase relationship data.',
    `weight_on_manifest_kg` DECIMAL(18,2) COMMENT 'Actual weight in kilograms of the pieces from this consignment loaded onto this specific manifest. May differ from consignment.declared_weight_kg if the consignment is split across multiple manifests. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_manifest_line_item PRIMARY KEY(`manifest_line_item_id`)
) COMMENT 'This association product represents the operational loading record between a freight manifest and a consignment. It captures the physical loading event when a specific consignment is added to a specific manifest, including load sequencing, handling timestamps, piece counts, and weight at the time of loading. Each record links one freight manifest to one consignment with attributes that exist only in the context of this loading relationship. This is the legal line-item record required for customs documentation and carrier handover.. Existence Justification: In logistics operations, a freight manifest consolidates multiple consignments onto a single transport asset (aircraft, vessel, truck), and a single consignment can be split across multiple manifests when it travels through multiple legs or is too large for a single load. The manifest line item is a legally required operational record that captures the loading event, including sequence, position, timestamps, and actual pieces/weight loaded. This is a core operational M:N relationship that logistics staff actively manage during manifest creation, load planning, and customs documentation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` (
    `consignment_accessorial_application_id` BIGINT COMMENT 'Unique identifier for this specific application of an accessorial charge to a consignment. Primary key for the association.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to the accessorial charge definition from the master catalog. References the charge type, calculation basis, and standard rates.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the customer dispute or claims case ID if this charge has been disputed. Links to the claims management system for resolution tracking.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to the consignment that incurred this accessorial charge. References the core shipment booking record.',
    `invoice_id` BIGINT COMMENT 'Foreign key to the invoice on which this accessorial charge appears. Null if the charge has not yet been invoiced or if it was waived before invoicing. Links to the billing domain invoice product.',
    `application_status` STRING COMMENT 'Lifecycle status of this accessorial charge application. Pending: calculated but not yet finalized. Applied: finalized and ready for invoicing. Invoiced: included on customer invoice. Waived: charge waived and not billed. Disputed: under customer dispute. Reversed: charge reversed due to billing error.',
    `application_timestamp` TIMESTAMP COMMENT 'The date and time when this accessorial charge was applied to the consignment. Typically set by the rating engine during shipment rating or by billing systems during invoice generation. Critical for audit trails and dispute resolution.',
    `applied_charge_amount` DECIMAL(18,2) COMMENT 'The actual charge amount applied to this consignment for this accessorial. May differ from the catalog charge_amount due to customer-specific contract rates, negotiated discounts, or manual adjustments. This is the billable amount.',
    `auto_applied_flag` BOOLEAN COMMENT 'Indicates whether this accessorial charge was automatically applied by the rating engine based on business rules (true) or manually added by a billing analyst or customer service representative (false). Used for process improvement and automation metrics.',
    `created_by_system` STRING COMMENT 'Source system that created this accessorial application record. Examples: SAP_TM_Rating_Engine, Oracle_TMS_Billing, Manual_Billing_Portal. Used for data lineage and system integration troubleshooting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this association record was created in the system. Standard audit field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the applied_charge_amount. May differ from the catalog currency_code if currency conversion was applied based on consignment origin/destination.',
    `disputed_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed this specific accessorial charge application. True means a dispute case has been opened. Used to track dispute rates by charge type and drive operational improvements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this association record was last modified. Updated when waiver status changes, disputes are filed, or amounts are adjusted. Standard audit field.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity or number of units to which the accessorial charge applies. For per-piece charges, this is the number of pieces. For per-kg charges, this is the weight. For flat fees, this is typically 1. Used in conjunction with calculation_basis from the charge definition.',
    `waived_flag` BOOLEAN COMMENT 'Indicates whether this specific accessorial charge application has been waived (not billed to the customer). True means the charge was applied but then waived due to customer service recovery, contract terms, or billing disputes. Waived charges appear in operational reports but not on customer invoices.',
    `waiver_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the waiver was approved. Used for audit compliance and management reporting on waiver patterns.',
    `waiver_approved_by` STRING COMMENT 'User ID or name of the manager or customer service representative who approved the waiver of this charge. Required when waived_flag is true and waiver_approval_required is true in the charge definition.',
    `waiver_reason` STRING COMMENT 'Free-text or coded reason why this accessorial charge was waived. Examples: Customer service recovery, Contract exclusion, Billing dispute resolution, Operational error. Required when waived_flag is true.',
    CONSTRAINT pk_consignment_accessorial_application PRIMARY KEY(`consignment_accessorial_application_id`)
) COMMENT 'This association product represents the application of accessorial charges to consignments in the logistics billing process. It captures the operational reality that a single consignment can incur multiple accessorial charges (residential delivery, liftgate, hazmat, redelivery, storage) and the same accessorial charge definition applies to many consignments. Each record links one consignment to one accessorial charge with attributes that exist only in the context of this specific application: the actual charge amount applied (which may differ from catalog due to negotiations), quantity of units charged, application timestamp, waiver status, and approval requirements. This is a core operational entity in the billing domain, actively managed by rating engines, billing systems, and customer service teams processing disputes and waivers.. Existence Justification: In logistics operations, a single consignment routinely incurs multiple accessorial charges simultaneously (residential delivery surcharge + liftgate fee + signature required + hazmat handling for the same shipment), and each accessorial charge definition (e.g., Residential Delivery Surcharge) applies to thousands of consignments daily. The business actively manages these applications through rating engines, billing systems, customer service waiver processes, and dispute resolution workflows. This is not an analytical correlation but an operational entity that humans create (manual charge additions), update (waiver approvals), and query (show me all accessorials applied to consignment AWB12345, which consignments had residential surcharges waived this month).';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` (
    `consignment_consolidation_entry_id` BIGINT COMMENT 'Unique identifier for this consignment-consolidation entry record. Primary key for the association.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to the consignment that is being consolidated. References the shipment domains master consignment entity.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to the consolidation container or ULD into which the consignment is loaded. References the freight domains consolidation entity.',
    `consolidation_entry_timestamp` TIMESTAMP COMMENT 'Precise date and time when this consignment was physically loaded into the consolidation container or ULD at the origin CFS facility. Used for cargo cut-off compliance tracking and operational audit trails.',
    `deconsolidation_timestamp` TIMESTAMP COMMENT 'Precise date and time when this consignment was physically unloaded from the consolidation at the destination CFS facility. Used for dwell time calculation, onward delivery planning, and SLA tracking.',
    `entry_status` STRING COMMENT 'Current lifecycle status of this consignment within this specific consolidation: planned (scheduled but not yet loaded), loaded (physically in container), in_transit (departed origin), arrived (at destination port), deconsolidated (unloaded at destination CFS), delivered (handed over for final delivery).',
    `handling_unit_count` STRING COMMENT 'Number of handling units (pieces, pallets, cartons) from this specific consignment that were loaded into this specific consolidation. Critical when a consignment is split across multiple consolidations or when only partial pieces are consolidated.',
    `loading_remarks` STRING COMMENT 'Free-text operational notes recorded by CFS staff during loading operations, such as special handling performed, damage observed, or deviations from standard procedures.',
    `sequence_in_consolidation` STRING COMMENT 'The sequential order in which this consignment was loaded into the consolidation. Critical for CFS operations to determine unloading order (LIFO/FIFO) and for deconsolidation planning at destination CFS.',
    `split_shipment_indicator` BOOLEAN COMMENT 'Indicates whether this consignment was split across multiple consolidations due to capacity constraints or operational requirements. True if the consignment appears in more than one consolidation.',
    `volume_in_consolidation_cbm` DECIMAL(18,2) COMMENT 'The volume in cubic meters of this consignments cargo allocated to this specific consolidation. Used for capacity utilization tracking and pro-rata cost allocation.',
    `weight_in_consolidation_kg` DECIMAL(18,2) COMMENT 'The weight in kilograms of this consignments cargo that was allocated to this specific consolidation. Essential for pro-rata freight charge allocation when a consignment is split across multiple consolidations, and for accurate consolidation weight reconciliation.',
    CONSTRAINT pk_consignment_consolidation_entry PRIMARY KEY(`consignment_consolidation_entry_id`)
) COMMENT 'This association product represents the operational event of a consignment being physically loaded into a specific consolidation container or ULD. It captures the critical CFS warehouse operations data including the sequence in which cargo was loaded, precise entry and exit timestamps for deconsolidation planning, the number of handling units from this consignment in this specific consolidation, and the allocated weight for pro-rata freight charge calculation. Each record represents one consignments participation in one consolidation, supporting NVOCC co-loading operations, CFS workflow management, and split-shipment tracking when a single consignment spans multiple consolidations.. Existence Justification: In LCL and freight forwarding operations, a single consignment can be physically split across multiple consolidations when it exceeds available capacity in one container/ULD, and each consolidation contains cargo from multiple different consignments. The business actively manages each consignment-consolidation pairing as a distinct operational event with specific loading sequence, entry/exit timestamps, and weight allocation for pro-rata freight billing. This is a core NVOCC business process managed by CFS operations teams.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` (
    `consignment_offset_allocation_id` BIGINT COMMENT 'Unique identifier for this consignment-offset program allocation record. Primary key.',
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to the carbon offset program from which credits were allocated. Each allocation draws from exactly one program.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to the consignment that received carbon offset allocation. Each allocation applies to exactly one consignment.',
    `allocation_cost_usd` DECIMAL(18,2) COMMENT 'The cost incurred by Transport Shipping for this offset allocation, calculated as offset_quantity_tco2e multiplied by the program price per tonne at allocation time. Used for financial reconciliation and P&L attribution.',
    `allocation_date` DATE COMMENT 'The date when the carbon offset credits were allocated to this consignment. Used for vintage tracking, compliance reporting, and financial reconciliation.',
    `allocation_method` STRING COMMENT 'The method by which offset credits were allocated to this consignment: automatic_portfolio (system-driven blended allocation), customer_requested (customer purchased carbon-neutral shipping), manual_override (sustainability team adjustment), compliance_mandate (CORSIA or regulatory requirement).',
    `allocation_notes` STRING COMMENT 'Free-text notes capturing additional context about this allocation: reason for manual override, customer special requests, compliance requirements, or audit annotations.',
    `certificate_issue_date` DATE COMMENT 'The date when the carbon offset certificate was issued to the customer for this allocation.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a carbon offset certificate has been issued to the customer for this allocation. Used to track customer-facing deliverables and prevent duplicate issuance.',
    `certificate_number` STRING COMMENT 'The unique certificate number issued to the customer for this carbon offset allocation, if applicable. Links to certificate generation system.',
    `created_by_user` STRING COMMENT 'The user ID or system account that created this allocation record. Used for audit trails and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was created in the system.',
    `customer_charge_usd` DECIMAL(18,2) COMMENT 'The amount charged to the customer for carbon-neutral shipping on this consignment, if customer_requested_flag is true. May differ from allocation_cost_usd due to pricing strategy.',
    `customer_requested_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer explicitly requested and paid for carbon-neutral shipping for this consignment. Used for revenue attribution and customer reporting.',
    `offset_quantity_tco2e` DECIMAL(18,2) COMMENT 'The quantity of carbon offset credits allocated from this program to this consignment, measured in metric tonnes of CO2 equivalent. This is the core transactional attribute representing the actual offset applied.',
    `registry_retirement_reference` STRING COMMENT 'The unique retirement transaction identifier from the external carbon offset registry (e.g., Verra, Gold Standard). Provides audit trail and verification link.',
    `retirement_date` DATE COMMENT 'The date when the allocated offset credits were permanently retired in the carbon offset registry. Used for compliance reporting and audit trails.',
    `retirement_status` STRING COMMENT 'The lifecycle status of the allocated offset credits: allocated (reserved for this consignment), retired (permanently retired in registry), pending_retirement (awaiting registry confirmation), cancelled (allocation reversed).',
    CONSTRAINT pk_consignment_offset_allocation PRIMARY KEY(`consignment_offset_allocation_id`)
) COMMENT 'This association product represents the allocation of carbon offset credits from specific offset programs to individual consignments. It captures the operational process of applying carbon offset credits to shipments, supporting both automatic portfolio-based allocation and customer-requested carbon-neutral shipping. Each record links one consignment to one carbon offset program with the quantity of CO2e offset, allocation method, timing, and certificate issuance status. This enables Transport Shipping to track blended offset portfolios per shipment and provide customers with verifiable carbon-neutral delivery.. Existence Justification: In Transport Shippings carbon offset operations, consignments are offset through multiple programs simultaneously using a portfolio approach (e.g., aviation CORSIA-eligible credits plus voluntary Gold Standard reforestation credits to meet both compliance and marketing goals). Conversely, each offset program covers many consignments over time as credits are allocated and retired. The business actively manages these allocations: sustainability teams select program mixes, calculate offset quantities per consignment based on weight/distance/mode, track retirement status in external registries, and issue certificates to customers who purchase carbon-neutral shipping.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` (
    `manifest_supplier_pickup_id` BIGINT COMMENT 'Unique identifier for this manifest-supplier pickup record. Primary key.',
    `freight_manifest_id` BIGINT COMMENT 'Foreign key linking to the freight manifest that includes this supplier pickup stop',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier location where pickup occurred',
    `consignment_count` STRING COMMENT 'Number of individual consignments (shipments) collected from this supplier for this manifest. Used for load reconciliation and supplier performance metrics.',
    `pickup_sequence` STRING COMMENT 'The ordinal position of this supplier in the milk run route sequence (1st stop, 2nd stop, etc.). Critical for route optimization and driver instructions.',
    `pickup_status` STRING COMMENT 'Current status of the pickup at this supplier location (scheduled, in_transit, completed, missed, cancelled). Tracks execution state for operational visibility.',
    `pickup_timestamp` TIMESTAMP COMMENT 'Actual date and time when the driver completed pickup at this supplier location. Used for on-time pickup performance tracking and route execution analysis.',
    `planned_pickup_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for pickup at this supplier location as planned by the TMS route optimizer. Used to measure pickup punctuality.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume in cubic meters of all consignments picked up from this supplier for this manifest. Used for vehicle capacity utilization analysis.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of all consignments picked up from this supplier for this manifest. Contributes to manifest total weight and vehicle load planning.',
    CONSTRAINT pk_manifest_supplier_pickup PRIMARY KEY(`manifest_supplier_pickup_id`)
) COMMENT 'This association product represents the pickup event between a freight manifest and a supplier in milk run consolidation operations. It captures the operational details of collecting consignments from a specific supplier location as part of a multi-stop manifest route. Each record links one freight manifest to one supplier with pickup-specific attributes including sequence order, volume collected, and timestamp. This enables milk run route optimization, supplier performance tracking, and load reconciliation by origin point.. Existence Justification: In milk run consolidation operations, a single freight manifest collects shipments from multiple supplier locations along a planned route (e.g., automotive parts from 5 suppliers in one truck run). Conversely, a single supplier has shipments picked up across multiple manifests over time (different days, different routes, different service lanes). The business actively manages pickup sequences, tracks per-supplier volumes on each manifest, and measures on-time pickup performance at each supplier stop.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_related_exception_event_id` FOREIGN KEY (`related_exception_event_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`exception_event`(`exception_event_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ADD CONSTRAINT `fk_shipment_shipment_package_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ADD CONSTRAINT `fk_shipment_delivery_instruction_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ADD CONSTRAINT `fk_shipment_shipment_sla_commitment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ADD CONSTRAINT `fk_shipment_transit_hub_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ADD CONSTRAINT `fk_shipment_transit_hub_event_freight_manifest_id` FOREIGN KEY (`freight_manifest_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`freight_manifest`(`freight_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ADD CONSTRAINT `fk_shipment_transit_hub_event_shipment_consignment_id` FOREIGN KEY (`shipment_consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ADD CONSTRAINT `fk_shipment_transit_hub_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_superseded_by_document_shipment_document_id` FOREIGN KEY (`superseded_by_document_shipment_document_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_document`(`shipment_document_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ADD CONSTRAINT `fk_shipment_temperature_log_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ADD CONSTRAINT `fk_shipment_temperature_log_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ADD CONSTRAINT `fk_shipment_shipment_driver_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ADD CONSTRAINT `fk_shipment_manifest_line_item_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ADD CONSTRAINT `fk_shipment_manifest_line_item_freight_manifest_id` FOREIGN KEY (`freight_manifest_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`freight_manifest`(`freight_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ADD CONSTRAINT `fk_shipment_consignment_accessorial_application_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ADD CONSTRAINT `fk_shipment_consignment_consolidation_entry_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ADD CONSTRAINT `fk_shipment_consignment_offset_allocation_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ADD CONSTRAINT `fk_shipment_manifest_supplier_pickup_freight_manifest_id` FOREIGN KEY (`freight_manifest_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`freight_manifest`(`freight_manifest_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`shipment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`shipment` SET TAGS ('dbx_domain' = 'shipment');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Identifier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignee_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Profile Identifier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Profile Identifier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `cod_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `cod_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `committed_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignee_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Consignee Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignee_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignee_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `declared_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Declared Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `delivery_instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instruction Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `delivery_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time Window End');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `delivery_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time Window Start');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `hawb_number` SET TAGS ('dbx_business_glossary_term' = 'House Air Waybill (HAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `is_cod` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `is_otd_target` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Target Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `is_otif_target` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Target Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Consignment Lifecycle Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `mawb_number` SET TAGS ('dbx_business_glossary_term' = 'Master Air Waybill (MAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `number_of_pieces` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Origin Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_city` SET TAGS ('dbx_business_glossary_term' = 'Origin City');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|critical');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'express_parcel|air_freight|ocean_freight|road_freight|rail_freight|cross_border');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `shipper_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Shipper Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `shipper_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `shipper_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `shipper_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `shipper_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `sla_source` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `sla_source` SET TAGS ('dbx_value_regex' = 'customer_contract|rate_card|spot_booking|standard_terms');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time in Days');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ALTER COLUMN `volumetric_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Weight in Kilograms (KG) / Dimensional Weight (DIM Weight)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `carbon_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emissions in Kilograms (CO2e)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Leg Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Leg Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `delay_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `delivery_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `dispatch_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance in Kilometers (KM)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `equipment_type_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `eta_prediction_source` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Prediction Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `eta_prediction_source` SET TAGS ('dbx_value_regex' = 'fourkites_ai|carrier_edi|manual_estimate|tms_calculation|gps_tracking|iot_sensor');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `gps_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_business_glossary_term' = 'Leg Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|completed|delayed|cancelled|failed');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `planned_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Timestamp (Estimated Time of Arrival - ETA)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `planned_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Timestamp (Estimated Time of Departure - ETD)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `predicted_eta_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Predicted Estimated Time of Arrival (ETA) Confidence Score');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `predicted_eta_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Predicted Estimated Time of Arrival (ETA) Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'sap_tm|oracle_tms|fourkites|carrier_edi|manual_entry');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `vehicle_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` SET TAGS ('dbx_subdomain' = 'transit_operations');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `tracking_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `api_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'AWB (Air Waybill) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'BOL (Bill of Lading) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|held|released|rejected');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `damage_reported` SET TAGS ('dbx_business_glossary_term' = 'Damage Reported');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `edi_message_reference` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Message ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'tracking|hub_operation|exception|lifecycle');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Event Type Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `exception_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `exception_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `exception_resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|escalated');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `exception_resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `humidity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Location Postal Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `location_state_province` SET TAGS ('dbx_business_glossary_term' = 'Location State or Province');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `pieces_count` SET TAGS ('dbx_business_glossary_term' = 'Pieces Count');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `pod_image_url` SET TAGS ('dbx_business_glossary_term' = 'POD (Proof of Delivery) Image URL');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `pod_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'POD (Proof of Delivery) Recipient Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `pod_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `pod_recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `pod_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'POD (Proof of Delivery) Signature Captured');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `scan_type` SET TAGS ('dbx_business_glossary_term' = 'Scan Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `scan_type` SET TAGS ('dbx_value_regex' = 'barcode|rfid|manual|ocr');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` SET TAGS ('dbx_subdomain' = 'delivery_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `pod_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent Employee ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `pod_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `pod_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `pod_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `amount_collected` SET TAGS ('dbx_business_glossary_term' = 'Amount Collected');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `amount_collected` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `amount_collected` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `cod_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `cod_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `cod_currency` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `cod_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `collection_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Collection Variance Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Latitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Longitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `delivery_type` SET TAGS ('dbx_value_regex' = 'door|reception|locker|neighbor|safe_place|collection_point');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `dispute_raised_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Document Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `epod_image_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Image Reference');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cash|card|digital_wallet|bank_transfer|cheque');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `pod_status` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `pod_status` SET TAGS ('dbx_value_regex' = 'accepted|disputed|pending|verified|rejected');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_id_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identification Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_id_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identification Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_id_type` SET TAGS ('dbx_value_regex' = 'national_id|passport|drivers_license|employee_badge|none');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_signature` SET TAGS ('dbx_business_glossary_term' = 'Recipient Signature');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `recipient_signature` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `remittance_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Batch ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `remittance_status` SET TAGS ('dbx_value_regex' = 'pending|remitted|reconciled|disputed|failed');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` SET TAGS ('dbx_subdomain' = 'transit_operations');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `eta_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Milestone ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `contract_sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sla Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `actual_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `current_predicted_datetime` SET TAGS ('dbx_business_glossary_term' = 'Current Predicted Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'NOT_REQUIRED|PENDING|IN_PROGRESS|CLEARED|HELD|REJECTED');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `delay_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `distance_remaining_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Remaining Kilometers (KM)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `milestone_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'ETD_ORIGIN|ETA_TRANSIT_HUB|ETD_TRANSIT_HUB|ETA_DESTINATION|ETA_DELIVERY|ETD_PICKUP');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `notification_sent_datetime` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `original_committed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Original Committed Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `prediction_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Prediction Confidence Score');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `prediction_last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Prediction Last Updated Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `prediction_source` SET TAGS ('dbx_business_glossary_term' = 'Prediction Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `prediction_source` SET TAGS ('dbx_value_regex' = 'FOURKITES_AI|CARRIER_EDI|TMS_CALCULATION|MANUAL_OVERRIDE|GPS_TRACKING|HISTORICAL_AVERAGE');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `prediction_update_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Prediction Update Frequency Minutes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'STANDARD|EXPEDITED|URGENT|CRITICAL');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'ON_TIME|AT_RISK|DELAYED|EARLY');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `sla_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Threshold Hours');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `timezone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'AIR|OCEAN|ROAD|RAIL|INTERMODAL');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Variance Hours');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `vehicle_identifier` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ALTER COLUMN `weather_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` SET TAGS ('dbx_subdomain' = 'transit_operations');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_event_id` SET TAGS ('dbx_business_glossary_term' = 'Exception Event ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `related_exception_event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Exception Event ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `assigned_to_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `claim_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Channel');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_value_regex' = 'EMAIL|SMS|PHONE|PORTAL|API|EDI');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_value_regex' = 'TIER_1|TIER_2|TIER_3|EXECUTIVE');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `estimated_recovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Recovery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_location_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Location Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_location_name` SET TAGS ('dbx_business_glossary_term' = 'Exception Location Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_raised_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Raised Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'OPEN|IN_PROGRESS|RESOLVED|CLOSED|ESCALATED|CANCELLED');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `resolution_action_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `resolution_action_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `sla_breach_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `sla_breach_type` SET TAGS ('dbx_value_regex' = 'DELIVERY_TIME|PICKUP_TIME|TRANSIT_TIME|NOTIFICATION|NONE');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'FOURKITES|ORACLE_TMS|SAP_TM|CARRIER_API|MANUAL');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ALTER COLUMN `source_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` SET TAGS ('dbx_subdomain' = 'transit_operations');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `consignment_status_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Status ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `customs_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Cleared Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `customs_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `delay_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time Minutes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `eta_updated_flag` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Updated Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `humidity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `new_eta_timestamp` SET TAGS ('dbx_business_glossary_term' = 'New Estimated Time of Arrival (ETA) Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `new_status_code` SET TAGS ('dbx_business_glossary_term' = 'New Status Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'EMAIL|SMS|PUSH|PORTAL|NONE');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `planned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `previous_status_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Status Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `route_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Route Deviation Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `scan_type` SET TAGS ('dbx_business_glossary_term' = 'Scan Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `scan_type` SET TAGS ('dbx_value_regex' = 'BARCODE|RFID|MANUAL|GPS|API');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_TM|ORACLE_TMS|MANHATTAN_WMS|FOURKITES|CARRIER_EDI|MOBILE_APP');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `status_notes` SET TAGS ('dbx_business_glossary_term' = 'Status Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `status_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `status_transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `triggered_by_source` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ALTER COLUMN `triggered_by_source` SET TAGS ('dbx_value_regex' = 'SYSTEM|USER|CARRIER_EDI|API|MOBILE_APP|WMS');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `barcode_number` SET TAGS ('dbx_business_glossary_term' = 'Package Barcode Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `contents_description` SET TAGS ('dbx_business_glossary_term' = 'Package Contents Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `current_location_code` SET TAGS ('dbx_business_glossary_term' = 'Current Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `delivery_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Signature Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `delivery_signature_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `delivery_signature_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `fragile_flag` SET TAGS ('dbx_business_glossary_term' = 'Fragile Handling Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Height (Centimeters)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `insurance_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `last_scan_location_code` SET TAGS ('dbx_business_glossary_term' = 'Last Scan Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `last_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Scan Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Length (Centimeters)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `max_stack_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stack Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `pod_image_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Image URL');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Package Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'manhattan_wms|oracle_tms|sap_tm|fourkites|manual_entry');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature-Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Package Volume (Cubic Meters) - CBM');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `volumetric_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Weight (Kilograms) - DIM Weight');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_package` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Width (Centimeters)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `shipment_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carrier Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `rate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Confirmation Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'auto_optimized|manual_override|contract_based|spot_market|tender|preferred_carrier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'confirmed|tentative|cancelled|pending|rejected|expired');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Booking Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_service_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Product Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `carrier_service_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Product Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `contract_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `estimated_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD) Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `on_time_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `rate_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `total_carrier_charge` SET TAGS ('dbx_business_glossary_term' = 'Total Carrier Charge');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `train_number` SET TAGS ('dbx_business_glossary_term' = 'Train Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Vessel Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `delivery_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instruction ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Alternative Delivery Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Alternative Delivery Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Alternative Delivery City');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Alternative Delivery Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Alternative Delivery Postal Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Alternative Delivery State or Province');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `alternative_delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `authority_to_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Authority To Leave Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `delivery_notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notification Preference');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `delivery_notification_preference` SET TAGS ('dbx_value_regex' = 'SMS|EMAIL|PHONE_CALL|MOBILE_APP|NONE');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `id_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'ID Verification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Instruction Effective Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Instruction Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_priority` SET TAGS ('dbx_business_glossary_term' = 'Instruction Priority');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_priority` SET TAGS ('dbx_value_regex' = 'HIGH|MEDIUM|LOW');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_source` SET TAGS ('dbx_business_glossary_term' = 'Instruction Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_source` SET TAGS ('dbx_value_regex' = 'SHIPPER|CONSIGNEE|CUSTOMER_PORTAL|CALL_CENTER|MOBILE_APP|EDI');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Instruction Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|CANCELLED|COMPLETED|SUPERSEDED|PENDING');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instruction Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_value_regex' = 'LEAVE_AT_DOOR|REQUIRE_SIGNATURE|DELIVER_TO_NEIGHBOUR|LOCKER_DELIVERY|APPOINTMENT_REQUIRED|CALL_BEFORE_DELIVERY');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `locker_code` SET TAGS ('dbx_business_glossary_term' = 'Locker ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `locker_location_code` SET TAGS ('dbx_business_glossary_term' = 'Locker Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `neighbour_delivery_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Neighbour Delivery Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `preferred_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Preferred Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `preferred_neighbour_address` SET TAGS ('dbx_business_glossary_term' = 'Preferred Neighbour Address');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `preferred_neighbour_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `preferred_neighbour_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `preferred_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time Window End');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `preferred_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time Window Start');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `return_if_absent_flag` SET TAGS ('dbx_business_glossary_term' = 'Return If Absent Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `safe_place_description` SET TAGS ('dbx_business_glossary_term' = 'Safe Place Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `signature_type` SET TAGS ('dbx_business_glossary_term' = 'Signature Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `signature_type` SET TAGS ('dbx_value_regex' = 'CONSIGNEE|ADULT|INDIRECT|ELECTRONIC');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `special_access_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Access Instructions');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` SET TAGS ('dbx_subdomain' = 'delivery_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Return Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Return Label Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `original_awb_number` SET TAGS ('dbx_business_glossary_term' = 'Original Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `original_awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `original_bol_number` SET TAGS ('dbx_business_glossary_term' = 'Original Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `original_bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `restocking_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `restocking_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_authorized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Authorized Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_condition_assessment` SET TAGS ('dbx_business_glossary_term' = 'Return Condition Assessment');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Return Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_destination_type` SET TAGS ('dbx_business_glossary_term' = 'Return Destination Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_destination_type` SET TAGS ('dbx_value_regex' = 'warehouse|supplier|manufacturer|disposal_center|repair_center|distribution_center');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Return Disposition Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Freight Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_freight_charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Return Freight Charge Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_freight_charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_freight_paid_by` SET TAGS ('dbx_business_glossary_term' = 'Return Freight Paid By');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_freight_paid_by` SET TAGS ('dbx_value_regex' = 'customer|shipper|carrier|third_party');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Initiated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_initiator` SET TAGS ('dbx_business_glossary_term' = 'Return Initiator');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_initiator` SET TAGS ('dbx_value_regex' = 'consignee|shipper|ecommerce_platform|carrier|third_party');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Return Inspection Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_label_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Label Generated Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_label_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Label Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_label_tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Return Pickup Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Return Pickup Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_city` SET TAGS ('dbx_business_glossary_term' = 'Return Pickup City');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_country_code` SET TAGS ('dbx_business_glossary_term' = 'Return Pickup Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Return Pickup Postal Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_state_province` SET TAGS ('dbx_business_glossary_term' = 'Return Pickup State or Province');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_pickup_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Reference');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_service_type` SET TAGS ('dbx_business_glossary_term' = 'Return Service Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_service_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|scheduled_pickup|drop_off|prepaid_label');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Return Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|parcel|courier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'full|partial|exchange|warranty|recall');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `wms_return_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Return Receipt Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ALTER COLUMN `wms_return_receipt_number` SET TAGS ('dbx_value_regex' = '^RR[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `shipment_sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Service Level Agreement (SLA) Commitment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `breach_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `breach_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `breach_penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `breach_penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `breach_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `breach_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Breach Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `breach_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Reason Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `business_days_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Days Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `committed_delivery_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Time Window End');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `committed_delivery_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Time Window Start');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `customs_clearance_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `force_majeure_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `holiday_calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `measurement_end_event` SET TAGS ('dbx_business_glossary_term' = 'Measurement End Event');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `measurement_end_event` SET TAGS ('dbx_value_regex' = 'delivery|pod_signature|arrival|final_scan');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `measurement_start_event` SET TAGS ('dbx_business_glossary_term' = 'Measurement Start Event');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `measurement_start_event` SET TAGS ('dbx_value_regex' = 'pickup|booking_confirmation|departure|customs_clearance');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `otd_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Threshold Percentage');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pickup Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|standard|low');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_source` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_source` SET TAGS ('dbx_value_regex' = 'customer_contract|rate_card|spot_booking|promotional|custom_quote');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|met|breached|at_risk|waived|cancelled');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `sla_version_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Version Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Transit Time in Hours');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `waiver_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` SET TAGS ('dbx_subdomain' = 'cargo_consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `shipment_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Charge ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Assessment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `application_level` SET TAGS ('dbx_business_glossary_term' = 'Charge Application Level');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `application_level` SET TAGS ('dbx_value_regex' = 'shipment|leg|package|container|pallet');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Charge Basis');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `billable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Billable Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Charge Calculation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `net_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `origin_system` SET TAGS ('dbx_business_glossary_term' = 'Charge Origin System');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|freight_collect|freight_prepaid');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Unit');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Waived Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` SET TAGS ('dbx_subdomain' = 'delivery_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `shipment_asn_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Advanced Shipping Notice (ASN) ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Party ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Clerk Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Acknowledgement Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `actual_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `asn_status` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `asn_status` SET TAGS ('dbx_value_regex' = 'sent|acknowledged|received|discrepant|cancelled|pending');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `edi_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Reference');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `expected_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `number_of_cartons` SET TAGS ('dbx_business_glossary_term' = 'Number of Cartons');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `number_of_pallets` SET TAGS ('dbx_business_glossary_term' = 'Number of Pallets');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Rotating Order (PRO) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `receiver_party_name` SET TAGS ('dbx_business_glossary_term' = 'Receiver Party Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `sender_location_code` SET TAGS ('dbx_business_glossary_term' = 'Sender Location Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `sender_party_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Party Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` SET TAGS ('dbx_subdomain' = 'cargo_consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `freight_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Manifest ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `carbon_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emissions in Kilograms (CO2e)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `delay_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `destination_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `destination_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `equipment_type_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `gps_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'GPS Tracking Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `load_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Reference');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Closed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Manifest Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Manifest Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `origin_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `origin_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `planned_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `planned_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `predicted_eta_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Predicted Estimated Time of Arrival (ETA) Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Seal Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `total_chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `total_consignments` SET TAGS ('dbx_business_glossary_term' = 'Total Consignments');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `total_pieces` SET TAGS ('dbx_business_glossary_term' = 'Total Pieces');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|parcel');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` SET TAGS ('dbx_subdomain' = 'transit_operations');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `transit_hub_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transit Hub Event ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `freight_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Freight Manifest Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `shipment_consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `customs_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `customs_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `customs_status` SET TAGS ('dbx_value_regex' = 'CLEARED|PENDING|HELD|INSPECTION_REQUIRED');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `damage_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Detected Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'INBOUND_SCAN|SORTED|LOADED_OUTBOUND|TRANSFERRED|HELD|RETURNED_TO_SENDER');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `handling_unit_barcode` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Barcode');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `handling_unit_barcode` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = 'CUSTOMS_HOLD|DAMAGED|ADDRESS_CORRECTION|PAYMENT_REQUIRED|SECURITY_SCREENING|WEATHER_DELAY');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percent');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `outbound_vehicle_number` SET TAGS ('dbx_business_glossary_term' = 'Outbound Vehicle Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `outbound_vehicle_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,15}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `photo_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `photo_reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Duration Seconds');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `security_screening_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `security_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Result');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `security_screening_result` SET TAGS ('dbx_value_regex' = 'PASSED|FAILED|MANUAL_REVIEW');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `sort_destination_code` SET TAGS ('dbx_business_glossary_term' = 'Sort Destination Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `sort_destination_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `sort_lane_code` SET TAGS ('dbx_business_glossary_term' = 'Sort Lane Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `sort_lane_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MANHATTAN_WMS|SAP_TM|SORTATION_SYSTEM|HANDHELD_SCANNER|AUTOMATED_SORTER');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `source_system_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `source_system_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = 'FRAGILE|PERISHABLE|HIGH_VALUE|LIVE_ANIMALS|MEDICAL|PRIORITY');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` SET TAGS ('dbx_subdomain' = 'cargo_consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `shipment_document_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Document ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Related Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By User ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `superseded_by_document_shipment_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|rejected|expired|cancelled');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|JPEG|PNG|TIFF|XML|EDI');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document File Size in Bytes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `file_uri` SET TAGS ('dbx_business_glossary_term' = 'Document File Uniform Resource Identifier (URI)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `file_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'INCOMPLETE|EXPIRED|INVALID|MISMATCH|ILLEGIBLE|UNAUTHORIZED');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `reviewed_by_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Authority Name');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `translation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = 'CINV|PLIST|COO|PHYTO|DGM|INSC');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `upload_source` SET TAGS ('dbx_business_glossary_term' = 'Upload Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `upload_source` SET TAGS ('dbx_value_regex' = 'shipper_portal|edi|api|email|manual|carrier_system');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` SET TAGS ('dbx_subdomain' = 'transit_operations');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Sensor Calibration Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Alert Recipient List');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `alert_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggered Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `breach_severity_code` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `breach_severity_code` SET TAGS ('dbx_value_regex' = 'minor|moderate|critical');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `corrective_action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'iot_sensor|rfid_tag|manual_entry|bluetooth_beacon|data_logger|tms_integration');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `humidity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'facility|in_transit|warehouse|terminal|customs|delivery_vehicle');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `package_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Package Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `sensor_battery_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sensor Battery Level Percentage');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `sensor_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Sensor Calibration Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Device ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `setpoint_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Maximum Celsius');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `setpoint_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Minimum Celsius');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ALTER COLUMN `vehicle_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Reference Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` SET TAGS ('dbx_association_edges' = 'shipment.consignment,fleet.driver_profile');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `shipment_driver_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'shipment_driver_assignment Identifier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment - Consignment Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `fleet_driver_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment - Driver Profile Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `actual_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `actual_return_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `distance_actual_km` SET TAGS ('dbx_business_glossary_term' = 'Actual Distance Kilometers');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `driving_hours` SET TAGS ('dbx_business_glossary_term' = 'Driving Hours');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `planned_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `planned_return_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned Return Date Time');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` SET TAGS ('dbx_subdomain' = 'cargo_consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` SET TAGS ('dbx_association_edges' = 'shipment.freight_manifest,shipment.consignment');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `manifest_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Line Item ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Line Item - Consignment Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `freight_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Line Item - Freight Manifest Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Handling Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `load_position` SET TAGS ('dbx_business_glossary_term' = 'Load Position');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `loaded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loaded Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `manifest_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `piece_count_on_manifest` SET TAGS ('dbx_business_glossary_term' = 'Piece Count on Manifest');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `unloaded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unloaded Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_line_item` ALTER COLUMN `weight_on_manifest_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight on Manifest (kg)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` SET TAGS ('dbx_subdomain' = 'cargo_consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` SET TAGS ('dbx_association_edges' = 'shipment.consignment,pricing.accessorial_charge');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `consignment_accessorial_application_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Accessorial Application ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Accessorial Application - Accessorial Charge Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Accessorial Application - Consignment Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `applied_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `auto_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Created By System');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `disputed_flag` SET TAGS ('dbx_business_glossary_term' = 'Disputed Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Charge Quantity');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Waived Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `waiver_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` SET TAGS ('dbx_subdomain' = 'cargo_consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` SET TAGS ('dbx_association_edges' = 'shipment.consignment,freight.consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `consignment_consolidation_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Consolidation Entry ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Consolidation Entry - Consignment Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Consolidation Entry - Consolidation Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `consolidation_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `deconsolidation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deconsolidation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `handling_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Count in Consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `loading_remarks` SET TAGS ('dbx_business_glossary_term' = 'Loading Remarks');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `sequence_in_consolidation` SET TAGS ('dbx_business_glossary_term' = 'Loading Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `split_shipment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Split Shipment Indicator');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `volume_in_consolidation_cbm` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume in Consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ALTER COLUMN `weight_in_consolidation_kg` SET TAGS ('dbx_business_glossary_term' = 'Allocated Weight in Consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` SET TAGS ('dbx_subdomain' = 'delivery_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` SET TAGS ('dbx_association_edges' = 'shipment.consignment,sustainability.carbon_offset_program');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `consignment_offset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Offset Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Offset Allocation - Carbon Offset Program Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Offset Allocation - Consignment Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `allocation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cost (USD)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `customer_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Customer Charge (USD)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `customer_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Flag');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `offset_quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Offset Quantity (tonnes CO2e)');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `registry_retirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Registry Retirement ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ALTER COLUMN `retirement_status` SET TAGS ('dbx_business_glossary_term' = 'Retirement Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` SET TAGS ('dbx_subdomain' = 'cargo_consolidation');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` SET TAGS ('dbx_association_edges' = 'shipment.freight_manifest,procurement.supplier');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `manifest_supplier_pickup_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Supplier Pickup ID');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `freight_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Supplier Pickup - Freight Manifest Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Supplier Pickup - Supplier Id');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `consignment_count` SET TAGS ('dbx_business_glossary_term' = 'Consignment Count');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `pickup_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pickup Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `pickup_status` SET TAGS ('dbx_business_glossary_term' = 'Pickup Status');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `planned_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Pickup Timestamp');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Pickup Volume Cubic Meters');
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Pickup Weight Kilograms');
