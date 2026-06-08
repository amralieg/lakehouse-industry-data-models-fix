-- Schema for Domain: flight | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`flight` COMMENT 'Core flight operations data covering flight planning, dispatch releases, OOOI events (Out-Off-On-In gate times), block hours, fuel uplift, ACARS messaging, FMS data, operational control, flight schedules, actual departures and arrivals, delays, diversions, IROP handling, and real-time flight status. SSOT for all flight execution data. Aligns with Lufthansa Systems NetLine/Ops and Jeppesen Flight Planning System.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`scheduled_flight` (
    `scheduled_flight_id` BIGINT COMMENT 'Unique identifier for the scheduled flight record. Primary key for the scheduled flight master data.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Schedule planning systems require aircraft type master data (seating capacity, range, performance) to validate route feasibility and publish accurate capacity. aircraft_type_code is denormalized looku',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Airlines publish seat inventory and booking classes against a specific cabin configuration per scheduled flight. Revenue management, GDS distribution, and seat map display all require resolving the ex',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to route.fleet_assignment. Business justification: Schedule build and fleet planning require tracing each scheduled_flight back to the fleet_assignment decision that drove it. Network planners and revenue management teams reference fleet assignments f',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: GDS distribution, codeshare setup, and revenue management class assignment all require linking a scheduled_flight to its authoritative flight_number record. flight_leg already has this FK; scheduled_f',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to route.carrier. Business justification: Codeshare operations, GDS distribution, and interline settlement require identifying the marketing carrier on a scheduled_flight. Role prefix marketing_ distinguishes from operating carrier. marketi',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Scheduled flights operate on defined routes. This FK links the flight schedule to the route master for schedule planning, slot coordination, and network analysis.',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Schedule planning, IATA slot coordination, and OAG filing all require associating each scheduled_flight with its IATA schedule season. Aviation planners and slot coordinators always work within a seas',
    `slot_id` BIGINT COMMENT 'Foreign key linking to airport.slot. Business justification: IATA slot coordination requires each scheduled flight service to be assigned a specific airport slot. Schedule planning teams link scheduled flights to allocated slots for season filing, historic prec',
    `arrival_airport_code` STRING COMMENT 'Three-letter IATA airport code for the scheduled arrival airport (e.g., LAX, CDG, SIN).. Valid values are `^[A-Z]{3}$`',
    `arrival_terminal` STRING COMMENT 'Scheduled arrival terminal identifier at the destination airport (e.g., Terminal 2, T5, Concourse A).',
    `block_time_minutes` STRING COMMENT 'Planned block time in minutes from gate departure (Out) to gate arrival (In). This is the scheduled elapsed time for the flight leg.',
    `codeshare_indicator` BOOLEAN COMMENT 'Flag indicating whether this scheduled flight is part of a codeshare agreement where multiple airlines market the same flight operation. True if codeshare, false if single-carrier operation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scheduled flight record was first created in the system. Audit field for data lineage and compliance.',
    `day_of_week_pattern` STRING COMMENT 'Seven-character string indicating which days of the week the flight operates (1=operates, 0=does not operate). Position 1=Monday through position 7=Sunday (e.g., 1111100 = Monday-Friday only).. Valid values are `^[0-7]{7}$`',
    `departure_airport_code` STRING COMMENT 'Three-letter IATA airport code for the scheduled departure airport (e.g., JFK, LHR, DXB).. Valid values are `^[A-Z]{3}$`',
    `departure_terminal` STRING COMMENT 'Scheduled departure terminal identifier at the origin airport (e.g., Terminal 1, T3, Concourse B).',
    `effective_from_date` DATE COMMENT 'The first date this scheduled flight is valid and may operate. Start of the schedule validity period.',
    `effective_until_date` DATE COMMENT 'The last date this scheduled flight is valid and may operate. End of the schedule validity period. Nullable for open-ended schedules.',
    `etops_approval_indicator` BOOLEAN COMMENT 'Flag indicating whether this scheduled flight route requires ETOPS certification for twin-engine aircraft operations over extended distances from diversion airports. True if ETOPS-certified route required.',
    `flight_distance_km` DECIMAL(18,2) COMMENT 'Great circle distance between departure and arrival airports in kilometers. Used for RPK and ASK calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scheduled flight record was last updated. Audit field for change tracking and data quality monitoring.',
    `meal_service_code` STRING COMMENT 'Single-character IATA code indicating the type of meal service provided: B=Breakfast, L=Lunch, D=Dinner, S=Snack, M=Meal (unspecified), N=No meal service.. Valid values are `^[A-Z]{1}$`',
    `minimum_connecting_time_minutes` STRING COMMENT 'Minimum time in minutes required for passengers to make a legal connection from this flight to another flight at the arrival airport. Varies by airport, terminal, and connection type (domestic-domestic, domestic-international, international-international).',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier actually operating the flight (e.g., AA for American Airlines, BA for British Airways).. Valid values are `^[A-Z0-9]{2}$`',
    `published_date` DATE COMMENT 'Date when this scheduled flight was first published to Global Distribution Systems (GDS) and made available for booking. Critical for revenue management and distribution.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval from civil aviation authorities for this scheduled flight route and slot allocation: approved (fully authorized), pending (awaiting approval), conditional (approved with restrictions), or denied (not authorized).. Valid values are `approved|pending|conditional|denied`',
    `route_network_type` STRING COMMENT 'Classification of the scheduled flight within the airlines route network strategy: hub_spoke (connecting through a hub), point_to_point (direct city-pair), regional_feeder (short-haul feed to hub), long_haul_international (intercontinental), or domestic_trunk (major domestic route).. Valid values are `hub_spoke|point_to_point|regional_feeder|long_haul_international|domestic_trunk`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the scheduled flight: active (currently operating), suspended (temporarily not operating), cancelled (permanently removed), seasonal_inactive (out of season), or pending_approval (awaiting regulatory approval).. Valid values are `active|suspended|cancelled|seasonal_inactive|pending_approval`',
    `schedule_version_number` STRING COMMENT 'Version number of this schedule record. Incremented each time the scheduled flight details are modified (time changes, equipment changes, etc.). Supports schedule change tracking and audit.',
    `scheduled_arrival_time` TIMESTAMP COMMENT 'Published scheduled arrival time in local airport time. This is the planned gate arrival time (In time in OOOI).',
    `scheduled_departure_time` TIMESTAMP COMMENT 'Published scheduled departure time in local airport time. This is the planned gate departure time (Out time in OOOI).',
    `service_type` STRING COMMENT 'Classification of the flight service: passenger (revenue passenger service), cargo (freight-only), ferry (non-revenue repositioning), charter (non-scheduled charter), or positioning (crew/aircraft repositioning).. Valid values are `passenger|cargo|ferry|charter|positioning`',
    `traffic_restriction_code` STRING COMMENT 'IATA traffic restriction code indicating any limitations on passenger or cargo carriage (e.g., C=Cargo only, G=Technical stop no traffic rights, F=Passenger service only). Empty if no restrictions.',
    `wet_lease_indicator` BOOLEAN COMMENT 'Flag indicating whether this scheduled flight is operated under a wet lease agreement (aircraft leased with crew, maintenance, and insurance from another carrier). True if wet lease operation.',
    CONSTRAINT pk_scheduled_flight PRIMARY KEY(`scheduled_flight_id`)
) COMMENT 'Master record for a planned flight operation as published in the airlines schedule. Represents the canonical scheduled flight leg with planned route, aircraft type, departure/arrival airports, scheduled times (STD/STA), flight number, codeshare indicators, operating carrier, service type (passenger/cargo/ferry), day-of-week frequency pattern, season validity (IATA summer/winter), and schedule status (active/suspended/cancelled). SSOT for all planned flight operations prior to day-of-operations. Each operated flight_leg references exactly one scheduled_flight as its planned baseline.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`flight_leg` (
    `flight_leg_id` BIGINT COMMENT 'Unique identifier for the flight leg. Primary key for the operational instance of a single flight leg.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Flight legs are operated by specific aircraft. While aircraft_registration exists, linking to the aircraft master (aircraft_id) enables access to full aircraft details (ownership, configuration, maint',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: The actual operated cabin configuration on a flight leg drives load factor reporting, seat map availability for check-in, and revenue accounting by cabin class. Operations control must know the exact ',
    `codeshare_agreement_id` BIGINT COMMENT 'Foreign key linking to route.codeshare_agreement. Business justification: When a flight_leg is operated under a codeshare, the specific codeshare_agreement governs revenue sharing percentages, GDS inventory control, and liability allocation. Operations and revenue accountin',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Flight operations must be attributed to legal entity for financial consolidation, regulatory reporting (DOT Form 41, IATA financial statements), intercompany revenue/cost allocation, and tax complianc',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Operational flights must validate against flight number registry for codeshare agreement compliance, slot allocation verification, GDS distribution rules, and traffic rights validation. Flight operati',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to route.carrier. Business justification: Wet-lease operations, DOT carrier reporting, and IOSA audit trails require identifying the operating carrier on each flight_leg via a proper FK. Role prefix operating_ is required as flight_leg may ',
    `scheduled_flight_id` BIGINT COMMENT 'Reference to the planned baseline flight schedule for comparison of planned versus actual operations.',
    `actual_arrival_time` TIMESTAMP COMMENT 'The actual time the aircraft arrived at the gate (In time in OOOI), in local airport timezone.',
    `actual_departure_time` TIMESTAMP COMMENT 'The actual time the aircraft departed the gate (Out time in OOOI), in local airport timezone.',
    `airborne_time_hours` DECIMAL(18,2) COMMENT 'Total time the aircraft was airborne, from wheels-off (Off) to wheels-on (On), measured in hours.',
    `aircraft_registration` STRING COMMENT 'The unique aircraft registration number (tail number) assigned to the aircraft operating this flight leg.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `arrival_terminal` STRING COMMENT 'The terminal identifier at the destination airport where the flight arrived.. Valid values are `^[A-Z0-9]{1,3}$`',
    `block_hours` DECIMAL(18,2) COMMENT 'Total elapsed time from gate departure (Out) to gate arrival (In), measured in hours. Key metric for flight operations and crew duty time.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason for flight cancellation (e.g., weather, mechanical, crew, operational).. Valid values are `^[A-Z]{2,4}$`',
    `delay_code` STRING COMMENT 'IATA standard two-digit delay code indicating the primary reason for any departure or arrival delay.. Valid values are `^[0-9]{2}$`',
    `delay_minutes` STRING COMMENT 'Total delay time in minutes, calculated as the difference between scheduled and actual departure or arrival time.',
    `departure_terminal` STRING COMMENT 'The terminal identifier at the origin airport from which the flight departed.. Valid values are `^[A-Z0-9]{1,3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the arrival airport of this flight leg.. Valid values are `^[A-Z]{3}$`',
    `dispatch_release_number` STRING COMMENT 'Unique identifier for the dispatch release document authorizing this flight leg to operate, issued by flight dispatch.. Valid values are `^[A-Z0-9]{6,15}$`',
    `diversion_airport_code` STRING COMMENT 'Three-letter IATA airport code for the alternate airport if the flight was diverted from its original destination.. Valid values are `^[A-Z]{3}$`',
    `estimated_arrival_time` TIMESTAMP COMMENT 'The current estimated arrival time, updated based on operational conditions. ETA is the best current estimate of when the flight will arrive.',
    `estimated_departure_time` TIMESTAMP COMMENT 'The current estimated departure time, updated based on operational conditions. ETD is the best current estimate of when the flight will depart.',
    `flight_status` STRING COMMENT 'Current operational status of the flight leg in its lifecycle. Tracks progression from scheduled through boarding, departure, airborne, landing, arrival, or exceptional states like cancelled or diverted. [ENUM-REF-CANDIDATE: scheduled|boarding|departed|airborne|landed|arrived|cancelled|diverted — 8 candidates stripped; promote to reference product]',
    `flight_status_timestamp` TIMESTAMP COMMENT 'The timestamp when the current flight status was last updated, in UTC.',
    `fuel_uplift_kg` DECIMAL(18,2) COMMENT 'The amount of fuel loaded onto the aircraft for this flight leg, measured in kilograms.',
    `in_time` TIMESTAMP COMMENT 'The time the aircraft arrived at the gate and parking brake was set. Fourth event in OOOI (Out-Off-On-In) sequence.',
    `is_codeshare` BOOLEAN COMMENT 'Indicates whether this flight leg is operated as a codeshare with one or more partner airlines.',
    `off_time` TIMESTAMP COMMENT 'The time the aircraft wheels left the ground at takeoff. Second event in OOOI (Out-Off-On-In) sequence.',
    `on_time` TIMESTAMP COMMENT 'The time the aircraft wheels touched down on the runway at landing. Third event in OOOI (Out-Off-On-In) sequence.',
    `operating_date` DATE COMMENT 'The date on which this flight leg is operated or planned to be operated, in local departure timezone.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the departure airport of this flight leg.. Valid values are `^[A-Z]{3}$`',
    `out_time` TIMESTAMP COMMENT 'The time the aircraft pushed back from the gate or began taxi for departure. First event in OOOI (Out-Off-On-In) sequence.',
    `public_status_message` STRING COMMENT 'Customer-facing status message displayed on airport FIDS, mobile apps, and passenger notifications describing the current flight status.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this flight leg record was first created in the system, in UTC.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this flight leg record was last modified, in UTC.',
    `scheduled_arrival_time` TIMESTAMP COMMENT 'The originally scheduled arrival time for this flight leg, in local airport timezone.',
    `scheduled_departure_time` TIMESTAMP COMMENT 'The originally scheduled departure time for this flight leg, in local airport timezone.',
    `status_source` STRING COMMENT 'The source system or feed that provided the current flight status update (ACARS, ATC feed, airport FIDS, manual OCC update, GDS, NetLine/Ops).. Valid values are `acars|atc_feed|airport_fids|manual_occ|gds|netline_ops`',
    CONSTRAINT pk_flight_leg PRIMARY KEY(`flight_leg_id`)
) COMMENT 'Operational instance of a single flight leg actually operated or planned to be operated on a specific date. The atomic unit of flight execution and the central hub entity of the flight domain. Contains actual flight number, operating date, origin/destination airport pair, aircraft registration (tail number), cabin configuration, full flight status lifecycle with history (scheduled → boarding → departed → airborne → landed → arrived, or cancelled/diverted), status change timestamps with source attribution (ACARS, ATC feed, airport FIDS, manual OCC update), all OOOI timestamps (Out-Off-On-In), computed block hours and airborne time, estimated and actual departure/arrival times (ETD/ETA/ATD/ATA), gate/stand information, and public-facing status message. Links to scheduled_flight for planned baseline comparison. All operational flight records (dispatch, fuel, delays, performance) reference this entity. Supports real-time passenger notifications, airport FIDS integration, and OCC monitoring via NetLine/Ops.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`dispatch_release` (
    `dispatch_release_id` BIGINT COMMENT 'Unique identifier for the dispatch release document. Primary key for the dispatch release entity.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: A dispatch release is issued for a specific tail number; MEL item acceptance, structural weight limits, and ETOPS authorization are all aircraft-specific. FAA/EASA regulations require the dispatch rel',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Dispatch releases are issued by the dispatcher at the departure station and are subject to station-specific regulatory authority oversight. Linking to station enables station-level dispatch audit repo',
    `etops_authorization_id` BIGINT COMMENT 'Foreign key linking to fleet.etops_authorization. Business justification: Dispatchers must verify and record the specific ETOPS authorization used when releasing an ETOPS flight. FAA/EASA regulations require traceability from the dispatch release to the valid authorization.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg that this dispatch release authorizes for departure.',
    `member_id` BIGINT COMMENT 'Reference to the pilot-in-command (captain) who accepted and co-signed this dispatch release.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to flight.flight_plan. Business justification: Dispatch release is based on and references a specific flight plan version. The dispatcher reviews the flight plan and issues the release authorizing departure. This is a core operational relationship',
    `release_id` BIGINT COMMENT 'Foreign key linking to maintenance.release. Business justification: Dispatchers must verify the maintenance CRS before issuing a dispatch release — a direct regulatory requirement under Part 121. Linking dispatch_release.release_id → maintenance.release.release_id rep',
    `superseded_by_release_dispatch_release_id` BIGINT COMMENT 'Reference to the dispatch release that superseded this one, if applicable. Used to track release amendment history.',
    `aircraft_type` STRING COMMENT 'ICAO aircraft type designator for the aircraft assigned to this flight (e.g., B738, A320, B77W).. Valid values are `^[A-Z0-9]{3,10}$`',
    `alternate_airport_1_icao` STRING COMMENT 'Four-letter ICAO code of the primary alternate airport designated in case destination is unavailable.. Valid values are `^[A-Z]{4}$`',
    `alternate_airport_2_icao` STRING COMMENT 'Four-letter ICAO code of the secondary alternate airport if required by operational conditions or regulations.. Valid values are `^[A-Z]{4}$`',
    `alternate_fuel_kg` DECIMAL(18,2) COMMENT 'Fuel required to fly from destination to the designated alternate airport, measured in kilograms.',
    `captain_name` STRING COMMENT 'Full name of the pilot-in-command who accepted this dispatch release.',
    `captain_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the captain electronically accepted and co-signed the dispatch release, indicating agreement with flight plan and operational conditions.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of cargo and baggage loaded on this flight, measured in kilograms.',
    `contingency_fuel_kg` DECIMAL(18,2) COMMENT 'Additional fuel to account for unforeseen factors such as weather deviations or ATC (Air Traffic Control) routing changes, typically 5% of trip fuel or 5 minutes holding, measured in kilograms.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dispatch release record was first created in the system.',
    `departure_airport_icao` STRING COMMENT 'Four-letter ICAO code of the departure airport for this flight leg.. Valid values are `^[A-Z]{4}$`',
    `departure_metar` STRING COMMENT 'Current METAR weather observation for the departure airport at time of dispatch release issuance.',
    `destination_airport_icao` STRING COMMENT 'Four-letter ICAO code of the destination airport for this flight leg.. Valid values are `^[A-Z]{4}$`',
    `destination_metar` STRING COMMENT 'Current METAR weather observation for the destination airport at time of dispatch release issuance.',
    `destination_taf` STRING COMMENT 'Terminal Aerodrome Forecast for the destination airport covering the estimated time of arrival window.',
    `dispatcher_license_number` STRING COMMENT 'FAA or EASA license number of the dispatcher who authorized this release. Required for regulatory compliance.. Valid values are `^[A-Z0-9]{6,15}$`',
    `dispatcher_name` STRING COMMENT 'Full name of the certified flight dispatcher who issued this dispatch release.',
    `dispatcher_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatcher electronically signed and approved the dispatch release.',
    `estimated_block_time_minutes` STRING COMMENT 'Estimated total block time from gate departure (out) to gate arrival (in), measured in minutes.',
    `estimated_flight_time_minutes` STRING COMMENT 'Estimated total flight time from takeoff to landing, measured in minutes.',
    `etops_authorization_flag` BOOLEAN COMMENT 'Indicates whether this flight is authorized for ETOPS operations (extended-range twin-engine flight over water or remote areas).',
    `etops_entry_point` STRING COMMENT 'Geographic waypoint or coordinate where the flight enters ETOPS airspace, if applicable.',
    `etops_exit_point` STRING COMMENT 'Geographic waypoint or coordinate where the flight exits ETOPS airspace, if applicable.',
    `final_reserve_fuel_kg` DECIMAL(18,2) COMMENT 'Minimum fuel that must remain on board upon landing at the alternate airport, typically 30 minutes holding at 1500 feet above alternate, measured in kilograms.',
    `hazmat_onboard_flag` BOOLEAN COMMENT 'Indicates whether dangerous goods or hazardous materials are being carried on this flight, requiring special handling and documentation.',
    `landing_weight_kg` DECIMAL(18,2) COMMENT 'Planned aircraft landing weight at destination, measured in kilograms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dispatch release record was last updated or amended.',
    `mel_items_accepted_count` STRING COMMENT 'Number of MEL (Minimum Equipment List) deferred maintenance items accepted and documented in this dispatch release, allowing flight with specific inoperative equipment.',
    `mel_items_summary` STRING COMMENT 'Textual summary of all MEL items accepted for this flight, including item numbers, descriptions, and operational limitations.',
    `minimum_fuel_kg` DECIMAL(18,2) COMMENT 'Regulatory minimum fuel quantity required for this flight considering all fuel policy components, measured in kilograms.',
    `notam_briefing_package` STRING COMMENT 'Comprehensive text package of all relevant NOTAMs (Notices to Air Missions) for departure, en-route, destination, and alternate airports with operational significance flags.',
    `passenger_count` STRING COMMENT 'Total number of passengers planned to be carried on this flight at time of dispatch release.',
    `planned_cruise_altitude_ft` STRING COMMENT 'Planned cruising altitude for this flight leg, measured in feet above mean sea level.',
    `planned_cruise_speed_kts` STRING COMMENT 'Planned true airspeed during cruise phase, measured in knots.',
    `planned_fuel_uplift_kg` DECIMAL(18,2) COMMENT 'Total quantity of fuel planned to be loaded onto the aircraft for this flight, measured in kilograms.',
    `regulatory_authority` STRING COMMENT 'Primary aviation regulatory authority governing this flight operation (FAA for US, EASA for EU, etc.).. Valid values are `FAA|EASA|TCCA|CASA|CAAC`',
    `release_issued_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch release was officially issued and authorized for flight departure. Principal business event timestamp for this regulatory document.',
    `release_status` STRING COMMENT 'Current lifecycle status of the dispatch release document in the authorization workflow.. Valid values are `draft|pending_review|approved|issued|superseded|cancelled`',
    `release_version_number` STRING COMMENT 'Version number of this dispatch release if it has been amended or superseded after initial issuance.',
    `route_description` STRING COMMENT 'Detailed flight route including airways, waypoints, and navigation fixes from departure to destination.',
    `special_handling_notes` STRING COMMENT 'Free-text field for any special operational considerations, restrictions, or handling instructions for this flight.',
    `takeoff_weight_kg` DECIMAL(18,2) COMMENT 'Planned aircraft takeoff weight including fuel, payload, and operating empty weight, measured in kilograms.',
    `trip_fuel_kg` DECIMAL(18,2) COMMENT 'Fuel required to fly from departure to destination under planned conditions, measured in kilograms.',
    `weather_briefing_package` STRING COMMENT 'Comprehensive weather briefing including METARs (Meteorological Aerodrome Reports), TAFs (Terminal Aerodrome Forecasts), SIGMETs (Significant Meteorological Information), PIREPs (Pilot Reports), and winds-aloft data for all relevant stations.',
    `zero_fuel_weight_kg` DECIMAL(18,2) COMMENT 'Aircraft weight excluding all usable fuel, including operating empty weight and payload, measured in kilograms.',
    CONSTRAINT pk_dispatch_release PRIMARY KEY(`dispatch_release_id`)
) COMMENT 'Official dispatch release document authorizing a specific flight leg to depart. Contains dispatcher authorization, MEL (Minimum Equipment List) items accepted, fuel release quantities (planned uplift, minimum fuel, contingency, alternate, final reserve), alternate airports, NOTAM briefing package (relevant NOTAMs for departure/en-route/destination/alternate with operational significance flags), weather briefing package (METARs, TAFs, SIGMETs, PIREPs, winds-aloft for all relevant stations), ETOPS authorization if applicable, and dispatcher/captain sign-off timestamps. Mandatory regulatory document required by FAA 14 CFR Part 121.687 / EASA OPS for each commercial flight departure.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the flight plan record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Flight plans are filed for a specific tail number; weight/performance calculations, MEL item counts, and ETOPS eligibility all depend on the exact aircraft. Regulatory filing (ICAO FPL) references the',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Flight planning systems require aircraft type performance data (fuel capacity, cruise speed, MTOW, range) to calculate fuel requirements, weight limits, and route viability. aircraft_type_icao is deno',
    `alert_id` BIGINT COMMENT 'Foreign key linking to safety.alert. Business justification: Dispatchers modify flight plans in response to active safety alerts (volcanic ash NOTAMs, airspace restriction alerts, manufacturer airworthiness bulletins). Linking flight_plan to the triggering safe',
    `block_time_standard_id` BIGINT COMMENT 'Foreign key linking to route.block_time_standard. Business justification: Flight dispatchers reference the authoritative block_time_standard when computing fuel requirements, crew duty time limits, and planned block hours in a flight plan. This is a direct regulatory and op',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Flight plans are operationally tied to specific flight legs (actual operations on a date), not just the schedule master. A flight plan is prepared for a specific operational instance. This FK links th',
    `member_id` BIGINT COMMENT 'Reference to the pilot-in-command who accepted and signed off on the operational flight plan.',
    `scheduled_flight_id` BIGINT COMMENT 'Reference to the specific flight leg for which this flight plan was generated.',
    `alternate_airport_1_icao` STRING COMMENT 'Four-letter ICAO code of the primary alternate airport in case destination is unavailable.. Valid values are `^[A-Z]{4}$`',
    `alternate_airport_2_icao` STRING COMMENT 'Four-letter ICAO code of the secondary alternate airport.. Valid values are `^[A-Z]{4}$`',
    `alternate_fuel_kg` STRING COMMENT 'Fuel in kilograms required to fly from destination to the alternate airport and conduct an approach and landing.',
    `arrival_airport_icao` STRING COMMENT 'Four-letter ICAO code of the destination airport.. Valid values are `^[A-Z]{4}$`',
    `contingency_fuel_kg` STRING COMMENT 'Contingency fuel in kilograms to account for unforeseen factors (typically 5% of trip fuel or 5 minutes holding fuel, whichever is greater).',
    `cost_index` STRING COMMENT 'Cost index value used for flight planning optimization, balancing time cost versus fuel cost. Higher values favor speed; lower values favor fuel efficiency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this flight plan record was first created in the system.',
    `cruise_altitude_ft` STRING COMMENT 'Planned cruise altitude in feet above mean sea level (MSL) for the primary cruise segment.',
    `cruise_speed_kts` STRING COMMENT 'Planned cruise speed in knots (true airspeed or indicated airspeed as per flight planning convention).',
    `departure_airport_icao` STRING COMMENT 'Four-letter ICAO code of the departure airport.. Valid values are `^[A-Z]{4}$`',
    `etops_entry_point` STRING COMMENT 'Waypoint or geographic coordinate where the flight enters ETOPS airspace.',
    `etops_exit_point` STRING COMMENT 'Waypoint or geographic coordinate where the flight exits ETOPS airspace.',
    `etops_qualified_flag` BOOLEAN COMMENT 'Indicates whether this flight plan is qualified for ETOPS operations (extended-range twin-engine flights over water or remote areas).',
    `filed_timestamp` TIMESTAMP COMMENT 'Date and time when this flight plan version was filed with Air Traffic Control (ATC) or ICAO Flight Plan Processing System.',
    `final_reserve_fuel_kg` STRING COMMENT 'Final reserve fuel in kilograms: minimum fuel required to fly for 30 minutes at holding speed at 1,500 feet above alternate airport elevation in standard conditions.',
    `landing_weight_kg` STRING COMMENT 'Planned landing weight in kilograms at destination: takeoff weight minus trip fuel burn.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this flight plan record was last updated.',
    `operational_timestamp` TIMESTAMP COMMENT 'Date and time when this flight plan version was accepted by the crew and loaded into the Flight Management System (FMS) as the operational flight plan (OFP).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the flight plan. Filed: submitted to ATC/ICAO; Amended: re-cleared or updated; Operational: final crew-accepted OFP loaded into FMS for execution; Cancelled: plan withdrawn; Rejected: not accepted by ATC; Superseded: replaced by newer version.. Valid values are `filed|amended|operational|cancelled|rejected|superseded`',
    `planned_block_hours` DECIMAL(18,2) COMMENT 'Estimated total block time in hours from gate departure (Out) to gate arrival (In), including taxi, flight, and approach time.',
    `planned_flight_time_hours` DECIMAL(18,2) COMMENT 'Estimated airborne time in hours from wheels-off to wheels-on.',
    `planned_taxi_in_minutes` STRING COMMENT 'Estimated taxi time in minutes from landing to gate arrival.',
    `planned_taxi_out_minutes` STRING COMMENT 'Estimated taxi time in minutes from gate departure to takeoff.',
    `route_of_flight` STRING COMMENT 'Full textual representation of the planned route including RNAV waypoints, airways, Standard Instrument Departures (SIDs), and Standard Terminal Arrival Routes (STARs).',
    `step_climb_schedule` STRING COMMENT 'Planned altitude step-climb profile showing waypoints and altitudes where the aircraft will request higher cruise levels to optimize fuel efficiency as weight decreases.',
    `takeoff_weight_kg` STRING COMMENT 'Planned takeoff weight in kilograms: zero fuel weight plus total fuel on board at brake release.',
    `total_fuel_required_kg` STRING COMMENT 'Total fuel required in kilograms: sum of trip fuel, contingency fuel, alternate fuel, final reserve fuel, taxi fuel, and any additional fuel.',
    `trip_fuel_kg` STRING COMMENT 'Planned fuel burn in kilograms from takeoff to landing at destination airport.',
    `version_number` STRING COMMENT 'Sequential version number of this flight plan. Increments with each amendment or update to the plan for the same flight.',
    `wind_data_source` STRING COMMENT 'Source of wind and temperature forecast data used in flight planning (e.g., NOAA GFS, ECMWF, proprietary meteorological service).',
    `zero_fuel_weight_kg` STRING COMMENT 'Planned zero fuel weight in kilograms: aircraft operating empty weight plus payload (passengers, cargo, baggage) but excluding all usable fuel.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Computerized flight plan for a specific flight leg, managed as a versioned document through its full lifecycle from initial filing to final crew-accepted Operational Flight Plan (OFP) loaded into the FMS. Contains route of flight (RNAV waypoints, airways, SIDs/STARs), planned altitude profile and step-climb schedule, estimated en-route time, fuel burn calculations by segment, alternate airports, wind and temperature data used, cost index, planned block hours, zero fuel weight, takeoff weight, landing weight, and performance data. Version status tracks progression: filed (submitted to ATC/ICAO), amended (re-cleared/updated), operational (final crew-accepted OFP loaded into FMS for execution). The operational version represents the definitive flight plan used by the crew and is the SSOT for planned route, fuel, and performance targets against which actuals are compared. Generated by Jeppesen Flight Planning System or equivalent.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`oooi_event` (
    `oooi_event_id` BIGINT COMMENT 'Unique identifier for each OOOI event record. Primary key for the OOOI event entity.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg for which this OOOI event was recorded. Links to the operational flight leg in the flight operations domain.',
    `acars_message_label` STRING COMMENT 'The ACARS message label identifier associated with this OOOI event transmission (e.g., H1 for OUT, 10 for OFF, 11 for ON, 12 for IN). Null if data source is not ACARS.',
    `acars_message_number` STRING COMMENT 'The unique ACARS message sequence number for this OOOI event transmission. Used for message tracking and reconciliation. Null if data source is not ACARS.',
    `aircraft_registration` STRING COMMENT 'The tail number or registration identifier of the aircraft that generated this OOOI event. Used for cross-validation and aircraft-specific analysis.',
    `airport_code` STRING COMMENT 'The three-letter IATA airport code where the OOOI event occurred (departure airport for OUT/OFF, arrival airport for ON/IN).. Valid values are `^[A-Z]{3}$`',
    `altitude_feet` STRING COMMENT 'The aircraft altitude in feet above mean sea level at the time of the OOOI event. Primarily populated for OFF and ON events from FMS or ADS-B data. Used for performance analysis.',
    `correction_reason` STRING COMMENT 'Free-text description explaining why this OOOI event timestamp was corrected. Null if is_corrected is False. Used for audit trail and data quality improvement.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality and reliability of the OOOI event data: VERIFIED (confirmed accurate), ESTIMATED (calculated or interpolated), CORRECTED (manually adjusted after initial capture), DISPUTED (conflicting data from multiple sources), PENDING (awaiting validation).. Valid values are `VERIFIED|ESTIMATED|CORRECTED|DISPUTED|PENDING`',
    `data_source` STRING COMMENT 'The system or method that captured and reported the OOOI event: ACARS (Aircraft Communications Addressing and Reporting System), ADS-B (Automatic Dependent Surveillance-Broadcast), MANUAL (crew or ground staff entry), FMS (Flight Management System), OOOI_SENSOR (dedicated aircraft sensor), GROUND_SYSTEM (airport ground handling system).. Valid values are `ACARS|ADS-B|MANUAL|FMS|OOOI_SENSOR|GROUND_SYSTEM`',
    `delay_code` STRING COMMENT 'The IATA standard delay code indicating the reason for delay if the event was delayed (e.g., 11-Aircraft defects, 31-Flight deck crew, 81-Weather). Null if no delay occurred.',
    `delay_minutes` STRING COMMENT 'The number of minutes this OOOI event occurred after the scheduled timestamp. Positive values indicate delay, negative values indicate early operation. Foundation for OTP and DOT delay reporting.',
    `event_timestamp` TIMESTAMP COMMENT 'The actual date and time when the OOOI event occurred, recorded in UTC. This is the authoritative timestamp for the event used in OTP reporting and block hours calculation.',
    `event_timestamp_local` TIMESTAMP COMMENT 'The OOOI event timestamp converted to the local time zone of the airport where the event occurred. Used for operational reporting and crew scheduling.',
    `event_type` STRING COMMENT 'The type of OOOI event: OUT (pushback/gate departure), OFF (wheels-off/takeoff), ON (wheels-on/landing), IN (gate arrival/chocks-in). Foundation for block hours and OTP calculation.. Valid values are `OUT|OFF|ON|IN`',
    `flight_number` STRING COMMENT 'The commercial flight number associated with this OOOI event (e.g., AA100, DL2345). Used for operational tracking and passenger communication.',
    `gate_stand` STRING COMMENT 'The gate or stand identifier where the OUT (pushback) or IN (arrival) event occurred. Null for OFF and ON events. Used for ground operations coordination.',
    `ground_speed_knots` STRING COMMENT 'The aircraft ground speed in knots at the time of the OOOI event. Primarily populated for OFF and ON events. Used for performance and safety analysis.',
    `is_corrected` BOOLEAN COMMENT 'Boolean flag indicating whether this OOOI event timestamp was manually corrected after initial capture due to data quality issues or system errors. True if corrected, False if original.',
    `is_estimated` BOOLEAN COMMENT 'Boolean flag indicating whether this OOOI event timestamp was estimated or interpolated rather than directly captured from aircraft or ground systems. True if estimated, False if actual.',
    `latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate where the OOOI event occurred, captured from ADS-B or FMS. Primarily populated for OFF and ON events. Used for flight path analysis and safety investigations.',
    `longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate where the OOOI event occurred, captured from ADS-B or FMS. Primarily populated for OFF and ON events. Used for flight path analysis and safety investigations.',
    `notes` STRING COMMENT 'Free-text field for operational notes, comments, or additional context about this OOOI event. Used by flight operations staff to document unusual circumstances or data quality issues.',
    `original_timestamp` TIMESTAMP COMMENT 'The original OOOI event timestamp before any corrections were applied. Null if is_corrected is False. Preserved for audit trail and data lineage.',
    `otp_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this OOOI event is eligible for inclusion in OTP calculations per IATA or DOT standards. False if flight was cancelled, diverted, or otherwise excluded from OTP metrics.',
    `processed_timestamp` TIMESTAMP COMMENT 'The timestamp when the OOOI event data was validated, quality-checked, and integrated into the operational database. Used for data pipeline monitoring.',
    `received_timestamp` TIMESTAMP COMMENT 'The timestamp when the OOOI event data was received and recorded by the ground-based flight operations system. Used for data latency analysis and system performance monitoring.',
    `reporting_status` STRING COMMENT 'Indicates whether this OOOI event has been included in regulatory reporting submissions to DOT, IATA, or other authorities: REPORTED (included in submission), UNREPORTED (not yet submitted), EXCLUDED (intentionally omitted per reporting rules), AMENDED (corrected in a subsequent filing).. Valid values are `REPORTED|UNREPORTED|EXCLUDED|AMENDED`',
    `runway_identifier` STRING COMMENT 'The runway designation used for the OFF (takeoff) or ON (landing) event. Format follows ICAO runway naming conventions (e.g., 27L, 09R). Null for OUT and IN events.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'The originally scheduled timestamp for this OOOI event type (scheduled departure for OUT, scheduled takeoff for OFF, scheduled landing for ON, scheduled arrival for IN). Used to calculate delay and OTP metrics.',
    CONSTRAINT pk_oooi_event PRIMARY KEY(`oooi_event_id`)
) COMMENT 'Captures the four key gate/runway timestamps for each flight leg: Out (pushback/gate departure), Off (wheels-off/takeoff), On (wheels-on/landing), and In (gate arrival/chocks-in). Each event record includes the event type, actual timestamp, source system (ACARS, manual entry, ADS-B), airport and runway/gate reference, and data quality flag. Foundation for block hours calculation, OTP (On-Time Performance) reporting, and DOT/IATA punctuality statistics.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`fuel_uplift` (
    `fuel_uplift_id` BIGINT COMMENT 'Unique identifier for the fuel uplift transaction record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Fuel supplier invoices flow through AP for payment processing and three-way matching (uplift record, invoice, payment). Links operational fuel transaction to financial settlement for cash management, ',
    `dispatch_release_id` BIGINT COMMENT 'Foreign key linking to flight.dispatch_release. Business justification: The dispatch release contains the planned_fuel_uplift_kg authorized for the flight. The fuel_uplift record captures what was actually loaded. Linking fuel_uplift directly to dispatch_release enables f',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg for which fuel was uplifted.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Fuel uplift occurs at specific stations; linking enables fuel cost allocation by station, vendor performance tracking, price variance analysis, and station-level fuel consumption reporting. Core finan',
    `aircraft_registration` STRING COMMENT 'The tail number or registration code of the aircraft that received the fuel uplift.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions in kilograms resulting from the combustion of the uplifted fuel, used for CORSIA reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel uplift record was first created in the system.',
    `fuel_batch_number` STRING COMMENT 'Batch or lot number of the fuel supplied, used for quality traceability.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `fuel_density` DECIMAL(18,2) COMMENT 'Density of the fuel at the time of uplift, measured in kilograms per litre, used for mass-volume conversions.',
    `fuel_price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fuel price.. Valid values are `^[A-Z]{3}$`',
    `fuel_price_per_unit` DECIMAL(18,2) COMMENT 'Price per unit (per kilogram or per litre) of fuel charged by the supplier.',
    `fuel_quality_certificate_number` STRING COMMENT 'Certificate number issued by the fuel supplier confirming fuel quality and compliance with aviation standards.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `fuel_quantity_kg` DECIMAL(18,2) COMMENT 'Quantity of fuel uplifted measured in kilograms.',
    `fuel_quantity_lbs` DECIMAL(18,2) COMMENT 'Quantity of fuel uplifted measured in pounds.',
    `fuel_quantity_litres` DECIMAL(18,2) COMMENT 'Quantity of fuel uplifted measured in litres.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional surcharge or fee applied to the fuel uplift transaction.',
    `fuel_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature of the fuel at the time of uplift, measured in degrees Celsius, used for density correction.',
    `fuel_ticket_number` STRING COMMENT 'Unique ticket or document number issued by the fueling company for this uplift transaction.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `fuel_type` STRING COMMENT 'Type of aviation fuel uplifted (e.g., Jet-A, Jet-A1, JP-8).. Valid values are `Jet-A|Jet-A1|JP-8|TS-1|Avgas`',
    `fuel_uplift_status` STRING COMMENT 'Current status of the fuel uplift transaction (e.g., completed, partial, cancelled, disputed).. Valid values are `completed|partial|cancelled|disputed`',
    `fueling_duration_minutes` STRING COMMENT 'Duration of the fueling operation in minutes.',
    `fueling_start_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel uplift operation began.',
    `fueling_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel uplift operation was completed, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `into_plane_agent` STRING COMMENT 'Name or identifier of the into-plane agent or ground handler responsible for the physical fueling operation.',
    `invoice_number` STRING COMMENT 'Invoice number issued by the fuel supplier for this uplift transaction.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `payment_method` STRING COMMENT 'Method of payment used for the fuel uplift (e.g., credit account, cash, card, prepaid).. Valid values are `credit_account|cash|card|prepaid`',
    `post_fueling_quantity_kg` DECIMAL(18,2) COMMENT 'Total quantity of fuel on board the aircraft after the uplift, measured in kilograms.',
    `pre_fueling_quantity_kg` DECIMAL(18,2) COMMENT 'Quantity of fuel already on board the aircraft before the uplift, measured in kilograms.',
    `remarks` STRING COMMENT 'Free-text field for additional notes or comments related to the fuel uplift transaction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to the fuel uplift transaction, including excise or environmental taxes.',
    `total_fuel_cost` DECIMAL(18,2) COMMENT 'Total cost of the fuel uplift transaction in the specified currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel uplift record was last updated in the system.',
    CONSTRAINT pk_fuel_uplift PRIMARY KEY(`fuel_uplift_id`)
) COMMENT 'Records actual fuel loaded onto an aircraft for a specific flight leg at a specific station. Contains fuel quantity uplift (kg/lbs and litres), fuel density, fuel type (Jet-A, Jet-A1, JP-8), fuelling company, into-plane agent, fuel ticket number, fuel price per unit, total fuel cost, pre-fuelling quantity on board, post-fuelling quantity on board, and fuelling timestamp. Critical for fuel cost accounting, fuel efficiency analysis, and CORSIA carbon reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`delay_record` (
    `delay_record_id` BIGINT COMMENT 'Unique identifier for the delay record. Primary key.',
    `absence_id` BIGINT COMMENT 'Foreign key linking to crew.absence. Business justification: Crew absence (sick call, no-show) is a primary IATA delay code category. DOT on-time reporting and delay cost attribution require linking a delay record directly to the crew absence that caused it. de',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: EU261/DOT delay compensation payments are processed as AP transactions. The delay_record has compensation_issued_flag and delay_cost_estimate_usd. Airlines pay compensation via AP to passengers or han',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Delay costs (crew overtime, passenger compensation, missed slot fees, reactionary delays) are allocated to responsible cost centres for operational cost analysis, CASK calculation, and departmental pe',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg that experienced this delay.',
    `irop_event_id` BIGINT COMMENT 'Foreign key linking to flight.flight_irop_event. Business justification: A delay record is frequently triggered by or associated with an IROP event (e.g., weather system, ATC ground stop, aircraft swap). Adding flight_irop_event_id to delay_record allows grouping all delay',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety occurrences (bird strikes, medical emergencies, security events) directly cause operational delays. Delay analysis and regulatory reporting (DOT 14 CFR Part 234) require linking delay records t',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Delay accountability requires linking to responsible station entity for performance tracking, cost allocation of controllable delays, station manager accountability, and regulatory DOT reporting by st',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance-caused delays must reference the specific work order driving the delay. Required for IATA delay code reporting (ATA/ATM codes), reliability program analysis, and maintenance delay cost att',
    `affected_passenger_count` STRING COMMENT 'Number of passengers (Pax) affected by this delay event. Used for customer impact assessment and compensation calculations.',
    `compensation_issued_flag` BOOLEAN COMMENT 'Boolean flag indicating whether passenger compensation (monetary or vouchers) was issued as a result of this delay under EU261, DOT, or airline policy. True if compensation issued, False if not.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective or preventive actions taken to resolve the delay or prevent recurrence. Used for continuous improvement and safety management system (SMS) tracking.',
    `data_source_system` STRING COMMENT 'Identifier of the source system from which this delay record originated (e.g., Lufthansa Systems NetLine/Ops, Jeppesen Flight Planning, manual entry by operations staff, ACARS messaging, or other systems).. Valid values are `netline_ops|jeppesen|manual_entry|acars|other`',
    `delay_category` STRING COMMENT 'High-level classification of the delay cause: airline operational issues, ATC (Air Traffic Control) restrictions, airport facility problems, weather conditions, passenger-related issues, reactionary delays from late inbound aircraft, security events, or other causes. [ENUM-REF-CANDIDATE: airline_operational|air_traffic_control|airport_facilities|weather|passenger_related|reactionary|security|other — 8 candidates stripped; promote to reference product]',
    `delay_cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated financial cost of the delay in US dollars, including crew overtime, passenger compensation, fuel burn, missed connections, and operational disruption. Used for cost-benefit analysis and delay reduction initiatives.',
    `delay_description` STRING COMMENT 'Free-text narrative description providing detailed context and explanation of the delay event, root cause, and any corrective actions taken.',
    `delay_duration_minutes` STRING COMMENT 'Total duration of the delay event measured in minutes. Used for OTP (On-Time Performance) calculations and DOT reporting.',
    `delay_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking the resolution or end of the delay event in UTC. Nullable if delay is ongoing or not yet resolved.',
    `delay_notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when delay notification was sent to passengers via SMS, email, or mobile app. Used to measure compliance with customer communication standards.',
    `delay_sequence_number` STRING COMMENT 'Sequential ordering of multiple delay events for the same flight leg. Allows tracking of multiple delay causes on a single flight.',
    `delay_start_timestamp` TIMESTAMP COMMENT 'Timestamp marking the beginning of the delay event in UTC. Used to calculate delay duration and analyze delay patterns by time of day.',
    `delay_status` STRING COMMENT 'Current lifecycle status of the delay record: open (delay ongoing), resolved (delay ended), under investigation (root cause analysis in progress), closed (finalized and archived), or disputed (under review or challenge).. Valid values are `open|resolved|under_investigation|closed|disputed`',
    `delay_verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the delay record was verified and approved by a supervisor. Nullable if verification is pending.',
    `is_controllable_delay` BOOLEAN COMMENT 'Boolean flag indicating whether the delay was within the airlines control (e.g., maintenance, crew scheduling) versus external factors (e.g., weather, ATC). Used for internal performance accountability and root cause analysis.',
    `is_reactionary_delay` BOOLEAN COMMENT 'Boolean flag indicating whether this delay was reactionary (caused by a late inbound aircraft from a previous flight leg). True if reactionary, False if not.',
    `is_reportable_to_dot` BOOLEAN COMMENT 'Boolean flag indicating whether this delay must be reported to the US Department of Transportation under 14 CFR Part 234 (applies to delays of 15 minutes or more for covered carriers). True if reportable, False if not.',
    `missed_connection_count` STRING COMMENT 'Number of passengers who missed their connecting flights as a result of this delay. Used for IROP (Irregular Operations) management and customer service planning.',
    `primary_delay_code` STRING COMMENT 'Two-digit IATA delay code representing the primary cause of the delay per AHM 730 standard (e.g., 11=Aircraft defects, 31=Flight deck crew, 81=Weather).. Valid values are `^[0-9]{2}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delay record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delay record was last modified. Used for audit trail and change tracking.',
    `responsible_department_code` STRING COMMENT 'Internal department code identifying the organizational unit responsible for or associated with the delay (e.g., MX=Maintenance, OPS=Operations, CREW=Crew Scheduling, GND=Ground Handling).. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_delay_record PRIMARY KEY(`delay_record_id`)
) COMMENT 'Captures delay events associated with a flight leg including primary and secondary IATA delay codes (AHM 730 standard), delay duration in minutes, responsible department/station, delay description narrative, delay category (airline, ATC, airport, weather, pax-related), and whether the delay was reactionary (caused by late inbound aircraft). Supports OTP reporting, DOT delay reporting, root cause analysis, and operational performance management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`diversion` (
    `diversion_id` BIGINT COMMENT 'Unique identifier for the flight diversion event. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Diversions trigger immediate AP payments for hotel_accommodation, meal_vouchers, and ground transport (flags present on diversion). Airlines process these as AP invoices from hotels/caterers; linking ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Diversions incur incremental costs (extra fuel, ground handling, passenger accommodation, crew expenses) that must be allocated to specific cost centres for operational variance analysis, budget contr',
    `dispatch_release_id` BIGINT COMMENT 'Foreign key linking to flight.dispatch_release. Business justification: When a diversion occurs, a new or amended dispatch release must be issued for the continuation flight from the diversion airport. diversion already has dispatch_release_updated_flag (boolean) indicati',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight that was diverted. Links to the flight operations record.',
    `irop_event_id` BIGINT COMMENT 'Foreign key linking to flight.flight_irop_event. Business justification: A diversion is a key outcome of an IROP event. Multiple diversions can be caused by the same IROP event (e.g., a severe weather system forcing several aircraft to divert). Adding flight_irop_event_id ',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Diversions are significant safety events requiring occurrence reporting under ICAO Annex 13 and national regulations. Direct linkage enables Safety Management System to track diversion→occurrence rela',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Diversion events require station entity link for ground handler coordination, passenger care resource allocation, diversion cost tracking by station, hotel/meal vendor management, and station capabili',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Technical diversions generate work orders at the diversion station. Linking diversion.work_order_id → maintenance.work_order.work_order_id enables technical diversion root cause analysis, cost attribu',
    `actual_gate_arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the aircraft arrived at the gate at the diversion airport. Completes the In event of OOOI tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `actual_landing_timestamp` TIMESTAMP COMMENT 'Date and time when the aircraft touched down at the diversion airport. Part of OOOI (Out-Off-On-In) event tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft that was diverted. Used for aircraft-specific tracking and maintenance correlation.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `airport_icao_code` STRING COMMENT 'Four-letter ICAO airport code of the diversion airport. Provides international standard identifier for flight planning and ATC coordination.. Valid values are `^[A-Z]{4}$`',
    `atc_coordination_reference` STRING COMMENT 'Reference number or identifier provided by Air Traffic Control (ATC) for the diversion coordination. Used for operational tracking and incident investigation.',
    `compensation_eligibility_flag` BOOLEAN COMMENT 'Indicates whether passengers are eligible for monetary compensation under applicable passenger rights regulations due to the diversion. True if eligible; False otherwise.',
    `continuation_departure_timestamp` TIMESTAMP COMMENT 'Date and time when the continuation flight departed from the diversion airport toward the original destination. Null if no continuation occurred. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `continuation_flight_number` STRING COMMENT 'Flight number assigned to the continuation flight if the aircraft or passengers continued to the original destination after the diversion. Null if flight was cancelled or returned to origin.',
    `cost_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this diversion record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crew_duty_time_impact_flag` BOOLEAN COMMENT 'Indicates whether the diversion caused crew duty time or flight time limitations to be exceeded or approached, requiring crew replacement or schedule adjustments. True if impacted; False otherwise.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the decision to divert was made by the pilot-in-command or operational control. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dispatch_release_updated_flag` BOOLEAN COMMENT 'Indicates whether a new or amended dispatch release was issued for the continuation flight from the diversion airport. True if updated; False otherwise.',
    `disposition_action` STRING COMMENT 'Subsequent operational action taken after landing at the diversion airport. Continued_to_destination indicates flight resumed to original destination; returned_to_origin indicates flight returned to departure airport; cancelled indicates flight was terminated; aircraft_swap indicates passengers transferred to another aircraft; overnight_recovery indicates passengers accommodated overnight.. Valid values are `continued_to_destination|returned_to_origin|cancelled|aircraft_swap|overnight_recovery`',
    `diversion_number` STRING COMMENT 'Business identifier for the diversion event, used for operational tracking and reporting. Format: DIV followed by numeric sequence.. Valid values are `^DIV[0-9]{8,12}$`',
    `diversion_status` STRING COMMENT 'Current lifecycle status of the diversion event. Tracks progression from initial declaration through resolution.. Valid values are `declared|in_progress|landed|resolved|cancelled`',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial cost impact of the diversion event, including fuel, landing fees, passenger care, crew expenses, and operational disruption costs. Expressed in the airlines reporting currency.',
    `fuel_uplift_at_diversion_kg` DECIMAL(18,2) COMMENT 'Amount of fuel uplifted at the diversion airport in kilograms. Required if the aircraft continued to the original destination or another airport after the diversion.',
    `ground_time_duration_minutes` STRING COMMENT 'Total time in minutes that the aircraft spent on the ground at the diversion airport, from gate arrival to departure (if continuation occurred) or final shutdown.',
    `hotel_accommodation_provided_flag` BOOLEAN COMMENT 'Indicates whether hotel accommodation was provided to passengers due to the diversion. True if accommodation was arranged; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this diversion record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `meal_voucher_provided_flag` BOOLEAN COMMENT 'Indicates whether meal vouchers or meals were provided to passengers due to the diversion. True if meals were provided; False otherwise.',
    `notam_reference` STRING COMMENT 'Reference to any relevant NOTAM (Notice to Air Missions) that contributed to or was issued in relation to the diversion event.',
    `passenger_care_action_taken` STRING COMMENT 'Description of passenger care actions provided at the diversion airport, including meals, accommodation, rebooking, ground transportation, and communication. Documents compliance with passenger rights regulations.',
    `passenger_count_diverted` STRING COMMENT 'Total number of passengers (Pax) on board the aircraft at the time of diversion. Used for passenger care planning and regulatory reporting.',
    `planned_destination_airport_code` STRING COMMENT 'Three-letter IATA airport code of the original planned destination airport before diversion was declared.. Valid values are `^[A-Z]{3}$`',
    `reason_code` STRING COMMENT 'Primary reason category for the diversion. Weather includes wx conditions at destination; medical includes passenger or crew medical emergencies; mechanical includes aircraft technical issues; fuel includes fuel shortage or fuel planning issues; ATC includes air traffic control restrictions; security includes security threats or incidents; airport_closure includes runway closures or airport operational issues. [ENUM-REF-CANDIDATE: weather|medical|mechanical|fuel|atc|security|airport_closure — 7 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the specific circumstances that led to the diversion decision. Provides operational context beyond the reason code.',
    `regulatory_report_required_flag` BOOLEAN COMMENT 'Indicates whether the diversion event requires formal reporting to aviation regulatory authorities (FAA, EASA, national CAA). True if reporting is required; False otherwise.',
    `regulatory_report_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the required regulatory report was submitted to the aviation authority. Null if no report was required or not yet submitted. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `safety_report_reference` STRING COMMENT 'Reference number of any safety report filed in the airlines Safety Management System (SMS) related to the diversion event. Used for safety trend analysis and continuous improvement.',
    `weather_condition_description` STRING COMMENT 'Description of the weather (wx) conditions at the planned destination or en route that contributed to the diversion decision, if weather was a factor. Includes visibility, ceiling, wind, precipitation, and other meteorological phenomena.',
    CONSTRAINT pk_diversion PRIMARY KEY(`diversion_id`)
) COMMENT 'Records flight diversions where an aircraft lands at an airport other than the planned destination. Contains diversion reason (weather, medical, mechanical, ATC, security), diversion airport, time of diversion decision, actual landing time at diversion airport, subsequent disposition (continued to destination, returned to origin, cancelled), passenger handling actions taken, and estimated cost impact. Supports IROP management, regulatory reporting, and passenger care obligations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`irop_event` (
    `irop_event_id` BIGINT COMMENT 'Unique identifier for the irregular operations event record. Primary key for the flight IROP event entity.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: IROP events impact specific stations; linking enables station-level impact analysis, resource allocation during irregular operations, recovery plan coordination with station managers, and financial im',
    `alert_id` BIGINT COMMENT 'Foreign key linking to safety.alert. Business justification: Safety alerts (volcanic ash advisories, airspace closures, manufacturer bulletins) directly trigger IROP events in Operations Control. Linking flight_irop_event to the triggering safety alert supports',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: IROP events have estimated_financial_impact_amount and responsible_department requiring cost centre attribution. Airlines track IROP costs by cost centre (OCC, ground ops, crew) for budget variance an',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: IROP events triggered by safety occurrences (runway incursions, bird strikes, emergency declarations) must be directly correlated for DOT/regulatory reporting and SMS root cause analysis. Operations C',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: IROP management and CDM (Collaborative Decision Making) sessions are route-centric — network recovery planning, regulatory notification, and route performance impact assessment all require knowing whi',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: IROP events caused by technical/AOG issues must reference the triggering work order for root cause analysis and recovery planning. Operations Control Centers require this link to coordinate maintenanc',
    `actual_passengers_affected` STRING COMMENT 'Actual total number of passengers impacted by the irregular operations event across all affected flights. Calculated after event resolution.',
    `actual_total_delay_minutes` STRING COMMENT 'Actual cumulative delay minutes across all affected flights resulting from this irregular operations event. Calculated after event resolution.',
    `atc_coordination_notes` STRING COMMENT 'Notes documenting coordination activities and communications with Air Traffic Control during the irregular operations event.',
    `cdm_session_reference` STRING COMMENT 'Reference identifier linking to the Collaborative Decision Making session coordinating the operational response to this irregular operations event.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this irregular operations event record was first created in the system. Used for audit trail and data lineage.',
    `estimated_financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the irregular operations event including operational costs, passenger compensation, and revenue loss. Expressed in airline base currency.',
    `estimated_passengers_affected` STRING COMMENT 'Estimated total number of passengers impacted by the irregular operations event across all affected flights. Used for customer service resource planning.',
    `estimated_total_delay_minutes` STRING COMMENT 'Estimated cumulative delay minutes across all affected flights resulting from this irregular operations event. Used for impact assessment and reporting.',
    `event_code` STRING COMMENT 'Standardized code identifying the type of irregular operations event. Used for operational reporting and analysis.. Valid values are `^[A-Z0-9]{3,10}$`',
    `event_description` STRING COMMENT 'Detailed narrative description of the irregular operations event including circumstances, operational impact, and contributing factors.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the irregular operations event was resolved and normal operations resumed. Nullable for ongoing events.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the irregular operations event was first detected or began affecting operations. Critical for timeline analysis and delay attribution.',
    `event_status` STRING COMMENT 'Current lifecycle state of the irregular operations event. Tracks progression from initial detection through resolution and closure.. Valid values are `active|monitoring|resolved|closed`',
    `event_type` STRING COMMENT 'Classification of the root cause driving the irregular operations event. Determines recovery strategy and operational response.. Valid values are `weather|atc_ground_stop|airport_closure|aircraft_aog|crew_shortage|security`',
    `flights_cancelled_count` STRING COMMENT 'Total number of flights cancelled as a direct result of this irregular operations event. Key metric for operational impact assessment.',
    `flights_delayed_count` STRING COMMENT 'Total number of flights delayed as a direct result of this irregular operations event. Key metric for operational impact assessment.',
    `flights_diverted_count` STRING COMMENT 'Total number of flights diverted to alternate airports as a direct result of this irregular operations event.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this irregular operations event record was most recently modified. Used for audit trail and change tracking.',
    `notam_reference` STRING COMMENT 'Reference identifier for any associated Notice to Air Missions issued in connection with this irregular operations event.',
    `passenger_compensation_triggered_flag` BOOLEAN COMMENT 'Indicates whether this irregular operations event triggered passenger compensation obligations under applicable regulations such as EU261 or DOT rules.',
    `recovery_plan_description` STRING COMMENT 'Detailed description of the operational recovery plan including actions, resource allocation, and timeline for restoring normal operations.',
    `recovery_plan_status` STRING COMMENT 'Current state of the operational recovery plan developed to address the irregular operations event and restore normal operations.. Valid values are `not_started|in_progress|approved|executing|completed`',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this irregular operations event requires notification to regulatory authorities such as FAA, EASA, or national civil aviation authorities.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of this irregular operations event. Nullable if notification not required or not yet completed.',
    `responsible_department` STRING COMMENT 'Name of the operational department or division responsible for managing the response to this irregular operations event.',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the underlying root cause that triggered the irregular operations event. Used for post-event analysis and prevention planning.',
    `severity_level` STRING COMMENT 'Operational impact severity classification of the irregular operations event. Determines escalation procedures and resource allocation priority.. Valid values are `critical|high|medium|low`',
    `weather_condition_summary` STRING COMMENT 'Summary of weather conditions contributing to or associated with the irregular operations event. Applicable for weather-related IROP events.',
    CONSTRAINT pk_irop_event PRIMARY KEY(`irop_event_id`)
) COMMENT 'Irregular Operations (IROP) event master record capturing disruptions that affect multiple flights or require operational recovery actions. Covers event type (weather, ATC ground stop, airport closure, aircraft AOG, crew shortage, security), affected station(s), event start/end times, severity level, CDM (Collaborative Decision Making) session reference, recovery plan status, and estimated total delay minutes and passengers affected. Distinct from individual delay_record or diversion — represents the root cause event driving multiple disruptions.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`cancellation` (
    `cancellation_id` BIGINT COMMENT 'Unique identifier for the flight cancellation record. Primary key.',
    `absence_id` BIGINT COMMENT 'Foreign key linking to crew.absence. Business justification: Crew absence is a named root cause of flight cancellations (crew_legality_issue flag exists on cancellation). DOT/regulatory reporting and OCC root-cause analysis require direct linkage from a cancell',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Cancellations trigger AP invoices for passenger care costs (hotels, rebooking on other carriers, meal vouchers). The cancellation has passenger_care_cost_amount and compensation_amount_per_passenger. ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cancellations incur direct costs (passenger care, rebooking, compensation) that must be attributed to a cost centre for airline cost management reporting and variance analysis. Aviation finance teams ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Cancellations are managed at the departure station responsible for passenger rebooking, care costs, and DOT/regulatory reporting. Station-level cancellation attribution is required for operational per',
    `flight_leg_id` BIGINT COMMENT 'Reference to the cancelled flight leg in the flight operations system.',
    `irop_event_id` BIGINT COMMENT 'Reference to the broader irregular operations event that triggered this cancellation, if part of a multi-flight disruption scenario.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety-related cancellations (maintenance defects, crew fatigue, hazardous weather, security threats) require occurrence reporting and SMS tracking. Direct cancellation→occurrence linkage supports reg',
    `scheduled_flight_id` BIGINT COMMENT 'Reference to the scheduled flight record that was cancelled.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance-caused cancellations must reference the specific work order (AOG defect) that caused the cancellation. Required for DOT reportable cancellation analysis, reliability statistics, and mainte',
    `advance_notice_hours` DECIMAL(18,2) COMMENT 'Number of hours between cancellation decision and scheduled departure time. Critical for determining passenger compensation eligibility under EU261 (14-day, 7-day thresholds).',
    `affected_passenger_count` STRING COMMENT 'Total number of passengers with confirmed bookings on the cancelled flight who require rebooking or refund.',
    `aircraft_registration` STRING COMMENT 'Tail number of the aircraft that was assigned to the cancelled flight at the time of cancellation.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `atc_restriction_type` STRING COMMENT 'Type of air traffic control restriction that contributed to the cancellation (SLOT=slot restriction, GDP=ground delay program, GS=ground stop, CLOSURE=airport closure, CAPACITY=capacity reduction, FLOW=flow control).. Valid values are `SLOT|GDP|GS|CLOSURE|CAPACITY|FLOW`',
    `cancellation_type` STRING COMMENT 'Whether the cancellation was proactive (planned in advance to minimize disruption) or reactive (last-minute response to an operational event).. Valid values are `PROACTIVE|REACTIVE`',
    `compensation_amount_per_passenger` DECIMAL(18,2) COMMENT 'Standard compensation amount per passenger under applicable regulations (e.g., EUR 250/400/600 under EU261 based on distance and delay).',
    `compensation_eligibility_status` STRING COMMENT 'Status of passenger compensation eligibility determination under applicable regulations (EU261, DOT, local regulations).. Valid values are `ELIGIBLE|NOT_ELIGIBLE|UNDER_REVIEW|PAID`',
    `crew_legality_issue` STRING COMMENT 'Type of crew legality or availability issue that caused the cancellation (DUTY_TIME=exceeded duty limits, REST=insufficient rest, QUALIFICATION=crew not qualified, AVAILABILITY=crew unavailable, POSITIONING=crew positioning failure).. Valid values are `DUTY_TIME|REST|QUALIFICATION|AVAILABILITY|POSITIONING`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the decision to cancel the flight was made by the authorized authority.',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation became effective in operational systems and passenger notifications were triggered.',
    `estimated_revenue_impact_amount` DECIMAL(18,2) COMMENT 'Estimated revenue loss from the cancelled flight including ticket revenue, ancillary revenue, and potential future booking impact.',
    `first_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the first passenger notification was sent regarding the cancellation.',
    `is_controllable` BOOLEAN COMMENT 'Indicates whether the cancellation was within the airlines control (maintenance, crew, operational decisions) versus uncontrollable (weather, ATC, security, force majeure). Used for passenger compensation eligibility under EU261 and DOT regulations.',
    `is_dot_reportable` BOOLEAN COMMENT 'Indicates whether this cancellation must be reported to the US Department of Transportation under 14 CFR Part 234 (applies to US domestic flights and international flights to/from US by US carriers).',
    `network_optimization_flag` BOOLEAN COMMENT 'Indicates whether the cancellation was a strategic network optimization decision (e.g., consolidating low-load flights, repositioning aircraft) rather than an operational failure.',
    `notification_method` STRING COMMENT 'Primary method(s) used to notify affected passengers of the cancellation (e.g., SMS, email, mobile app push, airport announcement, GDS message). [ENUM-REF-CANDIDATE: SMS|EMAIL|PUSH|AIRPORT_ANNOUNCEMENT|GDS|PHONE|WEBSITE — promote to reference product]',
    `occ_remarks` STRING COMMENT 'Free-text operational remarks and notes from the Operations Control Center regarding the cancellation decision and handling.',
    `passenger_care_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for passenger care obligations including meals, accommodation, transportation, and compensation payments under EU261 or DOT regulations.',
    `reason_code` STRING COMMENT 'IATA AHM 730 standard cancellation reason code (e.g., WX for weather, MX for maintenance, CR for crew, OA for operational, etc.).. Valid values are `^[A-Z0-9]{2,4}$`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the cancellation reason for operational and customer service purposes.',
    `rebooked_passenger_count` STRING COMMENT 'Number of affected passengers who were successfully rebooked on alternative flights.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was last updated in the system.',
    `refunded_passenger_count` STRING COMMENT 'Number of affected passengers who requested and received full refunds instead of rebooking.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the required regulatory report (DOT, EASA, local CAA) has been submitted for this cancellation.',
    `regulatory_report_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory report for this cancellation was submitted to the governing authority.',
    `substitute_departure_time` TIMESTAMP COMMENT 'Scheduled departure time of the substitute flight, if one was operated to replace the cancelled service.',
    `substitute_flight_number` STRING COMMENT 'Flight number of the substitute or replacement flight operated to cover the cancelled service, if applicable.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `weather_condition_code` STRING COMMENT 'METAR/TAF weather phenomenon code if weather was a contributing factor to the cancellation (e.g., TS for thunderstorm, FG for fog, SN for snow).. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_cancellation PRIMARY KEY(`cancellation_id`)
) COMMENT 'Records flight cancellations including cancellation reason code (IATA AHM 730), cancellation decision timestamp, cancellation authority (OCC, station, crew), whether cancellation was proactive or reactive, passenger rebooking status, estimated revenue impact, and whether the cancellation was DOT-reportable. Distinct from delay_record (flight operated late) and diversion (flight landed elsewhere). Supports DOT 14 CFR Part 234 reporting and passenger care compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`weight_balance` (
    `weight_balance_id` BIGINT COMMENT 'Unique identifier for the weight and balance loadsheet record. Primary key.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Loadsheets are prepared by the departure stations load control team. Linking weight_balance to the departure station enables station-level load control audit trails, regulatory compliance reporting, ',
    `dispatch_release_id` BIGINT COMMENT 'Foreign key linking to flight.dispatch_release. Business justification: Weight & balance loadsheet is part of the dispatch release package in aviation operations. The W&B must be coordinated with and approved as part of the dispatch release. This is a standard operational',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg for which this weight and balance loadsheet was prepared.',
    `load_plan_id` BIGINT COMMENT 'Foreign key linking to cargo.load_plan. Business justification: The W&B sheet is produced directly from the cargo load plan — loadmasters use the load plan as the source document for W&B calculations. Regulatory compliance and dispatch sign-off require traceabilit',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.member. Business justification: Regulatory load sheet accountability: the loadmaster who prepares and signs the weight & balance sheet is a licensed crew member. Aviation regulators require traceability of load control sign-offs to ',
    `aircraft_registration` STRING COMMENT 'Tail number or registration code of the aircraft for which this weight and balance was calculated.',
    `aircraft_type_code` STRING COMMENT 'ICAO or IATA aircraft type designator (e.g., B738, A320, B77W) identifying the aircraft model.',
    `baggage_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of checked passenger baggage loaded in cargo holds.',
    `captain_acceptance_signature` STRING COMMENT 'Digital or physical signature of the pilot in command accepting the weight and balance loadsheet and authorizing departure.',
    `captain_acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the pilot in command accepted and signed the weight and balance loadsheet.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of revenue cargo (freight and mail) loaded in cargo holds, excluding passenger baggage.',
    `cg_aft_limit_percent_mac` DECIMAL(18,2) COMMENT 'Aft limit of the certified CG envelope for this weight and configuration. CG must not be behind this limit.',
    `cg_forward_limit_percent_mac` DECIMAL(18,2) COMMENT 'Forward limit of the certified CG envelope for this weight and configuration. CG must not be ahead of this limit.',
    `cg_landing_percent_mac` DECIMAL(18,2) COMMENT 'Estimated longitudinal centre of gravity position at landing expressed as percentage of mean aerodynamic chord. Must remain within certified CG envelope.',
    `cg_takeoff_percent_mac` DECIMAL(18,2) COMMENT 'Longitudinal centre of gravity position at takeoff expressed as percentage of mean aerodynamic chord. Must be within certified CG envelope.',
    `dispatcher_license_number` STRING COMMENT 'FAA or EASA dispatcher license number of the dispatcher who signed off on the loadsheet.',
    `dispatcher_name` STRING COMMENT 'Name of the flight dispatcher who reviewed and signed off on the weight and balance loadsheet.',
    `dry_operating_weight_kg` DECIMAL(18,2) COMMENT 'The weight of the aircraft including crew, crew baggage, catering, and all operational equipment but excluding fuel, passengers, cargo, and baggage. Also known as basic operating weight.',
    `finalized_timestamp` TIMESTAMP COMMENT 'Date and time when the loadsheet was finalized and signed off, authorizing the flight for departure.',
    `hold_aft_weight_kg` DECIMAL(18,2) COMMENT 'Total weight loaded in the aft cargo hold compartment.',
    `hold_bulk_weight_kg` DECIMAL(18,2) COMMENT 'Total weight loaded in the bulk cargo hold compartment, typically used for loose baggage and small cargo items.',
    `hold_forward_weight_kg` DECIMAL(18,2) COMMENT 'Total weight loaded in the forward cargo hold compartment.',
    `landing_weight_kg` DECIMAL(18,2) COMMENT 'Estimated weight of the aircraft at landing. Calculated as takeoff weight minus trip fuel. Must not exceed maximum landing weight.',
    `load_distribution_compliant` BOOLEAN COMMENT 'Flag indicating whether the load distribution meets all structural and CG envelope requirements for safe flight.',
    `loadsheet_number` STRING COMMENT 'Unique externally-known identifier for the weight and balance loadsheet document, typically assigned by the load control system or dispatcher.',
    `loadsheet_status` STRING COMMENT 'Current lifecycle status of the weight and balance loadsheet. Final status indicates dispatcher sign-off and regulatory compliance approval.. Valid values are `draft|preliminary|final|revised|cancelled`',
    `loadsheet_version` STRING COMMENT 'Version number of the loadsheet. Incremented when corrections or updates are made prior to departure.',
    `mail_weight_kg` DECIMAL(18,2) COMMENT 'Weight of mail cargo loaded in cargo holds.',
    `max_landing_weight_kg` DECIMAL(18,2) COMMENT 'Maximum permissible landing weight for this aircraft as specified in the aircraft flight manual. Structural limit.',
    `max_takeoff_weight_kg` DECIMAL(18,2) COMMENT 'Maximum permissible takeoff weight for this aircraft under current conditions (runway length, temperature, altitude, obstacles). May be limited below certified MTOW.',
    `max_zero_fuel_weight_kg` DECIMAL(18,2) COMMENT 'Maximum permissible zero fuel weight for this aircraft as specified in the aircraft flight manual. Structural limit.',
    `passenger_count_business` STRING COMMENT 'Number of passengers seated in business class cabin.',
    `passenger_count_economy` STRING COMMENT 'Number of passengers seated in economy cabin.',
    `passenger_count_first` STRING COMMENT 'Number of passengers seated in first class cabin.',
    `passenger_count_premium_economy` STRING COMMENT 'Number of passengers seated in premium economy cabin.',
    `passenger_count_total` STRING COMMENT 'Total number of passengers on board across all cabin classes (first, business, premium economy, economy).',
    `passenger_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of all passengers calculated using standard or actual passenger weights per regulatory requirements.',
    `prepared_timestamp` TIMESTAMP COMMENT 'Date and time when the weight and balance loadsheet was initially prepared by the loadmaster or dispatcher.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this weight and balance record was first created in the database.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this weight and balance record was last modified in the database.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or clarifications related to the weight and balance calculation.',
    `special_load_indicator` BOOLEAN COMMENT 'Flag indicating whether the flight carries special loads requiring additional handling or documentation (dangerous goods, live animals, human remains, etc.).',
    `takeoff_fuel_kg` DECIMAL(18,2) COMMENT 'Total usable fuel on board at takeoff, including trip fuel, contingency, alternate, final reserve, and additional fuel.',
    `takeoff_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the aircraft at brake release for takeoff. Calculated as zero fuel weight plus takeoff fuel. Must not exceed maximum takeoff weight.',
    `total_payload_kg` DECIMAL(18,2) COMMENT 'Total revenue payload weight including passengers, baggage, cargo, and mail.',
    `trim_setting` STRING COMMENT 'Calculated horizontal stabilizer trim setting required for takeoff based on CG position and weight. Entered into flight management system or set manually.',
    `trip_fuel_kg` DECIMAL(18,2) COMMENT 'Fuel required to fly from departure to destination airport under expected conditions.',
    `underfloor_cargo_uld_count` STRING COMMENT 'Number of unit load devices (containers and pallets) loaded in underfloor cargo holds.',
    `zero_fuel_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the aircraft excluding usable fuel. Calculated as dry operating weight plus payload (passengers, baggage, cargo). Critical structural limit.',
    CONSTRAINT pk_weight_balance PRIMARY KEY(`weight_balance_id`)
) COMMENT 'Weight and balance (W&B) loadsheet for each flight leg. Contains zero fuel weight (ZFW), takeoff weight (TOW), landing weight (LW), maximum structural weights, centre of gravity (CG) position at takeoff and landing, trim setting, load distribution by zone, passenger count by cabin class, cargo/baggage weight by hold, and loadmaster/dispatcher sign-off. Mandatory regulatory document for every commercial flight per FAA/EASA airworthiness requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`status` (
    `status_id` BIGINT COMMENT 'Unique identifier for the flight status record. Primary key.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg this status record describes. Links to the flight_leg product.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration of the aircraft currently assigned to this flight leg. May change due to aircraft swaps or operational adjustments.',
    `altitude_feet` STRING COMMENT 'Current altitude of the aircraft in feet above mean sea level. Updated from ACARS or ADS-B feeds during flight.',
    `arrival_gate` STRING COMMENT 'Current gate assignment for arrival. May be updated during flight based on airport operations and gate availability.',
    `atc_slot_time` TIMESTAMP COMMENT 'Allocated takeoff or landing slot time assigned by ATC. Critical for slot-controlled airports and ATFM (Air Traffic Flow Management) compliance.',
    `boarding_start_time` TIMESTAMP COMMENT 'Actual time when passenger boarding commenced at the departure gate. Used for operational metrics and passenger communication.',
    `boarding_status` STRING COMMENT 'Current boarding process status. Indicates the stage of passenger boarding operations at the departure gate.. Valid values are `not_started|boarding|final_call|gate_closed|completed`',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for flight cancellation if status is cancelled. Used for operational analysis and passenger compensation processing.',
    `delay_minutes` STRING COMMENT 'Total delay in minutes compared to scheduled departure or arrival time. Used for OTP (On-Time Performance) reporting and DOT compliance.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the primary cause of delay if the flight is delayed. Used for operational analysis and regulatory reporting.',
    `departure_gate` STRING COMMENT 'Current gate assignment for departure. May change during operational disruptions or gate reassignments.',
    `diversion_airport_code` STRING COMMENT 'IATA three-letter airport code of the diversion airport if the flight was diverted. Null if no diversion occurred.. Valid values are `^[A-Z]{3}$`',
    `estimated_arrival_time` TIMESTAMP COMMENT 'Current best estimate of when the flight will arrive at the destination gate. Updated dynamically based on flight progress and conditions. Used for passenger notifications and ground operations planning.',
    `estimated_departure_time` TIMESTAMP COMMENT 'Current best estimate of when the flight will depart from the gate. Updated dynamically based on operational conditions. Used for passenger notifications and airport FIDS displays.',
    `fids_published_flag` BOOLEAN COMMENT 'Indicates whether this status has been published to airport FIDS displays. Used for display synchronization and audit purposes.',
    `flight_phase` STRING COMMENT 'Current phase of flight operations. Provides granular operational state for real-time tracking and operational control center monitoring. [ENUM-REF-CANDIDATE: pre_departure|taxi_out|takeoff|climb|cruise|descent|approach|landing|taxi_in|arrived — 10 candidates stripped; promote to reference product]',
    `gate_closure_time` TIMESTAMP COMMENT 'Actual time when the departure gate was closed and no further passengers were accepted for boarding. Critical for on-time departure metrics.',
    `gds_distribution_timestamp` TIMESTAMP COMMENT 'Timestamp when this status was distributed to GDS systems (Amadeus, Sabre, Travelport). Used for external partner data synchronization tracking.',
    `ground_speed_knots` STRING COMMENT 'Current ground speed of the aircraft in knots. Updated from ACARS or ADS-B feeds during flight for ETA calculation.',
    `in_time` TIMESTAMP COMMENT 'Actual time when aircraft arrived at the arrival gate and parking brake was set. Final event in OOOI sequence. Used for block time and turnaround planning.',
    `is_irop` BOOLEAN COMMENT 'Indicates whether this flight is currently under irregular operations status requiring special handling, rebooking, or recovery procedures.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether passenger notifications (SMS, email, push) have been sent for this status update. Used to prevent duplicate notifications.',
    `occ_remarks` STRING COMMENT 'Internal operational notes or remarks entered by OCC staff regarding this flight status. Used for operational coordination and handover communication.',
    `off_time` TIMESTAMP COMMENT 'Actual time when aircraft wheels left the ground at departure. Second event in OOOI sequence. Used for airborne time calculation.',
    `on_time` TIMESTAMP COMMENT 'Actual time when aircraft wheels touched down at destination. Third event in OOOI sequence. Used for flight time and arrival metrics.',
    `out_time` TIMESTAMP COMMENT 'Actual time when aircraft pushed back from the gate or began taxi. First event in OOOI (Out-Off-On-In) sequence. Used for block time calculation.',
    `position_latitude` DECIMAL(18,2) COMMENT 'Current latitude coordinate of the aircraft in decimal degrees. Updated from ACARS or ADS-B feeds during flight for real-time tracking.',
    `position_longitude` DECIMAL(18,2) COMMENT 'Current longitude coordinate of the aircraft in decimal degrees. Updated from ACARS or ADS-B feeds during flight for real-time tracking.',
    `public_status_message` STRING COMMENT 'Customer-facing status message displayed on airport FIDS, mobile apps, and passenger notifications. Provides human-readable explanation of current flight status.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight status record was first created in the system. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight status record was last modified. Used for audit trail and change tracking.',
    `status_code` STRING COMMENT 'Current operational state of the flight leg. Represents the lifecycle stage from scheduled through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|boarding|departed|airborne|landed|arrived|cancelled|diverted|delayed|returned — 10 candidates stripped; promote to reference product]',
    `status_source` STRING COMMENT 'System or channel that provided this status update. Indicates the origin of the status information for data quality and reconciliation purposes.. Valid values are `acars|atc_feed|airport_fids|occ_manual|gds_update|pss_system`',
    `status_timestamp` TIMESTAMP COMMENT 'Date and time when this status was recorded or became effective. Represents the business event time for this status change.',
    `weather_condition_code` STRING COMMENT 'Current weather condition code at departure or arrival airport affecting flight status. Used for delay attribution and operational decision-making.',
    CONSTRAINT pk_status PRIMARY KEY(`status_id`)
) COMMENT 'Real-time and historical flight status records providing the current operational state of a flight leg at any point in time. Contains status code (scheduled, boarding, departed, airborne, landed, arrived, cancelled, diverted, delayed), status timestamp, source system (ACARS, ATC feed, airport FIDS, manual OCC update), estimated departure/arrival times (ETD/ETA), gate information, and public-facing status message. Supports real-time passenger notifications, airport FIDS, and OCC monitoring via NetLine/Ops.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`booking_segment` (
    `booking_segment_id` BIGINT COMMENT 'Primary key uniquely identifying this passenger-flight booking segment',
    `booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking_passenger. Business justification: The DCS booking_segment must reference the reservation_booking_passenger to link the operational boarding record to the per-passenger reservation record for check-in reconciliation, IROP rebooking, an',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Check-in, upgrade processing, and baggage entitlement lookup all require resolving booking_segments cabin to the cabin_class master record for service level, baggage allowance, and lounge access rule',
    `checkin_session_id` BIGINT COMMENT 'Foreign key linking to airport.checkin_session. Business justification: A booking segment is fulfilled through a check-in session — the core passenger processing workflow. Linking booking_segment to checkin_session enables check-in status reconciliation, upgrade processin',
    `e_ticket_id` BIGINT COMMENT 'Foreign key linking to reservation.e_ticket. Business justification: Departure Control Systems must validate and lift e-ticket coupons at boarding. The booking_segment (DCS record) must reference the e_ticket for coupon status updates and revenue coupon reconciliation.',
    `fare_id` BIGINT COMMENT 'Foreign key linking to revenue.fare. Business justification: Fare audit and revenue integrity reporting requires verifying that the fare applied to each booking segment matches a valid filed fare. Revenue management teams use this link to detect fare leakage an',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: At check-in and boarding, the system must identify the passengers FFP membership to apply tier benefits (priority boarding, lounge access, upgrade eligibility) and trigger mileage accrual. Aviation d',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to the specific flight leg on which this passenger is booked',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Departure Control System reconciles boarded passengers against booked itinerary segments for coupon lifting, revenue accounting, and IROP rebooking. Aviation domain experts universally expect the DCS ',
    `minor_guardian_id` BIGINT COMMENT 'Foreign key linking to passenger.minor_guardian. Business justification: Unaccompanied minor (UM) handling requires ground staff and cabin crew to verify guardian authorization for each specific booking segment at departure and arrival gates. Airlines must confirm guardian',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the passenger profile for the traveler on this segment',
    `pnr_id` BIGINT COMMENT 'Reference to the Passenger Name Record (PNR) that contains this booking segment. Multiple segments may belong to the same PNR for multi-leg journeys.',
    `pricing_record_id` BIGINT COMMENT 'Foreign key linking to revenue.pricing_record. Business justification: Revenue integrity audit requires linking each booked segment to the pricing record capturing the exact fare quote applied at booking time. This enables post-ticketing fare audit, GDS pricing discrepan',
    `seat_assignment_id` BIGINT COMMENT 'Foreign key linking to ancillary.seat_assignment. Business justification: Check-in and boarding pass generation systems resolve a passengers seat from their booking segment record. This direct FK enables check-in agents to retrieve seat assignment details (seat number, cab',
    `seat_availability_id` BIGINT COMMENT 'Foreign key linking to inventory.seat_availability. Business justification: Revenue integrity audits and RM performance analysis require knowing which seat_availability snapshot governed each booking. Post-booking reconciliation (did the booking consume the correct bucket/ava',
    `seat_map_id` BIGINT COMMENT 'Foreign key linking to fleet.seat_map. Business justification: Seat assignment on a booking segment must reference a specific seat_map row to validate seat attributes (exit row, bulkhead, fee tier, accessibility). Ancillary seat fee calculation, check-in seat val',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: Check-in and boarding agents verify ticket validity against the booking segment in real time. Linking booking_segment to ticket enables ticket lift reconciliation, coupon status validation, and involu',
    `baggage_allowance` STRING COMMENT 'The checked baggage allowance for this passenger on this flight segment, expressed as piece concept (e.g., 2PC) or weight concept (e.g., 23KG).',
    `boarding_sequence` STRING COMMENT 'Numeric boarding priority assigned to this passenger for this flight, determining boarding group and order. Lower numbers board first.',
    `boarding_timestamp` TIMESTAMP COMMENT 'Date and time when the passengers boarding pass was scanned at the gate and they boarded the aircraft for this flight leg. UTC timestamp.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the passenger completed check-in for this flight segment, either online, mobile, kiosk, or airport counter. UTC timestamp.',
    `segment_created_timestamp` TIMESTAMP COMMENT 'Date and time when this booking segment was created in the reservation system. UTC timestamp.',
    `segment_status` STRING COMMENT 'Current status of this booking segment in its lifecycle. Tracks progression from booking through travel completion.',
    `segment_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this booking segment was last modified. Updated on any change to segment details. UTC timestamp.',
    `special_service_requests` STRING COMMENT 'Comma-separated list of IATA SSR codes for special services requested for this passenger on this flight (e.g., WCHR, VGML, PETC).',
    `standby_priority` STRING COMMENT 'Priority ranking for standby passengers on this flight segment. Lower numbers have higher priority for available seats. Null if passenger is confirmed.',
    `upgrade_status` STRING COMMENT 'Status of any cabin upgrade request or confirmation for this passenger on this flight segment. NONE=no upgrade, REQUESTED=waitlisted, CONFIRMED=upgrade confirmed, CLEARED=upgrade processed at gate, DENIED=upgrade denied.',
    CONSTRAINT pk_booking_segment PRIMARY KEY(`booking_segment_id`)
) COMMENT 'This association product represents the operational booking/reservation segment linking a passenger to a specific flight leg. It captures the passengers journey on a single flight, including seat assignment, boarding details, check-in status, fare information, and service entitlements. Each record represents one passengers travel on one flight leg. This is the core operational entity referenced by check-in systems, boarding gate systems, departure control, and in-flight service systems. Aligns with Amadeus Altéa PNR segment concept.. Existence Justification: In airline operations, the relationship between flight legs and passenger profiles is a canonical many-to-many: each flight leg carries many passengers (typically 100-400 depending on aircraft), and each passenger travels on many flight legs over their lifetime and even within a single journey (multi-leg itineraries). This relationship is operationally managed as booking segments or PNR segments in reservation systems like Amadeus Altéa, with rich attributes including seat assignments, check-in/boarding timestamps, fare details, and service entitlements that belong to neither the flight nor the passenger alone.';

CREATE OR REPLACE TABLE `airlines_ecm`.`flight`.`irop_flight_impact` (
    `irop_flight_impact_id` BIGINT COMMENT 'Primary key for the irop_flight_impact association',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to the specific flight leg affected by this IROP event.',
    `irop_event_id` BIGINT COMMENT 'Foreign key linking to the irregular operations event that caused this flight impact.',
    `delay_minutes_attributed` BIGINT COMMENT 'The portion of this flight legs total delay minutes directly attributable to this specific IROP event. Distinct from delay_minutes on flight_leg (which is total delay from all causes). Required for regulatory reporting, passenger compensation eligibility determination, and IROP financial impact reconciliation when multiple IROP events affect the same flight.',
    `flight_impact_status` STRING COMMENT 'Current lifecycle state of this flight legs impact within the IROP recovery workflow. Tracks OCC progress from initial impact identification through recovery completion, independent of the overall IROP event status.',
    `impact_sequence_number` BIGINT COMMENT 'Ordinal position of this flight leg within the IROP events recovery prioritization sequence. OCC planners assign sequence numbers to determine the order in which affected flights are recovered. Belongs to the association because sequence is relative to the IROP event, not an intrinsic property of the flight leg.',
    `impact_type` STRING COMMENT 'Classification of how this IROP event affected this specific flight leg. Distinct from flight_status on flight_leg — captures the IROP-specific outcome (e.g., a flight may have been recovered without a formal cancellation but still had an IROP impact type of DELAYED).',
    `recovery_action_taken` STRING COMMENT 'Specific recovery action applied to this flight leg under this IROP event by OCC. Examples include aircraft swap, crew reassignment, passenger reprotection, flight merge, or delay absorption. Belongs to the association because the same IROP event may trigger different recovery actions for different affected flights.',
    CONSTRAINT pk_irop_flight_impact PRIMARY KEY(`irop_flight_impact_id`)
) COMMENT 'This association product represents the operational impact event between a declared irregular operations event and a specific flight leg. It captures the per-flight impact record that OCC dispatchers and recovery planners actively manage during IROP recovery workflows. Each record links one flight_irop_event to one flight_leg and carries attributes that exist only in the context of this specific event-flight pairing — including the type of impact, recovery action taken, delay minutes attributable to this event, and the flights position in the recovery sequence. Recognized as a core operational concept in airline OCC systems such as Lufthansa Systems NetLine/Ops.. Existence Justification: In airline operations, a single IROP event (e.g., a weather ground stop at a hub) simultaneously affects dozens of flight legs, and a single flight leg can be impacted by multiple IROP events (e.g., a crew shortage compounded by an ATC ground stop on the same day). The Operations Control Center actively manages which specific flights are impacted by each declared IROP, tracking per-flight impact type, recovery actions taken, and delay minutes attributed to that specific event — data that belongs neither to the IROP event record nor to the flight leg record alone. This relationship is a recognized operational concept in airline OCC systems (e.g., NetLine/Ops irop_flight_impact) that dispatchers and recovery planners create, update, and close as part of the IROP recovery workflow.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `airlines_ecm`.`flight`.`plan`(`plan_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_superseded_by_release_dispatch_release_id` FOREIGN KEY (`superseded_by_release_dispatch_release_id`) REFERENCES `airlines_ecm`.`flight`.`dispatch_release`(`dispatch_release_id`);
ALTER TABLE `airlines_ecm`.`flight`.`plan` ADD CONSTRAINT `fk_flight_plan_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`plan` ADD CONSTRAINT `fk_flight_plan_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ADD CONSTRAINT `fk_flight_oooi_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ADD CONSTRAINT `fk_flight_fuel_uplift_dispatch_release_id` FOREIGN KEY (`dispatch_release_id`) REFERENCES `airlines_ecm`.`flight`.`dispatch_release`(`dispatch_release_id`);
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ADD CONSTRAINT `fk_flight_fuel_uplift_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_irop_event_id` FOREIGN KEY (`irop_event_id`) REFERENCES `airlines_ecm`.`flight`.`irop_event`(`irop_event_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_dispatch_release_id` FOREIGN KEY (`dispatch_release_id`) REFERENCES `airlines_ecm`.`flight`.`dispatch_release`(`dispatch_release_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_irop_event_id` FOREIGN KEY (`irop_event_id`) REFERENCES `airlines_ecm`.`flight`.`irop_event`(`irop_event_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_irop_event_id` FOREIGN KEY (`irop_event_id`) REFERENCES `airlines_ecm`.`flight`.`irop_event`(`irop_event_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ADD CONSTRAINT `fk_flight_weight_balance_dispatch_release_id` FOREIGN KEY (`dispatch_release_id`) REFERENCES `airlines_ecm`.`flight`.`dispatch_release`(`dispatch_release_id`);
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ADD CONSTRAINT `fk_flight_weight_balance_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`status` ADD CONSTRAINT `fk_flight_status_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ADD CONSTRAINT `fk_flight_irop_flight_impact_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ADD CONSTRAINT `fk_flight_irop_flight_impact_irop_event_id` FOREIGN KEY (`irop_event_id`) REFERENCES `airlines_ecm`.`flight`.`irop_event`(`irop_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`flight` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`flight` SET TAGS ('dbx_domain' = 'flight');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` SET TAGS ('dbx_subdomain' = 'schedule_planning');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight Identifier');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Arrival Airport Code');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `arrival_terminal` SET TAGS ('dbx_business_glossary_term' = 'Arrival Terminal');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `codeshare_indicator` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `day_of_week_pattern` SET TAGS ('dbx_business_glossary_term' = 'Day of Week Operating Pattern');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `day_of_week_pattern` SET TAGS ('dbx_value_regex' = '^[0-7]{7}$');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Departure Airport Code');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `departure_terminal` SET TAGS ('dbx_business_glossary_term' = 'Departure Terminal');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `etops_approval_indicator` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Approval Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `flight_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Flight Distance (Kilometers)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `meal_service_code` SET TAGS ('dbx_business_glossary_term' = 'Meal Service Code');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `meal_service_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `minimum_connecting_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Connecting Time (MCT) Minutes');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Published Date');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|conditional|denied');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `route_network_type` SET TAGS ('dbx_business_glossary_term' = 'Route Network Type');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `route_network_type` SET TAGS ('dbx_value_regex' = 'hub_spoke|point_to_point|regional_feeder|long_haul_international|domestic_trunk');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|seasonal_inactive|pending_approval');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `schedule_version_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `scheduled_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Time of Arrival (STA)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `scheduled_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Time of Departure (STD)');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'passenger|cargo|ferry|charter|positioning');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `traffic_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Traffic Restriction Code');
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ALTER COLUMN `wet_lease_indicator` SET TAGS ('dbx_business_glossary_term' = 'Wet Lease Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` SET TAGS ('dbx_subdomain' = 'schedule_planning');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `codeshare_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight Identifier');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time (ATA)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Time (ATD)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `airborne_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Airborne Time (Hours)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration (Tail Number)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `arrival_terminal` SET TAGS ('dbx_business_glossary_term' = 'Arrival Terminal');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `arrival_terminal` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `block_hours` SET TAGS ('dbx_business_glossary_term' = 'Block Hours');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `delay_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Code');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `delay_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `departure_terminal` SET TAGS ('dbx_business_glossary_term' = 'Departure Terminal');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `departure_terminal` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `dispatch_release_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Number');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `dispatch_release_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `diversion_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Diversion Airport Code');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `diversion_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `estimated_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Time (ETA)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `estimated_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Departure Time (ETD)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `flight_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Status');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `flight_status_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flight Status Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `fuel_uplift_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `in_time` SET TAGS ('dbx_business_glossary_term' = 'In Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `is_codeshare` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Flight Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `off_time` SET TAGS ('dbx_business_glossary_term' = 'Off Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `on_time` SET TAGS ('dbx_business_glossary_term' = 'On Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `operating_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Date');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `out_time` SET TAGS ('dbx_business_glossary_term' = 'Out Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `public_status_message` SET TAGS ('dbx_business_glossary_term' = 'Public Status Message');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `scheduled_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Time');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `scheduled_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Time');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `status_source` SET TAGS ('dbx_business_glossary_term' = 'Status Source System');
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ALTER COLUMN `status_source` SET TAGS ('dbx_value_regex' = 'acars|atc_feed|airport_fids|manual_occ|gds|netline_ops');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` SET TAGS ('dbx_subdomain' = 'schedule_planning');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `dispatch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `etops_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Etops Authorization Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Captain Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `release_id` SET TAGS ('dbx_business_glossary_term' = 'Release Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `superseded_by_release_dispatch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Release Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `aircraft_type` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `aircraft_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `alternate_airport_1_icao` SET TAGS ('dbx_business_glossary_term' = 'Alternate Airport 1 ICAO (International Civil Aviation Organization) Code');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `alternate_airport_1_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `alternate_airport_2_icao` SET TAGS ('dbx_business_glossary_term' = 'Alternate Airport 2 ICAO (International Civil Aviation Organization) Code');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `alternate_airport_2_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `alternate_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Alternate Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `captain_name` SET TAGS ('dbx_business_glossary_term' = 'Captain Name');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `captain_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Captain Sign-Off Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `contingency_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Contingency Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `departure_airport_icao` SET TAGS ('dbx_business_glossary_term' = 'Departure Airport ICAO (International Civil Aviation Organization) Code');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `departure_airport_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `departure_metar` SET TAGS ('dbx_business_glossary_term' = 'Departure METAR (Meteorological Aerodrome Report)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `destination_airport_icao` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport ICAO (International Civil Aviation Organization) Code');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `destination_airport_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `destination_metar` SET TAGS ('dbx_business_glossary_term' = 'Destination METAR (Meteorological Aerodrome Report)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `destination_taf` SET TAGS ('dbx_business_glossary_term' = 'Destination TAF (Terminal Aerodrome Forecast)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `dispatcher_license_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher License Number');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `dispatcher_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `dispatcher_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `dispatcher_name` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher Name');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `dispatcher_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher Sign-Off Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `estimated_block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `estimated_flight_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Flight Time (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `etops_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Authorization Flag');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `etops_entry_point` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Entry Point');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `etops_exit_point` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Exit Point');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `final_reserve_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Final Reserve Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `hazmat_onboard_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Onboard Flag');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `landing_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Landing Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `mel_items_accepted_count` SET TAGS ('dbx_business_glossary_term' = 'MEL (Minimum Equipment List) Items Accepted Count');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `mel_items_summary` SET TAGS ('dbx_business_glossary_term' = 'MEL (Minimum Equipment List) Items Summary');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `minimum_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `notam_briefing_package` SET TAGS ('dbx_business_glossary_term' = 'NOTAM (Notice to Air Missions) Briefing Package');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `planned_cruise_altitude_ft` SET TAGS ('dbx_business_glossary_term' = 'Planned Cruise Altitude (Feet)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `planned_cruise_speed_kts` SET TAGS ('dbx_business_glossary_term' = 'Planned Cruise Speed (Knots)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `planned_fuel_uplift_kg` SET TAGS ('dbx_business_glossary_term' = 'Planned Fuel Uplift (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'FAA|EASA|TCCA|CASA|CAAC');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `release_issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Issued Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Status');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|issued|superseded|cancelled');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `release_version_number` SET TAGS ('dbx_business_glossary_term' = 'Release Version Number');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `route_description` SET TAGS ('dbx_business_glossary_term' = 'Route Description');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Notes');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `takeoff_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Takeoff Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `trip_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Trip Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `weather_briefing_package` SET TAGS ('dbx_business_glossary_term' = 'Weather Briefing Package');
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ALTER COLUMN `zero_fuel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Zero Fuel Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`plan` SET TAGS ('dbx_subdomain' = 'schedule_planning');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Plan Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `block_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Block Time Standard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Accepted By Pilot-In-Command (PIC) Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `alternate_airport_1_icao` SET TAGS ('dbx_business_glossary_term' = 'Alternate Airport 1 ICAO Code');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `alternate_airport_1_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `alternate_airport_2_icao` SET TAGS ('dbx_business_glossary_term' = 'Alternate Airport 2 ICAO Code');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `alternate_airport_2_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `alternate_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Alternate Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `arrival_airport_icao` SET TAGS ('dbx_business_glossary_term' = 'Arrival Airport ICAO Code');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `arrival_airport_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `contingency_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Contingency Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `cost_index` SET TAGS ('dbx_business_glossary_term' = 'Cost Index (CI)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `cruise_altitude_ft` SET TAGS ('dbx_business_glossary_term' = 'Cruise Altitude (Feet)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `cruise_speed_kts` SET TAGS ('dbx_business_glossary_term' = 'Cruise Speed (Knots)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `departure_airport_icao` SET TAGS ('dbx_business_glossary_term' = 'Departure Airport ICAO Code');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `departure_airport_icao` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `etops_entry_point` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Entry Point');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `etops_exit_point` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Exit Point');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `etops_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Qualified Flag');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filed Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `final_reserve_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Final Reserve Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `landing_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Landing Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `operational_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operational Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Plan Status');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'filed|amended|operational|cancelled|rejected|superseded');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `planned_block_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Block Hours');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `planned_flight_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Flight Time (Hours)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `planned_taxi_in_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Taxi-In Time (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `planned_taxi_out_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Taxi-Out Time (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `route_of_flight` SET TAGS ('dbx_business_glossary_term' = 'Route of Flight');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `step_climb_schedule` SET TAGS ('dbx_business_glossary_term' = 'Step Climb Schedule');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `takeoff_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Takeoff Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `total_fuel_required_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Fuel Required (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `trip_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Trip Fuel (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `wind_data_source` SET TAGS ('dbx_business_glossary_term' = 'Wind Data Source');
ALTER TABLE `airlines_ecm`.`flight`.`plan` ALTER COLUMN `zero_fuel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Zero Fuel Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `oooi_event_id` SET TAGS ('dbx_business_glossary_term' = 'Out-Off-On-In (OOOI) Event Identifier');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `acars_message_label` SET TAGS ('dbx_business_glossary_term' = 'ACARS Message Label');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `acars_message_number` SET TAGS ('dbx_business_glossary_term' = 'ACARS Message Number');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `airport_code` SET TAGS ('dbx_business_glossary_term' = 'Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `altitude_feet` SET TAGS ('dbx_business_glossary_term' = 'Altitude in Feet');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `correction_reason` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason Description');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'VERIFIED|ESTIMATED|CORRECTED|DISPUTED|PENDING');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'ACARS|ADS-B|MANUAL|FMS|OOOI_SENSOR|GROUND_SYSTEM');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `delay_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Delay Code');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Minutes');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `event_timestamp_local` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp Local Time');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'OOOI Event Type');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'OUT|OFF|ON|IN');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `gate_stand` SET TAGS ('dbx_business_glossary_term' = 'Gate or Stand Identifier');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `ground_speed_knots` SET TAGS ('dbx_business_glossary_term' = 'Ground Speed in Knots');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `is_corrected` SET TAGS ('dbx_business_glossary_term' = 'Is Corrected Event Flag');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Event Flag');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `original_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Original Event Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `otp_eligible` SET TAGS ('dbx_business_glossary_term' = 'On-Time Performance (OTP) Eligible Flag');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Processed Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Received Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `reporting_status` SET TAGS ('dbx_value_regex' = 'REPORTED|UNREPORTED|EXCLUDED|AMENDED');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `runway_identifier` SET TAGS ('dbx_business_glossary_term' = 'Runway Identifier');
ALTER TABLE `airlines_ecm`.`flight`.`oooi_event` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Event Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` SET TAGS ('dbx_subdomain' = 'schedule_planning');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_uplift_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift ID');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `dispatch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `carbon_emission_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission (Kilograms CO2)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Batch Number');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_density` SET TAGS ('dbx_business_glossary_term' = 'Fuel Density (kg/L)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Fuel Price Currency Code');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Price per Unit');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quality Certificate Number');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_quality_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_quantity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity (Pounds)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_quantity_litres` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity (Litres)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Fuel Temperature (Celsius)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Ticket Number');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'Jet-A|Jet-A1|JP-8|TS-1|Avgas');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_uplift_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Status');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fuel_uplift_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|disputed');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fueling_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Fueling Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fueling_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fueling Start Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `fueling_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fueling Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `into_plane_agent` SET TAGS ('dbx_business_glossary_term' = 'Into-Plane Agent');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_account|cash|card|prepaid');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `post_fueling_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Post-Fueling Quantity on Board (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `pre_fueling_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Pre-Fueling Quantity on Board (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `total_fuel_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Fuel Cost');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `total_fuel_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_record_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Record Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `absence_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `irop_event_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Irop Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `affected_passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Passenger (Pax) Count');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `compensation_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Issued Flag');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `compensation_issued_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `compensation_issued_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'netline_ops|jeppesen|manual_entry|acars|other');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_category` SET TAGS ('dbx_business_glossary_term' = 'Delay Category');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Delay Cost Estimate in United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Description Narrative');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Minutes');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay End Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Notification Sent Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Delay Sequence Number');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Start Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_status` SET TAGS ('dbx_business_glossary_term' = 'Delay Record Status');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_status` SET TAGS ('dbx_value_regex' = 'open|resolved|under_investigation|closed|disputed');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `delay_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Verification Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `is_controllable_delay` SET TAGS ('dbx_business_glossary_term' = 'Controllable Delay Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `is_reactionary_delay` SET TAGS ('dbx_business_glossary_term' = 'Reactionary Delay Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `is_reportable_to_dot` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Reportable Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `missed_connection_count` SET TAGS ('dbx_business_glossary_term' = 'Missed Connection Count');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `primary_delay_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Delay Code');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `primary_delay_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `record_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `responsible_department_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Code');
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ALTER COLUMN `responsible_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `diversion_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `dispatch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `irop_event_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Irop Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `actual_gate_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Gate Arrival Timestamp at Diversion Airport');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `actual_landing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Landing Timestamp at Diversion Airport');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `airport_icao_code` SET TAGS ('dbx_business_glossary_term' = 'Diversion Airport Code (ICAO)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `airport_icao_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `atc_coordination_reference` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Coordination Reference');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `compensation_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Eligibility Flag');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `compensation_eligibility_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `compensation_eligibility_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `continuation_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Continuation Departure Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `continuation_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Continuation Flight Number');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `crew_duty_time_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Duty Time Impact Flag');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Diversion Decision Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `dispatch_release_updated_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Updated Flag');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Diversion Disposition Action');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'continued_to_destination|returned_to_origin|cancelled|aircraft_swap|overnight_recovery');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `diversion_number` SET TAGS ('dbx_business_glossary_term' = 'Diversion Reference Number');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `diversion_number` SET TAGS ('dbx_value_regex' = '^DIV[0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `diversion_status` SET TAGS ('dbx_business_glossary_term' = 'Diversion Status');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `diversion_status` SET TAGS ('dbx_value_regex' = 'declared|in_progress|landed|resolved|cancelled');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `fuel_uplift_at_diversion_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift at Diversion Airport (Kilograms)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `ground_time_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Ground Time Duration at Diversion Airport (Minutes)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `hotel_accommodation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Hotel Accommodation Provided Flag');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `meal_voucher_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Voucher Provided Flag');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `notam_reference` SET TAGS ('dbx_business_glossary_term' = 'Notice to Air Missions (NOTAM) Reference');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `passenger_care_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Passenger Care Action Taken');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `passenger_count_diverted` SET TAGS ('dbx_business_glossary_term' = 'Passenger (Pax) Count Diverted');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `planned_destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Planned Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `planned_destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Diversion Reason Code');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Diversion Reason Description');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `regulatory_report_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Required Flag');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `regulatory_report_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `safety_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Report Reference Number');
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ALTER COLUMN `weather_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Weather (WX) Condition Description');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `irop_event_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Irregular Operations (IROP) Event ID');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `actual_passengers_affected` SET TAGS ('dbx_business_glossary_term' = 'Actual Passengers Affected');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `actual_total_delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Delay Minutes');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `atc_coordination_notes` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Coordination Notes');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `cdm_session_reference` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Session Reference');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact Amount');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `estimated_passengers_affected` SET TAGS ('dbx_business_glossary_term' = 'Estimated Passengers Affected');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `estimated_total_delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Delay Minutes');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Event Code');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Event Description');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Event End Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Event Start Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Event Status');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|monitoring|resolved|closed');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Event Type');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'weather|atc_ground_stop|airport_closure|aircraft_aog|crew_shortage|security');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `flights_cancelled_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Cancelled Count');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `flights_delayed_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Delayed Count');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `flights_diverted_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Diverted Count');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `notam_reference` SET TAGS ('dbx_business_glossary_term' = 'Notice to Air Missions (NOTAM) Reference');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `passenger_compensation_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Compensation Triggered Flag');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `passenger_compensation_triggered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `passenger_compensation_triggered_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `recovery_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Recovery Plan Description');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `recovery_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Plan Status');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `recovery_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|executing|completed');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Severity Level');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ALTER COLUMN `weather_condition_summary` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Summary');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `cancellation_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Cancellation ID');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `absence_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `irop_event_id` SET TAGS ('dbx_business_glossary_term' = 'IROP (Irregular Operations) Event ID');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight ID');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `advance_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Hours');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `affected_passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `atc_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'ATC (Air Traffic Control) Restriction Type');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `atc_restriction_type` SET TAGS ('dbx_value_regex' = 'SLOT|GDP|GS|CLOSURE|CAPACITY|FLOW');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Type');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_value_regex' = 'PROACTIVE|REACTIVE');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `compensation_amount_per_passenger` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount Per Passenger');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `compensation_amount_per_passenger` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `compensation_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Passenger Compensation Eligibility Status');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `compensation_eligibility_status` SET TAGS ('dbx_value_regex' = 'ELIGIBLE|NOT_ELIGIBLE|UNDER_REVIEW|PAID');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `compensation_eligibility_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `compensation_eligibility_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `crew_legality_issue` SET TAGS ('dbx_business_glossary_term' = 'Crew Legality Issue Type');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `crew_legality_issue` SET TAGS ('dbx_value_regex' = 'DUTY_TIME|REST|QUALIFICATION|AVAILABILITY|POSITIONING');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Decision Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Effective Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `estimated_revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact Amount');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `estimated_revenue_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `first_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Passenger Notification Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `is_controllable` SET TAGS ('dbx_business_glossary_term' = 'Is Controllable Cancellation');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `is_dot_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is DOT (Department of Transportation) Reportable');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `network_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Optimization Cancellation Flag');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Passenger Notification Method');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `occ_remarks` SET TAGS ('dbx_business_glossary_term' = 'OCC (Operations Control Center) Remarks');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `passenger_care_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Passenger Care Cost Amount');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `passenger_care_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `rebooked_passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Rebooked Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `refunded_passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Refunded Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `regulatory_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `substitute_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Substitute Flight Departure Time');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `substitute_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Substitute Flight Number');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `substitute_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `weather_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Code');
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ALTER COLUMN `weather_condition_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` SET TAGS ('dbx_subdomain' = 'schedule_planning');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `weight_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Weight and Balance (W&B) ID');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `dispatch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Release Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loadmaster Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `baggage_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Baggage Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `captain_acceptance_signature` SET TAGS ('dbx_business_glossary_term' = 'Captain Acceptance Signature');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `captain_acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Captain Acceptance Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Cargo Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `cg_aft_limit_percent_mac` SET TAGS ('dbx_business_glossary_term' = 'Centre of Gravity (CG) Aft Limit Percent Mean Aerodynamic Chord (MAC)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `cg_forward_limit_percent_mac` SET TAGS ('dbx_business_glossary_term' = 'Centre of Gravity (CG) Forward Limit Percent Mean Aerodynamic Chord (MAC)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `cg_landing_percent_mac` SET TAGS ('dbx_business_glossary_term' = 'Centre of Gravity (CG) at Landing Percent Mean Aerodynamic Chord (MAC)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `cg_takeoff_percent_mac` SET TAGS ('dbx_business_glossary_term' = 'Centre of Gravity (CG) at Takeoff Percent Mean Aerodynamic Chord (MAC)');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `dispatcher_license_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Dispatcher License Number');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `dispatcher_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `dispatcher_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Dispatcher Name');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `dry_operating_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dry Operating Weight (DOW) in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loadsheet Finalized Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `hold_aft_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Aft Cargo Hold Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `hold_bulk_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Bulk Cargo Hold Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `hold_forward_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Forward Cargo Hold Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `landing_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Landing Weight (LW) in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `load_distribution_compliant` SET TAGS ('dbx_business_glossary_term' = 'Load Distribution Compliant Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `loadsheet_number` SET TAGS ('dbx_business_glossary_term' = 'Loadsheet Number');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `loadsheet_status` SET TAGS ('dbx_business_glossary_term' = 'Loadsheet Status');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `loadsheet_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|revised|cancelled');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `loadsheet_version` SET TAGS ('dbx_business_glossary_term' = 'Loadsheet Version');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `mail_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Mail Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `max_landing_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Landing Weight (MLW) in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `max_takeoff_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Takeoff Weight (MTOW) in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `max_zero_fuel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Zero Fuel Weight (MZFW) in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `passenger_count_business` SET TAGS ('dbx_business_glossary_term' = 'Business Class Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `passenger_count_economy` SET TAGS ('dbx_business_glossary_term' = 'Economy Class Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `passenger_count_first` SET TAGS ('dbx_business_glossary_term' = 'First Class Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `passenger_count_premium_economy` SET TAGS ('dbx_business_glossary_term' = 'Premium Economy Class Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `passenger_count_total` SET TAGS ('dbx_business_glossary_term' = 'Total Passenger Count');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `passenger_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Passenger Weight in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `prepared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loadsheet Prepared Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Loadsheet Remarks');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `special_load_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Load Indicator');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `takeoff_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Takeoff Fuel in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `takeoff_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Takeoff Weight (TOW) in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `total_payload_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Payload in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `trim_setting` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Stabilizer Trim Setting');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `trip_fuel_kg` SET TAGS ('dbx_business_glossary_term' = 'Trip Fuel in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `underfloor_cargo_uld_count` SET TAGS ('dbx_business_glossary_term' = 'Underfloor Cargo Unit Load Device (ULD) Count');
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ALTER COLUMN `zero_fuel_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Zero Fuel Weight (ZFW) in Kilograms');
ALTER TABLE `airlines_ecm`.`flight`.`status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`flight`.`status` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `status_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Status ID');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `altitude_feet` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Altitude Feet');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `arrival_gate` SET TAGS ('dbx_business_glossary_term' = 'Arrival Gate Assignment');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `atc_slot_time` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Slot Time');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `boarding_start_time` SET TAGS ('dbx_business_glossary_term' = 'Boarding Start Time');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `boarding_status` SET TAGS ('dbx_business_glossary_term' = 'Boarding Status');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `boarding_status` SET TAGS ('dbx_value_regex' = 'not_started|boarding|final_call|gate_closed|completed');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration Minutes');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `departure_gate` SET TAGS ('dbx_business_glossary_term' = 'Departure Gate Assignment');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `diversion_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Diversion Airport Code');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `diversion_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `estimated_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Time (ETA)');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `estimated_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Departure Time (ETD)');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `fids_published_flag` SET TAGS ('dbx_business_glossary_term' = 'Flight Information Display System (FIDS) Published Flag');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `flight_phase` SET TAGS ('dbx_business_glossary_term' = 'Flight Phase');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `gate_closure_time` SET TAGS ('dbx_business_glossary_term' = 'Gate Closure Time');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `gds_distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Distribution Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `ground_speed_knots` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Ground Speed Knots');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `in_time` SET TAGS ('dbx_business_glossary_term' = 'In Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `is_irop` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Flag');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Notification Sent Flag');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `occ_remarks` SET TAGS ('dbx_business_glossary_term' = 'Operations Control Center (OCC) Remarks');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `off_time` SET TAGS ('dbx_business_glossary_term' = 'Off Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `on_time` SET TAGS ('dbx_business_glossary_term' = 'On Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `out_time` SET TAGS ('dbx_business_glossary_term' = 'Out Time (OOOI)');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `position_latitude` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Position Latitude');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `position_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `position_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `position_longitude` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Position Longitude');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `position_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `position_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `public_status_message` SET TAGS ('dbx_business_glossary_term' = 'Public Status Message');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `status_code` SET TAGS ('dbx_business_glossary_term' = 'Flight Status Code');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `status_source` SET TAGS ('dbx_business_glossary_term' = 'Status Source System');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `status_source` SET TAGS ('dbx_value_regex' = 'acars|atc_feed|airport_fids|occ_manual|gds_update|pss_system');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `status_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`status` ALTER COLUMN `weather_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Code');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `booking_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Segment ID');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `checkin_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkin Session Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `e_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'E Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Segment - Flight Leg Id');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `minor_guardian_id` SET TAGS ('dbx_business_glossary_term' = 'Minor Guardian Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Segment - Pax Profile Id');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'PNR ID');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `pricing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `seat_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `seat_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Availability Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `seat_map_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Map Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `baggage_allowance` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `boarding_sequence` SET TAGS ('dbx_business_glossary_term' = 'Boarding Sequence Number');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `boarding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Boarding Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-in Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `segment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Created Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `segment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Updated Timestamp');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `special_service_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Service Requests');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `standby_priority` SET TAGS ('dbx_business_glossary_term' = 'Standby Priority');
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ALTER COLUMN `upgrade_status` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Status');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` SET TAGS ('dbx_association_edges' = 'flight.flight_irop_event,flight.flight_leg');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `irop_flight_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Irop Flight Impact - Irop Flight Impact Id');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Irop Flight Impact - Flight Leg Id');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `irop_event_id` SET TAGS ('dbx_business_glossary_term' = 'Irop Flight Impact - Flight Irop Event Id');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `delay_minutes_attributed` SET TAGS ('dbx_business_glossary_term' = 'Attributed Delay Minutes');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `flight_impact_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Impact Status');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `impact_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Impact Sequence Number');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `impact_type` SET TAGS ('dbx_business_glossary_term' = 'Flight Impact Type');
ALTER TABLE `airlines_ecm`.`flight`.`irop_flight_impact` ALTER COLUMN `recovery_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action');
