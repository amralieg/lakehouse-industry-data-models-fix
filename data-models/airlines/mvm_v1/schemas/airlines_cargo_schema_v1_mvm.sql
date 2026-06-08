-- Schema for Domain: cargo | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`cargo` COMMENT 'Air freight and cargo commercial and operational data including AWB (Air Waybill) lifecycle, ULD (Unit Load Device) management, cargo bookings, shipment tracking, cargo capacity allocation, weight and balance, dangerous goods (DG) declarations, freight rates, cargo revenue accounting, and shipper/consignee relationships. Manages both belly cargo and dedicated freighter operations. Aligns with Mercator Cargo Management System.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`awb` (
    `awb_id` BIGINT COMMENT 'Unique system identifier for the air waybill record. Primary key for the AWB entity.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to revenue.corporate_account. Business justification: The AWB is the primary cargo commercial document. Corporate shippers (e.g., automotive OEMs, pharma companies) with airline corporate accounts require AWBs linked to their account for volume commitmen',
    `station_id` BIGINT COMMENT 'FK to airport.station',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: AWB stores agent_name and agent_iata_code as strings. Freight_forwarder is the authoritative master with iata_cargo_agent_code. Adding freight_forwarder_id FK normalizes agent reference and allows JOI',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_rate. Business justification: An Air Waybill is issued at a specific freight rate. The AWB captures freight_charge_amount (the computed charge) but has no FK to the freight_rate master record that defines the rate structure. Addin',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AWB is the primary air cargo financial instrument — freight charges, surcharges, and valuation charges must post to a GL account for revenue recognition and CASS settlement reporting. Aviation finance',
    `origin_station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: AWBs specify origin_airport_code for acceptance. Station link provides hub classification, customs facility availability, DG certification, acceptance cutoff times, and ground handler assignment for o',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: AWBs are booked and transported on specific routes. Cargo yield management, route profitability analysis, and capacity planning require linking shipments to routes. Essential for cargo revenue managem',
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
    `executed_date` DATE COMMENT 'Date when the AWB contract was executed and signed by the shipper or authorized agent.',
    `executed_location` STRING COMMENT 'City and country where the AWB was executed and signed, establishing the jurisdiction for the contract.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight charges for the air transportation service, calculated based on chargeable weight and applicable rate.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment including packaging, expressed in kilograms. This is the actual physical weight of all pieces combined.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the AWB record was most recently updated, tracking the latest change to any field.',
    `nature_of_goods` STRING COMMENT 'High-level classification of the cargo type indicating special handling, regulatory, or operational requirements. [ENUM-REF-CANDIDATE: general|perishable|valuable|live_animals|dangerous_goods|human_remains|diplomatic|mail — 8 candidates stripped; promote to reference product]',
    `number_of_pieces` STRING COMMENT 'Total count of individual packages, cartons, or pieces comprising the shipment as declared on the AWB.',
    `payment_indicator` STRING COMMENT 'Indicates whether freight charges are prepaid (paid by shipper at origin), collect (paid by consignee at destination), or mixed (split payment).. Valid values are `prepaid|collect|mixed`',
    `routing_instructions` STRING COMMENT 'Specific routing path and transit points for the shipment, including intermediate airports and connecting flights.',
    `shipment_reference_number` STRING COMMENT 'Customer or agent-provided reference number for tracking and internal identification purposes.',
    `special_handling_codes` STRING COMMENT 'Three-letter IATA Special Handling Codes (SHC) indicating special requirements such as PER (perishable), AVI (live animals), DGR (dangerous goods), VAL (valuable cargo). Multiple codes separated by commas.',
    `total_charges_amount` DECIMAL(18,2) COMMENT 'Grand total of all charges on the AWB including freight, valuation, and other charges.',
    `valuation_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge for declared value coverage exceeding the standard carrier liability limit.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the shipment in cubic meters, calculated from the dimensions of all pieces.',
    CONSTRAINT pk_awb PRIMARY KEY(`awb_id`)
) COMMENT 'Air Waybill (AWB) master record — the primary contractual and operational document governing a cargo shipment. Captures AWB number (IATA 8-digit format), origin and destination airports, shipper and consignee details, commodity description, declared value, number of pieces, gross weight, chargeable weight, volume, nature of goods, special handling codes, freight charges, prepaid/collect indicator, routing instructions, and AWB status lifecycle (booked, accepted, manifested, departed, arrived, delivered). SSOT for all AWB-level cargo data. Aligns with Mercator Cargo Management System AWB module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`booking` (
    `booking_id` BIGINT COMMENT 'Unique identifier for the cargo booking record. Primary key.',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Booking is created before AWB issuance. Once AWB is generated, booking should reference it. This FK will be NULL initially and populated during AWB creation process. Tracks the booking-to-AWB lifecycl',
    `capacity_id` BIGINT COMMENT 'Foreign key linking to cargo.capacity. Business justification: A cargo booking reserves space against a specific capacity record for a flight segment. cargo_booking has requested_flight_date and requested_flight_number as free-text fields but no FK to the capacit',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cargo bookings are attributed to cost centres for route-level and station-level P&L reporting. Aviation cargo controllers require cost centre attribution on bookings to produce RASK/CASK analysis by b',
    `station_id` BIGINT COMMENT 'FK to airport.station',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Cargo bookings are made against specific scheduled flight numbers for capacity allocation. The existing requested_flight_number is a plain-text denormalization of route.flight_number. A cargo booking ',
    `freight_forwarder_id` BIGINT COMMENT 'Reference to the freight forwarder or agent who created the booking on behalf of the shipper.',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_rate. Business justification: A cargo booking is priced using a specific freight rate. cargo_booking has rate_quote_reference and quoted_rate_amount as denormalized fields but no FK to the freight_rate master record. Adding freigh',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Cargo bookings generate revenue accruals at booking time for yield management and financial forecasting. GL posting of booked revenue is standard in airline cargo accounting; finance teams require boo',
    `origin_station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Bookings specify origin_station_code for acceptance planning. Station link provides capacity constraints, embargo status, acceptance cutoff times, and ground handler capability for booking validation ',
    `shipper_id` BIGINT COMMENT 'Reference to the party shipping the cargo. The consignor or sender of the goods.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Cargo bookings are made for specific routes. Booking acceptance workflow checks route-level capacity, embargoes, and allotments. Critical for cargo capacity control and allotment utilization tracking ',
    `scheduled_flight_id` BIGINT COMMENT 'Foreign key linking to flight.scheduled_flight. Business justification: Cargo bookings are made against a specific scheduled flight for capacity allocation and revenue management. Cargo revenue systems require the scheduled_flight FK to enforce capacity limits and generat',
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
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the booking reservation expires if not confirmed or if cargo is not accepted.',
    `insurance_requested` BOOLEAN COMMENT 'Flag indicating whether the shipper has requested cargo insurance coverage for this booking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this booking record was last updated or modified. Audit trail field.',
    `number_of_pieces` STRING COMMENT 'Total count of individual pieces or packages in the cargo booking.',
    `quoted_rate_amount` DECIMAL(18,2) COMMENT 'Freight rate amount quoted to the shipper for this booking. May be per kilogram or total shipment rate.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted freight rate.. Valid values are `^[A-Z]{3}$`',
    `rate_quote_reference` STRING COMMENT 'Reference number linking this booking to a previously issued freight rate quotation. Used for rate validation and pricing.',
    `reference_number` STRING COMMENT 'Externally-known unique booking reference number assigned to the cargo space reservation. Used for customer communication and tracking.. Valid values are `^[A-Z0-9]{6,12}$`',
    `remarks` STRING COMMENT 'Free-text remarks or special instructions related to the cargo booking. May include handling notes, contact information, or other operational details.',
    `requested_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo shipment requested for booking, measured in cubic meters.',
    `requested_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo shipment requested for booking, measured in kilograms.',
    `special_handling_codes` STRING COMMENT 'Comma-separated list of IATA Special Handling Codes (SHC) indicating special requirements such as DG (Dangerous Goods), PER (Perishable), AVI (Live Animals), VAL (Valuables), HEA (Heavy cargo).',
    `temperature_control_required` BOOLEAN COMMENT 'Flag indicating whether the cargo requires temperature-controlled handling (e.g., for perishables or pharmaceuticals).',
    `temperature_range_celsius` STRING COMMENT 'Required temperature range for temperature-controlled cargo, expressed as min-max range in Celsius (e.g., 2-8).',
    `uld_type_requested` STRING COMMENT 'Type of ULD (Unit Load Device) requested for the cargo, such as container or pallet type (e.g., AKE, PMC). Applicable for containerized cargo.',
    CONSTRAINT pk_booking PRIMARY KEY(`booking_id`)
) COMMENT 'Cargo space reservation record created prior to AWB issuance. Captures booking reference number, booking channel (GDS, direct, agent), requested flight(s), commodity type, requested weight and volume, special handling requirements (DG, perishable, live animals, valuables), booking status (tentative, confirmed, waitlisted, cancelled), rate quote reference, booking agent/forwarder, acceptance deadline, and allotment reference. Represents the commercial commitment before physical acceptance. Aligns with Mercator Cargo booking module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the physical shipment record. Primary key for tracking cargo movement from acceptance to delivery.',
    `awb_id` BIGINT COMMENT 'Reference to the Air Waybill document governing this shipment. Links shipment to commercial contract and routing instructions.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to cargo.cargo_booking. Business justification: A shipment is the physical execution of a cargo booking. While shipment already links to awb (which links to cargo_booking), the direct shipment → cargo_booking FK provides a first-class traceability ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Shipment handling costs (ground handling, storage, special handling surcharges) are attributed to cost centres for station-level operational cost reporting. Required for cargo P&L by hub and spoke sta',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Shipments track current_location_code for real-time tracking. Station link provides ground handler, customs capability, operational hours, and contact details essential for exception handling and deli',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Cargo tracking systems directly associate shipments with the operating flight leg for real-time shipment status, on-time performance reporting, and exception management. Aviation domain experts expect',
    `freight_forwarder_id` BIGINT COMMENT 'FK to cargo.freight_forwarder',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: Shipments are physically accepted, loaded, and delivered by ground handlers. Claims investigation, SLA tracking, and handler performance management require knowing which ground handler handled each sh',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: A specific shipment (leaking DG, live animals causing crew distraction) can be proactively identified as a hazard source in the SMS before any occurrence is recorded. Direct shipment→hazard linkage su',
    `manifest_id` BIGINT COMMENT 'Reference to the flight manifest on which this shipment is loaded. Links shipment to specific flight leg for operational tracking.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Cargo incidents (damage, theft, security breaches, handling accidents) generate safety occurrences. Shipment tracking requires linkage to safety events for investigation, regulatory reporting (ICAO, C',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Shipments move along specific routes. Operational performance monitoring, transit time compliance, and route-level service quality metrics require route linkage. Essential for cargo operational KPI re',
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
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: ULDs are frequently leased from other airlines or leasing companies under IFRS 16 lease contracts. Aviation finance requires ULD-to-lease-contract linkage for right-of-use asset recognition, lease lia',
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
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: ULD movement events (load/offload/transfer) are recorded per flight leg for ULD control, damage liability tracking, and ground handling performance reporting. Every aviation cargo system ties ULD move',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: ULD load/offload events occur at specific gate stands. Ramp coordination, weight-and-balance reporting, and turnaround SLA tracking require linking each ULD movement to the gate assignment where it oc',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: Each ULD movement is performed by a specific ground handler. handling_agent_code and handling_agent_name are denormalized representations of ground_handler. Proper FK enables handler performance repor',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: ULD damage, seal tampering, or handling discrepancies during movement can trigger safety occurrences. Ground handling safety events require traceability to specific ULD movements for investigation and',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: ULD movements track origin_station_code for asset tracking. Station link provides ground handler, operational status, maintenance capability, and cost center for ULD lifecycle management and repositio',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to airport.turnaround. Business justification: ULD movements are sub-events of aircraft turnarounds. Linking enables delay attribution (late ULD loading caused turnaround delay), ground handler SLA compliance reporting, and ramp operations perform',
    `uld_id` BIGINT COMMENT 'Foreign key linking to cargo.uld. Business justification: ULD_movement tracks uld_serial_number and uld_type_code as strings. ULD is the authoritative master for all ULD asset data. Adding uld_id FK normalizes this reference and allows JOIN to retrieve curre',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: When ULD damage is discovered during a movement event (loading, offloading, transfer), a maintenance work order is immediately raised for repair. Cargo operations staff need to reference the resulting',
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
    `capacity_id` BIGINT COMMENT 'Foreign key linking to cargo.capacity. Business justification: A flight cargo manifest is the operational document for a specific flight, and capacity is the planning record for that same flights cargo capacity. Linking manifest to capacity enables direct compar',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Manifest-level cargo operations are attributed to cost centres for flight-level P&L and load factor reporting. Required for cargo contribution margin analysis by route and aircraft type in airline man',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Integrated load planning and weight-and-balance calculations require coordinating cargo manifests with passenger cabin loads. Load planners need to see both cargo weight (from manifest) and passenger ',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight on which this cargo manifest applies.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Cargo manifests are filed per flight number for customs and regulatory submission. The plain-text flight_number on manifest is a denormalization of route.flight_number. Regulatory cargo manifest filin',
    `load_plan_id` BIGINT COMMENT 'Foreign key linking to cargo.load_plan. Business justification: Manifest has load_plan_reference (STRING) linking to the weight and balance calculation. Load_plan table PK is weight_balance_record_id. Adding this FK normalizes the reference and allows JOIN to retr',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Manifests are created for flights operating specific routes. Customs pre-clearance, regulatory compliance reporting, and cargo operations planning require route context beyond flight_leg. Supports rou',
    `scheduled_flight_id` BIGINT COMMENT 'Foreign key linking to flight.scheduled_flight. Business justification: Cargo manifests are prepared for a specific scheduled service. Operations and revenue teams link manifests to scheduled_flight for route/timing data during manifest preparation and pre-flight cargo pl',
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
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: IATA DGR and ICAO Annex 18 require misdeclared or improperly packaged DG shipments to be entered into the SMS hazard register. A specific DG record must reference the hazard it generated, enabling pro',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Dangerous goods incidents (leaks, misdeclarations, packaging failures) are safety occurrences that must be tracked in the SMS. This FK links DG incidents to the safety occurrence register for regulato',
    `shipper_id` BIGINT COMMENT 'Foreign key linking to cargo.shipper. Business justification: A dangerous goods declaration is made by the shipper tendering the DG cargo. dangerous_goods has shipper_name as a free-text field but no FK to the shipper master. Adding shipper_id normalizes the DG ',
    `acceptance_certificate_number` STRING COMMENT 'Reference number of the dangerous goods acceptance certificate or checklist issued upon successful acceptance inspection.',
    `acceptance_check_status` STRING COMMENT 'Result of the airlines dangerous goods acceptance inspection: passed (accepted for carriage), failed (rejected), pending (under review), waived (exempted).. Valid values are `passed|failed|pending|waived`',
    `acceptance_check_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods acceptance check was completed by airline cargo acceptance staff.',
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
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Freight rates are managed by cost centre for route profitability and yield management reporting. Aviation cargo revenue management requires rate-to-cost-centre attribution for RASK analysis and rate a',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: Freight rates in cargo operations are often negotiated as contract rates specific to a freight forwarder (IATA cargo agent). freight_rate has interline_partner_code and rate_source as free-text fields',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Freight rates specify origin_airport_code for pricing. Station link enables cost center allocation, revenue attribution, market segmentation, and competitive analysis for pricing strategy and yield ma',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Freight rates are published and applied by route (origin-destination pairs). Pricing systems, quotation engines, and revenue management require route linkage for rate lookup and application. Core to c',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Cargo tariffs are published per IATA schedule season (Summer/Winter). Airlines set and file cargo rates aligned to schedule seasons for regulatory and commercial purposes. A cargo revenue manager woul',
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
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Belly cargo capacity allocation (belly_cargo_volume_capacity_cbm, belly_cargo_weight_capacity_kg) is directly determined by the installed cabin configuration. Cargo revenue management references cabin',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cargo capacity is managed by cost centre for route-level revenue budgeting and CASK attribution. Required for cargo capacity utilization reporting against budget by business unit in airline management',
    `station_id` BIGINT COMMENT 'FK to airport.station',
    `embargo_id` BIGINT COMMENT 'Foreign key linking to cargo.embargo. Business justification: The capacity record has embargo_flag (BOOLEAN) and embargo_reason (STRING) indicating when a flights cargo capacity is under embargo. The embargo table is the authoritative record for cargo restricti',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Unified capacity management dashboards require linking cargo and passenger capacity for the same flight. Airlines with mixed-configuration aircraft (passenger + cargo) need integrated load factor repo',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight segment for which this capacity allocation applies.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Cargo capacity is allocated and controlled at flight number level (not just route). Tactical capacity management, allotment assignment, and booking acceptance decisions operate on specific flight numb',
    `origin_station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Capacity records track origin_station_code for departure planning. Station link provides ground handler, operational status, slot coordination, and embargo status for capacity allocation and overbooki',
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
    `embargo_flag` BOOLEAN COMMENT 'Indicates whether a cargo embargo is in effect for this flight segment, preventing new bookings (True) or allowing normal operations (False).',
    `flight_date` DATE COMMENT 'The scheduled departure date of the flight segment in local time at origin (yyyy-MM-dd).',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`freight_forwarder` (
    `freight_forwarder_id` BIGINT COMMENT 'Unique identifier for the freight forwarder or cargo agent record. Primary key.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Freight forwarders are major billed customers; their receivables must be tracked in AR for credit management, collections, and DSO reporting. Core customer-to-AR relationship.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Freight forwarder revenue and commission costs are attributed to cost centres for distribution channel P&L reporting. Required for cargo sales channel profitability analysis and forwarder incentive pr',
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
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Shippers are direct customers who generate receivables when billed for cargo services. Essential for customer credit management, collections, and revenue assurance in direct billing scenarios.',
    `freight_forwarder_id` BIGINT COMMENT 'Reference to the freight forwarder entity if this shipper operates through a freight forwarder. Null if shipper deals directly with the airline.',
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
    `shipper_id` BIGINT COMMENT 'Foreign key linking to cargo.shipper. Business justification: Invoice has billing_party_id (BIGINT) and billing_party_type (STRING). When billing_party_type=SHIPPER, this should FK to shipper. Adding billed_shipper_id as a labeled FK (nullable, populated when ',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to revenue.corporate_account. Business justification: Airlines with integrated corporate sales programs issue cargo invoices against corporate accounts for consolidated billing, volume commitment tracking, and corporate revenue reporting. A domain expert',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cargo invoices must be attributed to cost centres for revenue reporting by business unit, station, and channel. Required for CASS billing reconciliation and cargo revenue P&L by cost centre in airline',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: Invoice has billing_party_id (BIGINT) and billing_party_type (STRING). When billing_party_type=FORWARDER, this should FK to freight_forwarder. Adding billed_freight_forwarder_id as a labeled FK (nul',
    `invoice_freight_forwarder_id` BIGINT COMMENT 'Reference to the party (freight forwarder, shipper, or consignee) being invoiced for cargo transportation charges.',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`claim` (
    `claim_id` BIGINT COMMENT 'Primary key for claim',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Cargo claims resulting in settlements generate AP entries for payment to claimants. Aviation cargo claims management requires direct linkage to AP for settlement payment processing, three-way match, a',
    `awb_id` BIGINT COMMENT 'Foreign key linking to cargo.awb. Business justification: Claim has awb_number (STRING) to identify which AWB the claim is filed against. AWB is the authoritative master document. Adding awb_id FK normalizes this reference and allows JOIN to retrieve full AW',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cargo claims are attributed to cost centres for loss and liability reporting by station and route. Required for cargo claims expense tracking against budget and insurance recovery reporting in airline',
    `station_id` BIGINT COMMENT 'FK to airport.station',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Cargo damage/loss claims are investigated against the specific flight leg where the incident occurred. Claims processing, liability determination, and regulatory reporting (Montreal Convention) requir',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Cargo claims are filed against specific flights for liability determination and insurance recovery. The plain-text flight_number on claim is a denormalization of route.flight_number. Claims analysis b',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: A cargo claim is typically filed by a freight forwarder acting on behalf of the shipper or consignee. claim has claimant_name and claimant_type as free-text fields but no FK to the freight_forwarder m',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: Cargo damage and loss claims are frequently caused by ground handling errors. Claims investigation and subrogation recovery require identifying the responsible ground handler. Aviation cargo claims ma',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Cargo claims arising from safety occurrences (turbulence damage, runway excursion, cargo hold fire) require direct linkage for liability determination, insurance recovery, and regulatory reporting. Cl',
    `origin_station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Claims track origin_station_code for liability determination. Station link identifies responsible ground handler, operational context, handling performance data, and insurance coverage for claim inves',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to cargo.shipment. Business justification: A cargo claim for loss, damage, or delay is directly associated with a specific physical shipment. claim already has awb_id → awb, but the direct link to shipment provides access to the physical movem',
    `shipper_id` BIGINT COMMENT 'Foreign key linking to cargo.shipper. Business justification: A cargo claim may be filed directly by a shipper (when the shipper is the claimant rather than a freight forwarder). claim has claimant_name and claimant_type but no FK to the shipper master. Adding s',
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
    `discovery_date` DATE COMMENT 'Date when the loss, damage, or delay was first discovered by the claimant or carrier.',
    `filing_date` DATE COMMENT 'Date when the claim was formally filed by the claimant. Principal business event timestamp for the claim transaction.',
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
    `capacity_id` BIGINT COMMENT 'Foreign key linking to cargo.capacity. Business justification: A weight and balance load plan is calculated for a specific flight, and the capacity record defines the available cargo capacity for that same flight. Linking load_plan to capacity enables direct comp',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Load planning operational costs (loadmaster labor, ground equipment) are attributed to cost centres for station-level cost reporting. Required for cargo ground operations P&L by hub station in airline',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight for which this weight and balance calculation was performed.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Load plans are produced per scheduled flight number for weight-and-balance and load control. The plain-text flight_number on load_plan is a denormalization of route.flight_number. Load control operati',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: Load plans are executed at specific gates where aircraft park. Gate assignment determines loading equipment availability, ground handler assignment, turnaround coordination, and ramp access for load e',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.member. Business justification: Regulatory requirement (IATA, FAA/EASA): the crew member (loadmaster) who signs off the load sheet must be traceable by name and employee record. load_plan.loadmaster_signoff_timestamp already exists,',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to crew.qualification. Business justification: Regulatory audit trail: aviation authorities require proof that the crew member who signed the load sheet held a valid weight-and-balance qualification at time of signing. Linking load_plan to the spe',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to airport.turnaround. Business justification: Load plans are executed during aircraft turnarounds; loadmaster sign-off (loadmaster_signoff_timestamp) and dispatch release are turnaround milestones. Linking enables turnaround completion tracking, ',
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
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Embargoes have direct financial impact — blocked revenue and capacity costs must be tracked by cost centre for route revenue management reporting. Aviation cargo finance requires embargo-to-cost-centr',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Cargo embargo management blocks specific flights from accepting cargo bookings. Linking embargo to flight_inventory enables cargo booking systems to check active embargoes against a specific flights ',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Embargoes are frequently issued against specific flight numbers (e.g., blocking a commodity on a particular service). The plain-text affected_flight_number is a denormalization of route.flight_number.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Embargoes can trigger revenue adjustments or refund liabilities that must be recorded in GL for accurate financial reporting and customer refund processing.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety-triggered embargoes (e.g., DG incident at a station prompting commodity embargo) must reference the originating safety occurrence for regulatory audit trails and embargo justification documenta',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Embargoes apply to origin_station_code for acceptance restrictions. Station link enables operational notification, ground handler coordination, booking system updates, and customer communication for e',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Embargoes are imposed on specific routes (origin-destination pairs). Booking acceptance systems, capacity control, and operational compliance require route-level embargo enforcement. Essential for emb',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Cargo embargoes are routinely issued for specific IATA schedule seasons (e.g., peak-season commodity embargoes). Linking embargo to schedule_season enables season-level embargo reporting and planning,',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`customs_entry` (
    `customs_entry_id` BIGINT COMMENT 'Unique identifier for the customs declaration record. Primary key for the customs entry entity.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Customs duties and taxes paid on cargo generate AP entries for payment to customs authorities. Aviation cargo finance requires customs_entry→AP linkage for duty payment processing, tax reconciliation,',
    `awb_id` BIGINT COMMENT 'Reference to the air waybill associated with this customs entry. Links the customs declaration to the shipment document.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Customs processing costs (broker fees, examination fees, storage during hold) are attributed to cost centres for station-level import/export cost reporting. Required for cargo customs compliance cost ',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Customs advance cargo information (CBP, EU ICS2) is filed per arriving flight leg. Regulatory compliance requires linking customs entries to the specific operating flight leg for pre-arrival declarati',
    `freight_forwarder_id` BIGINT COMMENT 'Foreign key linking to cargo.freight_forwarder. Business justification: A customs entry is typically filed by a customs broker who is often the freight forwarder or their licensed agent. customs_entry has customs_broker_license_number as a free-text field but no FK to the',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Customs duties and taxes paid or collected post to GL as expenses or liabilities. Critical for customs cost recovery, tax compliance, and cross-border trade accounting.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Customs entries specify port_of_entry_code for clearance. Station link validates customs facility availability, regulatory authority, broker assignment, operating hours, and examination capability for',
    `shipper_id` BIGINT COMMENT 'Foreign key linking to cargo.shipper. Business justification: A customs entry identifies the exporter/shipper of the cargo crossing international borders. customs_entry has exporter_name as a free-text field but no FK to the shipper master. Adding shipper_id nor',
    `tax_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_transaction. Business justification: Customs entries directly generate tax transactions (import duties, VAT, GST on imported cargo). Aviation cargo finance requires customs_entry→tax_transaction linkage for tax filing, duty drawback clai',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`cargo`.`uld_content` (
    `uld_content_id` BIGINT COMMENT 'Primary key for the uld_content association',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to the shipment assigned to this ULD movement event',
    `uld_movement_id` BIGINT COMMENT 'Foreign key linking to the specific ULD movement event in which this shipment was loaded',
    `aircraft_hold_position` STRING COMMENT 'Specific compartment or position code within the aircraft hold where this ULD (containing this shipment) was loaded for this movement event. Belongs to the association as it describes the physical placement of this shipment-ULD combination on a specific flight leg.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Weight in kilograms contributed by this specific shipment to this ULD movement event. Required for weight and balance calculations at the shipment-within-ULD level. Belongs to the association because weight allocation per shipment per ULD movement is an operational record distinct from the shipments total weight.',
    `piece_count` STRING COMMENT 'Number of pieces from this specific shipment loaded into this ULD movement event. Distinct from the total ULD piece count (which aggregates all shipments) and from the shipments total actual_pieces (which spans all legs). Belongs to the association because the same shipment may contribute different piece counts to different ULD movements across routing legs.',
    `seal_number_primary` STRING COMMENT 'Primary security seal number applied to the ULD for this movement event as it relates to the integrity of this shipments contents. Belongs to the association to enable per-shipment seal traceability across multi-leg movements where different seals may be applied at each build-up.',
    `special_handling_codes` STRING COMMENT 'Comma-separated IATA Special Handling Codes (SHC) applicable to this shipment within this ULD movement event. Belongs to the association because SHC requirements may differ per shipment within a mixed-commodity ULD and must be tracked at the shipment-movement level for compliance.',
    CONSTRAINT pk_uld_content PRIMARY KEY(`uld_content_id`)
) COMMENT 'This association product represents the ULD Build-Up Event between uld_movement and shipment. It captures the operational record of which shipments were loaded into a specific ULD for a specific movement event, including the piece count, weight contribution, hold position, seal, and special handling codes applicable to that shipment within that ULD movement. Each record links one uld_movement to one shipment and carries attributes that exist only in the context of that specific build-up assignment. Aligns with IATA ULD Regulations and Cargo-XML messaging standards for ULD content manifesting.. Existence Justification: In air cargo operations, the ULD build-up process is a distinct, actively managed business activity where multiple shipments are physically loaded into a ULD for a specific movement event, and a single shipment may traverse multiple ULD movement events across its routing legs (e.g., built into ULD-A at origin, transferred to ULD-B at a hub). This relationship — known in the industry as a ULD Content Record or ULD Shipment Assignment — is operationally created, updated, and deleted by cargo handlers and is the authoritative record of which shipments were in which ULD at each movement event. The existing shipment.uld_id FK points only to the ULD asset (cargo.uld), not to a specific movement event, meaning it cannot represent the temporal/event-level assignment that cargo operations actually require.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_rate`(`freight_rate_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_capacity_id` FOREIGN KEY (`capacity_id`) REFERENCES `airlines_ecm`.`cargo`.`capacity`(`capacity_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_rate`(`freight_rate_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `airlines_ecm`.`cargo`.`booking`(`booking_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `airlines_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_uld_id` FOREIGN KEY (`uld_id`) REFERENCES `airlines_ecm`.`cargo`.`uld`(`uld_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `airlines_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_uld_id` FOREIGN KEY (`uld_id`) REFERENCES `airlines_ecm`.`cargo`.`uld`(`uld_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_capacity_id` FOREIGN KEY (`capacity_id`) REFERENCES `airlines_ecm`.`cargo`.`capacity`(`capacity_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_load_plan_id` FOREIGN KEY (`load_plan_id`) REFERENCES `airlines_ecm`.`cargo`.`load_plan`(`load_plan_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_embargo_id` FOREIGN KEY (`embargo_id`) REFERENCES `airlines_ecm`.`cargo`.`embargo`(`embargo_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_invoice_freight_forwarder_id` FOREIGN KEY (`invoice_freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `airlines_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_capacity_id` FOREIGN KEY (`capacity_id`) REFERENCES `airlines_ecm`.`cargo`.`capacity`(`capacity_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `airlines_ecm`.`cargo`.`shipper`(`shipper_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ADD CONSTRAINT `fk_cargo_uld_content_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `airlines_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ADD CONSTRAINT `fk_cargo_uld_content_uld_movement_id` FOREIGN KEY (`uld_movement_id`) REFERENCES `airlines_ecm`.`cargo`.`uld_movement`(`uld_movement_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`cargo` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `airlines_ecm`.`cargo` SET TAGS ('dbx_domain' = 'cargo');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `station_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `origin_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Executed Date');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `executed_location` SET TAGS ('dbx_business_glossary_term' = 'Executed Location');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (kg)');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `nature_of_goods` SET TAGS ('dbx_business_glossary_term' = 'Nature of Goods');
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ALTER COLUMN `number_of_pieces` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
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
ALTER TABLE `airlines_ecm`.`cargo`.`booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Booking Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `station_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Agent Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `origin_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `acceptance_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Deadline Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|waitlisted|cancelled|expired|rejected');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Creation Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Indicator');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `declared_value_for_carriage` SET TAGS ('dbx_business_glossary_term' = 'Declared Value for Carriage');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Expiry Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `insurance_requested` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requested');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `number_of_pieces` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `quoted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Quoted Rate Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `rate_quote_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Quote Reference');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Booking Remarks');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `requested_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Requested Volume in Cubic Meters');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `requested_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Requested Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range in Celsius');
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ALTER COLUMN `uld_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Type Requested');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Booking Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Manifest Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`uld` SET TAGS ('dbx_subdomain' = 'fleet_handling');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `uld_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) ID');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` SET TAGS ('dbx_subdomain' = 'fleet_handling');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `uld_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Movement ID');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Manifest Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `uld_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Balance Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Certificate Number');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Check Status');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ALTER COLUMN `acceptance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Check Timestamp');
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
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate ID');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` SET TAGS ('dbx_subdomain' = 'fleet_handling');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `aircraft_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration ID');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `station_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `embargo_id` SET TAGS ('dbx_business_glossary_term' = 'Embargo Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `origin_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `embargo_flag` SET TAGS ('dbx_business_glossary_term' = 'Embargo Flag');
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
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
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Identifier');
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
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Billed Shipper Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Billed Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `invoice_freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Identifier (ID)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `oversize_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Oversize Surcharge');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `security_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Security Surcharge');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `storage_fee` SET TAGS ('dbx_business_glossary_term' = 'Storage Fee');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Awb Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `station_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `origin_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Discovery Date');
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Date');
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
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` SET TAGS ('dbx_subdomain' = 'fleet_handling');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loadmaster Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Loadmaster Qualification Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `embargo_id` SET TAGS ('dbx_business_glossary_term' = 'Embargo Identifier');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` SET TAGS ('dbx_subdomain' = 'shipment_operations');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry ID');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `awb_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) ID');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `freight_forwarder_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ALTER COLUMN `tax_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` SET TAGS ('dbx_subdomain' = 'fleet_handling');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` SET TAGS ('dbx_association_edges' = 'cargo.uld_movement,cargo.shipment');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `uld_content_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Content - Uld Content Id');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Content - Shipment Id');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `uld_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Content - Uld Movement Id');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `aircraft_hold_position` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Hold Position');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight Contribution in ULD');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `piece_count` SET TAGS ('dbx_business_glossary_term' = 'Shipment Piece Count in ULD');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `seal_number_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Seal Number');
ALTER TABLE `airlines_ecm`.`cargo`.`uld_content` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes');
