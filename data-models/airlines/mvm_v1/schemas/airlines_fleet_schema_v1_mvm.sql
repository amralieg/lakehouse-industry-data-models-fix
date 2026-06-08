-- Schema for Domain: fleet | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`fleet` COMMENT 'Single source of truth for aircraft and fleet asset master data including aircraft registration, tail numbers, ICAO/IATA type designators, configuration (cabin layout, seat maps), seating capacity, ownership (owned, wet lease, dry lease, ACMI), APU details, ETOPS certification status, MEL applicability, utilization, block hours, cycles, and fleet planning. Owns the physical asset registry referenced by all other operational domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`aircraft` (
    `aircraft_id` BIGINT COMMENT 'Unique system identifier for the aircraft asset. Primary key for the aircraft master record.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Every aircraft is of a specific type. Aircraft currently denormalizes type-level attributes (icao_type_designator, iata_type_code, aircraft_family, aircraft_variant, manufacturer) that belong in aircr',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Aircraft home base assignment drives crew rostering, maintenance scheduling, and fleet deployment planning. Essential for operational planning and cost allocation. Replaces denormalized base_station_c',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Aircraft leasing is core to airline fleet financing. IFRS16 requires tracking right-of-use assets and lease liabilities by specific aircraft. Finance must link lease contracts to aircraft for lease ac',
    `lessor_id` BIGINT COMMENT 'Foreign key linking to fleet.lessor. Business justification: aircraft has denormalized lessor_name (STRING) attribute. For leased aircraft, the lessor is a critical operational reference. The lessor product exists in fleet domain as the authoritative master. Th',
    `airworthiness_category` STRING COMMENT 'The category of airworthiness certificate issued. Standard = normal commercial operations; Restricted = limited operations; Limited = special purpose; Experimental = testing; Provisional = pre-certification.. Valid values are `standard|restricted|limited|experimental|provisional`',
    `apu_manufacturer` STRING COMMENT 'The manufacturer of the Auxiliary Power Unit installed on the aircraft (e.g., Honeywell, Pratt & Whitney, Hamilton Sundstrand).',
    `apu_model` STRING COMMENT 'The specific model designation of the Auxiliary Power Unit installed on the aircraft.',
    `cabin_configuration_code` STRING COMMENT 'Internal code identifying the specific cabin layout and seat map configuration installed on this aircraft (e.g., 2-class, 3-class, high-density). Links to detailed seat map reference data.',
    `cat_iii_ils_approved` BOOLEAN COMMENT 'Indicates whether the aircraft is equipped and certified for CAT III ILS precision approaches in very low visibility conditions (decision height below 100 feet or no decision height).',
    `certificate_of_airworthiness_number` STRING COMMENT 'The unique certificate number issued by the civil aviation authority certifying that the aircraft meets all safety and airworthiness standards for flight operations.',
    `certificate_of_registration_number` STRING COMMENT 'The unique certificate number issued by the civil aviation authority proving legal registration of the aircraft.',
    `country_of_registration` STRING COMMENT 'The three-letter ISO country code of the nation where the aircraft is registered (e.g., USA, GBR, DEU). Determines regulatory jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this aircraft master record was first created in the system.',
    `delivery_date` DATE COMMENT 'The date the aircraft was delivered from the manufacturer to the original customer or the date it entered the current operators fleet.',
    `etops_certified` BOOLEAN COMMENT 'Indicates whether the aircraft holds ETOPS certification allowing extended-range operations over water or remote areas beyond single-engine diversion time limits.',
    `etops_minutes_rating` STRING COMMENT 'The maximum diversion time in minutes that the aircraft is certified to fly from the nearest suitable airport under ETOPS rules (e.g., 120, 180, 207, 330 minutes). Null if not ETOPS certified.',
    `line_number` STRING COMMENT 'The sequential production line number assigned by the manufacturer indicating the order in which this aircraft was built within its type series.',
    `mel_applicable` BOOLEAN COMMENT 'Indicates whether a Minimum Equipment List is applicable to this aircraft, allowing dispatch with certain non-critical equipment inoperative under controlled conditions.',
    `msn` STRING COMMENT 'The unique serial number assigned by the aircraft manufacturer at the time of production. Permanent identifier that never changes regardless of ownership or registration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `noise_chapter` STRING COMMENT 'The ICAO noise certification standard chapter that the aircraft meets. Chapter 4 is the most stringent current standard. Determines airport access and noise restrictions.. Valid values are `chapter_2|chapter_3|chapter_4|chapter_14`',
    `operational_status` STRING COMMENT 'Current operational state of the aircraft. Active = in revenue service; Stored = long-term storage; Parked = temporary non-operation; Maintenance = undergoing MRO; Retired = permanently withdrawn; Wet_lease_out = leased to another carrier with crew; AOG = Aircraft on Ground (unscheduled maintenance). [ENUM-REF-CANDIDATE: active|stored|parked|maintenance|retired|wet_lease_out|aog — 7 candidates stripped; promote to reference product]',
    `ownership_category` STRING COMMENT 'The legal and financial ownership structure of the aircraft. Owned = airline owns outright; Finance_lease = capital lease with purchase option; Operating_lease = rental without ownership transfer; Dry_lease = aircraft only; Wet_lease_in = aircraft with crew from lessor; ACMI = Aircraft Crew Maintenance Insurance lease.. Valid values are `owned|finance_lease|operating_lease|dry_lease|wet_lease_in|acmi`',
    `registered_operator` STRING COMMENT 'The airline or operator name registered with the civil aviation authority as the entity authorized to operate this aircraft.',
    `registered_owner` STRING COMMENT 'The legal entity name appearing on the certificate of registration as the registered owner of the aircraft. May differ from operator for leased aircraft.',
    `registration_authority` STRING COMMENT 'The name of the civil aviation authority that issued the certificate of registration (e.g., FAA, EASA, CAAC, Transport Canada).',
    `registration_date` DATE COMMENT 'The date the current certificate of registration was issued by the civil aviation authority.',
    `registration_expiry_date` DATE COMMENT 'The expiration date of the current certificate of registration. Aircraft must be re-registered before this date to maintain legal operating authority.',
    `retirement_date` DATE COMMENT 'The date the aircraft was permanently withdrawn from service and retired from the fleet. Null for active aircraft.',
    `rvsm_approved` BOOLEAN COMMENT 'Indicates whether the aircraft is approved for RVSM operations allowing flight in airspace between FL290 and FL410 with 1,000-foot vertical separation.',
    `seating_capacity_business` STRING COMMENT 'The number of seats in the business class cabin. Zero if aircraft does not have business class configuration.',
    `seating_capacity_economy` STRING COMMENT 'The number of seats in the economy class cabin.',
    `seating_capacity_first` STRING COMMENT 'The number of seats in the first class cabin. Zero if aircraft does not have first class configuration.',
    `seating_capacity_premium_economy` STRING COMMENT 'The number of seats in the premium economy cabin. Zero if aircraft does not have premium economy configuration.',
    `seating_capacity_total` STRING COMMENT 'The total number of passenger seats installed on the aircraft across all cabin classes. Used for load factor and capacity planning calculations.',
    `tail_number` STRING COMMENT 'The official registration mark painted on the aircraft tail, serving as the globally unique identifier for the physical aircraft asset. Also known as registration mark or tail sign.. Valid values are `^[A-Z0-9]{5,6}$`',
    `total_block_hours` DECIMAL(18,2) COMMENT 'Cumulative total block hours (gate-to-gate flight time) accumulated by the aircraft since delivery. Critical metric for maintenance planning and asset valuation.',
    `total_cycles` STRING COMMENT 'Cumulative total number of flight cycles (takeoff and landing pairs) accumulated by the aircraft since delivery. Key metric for fatigue life and maintenance interval tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this aircraft master record was last modified in the system.',
    CONSTRAINT pk_aircraft PRIMARY KEY(`aircraft_id`)
) COMMENT 'Core master record for every physical aircraft asset in the airlines fleet — the Single Source of Truth for aircraft identity referenced by all operational domains. Captures tail number (registration mark), ICAO/IATA type designator, MSN (Manufacturer Serial Number), line number, aircraft family and variant, current operational status (active, stored, parked, retired, wet-lease-out), ownership category (owned, finance-lease, dry-lease, wet-lease-in, ACMI), lessor/owner reference, delivery date, retirement date, country of registration, certificate of registration number, certificate of airworthiness number, airworthiness category, noise chapter classification, ETOPS certification status and minutes rating, RVSM approval, CAT III ILS approval, and current base station. Following merge of aircraft_registration, also holds regulatory registration details including registering authority, registration date/expiry, and registered owner/operator.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`aircraft_type` (
    `aircraft_type_id` BIGINT COMMENT 'Unique identifier for the aircraft type record. Primary key.',
    `aircraft_family` STRING COMMENT 'High-level aircraft family grouping (e.g., B737, A320, B777, A350, E190) used for fleet planning and commonality analysis.',
    `aircraft_type_status` STRING COMMENT 'Current lifecycle status of the aircraft type in the airlines context: active (currently operated), retired (formerly operated), planned (future fleet addition), reference (not operated, maintained for codeshare/interline/industry reference).. Valid values are `active|retired|planned|reference`',
    `aircraft_variant` STRING COMMENT 'Specific aircraft variant within the family including generation and configuration details (e.g., B737-800, A320neo, B777-300ER, A350-900, E190-E2).',
    `apu_manufacturer` STRING COMMENT 'Manufacturer of the Auxiliary Power Unit (APU) (e.g., Honeywell, Pratt & Whitney Canada, Hamilton Sundstrand).',
    `apu_model` STRING COMMENT 'Model designation of the Auxiliary Power Unit (APU) installed on this aircraft type (e.g., APS3200, GTCP331-500). Used for maintenance planning and ground operations.',
    `cargo_volume_m3` DECIMAL(18,2) COMMENT 'Total cargo hold volume in cubic meters. Used for cargo revenue planning and ULD capacity analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this aircraft type record was first created in the system.',
    `emissions_standard` STRING COMMENT 'ICAO engine emissions standard (e.g., CAEP/6, CAEP/8, CAEP/10) indicating compliance level for NOx, CO, HC, and smoke. Used for CORSIA reporting and environmental compliance.',
    `engine_count` STRING COMMENT 'Number of engines installed on the aircraft type (typically 2, 3, or 4 for commercial jets; 2 for turboprops).',
    `engine_model` STRING COMMENT 'Specific engine model and manufacturer (e.g., CFM56-7B, PW1100G-JM, GE90-115B, Trent XWB) used for maintenance planning and fuel efficiency analysis.',
    `engine_type` STRING COMMENT 'Propulsion system type installed on the aircraft (turbofan for modern jets, turboprop for regional aircraft, turbojet for older jets, piston for small aircraft).. Valid values are `turbofan|turbojet|turboprop|piston`',
    `etops_baseline_minutes` STRING COMMENT 'Baseline ETOPS certification in minutes (e.g., 120, 180, 330, 370) indicating how far the aircraft can fly from the nearest suitable airport with one engine inoperative. Null for non-ETOPS or multi-engine (3+) aircraft.',
    `etops_certified_flag` BOOLEAN COMMENT 'Indicates whether this aircraft type holds ETOPS certification, enabling extended overwater and remote area operations for twin-engine aircraft.',
    `fleet_entry_date` DATE COMMENT 'Date when this aircraft type first entered the airlines operating fleet. Null if not yet in fleet or planned only.',
    `fleet_exit_date` DATE COMMENT 'Date when this aircraft type was retired from the airlines operating fleet. Null if still active or never operated.',
    `fuel_capacity_liters` DECIMAL(18,2) COMMENT 'Total usable fuel capacity in liters. Critical for range calculation, fuel uplift planning, and operational cost analysis.',
    `fuselage_length_m` DECIMAL(18,2) COMMENT 'Overall length of the aircraft fuselage in meters. Impacts gate compatibility and ground handling requirements.',
    `fuselage_width_category` STRING COMMENT 'Classification of aircraft by fuselage width: narrowbody (single-aisle, e.g., A320, B737), widebody (twin-aisle, e.g., A350, B777), regional (smaller single-aisle, e.g., E190, CRJ).. Valid values are `narrowbody|widebody|regional`',
    `iata_type_code` STRING COMMENT 'Three-character IATA aircraft type code used in reservation systems, schedules, and commercial documentation (e.g., 738 for Boeing 737-800, 32Q for Airbus A321neo).. Valid values are `^[A-Z0-9]{3}$`',
    `icao_type_code` STRING COMMENT 'Four-character ICAO aircraft type designator used globally for flight planning, ATC communication, and operational documentation (e.g., B738 for Boeing 737-800, A20N for Airbus A320neo).. Valid values are `^[A-Z0-9]{2,4}$`',
    `in_fleet_flag` BOOLEAN COMMENT 'Indicates whether this aircraft type is currently operated in the airlines fleet (true) or is a reference type for codeshare, interline, or future planning (false).',
    `manufacturer_name` STRING COMMENT 'Name of the aircraft manufacturer (e.g., Boeing, Airbus, Embraer, Bombardier, ATR).',
    `max_passenger_capacity` STRING COMMENT 'Maximum number of passenger seats that can be installed per the aircraft type certificate, regardless of airline-specific configuration. Used for regulatory compliance and emergency planning.',
    `max_range_nm` STRING COMMENT 'Maximum certified range in nautical miles with maximum fuel and reduced payload. Defines the aircrafts absolute capability for ultra-long-haul operations.',
    `max_structural_payload_kg` DECIMAL(18,2) COMMENT 'Maximum weight of passengers, cargo, and baggage that can be carried, limited by structural design. Critical for load planning and revenue optimization.',
    `mel_applicable_flag` BOOLEAN COMMENT 'Indicates whether a Minimum Equipment List (MEL) is applicable to this aircraft type, allowing dispatch with certain non-critical equipment inoperative under specific conditions.',
    `mlw_kg` DECIMAL(18,2) COMMENT 'Maximum certified weight at which the aircraft is permitted to land. Determines whether fuel jettison is required in emergency return scenarios.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this aircraft type record was last modified.',
    `mtow_kg` DECIMAL(18,2) COMMENT 'Maximum certified weight at which the aircraft is permitted to take off. Determines runway length requirements, fuel capacity, and payload trade-offs.',
    `mzfw_kg` DECIMAL(18,2) COMMENT 'Maximum permitted weight of the aircraft and its contents (excluding usable fuel). Limits payload when fuel load is high. Critical for load planning.',
    `noise_chapter` STRING COMMENT 'ICAO Annex 16 noise certification chapter (Chapter 2, 3, 4, or 14). Chapter 4 and 14 represent the latest, quietest standards. Critical for airport slot eligibility and environmental compliance.. Valid values are `Chapter 2|Chapter 3|Chapter 4|Chapter 14`',
    `typical_block_fuel_per_hour_kg` DECIMAL(18,2) COMMENT 'Average fuel burn per block hour in kilograms under typical operating conditions. Used for CASK calculation, route profitability analysis, and fuel budgeting.',
    `typical_cruise_speed_mach` DECIMAL(18,2) COMMENT 'Typical cruise speed expressed as Mach number (e.g., 0.78, 0.82, 0.85). Used for flight planning, schedule optimization, and block time calculation.',
    `typical_range_nm` STRING COMMENT 'Typical operational range in nautical miles with standard passenger load and reserves. Used for route network planning and aircraft assignment.',
    `wake_turbulence_category` STRING COMMENT 'ICAO wake turbulence category based on maximum takeoff weight: L (Light, <7000kg), M (Medium, 7000-136000kg), H (Heavy, >136000kg), J (Super, A380 only). Critical for ATC separation standards.. Valid values are `L|M|H|J`',
    `wingspan_m` DECIMAL(18,2) COMMENT 'Aircraft wingspan in meters. Determines gate compatibility, taxiway clearance requirements, and ICAO aerodrome reference code.',
    CONSTRAINT pk_aircraft_type PRIMARY KEY(`aircraft_type_id`)
) COMMENT 'Reference master for ICAO/IATA aircraft type designators covering all aircraft families and variants operated or planned. Stores ICAO type code, IATA type code, manufacturer name, aircraft family (e.g. B737, A320), variant (e.g. B737-800, A320neo), engine count, engine type (turbofan, turboprop), wake turbulence category (L/M/H/J), maximum certified passenger capacity, maximum structural payload (kg), maximum takeoff weight (MTOW), maximum landing weight (MLW), maximum zero-fuel weight (MZFW), typical range (nm), typical cruise speed (Mach), wingspan (m), fuselage width category (narrowbody/widebody), ETOPS baseline capability, and whether the type is currently in the airlines fleet.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`cabin_configuration` (
    `cabin_configuration_id` BIGINT COMMENT 'Unique identifier for the cabin configuration record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Reference to the specific aircraft tail number to which this cabin configuration is installed.',
    `aircraft_type_id` BIGINT COMMENT 'Reference to the aircraft type (e.g., B738, A320) for which this configuration is designed. Used when configuration applies to a fleet type rather than a single tail.',
    `business_class_seat_count` STRING COMMENT 'Number of seats in the Business Class cabin. Zero if Business Class is not offered in this configuration.',
    `business_class_seat_pitch_inches` DECIMAL(18,2) COMMENT 'Average seat pitch in Business Class, measured in inches. Null if Business Class is not offered.',
    `business_class_seat_width_inches` DECIMAL(18,2) COMMENT 'Average seat width in Business Class, measured in inches. Null if Business Class is not offered.',
    `cabin_class_count` STRING COMMENT 'Number of distinct cabin classes in this configuration (e.g., 1 for all-economy, 2 for business and economy, 3 for first/business/economy).',
    `configuration_code` STRING COMMENT 'Unique business identifier for the cabin configuration version (e.g., B738-CFG-A, A320-Y180). Used for operational reference and inventory management.. Valid values are `^[A-Z0-9]{3,20}$`',
    `configuration_name` STRING COMMENT 'Human-readable name or description of the cabin configuration (e.g., High-Density Economy, Premium Three-Class).',
    `configuration_status` STRING COMMENT 'Current lifecycle status of the cabin configuration. Active configurations are in operational use; planned configurations are approved but not yet installed; retired configurations are no longer in service.. Valid values are `active|inactive|planned|retired|maintenance`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cabin configuration record was first created in the system.',
    `door_count` STRING COMMENT 'Total number of passenger entry/exit doors in this cabin configuration. Critical for emergency evacuation certification.',
    `economy_seat_count` STRING COMMENT 'Number of seats in the Economy (standard coach) cabin.',
    `economy_seat_pitch_inches` DECIMAL(18,2) COMMENT 'Average seat pitch in Economy class, measured in inches.',
    `economy_seat_width_inches` DECIMAL(18,2) COMMENT 'Average seat width in Economy class, measured in inches.',
    `effective_date` DATE COMMENT 'Date on which this cabin configuration became (or will become) active and available for operational use.',
    `first_class_seat_count` STRING COMMENT 'Number of seats in the First Class cabin. Zero if First Class is not offered in this configuration.',
    `first_class_seat_pitch_inches` DECIMAL(18,2) COMMENT 'Average seat pitch (distance from one seat to the same point on the seat in front) in First Class, measured in inches. Null if First Class is not offered.',
    `first_class_seat_width_inches` DECIMAL(18,2) COMMENT 'Average seat width in First Class, measured in inches. Null if First Class is not offered.',
    `galley_count` STRING COMMENT 'Total number of galleys (food and beverage preparation areas) installed in this cabin configuration.',
    `ife_system_type` STRING COMMENT 'Type or model of the In-Flight Entertainment system installed (e.g., Panasonic eX3, Thales AVANT, Streaming-only). Null if no IFE is installed.',
    `lavatory_count` STRING COMMENT 'Total number of lavatories (restrooms) installed in this cabin configuration.',
    `lie_flat_seat_available` BOOLEAN COMMENT 'Indicates whether this configuration includes lie-flat seats (typically in First or Business Class). True if any cabin class offers lie-flat capability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cabin configuration record was last modified.',
    `overwing_exit_count` STRING COMMENT 'Number of overwing emergency exits in this cabin configuration. Used for evacuation planning and seating restrictions.',
    `power_outlet_availability` STRING COMMENT 'Indicates the availability of power outlets (AC or USB) for passenger devices. Values: none (no power outlets), selected_seats (available in premium cabins or select rows), all_seats (available at every seat).. Valid values are `none|selected_seats|all_seats`',
    `premium_economy_seat_count` STRING COMMENT 'Number of seats in the Premium Economy cabin. Zero if Premium Economy is not offered in this configuration.',
    `premium_economy_seat_pitch_inches` DECIMAL(18,2) COMMENT 'Average seat pitch in Premium Economy, measured in inches. Null if Premium Economy is not offered.',
    `premium_economy_seat_width_inches` DECIMAL(18,2) COMMENT 'Average seat width in Premium Economy, measured in inches. Null if Premium Economy is not offered.',
    `retirement_date` DATE COMMENT 'Date on which this cabin configuration was retired from service. Null if the configuration is still active or planned.',
    `seat_map_reference` STRING COMMENT 'Reference identifier or URL to the detailed seat map diagram for this configuration. Used by reservation systems and passenger-facing applications.',
    `total_seat_count` STRING COMMENT 'Total number of passenger seats installed in this cabin configuration across all classes. Critical for revenue management and Available Seat Kilometer (ASK) calculations.',
    `wifi_available` BOOLEAN COMMENT 'Indicates whether in-flight Wi-Fi connectivity is available in this cabin configuration.',
    `wifi_provider` STRING COMMENT 'Name of the Wi-Fi service provider (e.g., Gogo, Viasat, Panasonic Avionics). Null if Wi-Fi is not available.',
    CONSTRAINT pk_cabin_configuration PRIMARY KEY(`cabin_configuration_id`)
) COMMENT 'Defines the cabin layout and seating configuration installed on a specific aircraft. Each record represents a named configuration version (e.g. B738-CFG-A) linked to an aircraft or aircraft type. Captures total seat count, number of cabin classes (e.g. First, Business, Premium Economy, Economy), seat pitch by class, seat width by class, lie-flat availability, in-flight entertainment (IFE) system type, Wi-Fi availability, galley count, lavatory count, door count, overwing exit count, configuration effective date, and configuration retirement date. Supports revenue management seat inventory and passenger service.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`seat_map` (
    `seat_map_id` BIGINT COMMENT 'Unique identifier for the seat map record. Primary key for the seat map entity.',
    `cabin_configuration_id` BIGINT COMMENT 'Reference to the specific aircraft configuration that this seat belongs to. Links to the aircraft configuration master data defining the overall cabin layout.',
    `block_reason` STRING COMMENT 'The reason why the seat is blocked from assignment. Provides operational context for seat inventory management and passenger service recovery.. Valid values are `crew_rest|broken|maintenance|weight_balance|social_distancing|vip_buffer|[ENUM-REF-CANDIDATE: crew_rest|broken|maintenance|weight_balance|social_distancing|vip_buffer|operational|regulatory — promote to reference product]`',
    `cabin_class` STRING COMMENT 'The service class or cabin compartment to which this seat is assigned. Determines service level, amenities, and fare eligibility.. Valid values are `first|business|premium_economy|economy`',
    `column_letter` STRING COMMENT 'The alphabetic column identifier for the seat position within the row (A through K). Typically A and K are window seats in wide-body aircraft.. Valid values are `^[A-K]$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this seat map record was first created in the system. Used for audit trail and data lineage.',
    `deck` STRING COMMENT 'The deck or level of the aircraft where the seat is located. Relevant for wide-body aircraft with multiple passenger decks.. Valid values are `main|upper|lower`',
    `effective_date` DATE COMMENT 'The date from which this seat map configuration becomes active and available for passenger assignment. Supports configuration versioning and fleet changes.',
    `expiry_date` DATE COMMENT 'The date on which this seat map configuration is retired and no longer valid for passenger assignment. Nullable for current active configurations.',
    `galley_proximity` STRING COMMENT 'Indicates the proximity of the seat to galley (kitchen) facilities. Proximity to galleys can impact passenger experience due to noise and crew activity.. Valid values are `none|adjacent|near|far`',
    `has_ife` BOOLEAN COMMENT 'Flag indicating whether the seat is equipped with an in-flight entertainment system. IFE availability is a key amenity for passenger satisfaction and ancillary revenue.',
    `ife_screen_size_inches` DECIMAL(18,2) COMMENT 'The diagonal screen size in inches of the in-flight entertainment display at this seat. Used for product differentiation and passenger communication.',
    `is_accessible` BOOLEAN COMMENT 'Flag indicating whether the seat is designated as accessible for passengers with disabilities or reduced mobility. Accessible seats meet regulatory requirements for space and proximity to facilities.',
    `is_bassinet_capable` BOOLEAN COMMENT 'Flag indicating whether the seat position can accommodate an infant bassinet attachment. Typically available at bulkhead seats with sufficient wall space.',
    `is_blocked` BOOLEAN COMMENT 'Flag indicating whether the seat is currently blocked from passenger assignment. Blocked seats are unavailable for sale or assignment due to operational, regulatory, or commercial reasons.',
    `is_bulkhead` BOOLEAN COMMENT 'Flag indicating whether the seat is located directly behind a bulkhead (dividing wall). Bulkhead seats typically offer extra legroom but may have restricted under-seat storage.',
    `is_crew_rest` BOOLEAN COMMENT 'Flag indicating whether the seat is designated for crew rest on long-haul flights. Crew rest seats are blocked from passenger assignment and reserved for flight crew during rest periods.',
    `is_exit_row` BOOLEAN COMMENT 'Flag indicating whether the seat is located in an emergency exit row. Exit row seats have special regulatory requirements and passenger eligibility restrictions.',
    `is_last_row` BOOLEAN COMMENT 'Flag indicating whether the seat is in the last row of the cabin or section. Last row seats often have limited or no recline and proximity to lavatories.',
    `is_overwing` BOOLEAN COMMENT 'Flag indicating whether the seat is located over the aircraft wing, which may restrict window views. Used for passenger communication and seat selection preferences.',
    `is_preferred_seat` BOOLEAN COMMENT 'Flag indicating whether the seat is designated as a preferred or premium seat eligible for ancillary seat selection fees. Preferred seats typically offer enhanced comfort or location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this seat map record was last updated. Used for change tracking and audit trail.',
    `lavatory_proximity` STRING COMMENT 'Indicates the proximity of the seat to lavatory facilities. Proximity to lavatories can be a positive (convenience) or negative (noise, traffic) factor for seat selection.. Valid values are `none|adjacent|near|far`',
    `power_outlet_type` STRING COMMENT 'The type of power outlet available at the seat for passenger device charging. Power availability is increasingly important for passenger satisfaction and ancillary revenue.. Valid values are `none|ac_110v|ac_220v|usb_a|usb_c|both_ac_usb`',
    `recline_angle_degrees` DECIMAL(18,2) COMMENT 'The maximum recline angle of the seat in degrees from vertical. Used to communicate seat comfort specifications and differentiate premium products.',
    `recline_type` STRING COMMENT 'The recline capability of the seat, ranging from no recline to full lie-flat configurations. Critical for premium cabin differentiation and passenger comfort.. Valid values are `none|limited|standard|enhanced|lie_flat|angle_flat`',
    `row_number` STRING COMMENT 'The numeric row identifier within the aircraft cabin. Used for seat assignment logic and cabin zone management.',
    `seat_designator` STRING COMMENT 'The unique seat identifier within the aircraft, combining row number and column letter (e.g., 12A, 34F). This is the seat label passengers see on their boarding pass.. Valid values are `^[1-9][0-9]{0,2}[A-K]$`',
    `seat_fee_tier` STRING COMMENT 'The pricing tier for ancillary seat selection fees. Used by revenue management systems to price seat assignments and optimize ancillary revenue.. Valid values are `standard|preferred|extra_legroom|premium|exit_row`',
    `seat_map_status` STRING COMMENT 'The current lifecycle status of the seat map record. Indicates whether the seat configuration is currently in use, pending activation, or retired.. Valid values are `active|inactive|pending|retired`',
    `seat_pitch_inches` DECIMAL(18,2) COMMENT 'The distance in inches from one point on a seat to the same point on the seat in front or behind, measuring legroom and seat spacing. Key metric for passenger comfort and cabin density.',
    `seat_type` STRING COMMENT 'The positional type of the seat within the row, indicating whether it is adjacent to the window, in the middle of a seat group, or adjacent to the aisle. Critical for passenger preference and ancillary revenue.. Valid values are `window|middle|aisle`',
    `seat_width_inches` DECIMAL(18,2) COMMENT 'The width of the seat in inches, measured at the widest point of the seat cushion. Impacts passenger comfort and cabin configuration.',
    `storage_restriction` STRING COMMENT 'Indicates any restrictions on carry-on baggage storage at this seat location. Some seats (e.g., bulkhead, exit row) have limited under-seat or overhead storage.. Valid values are `none|no_underseat|limited_overhead|both`',
    CONSTRAINT pk_seat_map PRIMARY KEY(`seat_map_id`)
) COMMENT 'Seat-level detail for a cabin configuration — each row represents one physical seat position. This is the granular seat inventory that passenger service systems, revenue management, and check-in reference for seat assignment, blocking, and special service request (SSR) fulfillment. Captures seat designator (e.g. 12A), deck (main/upper), cabin class assignment, row number, column letter, seat type (window/middle/aisle), location attributes (exit-row, bulkhead, overwing, last-row, bassinet-capable), physical dimensions (pitch inches, width inches), recline capability (standard/limited/lie-flat/angle-flat), blocking flags (is_blocked, block_reason), crew rest indicator, IFE availability, power outlet type (none/AC/USB/both), and premium attributes relevant to ancillary seat selection revenue.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`fleet_order` (
    `fleet_order_id` BIGINT COMMENT 'Unique identifier for the fleet order record. Primary key for aircraft purchase orders and lease commitments.',
    `aircraft_type_id` BIGINT COMMENT 'Reference to the aircraft type being ordered (e.g., Boeing 737-800, Airbus A320neo). Links to aircraft type master data containing ICAO/IATA designators and specifications.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Aircraft purchase orders must reference the approved CAPEX budget plan for board-level fleet investment authorization and budget vs. actual variance reporting. Airline finance teams track fleet order ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Fleet orders drive CAPEX cost centre assignments that determine where aircraft depreciation will be posted once delivered. Airline CAPEX controllers require fleet orders to reference a cost centre for',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Fleet purchase orders are contracted by a specific airline legal entity (subsidiary), which is essential for group CAPEX consolidation, purchase contract management, and entity-level financial reporti',
    `lessor_id` BIGINT COMMENT 'Foreign key linking to fleet.lessor. Business justification: fleet_order records both purchase orders (with OEMs) and lease commitments. When order_type indicates a lease commitment, the counterparty is a lessor tracked in the lessor master table. Adding fleet_',
    `cabin_configuration_code` STRING COMMENT 'Planned cabin layout configuration for the ordered aircraft. Defines seating classes and arrangement (e.g., 2-class, 3-class, high-density). Links to detailed seat map specifications.',
    `cancellation_date` DATE COMMENT 'Date when the order was officially cancelled or terminated. Null for active orders.',
    `cancellation_penalty_usd` DECIMAL(18,2) COMMENT 'Financial penalty amount in US Dollars if the order is cancelled before delivery. Defined in contract terms.',
    `cancellation_reason` STRING COMMENT 'Business reason for order cancellation. Examples: strategic fleet plan change, financial constraints, route network adjustment, OEM delivery delays. Null for active orders.',
    `contract_reference_number` STRING COMMENT 'Legal contract or purchase agreement reference number. Links to the binding legal document governing the order terms and conditions.',
    `conversion_date` DATE COMMENT 'Date when an option or letter of intent was converted to a firm order. Null if order was firm from inception or has not been converted.',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty. OEM = Original Equipment Manufacturer (Boeing, Airbus), Lessor = Aircraft leasing company, Broker = Intermediary facilitating the transaction.. Valid values are `oem|lessor|broker`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet order record was first created in the system. Audit trail for data lineage.',
    `delivery_window_end_date` DATE COMMENT 'Latest contractual delivery date for aircraft in this order. Defines the end of the delivery period.',
    `delivery_window_start_date` DATE COMMENT 'Earliest contractual delivery date for aircraft in this order. Defines the beginning of the delivery period.',
    `deposit_amount_usd` DECIMAL(18,2) COMMENT 'Initial deposit or down payment amount paid to secure the order, in US Dollars. Typically a percentage of total order value.',
    `engine_type` STRING COMMENT 'Specific engine model selected for the aircraft order. Examples: CFM LEAP-1A, Pratt & Whitney PW1100G, Rolls-Royce Trent 7000. Critical for maintenance planning and fuel efficiency.',
    `financing_structure` STRING COMMENT 'Method of financing the aircraft acquisition. Cash = direct purchase, Debt Financing = loan-backed purchase, Sale-Leaseback = sell and lease back, Operating Lease = rental, Finance Lease = lease-to-own, Hybrid = combination of methods.. Valid values are `cash|debt_financing|sale_leaseback|operating_lease|finance_lease|hybrid`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet order record was last updated. Tracks most recent change for audit and data quality purposes.',
    `list_price_per_unit_usd` DECIMAL(18,2) COMMENT 'Manufacturers published list price per aircraft in US Dollars. This is the catalog price before any negotiated discounts.',
    `negotiated_price_per_unit_usd` DECIMAL(18,2) COMMENT 'Actual negotiated price per aircraft in US Dollars after discounts and concessions. Highly confidential commercial terms. Null if not disclosed or still under negotiation.',
    `notes` STRING COMMENT 'Free-text field for additional order details, special terms, delivery conditions, or internal planning notes. Supports operational context and decision documentation.',
    `option_expiry_date` DATE COMMENT 'Date by which option rights must be exercised or they expire. Applicable only for orders with option quantities. Null for firm orders.',
    `order_date` DATE COMMENT 'Date when the order was officially placed with the OEM or lessor. Marks the contractual commitment date.',
    `order_status` STRING COMMENT 'Current lifecycle status of the fleet order. Firm = binding commitment, Option = right to purchase, Letter of Intent = preliminary agreement, Cancelled = order terminated, Converted = option converted to firm, Delivered = order fulfilled.. Valid values are `firm|option|letter_of_intent|cancelled|converted|delivered`',
    `order_type` STRING COMMENT 'Classification of the acquisition structure. Purchase = outright ownership, Operating Lease = rental without ownership transfer, Finance Lease = lease with ownership transfer option, Sale-Leaseback = sell owned aircraft and lease back, Wet Lease = aircraft with crew, Dry Lease = aircraft only, ACMI = Aircraft Crew Maintenance Insurance lease. [ENUM-REF-CANDIDATE: purchase|operating_lease|finance_lease|sale_leaseback|wet_lease|dry_lease|acmi — 7 candidates stripped; promote to reference product]',
    `purpose` STRING COMMENT 'Strategic business purpose for the aircraft order. Fleet Growth = net addition to fleet size, Fleet Replacement = replacing retiring aircraft, Fleet Renewal = modernizing existing capacity, Capacity Expansion = increasing seat capacity, Route Expansion = supporting new route network.. Valid values are `fleet_growth|fleet_replacement|fleet_renewal|capacity_expansion|route_expansion`',
    `quantity_cancelled` STRING COMMENT 'Number of aircraft from this order that have been cancelled or terminated before delivery.',
    `quantity_delivered` STRING COMMENT 'Number of aircraft from this order that have been delivered and accepted into the fleet.',
    `quantity_firm` STRING COMMENT 'Number of aircraft under firm binding commitment. These are contractually committed deliveries.',
    `quantity_loi` STRING COMMENT 'Number of aircraft covered by letter of intent. Non-binding preliminary agreement expressing purchase interest.',
    `quantity_option` STRING COMMENT 'Number of aircraft under option rights. Airline has the right but not obligation to purchase at predetermined terms.',
    `reference_number` STRING COMMENT 'External business identifier for the aircraft order or lease commitment. Used in contracts and communications with OEMs and lessors.. Valid values are `^[A-Z0-9]{6,20}$`',
    `total_order_value_usd` DECIMAL(18,2) COMMENT 'Total financial value of the entire order in US Dollars. Calculated as quantity times negotiated price (or list price if negotiated not available). Represents total capital commitment.',
    `total_seat_capacity` STRING COMMENT 'Total number of passenger seats in the planned cabin configuration. Sum of all seating classes (First, Business, Premium Economy, Economy).',
    CONSTRAINT pk_fleet_order PRIMARY KEY(`fleet_order_id`)
) COMMENT 'Records aircraft purchase orders and lease commitments placed with OEMs (Boeing, Airbus, Embraer) or lessors for fleet growth, replacement, or renewal. Each record represents a firm order, option, or letter of intent. Captures order reference number, aircraft type ordered, quantity (firm/option/LoI), deliveries completed, cancellations, order date, contractual delivery window (start/end), list price per unit (USD), negotiated price per unit where available, total order value, order status (firm/option/LoI/cancelled/converted), financing structure (cash/debt/sale-leaseback/operating-lease), counterparty (OEM or lessor), and associated fleet plan scenario reference. Supports fleet planning, capital expenditure forecasting, and delivery pipeline management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` (
    `aircraft_delivery_id` BIGINT COMMENT 'Unique identifier for the aircraft delivery event. Primary key for the aircraft delivery transaction.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft master record that was delivered. Links to the aircraft asset registry.',
    `aircraft_lease_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_lease. Business justification: An aircraft delivery event — particularly for wet-lease, dry-lease, or ACMI arrangements — fulfills a specific lease agreement. Linking aircraft_delivery.aircraft_lease_id → aircraft_lease.aircraft_le',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Aircraft delivery records the type of aircraft being delivered. Currently denormalizes aircraft_type_icao and aircraft_type_iata. Adding aircraft_type_id FK normalizes this and allows delivery records',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: aircraft_delivery currently stores cabin_configuration_code as a plain STRING, denormalizing the cabin layout installed at delivery. The cabin_configuration table is the authoritative source for confi',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: New aircraft acceptance logistics, delivery team deployment, and acceptance flight planning require station linkage. Fleet planning and delivery coordination depend on accurate station tracking. Repla',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: When aircraft is delivered, its capitalized as a fixed asset. Delivery record must link to fixed_asset entry for acquisition cost, depreciation tracking, and asset register reconciliation. Real busin',
    `fleet_order_id` BIGINT COMMENT 'Foreign key linking to fleet.fleet_order. Business justification: Aircraft delivery fulfills a fleet order. fleet_order tracks purchase orders and lease commitments; aircraft_delivery records the actual delivery event. Linking delivery to order establishes traceabil',
    `acceptance_certificate_reference` STRING COMMENT 'Reference number of the formal acceptance certificate document signed by the airline and manufacturer/lessor confirming aircraft delivery and acceptance.. Valid values are `^ACC-[A-Z0-9]{6,12}$`',
    `airframe_cycles_at_delivery` STRING COMMENT 'Total accumulated flight cycles (takeoff and landing cycles) on the airframe at the time of delivery. Zero for new aircraft, non-zero for used aircraft.',
    `airframe_hours_at_delivery` DECIMAL(18,2) COMMENT 'Total accumulated flight hours (block hours) on the airframe at the time of delivery. Zero for new aircraft, non-zero for used aircraft.',
    `apu_serial_number` STRING COMMENT 'Manufacturer serial number of the Auxiliary Power Unit (APU) installed on the aircraft at delivery. APU provides electrical power and pneumatic air on the ground and in-flight backup.. Valid values are `^[A-Z0-9]{6,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this aircraft delivery record was first created in the system.',
    `delivery_condition` STRING COMMENT 'Condition classification of the aircraft at delivery: new from manufacturer, used from lessor, refurbished after major overhaul, or pre-owned from another operator.. Valid values are `new|used|refurbished|pre-owned`',
    `delivery_date` DATE COMMENT 'The date on which the aircraft was formally accepted into the airlines fleet from the manufacturer or lessor. Marks the start of operational availability.',
    `delivery_flight_number` STRING COMMENT 'Flight number assigned to the ferry flight that delivered the aircraft from the manufacturer or lessor facility to the airlines base. May be a non-revenue positioning flight.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}$`',
    `delivery_notes` STRING COMMENT 'Free-text notes capturing additional details about the delivery event, including any special conditions, snags identified during acceptance inspection, or deviations from standard delivery procedures.',
    `delivery_number` STRING COMMENT 'Externally-known unique business identifier for this aircraft delivery transaction, typically assigned by the manufacturer or lessor.. Valid values are `^DEL-[0-9]{6,10}$`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the aircraft delivery transaction: scheduled (planned future delivery), in transit (ferry flight underway), accepted (delivery completed and aircraft in service), rejected (delivery refused), cancelled (delivery cancelled), or deferred (delivery postponed).. Valid values are `scheduled|in_transit|accepted|rejected|cancelled|deferred`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the aircraft delivery acceptance was signed off and the aircraft officially transferred to the airlines operational control.',
    `engine_1_serial_number` STRING COMMENT 'Manufacturer serial number of the engine installed in position 1 (typically left engine on twin-engine aircraft) at delivery.. Valid values are `^[A-Z0-9]{6,15}$`',
    `engine_2_serial_number` STRING COMMENT 'Manufacturer serial number of the engine installed in position 2 (typically right engine on twin-engine aircraft) at delivery.. Valid values are `^[A-Z0-9]{6,15}$`',
    `engine_3_serial_number` STRING COMMENT 'Manufacturer serial number of the engine installed in position 3 (for tri-jet or quad-jet aircraft) at delivery. Null for twin-engine aircraft.. Valid values are `^[A-Z0-9]{6,15}$`',
    `engine_4_serial_number` STRING COMMENT 'Manufacturer serial number of the engine installed in position 4 (for quad-jet aircraft) at delivery. Null for twin-engine and tri-jet aircraft.. Valid values are `^[A-Z0-9]{6,15}$`',
    `etops_certified_flag` BOOLEAN COMMENT 'Indicates whether the aircraft is certified for ETOPS operations at delivery, allowing extended-range twin-engine flights over routes distant from diversion airports.',
    `etops_rating_minutes` STRING COMMENT 'ETOPS rating in minutes (e.g., 120, 180, 207, 330) indicating the maximum diversion time the aircraft is certified for. Null if not ETOPS certified.',
    `mel_applicable_flag` BOOLEAN COMMENT 'Indicates whether a Minimum Equipment List (MEL) is applicable to this aircraft, allowing dispatch with certain non-critical equipment inoperative under specified conditions.',
    `msn` STRING COMMENT 'Unique serial number assigned by the aircraft manufacturer at production. Permanent identifier for the airframe throughout its lifecycle.. Valid values are `^[A-Z0-9]{4,10}$`',
    `ownership_type` STRING COMMENT 'Type of ownership or lease arrangement under which the aircraft was acquired: owned (purchased outright), wet lease (aircraft with crew), dry lease (aircraft only), ACMI (Aircraft Crew Maintenance Insurance), finance lease, or operating lease.. Valid values are `owned|wet_lease|dry_lease|acmi|finance_lease|operating_lease`',
    `tail_number` STRING COMMENT 'Civil aviation registration number (tail number) assigned to the aircraft at delivery. Displayed on the aircraft fuselage and used for ATC identification.. Valid values are `^[A-Z]{1,2}-[A-Z0-9]{3,5}$`',
    `technical_acceptance_outcome` STRING COMMENT 'Outcome of the technical acceptance inspection performed by the airlines engineering team: accepted (no issues), accepted with conditions (minor snags to be resolved), rejected (major defects), or deferred (inspection postponed).. Valid values are `accepted|accepted_with_conditions|rejected|deferred`',
    `total_seat_capacity` STRING COMMENT 'Total number of passenger seats installed in the aircraft at delivery, across all cabin classes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this aircraft delivery record was last modified in the system.',
    CONSTRAINT pk_aircraft_delivery PRIMARY KEY(`aircraft_delivery_id`)
) COMMENT 'Transactional record of each aircraft delivery event — when a new or leased aircraft is formally accepted into the airlines fleet from a manufacturer or lessor. Captures delivery date, delivery location (airport ICAO), aircraft MSN, tail number assigned at delivery, aircraft type, delivery flight number (ferry flight), acceptance certificate reference, technical acceptance inspection outcome, delivery condition (new/used), hours at delivery, cycles at delivery, engine serial numbers at delivery, APU serial number at delivery, and delivery team sign-off. Triggers aircraft registration and initial airworthiness documentation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`aircraft_lease` (
    `aircraft_lease_id` BIGINT COMMENT 'Unique identifier for the aircraft lease agreement record. Primary key for the aircraft lease entity.',
    `aircraft_id` BIGINT COMMENT 'Reference to the specific aircraft asset covered by this lease agreement. Links to the aircraft master registry.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: aircraft_lease currently stores aircraft_type_code as a plain STRING, which is a denormalized reference to the aircraft type. Lease agreements are often structured around a specific aircraft type (e.g',
    `fleet_order_id` BIGINT COMMENT 'Foreign key linking to fleet.fleet_order. Business justification: A lease agreement often originates from a fleet order commitment (when fleet_order.order_type = lease commitment). Linking aircraft_lease.fleet_order_id → fleet_order.fleet_order_id allows the lease r',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: aircraft_lease is the operational lease record; lease_contract is the financial/accounting representation under IFRS16. Same lease must exist in both domains for compliance. Real business process: lea',
    `legal_entity_id` BIGINT COMMENT 'Reference to the lessee entity (airline operating unit or subsidiary) receiving the aircraft. Links to internal organizational hierarchy.',
    `lessor_id` BIGINT COMMENT 'Foreign key linking to fleet.lessor. Business justification: aircraft_lease has denormalized lessor_name (STRING) attribute. The lessor product exists in fleet domain as the authoritative master for lessor entities. This FK normalizes the relationship, allowing',
    `actual_delivery_date` DATE COMMENT 'Actual date when the aircraft was physically delivered to the lessee and accepted into operational service. May differ from lease start date.',
    `actual_return_date` DATE COMMENT 'Actual date when the aircraft was returned to the lessor and removed from lessee operational control. Populated upon lease termination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease agreement record was first created in the system. Audit trail for data lineage.',
    `early_termination_clause_flag` BOOLEAN COMMENT 'Indicates whether the lease agreement includes provisions allowing early termination by either party under specified conditions.',
    `early_termination_penalty_usd` DECIMAL(18,2) COMMENT 'Financial penalty amount in US dollars payable if the lease is terminated before the scheduled end date. Nullable if no penalty applies.',
    `extension_option_available_flag` BOOLEAN COMMENT 'Indicates whether the lease agreement includes an option for the lessee to extend the lease term beyond the original end date.',
    `extension_option_duration_months` STRING COMMENT 'Duration in months for which the lease can be extended if the extension option is exercised. Nullable if no extension option exists.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law specified in the lease agreement for dispute resolution and contract interpretation (e.g., New York, England and Wales, Singapore).',
    `insurance_responsibility` STRING COMMENT 'Party responsible for maintaining aircraft hull and liability insurance coverage during the lease term. Critical for ACMI vs dry lease distinction.. Valid values are `lessor|lessee|shared`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease agreement record was most recently updated. Tracks the latest change to any attribute in the record.',
    `lease_agreement_number` STRING COMMENT 'Externally-known unique identifier for the lease agreement as referenced in legal contracts and financial systems. Business identifier for the lease.. Valid values are `^[A-Z0-9]{6,20}$`',
    `lease_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the lease agreement. While amounts are stored in USD, this captures the original contract currency for reference.. Valid values are `^[A-Z]{3}$`',
    `lease_end_date` DATE COMMENT 'Scheduled expiration date of the lease agreement when the aircraft must be returned to the lessor. Nullable for open-ended leases.',
    `lease_execution_date` DATE COMMENT 'Date when the lease agreement was formally signed and executed by both lessor and lessee parties. Legal effective date of the contract.',
    `lease_start_date` DATE COMMENT 'Effective date when the lease agreement becomes binding and the aircraft is delivered to the lessee. Marks the beginning of rental obligations.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease agreement. Tracks the agreement from negotiation through active operation to closure. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|extended — 7 candidates stripped; promote to reference product]',
    `lease_type` STRING COMMENT 'Classification of the lease arrangement. Dry lease: aircraft only. Wet lease: aircraft with crew. ACMI: Aircraft, Crew, Maintenance, Insurance. Damp lease: aircraft with some crew.. Valid values are `dry_lease|wet_lease|acmi|damp_lease`',
    `maintenance_reserve_rate_per_cycle` DECIMAL(18,2) COMMENT 'Maintenance reserve contribution rate in US dollars per flight cycle (takeoff and landing). Applied to landing gear and other cycle-sensitive components.',
    `maintenance_reserve_rate_per_fh` DECIMAL(18,2) COMMENT 'Maintenance reserve contribution rate in US dollars per flight hour. Accumulated reserves fund major maintenance events and are reconciled at lease end.',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for performing and funding aircraft maintenance during the lease term. Defines operational obligations under the lease type.. Valid values are `lessor|lessee|shared`',
    `monthly_rental_rate_usd` DECIMAL(18,2) COMMENT 'Fixed monthly lease payment amount in US dollars payable to the lessor. Base rental rate excluding maintenance reserves and other variable charges.',
    `payment_frequency` STRING COMMENT 'Frequency at which lease rental payments are due to the lessor. Defines the billing cycle for the lease obligation.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `redelivery_location_code` STRING COMMENT 'IATA three-letter airport code specifying the contractual location where the aircraft must be returned to the lessor at lease end.. Valid values are `^[A-Z]{3}$`',
    `return_condition_max_cycles` STRING COMMENT 'Maximum total flight cycles allowed on the aircraft at lease return. Contractual limit for takeoff/landing cycles at redelivery.',
    `return_condition_max_flight_hours` STRING COMMENT 'Maximum total flight hours allowed on the aircraft at lease return. Contractual limit defining acceptable utilization at redelivery.',
    `security_deposit_amount_usd` DECIMAL(18,2) COMMENT 'Refundable security deposit amount in US dollars held by the lessor as collateral against lease obligations and aircraft return conditions.',
    CONSTRAINT pk_aircraft_lease PRIMARY KEY(`aircraft_lease_id`)
) COMMENT 'Master record for each aircraft lease agreement covering dry-lease, wet-lease, and ACMI arrangements. Captures lease agreement number, lessor name, lessee entity, aircraft tail number, aircraft type, lease type (dry/wet/ACMI), lease start date, lease end date, monthly rental rate (USD), security deposit amount, return conditions (hours/cycles limits), maintenance reserve rate per flight hour, redelivery location, extension options, early termination clause flag, governing law jurisdiction, and current lease status (active/expired/terminated/extended). SSOT for fleet ownership and cost allocation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`engine` (
    `engine_id` BIGINT COMMENT 'Unique identifier for the aircraft engine asset. Primary key for the engine master record.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft on which this engine is currently installed. Null if engine is in spare pool or shop.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Engine MRO costs, PBH (power-by-hour) contract charges, and depreciation must be attributed to a cost centre for airline management accounting and CASK reporting by fleet type. Aviation finance contro',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Off-wing engine inventory management and shop visit logistics require station tracking. Spare engine positioning, MRO coordination, and rotable pool management depend on knowing current engine locatio',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Engines are individually capitalized assets under IFRS/GAAP requiring their own fixed_asset records for depreciation, impairment testing, and disposal accounting. Engine acquisition_cost and current_b',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Engines are often leased separately from airframes (power-by-hour contracts, standalone engine leases). Finance must track engine lease liabilities independently for IFRS16 compliance and cash flow fo',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original acquisition cost of this engine in the airlines reporting currency. Used for asset valuation, depreciation calculation, and financial reporting. Null if cost information is not tracked.',
    `acquisition_date` DATE COMMENT 'Date when this engine was acquired by the airline, either through purchase, lease commencement, or delivery from manufacturer. Used for asset accounting and depreciation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engine master record was first created in the system. Used for data lineage and audit trail purposes.',
    `cslsv_cycles` STRING COMMENT 'Flight cycles accumulated since the engines last major shop visit or overhaul. Resets to zero after each shop visit. Used alongside TSLSV for shop visit planning.',
    `csn_cycles` STRING COMMENT 'Total number of flight cycles (takeoff and landing pairs) accumulated by this engine since manufacture. One cycle equals one takeoff-landing sequence. Used for fatigue life tracking.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current depreciated book value of this engine on the airlines balance sheet. Updated based on depreciation schedule and any impairment charges. Null if not tracked.',
    `engine_status` STRING COMMENT 'Current operational status of the engine. Installed (on-wing), spare (serviceable spare pool), QEC (Quick Engine Change kit), shop (undergoing MRO), beyond-repair (uneconomical to repair), retired (end of service life), or AOG (Aircraft on Ground - engine causing aircraft grounding). [ENUM-REF-CANDIDATE: installed|spare|QEC|shop|beyond-repair|retired|AOG — 7 candidates stripped; promote to reference product]',
    `esn` STRING COMMENT 'Manufacturer-assigned unique serial number for this engine. The globally unique identifier used for tracking, MRO, and lease return. Also known as ESN in aviation industry.. Valid values are `^[A-Z0-9]{6,20}$`',
    `etops_eligible` BOOLEAN COMMENT 'Indicates whether this engine meets ETOPS certification requirements for extended over-water or remote area operations. True if engine is ETOPS-certified and current on all ETOPS maintenance requirements.',
    `etops_rating_minutes` STRING COMMENT 'ETOPS diversion time rating in minutes (e.g., 120, 180, 207, 330). Defines maximum allowable distance from suitable alternate airport. Null if engine is not ETOPS-certified.',
    `installation_date` DATE COMMENT 'Date when this engine was installed on the current aircraft. Null if engine is not currently installed on an aircraft.',
    `last_shop_visit_date` DATE COMMENT 'Date when this engine completed its most recent major shop visit or overhaul. Used to calculate TSLSV and CSLSV intervals.',
    `last_shop_visit_type` STRING COMMENT 'Type of maintenance work performed during the last shop visit. Performance restoration (PR), life-limited parts replacement, hot section inspection (HSI), or full overhaul. Determines next shop visit scope.. Valid values are `performance_restoration|life_limited_parts_replacement|hot_section_inspection|full_overhaul`',
    `lease_expiry_date` DATE COMMENT 'Date when the current engine lease agreement expires. Critical for return condition planning and lease extension negotiations. Null if engine is owned.',
    `lease_return_condition` STRING COMMENT 'Contractual maintenance condition requirements that must be met when returning this leased engine to the lessor. Typically specifies minimum remaining hours/cycles on LLPs and maintenance status. Null if owned.',
    `llp_lowest_remaining_cycles` STRING COMMENT 'Remaining cycles until mandatory retirement of the most limiting life-limited part in this engine. Critical for shop visit planning and residual value assessment.',
    `llp_summary` STRING COMMENT 'Summary of remaining cycles for critical life-limited parts (LLP) in this engine. LLPs are components with mandatory retirement life limits due to fatigue considerations. Format typically includes part numbers and remaining cycles.',
    `manufacturer` STRING COMMENT 'Name of the engine manufacturer. Major manufacturers include CFM International, GE Aviation, Rolls-Royce, Pratt & Whitney, IAE (International Aero Engines), and Engine Alliance.. Valid values are `CFM International|GE Aviation|Rolls-Royce|Pratt & Whitney|IAE|Engine Alliance`',
    `mel_applicable` BOOLEAN COMMENT 'Indicates whether this engine has any active MEL items that allow aircraft dispatch with certain engine components inoperative under controlled conditions. True if MEL items are currently active.',
    `mel_item_count` STRING COMMENT 'Number of active MEL items currently logged against this engine. Zero indicates no MEL items. Higher counts may indicate declining engine health or deferred maintenance.',
    `model` STRING COMMENT 'Specific engine model and variant designation (e.g., CFM56-7B27, LEAP-1A26, Trent 1000, PW4000). Defines thrust rating, fuel efficiency, and maintenance program applicability.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `mro_provider` STRING COMMENT 'Name of the MRO facility or provider currently responsible for this engines maintenance, or the facility where the engine is currently undergoing shop work. May be OEM, third-party MRO, or airline in-house facility.',
    `next_shop_visit_due_date` DATE COMMENT 'Planned or forecast date when this engine is scheduled for its next major shop visit or overhaul. Based on maintenance program intervals and current utilization rates.',
    `ownership_type` STRING COMMENT 'Legal ownership and financial arrangement for this engine. Owned (airline owns outright), finance_lease (capital lease with ownership transfer), operating_lease (rental), power_by_hour (pay-per-use MRO contract), or spare_lease (short-term spare engine rental).. Valid values are `owned|finance_lease|operating_lease|power_by_hour|spare_lease`',
    `position` STRING COMMENT 'Current position of the engine. For installed engines: 1, 2, 3, or 4 (left to right facing forward). For uninstalled: spare (serviceable spare pool), shop (undergoing MRO), or QEC (Quick Engine Change kit assembly). [ENUM-REF-CANDIDATE: 1|2|3|4|spare|shop|QEC — 7 candidates stripped; promote to reference product]',
    `power_by_hour_contract` BOOLEAN COMMENT 'Indicates whether this engine is covered under a power-by-hour (PBH) or similar pay-per-use maintenance contract with the OEM or MRO provider. True if under PBH contract.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational remarks about this engine. May include historical events, special handling requirements, or configuration notes.',
    `removal_date` DATE COMMENT 'Date when this engine was last removed from an aircraft. Used to track off-wing time and shop visit intervals.',
    `thrust_rating_kn` DECIMAL(18,2) COMMENT 'Maximum certified thrust output of this engine variant measured in kilonewtons (kN). International standard unit for thrust measurement.',
    `thrust_rating_lbf` STRING COMMENT 'Maximum certified thrust output of this engine variant measured in pounds-force (lbf). Determines aircraft performance capabilities and operational limitations.',
    `tslsv_hours` DECIMAL(18,2) COMMENT 'Flight hours accumulated since the engines last major shop visit or overhaul. Resets to zero after each shop visit. Used to plan next shop visit interval.',
    `tsn_hours` DECIMAL(18,2) COMMENT 'Total flight hours accumulated by this engine since it was manufactured (Time Since New). Critical metric for life-limited parts tracking and residual value calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this engine master record was last modified. Updated whenever any attribute of the engine record changes. Used for change tracking and data synchronization.',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturers warranty coverage for this engine expires. After this date, all maintenance costs are borne by the airline or covered under separate maintenance agreements.',
    CONSTRAINT pk_engine PRIMARY KEY(`engine_id`)
) COMMENT 'Master record for each aircraft engine tracked as an independent serialized asset. Engines move between aircraft (on-wing swaps), go to MRO shops, and serve as spares — requiring independent lifecycle tracking separate from the airframe. Captures engine serial number (ESN), manufacturer (CFM International, GE Aviation, Rolls-Royce, Pratt & Whitney), engine model/variant (e.g. CFM56-7B27, LEAP-1A26), current position on aircraft (1/2/3/4 or spare/shop), current installed aircraft reference, installation date, last removal date, total flight hours since new (TSN), total cycles since new (CSN), hours since last shop visit (TSLSV), cycles since last shop visit (CSLSV), engine status (installed/spare/QEC/shop/beyond-repair/retired), thrust rating (lbf/kN), ETOPS eligibility flag, and life-limited parts (LLP) remaining cycles summary. Critical for engine shop visit planning and lease return.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` (
    `aircraft_utilization_id` BIGINT COMMENT 'Unique identifier for each daily aircraft utilization record. Primary key for the aircraft utilization ledger.',
    `aircraft_id` BIGINT COMMENT 'Foreign key reference to the aircraft master data. Links this utilization record to the specific aircraft asset.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Daily aircraft utilization drives cost allocation (fuel, crew, maintenance reserves). Finance allocates costs by aircraft to cost centres for profitability analysis, CASK calculation, and route/fleet ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Daily utilization records require station context for station-level performance reporting, cost center allocation, and operational efficiency analysis. Critical for hub vs spoke utilization comparison',
    `apu_hours` DECIMAL(18,2) COMMENT 'Total APU operating hours on this date. APU provides ground power and air conditioning when main engines are off. Tracked for APU maintenance intervals.',
    `average_daily_utilization_hours` DECIMAL(18,2) COMMENT 'Rolling 30-day average daily block hours for this aircraft, calculated as of this utilization date. Used for fleet planning and lease utilization benchmarking.',
    `block_hours` DECIMAL(18,2) COMMENT 'Total block hours flown on this date, measured from gate departure (off-blocks) to gate arrival (on-blocks). Primary utilization metric for lease agreements and maintenance planning.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality and completeness of this utilization record. Verified indicates data has been validated against multiple sources, estimated indicates calculated or interpolated values, incomplete indicates missing data elements, reconciled indicates discrepancies have been resolved.. Valid values are `verified|estimated|incomplete|reconciled`',
    `data_source` STRING COMMENT 'The source system from which this utilization data was captured. ACARS (Aircraft Communications Addressing and Reporting System) provides automated flight data, FMS (Flight Management System) provides flight planning data, AMOS (Aircraft Maintenance and Engineering System) provides maintenance records, manual indicates operator-entered data.. Valid values are `acars|fms|amos|manual`',
    `delay_minutes` STRING COMMENT 'Total delay minutes attributed to this aircraft on this date, summed across all flights. Used for OTP (On-Time Performance) analysis and aircraft reliability tracking.',
    `etops_sectors` STRING COMMENT 'Number of ETOPS-certified flight sectors operated on this date. ETOPS allows twin-engine aircraft to fly routes more than 60 minutes from the nearest suitable airport.',
    `flight_cycles` STRING COMMENT 'Total number of flight cycles (pressurization cycles) completed on this date. One cycle equals one takeoff and landing. Critical for fatigue-sensitive component maintenance.',
    `flight_hours` DECIMAL(18,2) COMMENT 'Total airborne flight hours on this date, measured from wheels-off to wheels-on. Used for airframe and engine maintenance interval calculations.',
    `fuel_burn_kg` DECIMAL(18,2) COMMENT 'Total fuel consumed (in kilograms) on this date across all flights. Used for CASK calculation and environmental reporting.',
    `ground_time_minutes` STRING COMMENT 'Total ground time (turnaround time) between flights on this date, summed across all sectors. Used for ground operations efficiency analysis.',
    `landings` STRING COMMENT 'Total number of landings performed on this date. Used for landing gear and brake maintenance tracking.',
    `mel_items_open` STRING COMMENT 'Number of open MEL items (deferred defects) at the end of this utilization date. MEL allows aircraft to operate with certain non-critical systems inoperative under specific conditions.',
    `night_flight_hours` DECIMAL(18,2) COMMENT 'Total flight hours operated during night hours (as defined by local aviation authority) on this date. Used for crew scheduling and fatigue management compliance.',
    `non_revenue_block_hours` DECIMAL(18,2) COMMENT 'Block hours flown on non-revenue flights including ferry, positioning, maintenance test flights, and crew training.',
    `operational_status` STRING COMMENT 'The operational status of the aircraft on this date. In_service indicates normal revenue operations, maintenance indicates scheduled or unscheduled maintenance, AOG (Aircraft on Ground) indicates unplanned downtime, storage indicates temporary or long-term parking, ferry indicates non-revenue positioning.. Valid values are `in_service|maintenance|aog|storage|ferry`',
    `pirep_count` STRING COMMENT 'Number of pilot-reported maintenance discrepancies logged on this date. Used for aircraft reliability trending and predictive maintenance.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this utilization record was first created in the system. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this utilization record was last modified. Used for change tracking and data quality monitoring.',
    `revenue_block_hours` DECIMAL(18,2) COMMENT 'Block hours flown on revenue-generating flights (passenger or cargo). Excludes ferry, positioning, and maintenance flights.',
    `sectors_flown` STRING COMMENT 'Total number of flight sectors (legs) operated on this date. Equivalent to number of departures.',
    `tail_number` STRING COMMENT 'The unique aircraft registration identifier (tail number) for operational reference. Denormalized from aircraft master for query performance.. Valid values are `^[A-Z0-9]{5,6}$`',
    `technical_delay_minutes` STRING COMMENT 'Delay minutes caused by technical or maintenance issues on this date. Subset of total delay minutes, used for aircraft reliability and maintenance effectiveness analysis.',
    `total_airframe_hours_tsn` DECIMAL(18,2) COMMENT 'Cumulative total airframe hours since the aircraft was manufactured, as of the end of this utilization date. Running total used for major maintenance checks and lease return conditions.',
    `total_cycles_csn` STRING COMMENT 'Cumulative total flight cycles since the aircraft was manufactured, as of the end of this utilization date. Running total used for fatigue-sensitive component tracking.',
    `utilization_date` DATE COMMENT 'The calendar date (UTC) for which this utilization record applies. Each aircraft has one record per operational day.',
    CONSTRAINT pk_aircraft_utilization PRIMARY KEY(`aircraft_utilization_id`)
) COMMENT 'Daily utilization ledger for each aircraft capturing actual operational activity — the authoritative source for airframe time and cycles used by maintenance planning, lease return monitoring, and fleet economics. Each record is keyed to aircraft + date. Stores daily block hours flown, flight hours (airborne), flight cycles completed, number of sectors, number of landings, fuel burn (kg), APU hours, and revenue vs. non-revenue (ferry/positioning) breakdown. Maintains running cumulative totals: total airframe hours since new (TSN), total cycles since new (CSN). Feeds maintenance interval calculations, CASK/RASK analytics, lease return condition tracking, and regulatory utilization reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`etops_authorization` (
    `etops_authorization_id` BIGINT COMMENT 'Unique identifier for the ETOPS authorization record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft asset that holds this ETOPS authorization. Links to the aircraft master registry in the fleet domain.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: ETOPS authorization is granted for a specific aircraft-engine type combination. etops_authorization currently stores engine_type_designator as a STRING descriptor but has no FK to aircraft_type. Addin',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: ETOPS authorizations often tied to specific maintenance stations with certified capabilities. Regulatory compliance audits and diversion planning require tracking which station holds ETOPS maintenance',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Regulatory ETOPS compliance requires linking each aircraft ETOPS authorization to the specific routes it covers. Dispatch and safety departments must verify that etops_required routes are served only ',
    `apu_etops_compliance_flag` BOOLEAN COMMENT 'Indicates whether the APU on this aircraft meets ETOPS reliability and operational standards. True if APU is ETOPS-compliant and available for in-flight use; false otherwise.',
    `audit_trail_reference` STRING COMMENT 'Reference to the audit or inspection report that validated compliance with ETOPS requirements prior to authorization issuance. May include document ID or inspection case number.',
    `authorization_status` STRING COMMENT 'Current lifecycle status of the ETOPS authorization. Active authorizations are valid for dispatch; suspended, expired, or revoked authorizations prohibit ETOPS operations.. Valid values are `active|suspended|expired|revoked|pending|withdrawn`',
    `cargo_fire_suppression_etops_flag` BOOLEAN COMMENT 'Indicates whether the cargo compartment fire suppression system meets ETOPS requirements for extended diversion times. True if compliant; false otherwise.',
    `communication_system_etops_flag` BOOLEAN COMMENT 'Indicates whether the aircraft communication systems (HF, SATCOM, ACARS) meet ETOPS requirements for extended overwater operations. True if compliant; false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ETOPS authorization record was first created in the system. Used for audit trail and data lineage.',
    `diversion_time_minutes` STRING COMMENT 'The maximum approved diversion time in minutes that the aircraft is authorized to operate from the nearest suitable alternate airport. Common values include 120, 138, 180, 207, or 240 minutes.',
    `effective_date` DATE COMMENT 'The date on which this ETOPS authorization becomes valid and the aircraft is approved to commence ETOPS operations under this authorization.',
    `electrical_system_etops_flag` BOOLEAN COMMENT 'Indicates whether the aircraft electrical power generation and distribution systems meet ETOPS redundancy standards. True if compliant; false otherwise.',
    `engine_type_designator` STRING COMMENT 'ICAO or manufacturer engine type designator for the engines installed on this aircraft under this ETOPS authorization (e.g., CFM56-7B, GE90-115B). ETOPS authorization is engine-type specific.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `expiry_date` DATE COMMENT 'The date on which this ETOPS authorization expires and is no longer valid for dispatch. Nullable for authorizations without a fixed expiry (subject to continuous compliance).',
    `fuel_system_etops_flag` BOOLEAN COMMENT 'Indicates whether the aircraft fuel system (including pumps, crossfeed, and monitoring) meets ETOPS reliability and redundancy standards. True if compliant; false otherwise.',
    `hydraulic_system_etops_flag` BOOLEAN COMMENT 'Indicates whether the aircraft hydraulic systems meet ETOPS redundancy and reliability requirements. True if compliant; false otherwise.',
    `last_compliance_verification_date` DATE COMMENT 'The date of the most recent compliance verification or audit confirming that the aircraft and operator continue to meet ETOPS standards. Used to track ongoing compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ETOPS authorization record was last updated. Tracks the most recent change to any field in the record.',
    `maintenance_program_reference` STRING COMMENT 'Reference to the approved ETOPS maintenance program document or section number that this authorization is contingent upon. Compliance with this program is mandatory for maintaining authorization validity.',
    `mel_reference` STRING COMMENT 'Reference to the specific MEL section or revision that governs ETOPS dispatch requirements for this aircraft. Identifies which equipment must be operational for ETOPS flight.',
    `navigation_system_etops_flag` BOOLEAN COMMENT 'Indicates whether the aircraft navigation systems (FMS, GPS, INS) meet ETOPS accuracy and redundancy requirements. True if compliant; false otherwise.',
    `next_compliance_review_date` DATE COMMENT 'The scheduled date for the next compliance review or audit to ensure continued ETOPS authorization validity. Nullable if no periodic review is mandated.',
    `operator_etops_experience_level` STRING COMMENT 'The operators ETOPS experience classification at the time of this authorization. Initial operators may have more restrictive conditions; advanced operators may have fewer limitations.. Valid values are `initial|intermediate|advanced`',
    `remarks` STRING COMMENT 'Additional free-text remarks, notes, or clarifications related to this ETOPS authorization. May include historical context, amendment notes, or operational guidance.',
    `special_conditions` STRING COMMENT 'Free-text field capturing any special conditions, operational limitations, or additional requirements imposed by the regulatory authority on this ETOPS authorization (e.g., seasonal restrictions, crew qualification requirements, alternate airport specifications).',
    `time_limited_system_extension_minutes` STRING COMMENT 'For certain ETOPS authorizations, the approved extension time (in minutes) for time-limited systems (e.g., cargo fire suppression discharge time). Nullable if not applicable.',
    CONSTRAINT pk_etops_authorization PRIMARY KEY(`etops_authorization_id`)
) COMMENT 'Records ETOPS (Extended-range Twin-engine Operational Performance Standards) authorization for each aircraft, specifying the approved diversion time (e.g. 120, 180, 240 minutes), the authorizing regulatory body (FAA, EASA, national CAA), authorization certificate number, effective date, expiry date, applicable route pairs or geographic areas, required maintenance program compliance references, and current authorization status (active/suspended/expired). Each aircraft may have multiple ETOPS authorizations from different regulators. Critical for long-haul twin-engine route dispatch.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`aircraft_registration` (
    `aircraft_registration_id` BIGINT COMMENT 'Unique identifier for the aircraft registration record. Primary key for this entity. Role: MASTER_RESOURCE.',
    `aircraft_id` BIGINT COMMENT 'Foreign key reference to the parent aircraft master record in the fleet domain. Links this registration record to the physical aircraft asset.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: The registered operator and owner on an aircraft registration certificate must be a legal entity for AOC compliance, insurance, and regulatory filings. registered_operator_name and registered_owner_na',
    `aircraft_category` STRING COMMENT 'The regulatory category classification of the aircraft. Transport category includes commercial passenger and cargo aircraft. General aviation includes smaller aircraft for personal or business use.. Valid values are `transport|general_aviation|aerial_work|private|experimental`',
    `airworthiness_category` STRING COMMENT 'The category of the certificate of airworthiness indicating the operational limitations and certification basis. Standard is for normal commercial operations, restricted for limited operations, provisional for temporary certification.. Valid values are `standard|restricted|limited|provisional|special`',
    `airworthiness_expiry_date` DATE COMMENT 'The date on which the current certificate of airworthiness expires. Nullable for certificates that remain valid subject to continuing airworthiness requirements.',
    `airworthiness_issue_date` DATE COMMENT 'The date on which the current certificate of airworthiness was issued by the national civil aviation authority.',
    `certificate_of_airworthiness_number` STRING COMMENT 'The unique certificate number issued by the national civil aviation authority certifying that the aircraft meets airworthiness standards and is safe to fly. Also known as C of A number.',
    `certificate_of_registration_number` STRING COMMENT 'The unique certificate number issued by the national civil aviation authority for this aircraft registration. This is the official document number proving the aircraft is registered.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this registration record was first created in the system. Used for audit trail and data lineage.',
    `export_certificate_date` DATE COMMENT 'The date on which the export certificate of airworthiness was issued by the exporting country civil aviation authority.',
    `export_certificate_number` STRING COMMENT 'The certificate number issued by the exporting country civil aviation authority when the aircraft was transferred from another jurisdiction. Required for international aircraft transfers.',
    `national_caa_name` STRING COMMENT 'The name of the national civil aviation authority that issued the registration. Examples: Federal Aviation Administration (FAA), European Union Aviation Safety Agency (EASA), Civil Aviation Authority (CAA).',
    `noise_certificate_number` STRING COMMENT 'The unique certificate number issued by the national civil aviation authority certifying that the aircraft meets noise emission standards per ICAO Annex 16. Required for commercial operations at most airports.',
    `noise_chapter_compliance` STRING COMMENT 'The ICAO Annex 16 noise certification chapter that the aircraft complies with. Chapter 4 is the most stringent current standard. Chapter 2 aircraft are banned from most airports.. Valid values are `chapter_2|chapter_3|chapter_4|chapter_14`',
    `previous_registering_country_code` STRING COMMENT 'The ICAO country code of the previous country of registration, if the aircraft was transferred from another jurisdiction.. Valid values are `^[A-Z]{2,3}$`',
    `previous_registration_mark` STRING COMMENT 'The previous registration mark (tail number) assigned to this aircraft before the current registration, if applicable. Used to track aircraft that have been re-registered or transferred between jurisdictions.',
    `registering_country_code` STRING COMMENT 'The ICAO two or three-letter country code prefix indicating the country of registration. Examples: N (USA), G (UK), D (Germany), C (Canada).. Valid values are `^[A-Z]{2,3}$`',
    `registration_date` DATE COMMENT 'The date on which the aircraft was officially registered with the national civil aviation authority. This is the effective start date of the registration.',
    `registration_expiry_date` DATE COMMENT 'The date on which the current aircraft registration expires and must be renewed. Nullable for registrations without expiry or perpetual registrations.',
    `registration_mark` STRING COMMENT 'The official registration mark (tail number) assigned by the national civil aviation authority. This is the unique identifier painted on the aircraft fuselage and tail. Also known as aircraft registration number or tail number.. Valid values are `^[A-Z0-9-]{3,10}$`',
    `registration_remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the aircraft registration. May include restrictions, special authorizations, or historical notes.',
    `registration_status` STRING COMMENT 'The current lifecycle status of the aircraft registration. Current indicates active registration, expired indicates registration has lapsed, cancelled indicates registration has been terminated, suspended indicates temporary suspension, transferred indicates registration has been moved to another jurisdiction.. Valid values are `current|expired|cancelled|suspended|transferred`',
    `registration_status_date` DATE COMMENT 'The date on which the current registration status became effective. Used to track when a registration was cancelled, suspended, or transferred.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this registration record was last modified in the system. Used for audit trail and change tracking.',
    CONSTRAINT pk_aircraft_registration PRIMARY KEY(`aircraft_registration_id`)
) COMMENT 'Official regulatory registration record for each aircraft with the national civil aviation authority. Captures registration mark (tail number), registering country (ICAO country prefix), national civil aviation authority (CAA) name, certificate of registration number, registration date, registration expiry date, registered owner name, registered operator name, aircraft category (transport/general aviation), certificate of airworthiness number, airworthiness category, noise certificate number, and registration status (current/expired/cancelled/transferred). This is the regulatory identity record for the aircraft asset.';

CREATE OR REPLACE TABLE `airlines_ecm`.`fleet`.`lessor` (
    `lessor_id` BIGINT COMMENT 'Primary key for lessor',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Lessors are external legal entities requiring formal entity registration for contract management, counterparty credit risk assessment, and regulatory reporting. Lessor registration_number and tax_iden',
    `parent_lessor_id` BIGINT COMMENT 'Self-referencing FK on lessor (parent_lessor_id)',
    `aircraft_leased_to_airline_count` STRING COMMENT 'Number of aircraft currently leased from this lessor to Airlines.',
    `business_address_line1` STRING COMMENT 'First line of the lessors registered business address (street number and name).',
    `business_address_line2` STRING COMMENT 'Second line of the lessors registered business address (suite, floor, building name).',
    `business_city` STRING COMMENT 'City of the lessors registered business address.',
    `business_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the lessors registered business address.',
    `business_postal_code` STRING COMMENT 'Postal or ZIP code of the lessors registered business address.',
    `business_state_province` STRING COMMENT 'State, province, or administrative region of the lessors registered business address.',
    `contract_end_date` DATE COMMENT 'Date when the current master lease agreement or relationship with this lessor is scheduled to end. Null for open-ended relationships.',
    `contract_start_date` DATE COMMENT 'Date when the first lease contract with this lessor became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lessor record was first created in the system.',
    `credit_rating` STRING COMMENT 'Current credit rating assigned to the lessor by recognized rating agencies (e.g., Moodys, S&P, Fitch).',
    `credit_rating_agency` STRING COMMENT 'Name of the credit rating agency that issued the credit rating.',
    `credit_rating_date` DATE COMMENT 'Date when the current credit rating was issued or last updated.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the lessors preferred invoicing and payment currency.',
    `fleet_size` STRING COMMENT 'Total number of aircraft owned by the lessor across all customers and aircraft types.',
    `headquarters_city` STRING COMMENT 'City where the lessors primary headquarters office is located.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the lessors headquarters is located.',
    `insurance_certificate_number` STRING COMMENT 'Reference number of the lessors liability insurance certificate on file with Airlines.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the lessors current liability insurance certificate.',
    `last_audit_date` DATE COMMENT 'Date of the most recent financial or operational audit conducted on the lessor by Airlines or a third-party auditor.',
    `lessor_code` STRING COMMENT 'Unique alphanumeric code assigned to the lessor for operational reference and system integration.',
    `lessor_name` STRING COMMENT 'The full legal name of the aircraft lessor organization.',
    `lessor_status` STRING COMMENT 'Current operational status of the lessor relationship in the fleet management system.',
    `lessor_type` STRING COMMENT 'Classification of the lessor based on their business model and lease structure (operating lease, finance lease, sale-leaseback, manufacturer-backed, bank-owned, or private equity).',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next financial or operational audit of the lessor.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the lessor relationship.',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for lease payments to this lessor (e.g., 30, 60, 90 days).',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether the lessor has preferred vendor status with Airlines for priority consideration in lease negotiations.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the lessor for operational communications and lease administration.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the lessor organization.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the lessors main business contact, including country code.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approvals required for the lessor to lease aircraft to Airlines in applicable jurisdictions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the lessor record was last modified in the system.',
    `website_url` STRING COMMENT 'Official website URL of the lessor organization.',
    CONSTRAINT pk_lessor PRIMARY KEY(`lessor_id`)
) COMMENT 'Master reference table for lessor. Referenced by lessor_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_lessor_id` FOREIGN KEY (`lessor_id`) REFERENCES `airlines_ecm`.`fleet`.`lessor`(`lessor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ADD CONSTRAINT `fk_fleet_cabin_configuration_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ADD CONSTRAINT `fk_fleet_cabin_configuration_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ADD CONSTRAINT `fk_fleet_seat_map_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_lessor_id` FOREIGN KEY (`lessor_id`) REFERENCES `airlines_ecm`.`fleet`.`lessor`(`lessor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_aircraft_lease_id` FOREIGN KEY (`aircraft_lease_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_lease`(`aircraft_lease_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_fleet_order_id` FOREIGN KEY (`fleet_order_id`) REFERENCES `airlines_ecm`.`fleet`.`fleet_order`(`fleet_order_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_fleet_order_id` FOREIGN KEY (`fleet_order_id`) REFERENCES `airlines_ecm`.`fleet`.`fleet_order`(`fleet_order_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_lessor_id` FOREIGN KEY (`lessor_id`) REFERENCES `airlines_ecm`.`fleet`.`lessor`(`lessor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ADD CONSTRAINT `fk_fleet_aircraft_utilization_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ADD CONSTRAINT `fk_fleet_etops_authorization_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ADD CONSTRAINT `fk_fleet_etops_authorization_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ADD CONSTRAINT `fk_fleet_aircraft_registration_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ADD CONSTRAINT `fk_fleet_lessor_parent_lessor_id` FOREIGN KEY (`parent_lessor_id`) REFERENCES `airlines_ecm`.`fleet`.`lessor`(`lessor_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`fleet` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`fleet` SET TAGS ('dbx_domain' = 'fleet');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` SET TAGS ('dbx_subdomain' = 'aircraft_registry');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Identifier');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Base Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `lessor_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `airworthiness_category` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Category');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `airworthiness_category` SET TAGS ('dbx_value_regex' = 'standard|restricted|limited|experimental|provisional');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `apu_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Manufacturer');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `apu_model` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Model');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `cabin_configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Code');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `cat_iii_ils_approved` SET TAGS ('dbx_business_glossary_term' = 'Category III Instrument Landing System (CAT III ILS) Approved');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `certificate_of_airworthiness_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Airworthiness Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `certificate_of_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Registration Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_business_glossary_term' = 'Country of Registration');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `etops_certified` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Certified');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `etops_minutes_rating` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Minutes Rating');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Production Line Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `mel_applicable` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Applicable');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `msn` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number (MSN)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `msn` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `noise_chapter` SET TAGS ('dbx_business_glossary_term' = 'Noise Chapter Classification');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `noise_chapter` SET TAGS ('dbx_value_regex' = 'chapter_2|chapter_3|chapter_4|chapter_14');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `ownership_category` SET TAGS ('dbx_business_glossary_term' = 'Ownership Category');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `ownership_category` SET TAGS ('dbx_value_regex' = 'owned|finance_lease|operating_lease|dry_lease|wet_lease_in|acmi');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `registered_operator` SET TAGS ('dbx_business_glossary_term' = 'Registered Operator');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `registered_owner` SET TAGS ('dbx_business_glossary_term' = 'Registered Owner');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `registered_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `registration_authority` SET TAGS ('dbx_business_glossary_term' = 'Registration Authority');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `registration_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `rvsm_approved` SET TAGS ('dbx_business_glossary_term' = 'Reduced Vertical Separation Minimum (RVSM) Approved');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `seating_capacity_business` SET TAGS ('dbx_business_glossary_term' = 'Business Class Seating Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `seating_capacity_economy` SET TAGS ('dbx_business_glossary_term' = 'Economy Class Seating Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `seating_capacity_first` SET TAGS ('dbx_business_glossary_term' = 'First Class Seating Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `seating_capacity_premium_economy` SET TAGS ('dbx_business_glossary_term' = 'Premium Economy Seating Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `seating_capacity_total` SET TAGS ('dbx_business_glossary_term' = 'Total Seating Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `tail_number` SET TAGS ('dbx_business_glossary_term' = 'Tail Number (Registration Mark)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `tail_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,6}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `total_block_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Block Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `total_cycles` SET TAGS ('dbx_business_glossary_term' = 'Total Flight Cycles');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` SET TAGS ('dbx_subdomain' = 'aircraft_registry');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Identifier');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `aircraft_family` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Family Designation');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `aircraft_type_status` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Status');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `aircraft_type_status` SET TAGS ('dbx_value_regex' = 'active|retired|planned|reference');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `aircraft_variant` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Variant Designation');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `apu_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Manufacturer');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `apu_model` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Model');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `cargo_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Cargo Hold Volume in Cubic Meters');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Engine Emissions Certification Standard');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `engine_count` SET TAGS ('dbx_business_glossary_term' = 'Engine Count');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `engine_model` SET TAGS ('dbx_business_glossary_term' = 'Engine Model Designation');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `engine_type` SET TAGS ('dbx_business_glossary_term' = 'Engine Type');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `engine_type` SET TAGS ('dbx_value_regex' = 'turbofan|turbojet|turboprop|piston');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `etops_baseline_minutes` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Baseline Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `etops_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Certified Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `fleet_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Fleet Entry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `fleet_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Fleet Exit Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `fuel_capacity_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Capacity in Liters');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `fuselage_length_m` SET TAGS ('dbx_business_glossary_term' = 'Fuselage Length in Meters');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `fuselage_width_category` SET TAGS ('dbx_business_glossary_term' = 'Fuselage Width Category');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `fuselage_width_category` SET TAGS ('dbx_value_regex' = 'narrowbody|widebody|regional');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `iata_type_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Type Code');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `iata_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `icao_type_code` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Type Code');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `icao_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `in_fleet_flag` SET TAGS ('dbx_business_glossary_term' = 'In Fleet Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Manufacturer Name');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `max_passenger_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Certified Passenger Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `max_range_nm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Range in Nautical Miles (NM)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `max_structural_payload_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Structural Payload (Kilograms)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `mel_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Applicable Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `mlw_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Landing Weight (MLW) in Kilograms');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `mtow_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Takeoff Weight (MTOW) in Kilograms');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `mzfw_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Zero Fuel Weight (MZFW) in Kilograms');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `noise_chapter` SET TAGS ('dbx_business_glossary_term' = 'ICAO Noise Certification Chapter');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `noise_chapter` SET TAGS ('dbx_value_regex' = 'Chapter 2|Chapter 3|Chapter 4|Chapter 14');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `typical_block_fuel_per_hour_kg` SET TAGS ('dbx_business_glossary_term' = 'Typical Block Fuel Consumption per Hour (Kilograms)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `typical_cruise_speed_mach` SET TAGS ('dbx_business_glossary_term' = 'Typical Cruise Speed (Mach Number)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `typical_range_nm` SET TAGS ('dbx_business_glossary_term' = 'Typical Range in Nautical Miles (NM)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `wake_turbulence_category` SET TAGS ('dbx_business_glossary_term' = 'Wake Turbulence Category');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `wake_turbulence_category` SET TAGS ('dbx_value_regex' = 'L|M|H|J');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type` ALTER COLUMN `wingspan_m` SET TAGS ('dbx_business_glossary_term' = 'Wingspan in Meters');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` SET TAGS ('dbx_subdomain' = 'cabin_inventory');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `business_class_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Business Class Seat Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `business_class_seat_pitch_inches` SET TAGS ('dbx_business_glossary_term' = 'Business Class Seat Pitch (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `business_class_seat_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Business Class Seat Width (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `cabin_class_count` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired|maintenance');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `door_count` SET TAGS ('dbx_business_glossary_term' = 'Door Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `economy_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Economy Seat Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `economy_seat_pitch_inches` SET TAGS ('dbx_business_glossary_term' = 'Economy Seat Pitch (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `economy_seat_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Economy Seat Width (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `first_class_seat_count` SET TAGS ('dbx_business_glossary_term' = 'First Class Seat Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `first_class_seat_pitch_inches` SET TAGS ('dbx_business_glossary_term' = 'First Class Seat Pitch (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `first_class_seat_width_inches` SET TAGS ('dbx_business_glossary_term' = 'First Class Seat Width (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `galley_count` SET TAGS ('dbx_business_glossary_term' = 'Galley Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `ife_system_type` SET TAGS ('dbx_business_glossary_term' = 'In-Flight Entertainment (IFE) System Type');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `lavatory_count` SET TAGS ('dbx_business_glossary_term' = 'Lavatory Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `lie_flat_seat_available` SET TAGS ('dbx_business_glossary_term' = 'Lie-Flat Seat Available');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `overwing_exit_count` SET TAGS ('dbx_business_glossary_term' = 'Overwing Exit Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `power_outlet_availability` SET TAGS ('dbx_business_glossary_term' = 'Power Outlet Availability');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `power_outlet_availability` SET TAGS ('dbx_value_regex' = 'none|selected_seats|all_seats');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `premium_economy_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Premium Economy Seat Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `premium_economy_seat_pitch_inches` SET TAGS ('dbx_business_glossary_term' = 'Premium Economy Seat Pitch (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `premium_economy_seat_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Premium Economy Seat Width (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `seat_map_reference` SET TAGS ('dbx_business_glossary_term' = 'Seat Map Reference');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `total_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Total Seat Count');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `wifi_available` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Available');
ALTER TABLE `airlines_ecm`.`fleet`.`cabin_configuration` ALTER COLUMN `wifi_provider` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Provider');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` SET TAGS ('dbx_subdomain' = 'cabin_inventory');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_map_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Map Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Configuration Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Block Reason');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `block_reason` SET TAGS ('dbx_value_regex' = 'crew_rest|broken|maintenance|weight_balance|social_distancing|vip_buffer|[ENUM-REF-CANDIDATE: crew_rest|broken|maintenance|weight_balance|social_distancing|vip_buffer|operational|regulatory — promote to reference product]');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `column_letter` SET TAGS ('dbx_business_glossary_term' = 'Column Letter');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `column_letter` SET TAGS ('dbx_value_regex' = '^[A-K]$');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `deck` SET TAGS ('dbx_business_glossary_term' = 'Deck Level');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `deck` SET TAGS ('dbx_value_regex' = 'main|upper|lower');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `galley_proximity` SET TAGS ('dbx_business_glossary_term' = 'Galley Proximity');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `galley_proximity` SET TAGS ('dbx_value_regex' = 'none|adjacent|near|far');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `has_ife` SET TAGS ('dbx_business_glossary_term' = 'In-Flight Entertainment (IFE) Availability');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `ife_screen_size_inches` SET TAGS ('dbx_business_glossary_term' = 'In-Flight Entertainment (IFE) Screen Size (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_accessible` SET TAGS ('dbx_business_glossary_term' = 'Accessible Seat Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_bassinet_capable` SET TAGS ('dbx_business_glossary_term' = 'Bassinet Capable Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Seat Blocked Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_bulkhead` SET TAGS ('dbx_business_glossary_term' = 'Bulkhead Seat Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_crew_rest` SET TAGS ('dbx_business_glossary_term' = 'Crew Rest Seat Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_exit_row` SET TAGS ('dbx_business_glossary_term' = 'Exit Row Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_last_row` SET TAGS ('dbx_business_glossary_term' = 'Last Row Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_overwing` SET TAGS ('dbx_business_glossary_term' = 'Overwing Seat Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `is_preferred_seat` SET TAGS ('dbx_business_glossary_term' = 'Preferred Seat Indicator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `lavatory_proximity` SET TAGS ('dbx_business_glossary_term' = 'Lavatory Proximity');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `lavatory_proximity` SET TAGS ('dbx_value_regex' = 'none|adjacent|near|far');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `power_outlet_type` SET TAGS ('dbx_business_glossary_term' = 'Power Outlet Type');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `power_outlet_type` SET TAGS ('dbx_value_regex' = 'none|ac_110v|ac_220v|usb_a|usb_c|both_ac_usb');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `recline_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Recline Angle (Degrees)');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `recline_type` SET TAGS ('dbx_business_glossary_term' = 'Recline Type');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `recline_type` SET TAGS ('dbx_value_regex' = 'none|limited|standard|enhanced|lie_flat|angle_flat');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `row_number` SET TAGS ('dbx_business_glossary_term' = 'Row Number');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_designator` SET TAGS ('dbx_business_glossary_term' = 'Seat Designator');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_designator` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{0,2}[A-K]$');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_fee_tier` SET TAGS ('dbx_business_glossary_term' = 'Seat Fee Tier');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_fee_tier` SET TAGS ('dbx_value_regex' = 'standard|preferred|extra_legroom|premium|exit_row');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_map_status` SET TAGS ('dbx_business_glossary_term' = 'Seat Map Status');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_map_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_pitch_inches` SET TAGS ('dbx_business_glossary_term' = 'Seat Pitch (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_type` SET TAGS ('dbx_business_glossary_term' = 'Seat Type');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_type` SET TAGS ('dbx_value_regex' = 'window|middle|aisle');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `seat_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Seat Width (Inches)');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `storage_restriction` SET TAGS ('dbx_business_glossary_term' = 'Storage Restriction');
ALTER TABLE `airlines_ecm`.`fleet`.`seat_map` ALTER COLUMN `storage_restriction` SET TAGS ('dbx_value_regex' = 'none|no_underseat|limited_overhead|both');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` SET TAGS ('dbx_subdomain' = 'fleet_acquisition');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `fleet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Order Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `lessor_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `cabin_configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Code');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `cancellation_penalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Penalty (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `cancellation_penalty_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'oem|lessor|broker');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `delivery_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `delivery_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `deposit_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `deposit_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `engine_type` SET TAGS ('dbx_business_glossary_term' = 'Engine Type');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `financing_structure` SET TAGS ('dbx_business_glossary_term' = 'Financing Structure');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `financing_structure` SET TAGS ('dbx_value_regex' = 'cash|debt_financing|sale_leaseback|operating_lease|finance_lease|hybrid');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `list_price_per_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'List Price Per Unit (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `list_price_per_unit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `negotiated_price_per_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Price Per Unit (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `negotiated_price_per_unit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `option_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Option Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Placement Date');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'firm|option|letter_of_intent|cancelled|converted|delivered');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Order Purpose');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'fleet_growth|fleet_replacement|fleet_renewal|capacity_expansion|route_expansion');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `quantity_cancelled` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `quantity_firm` SET TAGS ('dbx_business_glossary_term' = 'Firm Order Quantity');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `quantity_loi` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Quantity');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `quantity_option` SET TAGS ('dbx_business_glossary_term' = 'Option Order Quantity');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Order Reference Number');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `total_order_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `total_order_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ALTER COLUMN `total_seat_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Seat Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` SET TAGS ('dbx_subdomain' = 'fleet_acquisition');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `aircraft_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Delivery Identifier');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Identifier');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `aircraft_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Lease Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `fleet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `acceptance_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Certificate Reference Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `acceptance_certificate_reference` SET TAGS ('dbx_value_regex' = '^ACC-[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `airframe_cycles_at_delivery` SET TAGS ('dbx_business_glossary_term' = 'Airframe Total Cycles at Delivery');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `airframe_hours_at_delivery` SET TAGS ('dbx_business_glossary_term' = 'Airframe Total Hours at Delivery');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `apu_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Serial Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `apu_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Delivery Condition');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_value_regex' = 'new|used|refurbished|pre-owned');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Delivery Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Ferry Flight Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Transaction Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_value_regex' = '^DEL-[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Transaction Status');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_transit|accepted|rejected|cancelled|deferred');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Delivery Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_1_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Engine Position 1 Serial Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_1_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_2_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Engine Position 2 Serial Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_2_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_3_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Engine Position 3 Serial Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_3_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_4_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Engine Position 4 Serial Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `engine_4_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `etops_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Certification Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `etops_rating_minutes` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Rating in Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `mel_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Applicable Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `msn` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number (MSN)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `msn` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Ownership Type');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|wet_lease|dry_lease|acmi|finance_lease|operating_lease');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `tail_number` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Tail Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `tail_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}-[A-Z0-9]{3,5}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `technical_acceptance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Technical Acceptance Inspection Outcome');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `technical_acceptance_outcome` SET TAGS ('dbx_value_regex' = 'accepted|accepted_with_conditions|rejected|deferred');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `total_seat_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Seat Capacity');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` SET TAGS ('dbx_subdomain' = 'fleet_acquisition');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `aircraft_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Lease Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `fleet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Lessee Entity Identifier (ID)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lessor_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `early_termination_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Clause Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `early_termination_penalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Penalty (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `early_termination_penalty_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `extension_option_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Available Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `extension_option_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Duration (Months)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `insurance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Insurance Responsibility');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `insurance_responsibility` SET TAGS ('dbx_value_regex' = 'lessor|lessee|shared');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Lease Currency Code');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Execution Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'dry_lease|wet_lease|acmi|damp_lease');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `maintenance_reserve_rate_per_cycle` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Reserve Rate per Cycle');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `maintenance_reserve_rate_per_cycle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `maintenance_reserve_rate_per_fh` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Reserve Rate per Flight Hour (FH)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `maintenance_reserve_rate_per_fh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'lessor|lessee|shared');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `monthly_rental_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Rental Rate (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `monthly_rental_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `redelivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Redelivery Location Code');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `redelivery_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `return_condition_max_cycles` SET TAGS ('dbx_business_glossary_term' = 'Return Condition Maximum Cycles');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `return_condition_max_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Return Condition Maximum Flight Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `security_deposit_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ALTER COLUMN `security_deposit_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` SET TAGS ('dbx_subdomain' = 'cabin_inventory');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Identifier');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Identifier');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Current Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Engine Acquisition Cost');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Engine Acquisition Date');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `cslsv_cycles` SET TAGS ('dbx_business_glossary_term' = 'Cycles Since Last Shop Visit (CSLSV)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `csn_cycles` SET TAGS ('dbx_business_glossary_term' = 'Cycles Since New (CSN)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Engine Current Book Value');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `current_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `engine_status` SET TAGS ('dbx_business_glossary_term' = 'Engine Operational Status');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `esn` SET TAGS ('dbx_business_glossary_term' = 'Engine Serial Number (ESN)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `esn` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `etops_eligible` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Eligible');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `etops_rating_minutes` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Rating Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Engine Installation Date');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `last_shop_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Shop Visit Date');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `last_shop_visit_type` SET TAGS ('dbx_business_glossary_term' = 'Last Shop Visit Type');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `last_shop_visit_type` SET TAGS ('dbx_value_regex' = 'performance_restoration|life_limited_parts_replacement|hot_section_inspection|full_overhaul');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Engine Lease Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `lease_return_condition` SET TAGS ('dbx_business_glossary_term' = 'Engine Lease Return Condition Requirements');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `lease_return_condition` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `llp_lowest_remaining_cycles` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Parts (LLP) Lowest Remaining Cycles');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `llp_summary` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Parts (LLP) Summary');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Engine Manufacturer');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `manufacturer` SET TAGS ('dbx_value_regex' = 'CFM International|GE Aviation|Rolls-Royce|Pratt & Whitney|IAE|Engine Alliance');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `mel_applicable` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Applicable');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `mel_item_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Item Count');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Engine Model and Variant');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `model` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `mro_provider` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Repair and Overhaul (MRO) Provider');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `next_shop_visit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Shop Visit Due Date');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Engine Ownership Type');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|finance_lease|operating_lease|power_by_hour|spare_lease');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Engine Position');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `power_by_hour_contract` SET TAGS ('dbx_business_glossary_term' = 'Power-by-Hour Contract Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Engine Remarks');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Engine Removal Date');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `thrust_rating_kn` SET TAGS ('dbx_business_glossary_term' = 'Thrust Rating (Kilonewtons)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `thrust_rating_lbf` SET TAGS ('dbx_business_glossary_term' = 'Thrust Rating (Pounds-Force)');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `tslsv_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Since Last Shop Visit (TSLSV) Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `tsn_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Time Since New (TSN) Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Engine Warranty Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` SET TAGS ('dbx_subdomain' = 'cabin_inventory');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `aircraft_utilization_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Utilization ID');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `apu_hours` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `average_daily_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Utilization Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `block_hours` SET TAGS ('dbx_business_glossary_term' = 'Block Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|incomplete|reconciled');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'acars|fms|amos|manual');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Delay Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `etops_sectors` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Sectors');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Flight Cycles');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Flight Hours (Airborne)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `fuel_burn_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Burn (Kilograms)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `ground_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Ground Time Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `landings` SET TAGS ('dbx_business_glossary_term' = 'Number of Landings');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `mel_items_open` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Items Open');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `night_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Night Flight Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `non_revenue_block_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Block Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|maintenance|aog|storage|ferry');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `pirep_count` SET TAGS ('dbx_business_glossary_term' = 'Pilot Report (PIREP) Count');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `revenue_block_hours` SET TAGS ('dbx_business_glossary_term' = 'Revenue Block Hours');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `sectors_flown` SET TAGS ('dbx_business_glossary_term' = 'Sectors Flown');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `tail_number` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Tail Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `tail_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,6}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `technical_delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Technical Delay Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `total_airframe_hours_tsn` SET TAGS ('dbx_business_glossary_term' = 'Total Airframe Hours Time Since New (TSN)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `total_cycles_csn` SET TAGS ('dbx_business_glossary_term' = 'Total Cycles Since New (CSN)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ALTER COLUMN `utilization_date` SET TAGS ('dbx_business_glossary_term' = 'Utilization Date');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` SET TAGS ('dbx_subdomain' = 'aircraft_registry');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `etops_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Authorization ID');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `apu_etops_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'APU (Auxiliary Power Unit) ETOPS (Extended-range Twin-engine Operational Performance Standards) Compliance Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Authorization Status');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending|withdrawn');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `cargo_fire_suppression_etops_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Fire Suppression ETOPS (Extended-range Twin-engine Operational Performance Standards) Compliance Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `communication_system_etops_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication System ETOPS (Extended-range Twin-engine Operational Performance Standards) Compliance Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `diversion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Approved Diversion Time in Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Authorization Effective Date');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `electrical_system_etops_flag` SET TAGS ('dbx_business_glossary_term' = 'Electrical System ETOPS (Extended-range Twin-engine Operational Performance Standards) Compliance Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `engine_type_designator` SET TAGS ('dbx_business_glossary_term' = 'Engine Type Designator');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `engine_type_designator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Authorization Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `fuel_system_etops_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel System ETOPS (Extended-range Twin-engine Operational Performance Standards) Compliance Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `hydraulic_system_etops_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic System ETOPS (Extended-range Twin-engine Operational Performance Standards) Compliance Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `last_compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Verification Date');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `maintenance_program_reference` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Maintenance Program Reference');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `mel_reference` SET TAGS ('dbx_business_glossary_term' = 'MEL (Minimum Equipment List) Reference for ETOPS (Extended-range Twin-engine Operational Performance Standards)');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `navigation_system_etops_flag` SET TAGS ('dbx_business_glossary_term' = 'Navigation System ETOPS (Extended-range Twin-engine Operational Performance Standards) Compliance Flag');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `operator_etops_experience_level` SET TAGS ('dbx_business_glossary_term' = 'Operator ETOPS (Extended-range Twin-engine Operational Performance Standards) Experience Level');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `operator_etops_experience_level` SET TAGS ('dbx_value_regex' = 'initial|intermediate|advanced');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions or Limitations');
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ALTER COLUMN `time_limited_system_extension_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time-Limited System Extension Minutes');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` SET TAGS ('dbx_subdomain' = 'aircraft_registry');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `aircraft_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration ID');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Registered Operator Legal Entity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `aircraft_category` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Category');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `aircraft_category` SET TAGS ('dbx_value_regex' = 'transport|general_aviation|aerial_work|private|experimental');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `airworthiness_category` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Category');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `airworthiness_category` SET TAGS ('dbx_value_regex' = 'standard|restricted|limited|provisional|special');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `airworthiness_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `airworthiness_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Issue Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `certificate_of_airworthiness_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Airworthiness (C of A) Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `certificate_of_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Registration Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `export_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Export Certificate Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `export_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Export Certificate of Airworthiness Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `national_caa_name` SET TAGS ('dbx_business_glossary_term' = 'National Civil Aviation Authority (CAA) Name');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `noise_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Noise Certificate Number');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `noise_chapter_compliance` SET TAGS ('dbx_business_glossary_term' = 'Noise Chapter Compliance');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `noise_chapter_compliance` SET TAGS ('dbx_value_regex' = 'chapter_2|chapter_3|chapter_4|chapter_14');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `previous_registering_country_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Registering Country Code');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `previous_registering_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `previous_registration_mark` SET TAGS ('dbx_business_glossary_term' = 'Previous Registration Mark');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registering_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registering Country Code (ICAO Country Prefix)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registering_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiry Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_mark` SET TAGS ('dbx_business_glossary_term' = 'Registration Mark (Tail Number)');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_mark` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,10}$');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_remarks` SET TAGS ('dbx_business_glossary_term' = 'Registration Remarks');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'current|expired|cancelled|suspended|transferred');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `registration_status_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Status Date');
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` SET TAGS ('dbx_subdomain' = 'fleet_acquisition');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `lessor_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Identifier');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `parent_lessor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
