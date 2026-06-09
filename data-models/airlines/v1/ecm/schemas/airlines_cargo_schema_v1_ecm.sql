-- Schema for Domain: cargo | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`cargo` COMMENT 'Air freight and cargo commercial and operational data including AWB (Air Waybill) lifecycle, ULD (Unit Load Device) management, cargo bookings, shipment tracking, cargo capacity allocation, weight and balance, dangerous goods (DG) declarations, freight rates, cargo revenue accounting, and shipper/consignee relationships. Manages both belly cargo and dedicated freighter operations. Aligns with Mercator Cargo Management System.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`awb` (
    `awb_id` BIGINT COMMENT 'Unique system identifier for the air waybill record. Primary key for the AWB entity.',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: AWB stores agent_name and agent_iata_code as strings. Freight_forwarder is the authoritative master with iata_cargo_agent_code. Adding freight_forwarder_id FK normalizes agent reference and allows JOI',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Ground handling and cargo terminal services for AWB processing are procured from vendors. Links cargo operations to vendor performance tracking and invoice reconciliation for handling fees.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AWBs are issued and executed by specific cargo agents at acceptance. Regulatory requirement to track who accepted the shipment for liability and audit purposes. Standard practice in IATA cargo operati',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: AWBs specify origin_airport_code for acceptance. Station link provides hub classification, customs facility availability, DG certification, acceptance cutoff times, and ground handler assignment for o',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: AWBs are referenced in regulatory filings such as customs declarations, statistical reports to authorities (e.g., DOT Form 41), and trade compliance submissions. Links shipment to official filing.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: AWBs must comply with IATA, customs, and dangerous goods regulations. Airlines verify regulatory compliance during acceptance and booking processes. Essential for legal shipment acceptance and audit t',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: AWBs are booked and transported on specific routes. Cargo yield management, route profitability analysis, and capacity planning require linking shipments to routes. Essential for cargo revenue managem',
    `service_product_id` BIGINT COMMENT 'Foreign key linking to cargo.service_product. Business justification: AWB has service_level (STRING) which references the cargo product catalog. Service_product table has product_code and service_level. Adding cargo_product_id FK links AWB to the authoritative product d',
    `shipper_id` BIGINT COMMENT 'Foreign key linking to cargo.shipper. Business justification: AWB currently stores shipper_name, shipper_address, shipper_account_number as denormalized strings. Shipper is the authoritative master for shipper data. Adding shipper_id FK allows JOIN to retrieve c',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the physical cargo was accepted by the carrier at the origin station, marking the start of carrier liability.',
    `awb_number` STRING COMMENT 'The 11-digit IATA standard AWB number in format XXX-XXXXXXXX where first 3 digits are airline prefix and remaining 8 digits are serial number. This is the globally recognized identifier for the cargo shipment contract.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `awb_status` STRING COMMENT 'Current lifecycle status of the AWB indicating its position in the cargo handling workflow from initial booking through final delivery. [ENUM-REF-CANDIDATE: booked|accepted|manifested|departed|in_transit|arrived|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `awb_type` STRING COMMENT 'Classification of the AWB: master (MAWB issued by carrier), house (HAWB issued by freight forwarder), direct (shipper to consignee), or neutral (pre-printed blank AWB).. Valid values are `master|house|direct|neutral`',
    `booking_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo shipment was initially booked and the AWB record was created in the system.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Weight used for freight charge calculation, which is the greater of gross weight or volumetric weight (volume in cubic meters × 167 for IATA standard).',
    `commodity_code` STRING COMMENT 'Harmonized System (HS) code or other standardized classification code identifying the type of goods for customs and regulatory purposes.',
    `commodity_description` STRING COMMENT 'Detailed description of the nature and contents of the goods being shipped, as declared by the shipper for customs and handling purposes.',
    `consignee_address` STRING COMMENT 'Complete postal address of the consignee including street, city, state/province, postal code, and country for delivery purposes.',
    `consignee_name` STRING COMMENT 'Full legal name of the party to whom the goods are being shipped and who will take delivery at destination.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the AWB record was first created in the cargo management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on the AWB including freight charges and declared values.. Valid values are `^[A-Z]{3}$`',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Flag indicating whether the shipment contains dangerous goods (DG) requiring special handling and documentation per IATA DGR.',
    `declared_value_for_carriage` DECIMAL(18,2) COMMENT 'Value of the goods declared by the shipper for the purpose of determining carrier liability in case of loss or damage.',
    `declared_value_for_customs` DECIMAL(18,2) COMMENT 'Value of the goods declared for customs purposes, used for duty and tax calculation at destination.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the final destination station where cargo will be delivered to consignee.. Valid values are `^[A-Z]{3}$`',
    `executed_date` DATE COMMENT 'Date when the AWB contract was executed and signed by the shipper or authorized agent.',
    `executed_location` STRING COMMENT 'City and country where the AWB was executed and signed, establishing the jurisdiction for the contract.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight charges for the air transportation service, calculated based on chargeable weight and applicable rate.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment including packaging, expressed in kilograms. This is the actual physical weight of all pieces combined.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the AWB record was most recently updated, tracking the latest change to any field.',
    `nature_of_goods` STRING COMMENT 'High-level classification of the cargo type indicating special handling, regulatory, or operational requirements. [ENUM-REF-CANDIDATE: general|perishable|valuable|live_animals|dangerous_goods|human_remains|diplomatic|mail — 8 candidates stripped; promote to reference product]',
    `number_of_pieces` STRING COMMENT 'Total count of individual packages, cartons, or pieces comprising the shipment as declared on the AWB.',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'Sum of miscellaneous charges such as fuel surcharge, security surcharge, handling fees, and other ancillary service charges.',
    `payment_indicator` STRING COMMENT 'Indicates whether freight charges are prepaid (paid by shipper at origin), collect (paid by consignee at destination), or mixed (split payment).. Valid values are `prepaid|collect|mixed`',
    `routing_instructions` STRING COMMENT 'Specific routing path and transit points for the shipment, including intermediate airports and connecting flights.',
    `shipment_reference_number` STRING COMMENT 'Customer or agent-provided reference number for tracking and internal identification purposes.',
    `special_handling_codes` STRING COMMENT 'Three-letter IATA Special Handling Codes (SHC) indicating special requirements such as PER (perishable), AVI (live animals), DGR (dangerous goods), VAL (valuable cargo). Multiple codes separated by commas.',
    `total_charges_amount` DECIMAL(18,2) COMMENT 'Grand total of all charges on the AWB including freight, valuation, and other charges.',
    `valuation_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge for declared value coverage exceeding the standard carrier liability limit.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the shipment in cubic meters, calculated from the dimensions of all pieces.',
    CONSTRAINT pk_awb PRIMARY KEY(`awb_id`)
) COMMENT 'Air Waybill (AWB) master record — the primary contractual and operational document governing a cargo shipment. Captures AWB number (IATA 8-digit format), origin and destination airports, shipper and consignee details, commodity description, declared value, number of pieces, gross weight, chargeable weight, volume, nature of goods, special handling codes, freight charges, prepaid/collect indicator, routing instructions, and AWB status lifecycle (booked, accepted, manifested, departed, arrived, delivered). SSOT for all AWB-level cargo data. Aligns with Mercator Cargo Management System AWB module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`cargo_booking` (
    `cargo_booking_id` BIGINT COMMENT 'Unique identifier for the cargo booking record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cargo bookings are created by specific sales or customer service agents. Essential for sales performance tracking, commission calculation, and customer relationship management. Standard CRM requiremen',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Booking is created before AWB issuance. Once AWB is generated, booking should reference it. This FK will be NULL initially and populated during AWB creation process. Tracks the booking-to-AWB lifecycl',
    `cargo_allotment_id` BIGINT COMMENT 'Foreign key linking to cargo.allotment. Business justification: Booking has allotment_reference (STRING) when booking uses pre-allocated allotment space. Allotment table has allotment_reference_number. Adding allotment_id FK normalizes this reference and allows JO',
    `freight_forwarder_id` BIGINT COMMENT 'Reference to the freight forwarder or agent who created the booking on behalf of the shipper.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Bookings specify origin_station_code for acceptance planning. Station link provides capacity constraints, embargo status, acceptance cutoff times, and ground handler capability for booking validation ',
    `shipper_id` BIGINT COMMENT 'Reference to the party shipping the cargo. The consignor or sender of the goods.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Cargo bookings are made for specific routes. Booking acceptance workflow checks route-level capacity, embargoes, and allotments. Critical for cargo capacity control and allotment utilization tracking ',
    `service_product_id` BIGINT COMMENT 'Foreign key linking to cargo.service_product. Business justification: Booking has service_level (STRING) which should reference the cargo product catalog. Adding cargo_product_id FK links booking to authoritative product definition and removes string-based service_level',
    `acceptance_deadline_timestamp` TIMESTAMP COMMENT 'Date and time by which the physical cargo must be delivered to the origin station for acceptance. After this time, the booking may be cancelled.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the cargo booking. Represents the state of the commercial commitment before physical acceptance.. Valid values are `tentative|confirmed|waitlisted|cancelled|expired|rejected`',
    `booking_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo booking was initially created in the system. Principal business event timestamp.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the booking was cancelled. Applicable only when booking status is cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the booking was cancelled, if applicable. Null if booking has not been cancelled.',
    `channel` STRING COMMENT 'Channel through which the cargo booking was received. Indicates the interface or method used to create the reservation. [ENUM-REF-CANDIDATE: gds|direct|agent|web_portal|api|email|phone — 7 candidates stripped; promote to reference product]',
    `commodity_code` STRING COMMENT 'IATA commodity classification code describing the type of goods being shipped. Used for rate determination and handling requirements.. Valid values are `^[A-Z0-9]{3,6}$`',
    `commodity_description` STRING COMMENT 'Free-text description of the cargo commodity or goods being shipped. Provides additional detail beyond the commodity code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this booking record was first created in the system. Audit trail field.',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Flag indicating whether the booking contains dangerous goods requiring special handling and documentation per IATA DGR.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared value for carriage.. Valid values are `^[A-Z]{3}$`',
    `declared_value_for_carriage` DECIMAL(18,2) COMMENT 'Value of the cargo declared by the shipper for carriage liability purposes. Used to determine carrier liability limits.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code representing the final destination station for the cargo shipment.. Valid values are `^[A-Z]{3}$`',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the booking reservation expires if not confirmed or if cargo is not accepted.',
    `insurance_requested` BOOLEAN COMMENT 'Flag indicating whether the shipper has requested cargo insurance coverage for this booking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this booking record was last updated or modified. Audit trail field.',
    `number_of_pieces` STRING COMMENT 'Total count of individual pieces or packages in the cargo booking.',
    `quoted_rate_amount` DECIMAL(18,2) COMMENT 'Freight rate amount quoted to the shipper for this booking. May be per kilogram or total shipment rate.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted freight rate.. Valid values are `^[A-Z]{3}$`',
    `rate_quote_reference` STRING COMMENT 'Reference number linking this booking to a previously issued freight rate quotation. Used for rate validation and pricing.',
    `reference_number` STRING COMMENT 'Externally-known unique booking reference number assigned to the cargo space reservation. Used for customer communication and tracking.. Valid values are `^[A-Z0-9]{6,12}$`',
    `remarks` STRING COMMENT 'Free-text remarks or special instructions related to the cargo booking. May include handling notes, contact information, or other operational details.',
    `requested_flight_date` DATE COMMENT 'Date of the requested flight departure for cargo carriage.',
    `requested_flight_number` STRING COMMENT 'Primary flight number requested by the shipper or agent for cargo carriage. May include multiple flights for multi-leg bookings.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}$`',
    `requested_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo shipment requested for booking, measured in cubic meters.',
    `requested_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo shipment requested for booking, measured in kilograms.',
    `special_handling_codes` STRING COMMENT 'Comma-separated list of IATA Special Handling Codes (SHC) indicating special requirements such as DG (Dangerous Goods), PER (Perishable), AVI (Live Animals), VAL (Valuables), HEA (Heavy cargo).',
    `temperature_control_required` BOOLEAN COMMENT 'Flag indicating whether the cargo requires temperature-controlled handling (e.g., for perishables or pharmaceuticals).',
    `temperature_range_celsius` STRING COMMENT 'Required temperature range for temperature-controlled cargo, expressed as min-max range in Celsius (e.g., 2-8).',
    `uld_type_requested` STRING COMMENT 'Type of ULD (Unit Load Device) requested for the cargo, such as container or pallet type (e.g., AKE, PMC). Applicable for containerized cargo.',
    CONSTRAINT pk_cargo_booking PRIMARY KEY(`cargo_booking_id`)
) COMMENT 'Cargo space reservation record created prior to AWB issuance. Captures booking reference number, booking channel (GDS, direct, agent), requested flight(s), commodity type, requested weight and volume, special handling requirements (DG, perishable, live animals, valuables), booking status (tentative, confirmed, waitlisted, cancelled), rate quote reference, booking agent/forwarder, acceptance deadline, and allotment reference. Represents the commercial commitment before physical acceptance. Aligns with Mercator Cargo booking module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the physical shipment record. Primary key for tracking cargo movement from acceptance to delivery.',
    `awb_id` BIGINT COMMENT 'Reference to the Air Waybill document governing this shipment. Links shipment to commercial contract and routing instructions.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Shipments track current_location_code for real-time tracking. Station link provides ground handler, customs capability, operational hours, and contact details essential for exception handling and deli',
    `freight_forwarder_id` BIGINT COMMENT 'FK to cargo.freight_forwarder',
    `manifest_id` BIGINT COMMENT 'Reference to the flight manifest on which this shipment is loaded. Links shipment to specific flight leg for operational tracking.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Cargo incidents (damage, theft, security breaches, handling accidents) generate safety occurrences. Shipment tracking requires linkage to safety events for investigation, regulatory reporting (ICAO, C',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Shipments move along specific routes. Operational performance monitoring, transit time compliance, and route-level service quality metrics require route linkage. Essential for cargo operational KPI re',
    `service_product_id` BIGINT COMMENT 'Foreign key linking to cargo.service_product. Business justification: Shipment has service_level (STRING) which should reference the cargo product catalog. Adding cargo_product_id FK links shipment to authoritative product definition and removes string-based service_lev',
    `shipper_id` BIGINT COMMENT 'FK to cargo.shipper',
    `uld_id` BIGINT COMMENT 'FK to cargo.uld',
    `acceptance_station_code` STRING COMMENT 'Three-letter IATA airport code where the shipment was accepted by the carrier. Origin point for physical cargo movement.. Valid values are `^[A-Z]{3}$`',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was physically accepted by the carrier at origin station. Marks the start of carrier liability and shipment lifecycle.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment physically arrived at the destination station. Recorded upon flight arrival and cargo offload.',
    `actual_pieces` STRING COMMENT 'Number of individual pieces or packages in the shipment as verified at acceptance. Used for piece-level tracking and reconciliation throughout the journey.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the shipment in kilograms as measured at acceptance. Used for weight and balance calculations and capacity planning.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Weight used for freight rate calculation, which is the greater of actual weight or volumetric weight (volume × 167 kg/m³ for air cargo). Basis for revenue computation.',
    `commodity_code` STRING COMMENT 'IATA or Harmonized System (HS) commodity classification code identifying the type of goods. Used for customs clearance, dangerous goods screening, and regulatory compliance.. Valid values are `^[0-9]{4,10}$`',
    `commodity_description` STRING COMMENT 'Free-text description of the goods being shipped. Provides human-readable detail for handling, customs, and security screening.',
    `consignee_name` STRING COMMENT 'Name of the party receiving the goods. Business-confidential commercial relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was first created in the system. Audit trail for data lineage and compliance.',
    `customs_clearance_timestamp` TIMESTAMP COMMENT 'Date and time when customs clearance was completed. Null if not yet cleared or not applicable for domestic shipments.',
    `customs_cleared_flag` BOOLEAN COMMENT 'Indicates whether the shipment has successfully cleared customs at the destination. Critical for international shipments and delivery release.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains dangerous goods requiring special handling, documentation, and regulatory compliance per IATA DGR.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was delivered to the consignee or their agent. Marks the end of carrier liability and shipment lifecycle.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code of the final destination as specified on the AWB. Target delivery location for the shipment.. Valid values are `^[A-Z]{3}$`',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Estimated date and time when the shipment is expected to arrive at the destination station. Updated based on flight schedules and delays.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether the shipment has encountered any exceptions (damage, delay, missing pieces, customs hold, etc.) requiring special attention or resolution.',
    `exception_reason` STRING COMMENT 'Free-text description of the exception condition if exception_flag is true. Provides context for operational follow-up and customer communication.',
    `insurance_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the insurance declared value.. Valid values are `^[A-Z]{3}$`',
    `insurance_declared_value` DECIMAL(18,2) COMMENT 'Declared value of the shipment for insurance purposes. Used to calculate insurance premiums and liability limits. Business-confidential financial data.',
    `origin_station_code` STRING COMMENT 'Three-letter IATA airport code of the shipment origin as specified on the AWB. May differ from acceptance station for interline shipments.. Valid values are `^[A-Z]{3}$`',
    `proof_of_delivery` STRING COMMENT 'Name and signature of the person who received the shipment, or electronic delivery confirmation reference. Legal proof of successful delivery.',
    `routing_segments` STRING COMMENT 'Planned routing path as a sequence of station codes (e.g., JFK-FRA-DXB). Defines the intended flight segments for the shipment journey.',
    `security_screening_status` STRING COMMENT 'Status of mandatory security screening per TSA/EASA regulations. Must be cleared before loading onto passenger or cargo aircraft.. Valid values are `pending|cleared|failed|exempt`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the physical shipment. Tracks progression from acceptance through delivery. Aligns with IATA Cargo-XML status codes. [ENUM-REF-CANDIDATE: received|built_up|loaded|in_transit|arrived|delivered|on_hold|returned — 8 candidates stripped; promote to reference product]',
    `special_handling_codes` STRING COMMENT 'Comma-separated list of three-letter IATA Special Handling Codes (e.g., PER for perishables, AVI for live animals, DGR for dangerous goods). Dictates handling requirements and restrictions.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowed temperature in Celsius for temperature-controlled shipments. Null for non-temperature-sensitive cargo.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum required temperature in Celsius for temperature-controlled shipments (e.g., perishables, pharmaceuticals). Null for non-temperature-sensitive cargo.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was last modified. Audit trail for data lineage and compliance.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters. Used for volumetric weight calculation and ULD space optimization.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Physical shipment record tracking the end-to-end movement of cargo from acceptance to delivery, including granular milestone events. Captures shipment status (received, built-up, loaded, in-transit, arrived, delivered, on-hold), actual pieces and weight at acceptance, volume, commodity code (IATA/HS), special handling codes (SHC), temperature range for perishables, routing segments, current location, estimated and actual arrival times, proof of delivery, exception flags, and milestone event history (event code per IATA Cargo-XML: RCS, DEP, ARR, NFD, DLV, DIS with timestamps, station, flight, and responsible party). Links AWB to physical ULD build-up and flight manifest. SSOT for shipment lifecycle tracking and real-time shipment visibility.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`uld` (
    `uld_id` BIGINT COMMENT 'Unique identifier for the Unit Load Device record. Primary key.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: ULDs track current_location_airport_code for asset tracking. Station link provides ground handler for maintenance, inspection scheduling, storage allocation, and next-use planning for ULD fleet manage',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: ULDs are capitalized assets tracked in the fixed asset register for depreciation, valuation, and asset lifecycle management. Essential for IFRS 16 compliance and asset accounting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: ULD lease, repair, and maintenance services are procured from specialized vendors. Essential for ULD lifecycle cost tracking, vendor performance on serviceable status, and lease payment processing.',
    `acquisition_cost_amount` DECIMAL(18,2) COMMENT 'Purchase or lease cost of the ULD at time of acquisition. Used for asset valuation and financial reporting.',
    `acquisition_cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the acquisition cost amount.. Valid values are `^[A-Z]{3}$`',
    `acquisition_date` DATE COMMENT 'Date when the airline acquired ownership or lease of this ULD. Used for asset accounting and depreciation.',
    `barcode_number` STRING COMMENT 'Barcode identifier printed on the ULD for manual or automated scanning during cargo handling operations.',
    `compatible_aircraft_types` STRING COMMENT 'Comma-separated list of aircraft type codes (e.g., B777, A350, B747F) that can accommodate this ULD type. Used for load planning and fleet compatibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ULD record was first created in the system. Used for audit trail and data lineage.',
    `damage_description` STRING COMMENT 'Free-text description of any damage, defects, or maintenance issues identified during inspection or operation. Used for repair planning and safety tracking.',
    `damage_status` STRING COMMENT 'Current damage assessment level. None indicates no damage; minor damage allows continued use with monitoring; major damage requires repair before next use; critical damage grounds the unit immediately.. Valid values are `none|minor|major|critical`',
    `dangerous_goods_certified_flag` BOOLEAN COMMENT 'Indicates whether this ULD is certified and approved for carrying dangerous goods shipments per IATA DGR. True if certified, false otherwise.',
    `inspection_interval_days` STRING COMMENT 'Standard number of days between required inspections for this ULD type, as defined by IATA regulations and airline maintenance programs.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent scheduled inspection or maintenance check of the ULD. Required for regulatory compliance and safety.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Date and time when the ULD was last scanned or moved. Used for tracking ULD utilization and identifying stale or lost units.',
    `last_repair_date` DATE COMMENT 'Date when the most recent repair or maintenance work was completed on this ULD. Used for maintenance history tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this ULD record was most recently modified. Used for audit trail and change tracking.',
    `manufacture_date` DATE COMMENT 'Date when the ULD was manufactured. Used for age tracking, depreciation, and lifecycle management.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured the ULD. Used for warranty tracking and quality management.',
    `material_type` STRING COMMENT 'Primary construction material of the ULD. Aluminum is most common; composite materials are lighter; steel is used for heavy-duty applications.. Valid values are `aluminum|composite|steel|hybrid`',
    `maximum_gross_weight_kg` DECIMAL(18,2) COMMENT 'Maximum allowable total weight (tare + cargo) for this ULD type in kilograms, as specified by IATA standards and aircraft compatibility.',
    `maximum_volume_m3` DECIMAL(18,2) COMMENT 'Maximum internal volume capacity of the ULD in cubic meters. Used for cargo capacity planning and load optimization.',
    `next_inspection_due_date` DATE COMMENT 'Date by which the next scheduled inspection must be completed. ULDs overdue for inspection should be removed from service.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or remarks about this ULD.',
    `owner_airline_code` STRING COMMENT 'IATA two-letter airline code of the carrier that owns this ULD asset. Part of the ULD serial number.. Valid values are `^[A-Z]{2}$`',
    `ownership_type` STRING COMMENT 'Indicates whether the ULD is owned by the airline, leased from a third party, or part of a shared pool arrangement.. Valid values are `owned|leased|pooled`',
    `retirement_date` DATE COMMENT 'Date when the ULD was permanently removed from service and retired from the fleet. Null for active units.',
    `retirement_reason` STRING COMMENT 'Explanation for why the ULD was retired (e.g., end of useful life, irreparable damage, fleet optimization, lease expiration).',
    `rfid_tag_number` STRING COMMENT 'Unique identifier of the RFID tag attached to the ULD for automated tracking and scanning. Used by ULD control systems.',
    `serial_number` STRING COMMENT 'IATA-compliant ULD serial number in format: 3-letter type code + 5-digit serial + 2-letter owner code (e.g., AKE12345AA). Globally unique identifier for the physical ULD asset.. Valid values are `^[A-Z]{3}[0-9]{5}[A-Z]{2}$`',
    `serviceable_status` STRING COMMENT 'Current operational status of the ULD. Serviceable units are available for loading; unserviceable units require repair; condemned units are retired from service; quarantined units are held for inspection; missing units are lost or unaccounted for.. Valid values are `serviceable|unserviceable|under_repair|condemned|quarantined|missing`',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Empty weight of the ULD in kilograms. Used for weight and balance calculations and to determine net cargo weight.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this ULD is equipped with active or passive temperature control for perishable or pharmaceutical cargo. True if temperature-controlled, false otherwise.',
    `type_code` STRING COMMENT 'IATA three-letter ULD type code identifying the container or pallet type (e.g., AKE, LD3, LD7, LD11, PMC, PAG, AAA). Defines the physical dimensions and configuration.. Valid values are `^[A-Z]{3}$`',
    `uld_category` STRING COMMENT 'High-level classification of the ULD: container (enclosed unit), pallet (flat platform), or igloo (pallet with contoured cover).. Valid values are `container|pallet|igloo`',
    CONSTRAINT pk_uld PRIMARY KEY(`uld_id`)
) COMMENT 'Unit Load Device (ULD) master record — the authoritative asset register for all ULD containers and pallets. Captures ULD serial number (IATA format: type code + serial + owner code), ULD type (LD3, LD7, LD11, PMC, PAG, etc.), tare weight, maximum gross weight, maximum volume, material, owner airline code, serviceable status, current location (airport/station), last inspection date, next inspection due date, damage status, and lease/ownership indicator. SSOT for ULD asset identity. Aligns with Mercator ULD management module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`uld_movement` (
    `uld_movement_id` BIGINT COMMENT 'Unique identifier for each ULD movement event record. Primary key for the ULD movement transaction.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: ULD movements must track which aircraft transported each unit for asset tracking, operational reconciliation, damage liability determination, and hold position verification. Real operational audit tra',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to cargo.manifest. Business justification: ULD_movement has flight_number and flight_date (strings) to identify which flight the ULD is on. Manifest is the authoritative record for flight cargo operations. Adding cargo_manifest_id FK links ULD',
    `employee_id` BIGINT COMMENT 'System user ID or employee identifier of the person who recorded this ULD movement event in the cargo management system.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: ULD damage, seal tampering, or handling discrepancies during movement can trigger safety occurrences. Ground handling safety events require traceability to specific ULD movements for investigation and',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: ULD movements track origin_station_code for asset tracking. Station link provides ground handler, operational status, maintenance capability, and cost center for ULD lifecycle management and repositio',
    `uld_id` BIGINT COMMENT 'Foreign key linking to cargo.uld. Business justification: ULD_movement tracks uld_serial_number and uld_type_code as strings. ULD is the authoritative master for all ULD asset data. Adding uld_id FK normalizes this reference and allows JOIN to retrieve curre',
    `aircraft_hold_position` STRING COMMENT 'Specific compartment or position code within the aircraft hold where the ULD was loaded (e.g., FWD, AFT, MAIN, P1, P2). Null for non-loading events.',
    `awb_count` STRING COMMENT 'Number of distinct Air Waybills (AWB) consolidated within this ULD. Represents the count of separate shipments loaded into the unit.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of cargo contents within the ULD, calculated as gross weight minus tare weight, measured in kilograms.',
    `damage_description` STRING COMMENT 'Free-text description of any physical damage, contamination, or other condition issues observed on the ULD during this movement event. Null if no damage.',
    `damage_severity` STRING COMMENT 'Severity classification of ULD damage. Minor = cosmetic, moderate = functional impact but usable, major = requires repair before next use, critical = ULD unsafe for service. Null if no damage.. Valid values are `minor|moderate|major|critical`',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the ULD contains dangerous goods (DG) cargo requiring special handling and documentation per IATA DG regulations. True = contains DG, False = no DG.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code where the ULD is destined for this movement leg.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether any discrepancy, irregularity, or exception was noted during this ULD movement event. True = discrepancy exists, False = normal movement.',
    `discrepancy_type` STRING COMMENT 'Category of discrepancy or irregularity identified during the ULD movement. Damage = physical damage to ULD, missing = ULD not found, overweight = exceeds weight limits, contamination = foreign substance present, seal_broken = security seal compromised, misdirected = sent to wrong location. Null if no discrepancy.. Valid values are `damage|missing|overweight|contamination|seal_broken|misdirected`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the ULD movement event occurred. Recorded in UTC and follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Type of ULD movement event being recorded. Buildup = cargo loaded into ULD, breakdown = cargo removed from ULD, loading = ULD loaded onto aircraft, offloading = ULD removed from aircraft, transfer = ULD moved between locations, repositioning = empty ULD moved for operational needs.. Valid values are `buildup|breakdown|loading|offloading|transfer|repositioning`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the ULD including tare weight and cargo content, measured in kilograms at the time of the movement event.',
    `handling_agent_code` STRING COMMENT 'Code identifying the ground handling agent or airline personnel responsible for executing this ULD movement event.. Valid values are `^[A-Z0-9]{2,8}$`',
    `handling_agent_name` STRING COMMENT 'Full name of the ground handling company or airline unit that performed the ULD movement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ULD movement record was last updated in the cargo management system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `movement_status` STRING COMMENT 'Current lifecycle status of this ULD movement event. Planned = scheduled but not started, in_progress = movement underway, completed = movement finished successfully, cancelled = movement aborted, delayed = movement behind schedule, exception = irregularity occurred.. Valid values are `planned|in_progress|completed|cancelled|delayed|exception`',
    `piece_count` STRING COMMENT 'Total number of individual cargo pieces or packages loaded within the ULD at the time of this movement event.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Date and time when this ULD movement record was created in the cargo management system. May differ from event_timestamp if recorded retroactively. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `repair_required_flag` BOOLEAN COMMENT 'Indicates whether the ULD requires maintenance or repair before it can be returned to service. True = repair needed, False = serviceable.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the investigation, corrective actions, and final resolution of any discrepancy or irregularity. Null if no discrepancy or not yet resolved.',
    `resolution_status` STRING COMMENT 'Status of resolution for any discrepancy or irregularity associated with this ULD movement. Open = discrepancy reported, investigating = under review, resolved = corrective action taken, closed = case finalized. Null if no discrepancy.. Valid values are `open|investigating|resolved|closed`',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was found intact at the time of this movement event. True = seal intact, False = seal broken or missing.',
    `seal_number_primary` STRING COMMENT 'Primary security seal number applied to the ULD to ensure cargo integrity and prevent tampering. Null if ULD is not sealed.',
    `seal_number_secondary` STRING COMMENT 'Secondary or backup security seal number if multiple seals are applied. Null if only one seal or no seals applied.',
    `special_handling_codes` STRING COMMENT 'Comma-separated list of IATA Special Handling Codes (SHC) applicable to the cargo within this ULD (e.g., PER for perishable, VAL for valuable, AVI for live animals). Null if no special handling required.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Empty weight of the ULD unit itself without cargo, measured in kilograms.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the ULD requires temperature-controlled handling (e.g., for pharmaceuticals, perishables). True = temperature control required, False = ambient conditions acceptable.',
    CONSTRAINT pk_uld_movement PRIMARY KEY(`uld_movement_id`)
) COMMENT 'Transactional record of every ULD movement and condition event — build-up, breakdown, transfer, loading, offloading, repositioning, and discrepancy/damage incidents. Captures ULD serial number, event type (including damage, missing, overweight, contamination, seal broken), event timestamp, origin station, destination station, flight number, position in aircraft (hold/position code), gross weight at loading, seal numbers, handling agent, discrepancy flags, damage description, repair required indicator, and resolution status. Enables full ULD traceability, supports weight and balance calculations, and provides ULD asset integrity management. Aligns with Mercator ULD tracking module and IATA ULD Regulations damage reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`manifest` (
    `manifest_id` BIGINT COMMENT 'Primary key for manifest',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Cargo manifests must reference the specific aircraft for weight/balance verification, operational tracking, regulatory compliance (customs, security), and audit trails. Core operational link for every',
    `dangerous_goods_incident_id` BIGINT COMMENT 'Foreign key linking to safety.dangerous_goods_incident. Business justification: Flight manifests must reference dangerous goods incidents for regulatory reporting (ICAO Annex 18), load planning corrections, and crew notification. Essential for tracking which flights were affected',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Integrated load planning and weight-and-balance calculations require coordinating cargo manifests with passenger cabin loads. Load planners need to see both cargo weight (from manifest) and passenger ',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight on which this cargo manifest applies.',
    `fuel_uplift_order_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_uplift_order. Business justification: Finalized cargo manifest weight drives fuel uplift order confirmation. Critical for fuel cost allocation to cargo operations and weight-based fuel variance analysis.',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: Cargo manifests are built for specific gate assignments where aircraft park. Gate determines cargo loading position, ground handler coordination, and turnaround sequencing. Essential for load planning',
    `load_plan_id` BIGINT COMMENT 'Foreign key linking to cargo.load_plan. Business justification: Manifest has load_plan_reference (STRING) linking to the weight and balance calculation. Load_plan table PK is weight_balance_record_id. Adding this FK normalizes the reference and allows JOIN to retr',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cargo manifests are prepared by specific cargo operations staff. Regulatory requirement for customs and security - must track who compiled the manifest. Accountability for manifest accuracy and comple',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Cargo manifests are submitted as regulatory filings to customs and border protection agencies (e.g., AMS, ICS). Real business need: tracking submission status and acknowledgment for compliance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Cargo manifests must comply with customs advance manifest requirements (e.g., US AMS, EU ICS). Real business need: timely submission to avoid flight delays and penalties.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Manifests are created for flights operating specific routes. Customs pre-clearance, regulatory compliance reporting, and cargo operations planning require route context beyond flight_leg. Supports rou',
    `amended_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest was amended post-departure to correct discrepancies or add late-loaded cargo information.',
    `awb_count` STRING COMMENT 'Total number of distinct Air Waybills (AWBs) included in this manifest.',
    `consignee_count` STRING COMMENT 'Total number of distinct consignees (receivers) represented across all AWBs on this manifest.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was first created in the cargo management system.',
    `customs_clearance_timestamp` TIMESTAMP COMMENT 'Date and time when customs authority granted clearance for the cargo on this manifest.',
    `customs_declaration_reference` STRING COMMENT 'Reference number assigned by customs authority upon submission of the manifest for clearance and regulatory compliance.. Valid values are `^[A-Z0-9]{10,30}$`',
    `customs_submission_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest was electronically transmitted to the destination customs authority for advance cargo declaration.',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Flag indicating whether this manifest includes any shipments containing dangerous goods requiring special handling and regulatory declaration.',
    `destination_airport_code` STRING COMMENT 'IATA three-letter airport code for the arrival airport of this flight segment.. Valid values are `^[A-Z]{3}$`',
    `finalized_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest was locked and finalized prior to flight departure, after which no further changes are permitted without amendment.',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight in local time at origin airport (OOOI Out timestamp date).',
    `flight_number` STRING COMMENT 'IATA flight designator including carrier code and flight number (e.g., AA1234) for the flight carrying this cargo.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was last updated in the cargo management system.',
    `live_animals_indicator` BOOLEAN COMMENT 'Flag indicating whether this manifest includes any shipments of live animals requiring special care and regulatory compliance.',
    `mail_indicator` BOOLEAN COMMENT 'Flag indicating whether this manifest includes postal mail shipments governed by Universal Postal Union regulations.',
    `manifest_number` STRING COMMENT 'Externally-known unique manifest document number assigned by the cargo system for regulatory and operational tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `manifest_status` STRING COMMENT 'Current lifecycle status of the cargo manifest. Preliminary indicates draft; final indicates locked for departure; amended indicates post-departure correction; submitted indicates transmitted to customs.. Valid values are `preliminary|final|amended|cancelled|submitted`',
    `operation_type` STRING COMMENT 'Indicates whether cargo is carried on a dedicated freighter aircraft, in the belly hold of a passenger aircraft, or on a combi (mixed passenger/cargo) configuration.. Valid values are `freighter|belly|combi`',
    `origin_airport_code` STRING COMMENT 'IATA three-letter airport code for the departure airport of this flight segment.. Valid values are `^[A-Z]{3}$`',
    `perishables_indicator` BOOLEAN COMMENT 'Flag indicating whether this manifest includes perishable cargo (e.g., fresh produce, pharmaceuticals) requiring temperature-controlled handling.',
    `remarks` STRING COMMENT 'Free-text field for operational notes, special handling instructions, or discrepancy explanations related to this manifest.',
    `security_screening_status` STRING COMMENT 'Indicates the security screening completion status for all cargo on this manifest, required for regulatory compliance.. Valid values are `complete|partial|pending|exempt`',
    `shipper_count` STRING COMMENT 'Total number of distinct shippers (consignors) represented across all AWBs on this manifest.',
    `total_chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Total chargeable weight in kilograms used for revenue calculation, which is the greater of actual weight or volumetric weight across all AWBs.',
    `total_declared_value_usd` DECIMAL(18,2) COMMENT 'Total declared value for customs and insurance purposes across all AWBs on this manifest, expressed in US dollars.',
    `total_pieces` STRING COMMENT 'Total count of individual cargo pieces (packages, cartons, pallets) loaded on this flight across all AWBs.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of all cargo loaded on this flight in cubic meters, used for capacity planning and dimensional analysis.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total actual gross weight of all cargo loaded on this flight in kilograms, used for weight and balance calculations.',
    `transit_cargo_indicator` BOOLEAN COMMENT 'Flag indicating whether this manifest includes transit cargo that will continue on a connecting flight rather than being delivered at the destination airport.',
    `uld_count` STRING COMMENT 'Total number of Unit Load Devices (containers and pallets) loaded on this flight.',
    `valuable_cargo_indicator` BOOLEAN COMMENT 'Flag indicating whether this manifest includes high-value cargo requiring enhanced security and handling procedures.',
    CONSTRAINT pk_manifest PRIMARY KEY(`manifest_id`)
) COMMENT 'Flight cargo manifest record consolidating all AWBs and ULDs loaded on a specific flight. Captures flight number, flight date, origin and destination airports, total pieces, total weight (actual and chargeable), total volume, list of AWBs carried, ULD positions, belly vs freighter indicator, manifest status (preliminary, final, amended), customs declaration reference, and regulatory submission timestamps. Required for customs clearance and regulatory compliance. Aligns with Mercator manifest module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`dangerous_goods` (
    `dangerous_goods_id` BIGINT COMMENT 'Primary key for dangerous_goods',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: DG declarations require acceptance at certified stations. Station link validates DG handling capability, regulatory compliance, emergency response capability, and acceptance authority required for dan',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Dangerous_goods has awb_number (STRING) to identify which AWB the DG declaration belongs to. AWB is the authoritative master document. Adding awb_id FK normalizes this reference and allows JOIN to ret',
    `employee_id` BIGINT COMMENT 'Employee identifier of the airline staff member who performed the dangerous goods acceptance check.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Specialized DG handling equipment and certification services are procured from certified vendors. Links DG compliance to vendor qualification (EASA Part 145, FAA certification) and equipment maintenan',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Dangerous goods incidents (leaks, misdeclarations, packaging failures) are safety occurrences that must be tracked in the SMS. This FK links DG incidents to the safety occurrence register for regulato',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each DG shipment must reference specific UN/IATA dangerous goods regulations (e.g., IATA DGR Section 4.2). Critical for safety compliance, acceptance verification, and regulatory audit defense.',
    `acceptance_certificate_number` STRING COMMENT 'Reference number of the dangerous goods acceptance certificate or checklist issued upon successful acceptance inspection.',
    `acceptance_check_status` STRING COMMENT 'Result of the airlines dangerous goods acceptance inspection: passed (accepted for carriage), failed (rejected), pending (under review), waived (exempted).. Valid values are `passed|failed|pending|waived`',
    `acceptance_check_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods acceptance check was completed by airline cargo acceptance staff.',
    `additional_handling_information` STRING COMMENT 'Free-text field for supplementary handling instructions, warnings, or remarks specific to this dangerous goods shipment.',
    `all_packed_in_one_flag` BOOLEAN COMMENT 'Indicates whether all dangerous goods packages covered by this declaration are contained within a single overpack or freight container.',
    `cargo_aircraft_only_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods are restricted to cargo aircraft only (true) or may be carried on passenger aircraft (false).',
    `compliance_verified_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods declaration has been verified for full regulatory compliance with IATA DGR, ICAO Technical Instructions, and applicable national regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dangerous goods declaration record was first created in the cargo management system.',
    `dg_class` STRING COMMENT 'Primary hazard class of the dangerous goods (1-9): 1=Explosives, 2=Gases, 3=Flammable Liquids, 4=Flammable Solids, 5=Oxidizing Substances, 6=Toxic and Infectious Substances, 7=Radioactive Material, 8=Corrosives, 9=Miscellaneous.. Valid values are `^[1-9]$`',
    `dg_division` STRING COMMENT 'Subdivision within the DG class providing further hazard classification (e.g., 2.1 for flammable gases, 6.2 for infectious substances). May be null for classes without divisions.',
    `emergency_contact_name` STRING COMMENT 'Name of the person or organization to contact in case of emergency involving the dangerous goods shipment.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency telephone number for the contact person or organization, including country and area codes.',
    `gross_weight_per_package_kg` DECIMAL(18,2) COMMENT 'Gross weight of each package including dangerous goods and packaging material, measured in kilograms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dangerous goods declaration record was last updated in the cargo management system.',
    `net_quantity_per_package` DECIMAL(18,2) COMMENT 'Net quantity of dangerous goods per package, excluding packaging material. Unit specified in net_quantity_unit.',
    `net_quantity_unit` STRING COMMENT 'Unit of measure for net quantity: kg (kilograms), L (liters), g (grams), mL (milliliters).. Valid values are `kg|L|g|mL`',
    `number_of_packages` STRING COMMENT 'Total count of packages containing dangerous goods within this declaration.',
    `overpack_used_flag` BOOLEAN COMMENT 'Indicates whether an overpack (single enclosure containing one or more packages) was used for this dangerous goods shipment.',
    `packing_group` STRING COMMENT 'Degree of danger presented by the substance: I=Great Danger, II=Medium Danger, III=Minor Danger. Not applicable to all DG classes.. Valid values are `I|II|III`',
    `packing_instruction` STRING COMMENT 'IATA packing instruction code specifying how the dangerous goods must be packaged for air transport (e.g., PI 965 for lithium ion batteries).',
    `proper_shipping_name` STRING COMMENT 'The official IATA-recognized name used to describe the dangerous goods substance or article as specified in the DGR List of Dangerous Goods.',
    `radioactive_category` STRING COMMENT 'Category label for radioactive materials (Class 7) based on transport index and surface radiation level. Applicable only to radioactive shipments.. Valid values are `I-WHITE|II-YELLOW|III-YELLOW`',
    `shipper_declaration_text` STRING COMMENT 'Full text of the shippers declaration certifying that the dangerous goods are properly classified, packaged, marked, labeled, and in proper condition for transport by air.',
    `shipper_name` STRING COMMENT 'Name of the shipper who prepared and signed the dangerous goods declaration.',
    `shipper_signature_date` DATE COMMENT 'Date on which the shipper signed the dangerous goods declaration, certifying compliance with IATA DGR.',
    `special_provision_codes` STRING COMMENT 'Comma-separated list of IATA special provision codes (e.g., A1, A2) that apply additional conditions or exemptions to the shipment.',
    `state_variation_codes` STRING COMMENT 'Comma-separated list of country-specific variation codes indicating deviations from IATA DGR by national civil aviation authorities.',
    `subsidiary_risk_class` STRING COMMENT 'Secondary hazard class if the dangerous goods present more than one hazard. May be null if no subsidiary risk exists.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all packages containing dangerous goods in this declaration, measured in kilograms.',
    `total_net_quantity` DECIMAL(18,2) COMMENT 'Total net quantity of dangerous goods across all packages in this declaration. Calculated as net_quantity_per_package multiplied by number_of_packages.',
    `transport_index` DECIMAL(18,2) COMMENT 'Single number assigned to a package, overpack, or freight container containing radioactive material to provide control over radiation exposure. Applicable only to Class 7 DG.',
    `un_number` STRING COMMENT 'Four-digit UN identification number assigned to the dangerous substance or article. Mandatory for all DG shipments per IATA DGR.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_dangerous_goods PRIMARY KEY(`dangerous_goods_id`)
) COMMENT 'Dangerous Goods (DG) declaration record associated with a specific AWB shipment. Captures IATA DG class and division, UN number, proper shipping name, packing group, net and gross quantity per package, number of packages, packing instruction code, shipper declaration text, emergency contact, radioactive index (if applicable), acceptance check results, DG acceptance certificate reference, and regulatory compliance flags per IATA DGR (Dangerous Goods Regulations). Mandatory for all DG shipments. Aligns with Mercator DG module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`freight_rate` (
    `freight_rate_id` BIGINT COMMENT 'Unique identifier for the freight rate record. Primary key for the freight rate master data.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Rate structures drive revenue recognition rules and must link to GL accounts for automated posting and revenue classification. Supports rate-to-revenue reconciliation and audit requirements.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Freight rates specify origin_airport_code for pricing. Station link enables cost center allocation, revenue attribution, market segmentation, and competitive analysis for pricing strategy and yield ma',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Freight rates must comply with tariff filing requirements in regulated markets and anti-dumping regulations. Essential for pricing compliance audits and regulatory defense in trade disputes.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Freight rates are published and applied by route (origin-destination pairs). Pricing systems, quotation engines, and revenue management require route linkage for rate lookup and application. Core to c',
    `commodity_code` STRING COMMENT 'IATA commodity classification code identifying the type of cargo this rate applies to (e.g., PER for perishables, VAL for valuables, AVI for live animals).. Valid values are `^[A-Z0-9]{3,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate record.. Valid values are `^[A-Z]{3}$`',
    `dangerous_goods_applicable` BOOLEAN COMMENT 'Indicates whether this rate applies to dangerous goods shipments requiring special handling and documentation per IATA DGR.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the shipment destination point for this rate.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date when this freight rate becomes valid and can be applied to bookings. Part of the rate validity period.',
    `effective_to_date` DATE COMMENT 'Date when this freight rate expires and can no longer be applied to new bookings. Null indicates open-ended validity.',
    `interline_partner_code` STRING COMMENT 'IATA two or three-letter airline code of the interline partner carrier for revenue proration. Applicable when rate_type is INTERLINE_PRORATE.. Valid values are `^[A-Z0-9]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was last updated. Audit trail for change tracking.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum freight charge that applies regardless of weight. Ensures revenue floor for small shipments.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, restrictions, or special conditions applicable to this freight rate.',
    `proration_method` STRING COMMENT 'Method for dividing revenue between interline carriers. MILEAGE (proportional to distance flown), SEGMENT (per flight segment), AGREED_PERCENTAGE (pre-negotiated split), TACT_STANDARD (IATA standard proration rules).. Valid values are `MILEAGE|SEGMENT|AGREED_PERCENTAGE|TACT_STANDARD`',
    `proration_percentage` DECIMAL(18,2) COMMENT 'Percentage of total freight revenue allocated to this carrier segment in interline operations. Used when proration_method is AGREED_PERCENTAGE.',
    `rate_approval_authority` STRING COMMENT 'Name or identifier of the authority or department that approved this freight rate (e.g., Revenue Management, Pricing Committee, IATA CSC).',
    `rate_class` STRING COMMENT 'IATA rate class indicator. M (Minimum), N (Normal/General), Q (Quantity), C (Specific Commodity), S (Surcharge), R (Reduction).. Valid values are `M|N|Q|C|S|R`',
    `rate_code` STRING COMMENT 'Unique business identifier for the freight rate. Used in Mercator rating engine and TACT publications.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rate_per_kg` DECIMAL(18,2) COMMENT 'Freight charge per kilogram of cargo weight for this rate tier and route. Expressed in the currency specified in currency_code.',
    `rate_publication_date` DATE COMMENT 'Date when this rate was officially published or filed with regulatory authorities or IATA TACT.',
    `rate_source` STRING COMMENT 'Origin of the freight rate. TACT (The Air Cargo Tariff published rate), BILATERAL_AGREEMENT (negotiated carrier-to-carrier), SPOT_RATE (one-time negotiated rate), INTERLINE (multi-carrier agreement), CONTRACT (shipper contract rate), MARKET_RATE (dynamic market-based pricing).. Valid values are `TACT|BILATERAL_AGREEMENT|SPOT_RATE|INTERLINE|CONTRACT|MARKET_RATE`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the freight rate. ACTIVE (in use), INACTIVE (not available), PENDING (awaiting approval), EXPIRED (past effective_to_date), SUSPENDED (temporarily disabled).. Valid values are `ACTIVE|INACTIVE|PENDING|EXPIRED|SUSPENDED`',
    `rate_type` STRING COMMENT 'Classification of the freight rate. GCR (General Cargo Rate) applies to standard shipments, SCR (Specific Commodity Rate) applies to designated commodities, CLASS_RATE applies to rate classes, ULD_RATE applies to unit load devices, IATA_TARIFF applies to published IATA rates, SURCHARGE applies to additional charges, INTERLINE_PRORATE applies to revenue sharing between carriers. [ENUM-REF-CANDIDATE: GCR|SCR|CLASS_RATE|ULD_RATE|IATA_TARIFF|SURCHARGE|INTERLINE_PRORATE — 7 candidates stripped; promote to reference product]',
    `routing_restriction` STRING COMMENT 'Routing constraints or requirements for this rate to apply. May specify required connection points, prohibited routings, or carrier restrictions.',
    `settlement_reference` STRING COMMENT 'Reference identifier for IATA Cargo Accounts Settlement Systems (CASS) or bilateral settlement agreement. Used for interline revenue reconciliation.',
    `surcharge_calculation_basis` STRING COMMENT 'Method for calculating surcharge amount. PERCENTAGE (percent of base freight), FLAT_AMOUNT (fixed charge), PER_KG (per kilogram), PER_SHIPMENT (per AWB).. Valid values are `PERCENTAGE|FLAT_AMOUNT|PER_KG|PER_SHIPMENT`',
    `surcharge_type` STRING COMMENT 'Type of surcharge if rate_type is SURCHARGE. FSC (Fuel Surcharge), SSC (Security Surcharge), HANDLING (special handling), DG (Dangerous Goods), OVERSIZE (oversized cargo), REMOTE_AREA (remote destination), CAF (Currency Adjustment Factor), NONE (not a surcharge). [ENUM-REF-CANDIDATE: FSC|SSC|HANDLING|DG|OVERSIZE|REMOTE_AREA|CAF|NONE — 8 candidates stripped; promote to reference product]',
    `surcharge_value` DECIMAL(18,2) COMMENT 'Numeric value for surcharge calculation. Interpretation depends on surcharge_calculation_basis (e.g., 15.5 for 15.5% or 15.5 currency units).',
    `uld_type_code` STRING COMMENT 'IATA ULD type code if this rate applies to a specific unit load device configuration (e.g., AKE, PMC, PAG). Null for non-ULD rates.. Valid values are `^[A-Z0-9]{3,5}$`',
    `weight_break_lower_kg` DECIMAL(18,2) COMMENT 'Lower weight threshold in kilograms for this rate tier. Rates typically decrease as shipment weight increases through defined break points.',
    `weight_break_upper_kg` DECIMAL(18,2) COMMENT 'Upper weight threshold in kilograms for this rate tier. Null indicates no upper limit (open-ended tier).',
    CONSTRAINT pk_freight_rate PRIMARY KEY(`freight_rate_id`)
) COMMENT 'Cargo freight rate and pricing master record defining all pricing structures for cargo transportation including base rates, surcharges, and interline proration. Captures rate type (general cargo rate GCR, specific commodity rate SCR, class rate, ULD rate, IATA tariff rate, surcharge, interline prorate), origin and destination airport pair, commodity code, weight break thresholds, rate per kg, minimum charge, currency, validity period, rate class, routing restrictions, rate source (TACT, bilateral agreement, spot rate, interline), surcharge details (fuel FSC, security SSC, handling, DG, oversize, remote area, CAF with calculation basis), interline partner code, proration method, and settlement references. SSOT for all cargo pricing and revenue sharing. Aligns with Mercator rating and interline modules.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`capacity` (
    `capacity_id` BIGINT COMMENT 'Primary key for capacity',
    `aircraft_registration_id` BIGINT COMMENT 'Reference to the aircraft registration assigned to this flight segment.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Cargo capacity planning requires aircraft type specifications: hold dimensions, weight limits, ULD position counts, and volume capacity. Essential for accurate capacity modeling and allotment manageme',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Unified capacity management dashboards require linking cargo and passenger capacity for the same flight. Airlines with mixed-configuration aircraft (passenger + cargo) need integrated load factor repo',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight segment for which this capacity allocation applies.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Cargo capacity is allocated and controlled at flight number level (not just route). Tactical capacity management, allotment assignment, and booking acceptance decisions operate on specific flight numb',
    `operational_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.operational_approval. Business justification: Cargo capacity on certain routes requires operational approvals (e.g., ETOPS cargo operations, special cargo authorizations). Links capacity planning to required operational approvals for compliance v',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Capacity records track origin_station_code for departure planning. Station link provides ground handler, operational status, slot coordination, and embargo status for capacity allocation and overbooki',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Cargo capacity is planned and managed by route. This FK links cargo capacity records to the route master for route planning, capacity optimization, and network analysis.',
    `aircraft_configuration` STRING COMMENT 'The operational configuration of the aircraft for this flight: passenger (belly cargo only), freighter (dedicated cargo aircraft), or combi (mixed passenger and main deck cargo).. Valid values are `passenger|freighter|combi`',
    `allotment_dangerous_goods_kg` DECIMAL(18,2) COMMENT 'Weight capacity in kilograms allocated to dangerous goods (DG) cargo for this flight segment, subject to IATA DGR restrictions.',
    `allotment_express_kg` DECIMAL(18,2) COMMENT 'Weight capacity in kilograms allocated to express cargo product type for this flight segment.',
    `allotment_general_kg` DECIMAL(18,2) COMMENT 'Weight capacity in kilograms allocated to general cargo product type for this flight segment.',
    `allotment_live_animals_kg` DECIMAL(18,2) COMMENT 'Weight capacity in kilograms allocated to live animals cargo for this flight segment.',
    `allotment_perishable_kg` DECIMAL(18,2) COMMENT 'Weight capacity in kilograms allocated to perishable cargo product type (e.g., fresh produce, pharmaceuticals) for this flight segment.',
    `allotment_valuable_kg` DECIMAL(18,2) COMMENT 'Weight capacity in kilograms allocated to valuable cargo (e.g., precious metals, jewelry, currency) for this flight segment.',
    `available_volume_cbm` DECIMAL(18,2) COMMENT 'Remaining available volume capacity in cubic meters for new bookings (total capacity minus booked volume).',
    `available_weight_kg` DECIMAL(18,2) COMMENT 'Remaining available weight capacity in kilograms for new bookings (total capacity minus booked weight).',
    `belly_cargo_volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Total available volume capacity in cubic meters for belly cargo compartments on this flight segment.',
    `belly_cargo_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Total available weight capacity in kilograms for belly cargo compartments on this flight segment.',
    `booked_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume in cubic meters of cargo bookings confirmed for this flight segment at the time of capacity snapshot.',
    `booked_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of cargo bookings confirmed for this flight segment at the time of capacity snapshot.',
    `bulk_cargo_allowed_flag` BOOLEAN COMMENT 'Indicates whether loose (non-containerized) bulk cargo is accepted on this flight segment (True) or only ULD cargo is permitted (False).',
    `capacity_status` STRING COMMENT 'Current booking status of cargo capacity for this flight segment: open (accepting bookings), limited (restricted availability), closed (no capacity), waitlist (overbooked, accepting waitlist), embargoed (no new bookings allowed), cancelled (flight cancelled).. Valid values are `open|limited|closed|waitlist|embargoed|cancelled`',
    `control_method` STRING COMMENT 'Method by which capacity allocation is managed for this flight: manual (human-controlled), automated (system-driven revenue management), or hybrid (combination of both).. Valid values are `manual|automated|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo capacity allocation record was first created in the system (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code for the arrival station of this flight segment.. Valid values are `^[A-Z]{3}$`',
    `embargo_flag` BOOLEAN COMMENT 'Indicates whether a cargo embargo is in effect for this flight segment, preventing new bookings (True) or allowing normal operations (False).',
    `embargo_reason` STRING COMMENT 'Free-text description of the reason for cargo embargo if embargo_flag is True (e.g., weight and balance restrictions, operational constraints, security concerns).',
    `flight_date` DATE COMMENT 'The scheduled departure date of the flight segment in local time at origin (yyyy-MM-dd).',
    `flight_number` STRING COMMENT 'The commercial flight number for this segment (e.g., AA1234). Includes carrier code and numeric identifier.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity allocation record was last updated in the system (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `main_deck_volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Total available volume capacity in cubic meters for main deck cargo on freighter or combi aircraft. Null for passenger-only configurations.',
    `main_deck_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Total available weight capacity in kilograms for main deck cargo on freighter or combi aircraft. Null for passenger-only configurations.',
    `overbooking_factor_percent` DECIMAL(18,2) COMMENT 'Percentage by which capacity may be overbooked to account for expected no-shows and cancellations. Used in revenue management optimization.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp representing the point-in-time when this capacity snapshot was captured for reporting and analytics (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `total_volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Total available cargo volume capacity in cubic meters across all compartments (belly plus main deck if applicable) for this flight segment.',
    `total_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Total available cargo weight capacity in kilograms across all compartments (belly plus main deck if applicable) for this flight segment.',
    `uld_positions_available` STRING COMMENT 'Number of Unit Load Device (ULD) positions available for loading on this flight segment. Applies to containerized cargo.',
    `uld_positions_booked` STRING COMMENT 'Number of Unit Load Device (ULD) positions already booked for this flight segment.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for all volume capacity fields. Standardized to cubic meters (CBM) per IATA standards.. Valid values are `^CBM$`',
    `weight_unit_of_measure` STRING COMMENT 'Unit of measure for all weight capacity fields. Standardized to kilograms (KG) per IATA standards.. Valid values are `^KG$`',
    CONSTRAINT pk_capacity PRIMARY KEY(`capacity_id`)
) COMMENT 'Cargo capacity allocation record per flight segment defining available belly and freighter capacity. Captures flight number, flight date, aircraft registration, aircraft type, total belly cargo capacity (weight and volume), freighter main deck capacity, booked weight, booked volume, available weight, available volume, allotment blocks by product type (general, express, perishable, DG), overbooking factor, embargo flags, and capacity status. Enables revenue management and capacity control for cargo. Aligns with Mercator capacity module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`cargo_allotment` (
    `cargo_allotment_id` BIGINT COMMENT 'Unique identifier for the cargo space allotment agreement record.',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: Allotment has forwarder_agent_code and forwarder_agent_name as strings. Freight_forwarder is the authoritative master with iata_cargo_agent_code and legal_name. Adding freight_forwarder_id FK normaliz',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Allotment contracts create deferred revenue or commitment entries in GL for financial planning and contract liability tracking under IFRS 15. Links capacity commitments to accounting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cargo allotments are managed by specific cargo sales managers who negotiate contracts and monitor utilization. Commercial accountability for revenue performance and contract compliance. Essential for ',
    `operating_certificate_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_certificate. Business justification: Cargo allotments require valid operating certificates for the routes covered. Essential for verifying route authority and traffic rights compliance when allocating capacity to freight forwarders.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Allotments specify route_origin_airport_code for contract execution. Station link validates ground handler capability, customs facility, DG certification, and operational hours for allotment feasibili',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Allotments are contracted for specific routes with freight forwarders. Contract management, utilization tracking, and revenue guarantee enforcement require route linkage. Essential for allotment perfo',
    `allocated_volume_cbm` DECIMAL(18,2) COMMENT 'Pre-allocated cargo capacity in cubic meters granted to the forwarder or agent under this allotment. Null if allotment is weight-only or ULD-only.',
    `allocated_weight_kg` DECIMAL(18,2) COMMENT 'Pre-allocated cargo capacity in kilograms granted to the forwarder or agent under this allotment. Null if allotment is volume-only or ULD-only.',
    `allotment_status` STRING COMMENT 'Current lifecycle status of the allotment agreement: active (in force), suspended (temporarily inactive), expired (validity period ended), cancelled (terminated early), or pending (awaiting activation).. Valid values are `active|suspended|expired|cancelled|pending`',
    `allotment_type` STRING COMMENT 'Classification of the allotment basis: weight-based, volume-based, ULD (Unit Load Device) count-based, or hybrid combination.. Valid values are `weight|volume|uld|hybrid`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Flag indicating whether the allotment agreement automatically renews upon expiration (true) or requires explicit renewal (false).',
    `contract_reference_number` STRING COMMENT 'Reference number of the master commercial contract or agreement under which this allotment is established.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allotment record was first created in the system.',
    `days_of_week_applicable` STRING COMMENT 'Days of the week on which this allotment is valid, expressed as comma-separated day codes (e.g., MON,WED,FRI) or ALL for daily applicability.',
    `flight_series_pattern` STRING COMMENT 'Flight number pattern or series covered by this allotment (e.g., AA100-AA199 or daily AA100). May be null if allotment applies to all flights on the route.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this allotment record was last updated or modified.',
    `minimum_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of allocated capacity that the forwarder or agent must utilize to maintain the allotment in good standing. Typically ranges from 70% to 90%.',
    `penalty_terms` STRING COMMENT 'Contractual penalty terms applied if the forwarder or agent fails to meet minimum utilization thresholds or other agreement conditions.',
    `priority_level` STRING COMMENT 'Booking priority level granted to shipments under this allotment relative to general cargo bookings.. Valid values are `standard|priority|premium`',
    `rate_class` STRING COMMENT 'Freight rate classification applicable to shipments booked under this allotment: general cargo rates, specific commodity rates, or contract rates.. Valid values are `general|specific_commodity|contract`',
    `reference_number` STRING COMMENT 'Business identifier for the allotment agreement, used in commercial communications and operational systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `release_time_hours` STRING COMMENT 'Number of hours before scheduled departure by which unused allotment capacity is released back to the airline for general sale.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational instructions related to this allotment agreement.',
    `route_destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination point of the allotment route or flight series.. Valid values are `^[A-Z]{3}$`',
    `sales_channel` STRING COMMENT 'Primary sales channel through which bookings against this allotment are made: direct airline booking, GDS (Global Distribution System), cargo portal, or offline manual booking.. Valid values are `direct|gds|cargo_portal|offline`',
    `seasonal_indicator` BOOLEAN COMMENT 'Flag indicating whether this allotment is seasonal (true) or year-round (false).',
    `uld_count` STRING COMMENT 'Number of ULDs allocated under this agreement if allotment is ULD-based. Null if allotment is weight or volume based.',
    `uld_type_code` STRING COMMENT 'IATA ULD type code (e.g., AKE, PMC, PAG) if the allotment is ULD-based. Null if allotment is weight or volume based.. Valid values are `^[A-Z0-9]{3,5}$`',
    `validity_end_date` DATE COMMENT 'Date on which the allotment agreement expires. Null for open-ended agreements.',
    `validity_start_date` DATE COMMENT 'Date from which the allotment agreement becomes effective and capacity is available for booking.',
    CONSTRAINT pk_cargo_allotment PRIMARY KEY(`cargo_allotment_id`)
) COMMENT 'Cargo space allotment agreement record granting a freight forwarder or agent a pre-allocated block of cargo capacity on specific flights or routes. Captures allotment reference number, forwarder/agent code, route or flight series, allotment type (weight, volume, or ULD), allocated weight, allocated volume, ULD type and count, validity period, utilization thresholds, release time (hours before departure), penalty terms, and allotment status (active, suspended, expired). Supports commercial capacity management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`freight_forwarder` (
    `freight_forwarder_id` BIGINT COMMENT 'Unique identifier for the freight forwarder or cargo agent record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Freight forwarders are assigned to specific cargo sales account managers for relationship management, contract negotiation, and performance monitoring. Mirrors existing shipper.account_manager_employe',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Freight forwarders are major billed customers; their receivables must be tracked in AR for credit management, collections, and DSO reporting. Core customer-to-AR relationship.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Airlines run targeted B2B campaigns to freight forwarders (key cargo customers) for service promotion, contract renewals, and new route launches. Linking forwarder acquisition/retention to campaigns e',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to marketing.nps_survey. Business justification: Airlines measure freight forwarder satisfaction via NPS surveys (post-shipment, quarterly relationship reviews). Linking forwarders to survey programs enables response tracking, trend analysis by acco',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Freight forwarders are licensed and regulated by specific authorities (e.g., IATA, national civil aviation authorities). Real business need: tracking accreditation status and regulatory oversight for ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Freight forwarders are vendors in procurement system for contract management, payment processing, and performance evaluation. Essential for CASS settlement reconciliation and vendor spend analysis.',
    `account_status` STRING COMMENT 'Current operational status of the freight forwarder account with the airline: active (operational), inactive (dormant), suspended (temporarily blocked), credit_hold (financial restriction), terminated (closed).. Valid values are `active|inactive|suspended|credit_hold|terminated`',
    `accreditation_date` DATE COMMENT 'Date when the freight forwarder received IATA cargo agent accreditation.',
    `accreditation_expiry_date` DATE COMMENT 'Date when the current IATA accreditation expires and requires renewal.',
    `approved_commodity_types` STRING COMMENT 'Comma-separated list of commodity types or special cargo categories the freight forwarder is approved to handle (e.g., perishables, pharmaceuticals, live_animals, valuables, dangerous_goods). [ENUM-REF-CANDIDATE: general_cargo|perishables|pharmaceuticals|live_animals|valuables|dangerous_goods|oversized|temperature_controlled|hazmat — promote to reference product]',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for invoicing and financial correspondence.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, floor, building name).',
    `billing_city` STRING COMMENT 'City name for the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the billing address country.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address.',
    `billing_state_province` STRING COMMENT 'State, province, or region for the billing address.',
    `bsp_participation_flag` BOOLEAN COMMENT 'Indicates whether the freight forwarder participates in IATA BSP for passenger ticket settlement (some cargo agents also handle passenger bookings). True if participating, False otherwise.',
    `business_registration_number` STRING COMMENT 'Official business or company registration number issued by the local government authority.',
    `cass_number` STRING COMMENT 'Unique identifier assigned within the IATA CASS billing and settlement system for cargo transactions.. Valid values are `^[A-Z0-9]{8,12}$`',
    `cass_participation_flag` BOOLEAN COMMENT 'Indicates whether the freight forwarder participates in IATA CASS for cargo billing settlement. True if participating, False otherwise.',
    `contract_end_date` DATE COMMENT 'Date when the commercial agreement with this freight forwarder expires or was terminated. Null for open-ended agreements.',
    `contract_start_date` DATE COMMENT 'Date when the commercial agreement with this freight forwarder became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight forwarder record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for this freight forwarder in the airlines base currency. Used for credit risk management.',
    `credit_limit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit limit amount.. Valid values are `^[A-Z]{3}$`',
    `dg_certification_expiry_date` DATE COMMENT 'Expiration date of the dangerous goods handling certification.',
    `dg_certification_number` STRING COMMENT 'Certification number or reference for dangerous goods handling authorization.',
    `dg_handling_certified_flag` BOOLEAN COMMENT 'Indicates whether the freight forwarder is certified to handle dangerous goods shipments per IATA DGR. True if certified, False otherwise.',
    `forwarder_type` STRING COMMENT 'Classification of the freight forwarder business model: direct_agent (direct cargo agent), consolidator (consolidates shipments), gsa (general sales agent), broker (intermediary), nvocc (non-vessel operating common carrier), integrated_logistics (full-service logistics provider).. Valid values are `direct_agent|consolidator|gsa|broker|nvocc|integrated_logistics`',
    `iata_accreditation_status` STRING COMMENT 'Current accreditation status with IATA Cargo Agency Program: accredited (full accreditation), provisional (temporary accreditation), suspended (temporarily suspended), revoked (accreditation removed), not_accredited (no IATA accreditation).. Valid values are `accredited|provisional|suspended|revoked|not_accredited`',
    `iata_cargo_agent_code` STRING COMMENT 'Seven or eight-digit numeric code assigned by IATA to identify accredited cargo agents globally. Primary business identifier for cargo commercial partners.. Valid values are `^[0-9]{7,8}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight forwarder record was last updated.',
    `legal_name` STRING COMMENT 'Full legal registered name of the freight forwarding company or cargo agent as registered with local authorities.',
    `payment_method` STRING COMMENT 'Primary payment settlement method: cass (IATA CASS settlement), bsp (BSP settlement), direct_billing (direct invoice), prepaid (advance payment), credit_card, bank_transfer.. Valid values are `cass|bsp|direct_billing|prepaid|credit_card|bank_transfer`',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date (e.g., 30 for Net 30 terms).',
    `primary_contact_email` STRING COMMENT 'Primary email address for operational and commercial communication with the freight forwarder.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the freight forwarder organization.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for operational contact with the freight forwarder.. Valid values are `^+?[0-9s-()]{7,20}$`',
    `station_coverage` STRING COMMENT 'Comma-separated list of three-letter IATA airport codes where the freight forwarder has operational presence or coverage.',
    `tax_identification_number` STRING COMMENT 'Tax identification number (TIN, VAT number, or equivalent) for the freight forwarder in their country of registration.',
    `trade_name` STRING COMMENT 'Operating or trade name used by the freight forwarder in commercial transactions, may differ from legal name.',
    `website_url` STRING COMMENT 'Official website URL of the freight forwarder company.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    CONSTRAINT pk_freight_forwarder PRIMARY KEY(`freight_forwarder_id`)
) COMMENT 'Freight forwarder and cargo agent master record — the commercial intermediary between shippers and the airline. Captures IATA cargo agent code, company name, CASS (Cargo Accounts Settlement System) number, IATA accreditation status, primary contact details, billing address, credit limit, payment terms, BSP/CASS participation flag, approved commodity types, DG handling certification, station coverage, account manager, and account status. SSOT for cargo commercial partner identity within the cargo domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`shipper` (
    `shipper_id` BIGINT COMMENT 'Unique identifier for the shipper entity. Primary key for the shipper master record.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Shippers are direct customers who generate receivables when billed for cargo services. Essential for customer credit management, collections, and revenue assurance in direct billing scenarios.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Shippers are direct cargo customers targeted by marketing campaigns (trade shows, email nurture, product launches). Tracking which campaigns drive shipper onboarding and shipment volume growth is esse',
    `email_send_id` BIGINT COMMENT 'Foreign key linking to marketing.email_send. Business justification: Email sends to shipper contacts for cargo marketing campaigns require linking for engagement tracking, bounce management, and communication preference enforcement. Enables shipper-level email performa',
    `freight_forwarder_id` BIGINT COMMENT 'Reference to the freight forwarder entity if this shipper operates through a freight forwarder. Null if shipper deals directly with the airline.',
    `market_research_study_id` BIGINT COMMENT 'Foreign key linking to marketing.market_research_study. Business justification: Shippers participate in cargo market research for service quality assessment, pricing feedback, and commodity-specific needs analysis. Linking shipper participation to studies enables targeted samplin',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to marketing.nps_survey. Business justification: Shippers receive NPS surveys to measure cargo service satisfaction and loyalty. Linking shippers to survey programs enables response tracking, satisfaction trend analysis, and automated service recove',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Shippers become vendors when airline procures services FROM them (e.g., charter cargo contracts, reverse logistics agreements). Supports dual-role entity management in commercial cargo operations.',
    `address_line1` STRING COMMENT 'First line of the shippers physical address including street number and street name.',
    `address_line2` STRING COMMENT 'Second line of the shippers physical address for additional address details such as suite, floor, or building.',
    `blacklist_reason` STRING COMMENT 'Reason for blacklisting the shipper if status is blacklisted. Includes security violations, payment defaults, or regulatory non-compliance. Null if not blacklisted.',
    `city` STRING COMMENT 'City or municipality where the shipper is located.',
    `commodity_specialization` STRING COMMENT 'Primary commodity types or industries the shipper specializes in (e.g., pharmaceuticals, perishables, electronics, automotive, textiles). Free-text field for multiple specializations.',
    `contact_email` STRING COMMENT 'Primary email address for the shipper contact. Used for operational communication and AWB notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_fax` STRING COMMENT 'Fax number for the shipper contact. May be null if fax is not used.',
    `contact_name` STRING COMMENT 'Full name of the primary contact person at the shipper organization.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the shipper contact including country and area codes.',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the shipper is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipper record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit extended to the shipper for cargo services in the airlines base currency. Null if cash-only or no credit extended.',
    `credit_status` STRING COMMENT 'Current credit status of the shipper for cargo services. Determines payment terms and credit limits.. Valid values are `approved|pending|suspended|declined|under_review|cash_only`',
    `customs_registration_number` STRING COMMENT 'Shippers registration number with the national customs authority. Required for international cargo shipments.',
    `dg_certification_expiry_date` DATE COMMENT 'Expiry date of the dangerous goods certification. Null if not applicable or certification does not expire.',
    `dg_certification_number` STRING COMMENT 'Certification number issued by the relevant authority for dangerous goods shipping. Null if shipper is not DG certified.',
    `dg_shipper_certified_flag` BOOLEAN COMMENT 'Indicates whether the shipper is certified to tender dangerous goods (DG) cargo. True if certified, False otherwise.',
    `eori_number` STRING COMMENT 'EORI number assigned by EU customs authorities for shippers operating in the European Union. Required for EU customs clearance.',
    `iata_cass_code` STRING COMMENT 'IATA CASS code assigned to the shipper or their freight forwarder for billing and settlement purposes. Null if not enrolled in CASS.',
    `known_shipper_certification_date` DATE COMMENT 'Date when the shipper was certified as a Known Shipper by the relevant aviation security authority.',
    `known_shipper_expiry_date` DATE COMMENT 'Date when the Known Shipper certification expires and requires renewal. Null if certification does not expire or is not applicable.',
    `known_shipper_status` STRING COMMENT 'IATA/ICAO security designation indicating whether the shipper has been validated and approved to tender cargo without additional security screening. Critical for aviation security compliance.. Valid values are `known_shipper|unknown_shipper|suspended|revoked|pending_validation|not_applicable`',
    `last_shipment_date` DATE COMMENT 'Date of the most recent cargo shipment tendered by this shipper. Used for shipper activity tracking and dormancy analysis.',
    `onboarding_date` DATE COMMENT 'Date when the shipper was first onboarded and approved to tender cargo with the airline.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date (e.g., 30, 60, 90). Null if cash-only or prepayment required.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the shippers address.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO currency code representing the shippers preferred currency for invoicing and rate quotations.. Valid values are `^[A-Z]{3}$`',
    `shipper_name` STRING COMMENT 'Full legal name of the shipper entity tendering cargo for transport. May be individual or corporate name.',
    `shipper_status` STRING COMMENT 'Current operational status of the shipper account. Active shippers can tender cargo; inactive, suspended, or blacklisted shippers cannot.. Valid values are `active|inactive|suspended|blacklisted|pending_approval`',
    `shipper_type` STRING COMMENT 'Classification of the shipper entity type. Distinguishes between individual shippers, corporate entities, regulated agents, freight forwarders acting as shippers, government agencies, manufacturers, and retailers. [ENUM-REF-CANDIDATE: individual|corporate|regulated_agent|freight_forwarder|government|manufacturer|retailer — 7 candidates stripped; promote to reference product]',
    `state_province` STRING COMMENT 'State, province, or administrative region where the shipper is located.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or VAT number for the shipper entity. Used for invoicing and tax compliance.',
    `total_shipments_count` STRING COMMENT 'Cumulative count of all cargo shipments tendered by this shipper since onboarding. Used for shipper volume analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipper record was last modified in the system.',
    CONSTRAINT pk_shipper PRIMARY KEY(`shipper_id`)
) COMMENT 'Shipper master record representing the entity tendering cargo for transport. Captures shipper name, address, country, contact details, known shipper status (IATA/ICAO security designation), shipper type (individual, corporate, regulated agent), commodity specializations, DG shipper certification, customs registration number, EORI number, credit status, and relationship to freight forwarder. Distinct from freight forwarder — the shipper is the cargo originator. SSOT for shipper identity in cargo operations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Cargo invoices create AR entries for customer billing, collections tracking, and aging analysis. Essential for cash flow management and credit control in cargo operations.',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Invoice has awb_number (STRING) for primary AWB reference (invoices can cover multiple AWBs but typically have a primary). Adding awb_id FK normalizes this reference and allows JOIN to retrieve AWB de',
    `billed_freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: Invoice has billing_party_id (BIGINT) and billing_party_type (STRING). When billing_party_type=FORWARDER, this should FK to freight_forwarder. Adding billed_freight_forwarder_id as a labeled FK (nul',
    `shipper_id` BIGINT COMMENT 'Foreign key linking to cargo.shipper. Business justification: Invoice has billing_party_id (BIGINT) and billing_party_type (STRING). When billing_party_type=SHIPPER, this should FK to shipper. Adding billed_shipper_id as a labeled FK (nullable, populated when ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cargo invoices are processed and approved by specific billing staff. Financial controls and audit trail requirement - must track who generated and approved the invoice for SOX compliance and dispute r',
    `freight_forwarder_id` BIGINT COMMENT 'Reference to the party (freight forwarder, shipper, or consignee) being invoiced for cargo transportation charges.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Cargo invoices post to GL as revenue and AR entries. This is the core accounting integration point for cargo billing and financial statement preparation.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Invoices track origin_station_code for revenue recognition. Station link provides cost center for P&L reporting, interline settlement, CASS reconciliation, and regional revenue attribution.',
    `awb_count` STRING COMMENT 'Number of distinct AWBs included in this invoice. Used for consolidated billing and reconciliation.',
    `billing_address_line1` STRING COMMENT 'First line of the billing partys address for invoice delivery and legal correspondence.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing partys address (suite, floor, building name).',
    `billing_city` STRING COMMENT 'City of the billing partys address.',
    `billing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the billing partys address (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `billing_party_account_number` STRING COMMENT 'Customer account number or IATA CASS agent code of the billing party. Used for account reconciliation and settlement.. Valid values are `^[A-Z0-9]{6,15}$`',
    `billing_party_name` STRING COMMENT 'Legal name of the party being billed. Captured for invoice presentation and audit trail.',
    `billing_party_type` STRING COMMENT 'Type of party being billed: freight forwarder (consolidator), shipper (consignor), consignee (receiver), agent (GSA/handling agent), airline (interline partner), or broker.. Valid values are `freight_forwarder|shipper|consignee|agent|airline|broker`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing partys address.',
    `billing_state_province` STRING COMMENT 'State or province of the billing partys address.',
    `cass_period` STRING COMMENT 'IATA CASS billing period in YYYY-MM format (e.g., 2024-03). Used for settlement cycle reconciliation.. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    `cass_settlement_reference` STRING COMMENT 'IATA CASS settlement reference number for invoices processed through the CASS billing and settlement system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'ISO 4217 3-letter currency code for all monetary amounts on this invoice (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_fee` DECIMAL(18,2) COMMENT 'Fee for customs clearance services provided by the airline or handling agent.',
    `destination_station_code` STRING COMMENT 'IATA 3-letter airport code of the cargo shipment destination station (e.g., JFK, LHR, HKG).. Valid values are `^[A-Z]{3}$`',
    `dg_surcharge` DECIMAL(18,2) COMMENT 'Surcharge for handling dangerous goods (DG) shipments requiring special handling, documentation, and compliance with IATA DGR.',
    `due_date` DATE COMMENT 'Date by which payment is expected from the billing party. Determines overdue status.',
    `freight_charge_collect` DECIMAL(18,2) COMMENT 'Total freight charges to be collected from the consignee at destination. Excludes prepaid charges.',
    `freight_charge_prepaid` DECIMAL(18,2) COMMENT 'Total freight charges paid by the shipper at origin. Excludes collect charges.',
    `fuel_surcharge` DECIMAL(18,2) COMMENT 'Fuel surcharge applied to the shipment to offset variable fuel costs. Typically calculated as a percentage of freight charges.',
    `handling_fee` DECIMAL(18,2) COMMENT 'Ground handling and terminal processing fees for cargo acceptance, storage, and delivery.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued to the billing party. Principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number issued to the billing party. Business identifier for the invoice.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice: draft (not yet issued), issued (finalized), sent (transmitted to billing party), partially_paid, paid (fully settled), overdue (past due date), cancelled, or disputed (under review). [ENUM-REF-CANDIDATE: draft|issued|sent|partially_paid|paid|overdue|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Type of invoice document: standard invoice, credit note (refund/reversal), debit note (additional charges), proforma (advance estimate), adjustment (correction), or supplementary (additional billing).. Valid values are `standard|credit_note|debit_note|proforma|adjustment|supplementary`',
    `other_charges` DECIMAL(18,2) COMMENT 'Miscellaneous charges not categorized under standard surcharge types (e.g., documentation fees, special service requests).',
    `oversize_surcharge` DECIMAL(18,2) COMMENT 'Surcharge for oversized or non-standard cargo requiring special handling or equipment.',
    `payment_method` STRING COMMENT 'Method by which payment is expected or received: CASS settlement, bank transfer, credit card, check, cash, ACH, or wire transfer. [ENUM-REF-CANDIDATE: cass|bank_transfer|credit_card|check|cash|ach|wire — 7 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the billing party: net_7 (7 days), net_15, net_30, net_45, net_60, due_on_receipt, prepaid, or COD (cash on delivery). [ENUM-REF-CANDIDATE: net_7|net_15|net_30|net_45|net_60|due_on_receipt|prepaid|cod — 8 candidates stripped; promote to reference product]',
    `security_surcharge` DECIMAL(18,2) COMMENT 'Security surcharge for cargo screening and security compliance (TSA, EASA requirements).',
    `storage_fee` DECIMAL(18,2) COMMENT 'Warehouse storage fees for cargo held beyond free storage period.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all freight charges and surcharges before taxes. Equals freight_charge_prepaid + freight_charge_collect + all surcharges.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice (VAT, GST, sales tax, or other applicable taxes based on jurisdiction).',
    `total_amount` DECIMAL(18,2) COMMENT 'Total invoice amount due from the billing party. Equals subtotal_amount + tax_amount. Single source of truth for cargo billing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified. Audit trail for record updates.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Cargo revenue invoice record issued to freight forwarders or shippers for transportation charges. Captures invoice number, AWB reference(s), billing party (forwarder/shipper), invoice date, due date, freight charges (prepaid and collect), surcharges (fuel surcharge, security surcharge, handling fees, DG surcharge, oversize surcharge), taxes, total amount, currency, payment status, CASS settlement reference, and invoice type (standard, credit note, debit note). SSOT for cargo billing. Aligns with Mercator revenue accounting module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`cargo_revenue` (
    `cargo_revenue_id` BIGINT COMMENT 'Unique identifier for the cargo revenue accounting record. Primary key.',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Cargo_revenue has awb_number (STRING) to identify which AWB generated the revenue. AWB is the authoritative master document. Adding awb_id FK normalizes this reference and allows JOIN to retrieve full',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to cargo.manifest. Business justification: Cargo_revenue has flight_number and flight_date (strings) to identify which flight the revenue is associated with. Manifest is the authoritative record for flight cargo operations. Adding cargo_manife',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cargo revenue must be allocated to cost centers (cargo divisions, stations) for financial reporting. This FK enables P&L tracking and cost allocation for the cargo business unit.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Revenue records track origin_station_code for accounting. Station link provides cost center for P&L reporting, profit center allocation, and regional performance analysis required for financial consol',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Cargo revenue is recognized and reported by route. Route P&L analysis, network profitability assessment, and strategic route planning require route-level revenue attribution. Essential for cargo finan',
    `accounting_period` STRING COMMENT 'The accounting period (YYYY-MM format) to which this revenue record is allocated for financial reporting purposes.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `booking_channel` STRING COMMENT 'The sales channel through which the cargo booking was made: direct airline booking, ground handling agent, freight forwarder, online platform, or cargo portal.. Valid values are `DIRECT|GHA|FREIGHT_FORWARDER|ONLINE|CARGO_PORTAL`',
    `commodity_code` STRING COMMENT 'The commodity classification code for the cargo shipment, used for rate determination and regulatory compliance.',
    `consignee_account_number` STRING COMMENT 'The account number of the consignee (receiver) to whom the cargo is being delivered.',
    `cost_center` STRING COMMENT 'The cost center responsible for this cargo revenue, typically aligned with the operating station or business unit.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cargo revenue record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the revenue amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code for the destination station of the flight segment.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction currency to the reporting currency at the time of revenue recognition.',
    `freight_revenue_amount` DECIMAL(18,2) COMMENT 'The base freight revenue amount earned from transporting the cargo, excluding surcharges and handling fees.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this cargo revenue is posted in the financial accounting system.',
    `handling_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue from cargo handling services including terminal handling charges and special handling fees.',
    `interline_settlement_amount` DECIMAL(18,2) COMMENT 'The amount to be settled with partner carriers through IATA Cargo Accounts Settlement Systems (CASS) for interline shipments. Null for direct single-carrier shipments.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this cargo revenue record was last modified or updated.',
    `per_rtk` DECIMAL(18,2) COMMENT 'Revenue per RTK, calculated as total revenue divided by RTK flown. Key yield management metric for cargo operations.',
    `profit_center` STRING COMMENT 'The profit center to which this cargo revenue is attributed for management reporting and profitability analysis.',
    `proration_factor` DECIMAL(18,2) COMMENT 'The numeric proration factor applied to calculate this carriers share of interline revenue. Value between 0 and 1 representing the percentage allocation.',
    `proration_method` STRING COMMENT 'The method used to allocate revenue across multiple carriers in interline shipments. IATA_PRORATE uses standard IATA prorate factors, BILATERAL_AGREEMENT uses negotiated rates between carriers, SPECIAL_PRORATE uses custom allocation rules, DIRECT indicates single-carrier revenue with no proration.. Valid values are `IATA_PRORATE|BILATERAL_AGREEMENT|SPECIAL_PRORATE|DIRECT`',
    `recognition_date` DATE COMMENT 'The date on which the cargo revenue was recognized in the accounting system, typically aligned with flight departure or completion.',
    `revenue_status` STRING COMMENT 'Current status of the revenue record in the accounting lifecycle: recognized in financial statements, deferred to future period, adjusted after initial recognition, reversed due to cancellation, or disputed pending resolution.. Valid values are `RECOGNIZED|DEFERRED|ADJUSTED|REVERSED|DISPUTED`',
    `revenue_type` STRING COMMENT 'Classification of revenue by operational mode: belly cargo on passenger flights, dedicated freighter operations, charter services, or ground trucking.. Valid values are `BELLY_CARGO|FREIGHTER|CHARTER|TRUCKING`',
    `rtk_flown` DECIMAL(18,2) COMMENT 'Revenue tonne kilometers flown for this shipment segment, calculated as chargeable weight in tonnes multiplied by distance flown in kilometers. Standard cargo capacity utilization metric.',
    `service_level` STRING COMMENT 'The service level or product type under which the cargo was transported, affecting pricing and handling requirements.. Valid values are `GENERAL_CARGO|EXPRESS|PRIORITY|DEFERRED|DANGEROUS_GOODS|PERISHABLE`',
    `shipment_weight_kg` DECIMAL(18,2) COMMENT 'The chargeable weight of the cargo shipment in kilograms used for revenue calculation. May be actual weight or volumetric weight, whichever is greater.',
    `shipper_account_number` STRING COMMENT 'The account number of the shipper (consignor) who tendered the cargo for transport.',
    `source_system` STRING COMMENT 'The operational system from which this cargo revenue record originated, typically Mercator Cargo Management System or SAP S/4HANA FI module.',
    `surcharge_revenue_amount` DECIMAL(18,2) COMMENT 'Total surcharge revenue including fuel surcharges, security surcharges, and other applicable add-on charges.',
    `total_revenue_amount` DECIMAL(18,2) COMMENT 'Total cargo revenue amount for this record, sum of freight, surcharge, and handling revenue components.',
    `yield_per_kg` DECIMAL(18,2) COMMENT 'Revenue yield per kilogram, calculated as total revenue divided by chargeable weight. Key performance metric for cargo pricing effectiveness.',
    CONSTRAINT pk_cargo_revenue PRIMARY KEY(`cargo_revenue_id`)
) COMMENT 'Cargo revenue accounting record capturing recognized revenue per AWB or flight segment. Captures AWB reference, flight segment, revenue recognition date, freight revenue, surcharge revenue, handling revenue, total revenue, currency, exchange rate, proration method (IATA prorate factor or bilateral), interline settlement amount, yield per kg, revenue per RTK (Revenue Tonne Kilometer), and accounting period. Supports cargo P&L reporting and yield management. Aligns with Mercator revenue accounting module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`claim` (
    `claim_id` BIGINT COMMENT 'Primary key for claim',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Claim has awb_number (STRING) to identify which AWB the claim is filed against. AWB is the authoritative master document. Adding awb_id FK normalizes this reference and allows JOIN to retrieve full AW',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cargo claims are assigned to specific claims adjusters for investigation and settlement. Case management requirement - tracks workload, performance, and accountability. Essential for claims processing',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Cargo claims create liability provisions and expense entries that post to GL for financial statement accuracy and reserve management. Critical for loss provisioning and insurance recovery tracking.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Claims track origin_station_code for liability determination. Station link identifies responsible ground handler, operational context, handling performance data, and insurance coverage for claim inves',
    `claim_status` STRING COMMENT 'Current lifecycle status of the claim in the adjudication workflow. [ENUM-REF-CANDIDATE: draft|filed|under_investigation|pending_documents|liability_determined|approved|settled|rejected|closed — 9 candidates stripped; promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the claim incident: loss (missing shipment), damage (physical harm to goods), delay (late delivery), pilferage (theft), shortage (partial loss), or contamination (quality degradation).. Valid values are `loss|damage|delay|pilferage|shortage|contamination`',
    `claimant_address` STRING COMMENT 'Full mailing address of the claimant for official correspondence and settlement payment.',
    `claimant_contact_email` STRING COMMENT 'Primary email address for claim correspondence and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claimant_contact_phone` STRING COMMENT 'Primary telephone number for claimant contact during claim investigation.',
    `claimant_name` STRING COMMENT 'Full legal name of the party filing the claim (shipper, consignee, or their authorized representative).',
    `claimant_type` STRING COMMENT 'Classification of the claimant party role in the shipment transaction.. Valid values are `shipper|consignee|freight_forwarder|insurance_company|authorized_agent`',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total monetary amount claimed by the claimant for loss, damage, or delay, in the claim currency.',
    `commodity_description` STRING COMMENT 'Description of the goods subject to the claim, including nature, quantity, and packaging.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the claimed amount and settlement amount.. Valid values are `^[A-Z]{3}$`',
    `damage_description` STRING COMMENT 'Detailed narrative description of the loss, damage, delay, or other incident circumstances as reported by the claimant.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code of the shipment destination station.. Valid values are `^[A-Z]{3}$`',
    `discovery_date` DATE COMMENT 'Date when the loss, damage, or delay was first discovered by the claimant or carrier.',
    `filing_date` DATE COMMENT 'Date when the claim was formally filed by the claimant. Principal business event timestamp for the claim transaction.',
    `flight_date` DATE COMMENT 'Date of the flight on which the shipment was transported when the incident occurred.',
    `flight_number` STRING COMMENT 'Flight number on which the shipment was transported when the incident occurred, if applicable.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}$`',
    `incident_date` DATE COMMENT 'Date when the incident (loss, damage, delay) is believed to have occurred, if determinable.',
    `insurance_claim_reference` STRING COMMENT 'Reference number of the corresponding insurance claim filed by the carrier for recovery, if applicable.',
    `insurance_recovery_flag` BOOLEAN COMMENT 'Indicates whether the carrier pursued or intends to pursue insurance recovery for this claim.',
    `investigation_notes` STRING COMMENT 'Internal notes and findings from the claim investigation process.',
    `investigation_status` STRING COMMENT 'Current status of the internal investigation into the claim incident.. Valid values are `not_started|in_progress|awaiting_information|completed|suspended`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim record was last updated in the system.',
    `liability_determination` STRING COMMENT 'Outcome of the liability assessment: whether the carrier is liable, not liable, partially liable, or a third party is liable.. Valid values are `carrier_liable|carrier_not_liable|partial_liability|third_party_liable|pending`',
    `liability_limit_applicable` BOOLEAN COMMENT 'Indicates whether the Montreal Convention liability limit (Special Drawing Rights per kilogram) applies to this claim.',
    `outcome` STRING COMMENT 'Final outcome of the claim adjudication process.. Valid values are `approved|partially_approved|rejected|withdrawn|settled|closed_no_liability`',
    `reference_number` STRING COMMENT 'Externally-visible unique claim reference number used for tracking and correspondence. Business identifier for the claim.. Valid values are `^CLM[0-9]{10}$`',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the claim was rejected, including legal or procedural grounds.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final monetary amount approved for settlement payment to the claimant, in the claim currency. May differ from claimed amount based on liability determination.',
    `settlement_date` DATE COMMENT 'Date when the settlement payment was issued or the claim was formally settled.',
    `settlement_method` STRING COMMENT 'Method by which the settlement was paid or credited to the claimant.. Valid values are `bank_transfer|check|credit_note|offset|insurance_recovery`',
    `shipment_pieces` STRING COMMENT 'Number of pieces in the shipment as declared on the AWB.',
    `shipment_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms as declared on the AWB.',
    `supporting_documents_list` STRING COMMENT 'Comma-separated list or description of supporting documents submitted with the claim (e.g., commercial invoice, packing list, photos, survey report, delivery receipt).',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Cargo claim record for loss, damage, or delay incidents. Captures claim reference number, AWB number, claimant details, claim type (loss, damage, delay, pilferage), date of discovery, date of claim filing, claimed amount, currency, damage description, supporting documents list, investigation status, liability determination, settlement amount, settlement date, and claim outcome. Supports cargo liability management and insurance recovery. Aligns with Mercator claims module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`load_plan` (
    `load_plan_id` BIGINT COMMENT 'Primary key for load_plan',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Weight & balance records require aircraft-specific structural limits (MZFW, MTOW, MLW), CG envelope, and hold configuration for safe loading. Critical safety and regulatory compliance link for every c',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight for which this weight and balance calculation was performed.',
    `fuel_uplift_order_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_uplift_order. Business justification: Load plan finalization (actual zero fuel weight, CG) triggers final fuel uplift order adjustments. Critical for fuel cost allocation accuracy and weight-based fuel consumption variance reporting.',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: Load plans are executed at specific gates where aircraft park. Gate assignment determines loading equipment availability, ground handler assignment, turnaround coordination, and ramp access for load e',
    `employee_id` BIGINT COMMENT 'Employee identifier of the loadmaster who prepared and signed off on this load plan.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Weight/balance violations, CG exceedances, or load-related safety events require linkage to the specific load plan for investigation. Critical for flight safety analysis, loadmaster accountability, an',
    `actual_takeoff_weight_kg` DECIMAL(18,2) COMMENT 'Actual calculated takeoff weight for this flight including zero fuel weight plus fuel load. Must not exceed maximum takeoff weight.',
    `actual_zero_fuel_weight_kg` DECIMAL(18,2) COMMENT 'Actual calculated zero fuel weight for this flight including passengers, baggage, cargo, and crew. Must not exceed maximum zero fuel weight.',
    `aft_hold_weight_kg` DECIMAL(18,2) COMMENT 'Weight of cargo loaded in the aft cargo hold in kilograms. Critical for center of gravity calculation.',
    `arrival_station` STRING COMMENT 'Three-letter IATA airport code for the arrival station (e.g., LAX, CDG).. Valid values are `^[A-Z]{3}$`',
    `bulk_hold_weight_kg` DECIMAL(18,2) COMMENT 'Weight of loose cargo loaded in the bulk cargo hold in kilograms. Typically used for non-containerized shipments.',
    `cargo_center_of_gravity_mac_percent` DECIMAL(18,2) COMMENT 'Cargo contribution to the aircraft center of gravity expressed as a percentage of Mean Aerodynamic Chord (MAC). Critical for flight safety and trim calculation.',
    `cargo_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume of cargo loaded in cubic meters. Used for volumetric capacity utilization analysis alongside weight.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this load plan record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dangerous_goods_onboard_flag` BOOLEAN COMMENT 'Indicates whether dangerous goods (hazardous materials) are included in the cargo load. Triggers additional handling and notification requirements.',
    `departure_station` STRING COMMENT 'Three-letter IATA airport code for the departure station (e.g., JFK, LHR). Used for station-specific cargo handling rules.. Valid values are `^[A-Z]{3}$`',
    `dispatch_release_flag` BOOLEAN COMMENT 'Indicates whether the flight dispatcher has released the flight for departure based on this load plan. True indicates dispatch approval granted.',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight for which this load plan applies. Format: yyyy-MM-dd.',
    `flight_number` STRING COMMENT 'Commercial flight number for this load plan (e.g., AA1234). Denormalized for operational convenience.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `forward_hold_weight_kg` DECIMAL(18,2) COMMENT 'Weight of cargo loaded in the forward cargo hold in kilograms. Critical for center of gravity calculation.',
    `load_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of available cargo capacity utilized on this flight, calculated as actual cargo weight divided by available cargo capacity.',
    `load_plan_status` STRING COMMENT 'Current lifecycle status of the load plan. Draft indicates planning in progress; final indicates approved for dispatch; closed indicates flight departed.. Valid values are `draft|preliminary|final|revised|cancelled|closed`',
    `load_sheet_reference` STRING COMMENT 'Reference number of the official load sheet document generated for this flight. Links to the regulatory load and trim sheet.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `loadmaster_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the loadmaster signed off on the load plan, certifying accuracy and compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maximum_landing_weight_kg` DECIMAL(18,2) COMMENT 'Maximum allowable landing weight for the destination airport based on aircraft structural limits and runway conditions.',
    `maximum_takeoff_weight_kg` DECIMAL(18,2) COMMENT 'Maximum allowable takeoff weight for this flight based on aircraft performance, runway length, weather, and regulatory limits.',
    `maximum_zero_fuel_weight_kg` DECIMAL(18,2) COMMENT 'Maximum allowable weight of the aircraft without fuel for this flight, based on aircraft type and configuration. Regulatory limit for structural integrity.',
    `planned_landing_weight_kg` DECIMAL(18,2) COMMENT 'Planned landing weight at destination calculated as takeoff weight minus planned fuel burn. Must not exceed maximum landing weight.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this load plan meets all regulatory weight and balance requirements. False indicates out-of-limits condition requiring corrective action.',
    `remarks` STRING COMMENT 'Free-text field for loadmaster or dispatcher remarks regarding special conditions, deviations, or operational notes for this load plan.',
    `special_load_flag` BOOLEAN COMMENT 'Indicates whether the cargo includes special loads requiring non-standard handling (e.g., live animals, human remains, valuable cargo, oversized items).',
    `total_cargo_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of all cargo loaded on the flight in kilograms, including belly cargo and ULDs. Excludes passenger baggage.',
    `trim_adjustment_required_flag` BOOLEAN COMMENT 'Indicates whether trim adjustment is required due to cargo loading. True if cargo distribution requires stabilizer trim beyond normal range.',
    `uld_count` STRING COMMENT 'Total number of ULDs (containers and pallets) loaded on this flight. Used for capacity utilization analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this load plan record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_load_plan PRIMARY KEY(`load_plan_id`)
) COMMENT 'Weight and balance calculation record per flight capturing cargo contribution to aircraft loading. Captures flight number, flight date, aircraft registration, total cargo weight loaded, cargo weight by hold position (forward hold, aft hold, bulk), ULD positions and weights, cargo centre of gravity contribution, trim adjustment required, load sheet reference, loadmaster sign-off, and regulatory compliance flag. Critical for flight safety and dispatch. Links cargo domain to flight operations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`embargo` (
    `embargo_id` BIGINT COMMENT 'Primary key for embargo',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created the embargo record in the cargo management system.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Embargoes can trigger revenue adjustments or refund liabilities that must be recorded in GL for accurate financial reporting and customer refund processing.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Embargoes apply to origin_station_code for acceptance restrictions. Station link enables operational notification, ground handler coordination, booking system updates, and customer communication for e',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Embargoes are often mandated by regulatory requirements (sanctions, safety directives, customs restrictions). Links embargo enforcement to the specific regulation requiring it for compliance tracking ',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Embargoes are imposed on specific routes (origin-destination pairs). Booking acceptance systems, capacity control, and operational compliance require route-level embargo enforcement. Essential for emb',
    `affected_flight_number` STRING COMMENT 'Specific flight number affected by the embargo (e.g., AA1234). Nullable if embargo applies to all flights on a route or to a station broadly.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `affected_route_pattern` STRING COMMENT 'Route pattern or route group affected by the embargo (e.g., JFK-LHR, US-EU, Transatlantic). Nullable if embargo is station-specific or commodity-specific without route constraint.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether override approval is required to accept cargo under this embargo. True if approval workflow must be followed; False if embargo is absolute.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the embargo was cancelled before its scheduled end date. Nullable if embargo was not cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the embargo was cancelled before its scheduled expiry. Nullable if embargo was not cancelled. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `commodity_code` STRING COMMENT 'Harmonized System (HS) or airline-specific commodity code for goods affected by the embargo. Nullable if embargo applies to all commodities on a route or station.',
    `commodity_description` STRING COMMENT 'Human-readable description of the commodity or commodity group affected by the embargo (e.g., Lithium batteries, Perishable goods, Live animals).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the embargo record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dangerous_goods_class` STRING COMMENT 'IATA Dangerous Goods Regulation (DGR) class affected by the embargo (e.g., Class 1 - Explosives, Class 3 - Flammable Liquids, Class 9 - Miscellaneous). Nullable if embargo does not target DG specifically.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code for the destination station affected by the embargo. Nullable if embargo applies to all destinations for a given origin or commodity.. Valid values are `^[A-Z]{3}$`',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Date and time when the embargo expires and restrictions are lifted. Nullable for indefinite embargoes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Date and time when the embargo becomes effective and restrictions begin to apply. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `embargo_status` STRING COMMENT 'Current lifecycle status of the embargo: draft (pending approval), active (in effect), suspended (temporarily paused), expired (end date reached), or cancelled (terminated before expiry).. Valid values are `draft|active|suspended|expired|cancelled`',
    `embargo_type` STRING COMMENT 'Classification of the embargo defining the nature of the restriction: station closure (airport/facility closed), commodity restriction (specific goods prohibited), weight restriction (weight limits imposed), dangerous goods restriction (DG acceptance suspended), seasonal embargo (recurring seasonal restriction), or capacity embargo (capacity allocation frozen).. Valid values are `station_closure|commodity_restriction|weight_restriction|dangerous_goods_restriction|seasonal_embargo|capacity_embargo`',
    `issuing_authority` STRING COMMENT 'Name of the internal department, external regulatory body, or authority that issued the embargo (e.g., Cargo Operations, FAA, EASA, Local Civil Aviation Authority).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the embargo record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether embargo notification has been sent to affected stations, agents, and customers. True if notification distributed; False if pending.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when embargo notification was distributed to stakeholders. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `override_approval_authority` STRING COMMENT 'Role or department authorized to approve exceptions to the embargo (e.g., Cargo Director, Station Manager, Safety Officer). Nullable if no override is permitted.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the embargo: capacity constraint, safety incident, regulatory requirement, weather event, infrastructure failure, or security threat.. Valid values are `capacity_constraint|safety_incident|regulatory_requirement|weather_event|infrastructure_failure|security_threat`',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of the reason for the embargo, providing context for operational and customer communication.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for the embargo, used in operational communications and cargo systems. Format: EMB followed by 8-12 digits.. Valid values are `^EMB[0-9]{8,12}$`',
    `remarks` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or context related to the embargo.',
    `volume_restriction_cbm` DECIMAL(18,2) COMMENT 'Maximum volume in cubic meters allowed under the embargo. Nullable if embargo is not volume-based.',
    `weight_restriction_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms allowed under the embargo. Nullable if embargo is not weight-based.',
    CONSTRAINT pk_embargo PRIMARY KEY(`embargo_id`)
) COMMENT 'Cargo embargo record defining restrictions on cargo acceptance for specific routes, stations, or commodity types. Captures embargo reference, embargo type (station closure, commodity restriction, weight restriction, DG restriction, seasonal embargo), affected origin/destination airports, affected flight numbers or route, commodity codes affected, embargo start and end dates, reason code, issuing authority, and override approval process. Supports capacity and safety management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`service_product` (
    `service_product_id` BIGINT COMMENT 'Primary key for service_product',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing campaigns promote specific cargo products (express, perishables, temperature-controlled, dangerous goods services). Linking products to campaigns enables product-level campaign effectiveness',
    `acceptance_cutoff_hours` STRING COMMENT 'Number of hours before scheduled departure by which cargo must be physically accepted at the origin station. Critical for operational planning and customer communication.',
    `applicable_surcharges` STRING COMMENT 'Comma-separated list of surcharge codes that apply to this product (e.g., fuel surcharge, security surcharge, peak season surcharge). Used for rate calculation and billing.',
    `booking_lead_time_hours` STRING COMMENT 'Minimum advance booking time required before scheduled departure, measured in hours. Used to enforce operational cutoff times and capacity planning windows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo service product record was first created in the system. Used for audit trail and data lineage.',
    `dangerous_goods_accepted` BOOLEAN COMMENT 'Flag indicating whether this product accepts dangerous goods shipments. Determines whether DG declarations and certifications are required for bookings.',
    `destination_region_restriction` STRING COMMENT 'Comma-separated list of IATA region codes or airport codes where this product is available for destination bookings. Empty indicates global availability. Used for regional product offerings.',
    `dimensional_weight_factor` DECIMAL(18,2) COMMENT 'Volumetric conversion factor used to calculate chargeable weight from shipment dimensions (typically 6000 for air cargo, representing cubic centimeters per kilogram). Used when volumetric weight exceeds actual weight.',
    `discontinued_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo service product was discontinued and removed from active offerings. Null for active products. Used for product lifecycle analytics and historical reporting.',
    `effective_end_date` DATE COMMENT 'Date after which this cargo service product is no longer available for new bookings. Null indicates indefinite availability. Used for product lifecycle management and seasonal offerings.',
    `effective_start_date` DATE COMMENT 'Date from which this cargo service product becomes available for booking and operational use. Used for product lifecycle management and seasonal offerings.',
    `eligible_commodity_codes` STRING COMMENT 'Comma-separated list of IATA commodity codes eligible for this product. Defines which types of cargo can be booked under this service offering. Empty indicates all commodities accepted.',
    `eligible_uld_types` STRING COMMENT 'Comma-separated list of ULD type codes compatible with this product (e.g., AKE, LD3, PMC). Null if product does not support ULD containerization.',
    `freighter_only_indicator` BOOLEAN COMMENT 'Flag indicating whether this product is restricted to dedicated freighter aircraft and cannot be carried in passenger aircraft belly cargo. Typically true for dangerous goods and oversized cargo.',
    `insurance_available` BOOLEAN COMMENT 'Flag indicating whether cargo insurance is available as an add-on for this product. Determines whether declared value for carriage can be specified at booking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo service product record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `live_animal_accepted` BOOLEAN COMMENT 'Flag indicating whether this product accepts live animal shipments. Determines applicability of IATA Live Animals Regulations (LAR) and special handling requirements.',
    `maximum_piece_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight per individual piece accepted under this product, measured in kilograms. Null indicates no piece weight restriction. Used for operational feasibility and equipment capacity checks.',
    `maximum_shipment_weight_kg` DECIMAL(18,2) COMMENT 'Maximum total weight per shipment accepted under this product, measured in kilograms. Null indicates no shipment weight restriction. Used for capacity allocation and aircraft weight and balance.',
    `minimum_chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Minimum weight threshold in kilograms for rate calculation. Shipments below this weight are charged at this minimum. Null indicates no minimum.',
    `origin_region_restriction` STRING COMMENT 'Comma-separated list of IATA region codes or airport codes where this product is available for origin bookings. Empty indicates global availability. Used for regional product offerings.',
    `priority_loading_indicator` BOOLEAN COMMENT 'Flag indicating whether this product receives priority loading on aircraft. True for express and premium products; affects weight and balance planning and turnaround sequencing.',
    `product_code` STRING COMMENT 'Unique alphanumeric code identifying the cargo service product in operational systems. Used for booking, rating, and billing. Aligns with Mercator product catalog codes.. Valid values are `^[A-Z0-9]{3,10}$`',
    `product_description` STRING COMMENT 'Detailed description of the cargo service product, including key features, benefits, and differentiators. Used for customer communication and sales enablement.',
    `product_name` STRING COMMENT 'Marketing and operational name of the cargo service product (e.g., Express Freight, Cool Chain, Live Animals, Pharma Secure, Courier, General Cargo, Dangerous Goods Express).',
    `product_owner` STRING COMMENT 'Business unit or department responsible for this cargo service product definition, pricing, and lifecycle management. Used for governance and accountability.',
    `product_status` STRING COMMENT 'Current lifecycle status of the cargo service product. Controls availability for new bookings and operational visibility.. Valid values are `active|inactive|suspended|discontinued|pending_approval`',
    `product_type` STRING COMMENT 'Classification of the cargo service product by operational category. Determines handling requirements, equipment needs, and regulatory compliance obligations.. Valid values are `standard|express|specialized|temperature_controlled|live_animal|dangerous_goods`',
    `restricted_commodity_codes` STRING COMMENT 'Comma-separated list of IATA commodity codes explicitly excluded from this product. Used to enforce product-specific restrictions (e.g., no dangerous goods on standard service).',
    `sales_channel_availability` STRING COMMENT 'Comma-separated list of sales channels through which this product can be booked (e.g., direct, GDS, agent, web, mobile). Used for channel management and distribution strategy.',
    `service_level` STRING COMMENT 'Service tier indicating speed, priority, and handling commitment. Determines transit time commitments, loading priority, and pricing tier.. Valid values are `economy|standard|priority|express|premium|guaranteed`',
    `special_handling_codes` STRING COMMENT 'Comma-separated list of IATA special handling codes (SHC) that apply by default to this product (e.g., PER for perishables, AVI for live animals, DGR for dangerous goods). Drives operational handling procedures.',
    `temperature_control_required` BOOLEAN COMMENT 'Flag indicating whether this product requires active temperature control (cool chain, pharma). Determines equipment requirements and handling procedures.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature threshold in Celsius for temperature-controlled products. Null for non-temperature-controlled products. Used for cool chain and pharmaceutical cargo.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature threshold in Celsius for temperature-controlled products. Null for non-temperature-controlled products. Used for cool chain and pharmaceutical cargo.',
    `tracking_capability_level` STRING COMMENT 'Level of shipment tracking and visibility provided for this product. Determines frequency of status updates and customer access to tracking data.. Valid values are `basic|standard|enhanced|real_time`',
    `transit_time_hours` STRING COMMENT 'Committed maximum transit time from origin acceptance to destination delivery, measured in hours. Forms the basis of service level agreements (SLA) and On-Time Performance (OTP) measurement.',
    `uld_compatible_indicator` BOOLEAN COMMENT 'Flag indicating whether this product supports Unit Load Device (ULD) containerization. Affects capacity planning, loading procedures, and pricing.',
    CONSTRAINT pk_service_product PRIMARY KEY(`service_product_id`)
) COMMENT 'Cargo product catalog record defining the airlines branded cargo service offerings. Captures product code, product name (e.g., Express Freight, Cool Chain, Live Animals, Pharma, Courier), product description, service level commitments (transit time, priority loading, temperature control), eligible commodity types, applicable surcharges, booking lead time requirements, tracking capabilities, and product status. Distinct from freight rates — this is the service definition layer. Aligns with Mercator product management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`customs_entry` (
    `customs_entry_id` BIGINT COMMENT 'Unique identifier for the customs declaration record. Primary key for the customs entry entity.',
    `awb_id` BIGINT COMMENT 'Reference to the air waybill associated with this customs entry. Links the customs declaration to the shipment document.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Customs brokerage services are procured from licensed vendors. Essential for broker performance tracking, clearance time SLAs, and reconciliation of customs clearance fees against vendor invoices.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Customs entries are processed by specific customs clearance officers. Regulatory requirement - must track who filed the entry for compliance audits and liability. Essential for customs broker accounta',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Customs duties and taxes paid or collected post to GL as expenses or liabilities. Critical for customs cost recovery, tax compliance, and cross-border trade accounting.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Customs entries specify port_of_entry_code for clearance. Station link validates customs facility availability, regulatory authority, broker assignment, operating hours, and examination capability for',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each customs entry must comply with specific import/export regulations of the jurisdiction (e.g., CBP 19 CFR Part 122). Essential for customs clearance processes and compliance verification.',
    `certificate_of_origin_number` STRING COMMENT 'Reference number of the certificate of origin document supporting the declared country of origin. Required for preferential duty claims.',
    `charges_currency_code` STRING COMMENT 'Three-letter ISO currency code for all customs charges and fees. Typically the currency of the importing or exporting country.. Valid values are `^[A-Z]{3}$`',
    `commodity_description` STRING COMMENT 'Detailed description of the goods being declared for customs purposes. Must accurately describe the nature, composition, and intended use of the cargo.',
    `country_of_destination` STRING COMMENT 'Three-letter ISO country code indicating the final destination country for the goods. Used for export control and trade statistics.. Valid values are `^[A-Z]{3}$`',
    `country_of_export` STRING COMMENT 'Three-letter ISO country code indicating the country from which the goods were exported. May differ from country of origin for re-exports.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the goods were manufactured or produced. Determines eligibility for preferential trade agreements and origin-based duties.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this customs entry record was first created in the system. Audit trail for record creation.',
    `customs_broker_license_number` STRING COMMENT 'Official license or registration number of the customs broker authorized to conduct customs business in the jurisdiction.',
    `customs_duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty assessed on the imported or exported goods. Calculated based on tariff classification, value, and applicable trade agreements.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the goods declared for customs purposes. Used as the basis for calculating duties and taxes.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO currency code for the declared value amount. Must align with customs authority requirements for valuation.. Valid values are `^[A-Z]{3}$`',
    `entry_number` STRING COMMENT 'Official customs entry number assigned by the customs authority. Unique identifier for tracking the declaration through customs clearance process.. Valid values are `^[A-Z0-9]{10,20}$`',
    `entry_status` STRING COMMENT 'Current status of the customs entry in the clearance workflow. Tracks progression from initial filing through final release or other disposition. [ENUM-REF-CANDIDATE: draft|filed|under_examination|released|held|seized|cancelled — 7 candidates stripped; promote to reference product]',
    `entry_type` STRING COMMENT 'Type of customs declaration indicating the nature of the cargo movement across borders. Determines applicable customs procedures and documentation requirements.. Valid values are `import|export|transit|transshipment|re-export|temporary_admission`',
    `examination_result` STRING COMMENT 'Outcome of the customs examination or inspection. Indicates whether the cargo passed inspection or if issues were identified.. Valid values are `passed|discrepancy_found|violation_detected|pending|not_applicable`',
    `examination_timestamp` TIMESTAMP COMMENT 'Date and time when customs examination or inspection was conducted. Null if no examination was performed.',
    `examination_type` STRING COMMENT 'Type of customs examination or inspection conducted on the cargo. Ranges from documentary review to full physical inspection.. Valid values are `none|documentary|physical|x-ray|canine|full_inspection`',
    `exporter_name` STRING COMMENT 'Legal name of the party exporting the goods. Required for export declarations and trade compliance.',
    `exporter_tax_number` STRING COMMENT 'Tax identification number or business registration number of the exporter. Required for export documentation and compliance.',
    `filing_timestamp` TIMESTAMP COMMENT 'Date and time when the customs declaration was officially filed with the customs authority. Critical for compliance with advance filing requirements.',
    `hold_reason` STRING COMMENT 'Explanation for why the cargo is being held by customs. May include documentation issues, valuation disputes, or regulatory concerns.',
    `hs_code` STRING COMMENT 'International commodity classification code used to determine applicable duties, taxes, and regulatory requirements. Six to ten digit code from the Harmonized Commodity Description and Coding System.. Valid values are `^[0-9]{6,10}$`',
    `importer_of_record` STRING COMMENT 'Legal name of the party responsible for ensuring imported goods comply with local laws and for paying duties and taxes. Legally liable entity for the import.',
    `importer_tax_number` STRING COMMENT 'Tax identification number or business registration number of the importer of record. Required for customs clearance and duty payment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this customs entry record was last updated. Audit trail for tracking changes to the declaration.',
    `payment_method` STRING COMMENT 'Method by which customs duties and taxes are paid. May include immediate payment or deferred payment arrangements. [ENUM-REF-CANDIDATE: cash|check|wire_transfer|ach|periodic_monthly_statement|bond|deferred — 7 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'Transaction reference number for the payment of customs duties and taxes. Links the customs entry to financial settlement records.',
    `preferential_trade_agreement` STRING COMMENT 'Name or code of the preferential trade agreement under which reduced duties are claimed. Examples include USMCA, EU-FTA, ASEAN agreements.',
    `regulatory_authority_code` STRING COMMENT 'Code identifying the customs or regulatory authority responsible for processing this entry. May be port-specific or national authority code.. Valid values are `^[A-Z]{2,6}$`',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo was officially released by customs for delivery or onward movement. Marks completion of customs clearance process.',
    `remarks` STRING COMMENT 'Free-text field for additional information, special instructions, or notes related to the customs entry. May include handling instructions or clarifications.',
    `special_program_indicator` STRING COMMENT 'Code or flag indicating participation in special customs programs such as AEO (Authorized Economic Operator), C-TPAT, or bonded warehouse programs.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount assessed on the goods, including VAT, GST, excise, or other applicable taxes. Separate from customs duty.',
    `total_charges_amount` DECIMAL(18,2) COMMENT 'Total of all customs duties, taxes, and fees assessed on this entry. Sum of all financial obligations to clear the cargo.',
    CONSTRAINT pk_customs_entry PRIMARY KEY(`customs_entry_id`)
) COMMENT 'Customs declaration and clearance record for cargo crossing international borders. Captures customs entry number, AWB reference, entry type (import, export, transit, transshipment), commodity HS code, declared value, country of origin, country of destination, customs broker details, duty and tax amounts, customs status (filed, under examination, released, held, seized), examination type, release timestamp, and regulatory authority reference. Supports import/export compliance and customs clearance workflows.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`interline_cargo` (
    `interline_cargo_id` BIGINT COMMENT 'Unique identifier for the interline cargo agreement record.',
    `awb_id` BIGINT COMMENT 'Reference to the master air waybill under which this interline cargo is carried.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Interline revenue and cost shares post to GL for consolidated financial reporting and interline settlement accounting. Links interline operations to financial statements.',
    `interline_billing_id` BIGINT COMMENT 'Foreign key linking to finance.interline_billing. Business justification: Interline cargo segments generate proration billing entries for settlement with partner airlines. Essential for IATA interline billing, CASS settlement, and partner revenue reconciliation.',
    `operating_certificate_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_certificate. Business justification: Interline cargo operations require valid operating certificates for each carrier segment. Essential for verifying partner airline authorization and route authority compliance in interline agreements.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Interline cargo segments are prorated and settled by route. Partner settlement, proration calculation, and interline revenue management require route context for each segment. Critical for interline a',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Interline segments track segment_origin_station_code for transfer. Station link provides transfer infrastructure, ground handler, minimum connect time, and customs capability for proration and settlem',
    `agreement_effective_date` DATE COMMENT 'Date from which the interline cargo agreement becomes valid and applicable to shipments.',
    `agreement_expiry_date` DATE COMMENT 'Date on which the interline cargo agreement expires or is scheduled for renewal. Null indicates an open-ended agreement.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the interline cargo agreement governing this shipment.. Valid values are `ACTIVE|SUSPENDED|TERMINATED|PENDING_APPROVAL|EXPIRED|UNDER_REVIEW`',
    `cass_settlement_reference` STRING COMMENT 'Reference number linking this interline cargo record to the IATA CASS settlement transaction for inter-carrier billing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline cargo record was first created in the system.',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Flag indicating whether this interline cargo segment contains dangerous goods requiring special handling and documentation.',
    `handling_carrier_code` STRING COMMENT 'IATA code of the airline responsible for physical handling and acceptance of cargo at the interline transfer point.. Valid values are `^[A-Z0-9]{2,3}$`',
    `interline_agreement_reference` STRING COMMENT 'Unique reference number of the bilateral or multilateral interline cargo agreement governing this shipment.',
    `interline_awb_prefix` STRING COMMENT 'Three-digit AWB prefix assigned to the partner airline for interline cargo documentation.. Valid values are `^[0-9]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline cargo record was last updated or modified.',
    `partner_airline_code` STRING COMMENT 'Two or three-letter IATA airline code of the partner carrier operating the interline segment.. Valid values are `^[A-Z0-9]{2,3}$`',
    `proration_factor` DECIMAL(18,2) COMMENT 'Numeric factor applied to calculate the partner airlines revenue share when using IATA prorate factor method. Typically a decimal value between 0 and 1.',
    `proration_method` STRING COMMENT 'Method used to allocate revenue between carriers for this interline segment. IATA prorate factor applies standard industry formulas, bilateral rate uses negotiated carrier-to-carrier rates, mileage proration allocates by distance, special prorate agreement applies custom terms, and fixed amount uses predetermined values.. Valid values are `IATA_PRORATE_FACTOR|BILATERAL_RATE|MILEAGE_PRORATION|SPECIAL_PRORATE_AGREEMENT|FIXED_AMOUNT`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or exceptions related to this interline cargo agreement or segment.',
    `route_segment_sequence` STRING COMMENT 'Sequential order of this segment within the multi-carrier routing (1 for first segment, 2 for second, etc.).',
    `segment_chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Chargeable weight in kilograms used for revenue calculation on this interline segment, which may differ from actual weight based on volumetric calculations.',
    `segment_destination_station_code` STRING COMMENT 'Three-letter IATA airport code for the destination of this interline segment.. Valid values are `^[A-Z]{3}$`',
    `segment_flight_date` DATE COMMENT 'Scheduled departure date of the partner airline flight carrying this interline cargo segment.',
    `segment_flight_number` STRING COMMENT 'Flight number operated by the partner airline for this interline cargo segment.',
    `segment_pieces` STRING COMMENT 'Number of individual pieces or packages carried on this interline segment.',
    `segment_revenue_share_amount` DECIMAL(18,2) COMMENT 'Calculated revenue amount allocated to the partner airline for operating this interline segment, based on the proration method.',
    `segment_revenue_share_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the segment revenue share amount.. Valid values are `^[A-Z]{3}$`',
    `segment_volume_cbm` DECIMAL(18,2) COMMENT 'Volume in cubic meters of cargo carried on this interline segment.',
    `segment_weight_kg` DECIMAL(18,2) COMMENT 'Actual or allocated weight in kilograms of cargo carried on this interline segment.',
    `settlement_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the interline revenue settlement for this cargo segment was finalized and funds transferred between carriers.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for final interline settlement between carriers.. Valid values are `^[A-Z]{3}$`',
    `settlement_period` STRING COMMENT 'IATA CASS billing period identifier (typically YYYYMM format) during which this interline cargo settlement is processed.',
    `settlement_status` STRING COMMENT 'Current status of the interline revenue settlement process for this cargo segment.. Valid values are `PENDING|SUBMITTED|SETTLED|DISPUTED|ADJUSTED|CANCELLED`',
    `settlement_submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the interline revenue settlement for this cargo segment was submitted to IATA CASS for processing.',
    `special_handling_codes` STRING COMMENT 'Comma-separated list of IATA special handling codes applicable to this interline cargo segment (e.g., PER for perishable, AVI for live animals, DGR for dangerous goods).',
    `transfer_manifest_reference` STRING COMMENT 'Reference number of the cargo manifest documenting the transfer of cargo between carriers at the interline point.',
    `uld_number` STRING COMMENT 'Serial number of the ULD container or pallet used to transport cargo on this interline segment, if applicable.',
    CONSTRAINT pk_interline_cargo PRIMARY KEY(`interline_cargo_id`)
) COMMENT 'Interline cargo agreement and proration record governing cargo carried on partner airline segments under a single AWB. Captures interline agreement reference, partner airline code, route segments, proration method (IATA prorate factor, bilateral rate, mileage proration), interline revenue share per segment, settlement currency, CASS settlement reference, interline AWB prefix, and agreement validity. Supports multi-carrier cargo revenue settlement. Aligns with Mercator interline module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` (
    `cargo_surcharge_id` BIGINT COMMENT 'Unique identifier for the cargo surcharge rate record. Primary key.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Surcharges are revenue line items that post to specific GL accounts for revenue recognition and surcharge revenue reporting. Essential for fuel surcharge and security fee accounting.',
    `approval_status` STRING COMMENT 'Workflow approval status for the surcharge rate. Ensures proper authorization before surcharge becomes active.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by_user` STRING COMMENT 'User ID or name of the revenue management or pricing authority who approved this surcharge rate.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the surcharge rate was approved for use.',
    `calculation_basis` STRING COMMENT 'Method used to calculate the surcharge amount (per kilogram, per shipment, per Air Waybill (AWB), percentage of base freight, flat rate per transaction, or per piece).. Valid values are `per_kg|per_shipment|per_awb|percentage_of_freight|flat_rate|per_piece`',
    `commodity_code` STRING COMMENT 'Harmonized System (HS) or airline-specific commodity code to which the surcharge applies. Null indicates surcharge applies to all commodities.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the surcharge rate record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the surcharge rate record was first created in the system.',
    `destination_country_code` STRING COMMENT 'Two-letter ISO 3166-1 alpha-2 country code for destination applicability. Used when surcharge applies to entire country rather than specific station.. Valid values are `^[A-Z]{2}$`',
    `destination_region_code` STRING COMMENT 'Geographic region code for destination applicability (e.g., EMEA, APAC, AMER). Used for regional surcharge rules.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport or station code where the surcharge applies at destination. Null indicates surcharge applies to all destinations.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the surcharge rate becomes valid and applicable to new bookings and shipments.',
    `expiry_date` DATE COMMENT 'Date on which the surcharge rate ceases to be valid. Null indicates open-ended validity.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the surcharge rate record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the surcharge rate record was last updated.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum surcharge amount cap. Limits the surcharge to prevent excessive charges on high-value or high-weight shipments.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum surcharge amount to be applied regardless of calculated value. Ensures a floor charge for the surcharge.',
    `origin_country_code` STRING COMMENT 'Two-letter ISO 3166-1 alpha-2 country code for origin applicability. Used when surcharge applies to entire country rather than specific station.. Valid values are `^[A-Z]{2}$`',
    `origin_region_code` STRING COMMENT 'Geographic region code for origin applicability (e.g., EMEA, APAC, AMER). Used for regional surcharge rules.',
    `origin_station_code` STRING COMMENT 'Three-letter IATA airport or station code where the surcharge applies at origin. Null indicates surcharge applies to all origins.. Valid values are `^[A-Z]{3}$`',
    `pass_through_flag` BOOLEAN COMMENT 'Indicates whether the surcharge is a pass-through charge collected on behalf of a third party (e.g., government, airport authority) versus airline revenue. True if pass-through, False if airline revenue.',
    `published_flag` BOOLEAN COMMENT 'Indicates whether the surcharge rate has been published to external systems (GDS, cargo portals, agent systems). True if published, False if internal only.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the surcharge rate was published to external distribution channels.',
    `rate_amount` DECIMAL(18,2) COMMENT 'Numeric value of the surcharge rate. Interpretation depends on calculation_basis (e.g., dollar amount per kg, percentage value, flat fee amount).',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the surcharge rate is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `regulatory_basis` STRING COMMENT 'Legal or regulatory justification for the surcharge (e.g., government-mandated security fee, environmental levy, customs processing fee). Used for compliance and transparency.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special conditions, or explanatory information about the surcharge rate.',
    `route_type` STRING COMMENT 'Classification of route to which the surcharge applies (domestic within country, international cross-border, regional within continent, intercontinental long-haul).. Valid values are `domestic|international|regional|intercontinental`',
    `service_level` STRING COMMENT 'Cargo service level to which the surcharge applies. Null indicates surcharge applies to all service levels.. Valid values are `standard|express|priority|economy|next_flight_out`',
    `special_handling_code` STRING COMMENT 'Three-letter IATA Special Handling Code (SHC) to which the surcharge applies (e.g., DGR for Dangerous Goods, PER for Perishables, VAL for Valuables, AVI for Live Animals). Null indicates surcharge applies regardless of handling requirements.. Valid values are `^[A-Z]{3}$`',
    `surcharge_category` STRING COMMENT 'High-level classification of the surcharge type for grouping and reporting purposes.. Valid values are `fuel|security|handling|regulatory|geographic|seasonal`',
    `surcharge_code` STRING COMMENT 'Standard code identifying the surcharge type (e.g., FSC for Fuel Surcharge, SSC for Security Surcharge, DGS for Dangerous Goods Surcharge, OVS for Oversize Surcharge, RAS for Remote Area Surcharge, CAF for Currency Adjustment Factor, HAN for Handling Surcharge).. Valid values are `^[A-Z]{2,6}$`',
    `surcharge_name` STRING COMMENT 'Full descriptive name of the surcharge (e.g., Fuel Surcharge, Security Surcharge, Dangerous Goods Handling Surcharge, Oversize Cargo Surcharge, Remote Area Delivery Surcharge, Currency Adjustment Factor, Peak Season Surcharge).',
    `surcharge_status` STRING COMMENT 'Current lifecycle status of the surcharge rate record. Controls whether the surcharge is applied in rating and invoicing processes.. Valid values are `active|inactive|pending|suspended|expired`',
    `tax_treatment_code` STRING COMMENT 'Code indicating how the surcharge is treated for tax purposes (e.g., taxable, exempt, zero-rated). Used for accurate tax calculation and reporting.',
    `uld_type_code` STRING COMMENT 'IATA ULD type code to which the surcharge applies (e.g., AKE, PMC, PAG). Used for ULD-specific surcharges. Null indicates surcharge applies regardless of ULD type.. Valid values are `^[A-Z0-9]{3,5}$`',
    `weight_break_maximum_kg` DECIMAL(18,2) COMMENT 'Maximum chargeable weight in kilograms for this surcharge rate to apply. Used for weight-tiered surcharge structures.',
    `weight_break_minimum_kg` DECIMAL(18,2) COMMENT 'Minimum chargeable weight in kilograms for this surcharge rate to apply. Used for weight-tiered surcharge structures.',
    CONSTRAINT pk_cargo_surcharge PRIMARY KEY(`cargo_surcharge_id`)
) COMMENT 'Cargo surcharge rate master record defining all applicable surcharges applied on top of base freight rates. Captures surcharge code, surcharge name (fuel surcharge FSC, security surcharge SSC, handling surcharge, DG surcharge, oversize surcharge, remote area surcharge, currency adjustment factor CAF), calculation basis (per kg, per shipment, per AWB, percentage of freight), rate amount, currency, origin/destination applicability, validity period, and surcharge status. Reference entity used in rating and invoicing.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`security_screening` (
    `security_screening_id` BIGINT COMMENT 'Unique identifier for the cargo security screening record. Primary key for the security screening entity.',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Security_screening has awb_number (STRING) to identify which AWB the screening applies to. AWB is the authoritative master document. Adding awb_id FK normalizes this reference and allows JOIN to retri',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Security screening alarms or failures that escalate to safety events (e.g., undeclared dangerous goods discovered, security threats) require occurrence linkage for regulatory reporting, investigation,',
    `operational_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.operational_approval. Business justification: Cargo security screening requires operational approvals for screening methods, equipment certification, and known consignor programs. Real business need: validating screening authority and method comp',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Cargo security screening must comply with TSA, EASA, and local security regulations (e.g., TSA 49 CFR 1546). Links screening records to applicable security requirements for audit compliance.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the individual who performed the screening. Required for accountability and audit trail.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Security screening tracks screening_location_code for compliance. Station link provides regulatory authority, equipment certification, screener certification requirements, and reporting obligations fo',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Security screening services and equipment are procured from certified vendors (regulated agents). Links screening compliance to vendor certification tracking and service-level agreement monitoring.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this screening event.',
    `rescreening_security_screening_id` BIGINT COMMENT 'Self-referencing FK on security_screening (rescreening_security_screening_id)',
    `acceptance_station_code` STRING COMMENT 'Three-letter IATA code of the station where the cargo was accepted after screening.. Valid values are `^[A-Z]{3}$`',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the screened cargo was formally accepted for carriage by the airline.',
    `alarm_reason` STRING COMMENT 'Detailed description of why the screening resulted in an alarm. Confidential security information used for investigation and resolution.',
    `chain_of_custody_verified_flag` BOOLEAN COMMENT 'Indicates whether the secure chain of custody has been verified from screening through to loading. Critical for security compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this security screening record was first created in the system.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the piece contains dangerous goods, requiring specialized screening procedures and handling.',
    `equipment_calibration_date` DATE COMMENT 'Date when the screening equipment was last calibrated. Ensures equipment accuracy and regulatory compliance.',
    `known_consignor_flag` BOOLEAN COMMENT 'Indicates whether the shipper holds Known Consignor status, allowing exemption from certain screening requirements under EU ACC3 regulations.',
    `known_consignor_reference` STRING COMMENT 'Reference number or certification identifier for the Known Consignor status, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this security screening record was last updated.',
    `piece_dimensions_cm` STRING COMMENT 'Dimensions of the piece in centimeters, typically formatted as length x width x height. Used to determine screening equipment compatibility.',
    `piece_number` STRING COMMENT 'Sequential piece number within the shipment being screened. Enables piece-level screening tracking for multi-piece shipments.',
    `piece_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the individual piece being screened, in kilograms. Used for screening method determination and capacity planning.',
    `regulated_agent_flag` BOOLEAN COMMENT 'Indicates whether the cargo was accepted from a Regulated Agent (RA3) who has performed screening on behalf of the airline.',
    `regulated_agent_reference` STRING COMMENT 'Certification or approval number of the Regulated Agent who performed the screening.',
    `regulatory_authority_code` STRING COMMENT 'Code identifying the regulatory authority governing this screening (TSA for US, EASA for EU, CAAC for China, CASA for Australia, DGCA for India, TCCA for Canada).. Valid values are `TSA|EASA|CAAC|CASA|DGCA|TCCA`',
    `regulatory_submission_reference` STRING COMMENT 'Reference number or confirmation code from the regulatory authority submission system.',
    `regulatory_submission_timestamp` TIMESTAMP COMMENT 'Date and time when screening data was submitted to the regulatory authority for compliance reporting.',
    `remarks` STRING COMMENT 'Additional notes or observations recorded during the screening process. Free-text field for operational details.',
    `resolution_action` STRING COMMENT 'Action taken to resolve an alarm or inconclusive screening result. Documents the follow-up process for non-clear screening outcomes.. Valid values are `cleared|rejected|re-screened|escalated|physical_inspection_performed`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution process for screening alarms or issues. Confidential security information.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the screening alarm or issue was resolved. Tracks time-to-resolution for operational performance.',
    `screener_certification_expiry_date` DATE COMMENT 'Expiration date of the screeners security certification. Must be valid at time of screening for regulatory compliance.',
    `screener_certification_number` STRING COMMENT 'Certification or license number of the screener, verifying their authorization to perform cargo security screening.',
    `screener_name` STRING COMMENT 'Full name of the certified screener who performed the security inspection.',
    `screening_equipment_code` STRING COMMENT 'Unique identifier of the screening equipment used (X-ray machine, ETD device, etc.). Required for equipment calibration and maintenance audit trail.',
    `screening_exemption_reason` STRING COMMENT 'Detailed justification for any screening exemption applied, including regulatory basis and authorization reference.',
    `screening_method` STRING COMMENT 'The primary method used to screen the cargo. X-ray for radiographic inspection, ETD for Explosive Trace Detection, physical inspection for manual examination, canine for sniffer dog detection, known consignor for exemption based on shipper status, regulated agent for RA3 certification, multi-method for combination approach. [ENUM-REF-CANDIDATE: x-ray|etd|physical_inspection|canine|known_consignor|regulated_agent|multi-method — 7 candidates stripped; promote to reference product]',
    `screening_result` STRING COMMENT 'Final determination of the screening process. Passed indicates no threat detected, failed indicates threat or non-compliance, inconclusive requires additional screening, exempted indicates regulatory exemption applied.. Valid values are `passed|failed|inconclusive|exempted`',
    `screening_status` STRING COMMENT 'Current status of the security screening process for this piece. Clear indicates passed screening, alarm indicates potential threat detected, re-screen required indicates inconclusive result, exempted indicates known consignor exemption applied.. Valid values are `clear|alarm|re-screen_required|exempted|pending|failed`',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time when the security screening was performed. Critical for chain-of-custody and regulatory compliance documentation.',
    `security_status_code` STRING COMMENT 'Standardized security status code for cargo. SPX (Screened to Passenger Aircraft Standard), SCO (Screened Cargo), SHR (Secure Chain of Custody), NSC (Not Screened Cargo), EXM (Exempted).. Valid values are `SPX|SCO|SHR|NSC|EXM`',
    `special_handling_codes` STRING COMMENT 'IATA special handling codes applicable to this shipment that may affect screening requirements (e.g., PER for perishables, AVI for live animals, VAL for valuables).',
    CONSTRAINT pk_security_screening PRIMARY KEY(`security_screening_id`)
) COMMENT 'Cargo security screening and acceptance verification record documenting the regulated screening process applied to each shipment before loading. Captures screening method (X-ray, ETD, physical inspection, sniffer dog, known consignor exemption), screening result (clear, alarm, re-screen required), screener identity and certification, screening equipment ID, screening timestamp, piece-level screening status, Regulated Agent (RA3) or Known Consignor (KC) reference, security status code (SPX, SCO, SHR), and regulatory authority submission. Mandatory for EU ACC3, TSA CCSP, and ICAO Annex 17 compliance. SSOT for cargo security chain-of-custody evidence.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` (
    `forwarder_route_agreement_id` BIGINT COMMENT 'Unique identifier for this freight forwarder route agreement record. Primary key.',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to the freight forwarder party in this route agreement',
    `route_id` BIGINT COMMENT 'Foreign key linking to the airline route covered by this agreement',
    `actual_volume_shipped_kg` DECIMAL(18,2) COMMENT 'Cumulative cargo volume in kilograms shipped by this forwarder on this route during the current contract period. Used to track performance against minimum volume commitments.',
    `agreement_status` STRING COMMENT 'Current operational status of this forwarder-route agreement: active (currently in force), suspended (temporarily inactive), expired (past end date), pending_renewal (under renegotiation), terminated (permanently ended).',
    `contract_end_date` DATE COMMENT 'Expiration or renewal date of the commercial agreement for this forwarder-route partnership. Null indicates an evergreen agreement.',
    `contract_start_date` DATE COMMENT 'Effective start date of the commercial agreement between this freight forwarder and the airline for this specific route.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forwarder-route agreement record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forwarder-route agreement record was last updated.',
    `last_shipment_date` DATE COMMENT 'Date of the most recent cargo shipment by this forwarder on this route. Used for activity monitoring and dormant agreement identification.',
    `minimum_volume_commitment_kg` DECIMAL(18,2) COMMENT 'Minimum cargo volume in kilograms that the freight forwarder has committed to ship on this route within the contract period. Used for capacity planning and commercial performance tracking.',
    `payment_terms_override` STRING COMMENT 'Route-specific payment terms that override the forwarders global payment terms. Captures negotiated terms such as Net 15, Net 45, or Prepaid that apply only to cargo shipments on this route.',
    `preferred_partner_status` STRING COMMENT 'Commercial status of the forwarder on this specific route: preferred (priority access and preferential rates), standard (normal commercial terms), restricted (limited capacity allocation). This status is route-specific and may vary across the forwarders route portfolio.',
    `priority_booking_flag` BOOLEAN COMMENT 'Indicates whether this freight forwarder has priority booking access on this route, allowing preferential space allocation during high-demand periods. Typically granted to preferred partners or high-volume forwarders.',
    `route_specific_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to standard cargo rates for this forwarder on this specific route. Negotiated as part of route-level commercial agreements and may differ from the forwarders global discount structure.',
    CONSTRAINT pk_forwarder_route_agreement PRIMARY KEY(`forwarder_route_agreement_id`)
) COMMENT 'This association product represents the commercial contract between a freight forwarder and a specific airline route. It captures route-specific commercial terms, volume commitments, preferential rates, and performance metrics that exist only in the context of this forwarder-route partnership. Each record links one freight forwarder to one route with contractual and operational attributes that govern the commercial relationship on that specific route.. Existence Justification: In airline cargo operations, freight forwarders establish route-specific commercial agreements with airlines that include negotiated rates, volume commitments, and preferential access terms that vary by route. A single freight forwarder operates across multiple routes with different commercial terms on each, and each route has multiple freight forwarder partners with individualized agreements. The airline actively manages these forwarder-route partnerships as distinct commercial contracts with route-specific performance tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`product_route_availability` (
    `product_route_availability_id` BIGINT COMMENT 'Unique identifier for this product-route availability configuration record. Primary key.',
    `route_id` BIGINT COMMENT 'Foreign key linking to the route on which this cargo product is available',
    `service_product_id` BIGINT COMMENT 'Foreign key linking to the cargo service product being offered on this route',
    `acceptance_cutoff_hours_override` STRING COMMENT 'Number of hours before scheduled departure by which cargo must be accepted for this product on this route. Overrides the products global cutoff when route-specific operational requirements apply (e.g., customs processing, security screening, connection timing).',
    `booking_channel_restrictions` STRING COMMENT 'Comma-separated list of booking channels through which this product-route combination can be booked (e.g., direct, gsa, freight_forwarder, online). Used to control distribution and manage channel conflicts.',
    `capacity_allocation_kg` DECIMAL(18,2) COMMENT 'Allocated cargo capacity in kilograms reserved for this product on this route per flight. Used for capacity management and revenue optimization. Null indicates no specific allocation (first-come-first-served).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product-route availability configuration was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date after which this cargo product is no longer available for booking on this specific route. Null indicates indefinite availability. Supports seasonal discontinuation and route-specific product retirement.',
    `effective_start_date` DATE COMMENT 'Date from which this cargo product becomes available for booking on this specific route. Supports seasonal product offerings and route-specific launch schedules.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this product-route availability configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product-route availability configuration was last updated in the system.',
    `maximum_weight_kg` DECIMAL(18,2) COMMENT 'Maximum shipment weight in kilograms accepted for this product on this specific route. May differ from the products global maximum due to aircraft type, route distance, or operational limitations.',
    `minimum_weight_kg` DECIMAL(18,2) COMMENT 'Minimum shipment weight in kilograms required for this product on this specific route. May differ from the products global minimum due to route economics, aircraft capacity, or operational constraints.',
    `operational_notes` STRING COMMENT 'Free-text field capturing route-specific operational considerations, restrictions, or special handling requirements for this product on this route (e.g., Requires customs pre-clearance, Limited to freighter flights only, Subject to seasonal capacity constraints).',
    `priority_level` STRING COMMENT 'Loading and handling priority for this product on this specific route. May differ from products global priority based on route capacity, competitive positioning, or operational constraints.',
    `rate_class_override` STRING COMMENT 'Optional rate class code that overrides the products default rate class for this specific route. Used when route-specific pricing structures apply due to competitive dynamics, bilateral agreements, or market conditions.',
    `service_availability_status` STRING COMMENT 'Current operational status of this product on this route: active (currently bookable), suspended (temporarily unavailable), planned (future availability), discontinued (permanently removed). Controls booking system availability.',
    `transit_time_hours_override` STRING COMMENT 'Committed transit time in hours for this product on this specific route. Overrides the products global transit time commitment when route distance, connection patterns, or operational realities require different service level commitments.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this product-route availability configuration.',
    CONSTRAINT pk_product_route_availability PRIMARY KEY(`product_route_availability_id`)
) COMMENT 'This association product represents the operational availability configuration between cargo service products and routes. It captures which cargo products are offered on which routes with route-specific service parameters, operational constraints, and availability windows. Each record links one cargo service product to one route with attributes that govern product availability, service commitments, and operational parameters specific to that product-route combination.. Existence Justification: In airline cargo operations, service products (Express Freight, Cool Chain, Pharma, etc.) are selectively offered on routes based on operational capabilities, market demand, and aircraft configuration. A cargo product like Pharma may be available on 50+ routes with different temperature control capabilities, while a single route may offer 8-12 different cargo products with varying service levels. Airlines actively manage product-route availability matrices, configuring route-specific parameters like weight limits, cutoff times, priority levels, and capacity allocations that vary by route characteristics (distance, aircraft type, competitive dynamics).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_service_product_id` FOREIGN KEY (`service_product_id`) REFERENCES `airlines_ecm`.`cargo`.`service_product`(`service_product_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_cargo_allotment_id` FOREIGN KEY (`cargo_allotment_id`) REFERENCES `airlines_ecm`.`cargo`.`cargo_allotment`(`cargo_allotment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_service_product_id` FOREIGN KEY (`service_product_id`) REFERENCES `airlines_ecm`.`cargo`.`service_product`(`service_product_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `airlines_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_service_product_id` FOREIGN KEY (`service_product_id`) REFERENCES `airlines_ecm`.`cargo`.`service_product`(`service_product_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_uld_id` FOREIGN KEY (`uld_id`) REFERENCES `airlines_ecm`.`cargo`.`uld`(`uld_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `airlines_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_uld_id` FOREIGN KEY (`uld_id`) REFERENCES `airlines_ecm`.`cargo`.`uld`(`uld_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_load_plan_id` FOREIGN KEY (`load_plan_id`) REFERENCES `airlines_ecm`.`cargo`.`load_plan`(`load_plan_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ADD CONSTRAINT `fk_cargo_cargo_allotment_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_billed_freight_forwarder_id` FOREIGN KEY (`billed_freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ADD CONSTRAINT `fk_cargo_cargo_revenue_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ADD CONSTRAINT `fk_cargo_cargo_revenue_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `airlines_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ADD CONSTRAINT `fk_cargo_interline_cargo_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `airlines_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_rescreening_security_screening_id` FOREIGN KEY (`rescreening_security_screening_id`) REFERENCES `airlines_ecm`.`cargo`.`security_screening`(`security_screening_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ADD CONSTRAINT `fk_cargo_forwarder_route_agreement_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ADD CONSTRAINT `fk_cargo_product_route_availability_service_product_id` FOREIGN KEY (`service_product_id`) REFERENCES `airlines_ecm`.`cargo`.`service_product`(`service_product_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`cargo` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `airlines_ecm`.`cargo` SET TAGS ('dbx_domain' = 'cargo');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agent Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `service_product_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Product Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cargo Acceptance Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `awb_status` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Status');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `awb_type` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Type');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `awb_type` SET TAGS ('dbx_value_regex' = 'master|house|direct|neutral');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (kg)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `declared_value_for_carriage` SET TAGS ('dbx_business_glossary_term' = 'Declared Value for Carriage');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `declared_value_for_carriage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `declared_value_for_customs` SET TAGS ('dbx_business_glossary_term' = 'Declared Value for Customs');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `declared_value_for_customs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Executed Date');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `executed_location` SET TAGS ('dbx_business_glossary_term' = 'Executed Location');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (kg)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `nature_of_goods` SET TAGS ('dbx_business_glossary_term' = 'Nature of Goods');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `number_of_pieces` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charges Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `payment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `payment_indicator` SET TAGS ('dbx_value_regex' = 'prepaid|collect|mixed');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `routing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Routing Instructions');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `total_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `total_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `valuation_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Charge Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `valuation_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `cargo_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Booking Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Agent Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `cargo_allotment_id` SET TAGS ('dbx_business_glossary_term' = 'Allotment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Agent Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `service_product_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Product Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `acceptance_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Deadline Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|waitlisted|cancelled|expired|rejected');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Creation Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `declared_value_for_carriage` SET TAGS ('dbx_business_glossary_term' = 'Declared Value for Carriage');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Expiry Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `insurance_requested` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requested');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `number_of_pieces` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `quoted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Quoted Rate Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `rate_quote_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Quote Reference');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Booking Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `requested_flight_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Flight Date');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `requested_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Requested Flight Number');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `requested_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `requested_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Requested Volume in Cubic Meters');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `requested_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Requested Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range in Celsius');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ALTER COLUMN `uld_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Type Requested');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Manifest Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `service_product_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Product Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `shipper_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `uld_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `acceptance_station_code` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `acceptance_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `actual_pieces` SET TAGS ('dbx_business_glossary_term' = 'Actual Pieces Count');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `customs_clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `customs_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Cleared Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `insurance_declared_value` SET TAGS ('dbx_business_glossary_term' = 'Insurance Declared Value');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `insurance_declared_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `proof_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `routing_segments` SET TAGS ('dbx_business_glossary_term' = 'Routing Segments');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Status');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed|exempt');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes (SHC)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `uld_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) ID');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `barcode_number` SET TAGS ('dbx_business_glossary_term' = 'Barcode Number');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `compatible_aircraft_types` SET TAGS ('dbx_business_glossary_term' = 'Compatible Aircraft Types');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `damage_status` SET TAGS ('dbx_business_glossary_term' = 'Damage Status');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `damage_status` SET TAGS ('dbx_value_regex' = 'none|minor|major|critical');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `dangerous_goods_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certified Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `inspection_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval (Days)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `last_repair_date` SET TAGS ('dbx_business_glossary_term' = 'Last Repair Date');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'aluminum|composite|steel|hybrid');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `maximum_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Gross Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `maximum_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `owner_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Owner Airline Code');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `owner_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|pooled');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `rfid_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Number');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Serial Number');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{5}[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `serviceable_status` SET TAGS ('dbx_business_glossary_term' = 'Serviceable Status');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `serviceable_status` SET TAGS ('dbx_value_regex' = 'serviceable|unserviceable|under_repair|condemned|quarantined|missing');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Type Code');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `uld_category` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Category');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `uld_category` SET TAGS ('dbx_value_regex' = 'container|pallet|igloo');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `uld_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Movement ID');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Manifest Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `uld_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `aircraft_hold_position` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Hold Position Code');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `awb_count` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Count');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight in Kilograms (KG)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `damage_severity` SET TAGS ('dbx_business_glossary_term' = 'Damage Severity Level');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `damage_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'damage|missing|overweight|contamination|seal_broken|misdirected');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Event Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Event Type');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'buildup|breakdown|loading|offloading|transfer|repositioning');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `handling_agent_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Agent Code');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `handling_agent_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `handling_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Handling Agent Name');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|delayed|exception');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `piece_count` SET TAGS ('dbx_business_glossary_term' = 'Piece Count');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `repair_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Repair Required Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Resolution Status');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `seal_number_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Seal Number');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `seal_number_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Seal Number');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes (SHC)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight in Kilograms (KG)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `dangerous_goods_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Incident Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `fuel_uplift_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Balance Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Preparer Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Amended Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `awb_count` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Count');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `consignee_count` SET TAGS ('dbx_business_glossary_term' = 'Consignee Count');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `customs_clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `customs_declaration_reference` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Reference');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `customs_declaration_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `customs_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Submission Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Finalized Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `live_animals_indicator` SET TAGS ('dbx_business_glossary_term' = 'Live Animals Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `mail_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mail Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `manifest_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Status');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|amended|cancelled|submitted');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'freighter|belly|combi');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `perishables_indicator` SET TAGS ('dbx_business_glossary_term' = 'Perishables Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Status');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_value_regex' = 'complete|partial|pending|exempt');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `shipper_count` SET TAGS ('dbx_business_glossary_term' = 'Shipper Count');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `total_chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Chargeable Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `total_declared_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Declared Value (United States Dollars)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `total_declared_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `total_pieces` SET TAGS ('dbx_business_glossary_term' = 'Total Pieces');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `transit_cargo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Transit Cargo Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `uld_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Count');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `valuable_cargo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Valuable Cargo Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `dangerous_goods_id` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Staff Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Equipment Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Certificate Number');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Check Status');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Check Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `additional_handling_information` SET TAGS ('dbx_business_glossary_term' = 'Additional Handling Information');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `all_packed_in_one_flag` SET TAGS ('dbx_business_glossary_term' = 'All Packed In One Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `cargo_aircraft_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Aircraft Only (CAO) Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `dg_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Class');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `dg_class` SET TAGS ('dbx_value_regex' = '^[1-9]$');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `dg_division` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Division');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `gross_weight_per_package_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight Per Package (kg)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `net_quantity_per_package` SET TAGS ('dbx_business_glossary_term' = 'Net Quantity Per Package');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `net_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Quantity Unit of Measure');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `net_quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|L|g|mL');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `overpack_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Overpack Used Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `packing_instruction` SET TAGS ('dbx_business_glossary_term' = 'Packing Instruction Code');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `radioactive_category` SET TAGS ('dbx_business_glossary_term' = 'Radioactive Material Category');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `radioactive_category` SET TAGS ('dbx_value_regex' = 'I-WHITE|II-YELLOW|III-YELLOW');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `shipper_declaration_text` SET TAGS ('dbx_business_glossary_term' = 'Shipper Declaration Text');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `shipper_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `shipper_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Shipper Signature Date');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `special_provision_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Provision Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `state_variation_codes` SET TAGS ('dbx_business_glossary_term' = 'State Variation Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `subsidiary_risk_class` SET TAGS ('dbx_business_glossary_term' = 'Subsidiary Risk Class');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight (kg)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `total_net_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Net Quantity');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `transport_index` SET TAGS ('dbx_business_glossary_term' = 'Transport Index (TI)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate ID');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `dangerous_goods_applicable` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Applicable Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `interline_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Interline Partner Airline Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `interline_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'MILEAGE|SEGMENT|AGREED_PERCENTAGE|TACT_STANDARD');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `proration_percentage` SET TAGS ('dbx_business_glossary_term' = 'Proration Percentage');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Authority');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'M|N|Q|C|S|R');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Kilogram');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Publication Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'TACT|BILATERAL_AGREEMENT|SPOT_RATE|INTERLINE|CONTRACT|MARKET_RATE');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|PENDING|EXPIRED|SUSPENDED');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `routing_restriction` SET TAGS ('dbx_business_glossary_term' = 'Routing Restriction');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `surcharge_calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Calculation Basis');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `surcharge_calculation_basis` SET TAGS ('dbx_value_regex' = 'PERCENTAGE|FLAT_AMOUNT|PER_KG|PER_SHIPMENT');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `surcharge_value` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Value');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `uld_type_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Type Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `uld_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,5}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `weight_break_lower_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Lower Threshold (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `weight_break_upper_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Upper Threshold (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `aircraft_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration ID');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `operational_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `aircraft_configuration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Configuration');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `aircraft_configuration` SET TAGS ('dbx_value_regex' = 'passenger|freighter|combi');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `allotment_dangerous_goods_kg` SET TAGS ('dbx_business_glossary_term' = 'Allotment Dangerous Goods (DG) Cargo (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `allotment_express_kg` SET TAGS ('dbx_business_glossary_term' = 'Allotment Express Cargo (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `allotment_general_kg` SET TAGS ('dbx_business_glossary_term' = 'Allotment General Cargo (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `allotment_live_animals_kg` SET TAGS ('dbx_business_glossary_term' = 'Allotment Live Animals Cargo (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `allotment_perishable_kg` SET TAGS ('dbx_business_glossary_term' = 'Allotment Perishable Cargo (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `allotment_valuable_kg` SET TAGS ('dbx_business_glossary_term' = 'Allotment Valuable Cargo (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `available_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Available Volume (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `available_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Available Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `belly_cargo_volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Belly Cargo Volume Capacity (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `belly_cargo_weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Belly Cargo Weight Capacity (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `booked_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Booked Volume (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `booked_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Booked Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `bulk_cargo_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Cargo Allowed Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Status');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_value_regex' = 'open|limited|closed|waitlist|embargoed|cancelled');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `control_method` SET TAGS ('dbx_business_glossary_term' = 'Capacity Control Method');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `control_method` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `embargo_flag` SET TAGS ('dbx_business_glossary_term' = 'Embargo Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `embargo_reason` SET TAGS ('dbx_business_glossary_term' = 'Embargo Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capacity Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `main_deck_volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Main Deck Volume Capacity (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `main_deck_weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Main Deck Weight Capacity (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `overbooking_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Factor (Percent)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capacity Snapshot Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `total_volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Capacity (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `total_weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Capacity (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `uld_positions_available` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Positions Available');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `uld_positions_booked` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Positions Booked');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = '^CBM$');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = '^KG$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `cargo_allotment_id` SET TAGS ('dbx_business_glossary_term' = 'Allotment Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Allotment Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `operating_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Certificate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `allocated_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume in Cubic Meters');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `allocated_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Allocated Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `allotment_status` SET TAGS ('dbx_business_glossary_term' = 'Allotment Status');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `allotment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|cancelled|pending');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `allotment_type` SET TAGS ('dbx_business_glossary_term' = 'Allotment Type');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `allotment_type` SET TAGS ('dbx_value_regex' = 'weight|volume|uld|hybrid');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `days_of_week_applicable` SET TAGS ('dbx_business_glossary_term' = 'Days of Week Applicable');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `flight_series_pattern` SET TAGS ('dbx_business_glossary_term' = 'Flight Series Pattern');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `minimum_utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Utilization Threshold Percentage');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `penalty_terms` SET TAGS ('dbx_business_glossary_term' = 'Penalty Terms');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|priority|premium');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'general|specific_commodity|contract');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Allotment Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `release_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Release Time in Hours Before Departure');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `route_destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Route Destination Airport Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `route_destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|gds|cargo_portal|offline');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `uld_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Count');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `uld_type_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Type Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `uld_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,5}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|credit_hold|terminated');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Accreditation Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Accreditation Expiry Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `approved_commodity_types` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity Types');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `bsp_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'BSP (Billing and Settlement Plan) Participation Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `cass_number` SET TAGS ('dbx_business_glossary_term' = 'CASS (Cargo Accounts Settlement System) Number');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `cass_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `cass_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'CASS (Cargo Accounts Settlement System) Participation Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `dg_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'DG (Dangerous Goods) Certification Expiry Date');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `dg_certification_number` SET TAGS ('dbx_business_glossary_term' = 'DG (Dangerous Goods) Certification Number');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `dg_handling_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'DG (Dangerous Goods) Handling Certified Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `forwarder_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Type');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `forwarder_type` SET TAGS ('dbx_value_regex' = 'direct_agent|consolidator|gsa|broker|nvocc|integrated_logistics');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `iata_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Accreditation Status');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `iata_accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|suspended|revoked|not_accredited');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `iata_cargo_agent_code` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Cargo Agent Code');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `iata_cargo_agent_code` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Company Name');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cass|bsp|direct_billing|prepaid|credit_card|bank_transfer');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-()]{7,20}$');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `station_coverage` SET TAGS ('dbx_business_glossary_term' = 'Station Coverage');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL (Uniform Resource Locator)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `email_send_id` SET TAGS ('dbx_business_glossary_term' = 'Email Send Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `email_send_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `email_send_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `market_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address Line 1');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address Line 2');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `blacklist_reason` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Shipper City');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `commodity_specialization` SET TAGS ('dbx_business_glossary_term' = 'Commodity Specialization');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Shipper Primary Contact Email');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_fax` SET TAGS ('dbx_business_glossary_term' = 'Shipper Contact Fax Number');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Primary Contact Name');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Shipper Primary Contact Phone');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipper Country Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Shipper Credit Status');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|pending|suspended|declined|under_review|cash_only');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `customs_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Registration Number');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `dg_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certification Expiry Date');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `dg_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certification Number');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `dg_shipper_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Shipper Certified Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `eori_number` SET TAGS ('dbx_business_glossary_term' = 'Economic Operators Registration and Identification (EORI) Number');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `iata_cass_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Cargo Accounts Settlement Systems (CASS) Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `known_shipper_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Known Shipper Certification Date');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `known_shipper_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Known Shipper Certification Expiry Date');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `known_shipper_status` SET TAGS ('dbx_business_glossary_term' = 'Known Shipper Security Status');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `known_shipper_status` SET TAGS ('dbx_value_regex' = 'known_shipper|unknown_shipper|suspended|revoked|pending_validation|not_applicable');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `last_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Shipment Date');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Shipper Onboarding Date');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipper Postal Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Legal Name');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `shipper_status` SET TAGS ('dbx_business_glossary_term' = 'Shipper Account Status');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `shipper_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blacklisted|pending_approval');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `shipper_type` SET TAGS ('dbx_business_glossary_term' = 'Shipper Type Classification');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Shipper State or Province');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `total_shipments_count` SET TAGS ('dbx_business_glossary_term' = 'Total Shipments Count');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billed_freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Billed Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Billed Shipper Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Processor Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Identifier (ID)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `awb_count` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Count');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_party_account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Account Number');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_party_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_party_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Name');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Type');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_party_type` SET TAGS ('dbx_value_regex' = 'freight_forwarder|shipper|consignee|agent|airline|broker');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `cass_period` SET TAGS ('dbx_business_glossary_term' = 'Cargo Accounts Settlement Systems (CASS) Period');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `cass_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `cass_settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Cargo Accounts Settlement Systems (CASS) Settlement Reference');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `cass_settlement_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `customs_clearance_fee` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Fee');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `dg_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Surcharge');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `freight_charge_collect` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Collect');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `freight_charge_prepaid` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Prepaid');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `fuel_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_note|debit_note|proforma|adjustment|supplementary');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `other_charges` SET TAGS ('dbx_business_glossary_term' = 'Other Charges');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `oversize_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Oversize Surcharge');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `security_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Security Surcharge');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `storage_fee` SET TAGS ('dbx_business_glossary_term' = 'Storage Fee');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `cargo_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Revenue ID');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Manifest Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `booking_channel` SET TAGS ('dbx_value_regex' = 'DIRECT|GHA|FREIGHT_FORWARDER|ONLINE|CARGO_PORTAL');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `consignee_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consignee Account Number');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `consignee_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `freight_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Revenue Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `handling_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Handling Revenue Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `interline_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Interline Settlement Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `per_rtk` SET TAGS ('dbx_business_glossary_term' = 'Revenue per Revenue Tonne Kilometer (RTK)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'IATA_PRORATE|BILATERAL_AGREEMENT|SPECIAL_PRORATE|DIRECT');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `revenue_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Status');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `revenue_status` SET TAGS ('dbx_value_regex' = 'RECOGNIZED|DEFERRED|ADJUSTED|REVERSED|DISPUTED');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `revenue_type` SET TAGS ('dbx_value_regex' = 'BELLY_CARGO|FREIGHTER|CHARTER|TRUCKING');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `rtk_flown` SET TAGS ('dbx_business_glossary_term' = 'Revenue Tonne Kilometers (RTK) Flown');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'GENERAL_CARGO|EXPRESS|PRIORITY|DEFERRED|DANGEROUS_GOODS|PERISHABLE');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `shipment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `shipper_account_number` SET TAGS ('dbx_business_glossary_term' = 'Shipper Account Number');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `shipper_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `surcharge_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Revenue Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ALTER COLUMN `yield_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Yield per Kilogram');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Claims Handler Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'loss|damage|delay|pilferage|shortage|contamination');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_address` SET TAGS ('dbx_business_glossary_term' = 'Claimant Mailing Address');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Claimant Contact Email');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Claimant Contact Phone');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_value_regex' = 'shipper|consignee|freight_forwarder|insurance_company|authorized_agent');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Discovery Date');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Date');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Reference');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `insurance_recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Recovery Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|awaiting_information|completed|suspended');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `liability_determination` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `liability_determination` SET TAGS ('dbx_value_regex' = 'carrier_liable|carrier_not_liable|partial_liability|third_party_liable|pending');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `liability_limit_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Applicable Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Claim Outcome');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|partially_approved|rejected|withdrawn|settled|closed_no_liability');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^CLM[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|credit_note|offset|insurance_recovery');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `shipment_pieces` SET TAGS ('dbx_business_glossary_term' = 'Shipment Piece Count');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `shipment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `supporting_documents_list` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents List');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `fuel_uplift_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Loadmaster Employee ID');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `actual_takeoff_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Takeoff Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `actual_zero_fuel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Zero Fuel Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `aft_hold_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Aft Hold Cargo Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `arrival_station` SET TAGS ('dbx_business_glossary_term' = 'Arrival Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `arrival_station` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `bulk_hold_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Bulk Hold Cargo Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `cargo_center_of_gravity_mac_percent` SET TAGS ('dbx_business_glossary_term' = 'Cargo Center of Gravity (Mean Aerodynamic Chord Percent)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `cargo_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `dangerous_goods_onboard_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Onboard Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `departure_station` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `departure_station` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `dispatch_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `forward_hold_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Forward Hold Cargo Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Cargo Load Factor (Percent)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `load_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Status');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `load_plan_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|revised|cancelled|closed');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `load_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Load Sheet Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `load_sheet_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `loadmaster_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loadmaster Sign-Off Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `maximum_landing_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Landing Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `maximum_takeoff_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Takeoff Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `maximum_zero_fuel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Zero Fuel Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `planned_landing_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Planned Landing Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `special_load_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Load Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `total_cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Cargo Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `trim_adjustment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Trim Adjustment Required Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `uld_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Count');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Updated Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `embargo_id` SET TAGS ('dbx_business_glossary_term' = 'Embargo Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `affected_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Flight Number');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `affected_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `affected_route_pattern` SET TAGS ('dbx_business_glossary_term' = 'Affected Route Pattern');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Embargo Cancellation Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Embargo Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Class');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code (IATA)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `effective_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `effective_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `embargo_status` SET TAGS ('dbx_business_glossary_term' = 'Embargo Status');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `embargo_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|cancelled');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `embargo_type` SET TAGS ('dbx_business_glossary_term' = 'Embargo Type');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `embargo_type` SET TAGS ('dbx_value_regex' = 'station_closure|commodity_restriction|weight_restriction|dangerous_goods_restriction|seasonal_embargo|capacity_embargo');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `override_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Authority');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Embargo Reason Code');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'capacity_constraint|safety_incident|regulatory_requirement|weather_event|infrastructure_failure|security_threat');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Embargo Reason Description');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Embargo Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^EMB[0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Embargo Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `volume_restriction_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Restriction (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `weight_restriction_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Restriction (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `service_product_id` SET TAGS ('dbx_business_glossary_term' = 'Service Product Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `acceptance_cutoff_hours` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Cutoff (Hours)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `applicable_surcharges` SET TAGS ('dbx_business_glossary_term' = 'Applicable Surcharges');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `booking_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Booking Lead Time (Hours)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `dangerous_goods_accepted` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Accepted');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `destination_region_restriction` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Restriction');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `dimensional_weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight Factor');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `discontinued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discontinued Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `eligible_commodity_codes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Commodity Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `eligible_uld_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Unit Load Device (ULD) Types');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `freighter_only_indicator` SET TAGS ('dbx_business_glossary_term' = 'Freighter Only Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `insurance_available` SET TAGS ('dbx_business_glossary_term' = 'Insurance Available');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `live_animal_accepted` SET TAGS ('dbx_business_glossary_term' = 'Live Animal Accepted');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `maximum_piece_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Piece Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `maximum_shipment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Shipment Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `minimum_chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Chargeable Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `origin_region_restriction` SET TAGS ('dbx_business_glossary_term' = 'Origin Region Restriction');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `priority_loading_indicator` SET TAGS ('dbx_business_glossary_term' = 'Priority Loading Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_owner` SET TAGS ('dbx_business_glossary_term' = 'Product Owner');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Product Status');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|pending_approval');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'standard|express|specialized|temperature_controlled|live_animal|dangerous_goods');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `restricted_commodity_codes` SET TAGS ('dbx_business_glossary_term' = 'Restricted Commodity Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `sales_channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Availability');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'economy|standard|priority|express|premium|guaranteed');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Celsius)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Celsius)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `tracking_capability_level` SET TAGS ('dbx_business_glossary_term' = 'Tracking Capability Level');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `tracking_capability_level` SET TAGS ('dbx_value_regex' = 'basic|standard|enhanced|real_time');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Hours)');
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ALTER COLUMN `uld_compatible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Compatible Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry ID');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) ID');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Officer Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `certificate_of_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `charges_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Charges Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `charges_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `country_of_export` SET TAGS ('dbx_business_glossary_term' = 'Country of Export');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `country_of_export` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `customs_broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `customs_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Status');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Type');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'import|export|transit|transshipment|re-export|temporary_admission');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `examination_result` SET TAGS ('dbx_business_glossary_term' = 'Customs Examination Result');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `examination_result` SET TAGS ('dbx_value_regex' = 'passed|discrepancy_found|violation_detected|pending|not_applicable');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `examination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Examination Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `examination_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Examination Type');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `examination_type` SET TAGS ('dbx_value_regex' = 'none|documentary|physical|x-ray|canine|full_inspection');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `exporter_name` SET TAGS ('dbx_business_glossary_term' = 'Exporter Name');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `exporter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `exporter_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Exporter Tax Identification Number');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `exporter_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `exporter_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Filing Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `importer_of_record` SET TAGS ('dbx_business_glossary_term' = 'Importer of Record');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `importer_of_record` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `importer_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Importer Tax Identification Number');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `importer_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `importer_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Duty Payment Method');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `preferential_trade_agreement` SET TAGS ('dbx_business_glossary_term' = 'Preferential Trade Agreement');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Code');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Release Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `special_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Program Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `total_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `interline_cargo_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Cargo ID');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) ID');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `interline_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Billing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `operating_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Certificate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|SUSPENDED|TERMINATED|PENDING_APPROVAL|EXPIRED|UNDER_REVIEW');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `cass_settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Cargo Accounts Settlement Systems (CASS) Settlement Reference');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `handling_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `handling_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `interline_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `interline_awb_prefix` SET TAGS ('dbx_business_glossary_term' = 'Interline Air Waybill (AWB) Prefix');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `interline_awb_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `partner_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Airline IATA Code');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `partner_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'IATA_PRORATE_FACTOR|BILATERAL_RATE|MILEAGE_PRORATION|SPECIAL_PRORATE_AGREEMENT|FIXED_AMOUNT');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Interline Cargo Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `route_segment_sequence` SET TAGS ('dbx_business_glossary_term' = 'Route Segment Sequence Number');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Segment Chargeable Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Destination Station IATA Code');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_flight_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Flight Departure Date');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Flight Number');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_pieces` SET TAGS ('dbx_business_glossary_term' = 'Segment Number of Pieces');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_revenue_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Segment Revenue Share Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_revenue_share_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Revenue Share Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_revenue_share_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Segment Volume in Cubic Meters');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `segment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Segment Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `settlement_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Completed Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'PENDING|SUBMITTED|SETTLED|DISPUTED|ADJUSTED|CANCELLED');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `settlement_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Submitted Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `transfer_manifest_reference` SET TAGS ('dbx_business_glossary_term' = 'Transfer Manifest Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ALTER COLUMN `uld_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Number');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `cargo_surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Surcharge ID');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'per_kg|per_shipment|per_awb|percentage_of_freight|flat_rate|per_piece');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `destination_region_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `origin_region_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Region Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `pass_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass-Through Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `published_flag` SET TAGS ('dbx_business_glossary_term' = 'Published Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'domestic|international|regional|intercontinental');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|express|priority|economy|next_flight_out');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code (SHC)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `surcharge_category` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Category');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `surcharge_category` SET TAGS ('dbx_value_regex' = 'fuel|security|handling|regulatory|geographic|seasonal');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `surcharge_name` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Name');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Status');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `uld_type_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Type Code');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `uld_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,5}$');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `weight_break_maximum_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum Kilograms (kg)');
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ALTER COLUMN `weight_break_minimum_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum Kilograms (kg)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `security_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Security Screening ID');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `operational_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Screener Employee ID');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Location Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `rescreening_security_screening_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `acceptance_station_code` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Station Code');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `acceptance_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `alarm_reason` SET TAGS ('dbx_business_glossary_term' = 'Alarm Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `alarm_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `chain_of_custody_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Verified Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `equipment_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Calibration Date');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `known_consignor_flag` SET TAGS ('dbx_business_glossary_term' = 'Known Consignor (KC) Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `known_consignor_reference` SET TAGS ('dbx_business_glossary_term' = 'Known Consignor (KC) Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `piece_dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Piece Dimensions (Centimeters)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `piece_number` SET TAGS ('dbx_business_glossary_term' = 'Piece Number');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `piece_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Piece Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `regulated_agent_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulated Agent (RA3) Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `regulated_agent_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulated Agent (RA3) Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Code');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_value_regex' = 'TSA|EASA|CAAC|CASA|DGCA|TCCA');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `regulatory_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Screening Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'cleared|rejected|re-screened|escalated|physical_inspection_performed');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screener_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Screener Certification Expiry Date');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screener_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Screener Certification Number');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screener_name` SET TAGS ('dbx_business_glossary_term' = 'Screener Name');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screener_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Screening Equipment ID');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Screening Exemption Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_value_regex' = 'passed|failed|inconclusive|exempted');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'clear|alarm|re-screen_required|exempted|pending|failed');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `security_status_code` SET TAGS ('dbx_business_glossary_term' = 'Security Status Code');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `security_status_code` SET TAGS ('dbx_value_regex' = 'SPX|SCO|SHR|NSC|EXM');
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes (SHC)');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` SET TAGS ('dbx_association_edges' = 'cargo.freight_forwarder,route.route');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `forwarder_route_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Forwarder Route Agreement ID');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Forwarder Route Agreement - Freight Forwarder Id');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Forwarder Route Agreement - Route Id');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `actual_volume_shipped_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Shipped');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `last_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Shipment Date');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `minimum_volume_commitment_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `payment_terms_override` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Override');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `preferred_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Preferred Partner Status');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `priority_booking_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Booking Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ALTER COLUMN `route_specific_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Discount Percentage');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` SET TAGS ('dbx_association_edges' = 'cargo.service_product,route.route');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `product_route_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Product Route Availability Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Product Route Availability - Route Id');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `service_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Route Availability - Cargo Product Id');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `acceptance_cutoff_hours_override` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Acceptance Cutoff Override');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `booking_channel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Restrictions');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `capacity_allocation_kg` SET TAGS ('dbx_business_glossary_term' = 'Product Capacity Allocation');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Effective End Date');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Effective Start Date');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `maximum_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Maximum Weight');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `minimum_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Minimum Weight');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `operational_notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Priority Level');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `rate_class_override` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Rate Class Override');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `service_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Service Availability Status');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `transit_time_hours_override` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Transit Time Override');
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
