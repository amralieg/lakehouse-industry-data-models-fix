-- Schema for Domain: route | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`route` COMMENT 'Route network planning and schedule design data including origin-destination (O&D) route definitions, hub-and-spoke network topology, city pairs, frequencies, flight numbers, seasonal schedules, slot allocations at constrained airports, bilateral agreements, codeshare route agreements, ASK (Available Seat Kilometer) capacity planning, and network performance KPIs (OTP, load factor by route). Aligns with Jeppesen scheduling.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`city_pair` (
    `city_pair_id` BIGINT COMMENT 'Unique identifier for the origin-destination city pair. Primary key for the city pair master entity.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: City pairs define markets between specific stations. Market analysis, demand forecasting, competitive assessment, and bilateral agreement evaluation require direct station links. Role prefix origin_',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this city pair is currently active in the airlines route network. Inactive city pairs are retained for historical analysis and potential future reactivation.',
    `bilateral_agreement_code` STRING COMMENT 'Reference code for the bilateral air service agreement governing this city pair (e.g., US-UK Open Skies, US-Japan bilateral). Determines traffic rights, capacity limits, and operational freedoms.',
    `codeshare_eligible_flag` BOOLEAN COMMENT 'Indicates whether this city pair is eligible for codeshare operations under existing alliance agreements and regulatory approvals.',
    `competitive_intensity` STRING COMMENT 'Market competition classification based on number of carriers serving the city pair: monopoly (single carrier), duopoly (two carriers), oligopoly (3-5 carriers), highly_competitive (6+ carriers).. Valid values are `monopoly|duopoly|oligopoly|highly_competitive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this city pair record was first created in the system. Used for data lineage and audit trail.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the destination point of the city pair (e.g., JFK, LAX, LHR).. Valid values are `^[A-Z]{3}$`',
    `destination_city_code` STRING COMMENT 'Three-letter IATA city code for the destination metropolitan area. May differ from airport code when multiple airports serve one city (e.g., LON for LHR/LGW/STN).. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination country (e.g., USA, GBR, FRA).. Valid values are `^[A-Z]{3}$`',
    `destination_iata_region` STRING COMMENT 'IATA Traffic Conference region for the destination (TC1=Americas, TC2=Europe/Africa/Middle East, TC3=Asia/Pacific). Used for fare construction and bilateral agreement classification.. Valid values are `^TC[1-3]$`',
    `directionality` STRING COMMENT 'Indicates whether the city pair is defined as one-way (origin to destination only) or bidirectional (both directions treated as same market for analysis).. Valid values are `one_way|bidirectional`',
    `distance_band` STRING COMMENT 'Categorical classification of route length: short_haul (<1500km), medium_haul (1500-4000km), long_haul (4000-8000km), ultra_long_haul (>8000km). Used for fleet assignment, crew planning, and market segmentation.. Valid values are `short_haul|medium_haul|long_haul|ultra_long_haul`',
    `effective_from_date` DATE COMMENT 'Date when this city pair definition became effective in the airlines route network. Used for historical analysis and schedule planning.',
    `effective_to_date` DATE COMMENT 'Date when this city pair definition ceased to be effective (nullable for currently active city pairs). Used for historical analysis and route discontinuation tracking.',
    `etops_required_flag` BOOLEAN COMMENT 'Indicates whether ETOPS certification is required for twin-engine aircraft operations on this city pair due to extended overwater or remote routing beyond 60 minutes single-engine diversion time.',
    `great_circle_distance_km` DECIMAL(18,2) COMMENT 'Shortest distance between origin and destination airports measured along the surface of the Earth (great circle route), expressed in kilometers. Used for ASK and RPK calculations.',
    `great_circle_distance_miles` DECIMAL(18,2) COMMENT 'Shortest distance between origin and destination airports measured along the surface of the Earth (great circle route), expressed in statute miles. Used for mileage accrual in FFP programs.',
    `hub_spoke_classification` STRING COMMENT 'Network topology classification indicating whether the city pair connects two hubs, a hub to a spoke, two spokes, or operates as a point-to-point route outside the hub network.. Valid values are `hub_to_hub|hub_to_spoke|spoke_to_spoke|point_to_point`',
    `interline_eligible_flag` BOOLEAN COMMENT 'Indicates whether this city pair is eligible for interline ticketing agreements with partner carriers, allowing through-ticketing and baggage transfer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this city pair record was last updated. Used for change tracking and data quality monitoring.',
    `market_classification` STRING COMMENT 'Classification of the city pair market type: domestic (within same country), international (between different countries), or transborder (specific cross-border markets with special regulatory treatment, e.g., US-Canada).. Valid values are `domestic|international|transborder`',
    `market_maturity` STRING COMMENT 'Lifecycle stage of the city pair market: emerging (new route, low traffic), growth (increasing demand), mature (stable established market), declining (reducing demand).. Valid values are `emerging|growth|mature|declining`',
    `minimum_connecting_time_minutes` STRING COMMENT 'Minimum time in minutes required for passenger connections at the origin or destination hub when this city pair is part of a connecting itinerary. Used for schedule feasibility and inventory availability.',
    `origin_city_code` STRING COMMENT 'Three-letter IATA city code for the origin metropolitan area. May differ from airport code when multiple airports serve one city (e.g., NYC for JFK/LGA/EWR).. Valid values are `^[A-Z]{3}$`',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code for the origin country (e.g., USA, GBR, FRA).. Valid values are `^[A-Z]{3}$`',
    `origin_iata_region` STRING COMMENT 'IATA Traffic Conference region for the origin (TC1=Americas, TC2=Europe/Africa/Middle East, TC3=Asia/Pacific). Used for fare construction and bilateral agreement classification.. Valid values are `^TC[1-3]$`',
    `scheduled_distance_km` DECIMAL(18,2) COMMENT 'Actual flown distance based on typical flight routing including airways, ATC routing, and operational constraints. May differ from great circle distance due to airspace restrictions, weather routing, or operational procedures.',
    `seasonal_pattern` STRING COMMENT 'Typical seasonal operating pattern for this city pair: year_round (continuous service), summer_only (IATA summer season), winter_only (IATA winter season), peak_season (high-demand periods), shoulder_season (transitional periods).. Valid values are `year_round|summer_only|winter_only|peak_season|shoulder_season`',
    `slot_constrained_flag` BOOLEAN COMMENT 'Indicates whether either the origin or destination airport is slot-controlled under IATA Worldwide Slot Guidelines (Level 3 airport), requiring allocated takeoff and landing slots.',
    `time_zone_difference_hours` DECIMAL(18,2) COMMENT 'Time difference in hours between origin and destination time zones. Positive values indicate destination is ahead; negative values indicate destination is behind. Used for schedule planning and passenger communication.',
    `traffic_rights_category` STRING COMMENT 'ICAO freedom of the air classification applicable to this city pair, defining the operational rights granted under bilateral agreements (e.g., third_freedom for outbound, fourth_freedom for inbound, fifth_freedom for beyond rights). [ENUM-REF-CANDIDATE: first_freedom|second_freedom|third_freedom|fourth_freedom|fifth_freedom|sixth_freedom|seventh_freedom|eighth_freedom|ninth_freedom — 9 candidates stripped; promote to reference product]',
    `typical_block_time_minutes` STRING COMMENT 'Average scheduled block time (gate-to-gate time) in minutes for flights operating this city pair, including taxi time. Used for crew scheduling, aircraft utilization planning, and schedule design.',
    `typical_flight_time_minutes` STRING COMMENT 'Average airborne flight time in minutes for this city pair, excluding taxi time. Used for fuel planning and flight operations analysis.',
    CONSTRAINT pk_city_pair PRIMARY KEY(`city_pair_id`)
) COMMENT 'Master definition of an origin-destination (O&D) city pair — the fundamental commercial unit of the airline route network. Captures origin and destination airport/city codes, directionality (one-way vs bidirectional), great circle distance, scheduled distance, IATA region pairing (e.g., TC1-TC2), and market classification (domestic, international, transborder). Serves as the SSOT for all O&D-level demand analysis, RPK aggregation, yield reporting, and market sizing. Referenced by route, market_assessment, and interline agreements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`route` (
    `route_id` BIGINT COMMENT 'Unique identifier for the airline route. Primary key for the route master record.',
    `city_pair_id` BIGINT COMMENT 'Foreign key linking to route.city_pair. Business justification: Route operates on a specific origin-destination city pair. Currently route has origin_airport_code and destination_airport_code as separate strings. Adding city_pair_id FK normalizes this relationship',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Routes are operated under a specific legal operating entity (company code) for IFRS P&L attribution, AOC compliance reporting, and route profitability statements. Aviation finance teams require route-',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Routes are primary cost objects in airline network planning. Direct operating costs (crew, fuel, maintenance) are allocated to cost centres by route for CASK calculation, route P&L reporting, and netw',
    `station_id` BIGINT COMMENT 'FK to airport.station',
    `origin_station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Routes operate between origin and destination stations. Network planning, slot coordination, bilateral rights validation, and operational readiness all require direct station references. Role prefix ',
    `authority_type` STRING COMMENT 'Regulatory classification of the route: domestic (within single country), international (between countries), or cabotage (domestic service by foreign carrier, typically restricted).. Valid values are `domestic|international|cabotage`',
    `average_load_factor_percent` DECIMAL(18,2) COMMENT 'Historical average load factor (percentage of seats filled) for this route over the trailing 12 months. Key performance indicator for route profitability.',
    `average_otp_percent` DECIMAL(18,2) COMMENT 'Historical average on-time performance percentage (flights arriving within 15 minutes of scheduled time) for this route over the trailing 12 months.',
    `block_time_minutes` STRING COMMENT 'Standard scheduled block time in minutes from gate departure (off-blocks) at origin to gate arrival (on-blocks) at destination. Used for crew scheduling and aircraft utilization planning.',
    `codeshare_eligible` BOOLEAN COMMENT 'Flag indicating whether this route is eligible for codeshare agreements with partner airlines (true) or restricted to own-metal operations only (false).',
    `competitive_route_indicator` BOOLEAN COMMENT 'Flag indicating whether this route faces direct competition from other carriers (true) or is operated exclusively by this airline (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the system.',
    `distance_km` DECIMAL(18,2) COMMENT 'Great circle distance between origin and destination airports in kilometers. Used for ASK (Available Seat Kilometer) and RPK (Revenue Passenger Kilometer) calculations.',
    `distance_miles` DECIMAL(18,2) COMMENT 'Great circle distance between origin and destination airports in statute miles. Used for frequent flyer mileage accrual and US DOT reporting.',
    `etops_rating_minutes` STRING COMMENT 'Required ETOPS rating in minutes (e.g., 120, 180, 207, 330) for aircraft operating this route. Null if ETOPS not required.',
    `etops_required` BOOLEAN COMMENT 'Flag indicating whether this route requires ETOPS certification due to extended overwater or remote area operations beyond 60 minutes single-engine diversion time.',
    `flight_time_minutes` STRING COMMENT 'Standard airborne flight time in minutes from wheels-up at origin to wheels-down at destination, excluding taxi time.',
    `inaugural_date` DATE COMMENT 'Date when the route was first launched and entered commercial service.',
    `interline_eligible` BOOLEAN COMMENT 'Flag indicating whether this route participates in interline ticketing agreements (true), allowing through-ticketing with other carriers, or is restricted (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was last updated in the system.',
    `number_of_competitors` STRING COMMENT 'Count of other airlines operating direct service on this origin-destination pair. Zero indicates monopoly route.',
    `operating_season` STRING COMMENT 'Season during which the route operates: year-round (all seasons), summer-only (IATA summer schedule), or winter-only (IATA winter schedule).. Valid values are `year_round|summer_only|winter_only`',
    `planned_launch_date` DATE COMMENT 'Expected date for route launch for routes in planned status. Null for active or discontinued routes.',
    `profitability_tier` STRING COMMENT 'Internal classification of route profitability: tier_1 (highest margin), tier_2 (above average), tier_3 (break-even), tier_4 (loss-making). Used for strategic network decisions.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `route_code` STRING COMMENT 'Six-character alphanumeric code representing the origin-destination pair (e.g., JFKLHR for New York JFK to London Heathrow). Typically constructed as origin IATA code + destination IATA code.. Valid values are `^[A-Z]{6}$`',
    `route_status` STRING COMMENT 'Current operational status of the route: active (currently operating), suspended (temporarily halted), planned (approved but not yet launched), or discontinued (permanently ceased).. Valid values are `active|suspended|planned|discontinued`',
    `route_type` STRING COMMENT 'Classification of the route based on network topology: hub-to-hub (connecting two major hubs), hub-to-spoke (hub to regional destination), spoke-to-spoke (regional to regional), or point-to-point (direct service bypassing hubs).. Valid values are `hub_to_hub|hub_to_spoke|spoke_to_spoke|point_to_point`',
    `seasonal_indicator` BOOLEAN COMMENT 'Flag indicating whether this route operates seasonally (true) or year-round (false). Seasonal routes typically align with IATA summer/winter schedule seasons.',
    `service_type` STRING COMMENT 'Type of service operated on this route: passenger (pax only), cargo (freight only), or mixed (combination of passenger and cargo).. Valid values are `passenger|cargo|mixed`',
    `slot_controlled_destination` BOOLEAN COMMENT 'Flag indicating whether the destination airport is slot-controlled (true), requiring allocated takeoff/landing slots, or non-slot-controlled (false).',
    `slot_controlled_origin` BOOLEAN COMMENT 'Flag indicating whether the origin airport is slot-controlled (true), requiring allocated takeoff/landing slots, or non-slot-controlled (false).',
    `suspension_date` DATE COMMENT 'Date when the route was suspended or discontinued. Null if route is currently active or planned.',
    `weekly_frequency` STRING COMMENT 'Number of scheduled flights per week on this route. Used for capacity planning and network optimization.',
    CONSTRAINT pk_route PRIMARY KEY(`route_id`)
) COMMENT 'Master record for a defined airline route between an origin and destination airport pair, representing the authoritative network topology entity. Captures route code, origin and destination IATA airport codes, route type (hub-to-hub, hub-to-spoke, spoke-to-spoke, point-to-point), service type (passenger, cargo, mixed), route status (active, suspended, planned, discontinued), inaugural date, suspension date, and applicable bilateral air service agreement reference. Aligns with Jeppesen NetLine/Sched route master.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`flight_number` (
    `flight_number_id` BIGINT COMMENT 'Unique system identifier for the flight number record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Flight numbers are typically assigned with planned aircraft type for schedule publication, GDS distribution, and passenger booking. Linking to aircraft_type enables fleet assignment validation, seat i',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to route.carrier. Business justification: flight_number currently has operating_carrier_code as STRING. Normalizing to carrier.carrier_id creates proper referential integrity. The operating carrier is the airline that physically operates the ',
    `partnership_id` BIGINT COMMENT 'Reference to the codeshare agreement governing this flight number assignment. Null for operating flights. Links to the bilateral codeshare contract between marketing and operating carriers.',
    `route_id` BIGINT COMMENT 'Reference to the origin-destination route that this flight number serves. Links to the route master data defining city pairs and network topology.',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: flight_number carries a `season_code` STRING attribute that is a denormalized reference to the IATA schedule season. Adding schedule_season_id as a proper FK to schedule_season normalizes this relatio',
    `slot_allocation_id` BIGINT COMMENT 'Reference to the airport slot allocation record for constrained airports. Links to the assigned takeoff/landing time window granted by the airport coordinator or Air Traffic Control (ATC).',
    `bilateral_agreement_reference` STRING COMMENT 'Reference code or identifier for the bilateral air service agreement between countries that authorizes this route. Governs traffic rights and frequencies under international aviation treaties.',
    `block_time_minutes` STRING COMMENT 'Scheduled block time in minutes from gate departure (out) to gate arrival (in) for this flight number. Represents the total elapsed time including taxi, flight, and arrival taxi.',
    `carrier_code` STRING COMMENT 'Two-character IATA airline designator code identifying the carrier (e.g., AA for American Airlines, BA for British Airways). Used as prefix for flight numbers.. Valid values are `^[A-Z0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight number record was first created in the system. Audit trail for data lineage and compliance.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the flights destination/arrival airport (e.g., LAX, CDG, SIN).. Valid values are `^[A-Z]{3}$`',
    `direction` STRING COMMENT 'Directional classification of the flight within the route network: outbound (departing from hub), inbound (arriving at hub), circular (multi-leg routing returning to origin).. Valid values are `outbound|inbound|circular`',
    `distance_km` DECIMAL(18,2) COMMENT 'Great circle distance in kilometers between origin and destination airports. Used for Revenue Passenger Kilometer (RPK) and Available Seat Kilometer (ASK) calculations.',
    `effective_from_date` DATE COMMENT 'Date when this flight number assignment becomes active and valid for scheduling and reservations. Start of the flight numbers lifecycle.',
    `effective_to_date` DATE COMMENT 'Date when this flight number assignment expires or is discontinued. Null indicates an open-ended assignment. End of the flight numbers lifecycle.',
    `etops_certified_indicator` BOOLEAN COMMENT 'Flag indicating whether this flight operates under Extended-range Twin-engine Operational Performance Standards (ETOPS) certification for extended overwater or remote area operations (true) or standard operations (false).',
    `flight_number` STRING COMMENT 'Numeric flight number designator (1-4 digits) with optional single-letter suffix. Combined with carrier code forms the complete flight identifier (e.g., 1234, 567A).. Valid values are `^[0-9]{1,4}[A-Z]{0,1}$`',
    `flight_number_status` STRING COMMENT 'Current lifecycle status of the flight number: active (in operational use), inactive (temporarily not scheduled), suspended (operationally blocked), pending (approved but not yet active), retired (permanently discontinued).. Valid values are `active|inactive|suspended|pending|retired`',
    `flight_number_type` STRING COMMENT 'Classification of the flight number based on operational arrangement: operating (airline operates the flight), codeshare (marketing carrier sells seats on another carriers flight), wetlease (aircraft leased with crew), drylease (aircraft leased without crew), blocked (reserved but not in active use).. Valid values are `operating|codeshare|wetlease|drylease|blocked`',
    `flight_time_minutes` STRING COMMENT 'Scheduled airborne flight time in minutes from wheels-off to wheels-on. Excludes ground taxi time.',
    `frequency_pattern` STRING COMMENT 'Seven-character string indicating days of operation (1=operates, 0=does not operate) in sequence Monday through Sunday (e.g., 1111100 = Monday-Friday only, 0000011 = weekends only).. Valid values are `^[0-7]{7}$`',
    `full_flight_number` STRING COMMENT 'Complete flight number including carrier code and numeric designator (e.g., AA1234, BA567A). This is the externally-known business identifier displayed to passengers and used in reservations.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]{0,1}$`',
    `gds_distribution_indicator` BOOLEAN COMMENT 'Flag indicating whether this flight number is distributed through Global Distribution Systems (GDS) such as Amadeus, Sabre, Travelport for travel agency bookings (true) or restricted to direct channels (false).',
    `icao_carrier_code` STRING COMMENT 'Three-character ICAO airline designator code for the carrier (e.g., AAL for American Airlines, BAW for British Airways). Used in flight plans and air traffic control communications.. Valid values are `^[A-Z]{3}$`',
    `interline_eligible_indicator` BOOLEAN COMMENT 'Flag indicating whether this flight number is eligible for interline ticketing agreements with partner carriers (true) or restricted to online bookings only (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight number record was last updated. Audit trail for change tracking and data quality monitoring.',
    `marketing_carrier_code` STRING COMMENT 'IATA code of the airline that markets and sells the flight. For codeshare flights, this is the carrier whose flight number is displayed. For operating flights, this matches the carrier_code.. Valid values are `^[A-Z0-9]{2}$`',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this flight number record. Supports audit trail and accountability for schedule changes.',
    `network_hub_indicator` BOOLEAN COMMENT 'Flag indicating whether this flight serves a hub airport in the carriers hub-and-spoke network topology (true) or is a point-to-point spoke route (false).',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the flights origin/departure airport (e.g., JFK, LHR, DXB).. Valid values are `^[A-Z]{3}$`',
    `priority_ranking` STRING COMMENT 'Internal priority ranking for this flight number within the carriers network. Lower numbers indicate higher priority for resource allocation, slot protection, and operational recovery during Irregular Operations (IROP).',
    `remarks` STRING COMMENT 'Free-text field for operational notes, special handling instructions, or additional context about this flight number assignment. May include codeshare display rules, seasonal variations, or historical notes.',
    `revenue_management_class` STRING COMMENT 'Revenue management classification code used for yield optimization and inventory control strategies. Aligns with Sabre AirVision Revenue Management system classifications.',
    `seasonal_indicator` BOOLEAN COMMENT 'Flag indicating whether this flight number is assigned on a seasonal basis (true) or year-round (false). Seasonal flights typically operate during peak travel periods (summer, winter holidays).',
    `service_type` STRING COMMENT 'Type of service provided by the flight: passenger (revenue passenger service), cargo (freight only), combi (mixed passenger and cargo), ferry (non-revenue aircraft repositioning), positioning (crew or equipment repositioning).. Valid values are `passenger|cargo|combi|ferry|positioning`',
    `traffic_rights_category` STRING COMMENT 'Classification of air traffic rights under the Freedoms of the Air framework (e.g., First Freedom, Second Freedom, Third Freedom, Fourth Freedom, Fifth Freedom, Sixth Freedom, Seventh Freedom, Eighth Freedom, Ninth Freedom). Defines the scope of international route authority.',
    CONSTRAINT pk_flight_number PRIMARY KEY(`flight_number_id`)
) COMMENT 'Master record for airline flight number designators assigned to routes, capturing the IATA/ICAO carrier code prefix, numeric flight number, suffix (if applicable), direction (outbound/inbound), operating carrier, marketing carrier (for codeshare), flight number type (operating, codeshare, wetlease), effective date range, and associated route. Serves as the SSOT for flight number lifecycle management and codeshare number assignment. Aligns with Jeppesen scheduling and Amadeus Altéa inventory.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`schedule_season` (
    `schedule_season_id` BIGINT COMMENT 'Unique identifier for the IATA scheduling season record. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: IATA schedule seasons (S/W) directly drive airline budget planning cycles. Finance teams create budget plans aligned to each schedule season for capacity, revenue, and cost forecasting. Aviation plann',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule season record was first created in the system. Supports audit trail and data lineage tracking.',
    `daylight_saving_transition_applicable_flag` BOOLEAN COMMENT 'Indicates whether daylight saving time transitions occur during this scheduling season, requiring schedule adjustments for affected routes and airports. True if DST transitions occur within the season period.',
    `duration_days` STRING COMMENT 'Total number of calendar days in the scheduling season, calculated from start_date to end_date inclusive. Typically ranges from 180 to 185 days.',
    `end_date` DATE COMMENT 'The last date of the IATA scheduling season when the seasonal schedule expires. Typically the Saturday before the next season starts.',
    `historical_use_it_or_lose_it_threshold_percent` DECIMAL(18,2) COMMENT 'The minimum slot utilization percentage required during this season to retain grandfather rights for the next equivalent season. Typically 80% per IATA WSG, but may vary by jurisdiction (e.g., EU Regulation 95/93). Expressed as a percentage (e.g., 80.00 for 80%).',
    `iata_schedules_conference_end_date` DATE COMMENT 'The end date of the biannual IATA Schedules Conference. Conferences typically last 3-5 days and occur twice per year (spring for winter season, fall for summer season).',
    `iata_schedules_conference_location` STRING COMMENT 'The city and country where the IATA Schedules Conference for this season is held (e.g., Geneva, Switzerland, Singapore).',
    `iata_schedules_conference_start_date` DATE COMMENT 'The start date of the biannual IATA Schedules Conference where airlines, airports, and slot coordinators meet to coordinate seasonal schedules, negotiate slots, and finalize bilateral agreements.',
    `iata_season_year` STRING COMMENT 'The calendar year in which the season primarily falls or begins, used for grouping and filtering seasons by year (e.g., 2025 for S25 or W25/26).',
    `initial_schedule_submission_deadline` DATE COMMENT 'The deadline by which airlines must submit their initial seasonal schedule requests to slot coordinators and Global Distribution Systems (GDS). Typically occurs several months before season start per IATA Schedules Information Standards (SIS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule season record was last updated. Supports change tracking and audit compliance.',
    `northern_hemisphere_dst_end_date` DATE COMMENT 'The date when daylight saving time ends in the northern hemisphere during this season (typically first Sunday in November for North America, last Sunday in October for Europe). Null if not applicable to this season.',
    `northern_hemisphere_dst_start_date` DATE COMMENT 'The date when daylight saving time begins in the northern hemisphere during this season (typically second Sunday in March for North America, last Sunday in March for Europe). Null if not applicable to this season.',
    `notes` STRING COMMENT 'Free-text field for capturing additional information, special circumstances, or operational notes relevant to this scheduling season (e.g., COVID-19 slot relief measures, exceptional slot waiver periods, regulatory changes).',
    `peak_travel_period_flag` BOOLEAN COMMENT 'Indicates whether this season is considered a peak travel period with higher demand and load factors. Summer seasons are typically peak periods for leisure travel in the northern hemisphere.',
    `schedule_season_status` STRING COMMENT 'Current lifecycle status of the scheduling season. Planning: season is being prepared and schedules are being submitted. Active: season is currently in effect. Completed: season has ended but data is still operational. Archived: season is historical and closed for reporting only.. Valid values are `planning|active|completed|archived`',
    `season_code` STRING COMMENT 'IATA standard season code identifying the scheduling period. Format: S25 for Summer 2025, W25/26 for Winter 2025/2026. This is the externally-known business identifier for the season.. Valid values are `^[SW]d{2}(/d{2})?$`',
    `season_name` STRING COMMENT 'Human-readable descriptive name for the scheduling season (e.g., Summer 2025, Winter 2025/2026).',
    `season_type` STRING COMMENT 'Classification of the scheduling season into IATA-defined periods: summer (typically late March to late October) or winter (typically late October to late March).. Valid values are `summer|winter`',
    `slot_coordination_cycle` STRING COMMENT 'The IATA slot coordination cycle identifier corresponding to this season, used by slot coordinators at Level 2 and Level 3 airports for capacity management and slot allocation.',
    `slot_return_deadline` DATE COMMENT 'The final date by which airlines must return unused or unwanted airport slots to the slot coordinator to avoid use-it-or-lose-it penalties. Critical for slot allocation compliance at Level 3 coordinated airports.',
    `southern_hemisphere_dst_end_date` DATE COMMENT 'The date when daylight saving time ends in the southern hemisphere during this season (typically first Sunday in April for Australia). Null if not applicable to this season.',
    `southern_hemisphere_dst_start_date` DATE COMMENT 'The date when daylight saving time begins in the southern hemisphere during this season (typically first Sunday in October for Australia). Null if not applicable to this season.',
    `start_date` DATE COMMENT 'The first date of the IATA scheduling season when the seasonal schedule becomes effective. Typically the last Sunday of March for summer seasons and last Sunday of October for winter seasons.',
    `supplementary_schedule_submission_deadline` DATE COMMENT 'The deadline for airlines to submit supplementary or revised schedule changes after the initial submission. Allows for adjustments closer to the season start date.',
    CONSTRAINT pk_schedule_season PRIMARY KEY(`schedule_season_id`)
) COMMENT 'Reference master for IATA scheduling seasons defining the temporal boundaries for all schedule planning, slot coordination, and capacity deployment activities. Captures season code (e.g., S25, W25/26), season type (summer/winter), start and end dates per IATA calendar, schedule submission deadlines (initial, supplementary), slot return deadlines, and IATA Schedules Conference dates. Serves as the mandatory temporal anchor referenced by seasonal_schedule, route_slot_allocation, ask_plan, and route_fleet_assignment.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`seasonal_schedule` (
    `seasonal_schedule_id` BIGINT COMMENT 'Unique identifier for the seasonal schedule record. Primary key for this entity.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Seasonal schedules must reference valid aircraft types to enforce fleet availability constraints, validate seat capacity, verify ETOPS certification for route requirements, and support schedule-to-fle',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Seasonal schedules are the primary unit of airline financial planning — each scheduled operation has an associated budget for revenue, fuel, and crew costs. Direct FK enables budget vs actual variance',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Seasonal schedule capacity planning requires the exact cabin configuration to compute available seats by class (ASK, load factor by cabin). seasonal_schedule.aircraft_configuration_code is a denormali',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Airlines with multiple AOC holders must attribute each scheduled operation to the correct legal entity for regulatory reporting and IFRS revenue recognition. seasonal_schedule has operating_carrier_id',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Seasonal schedules drive seasonal cost allocation for winter/summer network planning. Airlines track operating costs by schedule season and cost centre to analyze seasonal profitability, optimize capa',
    `station_id` BIGINT COMMENT 'FK to airport.station',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: seasonal_schedule carries a `flight_number` STRING attribute that is a denormalized reference to the flight_number master record. A seasonal schedule is the operational plan for a specific flight numb',
    `origin_station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Seasonal schedules specify origin station for slot coordination, gate allocation planning, ground handler contracting, and operational resource planning. Role prefix origin_ distinguishes from desti',
    `terminal_facility_id` BIGINT COMMENT 'Foreign key linking to airport.terminal_facility. Business justification: Airlines file terminal preferences with schedule submissions for capacity planning and passenger connectivity. origin_terminal is a denormalized text field; a FK to terminal_facility enables terminal ',
    `carrier_id` BIGINT COMMENT 'FK to route.carrier',
    `route_id` BIGINT COMMENT 'Reference to the route for which this seasonal schedule is defined. Links to the route master data defining the origin-destination city pair.',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Seasonal_schedule currently has iata_season_code (STRING) but should reference schedule_season via FK. Every seasonal schedule operates within a defined IATA season. The schedule_season table is the a',
    `slot_allocation_id` BIGINT COMMENT 'Foreign key linking to route.route_slot_allocation. Business justification: seasonal_schedule carries `slot_time_origin` and `slot_time_destination` STRING attributes that represent the allocated slot times at origin and destination airports. These are denormalized copies of ',
    `aircraft_owner` STRING COMMENT 'Indicates the ownership/lease arrangement for the aircraft planned for this schedule. Values: owned (airline-owned), wet_lease (leased with crew), dry_lease (leased without crew), acmi (Aircraft Crew Maintenance Insurance lease), charter (chartered from third party).. Valid values are `owned|wet_lease|dry_lease|acmi|charter`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this seasonal schedule received final approval from all required authorities (slot coordinators, civil aviation authorities, bilateral agreement partners). Nullable if not yet approved.',
    `arrival_time_local` STRING COMMENT 'Scheduled arrival time in local time at the destination airport. Format: HH:MM (24-hour). This is the planned gate arrival time (on-blocks time) in the destination airport local timezone. May show next-day arrival if flight crosses midnight.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `arrival_time_utc` STRING COMMENT 'Scheduled arrival time in UTC (Coordinated Universal Time). Format: HH:MM (24-hour). Used for operational planning and coordination across time zones.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `ask_planned` DECIMAL(18,2) COMMENT 'Planned Available Seat Kilometers for this seasonal schedule. Calculated as total seats multiplied by route distance in kilometers. Key capacity metric for network planning and revenue management.',
    `block_time_minutes` STRING COMMENT 'Scheduled block time in minutes. Block time is the total time from gate departure (off-blocks) to gate arrival (on-blocks), including taxi time at both airports. Used for crew duty calculations and operational planning.',
    `codeshare_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this seasonal schedule is part of a codeshare agreement. True if the flight is operated by one airline but marketed under multiple airline codes. False for solely-operated flights.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this seasonal schedule record was first created in the system. Audit field for data lineage and change tracking.',
    `day_change_indicator` STRING COMMENT 'Indicates the number of days difference between departure and arrival dates. Values: 0 (same day), 1 (next day), 2 (two days later), -1 (previous day for flights crossing international date line westbound). Used to calculate actual arrival date from departure date.',
    `days_of_operation` STRING COMMENT 'Seven-character string representing the days of the week this flight operates. Each position represents a day (Monday through Sunday). Values: 1=operates, 0=does not operate. Example: 1111100 means Monday-Friday only. Also known as DOW (Day of Week) mask.. Valid values are `^[0-7]{7}$`',
    `departure_time_local` STRING COMMENT 'Scheduled departure time in local time at the origin airport. Format: HH:MM (24-hour). This is the planned gate departure time (off-blocks time) in the origin airport local timezone.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `departure_time_utc` STRING COMMENT 'Scheduled departure time in UTC (Coordinated Universal Time). Format: HH:MM (24-hour). Used for operational planning and coordination across time zones.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `destination_terminal` STRING COMMENT 'Terminal identifier at the destination airport where this flight arrives. Used for passenger information and ground operations planning. Format varies by airport (e.g., 1, A, T1, North).',
    `effective_from_date` DATE COMMENT 'The first date on which this seasonal schedule becomes effective. Marks the start of the schedule validity period within the IATA season.',
    `effective_to_date` DATE COMMENT 'The last date on which this seasonal schedule is effective. Marks the end of the schedule validity period within the IATA season. Nullable for open-ended schedules.',
    `filed_timestamp` TIMESTAMP COMMENT 'Date and time when this seasonal schedule was officially filed with IATA and relevant slot coordinators. Represents the submission timestamp for regulatory and coordination purposes.',
    `frequency_per_week` STRING COMMENT 'The number of times this flight operates per week during the seasonal schedule period. Derived from the days_of_operation mask. Range: 0-7.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this seasonal schedule record was last updated. Audit field for change tracking and data quality monitoring.',
    `meal_service_code` STRING COMMENT 'IATA meal service code indicating the type of meal service planned for this flight. Common values: B=Breakfast, L=Lunch, D=Dinner, S=Snack, M=Meal (unspecified), N=No meal service. Used for catering planning and passenger information.. Valid values are `^[A-Z]{1}$`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational comments related to this seasonal schedule. May include information about seasonal variations, special events, or coordination notes.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the seasonal schedule. Values: planned (initial planning stage), filed (submitted to IATA and slot coordinators), approved (regulatory and slot approval received), active (currently operating), suspended (temporarily not operating), cancelled (permanently removed from schedule).. Valid values are `planned|filed|approved|active|suspended|cancelled`',
    `service_type` STRING COMMENT 'IATA service type code indicating the nature of the flight service. Values: J=Passenger Jet, F=Cargo, C=Charter, P=Positioning/Ferry. Passenger scheduled services typically use J.. Valid values are `J|F|C|P`',
    `total_seats` STRING COMMENT 'Total number of passenger seats available on the planned aircraft configuration for this seasonal schedule. Used for capacity planning and ASK (Available Seat Kilometer) calculations.',
    `traffic_restriction_code` STRING COMMENT 'IATA traffic restriction code indicating any limitations on passenger carriage. Examples: G=Government approval required, X=Technical stop (no traffic rights), T=Technical stop with traffic rights. Blank if no restrictions apply.',
    CONSTRAINT pk_seasonal_schedule PRIMARY KEY(`seasonal_schedule_id`)
) COMMENT 'Operational schedule plan for a specific route during an IATA season, defining the planned service pattern including days of operation (DOW mask), departure and arrival times (local and UTC), frequency per week, cabin configuration, planned aircraft type, block time, and schedule status (planned, filed, approved, active, cancelled). Represents the filed schedule submitted to IATA and slot coordinators. Aligns with Jeppesen Flight Planning System seasonal schedule module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`slot_allocation` (
    `slot_allocation_id` BIGINT COMMENT 'Unique identifier for the airport slot allocation record. Primary key for the route slot allocation entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Airport slot costs are significant operating expenses at slot-constrained airports (LHR, JFK, NRT). Airlines allocate slot acquisition, holding, and opportunity costs to route cost centres for route p',
    `route_id` BIGINT COMMENT 'Reference to the route for which this slot is allocated. Links to the route master data defining the origin-destination city pair and service characteristics.',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Route_slot_allocation currently has slot_season_code (STRING) but should reference schedule_season via FK. Slot allocations are granted for specific IATA seasons. The schedule_season table contains th',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Slot allocations are station-specific regulatory permissions. Slot utilization tracking, coordinator coordination, historic rights validation, and compliance reporting require direct station link. No ',
    `aircraft_size_category` STRING COMMENT 'General aircraft size category restriction for the slot. Used when specific type restrictions are not applied but size-based capacity management is in effect.. Valid values are `narrow_body|wide_body|regional|freighter`',
    `aircraft_type_restriction` STRING COMMENT 'ICAO aircraft type code restriction for this slot allocation (e.g., B738, A320, B77W). Some slots at noise-sensitive or capacity-constrained airports may be restricted to specific aircraft types or size categories. Null if no restriction applies.',
    `allocated_time` TIMESTAMP COMMENT 'The specific time allocated for the departure or arrival movement in local airport time (HH:MM format, 24-hour clock). This is the coordinated time window the airline must operate within.',
    `bilateral_agreement_reference` STRING COMMENT 'Reference to the bilateral air service agreement between countries that governs traffic rights and slot access for this route. Relevant for international routes where slot allocation must comply with bilateral treaty provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot allocation record was first created in the system. Part of audit trail for slot coordination data lineage.',
    `days_of_operation` STRING COMMENT 'Days of the week on which this slot is allocated, represented as a string of digits where 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday, 5=Friday, 6=Saturday, 7=Sunday. For example, 1357 means Monday, Wednesday, Friday, Sunday. Empty or 1234567 indicates daily operation.. Valid values are `^[1-7]{1,7}$`',
    `effective_from_date` DATE COMMENT 'The first date on which this slot allocation becomes effective. For full season slots, this is typically the season start date. For partial season slots, this is the first date of the allocated period.',
    `effective_to_date` DATE COMMENT 'The last date on which this slot allocation is effective. For full season slots, this is typically the season end date. For partial season slots, this is the last date of the allocated period.',
    `environmental_restriction_flag` BOOLEAN COMMENT 'Indicates whether this slot is subject to environmental restrictions such as noise abatement procedures, curfew limitations, or emissions-based access rules. True if environmental constraints apply to the slot usage.',
    `historical_precedence_flag` BOOLEAN COMMENT 'Indicates whether this slot carries historical precedence (grandfather rights) for the airline. True if the airline has operated this slot in previous equivalent seasons and is entitled to priority retention under IATA use-it-or-lose-it rules (80% usage threshold).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot allocation record was last updated. Tracks changes to slot status, times, or other allocation parameters throughout the coordination lifecycle.',
    `slot_allocation_timestamp` TIMESTAMP COMMENT 'Date and time when the slot coordinator officially allocated this slot to the airline. Marks the transition from requested to allocated status.',
    `slot_cancellation_reason` STRING COMMENT 'Reason for cancellation of the slot allocation by the coordinator or airline. Populated when slot_status is cancelled. May include regulatory changes, airport capacity reductions, or airline non-compliance with usage requirements.',
    `slot_conference_reference` STRING COMMENT 'Reference to the IATA slot coordination conference where this slot was discussed or allocated (e.g., IATA Slot Conference Worldwide, Regional Slot Conference). IATA holds biannual slot conferences where airlines and coordinators negotiate slot allocations.',
    `slot_confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the airline confirmed acceptance and intention to use the allocated slot. Required by IATA WSG to retain slot rights for future seasons.',
    `slot_coordination_level` STRING COMMENT 'IATA coordination level of the airport for this slot. Level 1 (non-coordinated): no slot coordination required; Level 2 (schedule-facilitated): voluntary schedule coordination; Level 3 (fully coordinated): mandatory slot allocation by coordinator. Only Level 2 and Level 3 airports issue formal slot allocations.. Valid values are `level_1|level_2|level_3`',
    `slot_coordinator_reference_number` STRING COMMENT 'Unique reference number assigned by the airport slot coordinator to this slot allocation. Used for official correspondence and slot coordination activities.',
    `slot_movement_type` STRING COMMENT 'Indicates whether this slot is for an arrival or departure movement at the coordinated airport.. Valid values are `arrival|departure`',
    `slot_priority_score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the slot coordinator to prioritize this slot request relative to competing requests. Higher scores indicate higher priority. Factors include historical precedence, new entrant status, network connectivity, and public interest considerations.',
    `slot_request_timestamp` TIMESTAMP COMMENT 'Date and time when the airline submitted the slot request to the coordinator. Used to establish priority in slot allocation processes where multiple carriers request the same time.',
    `slot_return_reason` STRING COMMENT 'Business reason for returning the slot to the coordinator pool. Populated when slot_status is returned. Common reasons include route discontinuation, schedule optimization, fleet changes, or commercial underperformance.',
    `slot_series_type` STRING COMMENT 'Indicates whether the slot allocation covers the full IATA season, a partial period within the season, or a single date. Full season slots run for the entire summer or winter season; partial season slots cover a subset of dates.. Valid values are `full_season|partial_season|single_date`',
    `slot_status` STRING COMMENT 'Current status of the slot allocation in the coordination lifecycle. Requested: airline has submitted a slot request; Allocated: coordinator has provisionally allocated the slot; Confirmed: airline has confirmed acceptance and usage; Returned: airline has returned the slot to the pool; Swapped: slot has been exchanged with another carrier; Cancelled: slot allocation has been cancelled.. Valid values are `requested|allocated|confirmed|returned|swapped|cancelled`',
    `slot_swap_partner_airline_code` STRING COMMENT 'IATA airline code of the partner airline involved in a slot swap transaction. Populated only when slot_status is swapped. Slot swaps allow airlines to exchange slots to optimize their network schedules.. Valid values are `^[A-Z0-9]{2,3}$`',
    `slot_swap_reference_number` STRING COMMENT 'Unique reference number for the slot swap transaction, assigned by the slot coordinator. Links this slot allocation to the corresponding swapped slot record.',
    `slot_tolerance_minutes` STRING COMMENT 'Number of minutes before or after the allocated time within which the flight operation is considered compliant with the slot. Typically -5 to +10 minutes for departures and -10 to +5 minutes for arrivals, but varies by airport coordinator policy.',
    `slot_type` STRING COMMENT 'Classification of the slot allocation type. Historical grandfather slots are held by airlines with historic precedence; new entrant slots are reserved for new carriers; pool slots are available for general allocation; ad hoc slots are one-time allocations; emergency slots are for irregular operations.. Valid values are `historical_grandfather|new_entrant|pool|ad_hoc|emergency`',
    `slot_usage_percentage` DECIMAL(18,2) COMMENT 'Percentage of allocated slot times that were actually used by the airline during the season. IATA WSG requires 80% usage to retain historical rights. Calculated as (flights operated within slot tolerance / total allocated slot occurrences) * 100.',
    `terminal_restriction` STRING COMMENT 'Specific terminal designation at the airport where this slot must be used (e.g., Terminal 1, Terminal 5, Concourse B). Some airports allocate slots with terminal restrictions due to capacity or operational constraints.',
    CONSTRAINT pk_slot_allocation PRIMARY KEY(`slot_allocation_id`)
) COMMENT 'Airport slot allocation record for a specific route and season at a slot-coordinated (Level 2 or Level 3) airport. Captures slot coordinator reference number, allocated departure or arrival time, slot type (historical grandfather, new entrant, pool), slot series (full season or partial), days of operation, aircraft type restriction, slot status (requested, allocated, confirmed, returned, swapped), and IATA slot coordination conference reference. Critical for constrained airports (LHR, JFK, CDG, NRT). Aligns with IATA Worldwide Slot Guidelines (WSG).';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`partnership` (
    `partnership_id` BIGINT COMMENT 'Primary key for partnership',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Codeshare partnerships have revenue-sharing and prorate settlements tracked by cost centres. Airlines allocate codeshare revenue, commission expenses, and settlement costs to route cost centres for pa',
    `carrier_id` BIGINT COMMENT 'FK to route.carrier',
    `partnership_partner_carrier_id` BIGINT COMMENT 'Foreign key linking to route.carrier. Business justification: partnership currently has partner_carrier_iata_code as STRING. Normalizing to carrier.carrier_id establishes proper FK to the partner carrier in the codeshare/interline partnership. The partner_carrie',
    `codeshare_agreement_id` BIGINT COMMENT 'Unique identifier for the route partnership agreement record. Primary key.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Route_partnership (codeshare/partnership agreements) currently has origin_airport_iata_code and destination_airport_iata_code as separate strings. These define a route. Adding route_id FK links the pa',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for this partnership agreement, used in contracts and commercial correspondence.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the partnership agreement: draft (under negotiation), pending_approval (awaiting executive sign-off), active (in force), suspended (temporarily inactive), terminated (ended before expiry), or expired (reached natural end date).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the commercial partnership arrangement: codeshare free-flow (marketing carrier sells seats on operating carrier inventory), codeshare block-space (marketing carrier purchases block of seats), standard interline (ticketing and baggage transfer agreement), special prorate agreement (SPA - negotiated revenue split), through-check-in (baggage handling only), or joint venture (revenue and cost sharing alliance).. Valid values are `codeshare_free_flow|codeshare_block_space|standard_interline|special_prorate_agreement|through_check_in|joint_venture`',
    `antitrust_immunity_granted` BOOLEAN COMMENT 'Indicates whether the partnership (typically joint venture) has been granted antitrust immunity by regulatory authorities, allowing revenue and capacity coordination.',
    `approval_date` DATE COMMENT 'Date on which this partnership agreement received final executive approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or commercial manager who approved this partnership agreement.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the partnership agreement automatically renews for an additional term upon expiry unless either party provides notice of termination.',
    `baggage_through_check_eligible` BOOLEAN COMMENT 'Indicates whether passengers on interline itineraries under this agreement are eligible for baggage through-check (baggage checked to final destination without re-check at transfer point).',
    `block_space_seat_count` STRING COMMENT 'Number of seats purchased by the marketing carrier under a block-space codeshare agreement. Null if not a block-space agreement.',
    `cabin_class_availability` STRING COMMENT 'Comma-separated list of cabin classes (e.g., F, J, W, Y) for which this partnership agreement applies. Null if applies to all classes.',
    `codeshare_flight_number_range_end` STRING COMMENT 'Ending flight number in the range allocated to the marketing carrier for codeshare flights under this agreement. Null if not a codeshare agreement.',
    `codeshare_flight_number_range_start` STRING COMMENT 'Starting flight number in the range allocated to the marketing carrier for codeshare flights under this agreement. Null if not a codeshare agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partnership agreement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the partnership agreement becomes active and binding.',
    `eticket_interline_capable` BOOLEAN COMMENT 'Indicates whether electronic ticketing is supported for interline itineraries under this agreement (both carriers must support e-ticket interline).',
    `expiry_date` DATE COMMENT 'Date on which the partnership agreement expires or is scheduled to terminate. Null for open-ended agreements.',
    `frequent_flyer_accrual_eligible` BOOLEAN COMMENT 'Indicates whether passengers can accrue frequent flyer miles/points on the partner carrier when traveling on codeshare or interline flights under this agreement.',
    `frequent_flyer_redemption_eligible` BOOLEAN COMMENT 'Indicates whether passengers can redeem frequent flyer miles/points for award travel on the partner carrier under this agreement.',
    `gds_distribution_enabled` BOOLEAN COMMENT 'Indicates whether codeshare flights under this agreement are distributed through Global Distribution Systems (Amadeus, Sabre, Travelport) for travel agent booking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partnership agreement record was last updated in the system.',
    `minimum_connecting_time_minutes` STRING COMMENT 'Minimum time in minutes required for passenger connections between the partner carriers under this agreement, used for interline itinerary construction.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to this partnership agreement.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the partnership agreement.',
    `prorate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ticket revenue allocated to the partner carrier under prorate revenue sharing. Null if revenue_sharing_basis is not prorate.',
    `revenue_sharing_basis` STRING COMMENT 'Method by which revenue is allocated between partner carriers: prorate (IATA standard prorate formula based on mileage), block_space (fixed payment for seat block), revenue_share_pool (joint venture pooling), cost_plus (cost reimbursement plus margin), or fixed_fee (flat payment per flight or period).. Valid values are `prorate|block_space|revenue_share_pool|cost_plus|fixed_fee`',
    `route_scope` STRING COMMENT 'Geographic scope of the partnership agreement: specific_od_pair (applies to one origin-destination pair), regional_network (applies to routes within a region), or global_network (applies to all routes between the carriers).. Valid values are `specific_od_pair|regional_network|global_network`',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which revenue settlements between partner carriers are conducted under this agreement.. Valid values are `^[A-Z]{3}$`',
    `settlement_frequency` STRING COMMENT 'Frequency at which revenue settlements are processed between partner carriers: weekly, biweekly, monthly, or quarterly.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `special_service_request_passthrough` BOOLEAN COMMENT 'Indicates whether Special Service Requests (meal preferences, wheelchair assistance, etc.) are passed through between carriers for interline passengers under this agreement.',
    `termination_date` DATE COMMENT 'Actual date on which the partnership agreement was terminated, if terminated before the scheduled expiry_date. Null if not terminated early.',
    `termination_reason` STRING COMMENT 'Free-text explanation of why the partnership agreement was terminated early, if applicable.',
    CONSTRAINT pk_partnership PRIMARY KEY(`partnership_id`)
) COMMENT 'Master record for all carrier-to-carrier commercial partnership arrangements at the route level, encompassing codeshare agreements, interline ticketing agreements, special prorate agreements (SPAs), and joint venture arrangements. Captures partner carrier IATA code, agreement type (codeshare free-flow, codeshare block-space, standard interline, SPA, through-check-in, joint venture), applicable routes or O&D pairs, revenue sharing basis (prorate, block-space, revenue-share pool), cabin class availability, baggage through-check eligibility, e-ticket interline capability, effective date, expiry date, and agreement status. Serves as the SSOT for all route-level partnership data enabling multi-carrier itinerary construction, codeshare flight number assignment, and interline revenue settlement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`interline_agreement` (
    `interline_agreement_id` BIGINT COMMENT 'Unique identifier for the interline ticketing and traffic agreement record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Interline agreements generate prorate revenue and settlement costs tracked by cost centres. Airlines allocate interline revenue, prorate expenses, and BSP/ARC settlement costs to route cost centres fo',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Interline safety events affect agreement terms (baggage liability, IROP reprotection) and partner safety performance evaluation. Required for interline agreement compliance and partner monitoring. Lin',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to route.carrier. Business justification: interline_agreement has partner_carrier_iata_code as STRING. Normalizing to carrier.carrier_id establishes FK to the partner carrier in the interline ticketing agreement. This connects interline_agree',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Route_interline_agreement currently has origin_airport_iata_code and destination_airport_iata_code as separate strings. These define a route. Adding route_id FK links the interline agreement to the au',
    `agreement_notes` STRING COMMENT 'Free-text field for additional notes, special conditions, restrictions, or operational instructions related to the interline agreement.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the interline agreement indicating whether it is active, suspended, terminated, pending approval, expired, or under negotiation.. Valid values are `active|suspended|terminated|pending_approval|expired|under_negotiation`',
    `agreement_type` STRING COMMENT 'Classification of the interline agreement defining the scope and nature of the partnership (standard interline, special prorate agreement, through check-in, codeshare interline, virtual interline, bilateral prorate).. Valid values are `standard_interline|special_prorate_agreement|through_check_in|codeshare_interline|virtual_interline|bilateral_prorate`',
    `alliance_membership` STRING COMMENT 'Indicates whether the interline agreement is facilitated by membership in a global airline alliance (Star Alliance, oneworld, SkyTeam, Value Alliance) or is a standalone bilateral agreement (none).. Valid values are `star_alliance|oneworld|skyteam|value_alliance|none`',
    `baggage_through_check_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether baggage can be checked through to the final destination across both carriers under this interline agreement (True) or must be reclaimed and re-checked (False).',
    `codeshare_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this interline agreement permits codeshare flight operations between the airline and partner carrier (True) or is limited to standard interline ticketing (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline agreement record was first created in the system.',
    `e_ticket_interline_capable` BOOLEAN COMMENT 'Boolean flag indicating whether electronic ticketing (e-ticket) is supported for interline itineraries under this agreement (True) or paper tickets are required (False).',
    `effective_date` DATE COMMENT 'Date on which the interline agreement becomes binding and operational for ticketing and traffic purposes.',
    `expiration_date` DATE COMMENT 'Date on which the interline agreement expires or terminates. Nullable for open-ended agreements subject to notice-based termination.',
    `frequent_flyer_accrual_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether passengers can accrue frequent flyer miles or points on the partner carrier segments under this interline agreement (True) or not (False).',
    `gds_distribution_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether interline itineraries under this agreement are available for booking through Global Distribution Systems (GDS) such as Amadeus, Sabre, and Travelport (True) or restricted to direct channels (False).',
    `irop_reprotection_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether passengers can be reprotected on the partner carrier in case of irregular operations (IROP) such as delays, cancellations, or missed connections (True) or not (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline agreement record was last updated or modified in the system.',
    `liability_limit_sdr` DECIMAL(18,2) COMMENT 'Maximum liability limit per passenger for baggage, delay, or injury claims under the interline agreement, expressed in Special Drawing Rights (SDR) as defined by the Montreal Convention.',
    `minimum_connecting_time_minutes` STRING COMMENT 'Minimum connecting time in minutes required at the transfer point for interline connections under this agreement. Ensures operational feasibility of through-ticketing.',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system process that last modified this interline agreement record. Supports audit trail and data governance.',
    `prorate_basis` STRING COMMENT 'Method used to allocate revenue between carriers for interline journeys: IATA prorate factor, mileage-based calculation, negotiated fixed split, revenue share percentage, or cost-plus model.. Valid values are `iata_prorate_factor|mileage_based|negotiated_fixed|revenue_share|cost_plus`',
    `prorate_percentage` DECIMAL(18,2) COMMENT 'Negotiated percentage of total fare allocated to the operating carrier or partner carrier under the prorate agreement. Expressed as a percentage (0.00 to 100.00).',
    `route_scope` STRING COMMENT 'Defines the geographic or network scope of the interline agreement: network-wide (all routes), specific city pair, regional coverage, hub-and-spoke network, or alliance network.. Valid values are `network_wide|specific_city_pair|regional|hub_spoke|alliance_network`',
    `settlement_basis` STRING COMMENT 'Financial settlement mechanism for interline revenue: BSP (Billing and Settlement Plan), ARC (Airlines Reporting Corporation), direct billing between carriers, ICH (IATA Clearing House), or bilateral settlement agreement.. Valid values are `bsp|arc|direct_billing|ich|bilateral_settlement`',
    `special_prorate_agreement_number` STRING COMMENT 'Unique identifier for a Special Prorate Agreement (SPA) filed with IATA or negotiated bilaterally, if applicable. Nullable for standard interline agreements.',
    `ssr_handling_agreement` STRING COMMENT 'Defines the level of Special Service Request (SSR) data exchange and handling between carriers: full SSR exchange, limited SSR support, or no SSR exchange.. Valid values are `full_ssr_exchange|limited_ssr|no_ssr_exchange`',
    CONSTRAINT pk_interline_agreement PRIMARY KEY(`interline_agreement_id`)
) COMMENT 'Master record for interline ticketing and traffic agreements between the airline and partner carriers at the route or network level. Captures partner carrier IATA code, agreement type (standard interline, special prorate agreement, through-check-in), applicable O&D pairs, prorate basis (IATA prorate factor, mileage, negotiated), baggage through-check eligibility, e-ticket interline capability, BSP/ARC settlement basis, effective date, and agreement status. Enables multi-carrier itinerary construction and revenue settlement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`performance` (
    `performance_id` BIGINT COMMENT 'Unique identifier for the route performance measurement record. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Route performance variance analysis requires linking actuals to budget. Airlines compare actual route performance metrics (revenue, costs, load factor) against budget plans for variance reporting, for',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Route performance measurement requires cost centre attribution for P&L reporting. Airlines track actual route revenue, costs, and profitability by cost centre for management reporting, route performan',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Route performance financials (total_revenue_amount, total_cost_amount, RASK, CASK) must reconcile to GL postings for financial close. Direct FK enables route P&L to GL reconciliation — a mandatory air',
    `route_id` BIGINT COMMENT 'Reference to the route being measured. Links to the route master data defining the origin-destination pair, flight number pattern, and network topology.',
    `schedule_season_id` BIGINT COMMENT 'Reference to the IATA schedule season during which this performance was measured (e.g., Summer 2024, Winter 2023/24). Links to schedule_season for season boundaries and slot coordination context.',
    `ask` DECIMAL(18,2) COMMENT 'The total number of seat-kilometers available for sale on this route. Calculated as sum of (available seats on each flight * flight distance in km). Fundamental capacity metric.',
    `available_seats_total` STRING COMMENT 'The total number of seats available for sale on all operated flights on this route during the measurement period. Basis for load factor calculation.',
    `average_block_time_minutes` DECIMAL(18,2) COMMENT 'The mean block time (gate-to-gate elapsed time) for all operated flights on this route during the measurement period. Used for schedule planning and crew productivity analysis.',
    `average_delay_minutes` DECIMAL(18,2) COMMENT 'The mean arrival delay in minutes for all operated flights on this route during the measurement period. Negative values indicate early arrivals.',
    `block_time_variance_minutes` DECIMAL(18,2) COMMENT 'The difference between average actual block time and scheduled block time. Positive values indicate flights took longer than scheduled; negative values indicate shorter actual times. Used for schedule buffer optimization.',
    `cancellation_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of scheduled flights that were cancelled. Calculated as (flights cancelled / flights scheduled) * 100. Key operational reliability metric.',
    `cask` DECIMAL(18,2) COMMENT 'Cost per unit of capacity. Calculated as (total cost / ASK). Key unit cost metric for route efficiency analysis. Expressed in cost_currency_code per kilometer.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which total_cost_amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this route performance record was first created in the system. Audit trail for data lineage and compliance.',
    `diversion_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of operated flights that were diverted. Calculated as (flights diverted / flights operated) * 100. Indicator of weather, ATC, or operational disruption impact.',
    `flights_cancelled_count` STRING COMMENT 'The total number of scheduled flights that were cancelled on this route during the measurement period.',
    `flights_diverted_count` STRING COMMENT 'The total number of flights that were diverted to an alternate airport on this route during the measurement period.',
    `flights_operated_count` STRING COMMENT 'The total number of flights that actually departed on this route during the measurement period. Excludes cancelled flights.',
    `flights_scheduled_count` STRING COMMENT 'The total number of flights scheduled to operate on this route during the measurement period, as published in the airline schedule.',
    `grade` STRING COMMENT 'Overall qualitative assessment of route performance based on composite scoring of OTP, load factor, yield, and RASK against targets. Used for executive dashboards and network optimization prioritization.. Valid values are `excellent|good|fair|poor|critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this route performance record was most recently updated. Audit trail for data lineage and compliance.',
    `load_factor_percent` DECIMAL(18,2) COMMENT 'The percentage of available seats that were occupied by revenue passengers. Calculated as (passengers carried / available seats) * 100. Core capacity utilization metric.',
    `measurement_period_end_date` DATE COMMENT 'The last date of the performance measurement period. Typically the last day of a calendar month or the end of a seasonal period.',
    `measurement_period_start_date` DATE COMMENT 'The first date of the performance measurement period. Typically the first day of a calendar month or the start of a seasonal period.',
    `measurement_period_type` STRING COMMENT 'The granularity of the performance measurement period. Monthly is most common for operational scorecards; seasonal aligns with IATA schedule seasons; custom supports ad-hoc analysis windows.. Valid values are `monthly|seasonal|quarterly|annual|weekly|custom`',
    `notes` STRING COMMENT 'Free-text commentary on exceptional performance factors, IROP events, competitive actions, seasonal effects, or other context relevant to interpreting the performance metrics for this period.',
    `otp_percent` DECIMAL(18,2) COMMENT 'The percentage of operated flights that arrived within 15 minutes of scheduled arrival time. Industry-standard KPI for route punctuality. Calculated as (on-time arrivals / flights operated) * 100.',
    `passengers_carried_count` STRING COMMENT 'The total number of revenue passengers transported on this route during the measurement period. Excludes non-revenue passengers (crew, deadheads, etc.).',
    `rask` DECIMAL(18,2) COMMENT 'Revenue per unit of capacity. Calculated as (total revenue / ASK). Key unit revenue metric for route profitability analysis. Expressed in revenue_currency_code per kilometer.',
    `revenue_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which total_revenue_amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `rpk` DECIMAL(18,2) COMMENT 'The total number of kilometers flown by revenue passengers on this route. Calculated as sum of (passengers on each flight * flight distance in km). Fundamental traffic volume metric.',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'The total operating cost allocated to this route during the measurement period, including direct costs (fuel, crew, airport charges) and allocated indirect costs (maintenance, overhead). Used for route profitability analysis.',
    `total_revenue_amount` DECIMAL(18,2) COMMENT 'The total passenger revenue generated on this route during the measurement period, including base fare, fuel surcharges, and ancillary revenue allocated to the route. Excludes cargo revenue.',
    `yield` DECIMAL(18,2) COMMENT 'Revenue per unit of traffic. Calculated as (total revenue / RPK). Measures pricing power and fare realization. Expressed in revenue_currency_code per kilometer.',
    CONSTRAINT pk_performance PRIMARY KEY(`performance_id`)
) COMMENT 'Operational performance record for a route over a defined measurement period (monthly or seasonal), capturing actual vs planned KPIs including OTP (On-Time Performance percentage), load factor (actual passengers / available seats), RPK (Revenue Passenger Kilometers), ASK (Available Seat Kilometers), RASK (Revenue per ASK), CASK (Cost per ASK), yield (revenue per RPK), cancellation rate, diversion rate, and average block time variance. Serves as the route-level operational scorecard. Distinct from flight-level OOOI data owned by the flight domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`block_time_standard` (
    `block_time_standard_id` BIGINT COMMENT 'Unique identifier for the block time standard record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Block time standards are aircraft-type-specific (cruise speed, climb/descent performance vary by type). Linking to aircraft_type enables accurate schedule planning, fuel burn estimation, crew duty cal',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Block time standards affect crew and fuel cost allocation by route. Airlines use block time standards to allocate crew duty costs, fuel burn, and aircraft utilization costs to route cost centres for c',
    `route_id` BIGINT COMMENT 'Reference to the route for which this block time standard applies. Links to the route master data defining the origin-destination city pair.',
    `schedule_season_id` BIGINT COMMENT 'Reference to the IATA schedule season for which this block time standard is effective. Links to the schedule season master defining the IATA summer/winter season boundaries.',
    `airborne_time_minutes` STRING COMMENT 'Planned airborne time in minutes from takeoff (wheels-up) to landing (wheels-down). Represents the actual flight time in the air, excluding ground operations.',
    `approval_date` DATE COMMENT 'Date when this block time standard was formally approved for operational use. Represents the governance checkpoint ensuring block time standards meet safety, efficiency, and reliability requirements.',
    `atc_delay_factor_minutes` STRING COMMENT 'Expected ATC delay factor in minutes based on historical congestion patterns at origin and destination airports, en-route airspace constraints, and time-of-day traffic density.',
    `block_time_standard_status` STRING COMMENT 'Current lifecycle status of the block time standard. Active standards are used for schedule construction; inactive standards are historical; under_review standards are being validated; superseded standards have been replaced by newer versions.. Valid values are `active|inactive|under_review|superseded`',
    `contingency_buffer_minutes` STRING COMMENT 'Additional buffer time in minutes added to the planned block time to account for operational variability, ATC delays, weather, and other uncertainties. Used to improve schedule reliability and OTP performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this block time standard record was first created in the system. Supports audit trail and data lineage tracking.',
    `crew_duty_time_minutes` STRING COMMENT 'Block time used for crew duty time and flight time limitation calculations. May include additional time for pre-flight briefing, post-flight duties, and regulatory compliance. Foundation for crew pairing and rostering.',
    `data_source` STRING COMMENT 'Source system or methodology used to derive this block time standard. Examples include historical flight data analysis, aircraft performance models, Jeppesen flight planning system, or manufacturer specifications.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the arrival airport for this block time standard.. Valid values are `^[A-Z]{3}$`',
    `direction` STRING COMMENT 'Direction of flight relative to the airlines hub or base. Outbound represents flights departing from hub; inbound represents flights arriving at hub. Block times may differ by direction due to prevailing winds and operational patterns.. Valid values are `outbound|inbound`',
    `effective_date` DATE COMMENT 'Date from which this block time standard becomes effective and is used for schedule construction and crew pairing. Typically aligned with IATA season start dates.',
    `etops_time_adjustment_minutes` STRING COMMENT 'Additional block time in minutes for ETOPS-certified routes requiring extended-range twin-engine operations. Accounts for required routing to remain within diversion distance of suitable alternate airports.',
    `expiry_date` DATE COMMENT 'Date on which this block time standard expires and is no longer used for schedule construction. Nullable for open-ended standards that remain effective until superseded.',
    `fuel_planning_time_minutes` STRING COMMENT 'Block time used for fuel planning calculations, which may differ from scheduled block time to ensure adequate fuel reserves for contingencies, alternate airports, and regulatory requirements.',
    `historical_average_block_time_minutes` STRING COMMENT 'Historical average actual block time in minutes based on past flight performance data. Used for benchmarking and validating planned block time standards against operational reality.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this block time standard record was last modified. Supports change tracking, audit trail, and data governance requirements.',
    `last_review_date` DATE COMMENT 'Date when this block time standard was last reviewed and validated against actual flight performance data. Block time standards should be reviewed regularly (typically quarterly or seasonally) to ensure accuracy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and validation of this block time standard. Ensures proactive maintenance of block time accuracy and alignment with operational performance.',
    `notes` STRING COMMENT 'Free-text notes capturing special considerations, operational constraints, seasonal factors, or other contextual information relevant to this block time standard. May include rationale for adjustments or known anomalies.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the departure airport for this block time standard.. Valid values are `^[A-Z]{3}$`',
    `percentile_85_block_time_minutes` STRING COMMENT '85th percentile of historical actual block times in minutes. Represents the block time that 85% of flights achieve or beat. Used as a reliability target for schedule planning to balance OTP performance with schedule efficiency.',
    `planned_block_time_minutes` STRING COMMENT 'Total planned gate-to-gate block time in minutes, representing the scheduled duration from gate departure (off-blocks) to gate arrival (on-blocks). This is the foundation for schedule construction, crew duty time calculations, and OTP measurement.',
    `sample_size` STRING COMMENT 'Number of historical flight records used to calculate this block time standard. Larger sample sizes provide greater statistical confidence in the standards accuracy and reliability.',
    `seasonal_adjustment_type` STRING COMMENT 'Indicates whether this block time standard applies to summer season (typically March-October in Northern Hemisphere), winter season (typically October-March), or year-round. Seasonal variations account for prevailing winds, jet stream patterns, and daylight saving time impacts.. Valid values are `summer|winter|year_round`',
    `slot_constrained_adjustment_minutes` STRING COMMENT 'Additional time in minutes added to block time for slot-constrained airports where departure or arrival slot availability may require schedule padding to ensure slot compliance and reduce IROP risk.',
    `standard_deviation_minutes` DECIMAL(18,2) COMMENT 'Standard deviation of historical block times in minutes, representing the variability and consistency of actual flight performance. Lower standard deviation indicates more predictable block times.',
    `taxi_in_time_minutes` STRING COMMENT 'Planned taxi-in time in minutes from landing (wheels-down) to gate arrival (on-blocks). Varies by airport layout, gate assignment, and ground traffic.',
    `taxi_out_time_minutes` STRING COMMENT 'Planned taxi-out time in minutes from gate departure (off-blocks) to takeoff (wheels-up). Varies by airport congestion, runway configuration, and time of day.',
    `wind_adjustment_minutes` STRING COMMENT 'Adjustment in minutes to account for prevailing wind patterns, jet stream effects, and seasonal wind variations. Positive values indicate headwind penalties; negative values indicate tailwind benefits.',
    CONSTRAINT pk_block_time_standard PRIMARY KEY(`block_time_standard_id`)
) COMMENT 'Reference master for planned block time standards by route and aircraft type, representing the scheduled gate-to-gate flight time used in schedule construction and crew pairing. Captures route, aircraft type, direction (outbound/inbound), planned block time (minutes), taxi-out time, taxi-in time, airborne time, seasonal adjustment (summer/winter winds), and last review date. Block time standards are the foundation of crew duty time calculations, fuel planning, and OTP measurement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`fleet_assignment` (
    `fleet_assignment_id` BIGINT COMMENT 'Unique identifier for the route fleet assignment record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Fleet controllers assign specific tail numbers to route assignments for ETOPS compliance verification, maintenance routing, and operational control. fleet_assignment currently captures only aircraft_t',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Route fleet assignments must reference valid aircraft types for capacity planning, ETOPS compliance verification, seat configuration validation, and schedule feasibility analysis. Replaces denormalize',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Fleet assignments drive capacity and operating cost budgets — aircraft type selection determines fuel burn, crew costs, and maintenance reserves. Finance teams link fleet deployment plans to budget pl',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Revenue management and capacity planning require exact cabin configuration (seat counts by class) for each route assignment. fleet_assignment.seat_configuration_code is a denormalized text reference t',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Fleet assignments drive aircraft depreciation and lease cost allocation by route. Airlines allocate aircraft ownership costs (depreciation, lease payments, insurance) to route cost centres based on fl',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Fleet assignments link specific leased aircraft to routes for lease cost allocation. Airlines track which lease contracts support which route assignments for IFRS 16 lease liability allocation, route ',
    `route_id` BIGINT COMMENT 'Reference to the route (origin-destination city pair) for which this fleet assignment is made.',
    `schedule_season_id` BIGINT COMMENT 'Reference to the IATA schedule season or planning period during which this fleet assignment is effective.',
    `approval_date` DATE COMMENT 'Date when this fleet assignment was formally approved by network planning or fleet management authority.',
    `approved_by_user` STRING COMMENT 'User ID or name of the network planning manager or fleet planner who approved this fleet assignment.',
    `assignment_code` STRING COMMENT 'Business identifier code for this fleet assignment, used in operational planning and crew scheduling systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `assignment_duration_days` STRING COMMENT 'Total number of days this fleet assignment is planned to be in effect, calculated from effective start to end date.',
    `assignment_priority` STRING COMMENT 'Priority ranking of this fleet assignment relative to other assignments, used for conflict resolution and aircraft allocation decisions. Lower numbers indicate higher priority.',
    `assignment_rationale` STRING COMMENT 'Business justification or reasoning for this specific fleet type assignment to the route, capturing strategic considerations such as demand patterns, competitive positioning, or operational constraints.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the fleet assignment: planned (initial planning), confirmed (approved by network planning), active (in operation), suspended (temporarily paused), cancelled (assignment withdrawn), historical (past assignment for reference).. Valid values are `planned|confirmed|active|suspended|cancelled|historical`',
    `assignment_type` STRING COMMENT 'Classification of the fleet assignment: permanent (year-round), seasonal (specific season only), temporary (short-term substitution), charter (ad-hoc charter operation), wet_lease (leased aircraft with crew), dry_lease (leased aircraft without crew).. Valid values are `permanent|seasonal|temporary|charter|wet_lease|dry_lease`',
    `business_class_seats` STRING COMMENT 'Number of business class seats in the assigned aircraft configuration.',
    `cargo_belly_capacity_kg` DECIMAL(18,2) COMMENT 'Available cargo capacity in the belly hold of the assigned aircraft, measured in kilograms, used for cargo revenue planning.',
    `cargo_belly_capacity_m3` DECIMAL(18,2) COMMENT 'Available cargo volume in the belly hold of the assigned aircraft, measured in cubic meters.',
    `codeshare_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fleet assignment is eligible for codeshare operations with partner airlines.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet assignment record was first created in the system.',
    `days_of_operation` STRING COMMENT 'Days of the week this fleet assignment operates, represented as a string of digits 1-7 (1=Monday, 7=Sunday). Example: 1357 means Monday, Wednesday, Friday, Sunday.. Valid values are `^[1-7]{1,7}$`',
    `economy_class_seats` STRING COMMENT 'Number of economy class seats in the assigned aircraft configuration.',
    `effective_end_date` DATE COMMENT 'Date when this fleet assignment ends and the aircraft type is no longer assigned to this route. Null indicates an open-ended assignment.',
    `effective_start_date` DATE COMMENT 'Date when this fleet assignment becomes effective and the assigned aircraft type begins operating the route.',
    `etops_rating_minutes` STRING COMMENT 'ETOPS rating in minutes (e.g., 120, 180, 207, 330) indicating the maximum diversion time to an alternate airport that the aircraft and route are certified for.',
    `etops_required_flag` BOOLEAN COMMENT 'Indicates whether ETOPS certification is required for this route due to extended over-water or remote area operations.',
    `first_class_seats` STRING COMMENT 'Number of first class or premium cabin seats in the assigned aircraft configuration.',
    `interline_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fleet assignment is eligible for interline ticketing agreements with other carriers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet assignment record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, constraints, or special considerations for this fleet assignment.',
    `planned_ask_capacity` DECIMAL(18,2) COMMENT 'Planned ASK (Available Seat Kilometers) capacity for this route-fleet assignment, calculated as total seats multiplied by route distance and frequency, used for network capacity planning.',
    `premium_economy_seats` STRING COMMENT 'Number of premium economy seats in the assigned aircraft configuration.',
    `target_load_factor_percent` DECIMAL(18,2) COMMENT 'Target load factor percentage (percentage of seats filled) that revenue management aims to achieve for this route-fleet assignment.',
    `total_seats` STRING COMMENT 'Total number of passenger seats available on the assigned aircraft configuration, also known as gauge in airline revenue management.',
    `weekly_frequency` STRING COMMENT 'Number of flights per week planned for this route with the assigned fleet type during the assignment period.',
    CONSTRAINT pk_fleet_assignment PRIMARY KEY(`fleet_assignment_id`)
) COMMENT 'Transactional record of fleet type assignment to a route for a specific season or schedule period, capturing the planned aircraft type, sub-fleet variant, seat configuration, cabin class mix, gauge (total seats), cargo belly capacity, ETOPS requirement (for long-haul over-water routes), and assignment effective date range. Represents the planned fleet deployment decision linking network planning to fleet management. Aligns with Jeppesen NetLine/Fleet assignment module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Primary key for carrier',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each carrier (airline) maps to a company code in the financial system for P&L reporting, intercompany eliminations, and regulatory filings. This is a foundational airline financial structure — carrier',
    `parent_carrier_id` BIGINT COMMENT 'Self-referencing FK on carrier (parent_carrier_id)',
    `accounting_code` STRING COMMENT 'Three-digit numeric code assigned by IATA for financial settlement, ticketing, and interline accounting purposes.',
    `alliance_membership` STRING COMMENT 'Global airline alliance to which the carrier belongs, enabling codeshare agreements, reciprocal benefits, and network coordination.',
    `aoc_expiry_date` DATE COMMENT 'Date when the carriers Air Operator Certificate expires, if applicable.',
    `aoc_issue_date` DATE COMMENT 'Date when the carriers current Air Operator Certificate was issued.',
    `aoc_issuing_authority` STRING COMMENT 'Name of the civil aviation authority that issued the carriers Air Operator Certificate.',
    `aoc_number` STRING COMMENT 'Unique identifier for the carriers Air Operator Certificate issued by the civil aviation authority.',
    `callsign` STRING COMMENT 'Unique radio telephony callsign used by pilots and air traffic control for voice communications during flight operations.',
    `cargo_operations_flag` BOOLEAN COMMENT 'Indicates whether the carrier operates dedicated cargo or freight services.',
    `carrier_name` STRING COMMENT 'Full legal name of the airline carrier as registered with aviation authorities.',
    `carrier_type` STRING COMMENT 'Classification of the carrier based on primary business model and service offering.',
    `ceased_operations_date` DATE COMMENT 'Date when the carrier permanently ceased flight operations, if applicable.',
    `codeshare_participant_flag` BOOLEAN COMMENT 'Indicates whether the carrier participates in codeshare agreements with other carriers.',
    `commenced_operations_date` DATE COMMENT 'Date when the carrier began commercial flight operations.',
    `contact_email` STRING COMMENT 'Primary contact email address for the carriers corporate communications.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the carriers customer service or corporate office.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the carrier is registered and holds its Air Operator Certificate (AOC).',
    `effective_from_date` DATE COMMENT 'Date from which this carrier record becomes effective for operational and scheduling purposes.',
    `effective_to_date` DATE COMMENT 'Date until which this carrier record remains effective, nullable for open-ended records.',
    `fleet_size` STRING COMMENT 'Total number of aircraft in the carriers operational fleet.',
    `founded_date` DATE COMMENT 'Date when the carrier was originally established or incorporated.',
    `headquarters_city` STRING COMMENT 'City where the carriers corporate headquarters and primary administrative offices are located.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the carriers headquarters is located.',
    `hub_airport_codes` STRING COMMENT 'Comma-separated list of IATA airport codes representing the carriers primary hub airports for network operations.',
    `iata_code` STRING COMMENT 'Two-character IATA airline designator code uniquely identifying the carrier in global distribution systems, reservations, and ticketing.',
    `iata_member_flag` BOOLEAN COMMENT 'Indicates whether the carrier is a member of the International Air Transport Association (IATA).',
    `icao_code` STRING COMMENT 'Three-character ICAO airline designator code used in flight plans, air traffic control communications, and operational systems.',
    `iosa_certification_date` DATE COMMENT 'Date when the carrier received or last renewed its IOSA certification.',
    `iosa_certified_flag` BOOLEAN COMMENT 'Indicates whether the carrier holds current IATA Operational Safety Audit (IOSA) certification.',
    `iosa_expiry_date` DATE COMMENT 'Date when the carriers current IOSA certification expires and requires renewal.',
    `low_cost_carrier_flag` BOOLEAN COMMENT 'Indicates whether the carrier operates under a low-cost carrier business model.',
    `operational_status` STRING COMMENT 'Current operational status of the carrier indicating whether it is actively operating flights.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier record was last modified in the system.',
    `regional_carrier_flag` BOOLEAN COMMENT 'Indicates whether the carrier primarily operates regional or short-haul routes.',
    `trade_name` STRING COMMENT 'Commercial or marketing name under which the carrier operates and is known to passengers, may differ from legal name.',
    `website_url` STRING COMMENT 'Primary website URL for the carriers official online presence.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master reference table for carrier. Referenced by operating_carrier_id.';

CREATE OR REPLACE TABLE `airlines_ecm`.`route`.`codeshare_agreement` (
    `codeshare_agreement_id` BIGINT COMMENT 'Primary key for codeshare_agreement',
    `carrier_id` BIGINT COMMENT 'FK to route.carrier',
    `renewed_codeshare_agreement_id` BIGINT COMMENT 'Self-referencing FK on codeshare_agreement (renewed_codeshare_agreement_id)',
    `agreement_code` STRING COMMENT 'Externally-known unique business identifier for the codeshare agreement, used in operational systems and partner communications.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the codeshare agreement for business reference and reporting.',
    `agreement_type` STRING COMMENT 'Classification of the codeshare agreement model defining inventory control and revenue sharing arrangements.',
    `alliance_affiliation` STRING COMMENT 'Name of the airline alliance under which this codeshare agreement operates, if applicable.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the codeshare agreement automatically renews upon expiration without explicit renegotiation.',
    `baggage_allowance_harmonization` BOOLEAN COMMENT 'Indicates whether baggage policies are harmonized between operating and marketing carriers for codeshare flights.',
    `bilateral_agreement_reference` STRING COMMENT 'Reference identifier or citation to the underlying bilateral air service agreement that authorizes this codeshare.',
    `block_space_seats` STRING COMMENT 'Number of seats allocated to the marketing carrier under block space codeshare arrangements.',
    `codeshare_agreement_status` STRING COMMENT 'Current lifecycle state of the codeshare agreement indicating operational validity and enforceability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this codeshare agreement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the codeshare agreement becomes binding and operational for flight inventory and revenue management.',
    `expiration_date` DATE COMMENT 'Date when the codeshare agreement terminates or requires renewal; nullable for evergreen agreements.',
    `fare_basis_code_sharing_allowed` BOOLEAN COMMENT 'Indicates whether fare basis codes can be shared between operating and marketing carriers under this agreement.',
    `frequent_flyer_accrual_allowed` BOOLEAN COMMENT 'Indicates whether passengers can earn frequent flyer miles on the marketing carriers program for codeshare flights.',
    `interline_ticketing_allowed` BOOLEAN COMMENT 'Indicates whether interline ticketing is permitted under this codeshare agreement for multi-carrier itineraries.',
    `inventory_control_party` STRING COMMENT 'Designates which carrier has authority over seat inventory management and availability control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this codeshare agreement record was last updated or modified.',
    `liability_allocation_model` STRING COMMENT 'Defines which carrier bears primary liability for passenger claims and operational issues under this codeshare.',
    `lounge_access_reciprocity` BOOLEAN COMMENT 'Indicates whether marketing carrier passengers have access to operating carrier lounges under this agreement.',
    `marketing_carrier_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the marketing carrier when percentage-split revenue model is used.',
    `minimum_connecting_time_minutes` STRING COMMENT 'Minimum connection time in minutes required for passengers transferring between codeshare flights.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to the codeshare agreement.',
    `operating_carrier_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the operating carrier when percentage-split revenue model is used.',
    `prorate_method` STRING COMMENT 'Calculation methodology for revenue proration when prorate revenue share model is applied.',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory authorities approved this codeshare agreement for commercial operation.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval from aviation authorities for this codeshare agreement.',
    `regulatory_authority` STRING COMMENT 'Name of the aviation regulatory body that granted approval for this codeshare agreement.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before expiration to trigger renewal or termination of the agreement.',
    `revenue_share_model` STRING COMMENT 'Method used to allocate revenue between operating and marketing carriers under this codeshare agreement.',
    `schedule_coordination_required` BOOLEAN COMMENT 'Indicates whether flight schedules must be coordinated between operating and marketing carriers under this agreement.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated early, if applicable; distinct from planned expiration.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the codeshare agreement.',
    CONSTRAINT pk_codeshare_agreement PRIMARY KEY(`codeshare_agreement_id`)
) COMMENT 'Master reference table for codeshare_agreement. Referenced by route_codeshare_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_city_pair_id` FOREIGN KEY (`city_pair_id`) REFERENCES `airlines_ecm`.`route`.`city_pair`(`city_pair_id`);
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_partnership_id` FOREIGN KEY (`partnership_id`) REFERENCES `airlines_ecm`.`route`.`partnership`(`partnership_id`);
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_slot_allocation_id` FOREIGN KEY (`slot_allocation_id`) REFERENCES `airlines_ecm`.`route`.`slot_allocation`(`slot_allocation_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_slot_allocation_id` FOREIGN KEY (`slot_allocation_id`) REFERENCES `airlines_ecm`.`route`.`slot_allocation`(`slot_allocation_id`);
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ADD CONSTRAINT `fk_route_slot_allocation_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ADD CONSTRAINT `fk_route_slot_allocation_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_partnership_partner_carrier_id` FOREIGN KEY (`partnership_partner_carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_codeshare_agreement_id` FOREIGN KEY (`codeshare_agreement_id`) REFERENCES `airlines_ecm`.`route`.`codeshare_agreement`(`codeshare_agreement_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ADD CONSTRAINT `fk_route_interline_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ADD CONSTRAINT `fk_route_interline_agreement_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`performance` ADD CONSTRAINT `fk_route_performance_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`performance` ADD CONSTRAINT `fk_route_performance_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ADD CONSTRAINT `fk_route_block_time_standard_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ADD CONSTRAINT `fk_route_block_time_standard_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`route`.`carrier` ADD CONSTRAINT `fk_route_carrier_parent_carrier_id` FOREIGN KEY (`parent_carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` ADD CONSTRAINT `fk_route_codeshare_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` ADD CONSTRAINT `fk_route_codeshare_agreement_renewed_codeshare_agreement_id` FOREIGN KEY (`renewed_codeshare_agreement_id`) REFERENCES `airlines_ecm`.`route`.`codeshare_agreement`(`codeshare_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`route` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`route` SET TAGS ('dbx_domain' = 'route');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `city_pair_id` SET TAGS ('dbx_business_glossary_term' = 'City Pair Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `bilateral_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Agreement Code');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `codeshare_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intensity');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_value_regex' = 'monopoly|duopoly|oligopoly|highly_competitive');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_city_code` SET TAGS ('dbx_business_glossary_term' = 'Destination City Code');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_city_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_iata_region` SET TAGS ('dbx_business_glossary_term' = 'Destination IATA Traffic Conference (TC) Region');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `destination_iata_region` SET TAGS ('dbx_value_regex' = '^TC[1-3]$');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `directionality` SET TAGS ('dbx_business_glossary_term' = 'Directionality');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `directionality` SET TAGS ('dbx_value_regex' = 'one_way|bidirectional');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `distance_band` SET TAGS ('dbx_business_glossary_term' = 'Distance Band');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `distance_band` SET TAGS ('dbx_value_regex' = 'short_haul|medium_haul|long_haul|ultra_long_haul');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `etops_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended-Range Twin-Engine Operational Performance Standards (ETOPS) Required Flag');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `great_circle_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Great Circle Distance (Kilometers)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `great_circle_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Great Circle Distance (Miles)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `hub_spoke_classification` SET TAGS ('dbx_business_glossary_term' = 'Hub-Spoke Classification');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `hub_spoke_classification` SET TAGS ('dbx_value_regex' = 'hub_to_hub|hub_to_spoke|spoke_to_spoke|point_to_point');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `interline_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Interline Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `market_classification` SET TAGS ('dbx_business_glossary_term' = 'Market Classification');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `market_classification` SET TAGS ('dbx_value_regex' = 'domestic|international|transborder');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `market_maturity` SET TAGS ('dbx_business_glossary_term' = 'Market Maturity');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `market_maturity` SET TAGS ('dbx_value_regex' = 'emerging|growth|mature|declining');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `minimum_connecting_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Connecting Time (MCT) in Minutes');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `origin_city_code` SET TAGS ('dbx_business_glossary_term' = 'Origin City Code');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `origin_city_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `origin_iata_region` SET TAGS ('dbx_business_glossary_term' = 'Origin IATA Traffic Conference (TC) Region');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `origin_iata_region` SET TAGS ('dbx_value_regex' = '^TC[1-3]$');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `scheduled_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Distance (Kilometers)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `seasonal_pattern` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Pattern');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `seasonal_pattern` SET TAGS ('dbx_value_regex' = 'year_round|summer_only|winter_only|peak_season|shoulder_season');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `slot_constrained_flag` SET TAGS ('dbx_business_glossary_term' = 'Slot Constrained Flag');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `time_zone_difference_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Difference (Hours)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `traffic_rights_category` SET TAGS ('dbx_business_glossary_term' = 'Traffic Rights Category (Freedoms of the Air)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `typical_block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Typical Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ALTER COLUMN `typical_flight_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Typical Flight Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`route` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `city_pair_id` SET TAGS ('dbx_business_glossary_term' = 'City Pair Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `station_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `origin_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `authority_type` SET TAGS ('dbx_business_glossary_term' = 'Route Authority Type');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `authority_type` SET TAGS ('dbx_value_regex' = 'domestic|international|cabotage');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `average_load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Load Factor (Percent)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `average_otp_percent` SET TAGS ('dbx_business_glossary_term' = 'Average On-Time Performance (OTP) Percent');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `codeshare_eligible` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Eligible Indicator');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `competitive_route_indicator` SET TAGS ('dbx_business_glossary_term' = 'Competitive Route Indicator');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Route Distance (Kilometers)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Route Distance (Miles)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `etops_rating_minutes` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Rating (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `etops_required` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Required Indicator');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `flight_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Flight Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `inaugural_date` SET TAGS ('dbx_business_glossary_term' = 'Inaugural Date');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `interline_eligible` SET TAGS ('dbx_business_glossary_term' = 'Interline Eligible Indicator');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `number_of_competitors` SET TAGS ('dbx_business_glossary_term' = 'Number of Competing Carriers');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `operating_season` SET TAGS ('dbx_business_glossary_term' = 'Operating Season');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `operating_season` SET TAGS ('dbx_value_regex' = 'year_round|summer_only|winter_only');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `planned_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Launch Date');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `profitability_tier` SET TAGS ('dbx_business_glossary_term' = 'Route Profitability Tier');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `profitability_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `profitability_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}$');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|suspended|planned|discontinued');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'hub_to_hub|hub_to_spoke|spoke_to_spoke|point_to_point');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Route Indicator');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'passenger|cargo|mixed');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `slot_controlled_destination` SET TAGS ('dbx_business_glossary_term' = 'Slot Controlled Destination Airport Indicator');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `slot_controlled_origin` SET TAGS ('dbx_business_glossary_term' = 'Slot Controlled Origin Airport Indicator');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `airlines_ecm`.`route`.`route` ALTER COLUMN `weekly_frequency` SET TAGS ('dbx_business_glossary_term' = 'Weekly Frequency');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Agreement Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `slot_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `bilateral_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Agreement Reference');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Carrier Code');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Flight Direction');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'outbound|inbound|circular');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Flight Distance (Kilometers)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `etops_certified_indicator` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Certified Indicator');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Designator');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]{0,1}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_number_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Status');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_number_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_number_type` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Type');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_number_type` SET TAGS ('dbx_value_regex' = 'operating|codeshare|wetlease|drylease|blocked');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `flight_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Flight Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `frequency_pattern` SET TAGS ('dbx_business_glossary_term' = 'Days of Week Frequency Pattern');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `frequency_pattern` SET TAGS ('dbx_value_regex' = '^[0-7]{7}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `full_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Full Flight Number');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `full_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]{0,1}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `gds_distribution_indicator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Distribution Indicator');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `icao_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Carrier Code');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `icao_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `interline_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interline Eligible Indicator');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `network_hub_indicator` SET TAGS ('dbx_business_glossary_term' = 'Network Hub Indicator');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `priority_ranking` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Priority Ranking');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Remarks');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `revenue_management_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Management Class');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'passenger|cargo|combi|ferry|positioning');
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ALTER COLUMN `traffic_rights_category` SET TAGS ('dbx_business_glossary_term' = 'Traffic Rights Category (Freedoms of the Air)');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` SET TAGS ('dbx_subdomain' = 'schedule_operations');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `daylight_saving_transition_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Daylight Saving Time (DST) Transition Applicable Flag');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Season Duration in Days');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Season End Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `historical_use_it_or_lose_it_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Historical Use-It-Or-Lose-It Threshold Percentage');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `iata_schedules_conference_end_date` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Schedules Conference End Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `iata_schedules_conference_location` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Schedules Conference Location');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `iata_schedules_conference_start_date` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Schedules Conference Start Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `iata_season_year` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Season Year');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `initial_schedule_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Initial Schedule Submission Deadline');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `northern_hemisphere_dst_end_date` SET TAGS ('dbx_business_glossary_term' = 'Northern Hemisphere Daylight Saving Time (DST) End Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `northern_hemisphere_dst_start_date` SET TAGS ('dbx_business_glossary_term' = 'Northern Hemisphere Daylight Saving Time (DST) Start Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Season Notes');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `peak_travel_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Peak Travel Period Flag');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `schedule_season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `schedule_season_status` SET TAGS ('dbx_value_regex' = 'planning|active|completed|archived');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Season Code');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[SW]d{2}(/d{2})?$');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `season_name` SET TAGS ('dbx_business_glossary_term' = 'Season Name');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Season Type');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'summer|winter');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `slot_coordination_cycle` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordination Cycle Identifier');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `slot_return_deadline` SET TAGS ('dbx_business_glossary_term' = 'Slot Return Deadline');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `southern_hemisphere_dst_end_date` SET TAGS ('dbx_business_glossary_term' = 'Southern Hemisphere Daylight Saving Time (DST) End Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `southern_hemisphere_dst_start_date` SET TAGS ('dbx_business_glossary_term' = 'Southern Hemisphere Daylight Saving Time (DST) Start Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Season Start Date');
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ALTER COLUMN `supplementary_schedule_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Supplementary Schedule Submission Deadline');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` SET TAGS ('dbx_subdomain' = 'schedule_operations');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `seasonal_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Schedule Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `station_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `origin_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `terminal_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Terminal Facility Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `slot_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Route Slot Allocation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `aircraft_owner` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Owner');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `aircraft_owner` SET TAGS ('dbx_value_regex' = 'owned|wet_lease|dry_lease|acmi|charter');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `arrival_time_local` SET TAGS ('dbx_business_glossary_term' = 'Arrival Time Local');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `arrival_time_local` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `arrival_time_utc` SET TAGS ('dbx_business_glossary_term' = 'Arrival Time Coordinated Universal Time (UTC)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `arrival_time_utc` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `ask_planned` SET TAGS ('dbx_business_glossary_term' = 'Available Seat Kilometers (ASK) Planned');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Time Minutes');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `codeshare_indicator` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Indicator');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `day_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Day Change Indicator');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `days_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Days of Operation (DOW Mask)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `days_of_operation` SET TAGS ('dbx_value_regex' = '^[0-7]{7}$');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `departure_time_local` SET TAGS ('dbx_business_glossary_term' = 'Departure Time Local');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `departure_time_local` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `departure_time_utc` SET TAGS ('dbx_business_glossary_term' = 'Departure Time Coordinated Universal Time (UTC)');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `departure_time_utc` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `destination_terminal` SET TAGS ('dbx_business_glossary_term' = 'Destination Terminal');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filed Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `frequency_per_week` SET TAGS ('dbx_business_glossary_term' = 'Frequency Per Week');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `meal_service_code` SET TAGS ('dbx_business_glossary_term' = 'Meal Service Code');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `meal_service_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'planned|filed|approved|active|suspended|cancelled');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'J|F|C|P');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `total_seats` SET TAGS ('dbx_business_glossary_term' = 'Total Seats');
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ALTER COLUMN `traffic_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Traffic Restriction Code');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` SET TAGS ('dbx_subdomain' = 'schedule_operations');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Route Slot Allocation Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `aircraft_size_category` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Size Category');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `aircraft_size_category` SET TAGS ('dbx_value_regex' = 'narrow_body|wide_body|regional|freighter');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `aircraft_type_restriction` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Restriction (ICAO)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `allocated_time` SET TAGS ('dbx_business_glossary_term' = 'Allocated Slot Time');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `bilateral_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Agreement Reference');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `days_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Days of Operation (Slot)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `days_of_operation` SET TAGS ('dbx_value_regex' = '^[1-7]{1,7}$');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Effective From Date');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Effective To Date');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `environmental_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Restriction Flag');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `historical_precedence_flag` SET TAGS ('dbx_business_glossary_term' = 'Historical Precedence Flag');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Slot Cancellation Reason');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_conference_reference` SET TAGS ('dbx_business_glossary_term' = 'IATA Slot Conference Reference');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Confirmation Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_coordination_level` SET TAGS ('dbx_business_glossary_term' = 'Airport Slot Coordination Level (IATA)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_coordination_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_coordinator_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordinator Reference Number');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Movement Type');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_movement_type` SET TAGS ('dbx_value_regex' = 'arrival|departure');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Slot Priority Score');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Request Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_return_reason` SET TAGS ('dbx_business_glossary_term' = 'Slot Return Reason');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_series_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Series Type');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_series_type` SET TAGS ('dbx_value_regex' = 'full_season|partial_season|single_date');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation Status');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'requested|allocated|confirmed|returned|swapped|cancelled');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_swap_partner_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Slot Swap Partner Airline Code (IATA)');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_swap_partner_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_swap_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Slot Swap Reference Number');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_tolerance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Tolerance Minutes');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_type` SET TAGS ('dbx_value_regex' = 'historical_grandfather|new_entrant|pool|ad_hoc|emergency');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `slot_usage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Slot Usage Percentage');
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ALTER COLUMN `terminal_restriction` SET TAGS ('dbx_business_glossary_term' = 'Terminal Restriction');
ALTER TABLE `airlines_ecm`.`route`.`partnership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`partnership` SET TAGS ('dbx_subdomain' = 'carrier_agreements');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Identifier');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `partnership_partner_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `codeshare_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Route Partnership Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Number');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Status');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Type');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'codeshare_free_flow|codeshare_block_space|standard_interline|special_prorate_agreement|through_check_in|joint_venture');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `antitrust_immunity_granted` SET TAGS ('dbx_business_glossary_term' = 'Antitrust Immunity Granted');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Approval Date');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Agreement Approved By');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `baggage_through_check_eligible` SET TAGS ('dbx_business_glossary_term' = 'Baggage Through-Check Eligible');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `block_space_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Block Space Seat Count');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `cabin_class_availability` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Availability');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `codeshare_flight_number_range_end` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Flight Number Range End');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `codeshare_flight_number_range_start` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Flight Number Range Start');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Effective Date');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `eticket_interline_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Ticket (E-Ticket) Interline Capable');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Expiry Date');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `frequent_flyer_accrual_eligible` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Accrual Eligible');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `frequent_flyer_redemption_eligible` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Redemption Eligible');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `gds_distribution_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Distribution Enabled');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `minimum_connecting_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Connecting Time (MCT) Minutes');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Notes');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `prorate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prorate Percentage');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `revenue_sharing_basis` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Basis');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `revenue_sharing_basis` SET TAGS ('dbx_value_regex' = 'prorate|block_space|revenue_share_pool|cost_plus|fixed_fee');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `route_scope` SET TAGS ('dbx_business_glossary_term' = 'Route Scope');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `route_scope` SET TAGS ('dbx_value_regex' = 'specific_od_pair|regional_network|global_network');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `special_service_request_passthrough` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Passthrough');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Termination Date');
ALTER TABLE `airlines_ecm`.`route`.`partnership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Partnership Termination Reason');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` SET TAGS ('dbx_subdomain' = 'carrier_agreements');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Route Interline Agreement Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `agreement_notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval|expired|under_negotiation');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Type');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard_interline|special_prorate_agreement|through_check_in|codeshare_interline|virtual_interline|bilateral_prorate');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `alliance_membership` SET TAGS ('dbx_business_glossary_term' = 'Alliance Membership');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `alliance_membership` SET TAGS ('dbx_value_regex' = 'star_alliance|oneworld|skyteam|value_alliance|none');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `baggage_through_check_eligible` SET TAGS ('dbx_business_glossary_term' = 'Baggage Through-Check Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `codeshare_eligible` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `e_ticket_interline_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Ticket (E-Ticket) Interline Capable Flag');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `frequent_flyer_accrual_eligible` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Accrual Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `gds_distribution_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Distribution Enabled Flag');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `irop_reprotection_eligible` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Reprotection Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `liability_limit_sdr` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit in Special Drawing Rights (SDR)');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `liability_limit_sdr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `minimum_connecting_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Connecting Time (MCT) in Minutes');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `prorate_basis` SET TAGS ('dbx_business_glossary_term' = 'Prorate Basis');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `prorate_basis` SET TAGS ('dbx_value_regex' = 'iata_prorate_factor|mileage_based|negotiated_fixed|revenue_share|cost_plus');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `prorate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prorate Percentage');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `prorate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `route_scope` SET TAGS ('dbx_business_glossary_term' = 'Route Scope');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `route_scope` SET TAGS ('dbx_value_regex' = 'network_wide|specific_city_pair|regional|hub_spoke|alliance_network');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `settlement_basis` SET TAGS ('dbx_business_glossary_term' = 'Settlement Basis');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `settlement_basis` SET TAGS ('dbx_value_regex' = 'bsp|arc|direct_billing|ich|bilateral_settlement');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `special_prorate_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Special Prorate Agreement (SPA) Number');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `special_prorate_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `ssr_handling_agreement` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Handling Agreement');
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ALTER COLUMN `ssr_handling_agreement` SET TAGS ('dbx_value_regex' = 'full_ssr_exchange|limited_ssr|no_ssr_exchange');
ALTER TABLE `airlines_ecm`.`route`.`performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`route`.`performance` SET TAGS ('dbx_subdomain' = 'schedule_operations');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `performance_id` SET TAGS ('dbx_business_glossary_term' = 'Route Performance ID');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season ID');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `ask` SET TAGS ('dbx_business_glossary_term' = 'Available Seat Kilometers (ASK)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `available_seats_total` SET TAGS ('dbx_business_glossary_term' = 'Available Seats Total');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `average_block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Block Time Minutes');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `average_delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Delay Minutes');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `block_time_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Time Variance Minutes');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `cancellation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Rate Percentage');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `cask` SET TAGS ('dbx_business_glossary_term' = 'Cost per Available Seat Kilometer (CASK)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `cask` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `diversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Percentage');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `flights_cancelled_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Cancelled Count');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `flights_diverted_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Diverted Count');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `flights_operated_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Operated Count');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `flights_scheduled_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Scheduled Count');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Performance Grade');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Percentage');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'monthly|seasonal|quarterly|annual|weekly|custom');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `otp_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Performance (OTP) Percentage');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `passengers_carried_count` SET TAGS ('dbx_business_glossary_term' = 'Passengers Carried Count');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `rask` SET TAGS ('dbx_business_glossary_term' = 'Revenue per Available Seat Kilometer (RASK)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `rask` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `rpk` SET TAGS ('dbx_business_glossary_term' = 'Revenue Passenger Kilometers (RPK)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Amount');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Amount');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `yield` SET TAGS ('dbx_business_glossary_term' = 'Yield (Revenue per RPK)');
ALTER TABLE `airlines_ecm`.`route`.`performance` ALTER COLUMN `yield` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` SET TAGS ('dbx_subdomain' = 'schedule_operations');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `block_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Block Time Standard Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `airborne_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Airborne Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `atc_delay_factor_minutes` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Delay Factor (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `block_time_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Block Time Standard Status');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `block_time_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|superseded');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `contingency_buffer_minutes` SET TAGS ('dbx_business_glossary_term' = 'Contingency Buffer (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `crew_duty_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Crew Duty Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Flight Direction');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `etops_time_adjustment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Extended-Range Twin-Engine Operational Performance Standards (ETOPS) Time Adjustment (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `fuel_planning_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Fuel Planning Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `historical_average_block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Historical Average Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `percentile_85_block_time_minutes` SET TAGS ('dbx_business_glossary_term' = '85th Percentile Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `planned_block_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Block Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `seasonal_adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Type');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `seasonal_adjustment_type` SET TAGS ('dbx_value_regex' = 'summer|winter|year_round');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `slot_constrained_adjustment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot-Constrained Adjustment (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `standard_deviation_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `taxi_in_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Taxi-In Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `taxi_out_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Taxi-Out Time (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ALTER COLUMN `wind_adjustment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Wind Adjustment (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` SET TAGS ('dbx_subdomain' = 'schedule_operations');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Route Fleet Assignment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Identifier (ID)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Approval Date');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Code');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Duration (Days)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Priority');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_rationale` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Rationale');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Status');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|active|suspended|cancelled|historical');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Type');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|seasonal|temporary|charter|wet_lease|dry_lease');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `business_class_seats` SET TAGS ('dbx_business_glossary_term' = 'Business Class Seats');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `cargo_belly_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Belly Capacity (Kilograms)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `cargo_belly_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Cargo Belly Capacity (Cubic Meters)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `codeshare_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `days_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Days of Operation');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `days_of_operation` SET TAGS ('dbx_value_regex' = '^[1-7]{1,7}$');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `economy_class_seats` SET TAGS ('dbx_business_glossary_term' = 'Economy Class Seats');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Effective End Date');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Effective Start Date');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `etops_rating_minutes` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Rating (Minutes)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `etops_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended-range Twin-engine Operational Performance Standards (ETOPS) Required Flag');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `first_class_seats` SET TAGS ('dbx_business_glossary_term' = 'First Class Seats');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `interline_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Interline Eligible Flag');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Notes');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `planned_ask_capacity` SET TAGS ('dbx_business_glossary_term' = 'Planned Available Seat Kilometers (ASK) Capacity');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `premium_economy_seats` SET TAGS ('dbx_business_glossary_term' = 'Premium Economy Seats');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `target_load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Load Factor (Percent)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `total_seats` SET TAGS ('dbx_business_glossary_term' = 'Total Seats (Gauge)');
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ALTER COLUMN `weekly_frequency` SET TAGS ('dbx_business_glossary_term' = 'Weekly Flight Frequency');
ALTER TABLE `airlines_ecm`.`route`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_agreements');
ALTER TABLE `airlines_ecm`.`route`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `airlines_ecm`.`route`.`carrier` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`route`.`carrier` ALTER COLUMN `parent_carrier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` SET TAGS ('dbx_subdomain' = 'carrier_agreements');
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` ALTER COLUMN `codeshare_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Agreement Identifier');
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` ALTER COLUMN `renewed_codeshare_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` ALTER COLUMN `marketing_carrier_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`route`.`codeshare_agreement` ALTER COLUMN `operating_carrier_share_percentage` SET TAGS ('dbx_confidential' = 'true');
