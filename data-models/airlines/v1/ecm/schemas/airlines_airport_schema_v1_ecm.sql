-- Schema for Domain: airport | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`airport` COMMENT 'Ground handling and airport operations data including gate assignments, turnaround operations, baggage handling and tracing, ramp services, aircraft servicing, ground support equipment (GSE) scheduling, slot management, CDM (Collaborative Decision Making) messages, PFC (Passenger Facility Charge) records, check-in and boarding process events, and airport facility coordination. Manages hub operations and spoke station activities. Aligns with SITA Airport Management Platform.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`terminal_facility` (
    `terminal_facility_id` BIGINT COMMENT 'Unique identifier for the airport terminal facility record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Terminal facilities are cost centers for budgeting, P&L reporting, and operational expense allocation. Airlines track terminal operating costs (utilities, maintenance, staffing) against budgets for st',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Terminal facilities require operational managers from workforce for day-to-day operations, staff coordination, and incident response. Aviation operations standard practice to assign facility managers.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: terminal_facility exists at a specific station/airport. Currently stores airport_code and icao_code (both STRING). FK to station provides access to station details including both IATA and ICAO codes, ',
    `accessibility_compliance_flag` BOOLEAN COMMENT 'Indicates whether the terminal facility meets accessibility standards for passengers with reduced mobility (PRM) including wheelchair access, accessible counters, and assistance services.',
    `annual_passenger_volume` BIGINT COMMENT 'Total number of passengers processed through this terminal facility in the most recent full calendar year.',
    `bag_drop_counter_count` STRING COMMENT 'Number of dedicated self-service bag drop counters for passengers who have completed online or kiosk check-in.',
    `biometric_capability_flag` BOOLEAN COMMENT 'Indicates whether the terminal facility is equipped with biometric passenger processing technology (facial recognition, fingerprint scanning) for check-in and boarding.',
    `cdm_enabled_flag` BOOLEAN COMMENT 'Indicates whether the terminal facility participates in Airport Collaborative Decision Making (A-CDM) for real-time information sharing between airport, airlines, and Air Traffic Control (ATC).',
    `check_in_counter_count` STRING COMMENT 'Total number of full-service check-in counters staffed by airline agents for passenger processing and baggage acceptance.',
    `contact_gate_count` STRING COMMENT 'Number of contact gates equipped with jet bridges for direct aircraft-to-terminal passenger boarding.',
    `counter_zone_designation` STRING COMMENT 'Alphanumeric designation of check-in counter zones within the terminal (e.g., Zone A, Rows 1-20, Island 3).',
    `customs_facility_flag` BOOLEAN COMMENT 'Indicates whether the terminal has customs and border control facilities for international passenger processing.',
    `facility_address` STRING COMMENT 'Physical street address of the terminal facility for operational coordination and ground transportation routing.',
    `facility_city` STRING COMMENT 'City where the terminal facility is located.',
    `facility_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the terminal facility location (e.g., USA, GBR, ARE).. Valid values are `^[A-Z]{3}$`',
    `facility_email` STRING COMMENT 'Primary email address for terminal facility operational communications and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facility_phone` STRING COMMENT 'Primary contact telephone number for terminal facility operations and coordination.',
    `facility_postal_code` STRING COMMENT 'Postal or ZIP code for the terminal facility address.',
    `facility_type` STRING COMMENT 'Classification of the terminal facility structure type.. Valid values are `terminal_building|concourse|pier|satellite|check_in_hall|gate_area`',
    `hub_classification` STRING COMMENT 'Strategic classification of the airport station in the airlines network (hub = central connecting airport, spoke = route from hub to destination).. Valid values are `hub|spoke|focus_city|outstation|maintenance_base`',
    `last_renovation_date` DATE COMMENT 'Date of the most recent major renovation or modernization project completed for this terminal facility.',
    `lounge_count` STRING COMMENT 'Number of airline lounges operated within this terminal facility for premium passengers and Frequent Flyer Program (FFP) members.',
    `opening_date` DATE COMMENT 'Date when the terminal facility first became operational for passenger services.',
    `operating_airline_code` STRING COMMENT 'IATA airline code of the primary operating carrier for this terminal facility (null for joint-use or airport authority facilities).. Valid values are `^[A-Z0-9]{2,3}$`',
    `operational_status` STRING COMMENT 'Current operational state of the terminal facility.. Valid values are `operational|under_construction|closed|seasonal|maintenance`',
    `ownership_model` STRING COMMENT 'Designation of facility ownership and usage rights (airline-owned, joint-use with other carriers, or airport authority managed).. Valid values are `airline_owned|joint_use|leased|shared_facility|airport_authority`',
    `passenger_capacity_per_hour` STRING COMMENT 'Design capacity of the terminal facility measured in passengers (PAX) that can be processed per hour during peak operations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this terminal facility record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this terminal facility record was last modified in the system.',
    `remote_gate_count` STRING COMMENT 'Number of remote gates requiring bus transportation for passenger boarding (no jet bridge connection).',
    `security_checkpoint_count` STRING COMMENT 'Number of Transportation Security Administration (TSA) or equivalent security screening checkpoints in the terminal facility.',
    `self_service_kiosk_count` STRING COMMENT 'Number of self-service check-in kiosks (CUSS - Common Use Self-Service) available for passenger self-check-in.',
    `slot_coordinated_flag` BOOLEAN COMMENT 'Indicates whether the airport requires slot coordination (allocated takeoff and landing times) due to capacity constraints.',
    `terminal_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area of the terminal facility measured in square meters.',
    `terminal_identifier` STRING COMMENT 'Business identifier for the terminal within the airport (e.g., Terminal 1, Terminal A, Concourse B, Satellite Terminal).',
    `total_gate_count` STRING COMMENT 'Total number of aircraft gates available in this terminal facility for passenger boarding and deplaning operations.',
    CONSTRAINT pk_terminal_facility PRIMARY KEY(`terminal_facility_id`)
) COMMENT 'Master record for airport terminal facilities including terminal buildings, concourses, piers, satellite structures, and check-in counter/kiosk assets. Captures IATA/ICAO airport codes, terminal identifiers, facility type, total gate count, check-in counter inventory (counter zones, types including full-service/self-service/CUSS/bag-drop, airline assignments, accessibility compliance, biometric capability), lounge count, capacity (PAX per hour), operational status, hub classification (hub vs spoke station), and owning airline or joint-use designation. SSOT for physical airport facility assets and check-in infrastructure managed by the airline.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`gate` (
    `gate_id` BIGINT COMMENT 'Unique identifier for the aircraft gate. Primary key for the gate master record.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Gates incur direct operating costs (ground power, jetbridge maintenance, utilities) that must be allocated to cost centers for financial reporting, station P&L analysis, and turnaround cost modeling u',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: gate exists at a specific station/airport. Currently stores airport_code (STRING). FK to station provides access to station details, time zone, and operational context. The airport_code becomes redund',
    `terminal_facility_id` BIGINT COMMENT 'Reference to the terminal facility that contains this gate.',
    `aircraft_size_code_max` STRING COMMENT 'Maximum ICAO aircraft size code (A through F) that this gate can accommodate based on wingspan, parking envelope, and structural limitations.. Valid values are `^[A-F]$`',
    `aircraft_size_code_min` STRING COMMENT 'Minimum ICAO aircraft size code (A through F) that this gate can accommodate based on wingspan and parking envelope.. Valid values are `^[A-F]$`',
    `common_use_gate` BOOLEAN COMMENT 'Indicates whether this gate is operated as a common-use facility available to multiple airlines through dynamic assignment, or is dedicated to a specific carrier.',
    `concourse` STRING COMMENT 'The concourse or pier designation within the terminal (e.g., A, B, C, D, International).. Valid values are `^[A-Z0-9]{1,5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gate master record was first created in the system.',
    `customs_facility` BOOLEAN COMMENT 'Indicates whether this gate has direct access to customs and immigration facilities for international arrivals processing.',
    `domestic_capable` BOOLEAN COMMENT 'Indicates whether this gate is equipped and authorized to handle domestic flights.',
    `effective_date` DATE COMMENT 'Date when this gate configuration became or will become operationally effective.',
    `expiry_date` DATE COMMENT 'Date when this gate configuration will cease to be valid (null for indefinite configurations).',
    `fuel_hydrant_available` BOOLEAN COMMENT 'Indicates whether underground fuel hydrant system is available at this gate position for aircraft refueling operations.',
    `gate_number` STRING COMMENT 'The alphanumeric gate identifier displayed to passengers and used in operational systems (e.g., A12, B5, C23).. Valid values are `^[A-Z0-9]{1,10}$`',
    `gate_type` STRING COMMENT 'Classification of gate based on aircraft parking configuration: contact (jetbridge-connected), remote (apron position requiring bus), hardstand (unpaved remote stand), bus_gate (passenger bus boarding point), swing_gate (can serve domestic or international).. Valid values are `contact|remote|hardstand|bus_gate|swing_gate`',
    `ground_power_unit_available` BOOLEAN COMMENT 'Indicates whether fixed ground power unit (GPU) electrical supply is available at this gate for aircraft systems during turnaround.',
    `international_capable` BOOLEAN COMMENT 'Indicates whether this gate is equipped and authorized to handle international flights with customs, immigration, and border control requirements.',
    `jetbridge_available` BOOLEAN COMMENT 'Indicates whether a passenger boarding bridge (jetbridge/airbridge) is installed and operational at this gate.',
    `jetbridge_count` STRING COMMENT 'Number of passenger boarding bridges available at this gate (0 for remote stands, 1-3 for contact gates serving wide-body aircraft).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gate master record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the gate parking position in decimal degrees for Ground Support Equipment (GSE) navigation and airport mapping systems.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the gate parking position in decimal degrees for Ground Support Equipment (GSE) navigation and airport mapping systems.',
    `max_aircraft_length_meters` DECIMAL(18,2) COMMENT 'Maximum aircraft fuselage length in meters that can be accommodated at this gate position.',
    `max_wingspan_meters` DECIMAL(18,2) COMMENT 'Maximum aircraft wingspan in meters that can be safely accommodated at this gate position.',
    `minimum_turnaround_time_minutes` STRING COMMENT 'Minimum aircraft turnaround time in minutes required at this gate based on facility capabilities and Ground Support Equipment (GSE) availability.',
    `narrow_body_capable` BOOLEAN COMMENT 'Indicates whether this gate can accommodate narrow-body aircraft (typically ICAO codes B, C such as A320 family, B737 family).',
    `operating_airline_code` STRING COMMENT 'IATA airline code of the carrier that has preferential or exclusive use rights to this gate under lease or operating agreement (null if common-use gate).. Valid values are `^[A-Z0-9]{2,3}$`',
    `operational_status` STRING COMMENT 'Current operational availability status of the gate for flight assignments and turnaround operations.. Valid values are `operational|maintenance|closed|reserved|inactive`',
    `parking_stand_designation` STRING COMMENT 'The official apron parking stand identifier used in airport operations and ATC communications (may differ from passenger-facing gate number).',
    `potable_water_available` BOOLEAN COMMENT 'Indicates whether fixed potable water supply connection is available at this gate for aircraft water system servicing.',
    `preconditioned_air_available` BOOLEAN COMMENT 'Indicates whether fixed preconditioned air system is available at this gate for aircraft cabin climate control during turnaround, reducing APU usage.',
    `regional_jet_capable` BOOLEAN COMMENT 'Indicates whether this gate can accommodate regional jet aircraft (typically ICAO code A such as CRJ, ERJ families).',
    `remarks` STRING COMMENT 'Free-text operational notes regarding gate restrictions, special handling requirements, or temporary conditions affecting gate usage.',
    `schengen_capable` BOOLEAN COMMENT 'Indicates whether this gate can handle flights within the Schengen Area (European airports only) without passport control requirements.',
    `wide_body_capable` BOOLEAN COMMENT 'Indicates whether this gate can accommodate wide-body aircraft (typically ICAO codes D, E, F such as B777, B787, A330, A350, A380).',
    CONSTRAINT pk_gate PRIMARY KEY(`gate_id`)
) COMMENT 'Master record for individual aircraft gates within a terminal facility. Captures gate identifier, terminal reference, concourse, gate type (contact/remote/hardstand), compatible aircraft categories (ICAO size codes A–F), jetbridge availability, ground power unit (GPU) availability, potable water availability, operational status, and maximum wingspan clearance. Serves as the SSOT for gate asset definitions used in gate assignment and turnaround planning.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`gate_assignment` (
    `gate_assignment_id` BIGINT COMMENT 'Unique identifier for the gate assignment record. Primary key for the gate assignment transaction.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Gate compatibility verification (aircraft size vs gate capability), stand planning, and ground equipment deployment require aircraft linkage. Critical for operational safety and efficient gate utiliza',
    `employee_id` BIGINT COMMENT 'Identifier of the operations dispatcher or system user who created or last modified this gate assignment. Used for audit trail and operational accountability.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg being assigned to the gate. Links to the flight operations domain.',
    `gate_id` BIGINT COMMENT 'Foreign key linking to airport.gate. Business justification: gate_assignment references a specific gate but currently uses gate_identifier (STRING) and terminal_code. Normalizing to FK allows joining to gate master for all gate attributes (gate_number, concours',
    `actual_gate_in_time` TIMESTAMP COMMENT 'Actual timestamp when aircraft arrived at gate and set parking brake (Actual On-block from OOOI). Captured via ACARS or manual entry. Critical for OTP calculation and turnaround tracking.',
    `actual_gate_out_time` TIMESTAMP COMMENT 'Actual timestamp when aircraft pushed back from gate and released parking brake (Actual Off-block from OOOI). Captured via ACARS or manual entry. Marks gate release and availability for next assignment.',
    `aircraft_size_category` STRING COMMENT 'Size classification of aircraft assigned to gate, used for gate compatibility validation. Narrow-body: single aisle; Wide-body: twin aisle; Regional: small aircraft; Heavy: large aircraft; Super: A380 class.. Valid values are `narrow_body|wide_body|regional|heavy|super`',
    `airport_iata_code` STRING COMMENT 'Three-letter IATA airport code where this gate assignment occurs (e.g., JFK, LHR, DXB). Identifies the operational airport for multi-hub airline networks.. Valid values are `^[A-Z]{3}$`',
    `arrival_gate` STRING COMMENT 'The gate number or stand identifier at the destination airport where the flight arrived. [Moved from flight_leg: arrival_gate is a STRING attribute in flight_leg that represents the gate assignment at arrival. This should be replaced by the gate_assignment association, as a flight can be reassigned to multiple gates during IROP. The actual gate used is determined by querying gate_assignment with assignment_type=arrival or turnaround and assignment_status=completed.]. Valid values are `^[A-Z0-9]{1,5}$`',
    `assignment_end_time` TIMESTAMP COMMENT 'Timestamp when the gate reservation expires and becomes available for next assignment, typically includes buffer after scheduled gate-out for cleanup and turnaround completion.',
    `assignment_number` STRING COMMENT 'Business identifier for the gate assignment, formatted as GA followed by 8 digits. Used for operational reference and CDM messaging.. Valid values are `^GA[0-9]{8}$`',
    `assignment_source` STRING COMMENT 'Origin of the gate assignment decision. CDM: Collaborative Decision Making system; Manual: dispatcher override; Auto-assign: automated allocation; Rescheduled: changed from original; IROP: irregular operations reassignment.. Valid values are `cdm|manual|auto_assign|rescheduled|irop`',
    `assignment_start_time` TIMESTAMP COMMENT 'Timestamp when the gate was reserved for this flight, typically earlier than scheduled gate-in to allow for ground equipment setup and early arrival buffer.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the gate assignment. Planned: initial assignment; Confirmed: verified by operations; Active: aircraft at gate; Completed: turnaround finished; Released: gate available; Cancelled: assignment voided.. Valid values are `planned|confirmed|active|completed|released|cancelled`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Timestamp when this gate assignment record was initially created in the system. Represents the business event time of assignment decision, distinct from technical audit timestamps.',
    `cdm_milestone_status` STRING COMMENT 'Current CDM milestone achieved for this gate assignment. TOBT: Target Off-Block Time set; TSAT: Target Start-Up Approval Time issued; AOBT: Actual Off-Block Time; AIBT: Actual In-Block Time; ALDT: Actual Landing Time.. Valid values are `tobt_set|tsat_issued|aobt_actual|aibt_actual|aldt_actual|pending`',
    `conflict_flag` BOOLEAN COMMENT 'Indicates whether this gate assignment has a scheduling conflict with another assignment (overlapping time windows). True when conflict detected; requires resolution by operations.',
    `conflict_resolution_notes` STRING COMMENT 'Free-text notes documenting how a gate assignment conflict was resolved, including dispatcher actions, alternative gate assignments, or operational adjustments made.',
    `departure_gate` STRING COMMENT 'The gate number or stand identifier at the origin airport from which the flight departed. [Moved from flight_leg: departure_gate is a STRING attribute in flight_leg that represents the gate assignment at departure. This should be replaced by the gate_assignment association, as a flight can be reassigned to multiple gates during IROP. The actual gate used is determined by querying gate_assignment with assignment_type=departure or turnaround and assignment_status=completed.]. Valid values are `^[A-Z0-9]{1,5}$`',
    `domestic_international_flag` STRING COMMENT 'Indicates whether the flight assigned to this gate is domestic or international. Schengen applies to intra-European flights with no border control. Determines gate area assignment and customs/immigration requirements.. Valid values are `domestic|international|schengen`',
    `gate_hold_reason` STRING COMMENT 'Free-text explanation for any gate hold or delay in releasing the gate assignment. Documents operational reasons such as late arriving aircraft, maintenance issues, or ATC delays.',
    `gate_type` STRING COMMENT 'Classification of gate facility type. Contact: jet bridge equipped; Remote: bus boarding; Hardstand: tarmac parking; Cargo: freight operations. Determines boarding method and ground service requirements.. Valid values are `contact|remote|hardstand|cargo`',
    `ground_power_available_flag` BOOLEAN COMMENT 'Indicates whether ground power unit (GPU) is available at this gate for this assignment. Required for aircraft electrical power during turnaround when APU is shut down.',
    `hub_spoke_indicator` STRING COMMENT 'Classification of airport operational role in airline network. Hub: major connecting airport; Spoke: destination from hub; Focus city: secondary hub; Outstation: remote station with limited operations.. Valid values are `hub|spoke|focus_city|outstation`',
    `jet_bridge_available_flag` BOOLEAN COMMENT 'Indicates whether a jet bridge (passenger boarding bridge) is available and operational at this gate for this assignment. Critical for passenger boarding operations and accessibility requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gate assignment record was last updated. Tracks changes to assignment details, status transitions, or operational adjustments.',
    `passenger_facility_charge_applicable_flag` BOOLEAN COMMENT 'Indicates whether Passenger Facility Charge applies to this gate assignment based on airport authority regulations. Used for financial settlement and regulatory reporting to DOT.',
    `preconditioned_air_available_flag` BOOLEAN COMMENT 'Indicates whether preconditioned air (PCA) system is available at this gate for cabin climate control during turnaround. Reduces APU usage and fuel burn.',
    `priority_override_flag` BOOLEAN COMMENT 'Indicates whether this assignment received priority treatment overriding normal allocation rules. True for VIP flights, IROP recovery, or operational priority situations.',
    `priority_override_reason` STRING COMMENT 'Business reason for priority override of normal gate assignment rules. Documents justification for preferential gate allocation outside standard procedures. [ENUM-REF-CANDIDATE: vip_flight|irop_recovery|maintenance_priority|diplomatic|medical_emergency|operational_necessity|none — 7 candidates stripped; promote to reference product]',
    `remarks` STRING COMMENT 'Free-text operational notes and comments related to this gate assignment. Used by dispatchers and ground operations for coordination and situational awareness.',
    `scheduled_gate_in_time` TIMESTAMP COMMENT 'Planned timestamp when aircraft is scheduled to arrive at the gate and set parking brake (On-block time from OOOI). Used for gate allocation planning and OTP reporting.',
    `scheduled_gate_out_time` TIMESTAMP COMMENT 'Planned timestamp when aircraft is scheduled to push back from gate and release parking brake (Off-block time from OOOI). Used for gate release planning and next assignment scheduling.',
    `slot_coordination_required_flag` BOOLEAN COMMENT 'Indicates whether this gate assignment requires coordination with airport slot allocation due to capacity constraints at slot-controlled airport. True for Level 3 coordinated airports.',
    `special_handling_code` STRING COMMENT 'Special Service Request code indicating special handling requirements for this gate assignment (e.g., WCHR for wheelchair, DEPA for deportee, MEDA for medical). Drives ground service and security coordination.. Valid values are `^[A-Z]{3,4}$`',
    `stand_compatibility_code` STRING COMMENT 'ICAO aerodrome reference code indicating maximum aircraft size the gate can accommodate (A through F). Ensures aircraft-gate physical compatibility for safe operations.. Valid values are `^[A-F]$`',
    `turnaround_duration_minutes` STRING COMMENT 'Planned duration in minutes for aircraft turnaround at the gate, from gate-in to gate-out. Varies by aircraft type, service level, and operational requirements.',
    CONSTRAINT pk_gate_assignment PRIMARY KEY(`gate_assignment_id`)
) COMMENT 'Transactional record linking a specific flight leg to a gate for a defined time window. Captures flight identifier, tail number, scheduled and actual gate-in/gate-out timestamps (OOOI-aligned), gate identifier, assignment source (CDM/manual/auto-assign), conflict flag, priority override reason, and assignment status (planned/confirmed/released). Supports turnaround sequencing, CDM messaging, and OTP reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`turnaround` (
    `turnaround_id` BIGINT COMMENT 'Unique identifier for the aircraft turnaround event. Primary key for the turnaround record.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Turnaround performance analysis by aircraft, maintenance event correlation, and technical delay attribution require aircraft linkage. Ground operations planning and aircraft-specific service requireme',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Turnaround operations are cost-tracked activities for CASK (cost per available seat kilometer) calculation, station profitability analysis, and ground handling cost allocation. Essential for financial',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: turnaround occurs at a specific gate assignment (time-bound gate allocation). Currently stores gate_assignment as STRING. FK to gate_assignment provides access to gate details, assignment times, and a',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: turnaround services are performed by a specific ground handler. Currently stores ground_handler_code (STRING). FK to ground_handler provides access to handler name, capabilities, performance tier, SLA',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Aircraft turnaround events occur at specific airport stations. The turnaround table currently has airport_code as a STRING denormalized attribute, but no FK to station. Adding station_id normalizes th',
    `flight_leg_id` BIGINT COMMENT 'Reference to the arriving flight leg that initiates this turnaround event.',
    `turnaround_outbound_flight_leg_id` BIGINT COMMENT 'Reference to the departing flight leg that concludes this turnaround event.',
    `actual_block_in_time` TIMESTAMP COMMENT 'Actual timestamp when the inbound aircraft arrived at the gate and parking brake was set (OOOI - On event).',
    `actual_block_out_time` TIMESTAMP COMMENT 'Actual timestamp when the outbound aircraft pushed back from the gate and began taxi (OOOI - Off event).',
    `actual_turnaround_time_minutes` STRING COMMENT 'Actual duration in minutes from block-in to block-out. Calculated as the difference between actual_block_out_time and actual_block_in_time.',
    `all_services_completed_flag` BOOLEAN COMMENT 'Indicates whether all ordered ground services have been completed and signed off. True when turnaround is ready for departure.',
    `baggage_pieces_loaded` STRING COMMENT 'Total number of baggage pieces loaded onto the outbound flight during turnaround.',
    `baggage_pieces_offloaded` STRING COMMENT 'Total number of baggage pieces offloaded from the inbound flight during turnaround.',
    `cargo_weight_loaded_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of cargo and mail loaded onto the outbound flight.',
    `cargo_weight_offloaded_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of cargo and mail offloaded from the inbound flight.',
    `cdm_milestone_status` STRING COMMENT 'JSON or delimited string capturing CDM milestone timestamps (TOBT, TSAT, TTOT, AOBT, ASAT, ATOT) for Airport CDM integration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this turnaround record was first created in the system.',
    `delay_code` STRING COMMENT 'Two-digit IATA delay code indicating the primary cause of any turnaround delay (e.g., 31=aircraft defect, 32=lack of crew, 81=weather, 82=ATC).. Valid values are `^[0-9]{2}$`',
    `delay_minutes` STRING COMMENT 'Total delay in minutes attributed to turnaround operations. Calculated as actual_turnaround_time_minutes minus target_turnaround_time_minutes when positive.',
    `deviation_notes` STRING COMMENT 'Free-text description of any deviations from standard turnaround procedures, service failures, or operational irregularities encountered.',
    `fuel_uplift_kg` DECIMAL(18,2) COMMENT 'Quantity of fuel in kilograms added to the aircraft during this turnaround.',
    `ground_support_equipment_assigned` STRING COMMENT 'Comma-separated list of GSE unit identifiers assigned to this turnaround (e.g., GPU-123, belt loader-456, tug-789).',
    `handler_instructions` STRING COMMENT 'Special instructions or notes for the ground handler regarding this specific turnaround (e.g., VIP passenger, special cargo, MEL items, security requirements).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this turnaround record was most recently modified.',
    `otp_impact_flag` BOOLEAN COMMENT 'Indicates whether this turnaround contributed to an on-time performance failure (departure delay >15 minutes). Used for OTP root-cause analysis.',
    `passenger_count_boarded` STRING COMMENT 'Number of passengers who boarded the outbound flight during this turnaround.',
    `passenger_count_deplaned` STRING COMMENT 'Number of passengers who deplaned from the inbound flight during this turnaround.',
    `ramp_service_order_number` STRING COMMENT 'Unique identifier for the ramp service order that defines all ground services to be performed during this turnaround.. Valid values are `^[A-Z0-9]{6,12}$`',
    `scheduled_block_in_time` TIMESTAMP COMMENT 'Planned timestamp when the inbound aircraft is scheduled to arrive at the gate (OOOI - On event).',
    `scheduled_block_out_time` TIMESTAMP COMMENT 'Planned timestamp when the outbound aircraft is scheduled to push back from the gate (OOOI - Off event).',
    `service_window_end_time` TIMESTAMP COMMENT 'Latest timestamp by which all ground service operations must be completed to meet scheduled block-out time.',
    `service_window_start_time` TIMESTAMP COMMENT 'Earliest timestamp when ground service operations can commence, typically shortly after block-in.',
    `services_completion_time` TIMESTAMP COMMENT 'Timestamp when all ground services were completed and aircraft was declared ready for departure.',
    `services_ordered` STRING COMMENT 'Comma-separated list of ground services ordered for this turnaround (e.g., fueling, catering, cleaning, water service, lavatory service, GPU, air start, deicing, baggage handling, cargo loading).',
    `target_turnaround_time_minutes` STRING COMMENT 'Planned duration in minutes for the complete turnaround cycle from block-in to block-out, based on aircraft type and turnaround type.',
    `turnaround_status` STRING COMMENT 'Current operational status of the turnaround event. Tracks lifecycle from scheduled through completion or cancellation.. Valid values are `scheduled|in_progress|completed|delayed|cancelled|diverted`',
    `turnaround_type` STRING COMMENT 'Classification of turnaround based on duration and service scope. Standard (60-90 min), quick (<45 min), overnight (>8 hours), transit (international connection), maintenance (scheduled service), extended (unplanned delay).. Valid values are `standard|quick|overnight|transit|maintenance|extended`',
    CONSTRAINT pk_turnaround PRIMARY KEY(`turnaround_id`)
) COMMENT 'Master operational record for an aircraft turnaround event at a gate, representing the full ground servicing cycle between inbound and outbound flight legs. Captures inbound and outbound flight references, tail number, gate assignment, scheduled and actual block-in/block-out times, turnaround type (standard/quick/overnight/transit), target turnaround time (TTT), actual turnaround time, overall status, responsible ground handler, ramp service order details (ordered services, service window, handler instructions, completion status, deviation notes), and OTP contribution metrics. Central entity for ground operations coordination, handler SLA measurement, and OTP root-cause analysis.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`turnaround_task` (
    `turnaround_task_id` BIGINT COMMENT 'Unique identifier for the individual ground servicing task within a turnaround event. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the individual ground service operator or technician assigned to execute this task. Used for accountability and certification tracking.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg associated with this turnaround task. Connects the ground service task to the specific flight operation.',
    `gse_asset_id` BIGINT COMMENT 'Reference to the primary ground support equipment asset deployed for this task (e.g., fuel truck, catering truck, GPU, tug, belt loader).',
    `gse_deployment_id` BIGINT COMMENT 'Foreign key linking to airport.gse_deployment. Business justification: turnaround_task may involve a specific gse_deployment. While turnaround_task already has gse_asset_id, the gse_deployment record captures the transactional deployment details (planned/actual times, op',
    `member_id` BIGINT COMMENT 'Reference to the ground crew or team assigned to perform this turnaround task.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Individual tasks (fueling, catering, pushback) are the specific activity during which safety occurrences happen. Task-level occurrence linking supports detailed root cause analysis and task-specific s',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Individual turnaround tasks (fueling, catering, cleaning, etc.) occur at specific airport stations. The turnaround_task table currently has airport_code as a STRING denormalized attribute, but no FK t',
    `turnaround_id` BIGINT COMMENT 'Reference to the parent turnaround event that this task belongs to. Links this task to the overall aircraft turnaround operation.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when the ground servicing task was completed. Used for SLA compliance measurement and operational efficiency analysis.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when the ground servicing task commenced. Used for performance measurement and delay analysis.',
    `completion_notes` STRING COMMENT 'Free-text notes or comments recorded by the service provider upon task completion, including any exceptions, observations, or special circumstances.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred for this ground servicing task, including labor, equipment, and materials. Used for turnaround cost analysis and vendor billing.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this turnaround task record was first created in the system. Used for audit trail and data lineage.',
    `delay_duration_minutes` STRING COMMENT 'Duration of task delay in minutes, calculated as the difference between planned and actual completion times. Used for SLA compliance measurement.',
    `delay_reason_code` STRING COMMENT 'Standardized IATA delay code indicating the reason for any task delay or late completion. Used for root cause analysis and performance improvement. [ENUM-REF-CANDIDATE: promote to reference product for full IATA delay code taxonomy]',
    `gate_stand_position` STRING COMMENT 'Specific gate or stand position identifier where the aircraft is parked and this task is being performed.',
    `gse_defect_description` STRING COMMENT 'Textual description of any GSE defect, malfunction, or maintenance issue observed during task execution. Populated when defect flag is true.',
    `gse_defect_noted_flag` BOOLEAN COMMENT 'Boolean indicator whether any equipment defect or malfunction was noted during this task. Triggers maintenance follow-up.',
    `gse_deployment_end_time` TIMESTAMP COMMENT 'Timestamp when the GSE asset was released from this task and became available for other operations. Used for GSE utilization optimization.',
    `gse_deployment_start_time` TIMESTAMP COMMENT 'Timestamp when the GSE asset was deployed and positioned for this task. Used for GSE utilization tracking and availability management.',
    `gse_fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Volume of fuel consumed by the GSE asset during this task deployment, measured in liters. Used for environmental reporting and cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this turnaround task record was last updated. Used for audit trail and change tracking.',
    `planned_end_time` TIMESTAMP COMMENT 'Scheduled timestamp when the ground servicing task is planned to be completed, based on standard service times and turnaround requirements.',
    `planned_start_time` TIMESTAMP COMMENT 'Scheduled timestamp when the ground servicing task is planned to begin, based on the turnaround schedule and task dependencies.',
    `priority_level` STRING COMMENT 'Priority classification of the task indicating urgency and importance for turnaround completion. Critical tasks are mandatory for flight departure.. Valid values are `CRITICAL|HIGH|NORMAL|LOW`',
    `quality_check_performed_flag` BOOLEAN COMMENT 'Boolean indicator whether a quality inspection or verification check was performed for this task. Used for quality assurance and safety compliance.',
    `quality_check_result` STRING COMMENT 'Result of the quality inspection or verification check, if performed. Used for quality assurance tracking and corrective action triggering.. Valid values are `PASS|FAIL|CONDITIONAL|NOT_PERFORMED`',
    `quantity_delivered` DECIMAL(18,2) COMMENT 'Numeric quantity of service delivered or resource provided during this task (e.g., liters of fuel, kilograms of cargo, number of meals, gallons of water). Unit depends on task type.',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean indicator whether any safety incident, near-miss, or hazard was reported during this task execution. Triggers safety investigation and SMS reporting.',
    `sequence_order` STRING COMMENT 'Numeric order indicating the planned sequence of this task within the turnaround event. Used to coordinate dependencies and parallel operations during aircraft servicing.',
    `service_provider_code` STRING COMMENT 'Code identifying the ground handling service provider or vendor responsible for executing this task. May be airline self-handling or third-party handler.',
    `service_provider_name` STRING COMMENT 'Full name of the ground handling service provider or vendor responsible for this task.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether the task was completed within the SLA target duration. Used for service provider performance measurement.',
    `sla_target_duration_minutes` STRING COMMENT 'Contractual service level agreement target duration for this task type, measured in minutes. Used for performance benchmarking and vendor compliance.',
    `task_description` STRING COMMENT 'Detailed textual description of the specific ground servicing task, including any special instructions, requirements, or notes for the service provider.',
    `task_status` STRING COMMENT 'Current lifecycle status of the turnaround task. Tracks progression from pending assignment through completion or cancellation. [ENUM-REF-CANDIDATE: PENDING|ASSIGNED|IN_PROGRESS|COMPLETE|SKIPPED|CANCELLED|FAILED — 7 candidates stripped; promote to reference product]',
    `task_type_code` STRING COMMENT 'Code representing the type of ground servicing task being performed. Examples include fueling, catering, cleaning, water service, lavatory service, de-icing, cargo loading/unloading, passenger boarding/deplaning, pushback, ground power unit (GPU), air start unit (ASU), potable water, waste removal, cabin preparation, security check, or pre-flight inspection. [ENUM-REF-CANDIDATE: FUEL|CATER|CLEAN|WATER|LAV|DEICE|CARGO_LOAD|CARGO_UNLOAD|PAX_BOARD|PAX_DEPLANE|PUSHBACK|GPU|ASU|POTABLE|WASTE|CABIN_PREP|SECURITY|INSPECTION — 18 candidates stripped; promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity delivered field. Varies by task type (e.g., liters for fuel, kilograms for cargo, units for catering). [ENUM-REF-CANDIDATE: LITERS|KILOGRAMS|GALLONS|UNITS|MEALS|PASSENGERS|BAGS — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_turnaround_task PRIMARY KEY(`turnaround_task_id`)
) COMMENT 'Individual ground servicing task within a turnaround event, including GSE deployment details. Captures task type (fueling, catering, cleaning, water service, lavatory service, de-icing, cargo loading, PAX boarding, pushback), planned and actual start/end times, responsible service provider, task status (pending/in-progress/complete/skipped), delay reason code, sequence order, assigned GSE asset(s), GSE operator, GSE deployment start/end times, fuel consumed by GSE, and any equipment defect noted. Enables milestone tracking, SLA compliance measurement, and GSE utilization optimization for each turnaround service element.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`slot` (
    `slot_id` BIGINT COMMENT 'Unique identifier for the airport slot record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Slot compliance monitoring (noise chapter restrictions, wake turbulence separation), coordinator reporting, and slot utilization analysis by aircraft type require aircraft_type linkage. Regulatory com',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Slot allocation and coordination decisions require workforce employee accountability for regulatory compliance, airline negotiations, and slot pool management. Critical for slot-coordinated airports.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Slot coordination costs (fees, administrative overhead) are allocated to network planning cost centers for route profitability analysis and slot portfolio valuation. Required for network planning ROI ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: slot is allocated at a specific airport/station. Currently stores airport_icao_code (STRING). FK to station provides access to station name, time zone, slot coordinator, CDM capability, and operationa',
    `actual_flight_reference` STRING COMMENT 'Reference to the actual flight that operated using this slot, typically the flight leg identifier or operational flight number. Used for post-operation reconciliation and compliance tracking. Null if slot was not used.',
    `actual_operation_date` DATE COMMENT 'The specific date on which this slot was actually used for a flight operation. Populated post-operation for utilization tracking. Null if not yet operated or if slot was not used.',
    `actual_operation_time` TIMESTAMP COMMENT 'The actual timestamp when the flight operation occurred (actual takeoff time for departure slots, actual landing time for arrival slots). Used to calculate variance from allocated time. Null if not yet operated.',
    `airline_designator` STRING COMMENT 'Two or three-character IATA airline code of the carrier to whom this slot is allocated (e.g., BA, AA, LH).. Valid values are `^[A-Z0-9]{2,3}$`',
    `allocated_time` TIMESTAMP COMMENT 'The specific date and time allocated for this slot operation (takeoff or landing). This is the coordinated time assigned by the slot coordinator.',
    `allocation_date` DATE COMMENT 'Date when this slot was initially allocated to the airline by the slot coordinator.',
    `cdm_message_reference` STRING COMMENT 'Reference identifier for Airport Collaborative Decision Making (A-CDM) messages related to this slot, used for real-time coordination between airline, airport, ATC, and ground handlers. Aligns with SITA Airport Management Platform.',
    `compliance_status` STRING COMMENT 'Indicates whether the slot was used in compliance with allocation: used (operated within tolerance), missed (not operated without valid reason), cancelled (airline cancelled in advance), swapped (exchanged with another slot), not_yet_operated (future slot).. Valid values are `used|missed|cancelled|swapped|not_yet_operated`',
    `confirmation_date` DATE COMMENT 'Date when the airline confirmed intention to use this slot. Null if not yet confirmed.',
    `coordinator_reference` STRING COMMENT 'Reference number or identifier assigned by the airport slot coordinator (e.g., Airport Coordination Limited, Flughafen-Koordinierung Deutschland) for tracking and correspondence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot record was first created in the system. Used for audit trail and data lineage.',
    `flight_number` STRING COMMENT 'Planned flight number for this slot operation, combining airline designator and numeric identifier (e.g., BA123, LH456). May be null for slots not yet assigned to specific flights.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `historic_precedence_flag` BOOLEAN COMMENT 'Indicates whether this slot carries historic precedence (grandfather rights) under IATA 80/20 rule, meaning the airline used the slot at least 80% of the time in the previous equivalent season and has priority for renewal.',
    `iata_season` STRING COMMENT 'IATA scheduling season for which this slot is allocated, in format S## (summer) or W## (winter), e.g., S23, W23. IATA seasons run summer (last Sunday March to last Saturday October) and winter (last Sunday October to last Saturday March).. Valid values are `^(S|W)[0-9]{2}$`',
    `justification_category` STRING COMMENT 'Categorized reason for non-compliance or slot misuse. Weather: meteorological conditions; ATC delay: air traffic control restrictions; Technical: aircraft maintenance or defect; Operational: crew, ground handling, or airport issues; Commercial: passenger or cargo demand changes; Other: miscellaneous.. Valid values are `weather|atc_delay|technical|operational|commercial|other`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this slot record was last updated. Used for audit trail and change tracking.',
    `non_compliance_reason` STRING COMMENT 'Free-text explanation for why a slot was missed or operated outside tolerance. May reference weather, Air Traffic Control (ATC) delays, technical issues, or other justifiable causes. Used for regulatory reporting and historic precedence calculations.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or operational notes related to this slot allocation. May include coordinator instructions, special handling requirements, or historical context.',
    `pool_category` STRING COMMENT 'Classification of the slot pool from which this slot was allocated. New entrant: reserved for new carriers; Domestic: domestic operations; International: international operations; General: unrestricted pool. Used for regulatory compliance and fair competition monitoring.. Valid values are `new_entrant|domestic|international|general`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this slot record must be included in regulatory compliance reports to aviation authorities (e.g., for 80/20 rule enforcement, slot pool management, or competition monitoring). True if reporting required.',
    `series` STRING COMMENT 'Indicates whether this is a regular series slot (recurring throughout the season) or an ad-hoc slot (one-time or irregular operation).. Valid values are `regular|ad_hoc`',
    `series_identifier` STRING COMMENT 'Unique identifier linking this slot to a series of recurring slots. Populated for regular series slots; null for ad-hoc slots.',
    `service_type` STRING COMMENT 'Type of flight service this slot is allocated for: passenger (revenue passenger service), cargo (freight service), ferry (non-revenue aircraft repositioning with no payload), positioning (deadhead crew or aircraft movement).. Valid values are `passenger|cargo|ferry|positioning`',
    `slot_status` STRING COMMENT 'Current lifecycle status of the slot allocation. Allocated: initially assigned; Confirmed: airline confirmed usage; Returned: handed back to coordinator; Swapped: exchanged with another carrier; Cancelled: withdrawn; Suspended: temporarily inactive.. Valid values are `allocated|confirmed|returned|swapped|cancelled|suspended`',
    `slot_type` STRING COMMENT 'Indicates whether this slot is for an arrival or departure operation at the airport.. Valid values are `arrival|departure`',
    `swap_date` DATE COMMENT 'Date when the slot swap transaction was executed and recorded with the slot coordinator. Null if no swap occurred.',
    `swap_partner_airline` STRING COMMENT 'IATA airline code of the carrier with whom this slot was swapped, if applicable. Null if no swap occurred.. Valid values are `^[A-Z0-9]{2,3}$`',
    `terminal_identifier` STRING COMMENT 'Airport terminal designation where this slot operation is planned (e.g., T1, T5, Terminal A). May be null if not yet assigned.',
    `time_variance_minutes` STRING COMMENT 'Difference in minutes between allocated slot time and actual operation time. Positive values indicate late operation, negative values indicate early operation. Used for compliance monitoring against tolerance thresholds (typically +/- 5 or 15 minutes depending on airport rules).',
    CONSTRAINT pk_slot PRIMARY KEY(`slot_id`)
) COMMENT 'Airport slot record representing an allocated takeoff or landing time at a capacity-constrained airport, including utilization tracking. Captures IATA season, slot type (arrival/departure), allocated time, slot coordinator reference, airport ICAO code, airline designator, aircraft type, slot series (regular/ad-hoc), slot status (allocated/confirmed/returned/swapped), historic slot precedence flag, and per-operating-date utilization data including actual flight reference, compliance status (used/missed/cancelled/swapped), variance in minutes, reason for non-compliance, and regulatory reporting flag. Aligns with IATA Worldwide Slot Guidelines (WSG) and supports slot compliance monitoring and slot pool management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`slot_utilization` (
    `slot_utilization_id` BIGINT COMMENT 'Unique identifier for the slot utilization transaction record.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight operation that utilized this slot.',
    `slot_id` BIGINT COMMENT 'Reference to the allocated airport slot being utilized.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Slot utilization records track actual use of allocated slots at specific airport stations. The slot_utilization table currently has airport_code as a STRING denormalized attribute, but no FK to statio',
    `actual_arrival_time` TIMESTAMP COMMENT 'The actual on-block or landing time recorded for the flight operation.',
    `actual_departure_time` TIMESTAMP COMMENT 'The actual off-block or takeoff time recorded for the flight operation.',
    `arrival_variance_minutes` STRING COMMENT 'The difference in minutes between planned and actual arrival time, calculated as actual minus planned. Positive values indicate delay, negative values indicate early arrival.',
    `cdm_message_timestamp` TIMESTAMP COMMENT 'Timestamp of the Airport CDM message that confirmed the actual slot utilization, typically sourced from SITA Airport Management Platform or equivalent CDM system.',
    `compliance_status` STRING COMMENT 'Current compliance state of the slot utilization indicating whether the slot was used as allocated, missed, cancelled, swapped with another carrier, returned to the pool, or forfeited due to non-compliance.. Valid values are `used|missed|cancelled|swapped|returned|forfeited`',
    `departure_variance_minutes` STRING COMMENT 'The difference in minutes between planned and actual departure time, calculated as actual minus planned. Positive values indicate delay, negative values indicate early departure.',
    `historic_rights_protected_flag` BOOLEAN COMMENT 'Indicator of whether this slot utilization contributes to the airlines historic rights (grandfather rights) for future season slot allocation under the 80/20 use-it-or-lose-it rule.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this slot utilization record, reflecting corrections or status changes.',
    `non_compliance_reason_code` STRING COMMENT 'Standardized code indicating the reason for slot non-compliance or variance, such as weather delay, technical issue, air traffic control restriction, or operational irregularity.. Valid values are `^[A-Z0-9]{2,10}$`',
    `non_compliance_reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances that led to slot non-compliance or significant variance from the allocated time.',
    `operated_date` DATE COMMENT 'The calendar date on which the slot was actually utilized by the flight operation.',
    `planned_arrival_time` TIMESTAMP COMMENT 'The scheduled arrival time as allocated in the original slot assignment.',
    `planned_departure_time` TIMESTAMP COMMENT 'The scheduled departure time as allocated in the original slot assignment.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicator of whether this slot utilization event must be reported to the slot coordinator or aviation authority for compliance monitoring and slot return obligation assessment.',
    `season_code` STRING COMMENT 'IATA scheduling season identifier (e.g., S23 for Summer 2023, W23 for Winter 2023/24) during which the slot was allocated and utilized.. Valid values are `^(S|W)[0-9]{2}$`',
    `slot_coordinator_code` STRING COMMENT 'Three-letter IATA airport code identifying the slot coordination authority responsible for this slot allocation.. Valid values are `^[A-Z]{3}$`',
    `slot_reference_number` STRING COMMENT 'External business identifier for the slot allocation as issued by the slot coordinator.. Valid values are `^[A-Z0-9]{8,20}$`',
    `slot_series_indicator` STRING COMMENT 'Classification indicating whether this slot utilization is part of a recurring series allocation or an ad-hoc one-time slot request.. Valid values are `ad_hoc|series`',
    `swap_transaction_reference` BIGINT COMMENT 'Reference to the slot swap transaction record if this slot utilization resulted from a slot exchange agreement between carriers.',
    `utilization_recorded_timestamp` TIMESTAMP COMMENT 'System timestamp when this slot utilization record was first captured in the airport operations system.',
    CONSTRAINT pk_slot_utilization PRIMARY KEY(`slot_utilization_id`)
) COMMENT 'Transactional record tracking actual use of an allocated slot against its planned parameters. Captures slot reference, associated flight, operated date, planned vs actual departure/arrival time, slot compliance status (used/missed/cancelled/swapped), variance in minutes, reason for non-compliance, and regulatory reporting flag for slot return obligations. Supports IATA slot compliance monitoring and slot pool management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`cdm_message` (
    `cdm_message_id` BIGINT COMMENT 'Unique identifier for the CDM message record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Airport Collaborative Decision Making (A-CDM) requires accurate aircraft tracking for TOBT calculation, turnaround monitoring, and departure sequencing. Critical for slot compliance and on-time perfor',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight associated with this CDM message.',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: cdm_message references a specific gate/stand position. Currently stores stand_gate_number (STRING). FK to gate_assignment provides precise gate allocation details, timing, and status. The stand_gate_n',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: CDM (Collaborative Decision Making) messages are exchanged between airline, airport, ATC, and ground handlers at specific airport stations. The cdm_message table currently has airport_icao_code as a S',
    `aobt` TIMESTAMP COMMENT 'Actual time when the aircraft commenced pushback or taxi from the gate. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `atot` TIMESTAMP COMMENT 'Actual time when the aircraft became airborne. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cobt` TIMESTAMP COMMENT 'Coordinated off-block time agreed upon by all CDM stakeholders (airline, airport, ATC, ground handler). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `correlation_reference` STRING COMMENT 'Unique identifier used to correlate related CDM messages across multiple systems and message types for the same flight operation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CDM message record was first created in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ctot` TIMESTAMP COMMENT 'Calculated take-off time assigned by the central flow management unit (e.g., EUROCONTROL Network Manager) for slot-controlled flights. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delay_code` STRING COMMENT 'IATA standard delay code associated with the flight at the time of the CDM message (e.g., 11-Aircraft defect, 81-Weather).',
    `eobt` TIMESTAMP COMMENT 'Estimated time when the aircraft will commence pushback or taxi, as estimated by the airline. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `flight_number` STRING COMMENT 'Airline flight number associated with this CDM message (e.g., AA100, BA2036).',
    `is_slot_constrained` BOOLEAN COMMENT 'Indicates whether the flight is subject to slot constraints and requires CTOT coordination.',
    `message_priority` STRING COMMENT 'Priority level assigned to the CDM message for processing and routing purposes.. Valid values are `low|normal|high|urgent`',
    `message_timestamp` TIMESTAMP COMMENT 'Date and time when the CDM message was created and transmitted. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `message_type` STRING COMMENT 'Type of CDM message: TOBT (Target Off-Block Time), TSAT (Target Start-Up Approval Time), TTOT (Target Take-Off Time), AOBT (Actual Off-Block Time), ATOT (Actual Take-Off Time), CTOT (Calculated Take-Off Time), DPI (Departure Planning Information), SRM (Slot Revision Message), EOBT (Estimated Off-Block Time), COBT (Coordinated Off-Block Time). [ENUM-REF-CANDIDATE: TOBT|TSAT|TTOT|AOBT|ATOT|CTOT|DPI|SRM|EOBT|COBT — 10 candidates stripped; promote to reference product]',
    `message_version` STRING COMMENT 'Version number of the CDM message format or protocol used (e.g., CDM 1.0, CDM 2.0).',
    `originating_system` STRING COMMENT 'Name or identifier of the system that generated the CDM message (e.g., airline operations system, airport management platform, ATC system, ground handler system).',
    `processing_status` STRING COMMENT 'Current processing status of the CDM message: received (message received by target system), validated (message passed validation checks), processed (message successfully processed and applied), rejected (message rejected due to validation errors), failed (message processing failed due to system error).. Valid values are `received|validated|processed|rejected|failed`',
    `receiver_organization` STRING COMMENT 'Name or code of the organization intended to receive the CDM message.',
    `rejection_reason` STRING COMMENT 'Detailed reason why the CDM message was rejected or failed processing, including error codes and descriptions.',
    `scheduled_date` DATE COMMENT 'Scheduled date of the flight operation. Format: yyyy-MM-dd.',
    `sender_organization` STRING COMMENT 'Name or code of the organization that sent the CDM message (airline, airport authority, ATC, ground handler).',
    `sequence_number` STRING COMMENT 'Sequential number of the CDM message within a series of messages for the same flight, used to track message order and detect duplicates.',
    `target_system` STRING COMMENT 'Name or identifier of the system intended to receive and process the CDM message.',
    `tobt` TIMESTAMP COMMENT 'Target time when the aircraft is expected to commence pushback or taxi from the gate, provided by the airline. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `tsat` TIMESTAMP COMMENT 'Target time provided by ATC for the aircraft to start engines and request pushback clearance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ttot` TIMESTAMP COMMENT 'Target time when the aircraft is expected to become airborne, calculated by the CDM system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `turnaround_status` STRING COMMENT 'Current status of the aircraft turnaround operation at the time of the CDM message.. Valid values are `not_started|in_progress|completed|delayed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CDM message record was last updated in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_cdm_message PRIMARY KEY(`cdm_message_id`)
) COMMENT 'Collaborative Decision Making (CDM) message record exchanged between the airline, airport, ATC, and ground handlers. Captures message type (TOBT/TSAT/TTOT/AOBT/ATOT/CTOT/DPI/SRM), originating system, target system, flight reference, airport ICAO, message timestamp, target off-block time (TOBT), calculated take-off time (CTOT), sequence number, and processing status. Aligns with EUROCONTROL/ICAO CDM standards and SITA Airport Management Platform integration.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`gse_asset` (
    `gse_asset_id` BIGINT COMMENT 'Unique identifier for the ground support equipment asset record. Primary key for the GSE asset master.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Ground support equipment (tugs, loaders, belt loaders) is capitalized as fixed assets for depreciation accounting, asset register maintenance, and financial statement reporting. Required for IFRS/GAAP',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: GSE assets are often owned and operated by ground handling service providers. This establishes the ownership/operator relationship between GSE assets and ground handlers. The existing owning_vendor_id',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: gse_asset has a home station where it is normally based. Currently stores home_station_code (STRING). FK to station provides access to station details and ground handler. The home_station_code becomes',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Leased GSE equipment requires IFRS 16 lease accounting for right-of-use asset recognition, lease liability calculation, and financial statement reporting. Essential for lease portfolio management and ',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: GSE assets are involved in many ground safety occurrences (equipment failures, collisions, maintenance defects). Asset-level occurrence history tracking supports fleet safety analysis and maintenance ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: GSE assets are purchased or leased from vendors. Linking to vendor master enables tracking of supplier performance, warranty claims, maintenance contracts, and asset acquisition costs. Critical for fl',
    `acquisition_cost_amount` DECIMAL(18,2) COMMENT 'Original purchase or acquisition cost of the equipment in the reporting currency, used for asset valuation and depreciation calculations.',
    `acquisition_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost amount.. Valid values are `^[A-Z]{3}$`',
    `acquisition_date` DATE COMMENT 'Date on which the equipment was acquired by the owning organization, either through purchase, lease, or transfer.',
    `availability_flag` BOOLEAN COMMENT 'Boolean indicator of whether the equipment is currently available for assignment to flight turnaround operations. True indicates the asset can be scheduled; false indicates it is unavailable.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the capacity value, defining whether capacity is expressed in weight, power, volume, or passenger count.. Valid values are `KG|LBS|KVA|LITERS|GALLONS|PASSENGERS`',
    `capacity_value` DECIMAL(18,2) COMMENT 'Primary quantitative capacity specification for the equipment, such as towing capacity for tugs, power output for GPUs, or volume for fluid trucks. The principal measurement defining the equipments operational capability.',
    `certification_expiry_date` DATE COMMENT 'Date on which the current safety certification expires, requiring recertification or inspection before continued operation. Critical for compliance tracking.',
    `certification_number` STRING COMMENT 'Official certification or approval number issued by the relevant aviation authority or safety body, confirming the equipment meets operational safety standards.',
    `current_station_code` STRING COMMENT 'Three-letter IATA airport code identifying the current physical location of the equipment, which may differ from home station during temporary deployments or repositioning.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation expense for the equipment asset over its useful life.. Valid values are `STRAIGHT_LINE|DECLINING_BALANCE|UNITS_OF_PRODUCTION`',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the equipment meets current environmental standards and emissions regulations applicable at the operating stations.',
    `equipment_registration_number` STRING COMMENT 'Official registration or serial number assigned to the GSE unit by the manufacturer or regulatory authority. Serves as the external business identifier for the asset.. Valid values are `^[A-Z0-9]{6,20}$`',
    `equipment_subtype` STRING COMMENT 'Secondary classification providing additional detail on the equipment variant or model family within the primary equipment type.',
    `equipment_type_code` STRING COMMENT 'Classification code identifying the functional type of ground support equipment. Defines the primary operational role of the asset in ground handling operations. [ENUM-REF-CANDIDATE: PUSHBACK_TRACTOR|GPU|AIR_STARTER|BELT_LOADER|CATERING_TRUCK|LAVATORY_TRUCK|WATER_TRUCK|DEICING_VEHICLE|PASSENGER_BUS|BAGGAGE_TUG|ULD_LOADER — 11 candidates stripped; promote to reference product]',
    `fuel_type` STRING COMMENT 'Type of fuel or power source used by the equipment, relevant for refueling logistics, environmental reporting, and operational cost tracking.. Valid values are `DIESEL|GASOLINE|ELECTRIC|HYBRID|LPG|CNG`',
    `gps_tracking_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the equipment is equipped with GPS tracking technology for real-time location monitoring and fleet management.',
    `insurance_expiry_date` DATE COMMENT 'Date on which the current insurance policy expires, requiring renewal to maintain coverage.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the insurance coverage protecting the equipment asset against damage, theft, or liability.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled or unscheduled maintenance activity performed on the equipment.',
    `maintenance_status` STRING COMMENT 'Current state of the equipments maintenance compliance, indicating whether maintenance is up to date, overdue, or actively being performed.. Valid values are `CURRENT|OVERDUE|SCHEDULED|IN_PROGRESS`',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured the ground support equipment unit.',
    `maximum_towing_weight_kg` DECIMAL(18,2) COMMENT 'Maximum aircraft weight in kilograms that the equipment can safely tow or push, applicable to pushback tractors and tugs. Critical for matching equipment to aircraft type.',
    `model_designation` STRING COMMENT 'Manufacturers model number or designation for the equipment unit, identifying the specific product line and configuration.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next required maintenance inspection or service, based on manufacturer recommendations and operational hours.',
    `operating_hours_total` DECIMAL(18,2) COMMENT 'Cumulative total operating hours logged for the equipment since commissioning, used for maintenance scheduling and lifecycle management.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the equipment indicating its availability for ground operations. Tracks whether the asset is active, under maintenance, or decommissioned.. Valid values are `IN_SERVICE|OUT_OF_SERVICE|MAINTENANCE|RETIRED|RESERVED`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this GSE asset record was first created in the system, supporting audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this GSE asset record was last modified, supporting audit trail and change tracking requirements.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or operational comments related to the equipment asset.',
    `telematics_device_code` STRING COMMENT 'Unique identifier for the telematics or IoT device installed on the equipment for remote monitoring of location, usage, and performance metrics.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the equipment in years, used for depreciation calculations and replacement planning.',
    `year_of_manufacture` STRING COMMENT 'Calendar year in which the equipment unit was manufactured, used for age tracking and depreciation calculations.',
    CONSTRAINT pk_gse_asset PRIMARY KEY(`gse_asset_id`)
) COMMENT 'Ground Support Equipment (GSE) asset master record. Captures equipment type (pushback tractor, GPU, air starter, belt loader, catering truck, lavatory truck, water truck, de-icing vehicle, passenger bus, baggage tug, ULD loader), registration/serial number, owning entity (airline/handler/airport), home station, current station, fuel type, capacity specifications, certification expiry, maintenance status, and operational availability flag. SSOT for GSE fleet managed at airline-operated stations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`gse_deployment` (
    `gse_deployment_id` BIGINT COMMENT 'Unique identifier for the GSE deployment record. Primary key.',
    `gate_assignment_id` BIGINT COMMENT 'Reference to the gate assignment where the GSE is deployed. Links to the gate assignment record.',
    `gse_asset_id` BIGINT COMMENT 'Reference to the specific GSE asset deployed (e.g., tug, belt loader, GPU). Links to the GSE asset master record.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Specific GSE deployments are operational instance during which equipment-related occurrences happen. Already has safety_incident_flag but missing occurrence FK for formal SMS integration and investiga',
    `employee_id` BIGINT COMMENT 'Reference to the ground handling employee assigned to operate the GSE during this deployment. Links to the employee master record.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: GSE deployment events occur at specific airport stations. The gse_deployment table currently has both airport_code and station_code as STRING denormalized attributes, but no FK to station. Adding stat',
    `turnaround_id` BIGINT COMMENT 'Reference to the aircraft turnaround operation this GSE deployment supports. Links to the turnaround master record.',
    `actual_deployment_end_time` TIMESTAMP COMMENT 'The actual date and time when the GSE deployment ended and the equipment was released from the task.',
    `actual_deployment_start_time` TIMESTAMP COMMENT 'The actual date and time when the GSE deployment began, captured from GSE tracking systems or operator logs.',
    `cdm_message_reference` STRING COMMENT 'Reference to the CDM message or milestone that triggered or updated this GSE deployment (e.g., TOBT, TSAT, AOBT). Supports CDM compliance and coordination.',
    `cost_allocation_code` STRING COMMENT 'The cost center or allocation code to which the GSE deployment costs (fuel, labor, depreciation) are charged. Supports financial reporting and cost recovery.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GSE deployment record was first created in the system. Supports audit trail and data lineage.',
    `defect_description` STRING COMMENT 'Free-text description of any equipment defect, malfunction, or performance issue observed during the deployment. Populated when defect_noted_flag is true.',
    `defect_noted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any equipment defect or malfunction was noted during this deployment. Triggers maintenance workflow.',
    `defect_severity` STRING COMMENT 'Severity classification of the noted defect (e.g., minor, moderate, major, critical). Determines maintenance priority and equipment availability.. Valid values are `minor|moderate|major|critical`',
    `delay_duration_minutes` STRING COMMENT 'The duration in minutes of any delay in GSE deployment or task completion, measured against planned times. Used for OTP analysis and resource planning.',
    `delay_reason` STRING COMMENT 'Free-text description of the reason for any delay in GSE deployment or task completion (e.g., equipment unavailable, operator unavailable, weather, aircraft delay).',
    `deployment_location` STRING COMMENT 'The specific physical location where the GSE was deployed (e.g., gate number, ramp position, hangar bay). Supports spatial analysis and resource optimization.',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the GSE deployment (e.g., scheduled, dispatched, in progress, completed, cancelled, delayed, equipment failure). [ENUM-REF-CANDIDATE: scheduled|dispatched|in_progress|completed|cancelled|delayed|equipment_failure — 7 candidates stripped; promote to reference product]',
    `dispatch_time` TIMESTAMP COMMENT 'The date and time when the GSE was dispatched from the equipment pool or staging area to the deployment location.',
    `electricity_consumed_kwh` DECIMAL(18,2) COMMENT 'The quantity of electricity consumed by electric GSE during this deployment, measured in kilowatt-hours. Used for cost allocation and sustainability tracking.',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'The quantity of fuel consumed by the GSE during this deployment, measured in liters. Used for cost allocation and environmental reporting.',
    `idle_duration_minutes` STRING COMMENT 'The duration in minutes that the GSE was idle or waiting during this deployment (e.g., waiting for aircraft arrival, waiting for clearance). Used for efficiency analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GSE deployment record was last updated. Supports audit trail and change tracking.',
    `operator_certification_number` STRING COMMENT 'The certification or license number of the operator assigned to this GSE deployment. Ensures compliance with training and qualification requirements.',
    `planned_deployment_end_time` TIMESTAMP COMMENT 'The scheduled date and time when the GSE deployment is planned to end, based on turnaround schedule and task duration estimates.',
    `planned_deployment_start_time` TIMESTAMP COMMENT 'The scheduled date and time when the GSE deployment is planned to begin, based on turnaround schedule and CDM messages.',
    `priority_level` STRING COMMENT 'Priority classification of the GSE deployment task (e.g., routine, high, urgent, critical). Influences dispatch sequencing and resource allocation.. Valid values are `routine|high|urgent|critical`',
    `return_time` TIMESTAMP COMMENT 'The date and time when the GSE was returned to the equipment pool or staging area after deployment completion.',
    `safety_incident_description` STRING COMMENT 'Free-text description of any safety incident, near-miss, or hazard observed during the deployment. Populated when safety_incident_flag is true.',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a safety incident or near-miss occurred during this GSE deployment. Triggers safety investigation and SMS reporting.',
    `service_provider_code` STRING COMMENT 'Code identifying the ground handling service provider responsible for this GSE deployment (e.g., airline self-handling, third-party handler). Supports vendor performance tracking.',
    `source_system` STRING COMMENT 'The name or code of the operational system that originated this GSE deployment record (e.g., SITA Airport Management Platform, ground handling system). Supports data lineage and integration troubleshooting.',
    `task_type` STRING COMMENT 'The specific ground handling task type for which the GSE is deployed (e.g., aircraft towing, baggage loading, ground power, de-icing). [ENUM-REF-CANDIDATE: aircraft_towing|baggage_loading|baggage_unloading|cargo_loading|cargo_unloading|ground_power|air_conditioning|potable_water|lavatory_service|fueling|de_icing|pushback|cabin_cleaning|catering_service|passenger_boarding|passenger_deplaning|maintenance_support — promote to reference product]',
    `utilization_duration_minutes` STRING COMMENT 'The total duration in minutes that the GSE was actively utilized during this deployment, calculated from actual start and end times. Used for utilization rate analysis.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of GSE deployment (e.g., clear, rain, snow, ice, fog). Impacts task duration, safety, and equipment performance.',
    CONSTRAINT pk_gse_deployment PRIMARY KEY(`gse_deployment_id`)
) COMMENT 'Transactional record for the deployment of a GSE asset to a specific turnaround task or gate operation. Captures GSE asset reference, turnaround or gate assignment reference, task type, assigned operator, planned and actual deployment start/end times, deployment status, fuel consumed, and any equipment defect noted during deployment. Enables GSE utilization tracking, scheduling optimization, and maintenance trigger events.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`checkin_session` (
    `checkin_session_id` BIGINT COMMENT 'Unique identifier for the passenger check-in session transaction. Primary key.',
    `checkin_counter_id` BIGINT COMMENT 'Foreign key linking to airport.checkin_counter. Business justification: checkin_session occurs at a specific check-in counter. Currently stores checkin_counter_number (STRING) and terminal_code. FK to checkin_counter provides access to counter type, capabilities (biometri',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Check-in operations (labor, equipment, counter space) are allocated to cost centers for passenger service cost tracking, station budgeting, and CASK calculation. Essential for operational expense mana',
    `employee_id` BIGINT COMMENT 'Identifier of the agent or kiosk device that processed the check-in. For counter check-in, this is the agent employee ID; for kiosk/CUSS, this is the device identifier. Nullable for web/mobile self-service.',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Sessions capture frequent_flyer_number (denormalized string); FK enables real-time loyalty recognition at checkin, tier-based service delivery, automated points posting, and member journey analytics a',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Check-in operations generate safety occurrences (medical emergencies, security incidents, accessibility failures, document fraud). Session context supports incident investigation and passenger-facing ',
    `profile_id` BIGINT COMMENT 'Reference to the passenger entity performing check-in. Links to passenger master data.',
    `scheduled_flight_id` BIGINT COMMENT 'Reference to the scheduled flight for which the passenger is checking in.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: checkin_session occurs at a specific airport/station. Currently stores airport_code (STRING). FK to station provides access to station name, time zone, operational hours, and ground handler details. T',
    `advance_checkin_flag` BOOLEAN COMMENT 'Indicates whether the passenger checked in more than 24 hours before scheduled departure (advance/online check-in). True if advance check-in.',
    `apis_data_transmitted_flag` BOOLEAN COMMENT 'Indicates whether APIS data (passport, nationality, date of birth) was transmitted to destination authorities during check-in. True if APIS transmitted.',
    `baggage_tag_numbers` STRING COMMENT 'Comma-separated list of 10-digit baggage tag numbers issued during check-in for tracked baggage pieces. Used for baggage tracing and reconciliation.',
    `bags_checked_count` STRING COMMENT 'Number of checked baggage pieces accepted during this check-in session.',
    `boarding_pass_barcode` STRING COMMENT 'Unique barcode or QR code string printed on the boarding pass. Used for boarding gate scanning. Contains PNR, flight, and passenger data encoded per IATA standards.',
    `boarding_pass_issuance_method` STRING COMMENT 'Method by which the boarding pass was delivered to the passenger. Paper = printed at counter, mobile = mobile app barcode, email = emailed PDF, SMS = SMS link, kiosk_print = printed at kiosk.. Valid values are `paper|mobile|email|sms|kiosk_print`',
    `cabin_class` STRING COMMENT 'Cabin class of the seat assigned at check-in. Reflects the service level for this flight segment.. Valid values are `first|business|premium_economy|economy`',
    `checkin_channel` STRING COMMENT 'Channel through which the passenger initiated check-in. Counter = airport counter, kiosk = self-service kiosk, CUSS = Common Use Self-Service, web = online web check-in, mobile = mobile app check-in, agent_assisted = call center or remote agent.. Valid values are `counter|kiosk|cuss|web|mobile|agent_assisted`',
    `checkin_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the check-in session was completed and boarding pass issued. Recorded in UTC.',
    `checkin_language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language used during the check-in session (e.g., en, es, fr).. Valid values are `^[a-z]{2}$`',
    `checkin_sequence_number` STRING COMMENT 'Sequential number assigned to the passenger within the flight check-in order. Used for boarding priority and operational sequencing.',
    `checkin_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the passenger initiated the check-in session. Recorded in UTC and converted to local airport time for operational reporting.',
    `checkin_status` STRING COMMENT 'Current status of the check-in session. Completed = boarding pass issued, incomplete = session started but not finished, cancelled = passenger cancelled check-in, no_show = passenger did not complete check-in and did not board.. Valid values are `completed|incomplete|cancelled|no_show`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this check-in session record was first created in the system. Audit field for data lineage.',
    `excess_baggage_charge_amount` DECIMAL(18,2) COMMENT 'Total excess baggage charge collected at check-in, in the transaction currency. Null if no excess baggage.',
    `excess_baggage_charge_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the excess baggage charge.. Valid values are `^[A-Z]{3}$`',
    `excess_baggage_flag` BOOLEAN COMMENT 'Indicates whether the passenger checked excess baggage beyond the standard allowance. True if excess baggage charges apply.',
    `group_checkin_flag` BOOLEAN COMMENT 'Indicates whether this check-in is part of a group booking check-in. True if group check-in.',
    `infant_accompanying_flag` BOOLEAN COMMENT 'Indicates whether the passenger is traveling with an infant (under 2 years) on lap. True if infant accompanying.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this check-in session record was last updated. Audit field for change tracking.',
    `pnr_reference` STRING COMMENT 'Six-character alphanumeric reference to the Passenger Name Record in the reservation system. Links check-in to the booking.. Valid values are `^[A-Z0-9]{6}$`',
    `priority_boarding_flag` BOOLEAN COMMENT 'Indicates whether the passenger is eligible for priority boarding based on fare class, loyalty status, or purchased upgrade. True if priority boarding granted.',
    `seat_assigned` STRING COMMENT 'Seat number assigned to the passenger during check-in (e.g., 12A, 34F). Format: row number followed by seat letter.. Valid values are `^[0-9]{1,3}[A-K]$`',
    `special_service_requests` STRING COMMENT 'Comma-separated list of SSR codes processed or confirmed during check-in (e.g., WCHR, VGML, PETC). Reflects special assistance, meal preferences, or service requests.',
    `standby_status` STRING COMMENT 'Indicates whether the passenger is confirmed, on standby, or waitlisted at check-in. Confirmed = seat guaranteed, standby = awaiting seat assignment, waitlisted = not yet cleared.. Valid values are `confirmed|standby|waitlisted`',
    `travel_document_verified_flag` BOOLEAN COMMENT 'Indicates whether the passengers travel documents (passport, visa) were verified during check-in. True if documents verified.',
    `upgrade_processed_flag` BOOLEAN COMMENT 'Indicates whether a cabin upgrade (e.g., economy to business) was processed during check-in. True if upgrade applied.',
    CONSTRAINT pk_checkin_session PRIMARY KEY(`checkin_session_id`)
) COMMENT 'Transactional record representing a passenger check-in interaction at an airport station. Captures PNR reference, passenger reference, flight reference, check-in channel (counter/kiosk/CUSS/web-drop), check-in agent or kiosk identifier, check-in start and end timestamps, seat assigned at check-in, number of bags checked, excess baggage flag, SSR (Special Service Request) items processed, boarding pass issuance method, and check-in status. Supports OTP, passenger flow, and ground operations analytics.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`boarding_event` (
    `boarding_event_id` BIGINT COMMENT 'Unique identifier for the boarding event record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the gate agent who processed the boarding event, if manually processed.',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Events capture frequent_flyer_number and tier (denormalized strings); FK enables real-time boarding analytics by tier, priority boarding enforcement validation, operational loyalty metrics, and member',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg for which this boarding event occurred.',
    `gate_assignment_id` BIGINT COMMENT 'Reference to the gate assignment where boarding took place.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Boarding is high-volume passenger interaction phase with safety risks (crowd control failures, accessibility incidents, security breaches). Scan-level traceability supports detailed investigation of p',
    `profile_id` BIGINT COMMENT 'Reference to the passenger who boarded or attempted to board.',
    `boarding_action_taken` STRING COMMENT 'Description of any special action taken during boarding such as offload, reaccommodation, security hold, or manual verification.',
    `boarding_door_used` STRING COMMENT 'Identifier of the aircraft door or boarding method used (jetbridge door, remote stairs, bus gate).. Valid values are `^(door_[1-9]|jetbridge|remote_stairs|bus_gate)$`',
    `boarding_method` STRING COMMENT 'Method by which the boarding event was captured: automated gate reader, agent-assisted scan, manual entry, mobile device scan, or biometric verification.. Valid values are `automated_gate|agent_scan|manual_entry|mobile_scan|biometric`',
    `boarding_pass_barcode` STRING COMMENT 'Barcode or QR code scanned from the passenger boarding pass (BCBP format).',
    `boarding_sequence_number` STRING COMMENT 'Sequential order in which the passenger boarded the aircraft relative to other passengers on the same flight.',
    `boarding_zone` STRING COMMENT 'Designated boarding zone or group assigned to the passenger for orderly boarding process.. Valid values are `^(zone_[1-9]|priority|general|first_class|business|premium_economy|economy)$`',
    `cabin_class` STRING COMMENT 'Cabin class in which the passenger is seated for this flight leg.. Valid values are `first|business|premium_economy|economy`',
    `carry_on_baggage_count` STRING COMMENT 'Number of carry-on baggage pieces the passenger brought to the gate.',
    `checked_baggage_count` STRING COMMENT 'Number of checked baggage pieces associated with this passenger for this flight leg.',
    `coupon_sequence_number` STRING COMMENT 'Sequential number of the flight coupon within the electronic ticket corresponding to this flight leg.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this boarding event record was first created in the system.',
    `frequent_flyer_tier` STRING COMMENT 'Current tier or status level of the passenger in the airline loyalty program.. Valid values are `basic|silver|gold|platinum|diamond`',
    `gate_reader_device_code` STRING COMMENT 'Identifier of the automated gate reader or kiosk device that captured the boarding scan.',
    `irregular_operation_flag` BOOLEAN COMMENT 'Indicates whether this boarding event occurred during an irregular operation scenario such as delay, cancellation recovery, or diversion.',
    `irregular_operation_reason` STRING COMMENT 'Description of the irregular operation circumstance if irregular_operation_flag is true.',
    `is_codeshare_passenger` BOOLEAN COMMENT 'Indicates whether the passenger booked through a codeshare partner airline.',
    `is_interline_passenger` BOOLEAN COMMENT 'Indicates whether the passenger is traveling on an interline itinerary involving multiple carriers.',
    `is_standby_passenger` BOOLEAN COMMENT 'Indicates whether the passenger was on standby status and cleared for boarding.',
    `is_upgrade_passenger` BOOLEAN COMMENT 'Indicates whether the passenger received a cabin class upgrade for this flight.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this boarding event record was last updated or modified.',
    `marketing_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier under which the ticket was sold (may differ from operating carrier in codeshare scenarios).. Valid values are `^[A-Z0-9]{2}$`',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier operating the flight.. Valid values are `^[A-Z0-9]{2}$`',
    `passenger_type_code` STRING COMMENT 'IATA passenger type code indicating category such as adult, child, infant, military, senior, student, or youth. [ENUM-REF-CANDIDATE: ADT|CHD|INF|MIL|SRC|STU|YTH — 7 candidates stripped; promote to reference product]',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record locator code associated with the booking.. Valid values are `^[A-Z0-9]{6}$`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for boarding rejection if scan_result_status is rejected.. Valid values are `^[A-Z0-9]{2,6}$`',
    `rejection_reason_description` STRING COMMENT 'Human-readable description of why the boarding was rejected or flagged.',
    `scan_result_status` STRING COMMENT 'Outcome of the boarding pass scan indicating whether the passenger was accepted for boarding, rejected, flagged as duplicate scan, offloaded, or other status.. Valid values are `accepted|rejected|duplicate|offload|gate_no_show|standby_cleared`',
    `scan_timestamp` TIMESTAMP COMMENT 'Precise date and time when the boarding pass was scanned at the gate.',
    `seat_number` STRING COMMENT 'Assigned seat number for the passenger on this flight (row and seat letter).. Valid values are `^[0-9]{1,3}[A-K]$`',
    `security_screening_status` STRING COMMENT 'Status of passenger security screening at the time of boarding.. Valid values are `cleared|pending|flagged|secondary_screening`',
    `special_service_request_codes` STRING COMMENT 'Comma-separated list of SSR codes associated with the passenger for this boarding event (e.g., WCHR, UMNR, PETC).',
    `ticket_number` STRING COMMENT 'Thirteen-digit electronic ticket number issued to the passenger.. Valid values are `^[0-9]{13}$`',
    CONSTRAINT pk_boarding_event PRIMARY KEY(`boarding_event_id`)
) COMMENT 'Transactional record capturing each passenger boarding scan event at the gate. Captures flight reference, gate assignment reference, passenger reference, PNR, boarding pass barcode, scan timestamp, boarding sequence number, boarding zone, scan result (accepted/rejected/duplicate/offload), agent or automated gate reader identifier, and any irregular boarding action taken. Enables final PAX count reconciliation, no-show tracking, and security compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`baggage_item` (
    `baggage_item_id` BIGINT COMMENT 'Unique system identifier for the individual checked baggage item. Primary key. Serves as the single source of truth for baggage identity within the airport domain.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: baggage_item is accepted at a specific station. Currently stores acceptance_station_code (STRING). FK to station provides access to station details, time zone, and operational context. The acceptance_',
    `flight_leg_id` BIGINT COMMENT 'Reference to the primary flight leg on which this baggage item is checked. Links to the flight operations domain for routing and tracking.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger who owns this baggage item. Links to the passenger master record in the Passenger domain.',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the baggage item was accepted at check-in. Marks the start of airline custody and liability. Critical for baggage tracking and service level monitoring.',
    `bag_tag_number` STRING COMMENT 'IATA standard 10-digit bag tag number printed on the baggage label. Globally unique identifier used for tracking and tracing throughout the baggage journey.. Valid values are `^[0-9]{10}$`',
    `bag_type` STRING COMMENT 'Classification of the baggage item based on size, content, or special handling requirements. Determines handling procedures, storage location, and applicable charges. [ENUM-REF-CANDIDATE: standard|oversized|fragile|sports_equipment|musical_instrument|live_animal|diplomatic|medical|wheelchair|infant_equipment — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this baggage item record was first created in the database. Used for data lineage and audit trail.',
    `current_location_station_code` STRING COMMENT 'Three-letter IATA airport code of the current physical location of the baggage item. Updated at each scan point throughout the journey.. Valid values are `^[A-Z]{3}$`',
    `current_status` STRING COMMENT 'Current lifecycle status of the baggage item in the handling process. Reflects the latest state in the baggage journey from acceptance through delivery. [ENUM-REF-CANDIDATE: accepted|loaded|in_transit|arrived|delivered|mishandled|delayed|damaged|lost — 9 candidates stripped; promote to reference product]',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value declared by the passenger for the contents of the baggage item. Used for excess valuation coverage and liability determination in case of loss or damage.',
    `declared_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared value amount. Supports multi-currency operations across international route networks.. Valid values are `^[A-Z]{3}$`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the baggage item was delivered to the passenger or authorized recipient at the final destination. Marks the end of airline custody and liability.',
    `excess_baggage_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge amount collected for this baggage item if it exceeds the free baggage allowance. Null if no excess charge applies.',
    `excess_baggage_charge_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the excess baggage charge amount. Null if no excess charge applies.. Valid values are `^[A-Z]{3}$`',
    `final_destination_station_code` STRING COMMENT 'Three-letter IATA airport code of the final destination where the baggage item should be delivered to the passenger. End point for baggage routing.. Valid values are `^[A-Z]{3}$`',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the baggage item in centimeters. Used for oversized baggage determination and ULD planning.',
    `interline_indicator` BOOLEAN COMMENT 'Flag indicating whether this baggage item involves interline transfer between different carriers. True if the routing includes flights operated by partner airlines.',
    `last_scan_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent scan event for this baggage item. Used for real-time tracking and service level monitoring.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this baggage item record was most recently modified. Used for change tracking and data synchronization.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the baggage item in centimeters. Used for oversized baggage determination and ULD (Unit Load Device) planning.',
    `mishandling_code` STRING COMMENT 'Classification of baggage mishandling incident if applicable. Used for service recovery, compensation determination, and quality metrics reporting.. Valid values are `none|delayed|damaged|pilfered|lost|destroyed`',
    `mishandling_report_number` STRING COMMENT 'Unique identifier of the Property Irregularity Report (PIR) or baggage claim filed for this item if mishandled. Links to the baggage claims system.',
    `pnr` STRING COMMENT 'Six-character alphanumeric Passenger Name Record identifier linking this baggage item to the booking. Used for reservation system integration and passenger association.. Valid values are `^[A-Z0-9]{6}$`',
    `priority_handling_code` STRING COMMENT 'Special handling priority assigned to the baggage item. Determines expedited processing for tight connections, premium passengers, or operational requirements.. Valid values are `none|rush|priority|vip|crew|transfer`',
    `routing_sequence` STRING COMMENT 'Planned routing path for the baggage item through connecting stations. Formatted as a sequence of IATA airport codes representing the complete journey.',
    `security_screening_status` STRING COMMENT 'Result of security screening process for this baggage item. Indicates whether the bag has been cleared for loading or requires additional inspection.. Valid values are `not_screened|cleared|flagged|manual_inspection|rejected`',
    `security_screening_timestamp` TIMESTAMP COMMENT 'Date and time when security screening was completed for this baggage item. Required for regulatory compliance and audit trail.',
    `special_service_request_codes` STRING COMMENT 'Comma-separated list of IATA SSR codes indicating special handling requirements for this baggage item (e.g., FRAG for fragile, BIKE for bicycle, PETC for pet in cabin).',
    `uld_number` STRING COMMENT 'Identifier of the Unit Load Device (container or pallet) in which this baggage item is loaded for transport. Null if loaded as bulk baggage.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Actual weight of the baggage item measured in kilograms at acceptance. Used for load planning, excess baggage charge calculation, and regulatory compliance.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the baggage item in centimeters. Used for oversized baggage determination and ULD planning.',
    CONSTRAINT pk_baggage_item PRIMARY KEY(`baggage_item_id`)
) COMMENT 'Master record for an individual checked baggage item from acceptance through delivery. Captures IATA 10-digit bag tag number, PNR reference, passenger reference, flight routing, bag type (standard/oversized/fragile/sports/live-animal), weight, dimensions, declared value, acceptance station, acceptance timestamp, final destination station, current location status, and last scan event reference. SSOT for baggage identity and routing within the airport domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`baggage_scan` (
    `baggage_scan_id` BIGINT COMMENT 'Unique identifier for each baggage scan event in the baggage handling system. Primary key for the baggage scan transaction record.',
    `baggage_item_id` BIGINT COMMENT 'Reference to the master baggage item record representing the physical piece of luggage being tracked through the handling system.',
    `employee_id` BIGINT COMMENT 'Identifier of the ground handling agent or airline staff member who performed manual intervention or verification during the scan event. Used for accountability and training.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the scheduled or operational flight associated with this baggage scan event. Links the bag movement to the specific flight leg.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Each baggage scan event occurs at a specific airport station. The baggage_scan table currently has scan_location_code as a STRING denormalized attribute, but no FK to station. Adding station_id normal',
    `actual_connect_time_minutes` STRING COMMENT 'Actual elapsed time in minutes between the inbound flight arrival scan and the outbound flight departure scan for transfer baggage. Used for connection performance analysis.',
    `bag_tag_number` STRING COMMENT 'Ten-digit unique baggage tag identifier affixed to the checked baggage item. Primary tracking identifier throughout the baggage journey from acceptance to delivery.. Valid values are `^[0-9]{10}$`',
    `baggage_type` STRING COMMENT 'Classification of the baggage item based on handling requirements and passenger service level. Determines handling priority and routing logic.. Valid values are `checked|transfer|rush|priority|special|oversized`',
    `baggage_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the baggage item in kilograms as measured at check-in or during handling. Used for load planning and excess baggage charge calculation.',
    `cdm_message_type` STRING COMMENT 'Type of Airport CDM message generated by this baggage scan event for sharing with airport collaborative decision-making systems and stakeholders.',
    `conveyor_belt_code` STRING COMMENT 'Identifier of the specific conveyor belt or carousel within the baggage handling system where the scan occurred or where the bag was routed.',
    `customs_status` STRING COMMENT 'Customs clearance status for international baggage items indicating whether the bag has been cleared for entry or requires inspection by customs authorities.. Valid values are `cleared|inspection_required|hold|released`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA code of the final destination airport for the baggage item as determined from the bag tag and flight routing information.. Valid values are `^[A-Z]{3}$`',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this scan event represents an irregular or exception condition requiring manual intervention or investigation.',
    `exception_reason_code` STRING COMMENT 'Standardized code describing the nature of the baggage handling exception such as misrouted, delayed, damaged, or security hold. Populated only when exception_flag is true.',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight associated with the baggage scan. Used for flight-specific baggage reconciliation and reporting.',
    `flight_number` STRING COMMENT 'Airline designator code and numeric flight identifier for the flight associated with this baggage scan event. Denormalized for operational convenience.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}$`',
    `iata_753_compliance_flag` BOOLEAN COMMENT 'Boolean indicator confirming whether this scan event meets IATA Resolution 753 baggage tracking requirements for mandatory scan point reporting.',
    `makeup_position` STRING COMMENT 'Specific location identifier within the baggage makeup area where bags are staged for loading onto the aircraft. Used for ground crew coordination.',
    `minimum_connect_time_minutes` STRING COMMENT 'Minimum connection time in minutes required for successful baggage transfer between the inbound and outbound flights. Used to identify at-risk connections.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA code of the originating airport where the baggage item was first checked in by the passenger.. Valid values are `^[A-Z]{3}$`',
    `passenger_name` STRING COMMENT 'Full name of the passenger who checked the baggage item. Used for baggage claim verification and irregular baggage handling.',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric reservation record locator linking the baggage item to the passenger booking. Enables correlation of bag movement with passenger itinerary.. Valid values are `^[A-Z0-9]{6}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this baggage scan record was first inserted into the data platform. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this baggage scan record was last modified in the data platform. Supports change tracking and data quality monitoring.',
    `scan_data_source` STRING COMMENT 'Type of data capture device or system that generated the baggage scan record. Used for data quality assessment and system performance monitoring.. Valid values are `automated_scanner|handheld_device|manual_entry|mobile_app|kiosk`',
    `scan_device_code` STRING COMMENT 'Unique identifier of the physical scanning device or reader that captured the bag tag. Used for device performance tracking and maintenance scheduling.',
    `scan_point_type` STRING COMMENT 'Classification of the baggage handling process stage where the scan occurred. Identifies the functional area within the airport baggage system.. Valid values are `check-in|bhs_sortation|makeup_area|aircraft_hold|reclaim_belt|transfer_area`',
    `scan_result_status` STRING COMMENT 'Outcome of the baggage tag scan attempt indicating whether the tag was successfully read by the automated system or required manual intervention.. Valid values are `successful_read|no_read|manual_entry|duplicate_scan|damaged_tag`',
    `scan_sequence_number` STRING COMMENT 'Sequential order number of this scan event within the complete baggage journey for the specific bag tag. Enables chronological reconstruction of bag movement.',
    `scan_timestamp` TIMESTAMP COMMENT 'Precise date and time when the baggage scan event occurred in the baggage handling system. Represents the real-world event time of the scan operation.',
    `security_screening_status` STRING COMMENT 'Current security clearance status of the baggage item as determined by TSA or equivalent security authority screening processes.. Valid values are `cleared|pending|hold|rejected`',
    `sortation_decision` STRING COMMENT 'Routing decision made by the baggage handling system determining the next destination for the baggage item based on flight information and system logic.. Valid values are `to_flight|to_transfer|to_storage|to_reclaim|to_manual_handling|rejected`',
    `special_service_request_code` STRING COMMENT 'IATA standard code indicating special handling requirements for the baggage item such as fragile, perishable, live animals, or medical equipment.',
    `transfer_connection_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this baggage item is part of a connecting itinerary requiring transfer between flights at this airport.',
    `uld_number` STRING COMMENT 'Unique identifier of the unit load device container or pallet into which the baggage item was loaded for aircraft transport. Critical for cargo tracking and load reconciliation.',
    CONSTRAINT pk_baggage_scan PRIMARY KEY(`baggage_scan_id`)
) COMMENT 'Transactional record for each baggage scan event in the baggage handling system (BHS). Captures bag tag number, baggage item reference, scan location (check-in/BHS sortation/make-up area/aircraft hold/reclaim belt/transfer), scan device identifier, scan timestamp, flight reference, sortation decision, and scan result (read/no-read/manual-entry). Provides full baggage tracing chain from acceptance to delivery and supports IATA Resolution 753 baggage tracking compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`baggage_irregularity` (
    `baggage_irregularity_id` BIGINT COMMENT 'Unique identifier for the baggage irregularity record. Primary key for this entity.',
    `baggage_item_id` BIGINT COMMENT 'Foreign key linking to airport.baggage_item. Business justification: baggage_irregularity is about a specific baggage_item. Currently stores bag_tag_number (STRING) for lookup. FK to baggage_item provides direct access to bag details, routing, passenger, and flight inf',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight on which the baggage irregularity occurred or was discovered.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Baggage compensation liability and interim expenses are posted to general ledger for financial statement reporting, accrual accounting, and DOT baggage mishandling cost reporting. Essential for accura',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PIR cases assigned to specific workforce customer service agents for passenger communication, WorldTracer updates, and resolution tracking. Required for case accountability and performance metrics.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Baggage handling incidents can involve safety occurrences (equipment failures causing injury, hazmat exposure, security breaches). PIR investigations may trigger safety reports. Links baggage service ',
    `profile_id` BIGINT COMMENT 'Reference to the passenger who owns the mishandled baggage.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: baggage_irregularity is reported at a specific station. Currently stores report_station_code (STRING). FK to station provides access to station details and ground handler responsible. The report_stati',
    `bag_color` STRING COMMENT 'Primary color of the mishandled bag as reported by the passenger.',
    `bag_description` STRING COMMENT 'Detailed physical description of the mishandled bag including color, brand, size, type, and distinguishing features to aid in identification and recovery.',
    `bag_type` STRING COMMENT 'Type or category of the mishandled bag (e.g., suitcase, duffel, backpack, garment bag, sports equipment).. Valid values are `suitcase|duffel|backpack|garment_bag|sports_equipment|other`',
    `closure_timestamp` TIMESTAMP COMMENT 'Date and time when the baggage irregularity case was officially closed, either due to successful delivery or final settlement.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Actual compensation amount paid to the passenger for the baggage irregularity, including interim expenses and final settlement.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount.. Valid values are `^[A-Z]{3}$`',
    `contents_description` STRING COMMENT 'Description of the bag contents as declared by the passenger, used for identification and liability assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this baggage irregularity record was first created in the system.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the bag contents as declared by the passenger for liability and compensation purposes.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared value amount.. Valid values are `^[A-Z]{3}$`',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the recovered bag was successfully delivered to the passenger or their designated location.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code of the passengers final destination where the bag should have arrived.. Valid values are `^[A-Z]{3}$`',
    `dot_reportable_flag` BOOLEAN COMMENT 'Indicates whether this irregularity qualifies as a mishandled bag under DOT reporting requirements (delayed, damaged, lost, or pilfered).',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight associated with the baggage irregularity.',
    `flight_number` STRING COMMENT 'Flight number on which the baggage irregularity occurred. Includes carrier code and flight number (e.g., AA1234).. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `forwarding_instructions` STRING COMMENT 'Detailed instructions for forwarding the recovered bag to the passenger, including delivery address, contact information, and special handling requirements.',
    `forwarding_station_code` STRING COMMENT 'Three-letter IATA airport code of the station to which the recovered bag will be forwarded for delivery to the passenger.. Valid values are `^[A-Z]{3}$`',
    `handling_carrier_code` STRING COMMENT 'Two or three-character IATA airline code of the carrier currently handling the baggage irregularity case and recovery efforts.. Valid values are `^[A-Z0-9]{2,3}$`',
    `interim_expense_amount` DECIMAL(18,2) COMMENT 'Amount reimbursed to passenger for interim expenses incurred due to delayed baggage (e.g., toiletries, clothing purchases).',
    `irregularity_type_code` STRING COMMENT 'IATA standard code classifying the type of baggage irregularity. DL=Delayed, MS=Misrouted, DF=Defaced, PL=Pilfered, DM=Damaged, RT=Retained, FD=Fraud, OV=Overage, RU=Rush, LT=Lost. [ENUM-REF-CANDIDATE: DL|MS|DF|PL|DM|RT|FD|OV|RU|LT — 10 candidates stripped; promote to reference product]',
    `irregularity_type_description` STRING COMMENT 'Detailed description of the baggage irregularity type providing additional context beyond the standard code.',
    `last_known_location_code` STRING COMMENT 'Three-letter IATA airport code of the last confirmed location where the bag was scanned or sighted in the baggage handling system.. Valid values are `^[A-Z]{3}$`',
    `last_known_location_timestamp` TIMESTAMP COMMENT 'Date and time when the bag was last scanned or confirmed at the last known location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this baggage irregularity record was last updated in the system.',
    `liability_amount` DECIMAL(18,2) COMMENT 'Calculated airline liability amount for the baggage irregularity based on applicable regulations and declared value.',
    `liability_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the liability amount.. Valid values are `^[A-Z]{3}$`',
    `located_timestamp` TIMESTAMP COMMENT 'Date and time when the mishandled bag was located and identified in the baggage handling system.',
    `pir_number` STRING COMMENT 'Unique PIR number assigned to the baggage irregularity case. Format typically includes station code followed by sequential number. This is the externally-known business identifier for the irregularity.. Valid values are `^[A-Z]{3}[A-Z0-9]{7,10}$`',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric PNR locator code associated with the passengers booking. Used to link the irregularity to the reservation.. Valid values are `^[A-Z0-9]{6}$`',
    `recovery_status_code` STRING COMMENT 'Current status of the baggage recovery process. OP=Open/In Progress, LO=Located, FD=Found and Delivered, DL=Delivered, CL=Closed.. Valid values are `OP|LO|FD|DL|CL`',
    `recovery_status_description` STRING COMMENT 'Detailed description of the current recovery status providing additional context and updates on recovery efforts.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this baggage irregularity must be included in regulatory reporting to DOT, IATA, or other aviation authorities.',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the baggage irregularity was reported to airline staff. This is the principal business event timestamp for the irregularity lifecycle.',
    `responsible_carrier_code` STRING COMMENT 'Two or three-character IATA airline code of the carrier determined to be responsible for the baggage irregularity.. Valid values are `^[A-Z0-9]{2,3}$`',
    `worldtracer_reference` STRING COMMENT 'Global baggage tracing reference number from IATA WorldTracer system used for international baggage tracking and recovery coordination across airlines.. Valid values are `^[A-Z]{2}[0-9]{10}$`',
    CONSTRAINT pk_baggage_irregularity PRIMARY KEY(`baggage_irregularity_id`)
) COMMENT 'Transactional record for a baggage irregularity event including mishandled, delayed, damaged, or pilfered baggage. Captures PIR (Property Irregularity Report) number, bag tag reference, passenger reference, flight reference, irregularity type (misrouted/offloaded/damaged/pilfered/lost), report station, report timestamp, last known location, forwarding instructions, recovery status, and WorldTracer reference number. Supports IATA WorldTracer integration and DOT/IATA mishandled baggage reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`ramp_service_order` (
    `ramp_service_order_id` BIGINT COMMENT 'Unique identifier for the ramp service order. Primary key for this transactional record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Ground handling service invoices from third-party handlers are processed through accounts payable for payment, three-way matching with service orders, and accrual accounting. Critical for vendor payme',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Ground handler invoicing, aircraft-specific service requirements (wide-body vs narrow-body), and service compliance tracking require aircraft linkage. Cost allocation and handler performance analysis ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ramp service orders issued and coordinated by workforce operations staff for ground handler dispatch, SLA monitoring, and turnaround coordination. Standard airport operations practice.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg for which this ramp service order is issued. Links to the operational flight that requires ground handling services.',
    `gate_id` BIGINT COMMENT 'Reference to the gate or parking stand where the aircraft will be positioned for ramp service execution.',
    `ground_handler_id` BIGINT COMMENT 'Reference to the ground handling service provider responsible for executing this ramp service order. Represents the counterparty in this transaction.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Ramp service execution is primary source of ground safety events. Service order provides work authorization context for occurrence investigation, handler performance evaluation, and SLA breach analysi',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Ramp service orders are issued to ground handlers for services at specific airport stations. The ramp_service_order table currently has airport_code as a STRING denormalized attribute, but no FK to st',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to airport.turnaround. Business justification: ramp_service_order is issued for a specific turnaround event. The service order defines what services are required; the turnaround tracks execution. This FK links the order to the operational turnarou',
    `actual_completion_minutes` STRING COMMENT 'Actual elapsed time in minutes from service window start to completion. Used to measure ground handler performance against SLA targets.',
    `baggage_handling_required` BOOLEAN COMMENT 'Indicates whether baggage loading and unloading services are included in this ramp service order.',
    `cargo_handling_required` BOOLEAN COMMENT 'Indicates whether cargo and freight loading/unloading service is included in this ramp service order.',
    `catering_service_required` BOOLEAN COMMENT 'Indicates whether inflight catering service is included in this ramp service order.',
    `cdm_message_reference` STRING COMMENT 'Reference to the CDM message or milestone event that triggered or is associated with this ramp service order. Links to airport collaborative decision-making system.',
    `cleaning_service_required` BOOLEAN COMMENT 'Indicates whether cabin and/or exterior cleaning service is included in this ramp service order.',
    `completion_status` STRING COMMENT 'Final status indicating whether all ordered services were successfully completed and the timeliness of completion. Used for SLA measurement and performance tracking.. Valid values are `completed_on_time|completed_delayed|partially_completed|not_completed|waived`',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when all ordered ramp services were completed and the aircraft was released for departure or parking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ramp service order record was first created in the system.',
    `deicing_service_required` BOOLEAN COMMENT 'Indicates whether aircraft de-icing or anti-icing service is included in this ramp service order. Critical for winter operations and safety compliance.',
    `flight_operation_type` STRING COMMENT 'Type of flight operation for which ramp services are ordered. Turnaround indicates both arrival and departure services for a continuing flight.. Valid values are `arrival|departure|turnaround|overnight|maintenance`',
    `fueling_service_required` BOOLEAN COMMENT 'Indicates whether aircraft refueling service is included in this ramp service order.',
    `ground_handler_acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the ground handler acknowledged receipt and acceptance of the ramp service order.',
    `ground_power_required` BOOLEAN COMMENT 'Indicates whether ground electrical power supply service is included in this ramp service order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ramp service order record was last updated or modified.',
    `lavatory_service_required` BOOLEAN COMMENT 'Indicates whether lavatory waste removal and servicing is included in this ramp service order.',
    `order_issued_timestamp` TIMESTAMP COMMENT 'Date and time when the ramp service order was officially issued to the ground handler. Represents the principal business event timestamp for this transaction.',
    `order_priority` STRING COMMENT 'Priority level assigned to this ramp service order. Critical priority typically assigned to IROP recovery, VIP flights, or tight connection scenarios.. Valid values are `routine|high|urgent|critical`',
    `order_status` STRING COMMENT 'Current lifecycle status of the ramp service order. Tracks progression from issuance through completion or cancellation. [ENUM-REF-CANDIDATE: draft|issued|acknowledged|in_progress|completed|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `passenger_handling_required` BOOLEAN COMMENT 'Indicates whether passenger boarding and deplaning services are included in this ramp service order.',
    `potable_water_service_required` BOOLEAN COMMENT 'Indicates whether potable water replenishment service is included in this ramp service order.',
    `preconditioned_air_required` BOOLEAN COMMENT 'Indicates whether preconditioned air supply for cabin climate control is included in this ramp service order.',
    `pushback_towing_required` BOOLEAN COMMENT 'Indicates whether aircraft pushback or towing service is included in this ramp service order.',
    `scheduled_arrival_time` TIMESTAMP COMMENT 'Planned arrival time of the aircraft at the gate. Used to coordinate service window timing for arrival-related services.',
    `scheduled_departure_time` TIMESTAMP COMMENT 'Planned departure time of the aircraft from the gate. Used to coordinate service window timing and ensure all services are completed before pushback.',
    `service_deviation_flag` BOOLEAN COMMENT 'Indicates whether any deviations from the ordered services occurred during execution. Triggers review of deviation notes and potential SLA impact.',
    `service_deviation_notes` STRING COMMENT 'Detailed notes describing any deviations, exceptions, or issues encountered during ramp service execution. Includes reasons for incomplete services, delays, or quality issues.',
    `service_order_number` STRING COMMENT 'Externally-known unique business identifier for the ramp service order. Used for tracking and communication with ground handlers.. Valid values are `^RSO[0-9]{10}$`',
    `service_order_type` STRING COMMENT 'Classification of the ramp service order indicating the nature and priority of services required. IROP indicates irregular operations requiring expedited or special handling.. Valid values are `standard|special|irop|charter|vip|cargo_only`',
    `service_window_end_time` TIMESTAMP COMMENT 'Latest time by which all ramp services must be completed. Critical for ensuring on-time departure and compliance with slot times.',
    `service_window_start_time` TIMESTAMP COMMENT 'Earliest time when ramp services may commence. Defines the beginning of the operational window for ground handler access to the aircraft.',
    `sla_target_completion_minutes` STRING COMMENT 'Target turnaround time in minutes for completing all ramp services as defined in the ground handling service level agreement.',
    `special_service_instructions` STRING COMMENT 'Free-text field capturing any special instructions, requirements, or notes for the ground handler regarding service execution. May include VIP handling, hazmat cargo, oversized baggage, or IROP recovery instructions.',
    CONSTRAINT pk_ramp_service_order PRIMARY KEY(`ramp_service_order_id`)
) COMMENT 'Transactional record for a ramp service order issued to a ground handler for a specific aircraft arrival or departure. Captures flight reference, tail number, gate, service order type (standard/special/IROP), ordered services (fueling/catering/cleaning/de-icing/cargo/PAX handling), ground handler reference, order issue timestamp, service window start/end, completion status, and any service deviation notes. Serves as the contractual instruction to the ramp handler and supports ground handling SLA measurement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`deicing_event` (
    `deicing_event_id` BIGINT COMMENT 'Unique identifier for the de-icing or anti-icing treatment event. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Deicing vendor invoices are processed through AP for payment settlement. Airlines must match deicing events to vendor invoices for cost verification, dispute resolution, and seasonal winter operations',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Deicing cost allocation, holdover time compliance tracking, and aircraft-specific fluid type requirements require aircraft linkage. Regulatory reporting and winter operations analysis depend on accura',
    `deicing_crew_id` BIGINT COMMENT 'Identifier for the ground crew or team that performed the de-icing treatment. Used for quality tracking and training purposes.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight receiving de-icing treatment. Links to the scheduled or operational flight record.',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: deicing_event occurs at a specific location, often at the gate or a deicing pad. Currently stores deicing_location_identifier (STRING). FK to gate_assignment provides precise location, time window, an',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Deicing operations have inherent safety risks (fluid exposure, equipment incidents, slip hazards). Direct occurrence link consolidates safety reporting alongside existing occurrence_report_id FK for c',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: De-icing events occur at specific airport stations. The deicing_event table currently has airport_code as a STRING denormalized attribute, but no FK to station. Adding station_id normalizes this relat',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Deicing operations require certified workforce supervision for safety compliance, fluid application oversight, and holdover time validation. Regulatory requirement for accountable supervisor beyond cr',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this de-icing event record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `deicing_location_type` STRING COMMENT 'The type of location where de-icing was performed: dedicated de-icing pad, gate position, remote stand, or runway holding area.. Valid values are `pad|gate|remote_stand|runway_holding_area`',
    `deicing_vendor_code` STRING COMMENT 'Code identifying the third-party vendor or ground handling company that performed the de-icing service. Used for billing and performance tracking.',
    `environmental_reporting_flag` BOOLEAN COMMENT 'Indicates whether this de-icing event must be included in environmental compliance reporting (CORSIA, ISO 14001). True if glycol usage exceeds reporting thresholds.',
    `equipment_identifier` STRING COMMENT 'Identifier for the specific de-icing truck or equipment unit used. Enables equipment maintenance correlation and utilization tracking.',
    `flight_number` STRING COMMENT 'The airline flight number for the flight being de-iced (e.g., AA1234). Includes carrier code and flight number.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `fluid_concentration_primary_percent` DECIMAL(18,2) COMMENT 'Concentration percentage of the primary de-icing fluid mixture (glycol to water ratio). Affects freezing point and holdover time.',
    `fluid_concentration_secondary_percent` DECIMAL(18,2) COMMENT 'Concentration percentage of the secondary anti-icing fluid mixture. Null if no secondary treatment was performed.',
    `fluid_cost_total_amount` DECIMAL(18,2) COMMENT 'Total cost of de-icing and anti-icing fluids used in this treatment event. Used for financial tracking and cost recovery.',
    `fluid_type_primary` STRING COMMENT 'The primary de-icing fluid type applied in the first treatment step. Type I is typically used for de-icing (removing contamination).. Valid values are `type_i|type_ii|type_iii|type_iv`',
    `fluid_type_secondary` STRING COMMENT 'The secondary anti-icing fluid type applied in the second treatment step, if applicable. Types II, III, or IV provide longer holdover time protection.. Valid values are `type_i|type_ii|type_iii|type_iv`',
    `fluid_volume_primary_liters` DECIMAL(18,2) COMMENT 'Volume of primary de-icing fluid applied, measured in liters. Used for cost tracking and environmental reporting.',
    `fluid_volume_secondary_liters` DECIMAL(18,2) COMMENT 'Volume of secondary anti-icing fluid applied, measured in liters. Null if no secondary treatment was performed.',
    `holdover_time_minutes` STRING COMMENT 'The estimated time in minutes that the anti-icing treatment will remain effective under current weather conditions. Critical for flight safety and departure timing.',
    `inspection_performed_by` STRING COMMENT 'Identifier of the person or crew who performed the post-treatment inspection. May be pilot, ground crew, or designated inspector.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this de-icing event record was last updated. Audit trail for data lineage and change tracking.',
    `outside_air_temperature_celsius` DECIMAL(18,2) COMMENT 'The outside air temperature in degrees Celsius at the time of treatment. Critical factor in determining holdover time and fluid effectiveness.',
    `post_treatment_inspection_result` STRING COMMENT 'Result of the post-treatment inspection to verify aircraft surfaces are free of contamination. Critical safety check before departure.. Valid values are `pass|fail|not_performed`',
    `precipitation_intensity` STRING COMMENT 'The intensity of precipitation during treatment. Combined with precipitation type to determine holdover time from FAA/Transport Canada tables.. Valid values are `none|light|moderate|heavy`',
    `precipitation_type` STRING COMMENT 'The type of precipitation or frozen contamination present during treatment. Affects holdover time calculation and treatment requirements. [ENUM-REF-CANDIDATE: none|light_snow|moderate_snow|heavy_snow|freezing_rain|freezing_drizzle|ice_pellets|frost|mixed — 9 candidates stripped; promote to reference product]',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special circumstances, or operational comments related to the de-icing event.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Labor and equipment service charge for the de-icing treatment, separate from fluid costs. Used for vendor billing and cost allocation.',
    `treatment_duration_minutes` STRING COMMENT 'Total duration of the de-icing treatment in minutes, calculated from start to end timestamp. Used for operational efficiency analysis.',
    `treatment_end_timestamp` TIMESTAMP COMMENT 'The date and time when de-icing treatment was completed. Marks the start of the holdover time window.',
    `treatment_reason_code` STRING COMMENT 'The primary reason or trigger for performing the de-icing treatment. Used for operational analysis and cost allocation. [ENUM-REF-CANDIDATE: scheduled|frost|snow|ice|freezing_rain|preventive|regulatory_requirement — 7 candidates stripped; promote to reference product]',
    `treatment_start_timestamp` TIMESTAMP COMMENT 'The date and time when de-icing treatment began. Used to calculate holdover time expiration and turnaround impact.',
    `treatment_status` STRING COMMENT 'Current status of the de-icing treatment event in its lifecycle. Tracks operational workflow state.. Valid values are `completed|in_progress|aborted|failed|rework_required`',
    `treatment_type` STRING COMMENT 'The type of de-icing and anti-icing fluid treatment applied. Type I is heated de-icing fluid; Types II, III, IV are thickened anti-icing fluids with varying viscosities and holdover times. [ENUM-REF-CANDIDATE: type_i_only|type_i_and_ii|type_i_and_iii|type_i_and_iv|type_ii_only|type_iii_only|type_iv_only — 7 candidates stripped; promote to reference product]',
    `visibility_meters` STRING COMMENT 'Visibility in meters at the time of treatment. Indicates severity of weather conditions.',
    `wind_speed_knots` STRING COMMENT 'Wind speed in knots at the time of treatment. High winds can reduce holdover time effectiveness.',
    CONSTRAINT pk_deicing_event PRIMARY KEY(`deicing_event_id`)
) COMMENT 'Transactional record for an aircraft de-icing or anti-icing treatment event. Captures flight reference, tail number, de-icing pad or gate location, treatment type (Type I/II/III/IV fluid), fluid volume applied per treatment step, holdover time issued, treatment start and end timestamps, outside air temperature, precipitation type, de-icing crew identifier, and post-treatment inspection result. Supports safety compliance, fluid cost tracking, and environmental reporting (CORSIA/ISO 14001).';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`pfc_record` (
    `pfc_record_id` BIGINT COMMENT 'Unique identifier for the PFC record. Primary key.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Passenger Facility Charges collected by airlines create receivables from airport authorities or payables to authorities depending on collection method. Required for regulatory remittance tracking, DOT',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg on which this PFC was collected. Links to the flight operations entity.',
    `original_pfc_record_id` BIGINT COMMENT 'Reference to the original PFC record if this is an adjustment or correction. Links to the superseded record for audit trail.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger for whom this PFC was collected. Links to the passenger master entity.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for any adjustment to the PFC amount. Examples include ticket refunds, exchanges, schedule changes, or data corrections.',
    `adjustment_reason_description` STRING COMMENT 'Detailed explanation of the adjustment made to this PFC record. Provides audit trail for compliance and reconciliation.',
    `airport_authority_name` STRING COMMENT 'Legal name of the airport authority or municipality that imposed the PFC. Required for DOT remittance reporting.',
    `airport_code` STRING COMMENT 'Three-letter IATA airport code identifying the US airport authority that imposed this PFC. The airport where the charge applies.. Valid values are `^[A-Z]{3}$`',
    `arc_report_period` STRING COMMENT 'ARC reporting period (YYYY-MM format) in which this PFC collection was reported. Used for reconciliation with ARC settlement data.. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    `bsp_period` STRING COMMENT 'BSP billing period (YYYY-MM format) in which this PFC collection was processed. Used for international settlement reconciliation.. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    `collecting_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier that collected the PFC on behalf of the airport authority. May differ from the operating carrier in codeshare scenarios.. Valid values are `^[A-Z0-9]{2}$`',
    `collection_date` DATE COMMENT 'Date on which the PFC was collected from the passenger. Typically the ticket issuance date or payment date.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the PFC transaction. Tracks the charge from collection through remittance to the airport authority or refund to the passenger.. Valid values are `collected|remitted|adjusted|refunded|pending|voided`',
    `coupon_sequence_number` STRING COMMENT 'Sequential number of the flight coupon within the ticket on which this PFC applies. Identifies the specific segment within a multi-segment ticket.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PFC record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the PFC amount. Typically USD for US domestic PFC collections.. Valid values are `^[A-Z]{3}$`',
    `dot_reporting_flag` BOOLEAN COMMENT 'Indicates whether this PFC record must be included in the quarterly DOT PFC reporting submission. True for all collected and remitted charges.',
    `exemption_code` STRING COMMENT 'Code indicating the reason for PFC exemption if the charge was not collected. Examples include connecting passenger exemptions, through-ticketing exemptions, or regulatory waivers.',
    `exemption_reason` STRING COMMENT 'Detailed explanation of why the PFC was exempted or not collected. Supports audit and compliance review.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PFC record was last updated. Tracks changes for audit and reconciliation purposes.',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier that operated the flight segment. Identifies the actual airline providing the service.. Valid values are `^[A-Z0-9]{2}$`',
    `pfc_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the PFC collected for this segment. Typically $4.50 per eligible segment under current DOT regulations, but may vary by airport approval.',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric code uniquely identifying the passenger reservation in the GDS or PSS. Links this PFC collection to the originating booking.. Valid values are `^[A-Z0-9]{6}$`',
    `point_of_sale_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the ticket was sold. Used for revenue accounting and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the PFC refunded to the passenger. May differ from the original collection amount due to partial refunds or currency adjustments.',
    `refund_date` DATE COMMENT 'Date on which the PFC was refunded to the passenger due to ticket cancellation, schedule change, or other qualifying event.',
    `remittance_batch_number` STRING COMMENT 'Identifier of the remittance batch in which this PFC was submitted to the airport authority. Links to the batch payment and DOT reporting cycle.',
    `remittance_date` DATE COMMENT 'Date on which the PFC was remitted to the airport authority. Must occur within the DOT-mandated remittance period (typically monthly).',
    `sales_channel` STRING COMMENT 'Channel through which the ticket and PFC were sold. GDS (Global Distribution System), airline direct website, OTA (Online Travel Agency), traditional travel agent, corporate booking tool, or call center.. Valid values are `GDS|airline_direct|OTA|travel_agent|corporate|call_center`',
    `settlement_method` STRING COMMENT 'Method by which the PFC was settled. ARC (Airlines Reporting Corporation) for US domestic, BSP (Billing and Settlement Plan) for international, direct for airline-direct sales, or interline for interline ticketing agreements.. Valid values are `ARC|BSP|direct|interline`',
    `ticket_number` STRING COMMENT 'Thirteen-digit IATA standard ticket number (3-digit airline code + 10-digit serial number) on which the PFC was collected. Uniquely identifies the e-ticket document.. Valid values are `^[0-9]{13}$`',
    `travel_date` DATE COMMENT 'Scheduled date of travel for the flight segment on which this PFC applies. Used for eligibility validation and reporting.',
    CONSTRAINT pk_pfc_record PRIMARY KEY(`pfc_record_id`)
) COMMENT 'Transactional record for a Passenger Facility Charge (PFC) collected on behalf of a US airport authority. Captures PNR reference, passenger reference, ticket number, collecting carrier, airport authority, PFC amount per segment, currency, collection date, remittance batch reference, and remittance status (collected/remitted/adjusted/refunded). Supports DOT PFC remittance compliance and ARC/BSP settlement reconciliation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`ground_handler` (
    `ground_handler_id` BIGINT COMMENT 'Unique identifier for the ground handling service provider record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Ground handlers are vendors providing contracted services (ramp, passenger, baggage handling). Linking ground_handler to vendor master unifies vendor management, enables procurement spend analysis, co',
    `agreement_effective_date` DATE COMMENT 'The date when the ground handling agreement becomes effective and services may commence.',
    `agreement_expiry_date` DATE COMMENT 'The date when the ground handling agreement expires or is scheduled for renewal.',
    `aircraft_damage_incident_count` STRING COMMENT 'The total number of aircraft damage incidents caused by this handler during the current performance measurement period.',
    `average_baggage_delivery_time_minutes` DECIMAL(18,2) COMMENT 'The average time in minutes from aircraft arrival to first baggage on carousel for flights handled by this provider.',
    `baggage_handling_flag` BOOLEAN COMMENT 'Indicates whether the handler provides baggage sorting, loading, unloading, and tracing services.',
    `baggage_mishandling_rate_per_1000` DECIMAL(18,2) COMMENT 'The number of mishandled baggage incidents per 1000 passengers handled, including delayed, damaged, and lost baggage.',
    `cargo_handling_flag` BOOLEAN COMMENT 'Indicates whether the handler provides cargo and freight handling services including loading, unloading, and warehouse operations.',
    `catering_handling_flag` BOOLEAN COMMENT 'Indicates whether the handler provides aircraft catering loading and unloading services.',
    `contracted_stations` STRING COMMENT 'Comma-separated list of IATA airport codes where this handler is contracted to provide services.',
    `emergency_contact_phone` STRING COMMENT 'The 24/7 emergency contact telephone number for urgent operational issues and Aircraft on Ground (AOG) situations.',
    `fuel_handling_flag` BOOLEAN COMMENT 'Indicates whether the handler provides aircraft refueling and defueling services.',
    `handler_name` STRING COMMENT 'The legal registered name of the ground handling service provider organization.',
    `handler_type` STRING COMMENT 'Classification of the ground handler by ownership and operational model.. Valid values are `third_party|airline_self_handling|airport_authority|hybrid`',
    `iata_ground_handler_code` STRING COMMENT 'The IATA-assigned unique code identifying this ground handling service provider globally.. Valid values are `^[A-Z0-9]{3,4}$`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The total liability coverage amount provided by the handlers insurance policy.',
    `insurance_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the insurance coverage amount.. Valid values are `^[A-Z]{3}$`',
    `insurance_expiry_date` DATE COMMENT 'The date when the handlers liability insurance policy expires and must be renewed.',
    `insurance_policy_number` STRING COMMENT 'The policy number of the handlers liability insurance coverage as required by the ground handling agreement.',
    `isago_certification_expiry_date` DATE COMMENT 'The date when the handlers ISAGO certification expires and must be renewed.',
    `isago_certified_flag` BOOLEAN COMMENT 'Indicates whether the handler holds current IATA Safety Audit for Ground Operations (ISAGO) certification.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent formal performance review conducted with this ground handler.',
    `license_expiry_date` DATE COMMENT 'The date when the ground handlers operating license expires and must be renewed.',
    `license_issuing_authority` STRING COMMENT 'The name of the civil aviation authority or regulatory body that issued the ground handling license.',
    `license_number` STRING COMMENT 'The regulatory license or permit number issued by the civil aviation authority authorizing ground handling operations.',
    `on_time_departure_contribution_pct` DECIMAL(18,2) COMMENT 'The percentage of flights handled by this provider that departed on time, measuring contribution to overall On-Time Performance (OTP).',
    `operational_status` STRING COMMENT 'Current operational status of the ground handler within the airlines network.. Valid values are `active|suspended|inactive|pending_approval|terminated`',
    `passenger_handling_flag` BOOLEAN COMMENT 'Indicates whether the handler provides passenger services including check-in, boarding, and gate operations.',
    `penalty_triggered_flag` BOOLEAN COMMENT 'Indicates whether contractual penalties have been triggered due to performance failures during the current period.',
    `performance_score` DECIMAL(18,2) COMMENT 'The composite performance score (0-100) calculated from weighted Key Performance Indicators (KPIs) including on-time performance, baggage handling, safety, and SLA compliance.',
    `performance_tier` STRING COMMENT 'The current performance tier classification of the handler based on historical Service Level Agreement (SLA) compliance and quality metrics.. Valid values are `platinum|gold|silver|bronze|probationary`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary operational contact at the ground handler.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary operational contact person at the ground handler for day-to-day coordination.',
    `primary_contact_phone` STRING COMMENT 'The telephone number of the primary operational contact at the ground handler.',
    `ramp_handling_flag` BOOLEAN COMMENT 'Indicates whether the handler provides ramp services including aircraft marshalling, chocking, towing, and ground power.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ground handler record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ground handler record was last modified in the system.',
    `sgha_agreement_reference` STRING COMMENT 'The unique reference number of the Standard Ground Handling Agreement contract governing the relationship with this handler.',
    `sla_breach_count` STRING COMMENT 'The total number of Service Level Agreement breaches recorded against this handler during the current measurement period.',
    CONSTRAINT pk_ground_handler PRIMARY KEY(`ground_handler_id`)
) COMMENT 'Master record for ground handling service providers contracted to deliver ramp, passenger, and cargo handling services at specific stations, including performance measurement history. Captures handler name, IATA ground handler code, handling categories (ramp/passenger/cargo/fuel/catering), contracted stations, SGHA agreement reference, license and permit details, insurance expiry, performance tier, operational contact details, and periodic performance KPIs (on-time departure contribution, baggage delivery time, damage rate, SLA breach flags, penalty triggers, performance scores). SSOT for ground handler identity and SLA governance within the airport domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`handling_performance` (
    `handling_performance_id` BIGINT COMMENT 'Unique identifier for the ground handler performance measurement record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: SLA penalties and performance charges from ground handlers are processed through AP for invoice adjustment and payment settlement. Required for contract compliance enforcement, dispute resolution, and',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg associated with this performance measurement. Enables correlation of handler performance with specific flight operations.',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: handling_performance measures the performance of a specific ground handler. Currently stores ground_handler_code (STRING). FK to ground_handler provides access to handler details, contract terms, and ',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Handler performance measurement includes safety metrics. Occurrences during turnarounds affect performance scoring, SLA compliance, and penalty triggers. Links operational performance management to sa',
    `ramp_service_order_id` BIGINT COMMENT 'Foreign key linking to airport.ramp_service_order. Business justification: handling_performance measures performance against a specific ramp_service_order. Currently stores ramp_service_order_number (STRING). FK to ramp_service_order provides access to ordered services, SLA ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Ground handler performance measurements are recorded for specific airport stations. The handling_performance table currently has station_code as a STRING denormalized attribute, but no FK to station. ',
    `turnaround_id` BIGINT COMMENT 'Reference to the turnaround operation being measured. Links to the turnaround record for which this performance assessment applies.',
    `airline_remarks` STRING COMMENT 'Free-text remarks or notes provided by airline operations or quality assurance regarding handler performance. Used for dispute resolution and contract management.',
    `baggage_delivery_target_minutes` DECIMAL(18,2) COMMENT 'Contractual target time in minutes for first baggage delivery. Defined in the SGHA or service level agreement with the ground handler.',
    `baggage_delivery_time_minutes` DECIMAL(18,2) COMMENT 'Actual time in minutes from aircraft block-in to first baggage delivered to carousel or claim area. Key KPI for passenger experience and SGHA compliance.',
    `cdm_milestone_compliance_flag` BOOLEAN COMMENT 'Indicates whether the ground handler met all CDM milestone reporting requirements for this turnaround. Critical for airport slot management and A-CDM compliance.',
    `damage_incident_count` STRING COMMENT 'Number of damage incidents (aircraft, baggage, cargo, or GSE) attributed to the ground handler during this turnaround. Used for safety and quality performance tracking.',
    `damage_rate_per_turnaround` DECIMAL(18,2) COMMENT 'Calculated damage rate for this turnaround, expressed as incidents per turnaround. Used for trend analysis and handler comparison.',
    `delay_code_attributed` STRING COMMENT 'IATA two-digit delay code attributed to the ground handler if their performance caused or contributed to flight delay. Used for OTP analysis and accountability.. Valid values are `^[0-9]{2}$`',
    `delay_minutes_attributed` STRING COMMENT 'Number of delay minutes attributed to the ground handler. Used for OTP impact assessment and cost recovery calculations.',
    `handler_remarks` STRING COMMENT 'Free-text remarks or notes provided by the ground handler regarding this turnaround performance. May include explanations for delays or incidents.',
    `measurement_period_end` TIMESTAMP COMMENT 'End timestamp of the performance measurement window. Typically aligned with aircraft block-out time or service order completion.',
    `measurement_period_start` TIMESTAMP COMMENT 'Start timestamp of the performance measurement window. Typically aligned with aircraft block-in time or service order activation.',
    `measurement_recorded_by` STRING COMMENT 'Identifier of the system, user, or automated process that recorded this performance measurement. Supports audit trail and data quality validation.',
    `measurement_source_system` STRING COMMENT 'Name or code of the source system that generated this performance measurement. Typically SITA Airport Management Platform, CDM system, or airline operations control system.',
    `mishandled_baggage_count` STRING COMMENT 'Number of baggage pieces mishandled (delayed, damaged, or lost) during this turnaround attributed to ground handler error. Key metric for IATA Resolution 753 compliance.',
    `no_show_bag_count` STRING COMMENT 'Number of bags that failed to arrive at the aircraft for loading despite being checked in. Indicates handler process failures in baggage sorting or transport.',
    `on_time_departure_contribution_flag` BOOLEAN COMMENT 'Indicates whether the ground handler contributed to achieving on-time departure. True if handler completed all services within target time and did not cause delay.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Calculated financial penalty amount in the contract currency resulting from SLA breach. Null if no penalty applies. Used for accounts payable adjustment.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the penalty amount. Aligns with the ground handling contract currency.. Valid values are `^[A-Z]{3}$`',
    `penalty_trigger_flag` BOOLEAN COMMENT 'Indicates whether this performance measurement triggers a contractual penalty or financial adjustment. Used for automated billing and contract enforcement.',
    `performance_score` DECIMAL(18,2) COMMENT 'Composite performance score for this turnaround, typically on a 0-100 scale. Calculated from weighted KPIs defined in the SGHA. Used for handler ranking and contract renewal decisions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance measurement record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance measurement record was last modified. Supports change tracking and dispute resolution workflows.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during this turnaround involving the ground handler. Triggers mandatory reporting and investigation per ISAGO standards.',
    `safety_incident_severity` STRING COMMENT 'Severity classification of the safety incident if one occurred. Determines investigation depth and regulatory reporting requirements.. Valid values are `minor|moderate|major|critical`',
    `sla_breach_category` STRING COMMENT 'Category of SLA breach if applicable. Classifies the type of performance failure for root cause analysis and penalty calculation.. Valid values are `on_time_departure|baggage_delivery|damage|safety|none`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether any SLA threshold defined in the SGHA was breached during this turnaround. Triggers contract review and potential penalty assessment.',
    `turnaround_completion_status` STRING COMMENT 'Overall completion status of the turnaround from the handlers perspective. Indicates whether all contracted services were successfully delivered.. Valid values are `completed|incomplete|aborted|delayed`',
    CONSTRAINT pk_handling_performance PRIMARY KEY(`handling_performance_id`)
) COMMENT 'Transactional record capturing ground handler performance measurement for a completed turnaround or service order. Captures ground handler reference, turnaround or ramp service order reference, flight reference, station, measurement period, KPIs measured (on-time departure contribution, baggage delivery time, damage rate, no-show bag rate), actual vs target values, SLA breach flag, penalty trigger flag, and performance score. Supports SGHA SLA governance and handler contract management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`airport_irop_event` (
    `airport_irop_event_id` BIGINT COMMENT 'Unique identifier for the airport IROP event record. Primary key for the airport_irop_event product.',
    `employee_id` BIGINT COMMENT 'Identifier of the airport operations manager or duty manager responsible for coordinating the IROP response at the affected station.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: IROPs often involve or trigger safety occurrences (emergency evacuations, passenger injuries, operational deviations under pressure). IROP context is essential for understanding safety events during i',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: airport_irop_event affects a specific station. Currently stores affected_station_code (STRING). FK to station provides access to station details, operational capabilities, and ground handler informati',
    `atc_restriction_type` STRING COMMENT 'Type of ATC restriction imposed during the IROP event if ATC-related. Examples: ground stop, ground delay program, flow control, airspace closure, reduced arrival rate, departure spacing.',
    `cancelled_flight_count` STRING COMMENT 'Number of flights cancelled as a direct result of this IROP event.',
    `cdm_coordination_flag` BOOLEAN COMMENT 'Indicates whether this IROP event required CDM coordination with airport authority, ATC, and other stakeholders. True if CDM messages were exchanged for collaborative recovery planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this IROP event record was first created in the system. Represents initial event detection and logging.',
    `delayed_flight_count` STRING COMMENT 'Number of flights delayed beyond scheduled departure or arrival time as a result of this IROP event.',
    `diverted_flight_count` STRING COMMENT 'Number of flights diverted to alternate airports as a result of this IROP event.',
    `duration_minutes` STRING COMMENT 'Total duration of the IROP event in minutes, calculated from start to end timestamp. Null if event is still active.',
    `estimated_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact amount.. Valid values are `^[A-Z]{3}$`',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the IROP event in the airlines reporting currency, including passenger compensation, crew costs, fuel, rebooking, catering, and ground handling expenses.',
    `event_narrative` STRING COMMENT 'Free-text narrative describing the IROP event circumstances, operational response, challenges encountered, and lessons learned. Provides qualitative context for post-event analysis.',
    `gate_reassignment_count` STRING COMMENT 'Number of gate reassignments executed as a result of this IROP event to accommodate delayed, diverted, or rescheduled flights.',
    `impacted_flight_count` STRING COMMENT 'Total number of flight legs affected by this IROP event, including delayed, cancelled, diverted, and returned flights.',
    `impacted_pax_count` STRING COMMENT 'Total number of passengers affected by this IROP event across all impacted flights. Includes passengers requiring reaccommodation, rebooking, or compensation.',
    `irop_end_timestamp` TIMESTAMP COMMENT 'Date and time when the IROP event was resolved and normal operations resumed. Null if the event is still active.',
    `irop_reference_number` STRING COMMENT 'Business identifier for the IROP event, formatted as IROP-{station}-{date}-{sequence}. Used for cross-system coordination and operational communication.. Valid values are `^IROP-[A-Z]{3}-[0-9]{8}-[0-9]{4}$`',
    `irop_start_timestamp` TIMESTAMP COMMENT 'Date and time when the IROP event began affecting airport operations. Represents the initial detection or onset of the irregular condition.',
    `irop_subtype_code` STRING COMMENT 'Detailed classification within the IROP type. Examples: for WEATHER - thunderstorm, fog, snow, ice, wind; for ATC - flow control, airspace closure, slot restriction; for MECHANICAL - engine, hydraulic, avionics, APU; for SECURITY - threat, incident, screening delay; for CREW - sick call, duty time, positioning; for AIRPORT_CLOSURE - runway closure, terminal evacuation, equipment failure.',
    `irop_type_code` STRING COMMENT 'Classification of the IROP event cause. Weather includes storms, fog, snow, ice; ATC includes air traffic control delays and restrictions; Mechanical includes aircraft technical issues; Security includes security incidents and threats; Crew includes crew availability and legality issues; Airport Closure includes runway closures and facility shutdowns.. Valid values are `WEATHER|ATC|MECHANICAL|SECURITY|CREW|AIRPORT_CLOSURE`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this IROP event record was last updated. Tracks ongoing event management and status changes.',
    `lessons_learned_documented_flag` BOOLEAN COMMENT 'Indicates whether lessons learned from this IROP event have been documented and shared with operations teams for continuous improvement.',
    `notam_reference_number` STRING COMMENT 'Reference number of the NOTAM issued in connection with this IROP event, if applicable. Links to official airspace or airport facility notifications.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the IROP event. ACTIVE: event is ongoing and impacting operations; MONITORING: event conditions present but not yet impacting; RECOVERING: event ended, recovery actions in progress; RESOLVED: all recovery actions complete; CLOSED: event fully documented and archived.. Valid values are `ACTIVE|MONITORING|RECOVERING|RESOLVED|CLOSED`',
    `operations_control_center_code` STRING COMMENT 'Three-letter code identifying the airline operations control center responsible for managing this IROP event and coordinating recovery actions.. Valid values are `^[A-Z]{3}$`',
    `passenger_compensation_triggered_flag` BOOLEAN COMMENT 'Indicates whether this IROP event triggered passenger compensation obligations under EU261, DOT regulations, or airline policy due to delay duration, cancellation, or denied boarding.',
    `reaccommodation_action_count` STRING COMMENT 'Number of passenger reaccommodation actions (rebooking, rerouting, refund) processed as a result of this IROP event.',
    `recovery_plan_reference` STRING COMMENT 'Reference identifier for the operational recovery plan document or system record created to manage this IROP event. Links to detailed recovery actions, resource allocation, and timeline.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this IROP event requires notification to regulatory authorities (FAA, EASA, DOT, national CAA) due to severity, passenger rights implications, or safety concerns.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of this IROP event. Null if notification was not required or not yet completed.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis has been completed for this IROP event. True if RCA documentation exists.',
    `severity_level` STRING COMMENT 'Classification of the IROP event impact severity. MINOR: 1-5 flights affected, minimal passenger impact; MODERATE: 6-15 flights, localized disruption; MAJOR: 16-50 flights, significant operational impact; CRITICAL: 50+ flights, widespread disruption requiring executive coordination.. Valid values are `MINOR|MODERATE|MAJOR|CRITICAL`',
    `turnaround_delay_count` STRING COMMENT 'Number of aircraft turnarounds delayed beyond target turnaround time as a result of this IROP event.',
    `weather_condition_description` STRING COMMENT 'Detailed description of weather conditions during the IROP event if weather-related. Includes visibility, ceiling, wind speed/direction, precipitation type, temperature, and relevant METAR/TAF information.',
    CONSTRAINT pk_airport_irop_event PRIMARY KEY(`airport_irop_event_id`)
) COMMENT 'Transactional record for an Irregular Operations (IROP) event affecting airport and ground operations. Captures IROP type (weather/ATC/mechanical/security/crew/airport-closure), affected station, start and end timestamps, impacted flight count, impacted PAX count, IROP severity level, CDM coordination flag, recovery plan reference, and responsible operations control center. Serves as the SSOT for IROP events within the airport domain, linking to gate reassignments, turnaround delays, and passenger reaccommodation actions.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`station` (
    `station_id` BIGINT COMMENT 'Unique identifier for the airline operating station. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Airport stations are operational cost centers. Each station incurs costs (staff, facilities, ground handling) that must be tracked in the finance domain. This FK enables cost allocation and P&L report',
    `ground_handler_id` BIGINT COMMENT 'FK to airport.ground_handler',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Station manager normalization from denormalized text fields. Essential for org hierarchy, performance reviews, cost center accountability, and operational escalation paths. High-value 3NF enforcement.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Stations operate under jurisdiction of specific regulatory authorities (FAA for US stations, EASA for EU, CAAC for China). Essential for determining applicable regulations, filing requirements, and au',
    `cargo_handling_capable_flag` BOOLEAN COMMENT 'Indicates whether the station has facilities and capability for cargo and freight handling operations. True if capable, false otherwise.',
    `cdm_enabled_flag` BOOLEAN COMMENT 'Indicates whether the station participates in Airport CDM processes for collaborative operational decision-making. True if CDM-enabled, false otherwise.',
    `city_name` STRING COMMENT 'Name of the city where the station is located, used for route planning and passenger information.',
    `closed_date` DATE COMMENT 'Date when the airline ceased operations at this station, if applicable. Null for active stations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the station operates.. Valid values are `^[A-Z]{3}$`',
    `customs_facility_available_flag` BOOLEAN COMMENT 'Indicates whether customs clearance facilities are available at the station for international arrivals. True if available, false otherwise.',
    `dangerous_goods_certified_flag` BOOLEAN COMMENT 'Indicates whether the station is certified to handle dangerous goods shipments per IATA regulations. True if certified, false otherwise.',
    `daylight_saving_observed_flag` BOOLEAN COMMENT 'Indicates whether the station location observes daylight saving time adjustments. True if DST is observed, false otherwise.',
    `elevation_meters` STRING COMMENT 'Airport elevation above mean sea level in meters, critical for aircraft performance calculations and flight planning.',
    `fuel_provider_code` STRING COMMENT 'Code identifying the primary aviation fuel supplier at this station.',
    `hub_classification` STRING COMMENT 'Classification of the station within the airlines network topology. Hub: major connecting point with extensive operations. Focus city: secondary hub with significant operations. Spoke: destination served from hub. Outstation: remote station with limited operations.. Valid values are `hub|focus_city|spoke|outstation`',
    `iata_airport_code` STRING COMMENT 'Three-letter IATA airport code identifying the airport where this station operates. Standard industry identifier for airport locations.. Valid values are `^[A-Z]{3}$`',
    `icao_airport_code` STRING COMMENT 'Four-letter ICAO airport code providing globally unique airport identification used in flight planning and air traffic control.. Valid values are `^[A-Z]{4}$`',
    `immigration_facility_available_flag` BOOLEAN COMMENT 'Indicates whether immigration processing facilities are available at the station for international passengers. True if available, false otherwise.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the station in decimal degrees, used for flight planning and distance calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the station in decimal degrees, used for flight planning and distance calculations.',
    `maintenance_capability_level` STRING COMMENT 'Level of aircraft maintenance capability available at the station. None: no maintenance. Line: routine checks and minor repairs. Base: scheduled maintenance and component replacement. Heavy: major overhaul and structural work.. Valid values are `none|line|base|heavy`',
    `opened_date` DATE COMMENT 'Date when the airline first began operations at this station.',
    `operational_hours_description` STRING COMMENT 'Detailed description of station operating hours, including daily schedules, seasonal variations, and any restrictions.',
    `operational_hours_type` STRING COMMENT 'Classification of station operating hours. 24x7: continuous operations. Scheduled: fixed daily hours. Seasonal: varies by season or demand.. Valid values are `24x7|scheduled|seasonal`',
    `operational_status` STRING COMMENT 'Current operational status of the station. Active: fully operational. Suspended: temporarily not operating. Seasonal: operates only during specific seasons. Closed: permanently ceased operations.. Valid values are `active|suspended|seasonal|closed`',
    `overnight_parking_capable_flag` BOOLEAN COMMENT 'Indicates whether the station has facilities and authorization for overnight aircraft parking. True if capable, false otherwise.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this station record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this station record was last modified, used for change tracking and data synchronization.',
    `remarks` STRING COMMENT 'Free-text field for additional operational notes, restrictions, or special handling requirements specific to this station.',
    `slot_coordinated_flag` BOOLEAN COMMENT 'Indicates whether the airport is slot-coordinated, requiring advance allocation of takeoff and landing slots. True if slot-coordinated, false otherwise.',
    `slot_coordinator_code` STRING COMMENT 'Code identifying the slot coordination authority responsible for allocating slots at this airport, if slot-coordinated.',
    `station_name` STRING COMMENT 'Official name of the airline operating station, typically matching the airport name or city served.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the station location, used for flight scheduling and operational coordination.',
    `utc_offset_hours` DECIMAL(18,2) COMMENT 'Standard UTC offset in hours for the station location, excluding daylight saving time adjustments.',
    CONSTRAINT pk_station PRIMARY KEY(`station_id`)
) COMMENT 'Master record for an airline operating station at an airport. Captures IATA airport code, ICAO airport code, station name, city, country, hub classification (hub/focus-city/spoke/outstations), time zone, DST observance, station manager, operational hours, customs and immigration availability, overnight parking capability, maintenance capability level, and active status. SSOT for airline station definitions within the airport domain; complements the route domains network topology.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`checkin_counter` (
    `checkin_counter_id` BIGINT COMMENT 'Unique identifier for the check-in counter or kiosk asset. Primary key for the check-in counter master record.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Check-in kiosks, CUTE/CUPPS workstations, and counter equipment are capitalized fixed assets requiring depreciation accounting, asset register tracking, and maintenance cost allocation. Required for f',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: checkin_counter exists at a specific station/airport. Currently stores airport_code (STRING). FK to station provides access to station details, time zone, and ground handler information. The airport_c',
    `terminal_facility_id` BIGINT COMMENT 'Reference to the terminal facility where this check-in counter is located. Links to the terminal master record for facility-level attributes.',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether the counter meets accessibility standards for passengers with reduced mobility (PRM). True if the counter has wheelchair-accessible height, clear approach space, and assistive technology per ADA/EASA regulations.',
    `assigned_airline_code` STRING COMMENT 'Two or three-character IATA airline code for the carrier assigned to this counter. Null for common-use counters or when unassigned. Supports airline-specific counter allocation and billing.. Valid values are `^[A-Z0-9]{2,3}$`',
    `assigned_alliance_code` STRING COMMENT 'Two-character code for the airline alliance assigned to this counter (e.g., *A for Star Alliance, ST for SkyTeam, OW for oneworld). Used for alliance-based counter pooling arrangements.. Valid values are `^[A-Z]{2}$`',
    `availability_status` STRING COMMENT 'Real-time availability state for resource scheduling. Available counters are ready for assignment; occupied counters are currently in use; closed counters are outside operating hours; blocked counters are reserved but not yet active.. Valid values are `available|occupied|closed|blocked`',
    `average_processing_time_minutes` DECIMAL(18,2) COMMENT 'Average time in minutes required to process one passenger at this counter. Used for capacity planning, staffing models, and passenger wait time estimation. Varies by counter type and service complexity.',
    `baggage_scale_integrated_flag` BOOLEAN COMMENT 'Indicates whether the counter has an integrated baggage weighing scale for checked baggage processing. True if scale hardware is present and connected to the departure control system.',
    `baggage_tag_printer_available_flag` BOOLEAN COMMENT 'Indicates whether the counter has a baggage tag printer for printing IATA-compliant baggage tags. True if printer hardware is installed and operational for checked baggage processing.',
    `biometric_capability_flag` BOOLEAN COMMENT 'Indicates whether the counter is equipped with biometric verification technology (facial recognition, fingerprint, iris scan). True if biometric hardware and software are installed and operational for identity verification.',
    `boarding_pass_printer_type` STRING COMMENT 'Type of boarding pass printer installed at the counter. Thermal printers are common for self-service kiosks; laser printers are used at full-service counters; inkjet printers are rare; none indicates no printer (mobile boarding pass only).. Valid values are `thermal|laser|inkjet|none`',
    `counter_number` STRING COMMENT 'The physical counter number or identifier displayed at the check-in position. Used for passenger wayfinding and operational coordination.',
    `counter_position_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the counter location in decimal degrees. Supports indoor mapping, wayfinding applications, and spatial analytics for passenger flow optimization.',
    `counter_position_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the counter location in decimal degrees. Supports indoor mapping, wayfinding applications, and spatial analytics for passenger flow optimization.',
    `counter_type` STRING COMMENT 'Classification of the check-in counter by service model. Full-service counters are staffed for full passenger processing; self-service kiosks enable passenger self-check-in; CUSS (Common Use Self-Service) are industry-standard kiosks; bag-drop counters accept pre-checked baggage; premium counters serve business/first class; group counters handle tour groups.. Valid values are `full_service|self_service_kiosk|cuss|bag_drop|premium|group`',
    `counter_zone` STRING COMMENT 'Logical zone or area designation within the terminal (e.g., Zone A, International Check-In, Domestic North). Used for capacity planning and passenger flow management.',
    `cute_cupps_device_code` STRING COMMENT 'Device identifier for CUTE/CUPPS common-use systems. Enables multiple airlines to share the same counter infrastructure by dynamically switching airline applications on the workstation.',
    `dcs_workstation_code` STRING COMMENT 'Unique identifier for the DCS workstation or terminal assigned to this counter. Links the physical counter to the airlines passenger service system for check-in, boarding, and baggage processing.',
    `effective_date` DATE COMMENT 'Date from which this counter configuration becomes active. Supports temporal tracking of counter assignments, configuration changes, and airline allocations for historical reporting and planning.',
    `expiry_date` DATE COMMENT 'Date when this counter configuration expires or is superseded. Null for current active configurations. Enables temporal queries and historical analysis of counter utilization and assignments.',
    `installation_date` DATE COMMENT 'Date when the counter was installed and commissioned for operational use. Supports asset lifecycle tracking, depreciation calculations, and replacement planning.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the counter equipment. Used for maintenance scheduling, compliance tracking, and equipment reliability analysis.',
    `maximum_queue_capacity` STRING COMMENT 'Maximum number of passengers that can be accommodated in the queue area for this counter. Used for queue management, passenger flow modeling, and capacity planning during peak periods.',
    `network_ip_address` STRING COMMENT 'IP address assigned to the counter workstation or kiosk for network connectivity. Used for system administration, troubleshooting, and security monitoring. Classified as confidential business infrastructure data.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity. Supports proactive maintenance planning and ensures continuous operational availability of check-in resources.',
    `operating_hours_end` STRING COMMENT 'Daily end time for counter operations in HH:MM format (24-hour clock). Defines the close of the counters operational window for capacity planning and staffing.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Daily start time for counter operations in HH:MM format (24-hour clock). Defines the beginning of the counters operational window for capacity planning and staffing.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_status` STRING COMMENT 'Current operational state of the check-in counter. Operational counters are available for passenger processing; out-of-service counters are temporarily unavailable; maintenance counters are undergoing repair; reserved counters are held for future assignment; decommissioned counters are permanently retired.. Valid values are `operational|out_of_service|maintenance|reserved|decommissioned`',
    `passport_scanner_available_flag` BOOLEAN COMMENT 'Indicates whether the counter is equipped with a passport/travel document scanner for automated document verification. True if scanner hardware is installed and operational.',
    `payment_terminal_available_flag` BOOLEAN COMMENT 'Indicates whether the counter has a payment terminal for processing credit/debit card transactions (excess baggage, upgrades, ancillary services). True if PCI-compliant payment hardware is installed.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this counter record was first created in the system. Supports data lineage, audit trails, and troubleshooting. Immutable after initial creation.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this counter record. Supports change tracking, data quality monitoring, and synchronization with downstream systems. Updated on every modification.',
    `remarks` STRING COMMENT 'Free-text field for operational notes, special instructions, or additional context about the counter. May include temporary restrictions, equipment issues, or coordination notes for ground handling staff.',
    `service_mode` STRING COMMENT 'Operational assignment model for the counter. Common-use counters are shared across multiple airlines via CUTE/CUPPS systems; dedicated counters are assigned to a single airline; hybrid counters support both modes based on schedule.. Valid values are `common_use|dedicated|hybrid`',
    `terminal_identifier` STRING COMMENT 'Terminal designation within the airport (e.g., T1, T2, Terminal A). Provides human-readable terminal context for operational staff.',
    CONSTRAINT pk_checkin_counter PRIMARY KEY(`checkin_counter_id`)
) COMMENT 'Master record for check-in counter and kiosk assets at a station. Captures counter identifier, terminal facility reference, counter zone, counter type (full-service/self-service kiosk/CUSS/bag-drop), airline or alliance assignment, operational hours, accessibility compliance flag, biometric capability flag, and current operational status. Supports check-in resource planning, passenger flow management, and station capacity optimization.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`station_mro_contract` (
    `station_mro_contract_id` BIGINT COMMENT 'Unique identifier for the station MRO contract record. Primary key.',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to the Part-145 approved maintenance organisation providing services under this contract.',
    `station_id` BIGINT COMMENT 'Foreign key linking to the airline operating station where maintenance services are contracted.',
    `aog_support_available_flag` BOOLEAN COMMENT 'Indicates whether Aircraft on Ground (AOG) emergency support is included in this station contract.',
    `contract_end_date` DATE COMMENT 'Expiry or termination date of the maintenance services contract for this station-provider combination. Null for indefinite contracts.',
    `contract_reference` STRING COMMENT 'Official contract reference number or identifier used in procurement and legal documentation for this station-specific MRO service agreement.',
    `contract_start_date` DATE COMMENT 'Effective start date of the maintenance services contract for this station-provider combination.',
    `contract_status` STRING COMMENT 'Current status of the station MRO contract: active (services being provided), inactive (contract signed but not yet active), suspended (temporarily halted), expired (end date passed), terminated (cancelled before end date).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contract pricing and invoicing at this station.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review or contract evaluation for this station-provider relationship.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next performance review or contract evaluation for this station-provider relationship.',
    `performance_metrics` STRING COMMENT 'Key performance indicators and metrics tracked for this station-provider contract, such as on-time completion rate, defect rate, AOG response time, and customer satisfaction scores.',
    `pricing_model` STRING COMMENT 'Pricing structure for this station-provider contract (e.g., time-and-materials, fixed monthly fee, per-event pricing, cost-plus).',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person at the MRO provider for this station contract.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the MRO provider for this station contract.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the MRO provider for this station contract.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special terms, restrictions, or operational considerations specific to this station-provider contract.',
    `service_scope` STRING COMMENT 'Detailed description of the maintenance services covered under this contract at this station (e.g., line maintenance, overnight checks, component replacement, AOG support, scheduled inspections).',
    `sla_terms` STRING COMMENT 'Service Level Agreement terms and commitments for this station-provider contract, including response times, turnaround times, availability guarantees, and quality standards.',
    `twenty_four_seven_coverage_flag` BOOLEAN COMMENT 'Indicates whether the MRO provider offers 24/7 maintenance coverage at this station under this contract.',
    CONSTRAINT pk_station_mro_contract PRIMARY KEY(`station_mro_contract_id`)
) COMMENT 'This association product represents the commercial maintenance service contract between an approved Part-145 maintenance organisation and an airline operating station. It captures the contractual relationship governing MRO services provided at a specific station, including contract terms, service scope, SLA commitments, and performance tracking. Each record links one approved maintenance organisation to one station with attributes that exist only in the context of this contractual relationship.. Existence Justification: Airlines contract multiple Part-145 approved maintenance organisations at each operating station to provide line maintenance, heavy checks, component services, and AOG support. Each MRO provider operates at multiple stations across the airlines network. The business actively manages these relationships as station-specific MRO service contracts, tracking contract terms, service scope, SLA commitments, pricing, and performance metrics for each station-provider combination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`station_authorization` (
    `station_authorization_id` BIGINT COMMENT 'Unique identifier for this station authorization record. Primary key.',
    `certifying_staff_id` BIGINT COMMENT 'Foreign key linking to the certifying staff member who is authorized at this station',
    `station_id` BIGINT COMMENT 'Foreign key linking to the station where the certifying staff member is authorized to operate',
    `authorization_effective_date` DATE COMMENT 'The date from which the certifying staff member is authorized to perform maintenance and issue CRS at this specific station. Tracks station-specific authorization start.',
    `authorization_expiry_date` DATE COMMENT 'The date on which the certifying staff members authorization at this specific station expires. Tracks station-specific authorization end.',
    `authorization_status` STRING COMMENT 'Current status of the station authorization. Active: currently authorized. Suspended: temporarily suspended. Expired: authorization period ended. Revoked: authorization withdrawn.',
    `base_station_code` STRING COMMENT 'The three-letter IATA airport code of the primary maintenance station or base where the certifying staff member is assigned (e.g., LHR, JFK, DXB). Used for resource planning and AOG response coordination. [Moved from certifying_staff: base_station_code in certifying_staff represents the primary station assignment, which is actually a specific instance of the station authorization relationship. This should be modeled as a station_authorization record with a primary_station_flag rather than an attribute on certifying_staff. However, given that base_station_code is a single-valued attribute (one primary base), it may be appropriate to keep it on certifying_staff as a denormalized convenience field while the full authorization history lives in station_authorization. Recommend keeping it on certifying_staff for now but noting the relationship.]. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this station authorization record was first created in the system. Used for audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this station authorization record was last updated. Used for audit trail and change tracking.',
    `on_call_status` STRING COMMENT 'Indicates whether the certifying staff member is on primary on-call, backup on-call, or not on-call for AOG situations at this station. Station-specific on-call responsibility.',
    `shift_assignment` STRING COMMENT 'The shift pattern assigned to the certifying staff member at this specific station (e.g., day shift, night shift, rotating). Station-specific work schedule.',
    `station_qualification_date` DATE COMMENT 'The date on which the certifying staff member completed station-specific qualification training and familiarization for this stations facilities, equipment, and procedures.',
    CONSTRAINT pk_station_authorization PRIMARY KEY(`station_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between certifying staff and stations. It captures the station-specific authorization scope, validity periods, shift assignments, and on-call status for licensed aircraft maintenance engineers at each operating station. Each record links one certifying staff member to one station with attributes that exist only in the context of this station-specific authorization.. Existence Justification: In airline maintenance operations, certifying staff (licensed AMEs/A&P mechanics) are authorized to perform maintenance and issue Certificates of Release to Service (CRS) at multiple stations across the airlines network. Each station requires multiple certifying staff to cover shifts, on-call rotations, and operational demands. The business actively manages station-specific authorizations with effective dates, expiry dates, shift assignments, and on-call status for each staff-station combination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` (
    `airport_slot_allocation_id` BIGINT COMMENT 'Primary key for airport_slot_allocation',
    `scheduled_flight_id` BIGINT COMMENT 'Foreign key linking to the scheduled flight that is allocated this slot',
    `slot_allocation_slot_id` BIGINT COMMENT 'Unique identifier for this slot allocation record. Primary key.',
    `slot_id` BIGINT COMMENT 'Foreign key linking to the airport slot allocated to this scheduled flight',
    `allocated_time` TIMESTAMP COMMENT 'The specific date and time allocated for this slot operation (takeoff or landing) as assigned by the slot coordinator for this scheduled flight.',
    `allocation_date` DATE COMMENT 'Date when this slot was initially allocated to this scheduled flight by the slot coordinator.',
    `compliance_status` STRING COMMENT 'Indicates whether the slot was used in compliance with allocation for this scheduled flight: used (operated as planned), missed (not operated without justification), cancelled (properly cancelled), swapped (exchanged with another flight).',
    `confirmation_date` DATE COMMENT 'Date when the airline confirmed intention to use this slot for this scheduled flight. Null if not yet confirmed.',
    `historic_precedence_flag` BOOLEAN COMMENT 'Indicates whether this slot allocation carries historic precedence (grandfather rights) under IATA guidelines for this specific scheduled flight.',
    `slot_status` STRING COMMENT 'Current lifecycle status of this specific slot allocation. Allocated: initially assigned; Confirmed: airline confirmed intention to use; Returned: slot returned to pool; Swapped: exchanged with another carrier.',
    `slot_time_arrival` TIMESTAMP COMMENT 'Allocated landing slot time at the arrival airport as assigned by Air Traffic Control (ATC) or airport slot coordinator. Critical for slot-controlled airports. [Moved from scheduled_flight: This attribute represents the allocated landing slot time for a specific scheduled flight at a specific airport, which is relationship-specific data. A scheduled flight may have different arrival slot times across different seasons or when slots are reallocated, making this an attribute of the allocation relationship rather than an intrinsic property of the scheduled flight itself.]',
    `slot_time_departure` TIMESTAMP COMMENT 'Allocated takeoff slot time at the departure airport as assigned by Air Traffic Control (ATC) or airport slot coordinator. Critical for slot-controlled airports. [Moved from scheduled_flight: This attribute represents the allocated takeoff slot time for a specific scheduled flight at a specific airport, which is relationship-specific data. A scheduled flight may have different slot times across different seasons or when slots are reallocated, making this an attribute of the allocation relationship rather than an intrinsic property of the scheduled flight itself.]',
    CONSTRAINT pk_airport_slot_allocation PRIMARY KEY(`airport_slot_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between a scheduled flight and an airport slot. It captures the regulatory and operational linkage between a planned flight operation and its assigned takeoff or landing time at capacity-constrained airports. Each record links one scheduled_flight to one slot with attributes that track allocation timing, compliance, historic rights, and confirmation status that exist only in the context of this specific allocation.. Existence Justification: In airline operations at slot-coordinated airports, a single scheduled flight requires multiple slot allocations (departure slot at origin airport and arrival slot at destination airport), and slots can be reallocated, swapped, or transferred between different scheduled flights across IATA seasons. The slot allocation process is a distinct regulatory and operational business process with relationship-specific data including allocation dates, confirmation status, compliance tracking, and historic precedence rights that belong to neither the scheduled flight nor the slot alone.';

CREATE OR REPLACE TABLE `airlines_ecm`.`airport`.`deicing_crew` (
    `deicing_crew_id` BIGINT COMMENT 'Primary key for deicing_crew',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: De-icing crews are based at specific airport stations. The deicing_crew table currently has home_station_code as a STRING denormalized attribute, but no FK to station. Adding home_station_id normalize',
    `relieved_deicing_crew_id` BIGINT COMMENT 'Self-referencing FK on deicing_crew (relieved_deicing_crew_id)',
    `aircraft_type_qualified` STRING COMMENT 'Comma-separated list of aircraft types this crew is qualified to service (e.g., B737, A320, B777, A350).',
    `average_turnaround_time_minutes` DECIMAL(18,2) COMMENT 'Historical average time in minutes this crew takes to complete a standard deicing operation.',
    `cdm_participant` BOOLEAN COMMENT 'Indicates whether this crew participates in Airport Collaborative Decision Making (A-CDM) processes for coordinated deicing operations.',
    `certification_expiry_date` DATE COMMENT 'Date when the crews current deicing certification expires and recertification is required.',
    `certification_level` STRING COMMENT 'Qualification level of the deicing crew indicating training completion and operational authorization for different aircraft types and deicing procedures.',
    `contact_email` STRING COMMENT 'Primary email address for operational communication with the deicing crew or supervisor.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for reaching the deicing crew supervisor or dispatch coordinator.',
    `contract_end_date` DATE COMMENT 'End date of the service contract for contractor crews, or null for permanent internal crews.',
    `contract_start_date` DATE COMMENT 'Start date of the service contract for contractor crews, or employment start date for internal crews.',
    `contractor_company_name` STRING COMMENT 'Name of the third-party contractor company providing this deicing crew, if applicable (null for internal crews).',
    `cost_per_hour` DECIMAL(18,2) COMMENT 'Hourly cost rate for deploying this deicing crew, including labor, equipment, and overhead (in base currency).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deicing crew record was first created in the system.',
    `crew_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the deicing crew for operational reference and scheduling systems.',
    `crew_name` STRING COMMENT 'Human-readable name or designation of the deicing crew (e.g., Alpha Deicing Team, Night Shift Crew 3).',
    `crew_size` STRING COMMENT 'Number of personnel assigned to this deicing crew.',
    `crew_status` STRING COMMENT 'Current operational status of the deicing crew indicating availability and lifecycle state.',
    `crew_type` STRING COMMENT 'Classification of the deicing crew based on employment and operational model (internal airline staff, third-party contractor, hybrid, seasonal, emergency response, or standby).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and financial fields (e.g., USD, EUR, GBP).',
    `effective_from_date` DATE COMMENT 'Date from which this crew record becomes active and valid for operational use.',
    `effective_to_date` DATE COMMENT 'Date until which this crew record remains active; null indicates open-ended validity.',
    `emergency_response_capable` BOOLEAN COMMENT 'Indicates whether this crew is trained and equipped for emergency deicing operations during severe weather events.',
    `equipment_assigned` STRING COMMENT 'Comma-separated list or description of ground support equipment (GSE) and deicing vehicles assigned to this crew (e.g., Type I truck, Type IV truck, bucket lift).',
    `fluid_type_authorized` STRING COMMENT 'Types of deicing and anti-icing fluids this crew is certified to apply (e.g., Type I, Type II, Type IV per AMS 1424/1428 standards).',
    `language_proficiency` STRING COMMENT 'Languages spoken by crew members for communication with flight crew and ground operations (e.g., English, French, Spanish).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deicing crew record was last updated or modified.',
    `last_training_date` DATE COMMENT 'Date of the most recent training session completed by this deicing crew.',
    `next_training_date` DATE COMMENT 'Scheduled date for the next mandatory training or recertification session.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or crew-specific information.',
    `operational_hours_capacity` DECIMAL(18,2) COMMENT 'Maximum number of operational hours this crew can work per shift or per day, based on regulatory and safety limits.',
    `performance_rating` STRING COMMENT 'Overall performance rating of the deicing crew based on operational efficiency, safety record, and quality metrics.',
    `safety_incident_count` STRING COMMENT 'Cumulative count of safety incidents or violations recorded for this crew since activation.',
    `shift_pattern` STRING COMMENT 'Work schedule pattern assigned to the deicing crew (day shift, night shift, rotating shifts, on-call, or continuous 24x7 coverage).',
    `supervisor_name` STRING COMMENT 'Full name of the supervisor or crew lead responsible for this deicing crew.',
    CONSTRAINT pk_deicing_crew PRIMARY KEY(`deicing_crew_id`)
) COMMENT 'Master reference table for deicing_crew. Referenced by deicing_crew_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ADD CONSTRAINT `fk_airport_terminal_facility_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gate` ADD CONSTRAINT `fk_airport_gate_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gate` ADD CONSTRAINT `fk_airport_gate_terminal_facility_id` FOREIGN KEY (`terminal_facility_id`) REFERENCES `airlines_ecm`.`airport`.`terminal_facility`(`terminal_facility_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ADD CONSTRAINT `fk_airport_gate_assignment_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `airlines_ecm`.`airport`.`gate`(`gate_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_gse_asset_id` FOREIGN KEY (`gse_asset_id`) REFERENCES `airlines_ecm`.`airport`.`gse_asset`(`gse_asset_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_gse_deployment_id` FOREIGN KEY (`gse_deployment_id`) REFERENCES `airlines_ecm`.`airport`.`gse_deployment`(`gse_deployment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ADD CONSTRAINT `fk_airport_slot_utilization_slot_id` FOREIGN KEY (`slot_id`) REFERENCES `airlines_ecm`.`airport`.`slot`(`slot_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ADD CONSTRAINT `fk_airport_slot_utilization_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ADD CONSTRAINT `fk_airport_cdm_message_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ADD CONSTRAINT `fk_airport_cdm_message_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ADD CONSTRAINT `fk_airport_gse_asset_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ADD CONSTRAINT `fk_airport_gse_asset_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ADD CONSTRAINT `fk_airport_gse_deployment_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ADD CONSTRAINT `fk_airport_gse_deployment_gse_asset_id` FOREIGN KEY (`gse_asset_id`) REFERENCES `airlines_ecm`.`airport`.`gse_asset`(`gse_asset_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ADD CONSTRAINT `fk_airport_gse_deployment_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ADD CONSTRAINT `fk_airport_gse_deployment_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_checkin_counter_id` FOREIGN KEY (`checkin_counter_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_counter`(`checkin_counter_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ADD CONSTRAINT `fk_airport_baggage_scan_baggage_item_id` FOREIGN KEY (`baggage_item_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_item`(`baggage_item_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ADD CONSTRAINT `fk_airport_baggage_scan_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_baggage_item_id` FOREIGN KEY (`baggage_item_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_item`(`baggage_item_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `airlines_ecm`.`airport`.`gate`(`gate_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_deicing_crew_id` FOREIGN KEY (`deicing_crew_id`) REFERENCES `airlines_ecm`.`airport`.`deicing_crew`(`deicing_crew_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ADD CONSTRAINT `fk_airport_pfc_record_original_pfc_record_id` FOREIGN KEY (`original_pfc_record_id`) REFERENCES `airlines_ecm`.`airport`.`pfc_record`(`pfc_record_id`);
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ADD CONSTRAINT `fk_airport_handling_performance_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ADD CONSTRAINT `fk_airport_handling_performance_ramp_service_order_id` FOREIGN KEY (`ramp_service_order_id`) REFERENCES `airlines_ecm`.`airport`.`ramp_service_order`(`ramp_service_order_id`);
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ADD CONSTRAINT `fk_airport_handling_performance_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ADD CONSTRAINT `fk_airport_handling_performance_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ADD CONSTRAINT `fk_airport_airport_irop_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`station` ADD CONSTRAINT `fk_airport_station_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ADD CONSTRAINT `fk_airport_checkin_counter_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ADD CONSTRAINT `fk_airport_checkin_counter_terminal_facility_id` FOREIGN KEY (`terminal_facility_id`) REFERENCES `airlines_ecm`.`airport`.`terminal_facility`(`terminal_facility_id`);
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ADD CONSTRAINT `fk_airport_station_mro_contract_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ADD CONSTRAINT `fk_airport_station_authorization_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ADD CONSTRAINT `fk_airport_airport_slot_allocation_slot_allocation_slot_id` FOREIGN KEY (`slot_allocation_slot_id`) REFERENCES `airlines_ecm`.`airport`.`slot`(`slot_id`);
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ADD CONSTRAINT `fk_airport_airport_slot_allocation_slot_id` FOREIGN KEY (`slot_id`) REFERENCES `airlines_ecm`.`airport`.`slot`(`slot_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ADD CONSTRAINT `fk_airport_deicing_crew_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ADD CONSTRAINT `fk_airport_deicing_crew_relieved_deicing_crew_id` FOREIGN KEY (`relieved_deicing_crew_id`) REFERENCES `airlines_ecm`.`airport`.`deicing_crew`(`deicing_crew_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`airport` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`airport` SET TAGS ('dbx_domain' = 'airport');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `terminal_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Facility Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `accessibility_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `annual_passenger_volume` SET TAGS ('dbx_business_glossary_term' = 'Annual Passenger Volume');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `bag_drop_counter_count` SET TAGS ('dbx_business_glossary_term' = 'Bag Drop Counter Count');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `biometric_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Capability Flag');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `biometric_capability_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `biometric_capability_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `cdm_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Enabled Flag');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `check_in_counter_count` SET TAGS ('dbx_business_glossary_term' = 'Check-In Counter Count');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `contact_gate_count` SET TAGS ('dbx_business_glossary_term' = 'Contact Gate Count');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `counter_zone_designation` SET TAGS ('dbx_business_glossary_term' = 'Counter Zone Designation');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `customs_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Facility Flag');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Address');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_city` SET TAGS ('dbx_business_glossary_term' = 'Facility City');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_email` SET TAGS ('dbx_business_glossary_term' = 'Facility Email Address');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_phone` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone Number');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Postal Code');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'terminal_building|concourse|pier|satellite|check_in_hall|gate_area');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `hub_classification` SET TAGS ('dbx_business_glossary_term' = 'Hub Classification');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `hub_classification` SET TAGS ('dbx_value_regex' = 'hub|spoke|focus_city|outstation|maintenance_base');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `lounge_count` SET TAGS ('dbx_business_glossary_term' = 'Lounge Count');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Airline Code');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|under_construction|closed|seasonal|maintenance');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'airline_owned|joint_use|leased|shared_facility|airport_authority');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `passenger_capacity_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Passenger (PAX) Capacity Per Hour');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `remote_gate_count` SET TAGS ('dbx_business_glossary_term' = 'Remote Gate Count');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `security_checkpoint_count` SET TAGS ('dbx_business_glossary_term' = 'Security Checkpoint Count');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `self_service_kiosk_count` SET TAGS ('dbx_business_glossary_term' = 'Self-Service Kiosk Count');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `slot_coordinated_flag` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordinated Flag');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `terminal_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Terminal Area Square Meters (sqm)');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `terminal_identifier` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ALTER COLUMN `total_gate_count` SET TAGS ('dbx_business_glossary_term' = 'Total Gate Count');
ALTER TABLE `airlines_ecm`.`airport`.`gate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`gate` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `terminal_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `aircraft_size_code_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Aircraft Size Code (ICAO)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `aircraft_size_code_max` SET TAGS ('dbx_value_regex' = '^[A-F]$');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `aircraft_size_code_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Aircraft Size Code (ICAO)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `aircraft_size_code_min` SET TAGS ('dbx_value_regex' = '^[A-F]$');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `common_use_gate` SET TAGS ('dbx_business_glossary_term' = 'Common Use Gate');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `concourse` SET TAGS ('dbx_business_glossary_term' = 'Concourse Designation');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `concourse` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `customs_facility` SET TAGS ('dbx_business_glossary_term' = 'Customs Facility Available');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `domestic_capable` SET TAGS ('dbx_business_glossary_term' = 'Domestic Flight Capable');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `fuel_hydrant_available` SET TAGS ('dbx_business_glossary_term' = 'Fuel Hydrant Available');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `gate_number` SET TAGS ('dbx_business_glossary_term' = 'Gate Number');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `gate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `gate_type` SET TAGS ('dbx_business_glossary_term' = 'Gate Type');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `gate_type` SET TAGS ('dbx_value_regex' = 'contact|remote|hardstand|bus_gate|swing_gate');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `ground_power_unit_available` SET TAGS ('dbx_business_glossary_term' = 'Ground Power Unit (GPU) Available');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `international_capable` SET TAGS ('dbx_business_glossary_term' = 'International Flight Capable');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `jetbridge_available` SET TAGS ('dbx_business_glossary_term' = 'Jetbridge Available');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `jetbridge_count` SET TAGS ('dbx_business_glossary_term' = 'Jetbridge Count');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `max_aircraft_length_meters` SET TAGS ('dbx_business_glossary_term' = 'Maximum Aircraft Length (Meters)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `max_wingspan_meters` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wingspan (Meters)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `minimum_turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Turnaround Time (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `narrow_body_capable` SET TAGS ('dbx_business_glossary_term' = 'Narrow-Body Aircraft Capable');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Airline Code (IATA)');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|closed|reserved|inactive');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `parking_stand_designation` SET TAGS ('dbx_business_glossary_term' = 'Parking Stand Designation');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `potable_water_available` SET TAGS ('dbx_business_glossary_term' = 'Potable Water Service Available');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `preconditioned_air_available` SET TAGS ('dbx_business_glossary_term' = 'Preconditioned Air (PCA) Available');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `regional_jet_capable` SET TAGS ('dbx_business_glossary_term' = 'Regional Jet Capable');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Operational Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `schengen_capable` SET TAGS ('dbx_business_glossary_term' = 'Schengen Area Capable');
ALTER TABLE `airlines_ecm`.`airport`.`gate` ALTER COLUMN `wide_body_capable` SET TAGS ('dbx_business_glossary_term' = 'Wide-Body Aircraft Capable');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `actual_gate_in_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Gate In Time (Actual On-Block Time)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `actual_gate_out_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Gate Out Time (Actual Off-Block Time)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `aircraft_size_category` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Size Category');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `aircraft_size_category` SET TAGS ('dbx_value_regex' = 'narrow_body|wide_body|regional|heavy|super');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `airport_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Airport International Air Transport Association (IATA) Code');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `airport_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `arrival_gate` SET TAGS ('dbx_business_glossary_term' = 'Arrival Gate');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `arrival_gate` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_end_time` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment End Time');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Number');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^GA[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'cdm|manual|auto_assign|rescheduled|irop');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_start_time` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Status');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|active|completed|released|cancelled');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Creation Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `cdm_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Milestone Status');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `cdm_milestone_status` SET TAGS ('dbx_value_regex' = 'tobt_set|tsat_issued|aobt_actual|aibt_actual|aldt_actual|pending');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Conflict Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Notes');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `departure_gate` SET TAGS ('dbx_business_glossary_term' = 'Departure Gate');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `departure_gate` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `domestic_international_flag` SET TAGS ('dbx_business_glossary_term' = 'Domestic International Flight Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `domestic_international_flag` SET TAGS ('dbx_value_regex' = 'domestic|international|schengen');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `gate_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Gate Hold Reason');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `gate_type` SET TAGS ('dbx_business_glossary_term' = 'Gate Type');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `gate_type` SET TAGS ('dbx_value_regex' = 'contact|remote|hardstand|cargo');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `ground_power_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ground Power Available Flag (GPU)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `hub_spoke_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hub Spoke Indicator');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `hub_spoke_indicator` SET TAGS ('dbx_value_regex' = 'hub|spoke|focus_city|outstation');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `jet_bridge_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Jet Bridge Available Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `passenger_facility_charge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Facility Charge (PFC) Applicable Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `preconditioned_air_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Preconditioned Air Available Flag (PCA)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `priority_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `priority_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Reason');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `scheduled_gate_in_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Gate In Time (On-Block Time)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `scheduled_gate_out_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Gate Out Time (Off-Block Time)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `slot_coordination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordination Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code (SSR)');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `stand_compatibility_code` SET TAGS ('dbx_business_glossary_term' = 'Stand Compatibility Code');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `stand_compatibility_code` SET TAGS ('dbx_value_regex' = '^[A-F]$');
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ALTER COLUMN `turnaround_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround ID');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Flight Leg ID');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `turnaround_outbound_flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Flight Leg ID');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `actual_block_in_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Block-In Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `actual_block_out_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Block-Out Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `actual_turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Turnaround Time in Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `all_services_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'All Services Completed Flag');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `baggage_pieces_loaded` SET TAGS ('dbx_business_glossary_term' = 'Baggage Pieces Loaded');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `baggage_pieces_offloaded` SET TAGS ('dbx_business_glossary_term' = 'Baggage Pieces Offloaded');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `cargo_weight_loaded_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight Loaded in Kilograms');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `cargo_weight_offloaded_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight Offloaded in Kilograms');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `cdm_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Milestone Status');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `delay_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Delay Code');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `delay_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notes');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `fuel_uplift_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift in Kilograms');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `ground_support_equipment_assigned` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Assigned');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `handler_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handler Instructions');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `otp_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Performance (OTP) Impact Flag');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `passenger_count_boarded` SET TAGS ('dbx_business_glossary_term' = 'Passenger Count Boarded');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `passenger_count_deplaned` SET TAGS ('dbx_business_glossary_term' = 'Passenger Count Deplaned');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `ramp_service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Ramp Service Order Number');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `ramp_service_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `scheduled_block_in_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Block-In Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `scheduled_block_out_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Block-Out Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `service_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window End Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `service_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `services_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Services Completion Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `services_ordered` SET TAGS ('dbx_business_glossary_term' = 'Services Ordered');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `target_turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Turnaround Time (TTT) in Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `turnaround_status` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Status');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `turnaround_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|delayed|cancelled|diverted');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `turnaround_type` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Type');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ALTER COLUMN `turnaround_type` SET TAGS ('dbx_value_regex' = 'standard|quick|overnight|transit|maintenance|extended');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `turnaround_task_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Task Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Operator Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gse_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Asset Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gse_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Gse Deployment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Event Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `delay_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gate_stand_position` SET TAGS ('dbx_business_glossary_term' = 'Gate Stand Position');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gse_defect_description` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Defect Description');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gse_defect_noted_flag` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Defect Noted Flag');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gse_deployment_end_time` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Deployment End Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gse_deployment_start_time` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Deployment Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `gse_fuel_consumed_liters` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Fuel Consumed (Liters)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|NORMAL|LOW');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `quality_check_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Performed Flag');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `quality_check_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Result');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `quality_check_result` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|CONDITIONAL|NOT_PERFORMED');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Delivered');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `service_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Code');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Name');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `sla_target_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `task_type_code` SET TAGS ('dbx_business_glossary_term' = 'Task Type Code');
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `airlines_ecm`.`airport`.`slot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`slot` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `actual_flight_reference` SET TAGS ('dbx_business_glossary_term' = 'Actual Flight Reference');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `actual_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Operation Date');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `actual_operation_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Operation Time');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `airline_designator` SET TAGS ('dbx_business_glossary_term' = 'Airline Designator Code');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `airline_designator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `allocated_time` SET TAGS ('dbx_business_glossary_term' = 'Allocated Slot Time');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation Date');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `cdm_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Message Reference');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Compliance Status');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'used|missed|cancelled|swapped|not_yet_operated');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Confirmation Date');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `coordinator_reference` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordinator Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `historic_precedence_flag` SET TAGS ('dbx_business_glossary_term' = 'Historic Precedence Flag');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `iata_season` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Season');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `iata_season` SET TAGS ('dbx_value_regex' = '^(S|W)[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `justification_category` SET TAGS ('dbx_business_glossary_term' = 'Justification Category');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `justification_category` SET TAGS ('dbx_value_regex' = 'weather|atc_delay|technical|operational|commercial|other');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Slot Notes');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `pool_category` SET TAGS ('dbx_business_glossary_term' = 'Slot Pool Category');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `pool_category` SET TAGS ('dbx_value_regex' = 'new_entrant|domestic|international|general');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `series` SET TAGS ('dbx_business_glossary_term' = 'Slot Series Type');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `series` SET TAGS ('dbx_value_regex' = 'regular|ad_hoc');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `series_identifier` SET TAGS ('dbx_business_glossary_term' = 'Slot Series Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'passenger|cargo|ferry|positioning');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'allocated|confirmed|returned|swapped|cancelled|suspended');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_value_regex' = 'arrival|departure');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `swap_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Swap Date');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `swap_partner_airline` SET TAGS ('dbx_business_glossary_term' = 'Swap Partner Airline Designator');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `swap_partner_airline` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `terminal_identifier` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`slot` ALTER COLUMN `time_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Variance in Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_utilization_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Utilization ID');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot ID');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Time');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `arrival_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Arrival Variance Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `cdm_message_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Message Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Compliance Status');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'used|missed|cancelled|swapped|returned|forfeited');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `departure_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Departure Variance Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `historic_rights_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Historic Rights Protected Flag');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `non_compliance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason Code');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `non_compliance_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `non_compliance_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason Description');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `operated_date` SET TAGS ('dbx_business_glossary_term' = 'Operated Date');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `planned_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Time');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `planned_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Time');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Season Code');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(S|W)[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_coordinator_code` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordinator Code');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_coordinator_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Slot Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_series_indicator` SET TAGS ('dbx_business_glossary_term' = 'Slot Series Indicator');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `slot_series_indicator` SET TAGS ('dbx_value_regex' = 'ad_hoc|series');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `swap_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Swap Transaction ID');
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ALTER COLUMN `utilization_recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Utilization Recorded Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `cdm_message_id` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Message Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `aobt` SET TAGS ('dbx_business_glossary_term' = 'Actual Off-Block Time (AOBT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `atot` SET TAGS ('dbx_business_glossary_term' = 'Actual Take-Off Time (ATOT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `cobt` SET TAGS ('dbx_business_glossary_term' = 'Coordinated Off-Block Time (COBT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `correlation_reference` SET TAGS ('dbx_business_glossary_term' = 'Message Correlation Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `ctot` SET TAGS ('dbx_business_glossary_term' = 'Calculated Take-Off Time (CTOT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `delay_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Delay Code');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `eobt` SET TAGS ('dbx_business_glossary_term' = 'Estimated Off-Block Time (EOBT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `is_slot_constrained` SET TAGS ('dbx_business_glossary_term' = 'Slot Constrained Flight Indicator');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `message_priority` SET TAGS ('dbx_business_glossary_term' = 'Message Priority Level');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `message_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `message_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Creation Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'CDM Message Type Code');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `message_version` SET TAGS ('dbx_business_glossary_term' = 'CDM Message Version');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `originating_system` SET TAGS ('dbx_business_glossary_term' = 'Originating System Name');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Message Processing Status');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'received|validated|processed|rejected|failed');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `receiver_organization` SET TAGS ('dbx_business_glossary_term' = 'Receiver Organization Name');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Message Rejection Reason');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight Date');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `sender_organization` SET TAGS ('dbx_business_glossary_term' = 'Sender Organization Name');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Message Sequence Number');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `target_system` SET TAGS ('dbx_business_glossary_term' = 'Target System Name');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `tobt` SET TAGS ('dbx_business_glossary_term' = 'Target Off-Block Time (TOBT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `tsat` SET TAGS ('dbx_business_glossary_term' = 'Target Start-Up Approval Time (TSAT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `ttot` SET TAGS ('dbx_business_glossary_term' = 'Target Take-Off Time (TTOT)');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `turnaround_status` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Status');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `turnaround_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|delayed');
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `gse_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Asset ID');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Home Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Availability Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'KG|LBS|KVA|LITERS|GALLONS|PASSENGERS');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Capacity Value');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `current_station_code` SET TAGS ('dbx_business_glossary_term' = 'Current Station Code');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `current_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'STRAIGHT_LINE|DECLINING_BALANCE|UNITS_OF_PRODUCTION');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `equipment_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Registration Number');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `equipment_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `equipment_subtype` SET TAGS ('dbx_business_glossary_term' = 'Equipment Subtype');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `equipment_type_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Code');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'DIESEL|GASOLINE|ELECTRIC|HYBRID|LPG|CNG');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `gps_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'GPS Tracking Enabled Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'CURRENT|OVERDUE|SCHEDULED|IN_PROGRESS');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `maximum_towing_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Towing Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `model_designation` SET TAGS ('dbx_business_glossary_term' = 'Model Designation');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `operating_hours_total` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Total');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'IN_SERVICE|OUT_OF_SERVICE|MAINTENANCE|RETIRED|RESERVED');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device ID');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ALTER COLUMN `year_of_manufacture` SET TAGS ('dbx_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `gse_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Deployment ID');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment ID');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `gse_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Equipment (GSE) Asset ID');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee ID');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround ID');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `actual_deployment_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Deployment End Time');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `actual_deployment_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Deployment Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `cdm_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Message Reference');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `cost_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Code');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `defect_noted_flag` SET TAGS ('dbx_business_glossary_term' = 'Defect Noted Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `delay_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `delay_reason` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `deployment_location` SET TAGS ('dbx_business_glossary_term' = 'Deployment Location');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `dispatch_time` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Time');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `electricity_consumed_kwh` SET TAGS ('dbx_business_glossary_term' = 'Electricity Consumed (Kilowatt-Hours)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `fuel_consumed_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (Liters)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `idle_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Idle Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `operator_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Number');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `planned_deployment_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Deployment End Time');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `planned_deployment_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Deployment Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|critical');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `return_time` SET TAGS ('dbx_business_glossary_term' = 'Return Time');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `safety_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Description');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `service_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Code');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `utilization_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Utilization Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` SET TAGS ('dbx_subdomain' = 'passenger_processing');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_session_id` SET TAGS ('dbx_business_glossary_term' = 'Check-In Session Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_counter_id` SET TAGS ('dbx_business_glossary_term' = 'Checkin Counter Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Check-In Agent Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `advance_checkin_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Check-In Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `apis_data_transmitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Passenger Information System (APIS) Data Transmitted Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `baggage_tag_numbers` SET TAGS ('dbx_business_glossary_term' = 'Baggage Tag Numbers');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `bags_checked_count` SET TAGS ('dbx_business_glossary_term' = 'Bags Checked Count');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `boarding_pass_barcode` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Barcode');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `boarding_pass_barcode` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `boarding_pass_barcode` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `boarding_pass_issuance_method` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Issuance Method');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `boarding_pass_issuance_method` SET TAGS ('dbx_value_regex' = 'paper|mobile|email|sms|kiosk_print');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_channel` SET TAGS ('dbx_business_glossary_term' = 'Check-In Channel');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_channel` SET TAGS ('dbx_value_regex' = 'counter|kiosk|cuss|web|mobile|agent_assisted');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In End Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_language_code` SET TAGS ('dbx_business_glossary_term' = 'Check-In Language Code');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Check-In Sequence Number');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Start Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_status` SET TAGS ('dbx_business_glossary_term' = 'Check-In Status');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `checkin_status` SET TAGS ('dbx_value_regex' = 'completed|incomplete|cancelled|no_show');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `excess_baggage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Excess Baggage Charge Amount');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `excess_baggage_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Excess Baggage Charge Currency');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `excess_baggage_charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `excess_baggage_flag` SET TAGS ('dbx_business_glossary_term' = 'Excess Baggage Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `group_checkin_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Check-In Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `infant_accompanying_flag` SET TAGS ('dbx_business_glossary_term' = 'Infant Accompanying Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `pnr_reference` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Reference');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `pnr_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `priority_boarding_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Boarding Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `seat_assigned` SET TAGS ('dbx_business_glossary_term' = 'Seat Assigned at Check-In');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `seat_assigned` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}[A-K]$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `special_service_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Service Requests (SSR) Processed');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `standby_status` SET TAGS ('dbx_business_glossary_term' = 'Standby Status');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `standby_status` SET TAGS ('dbx_value_regex' = 'confirmed|standby|waitlisted');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `travel_document_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Document Verified Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ALTER COLUMN `upgrade_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Processed Flag');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` SET TAGS ('dbx_subdomain' = 'passenger_processing');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_event_id` SET TAGS ('dbx_business_glossary_term' = 'Boarding Event ID');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Agent ID');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment ID');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Boarding Action Taken');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_door_used` SET TAGS ('dbx_business_glossary_term' = 'Boarding Door Used');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_door_used` SET TAGS ('dbx_value_regex' = '^(door_[1-9]|jetbridge|remote_stairs|bus_gate)$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_method` SET TAGS ('dbx_business_glossary_term' = 'Boarding Method');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_method` SET TAGS ('dbx_value_regex' = 'automated_gate|agent_scan|manual_entry|mobile_scan|biometric');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_pass_barcode` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Barcode');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_pass_barcode` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_pass_barcode` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Boarding Sequence Number');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_zone` SET TAGS ('dbx_business_glossary_term' = 'Boarding Zone');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `boarding_zone` SET TAGS ('dbx_value_regex' = '^(zone_[1-9]|priority|general|first_class|business|premium_economy|economy)$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `carry_on_baggage_count` SET TAGS ('dbx_business_glossary_term' = 'Carry-On Baggage Count');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `checked_baggage_count` SET TAGS ('dbx_business_glossary_term' = 'Checked Baggage Count');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `coupon_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Coupon Sequence Number');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `frequent_flyer_tier` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Tier');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `frequent_flyer_tier` SET TAGS ('dbx_value_regex' = 'basic|silver|gold|platinum|diamond');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `gate_reader_device_code` SET TAGS ('dbx_business_glossary_term' = 'Gate Reader Device ID');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `gate_reader_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `gate_reader_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `irregular_operation_flag` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operation (IROP) Flag');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `irregular_operation_reason` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operation Reason');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `is_codeshare_passenger` SET TAGS ('dbx_business_glossary_term' = 'Is Codeshare Passenger Flag');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `is_interline_passenger` SET TAGS ('dbx_business_glossary_term' = 'Is Interline Passenger Flag');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `is_standby_passenger` SET TAGS ('dbx_business_glossary_term' = 'Is Standby Passenger Flag');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `is_upgrade_passenger` SET TAGS ('dbx_business_glossary_term' = 'Is Upgrade Passenger Flag');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `scan_result_status` SET TAGS ('dbx_business_glossary_term' = 'Scan Result Status');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `scan_result_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|duplicate|offload|gate_no_show|standby_cleared');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scan Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `seat_number` SET TAGS ('dbx_business_glossary_term' = 'Seat Number');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `seat_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}[A-K]$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Status');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|secondary_screening');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `special_service_request_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Codes');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Ticket (E-Ticket) Number');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `ticket_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ALTER COLUMN `ticket_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` SET TAGS ('dbx_subdomain' = 'passenger_processing');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `baggage_item_id` SET TAGS ('dbx_business_glossary_term' = 'Baggage Item Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `bag_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Bag Tag Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `bag_tag_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `bag_type` SET TAGS ('dbx_business_glossary_term' = 'Baggage Type');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `current_location_station_code` SET TAGS ('dbx_business_glossary_term' = 'Current Location Station Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `current_location_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `current_status` SET TAGS ('dbx_business_glossary_term' = 'Current Baggage Status');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `excess_baggage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Excess Baggage Charge Amount');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `excess_baggage_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Excess Baggage Charge Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `excess_baggage_charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `final_destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Final Destination Station Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `final_destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (cm)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `interline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interline Indicator');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `last_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Scan Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (cm)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `mishandling_code` SET TAGS ('dbx_business_glossary_term' = 'Mishandling Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `mishandling_code` SET TAGS ('dbx_value_regex' = 'none|delayed|damaged|pilfered|lost|destroyed');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `mishandling_report_number` SET TAGS ('dbx_business_glossary_term' = 'Mishandling Report Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `pnr` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `pnr` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `pnr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `pnr` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `priority_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Handling Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `priority_handling_code` SET TAGS ('dbx_value_regex' = 'none|rush|priority|vip|crew|transfer');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `routing_sequence` SET TAGS ('dbx_business_glossary_term' = 'Routing Sequence');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Status');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_value_regex' = 'not_screened|cleared|flagged|manual_inspection|rejected');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `security_screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `special_service_request_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Codes');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `uld_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (kg)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (cm)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` SET TAGS ('dbx_subdomain' = 'passenger_processing');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `baggage_scan_id` SET TAGS ('dbx_business_glossary_term' = 'Baggage Scan Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `baggage_item_id` SET TAGS ('dbx_business_glossary_term' = 'Baggage Item Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `actual_connect_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Connect Time in Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `bag_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Bag Tag Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `bag_tag_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `baggage_type` SET TAGS ('dbx_business_glossary_term' = 'Baggage Type');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `baggage_type` SET TAGS ('dbx_value_regex' = 'checked|transfer|rush|priority|special|oversized');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `baggage_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Baggage Weight in Kilograms (kg)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `cdm_message_type` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Message Type');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `conveyor_belt_code` SET TAGS ('dbx_business_glossary_term' = 'Conveyor Belt Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `customs_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Status');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `customs_status` SET TAGS ('dbx_value_regex' = 'cleared|inspection_required|hold|released');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `iata_753_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'IATA Resolution 753 Compliance Flag');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `makeup_position` SET TAGS ('dbx_business_glossary_term' = 'Makeup Position');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `minimum_connect_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Connect Time (MCT) in Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `passenger_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `passenger_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `passenger_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_data_source` SET TAGS ('dbx_business_glossary_term' = 'Scan Data Source');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_data_source` SET TAGS ('dbx_value_regex' = 'automated_scanner|handheld_device|manual_entry|mobile_app|kiosk');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_device_code` SET TAGS ('dbx_business_glossary_term' = 'Scan Device Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_point_type` SET TAGS ('dbx_business_glossary_term' = 'Scan Point Type');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_point_type` SET TAGS ('dbx_value_regex' = 'check-in|bhs_sortation|makeup_area|aircraft_hold|reclaim_belt|transfer_area');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_result_status` SET TAGS ('dbx_business_glossary_term' = 'Scan Result Status');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_result_status` SET TAGS ('dbx_value_regex' = 'successful_read|no_read|manual_entry|duplicate_scan|damaged_tag');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Scan Sequence Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scan Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Status');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `security_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|hold|rejected');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `sortation_decision` SET TAGS ('dbx_business_glossary_term' = 'Sortation Decision');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `sortation_decision` SET TAGS ('dbx_value_regex' = 'to_flight|to_transfer|to_storage|to_reclaim|to_manual_handling|rejected');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `special_service_request_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `transfer_connection_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Connection Flag');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ALTER COLUMN `uld_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` SET TAGS ('dbx_subdomain' = 'passenger_processing');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `baggage_irregularity_id` SET TAGS ('dbx_business_glossary_term' = 'Baggage Irregularity Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `baggage_item_id` SET TAGS ('dbx_business_glossary_term' = 'Baggage Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handler Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Report Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `bag_color` SET TAGS ('dbx_business_glossary_term' = 'Bag Color');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `bag_description` SET TAGS ('dbx_business_glossary_term' = 'Bag Description');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `bag_type` SET TAGS ('dbx_business_glossary_term' = 'Bag Type');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `bag_type` SET TAGS ('dbx_value_regex' = 'suitcase|duffel|backpack|garment_bag|sports_equipment|other');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `contents_description` SET TAGS ('dbx_business_glossary_term' = 'Contents Description');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `dot_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Reportable Flag');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `forwarding_instructions` SET TAGS ('dbx_business_glossary_term' = 'Forwarding Instructions');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `forwarding_station_code` SET TAGS ('dbx_business_glossary_term' = 'Forwarding Station Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `forwarding_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `handling_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Carrier Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `handling_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `interim_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Interim Expense Amount');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `irregularity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Irregularity Type Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `irregularity_type_description` SET TAGS ('dbx_business_glossary_term' = 'Irregularity Type Description');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `last_known_location_code` SET TAGS ('dbx_business_glossary_term' = 'Last Known Location Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `last_known_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `last_known_location_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Known Location Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Amount');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Liability Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `located_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Located Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `pir_number` SET TAGS ('dbx_business_glossary_term' = 'Property Irregularity Report (PIR) Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `pir_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[A-Z0-9]{7,10}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `recovery_status_code` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `recovery_status_code` SET TAGS ('dbx_value_regex' = 'OP|LO|FD|DL|CL');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `recovery_status_description` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status Description');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `responsible_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Carrier Code');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `responsible_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `worldtracer_reference` SET TAGS ('dbx_business_glossary_term' = 'WorldTracer Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ALTER COLUMN `worldtracer_reference` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `ramp_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ramp Service Order Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `actual_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `baggage_handling_required` SET TAGS ('dbx_business_glossary_term' = 'Baggage Handling Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `cargo_handling_required` SET TAGS ('dbx_business_glossary_term' = 'Cargo Handling Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `catering_service_required` SET TAGS ('dbx_business_glossary_term' = 'Catering Service Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `cdm_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Message Reference');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `cleaning_service_required` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Service Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Status');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed_on_time|completed_delayed|partially_completed|not_completed|waived');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `deicing_service_required` SET TAGS ('dbx_business_glossary_term' = 'De-icing Service Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `flight_operation_type` SET TAGS ('dbx_business_glossary_term' = 'Flight Operation Type');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `flight_operation_type` SET TAGS ('dbx_value_regex' = 'arrival|departure|turnaround|overnight|maintenance');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `fueling_service_required` SET TAGS ('dbx_business_glossary_term' = 'Fueling Service Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `ground_handler_acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Acknowledgement Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `ground_power_required` SET TAGS ('dbx_business_glossary_term' = 'Ground Power Unit (GPU) Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `lavatory_service_required` SET TAGS ('dbx_business_glossary_term' = 'Lavatory Service Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `order_issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Issued Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Service Order Priority');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|critical');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Service Order Status');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `passenger_handling_required` SET TAGS ('dbx_business_glossary_term' = 'Passenger (Pax) Handling Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `potable_water_service_required` SET TAGS ('dbx_business_glossary_term' = 'Potable Water Service Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `preconditioned_air_required` SET TAGS ('dbx_business_glossary_term' = 'Preconditioned Air Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `pushback_towing_required` SET TAGS ('dbx_business_glossary_term' = 'Pushback and Towing Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `scheduled_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Time');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `scheduled_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Time');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Deviation Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Service Deviation Notes');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Ramp Service Order Number');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_order_number` SET TAGS ('dbx_value_regex' = '^RSO[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_order_type` SET TAGS ('dbx_business_glossary_term' = 'Service Order Type');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_order_type` SET TAGS ('dbx_value_regex' = 'standard|special|irop|charter|vip|cargo_only');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window End Time');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `service_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `sla_target_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ALTER COLUMN `special_service_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Service Instructions');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `deicing_event_id` SET TAGS ('dbx_business_glossary_term' = 'De-icing Event ID');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `deicing_crew_id` SET TAGS ('dbx_business_glossary_term' = 'De-icing Crew ID');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `deicing_location_type` SET TAGS ('dbx_business_glossary_term' = 'De-icing Location Type');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `deicing_location_type` SET TAGS ('dbx_value_regex' = 'pad|gate|remote_stand|runway_holding_area');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `deicing_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'De-icing Vendor Code');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `environmental_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Reporting Flag');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `equipment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_concentration_primary_percent` SET TAGS ('dbx_business_glossary_term' = 'Primary Fluid Concentration (Percent)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_concentration_secondary_percent` SET TAGS ('dbx_business_glossary_term' = 'Secondary Fluid Concentration (Percent)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_cost_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Fluid Cost Total Amount');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_cost_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_type_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Fluid Type');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_type_primary` SET TAGS ('dbx_value_regex' = 'type_i|type_ii|type_iii|type_iv');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_type_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Fluid Type');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_type_secondary` SET TAGS ('dbx_value_regex' = 'type_i|type_ii|type_iii|type_iv');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_volume_primary_liters` SET TAGS ('dbx_business_glossary_term' = 'Primary Fluid Volume (Liters)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `fluid_volume_secondary_liters` SET TAGS ('dbx_business_glossary_term' = 'Secondary Fluid Volume (Liters)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `holdover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Holdover Time (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `inspection_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Inspection Performed By');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `outside_air_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Outside Air Temperature (Celsius)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `post_treatment_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Post-Treatment Inspection Result');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `post_treatment_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_performed');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `post_treatment_inspection_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `post_treatment_inspection_result` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `precipitation_intensity` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Intensity');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `precipitation_intensity` SET TAGS ('dbx_value_regex' = 'none|light|moderate|heavy');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `precipitation_type` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Type');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Treatment End Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_end_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_end_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Reason Code');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_reason_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_reason_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Treatment Start Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_start_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_start_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Status');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|aborted|failed|rework_required');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Type');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `visibility_meters` SET TAGS ('dbx_business_glossary_term' = 'Visibility (Meters)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ALTER COLUMN `wind_speed_knots` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Knots)');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` SET TAGS ('dbx_subdomain' = 'passenger_processing');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `pfc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Facility Charge (PFC) Record Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `original_pfc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Original PFC Record Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `airport_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Airport Authority Name');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `airport_code` SET TAGS ('dbx_business_glossary_term' = 'Airport Code');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `arc_report_period` SET TAGS ('dbx_business_glossary_term' = 'Airlines Reporting Corporation (ARC) Report Period');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `arc_report_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `bsp_period` SET TAGS ('dbx_business_glossary_term' = 'Billing and Settlement Plan (BSP) Period');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `bsp_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `collecting_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Collecting Carrier Code');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `collecting_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'PFC Collection Date');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'PFC Collection Status');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'collected|remitted|adjusted|refunded|pending|voided');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `coupon_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon Sequence Number');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `dot_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Reporting Flag');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `exemption_code` SET TAGS ('dbx_business_glossary_term' = 'PFC Exemption Code');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'PFC Exemption Reason Description');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `pfc_amount` SET TAGS ('dbx_business_glossary_term' = 'Passenger Facility Charge (PFC) Amount');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale Country Code');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'PFC Refund Amount');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'PFC Refund Date');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `remittance_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Batch Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'GDS|airline_direct|OTA|travel_agent|corporate|call_center');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'ARC|BSP|direct|interline');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Ticket Number');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `ticket_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `ticket_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ALTER COLUMN `travel_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Date');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `aircraft_damage_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Damage Incident Count');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `average_baggage_delivery_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Baggage Delivery Time in Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `baggage_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Baggage Handling Service Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `baggage_mishandling_rate_per_1000` SET TAGS ('dbx_business_glossary_term' = 'Baggage Mishandling Rate per 1000 Passengers');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `cargo_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Handling Service Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `catering_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Catering Handling Service Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `contracted_stations` SET TAGS ('dbx_business_glossary_term' = 'Contracted Station Codes');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `fuel_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Handling Service Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `handler_name` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Legal Name');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `handler_type` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Type');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `handler_type` SET TAGS ('dbx_value_regex' = 'third_party|airline_self_handling|airport_authority|hybrid');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `iata_ground_handler_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Ground Handler Code');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `iata_ground_handler_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,4}$');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Policy Number');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `isago_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'IATA Safety Audit for Ground Operations (ISAGO) Certification Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `isago_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'IATA Safety Audit for Ground Operations (ISAGO) Certified Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `license_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'License Issuing Authority');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler License Number');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `on_time_departure_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Departure Contribution Percentage');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|pending_approval|terminated');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `passenger_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Handling Service Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `penalty_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Triggered Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier Classification');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|probationary');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Operational Contact Email Address');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Operational Contact Name');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Operational Contact Phone Number');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `ramp_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Ramp Handling Service Flag');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `sgha_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Ground Handling Agreement (SGHA) Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `sgha_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ALTER COLUMN `sla_breach_count` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Count');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `handling_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Performance ID');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `ramp_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ramp Service Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround ID');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `airline_remarks` SET TAGS ('dbx_business_glossary_term' = 'Airline Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `baggage_delivery_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Baggage Delivery Target Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `baggage_delivery_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Baggage Delivery Time Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `cdm_milestone_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Milestone Compliance Flag');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `damage_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Damage Incident Count');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `damage_rate_per_turnaround` SET TAGS ('dbx_business_glossary_term' = 'Damage Rate Per Turnaround');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `delay_code_attributed` SET TAGS ('dbx_business_glossary_term' = 'Delay Code Attributed');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `delay_code_attributed` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `delay_minutes_attributed` SET TAGS ('dbx_business_glossary_term' = 'Delay Minutes Attributed');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `handler_remarks` SET TAGS ('dbx_business_glossary_term' = 'Handler Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `measurement_recorded_by` SET TAGS ('dbx_business_glossary_term' = 'Measurement Recorded By');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `mishandled_baggage_count` SET TAGS ('dbx_business_glossary_term' = 'Mishandled Baggage Count');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `no_show_bag_count` SET TAGS ('dbx_business_glossary_term' = 'No-Show Bag Count');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `on_time_departure_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Departure Contribution Flag');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `penalty_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Trigger Flag');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `safety_incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Severity');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `safety_incident_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `sla_breach_category` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Category');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `sla_breach_category` SET TAGS ('dbx_value_regex' = 'on_time_departure|baggage_delivery|damage|safety|none');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `turnaround_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Completion Status');
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ALTER COLUMN `turnaround_completion_status` SET TAGS ('dbx_value_regex' = 'completed|incomplete|aborted|delayed');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `airport_irop_event_id` SET TAGS ('dbx_business_glossary_term' = 'Airport Irregular Operations (IROP) Event Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `atc_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Restriction Type');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `cancelled_flight_count` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Flight Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `cdm_coordination_flag` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Coordination Flag');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `delayed_flight_count` SET TAGS ('dbx_business_glossary_term' = 'Delayed Flight Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `diverted_flight_count` SET TAGS ('dbx_business_glossary_term' = 'Diverted Flight Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Duration in Minutes');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `estimated_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `estimated_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `event_narrative` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Event Narrative');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `gate_reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Reassignment Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `impacted_flight_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Flight Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `impacted_pax_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Passenger (PAX) Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `irop_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) End Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `irop_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `irop_reference_number` SET TAGS ('dbx_value_regex' = '^IROP-[A-Z]{3}-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `irop_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Start Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `irop_subtype_code` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Subtype Code');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `irop_type_code` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Type Code');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `irop_type_code` SET TAGS ('dbx_value_regex' = 'WEATHER|ATC|MECHANICAL|SECURITY|CREW|AIRPORT_CLOSURE');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `lessons_learned_documented_flag` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Documented Flag');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `notam_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Notice to Air Missions (NOTAM) Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Operational Status');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|MONITORING|RECOVERING|RESOLVED|CLOSED');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `operations_control_center_code` SET TAGS ('dbx_business_glossary_term' = 'Operations Control Center (OCC) Code');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `operations_control_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `passenger_compensation_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Compensation Triggered Flag');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `passenger_compensation_triggered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `passenger_compensation_triggered_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `reaccommodation_action_count` SET TAGS ('dbx_business_glossary_term' = 'Passenger Reaccommodation Action Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `recovery_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Recovery Plan Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed Flag');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Severity Level');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'MINOR|MODERATE|MAJOR|CRITICAL');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `turnaround_delay_count` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Delay Count');
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ALTER COLUMN `weather_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Description');
ALTER TABLE `airlines_ecm`.`airport`.`station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`station` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `cargo_handling_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Handling Capable Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `cdm_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Collaborative Decision Making (CDM) Enabled Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Station Closed Date');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `customs_facility_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Facility Available Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `dangerous_goods_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Certified Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `daylight_saving_observed_flag` SET TAGS ('dbx_business_glossary_term' = 'Daylight Saving Time (DST) Observed Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `elevation_meters` SET TAGS ('dbx_business_glossary_term' = 'Elevation Meters');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `fuel_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Provider Code');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `hub_classification` SET TAGS ('dbx_business_glossary_term' = 'Hub Classification');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `hub_classification` SET TAGS ('dbx_value_regex' = 'hub|focus_city|spoke|outstation');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `iata_airport_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Airport Code');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `iata_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `icao_airport_code` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Airport Code');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `icao_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `immigration_facility_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Immigration Facility Available Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `maintenance_capability_level` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Repair and Overhaul (MRO) Capability Level');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `maintenance_capability_level` SET TAGS ('dbx_value_regex' = 'none|line|base|heavy');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Station Opened Date');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `operational_hours_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Description');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `operational_hours_type` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Type');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `operational_hours_type` SET TAGS ('dbx_value_regex' = '24x7|scheduled|seasonal');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|suspended|seasonal|closed');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `overnight_parking_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Overnight Parking Capable Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `slot_coordinated_flag` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordinated Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `slot_coordinator_code` SET TAGS ('dbx_business_glossary_term' = 'Slot Coordinator Code');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Station Name');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `airlines_ecm`.`airport`.`station` ALTER COLUMN `utc_offset_hours` SET TAGS ('dbx_business_glossary_term' = 'Coordinated Universal Time (UTC) Offset Hours');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `checkin_counter_id` SET TAGS ('dbx_business_glossary_term' = 'Check-In Counter Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `terminal_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Facility Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `assigned_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Airline Code (IATA)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `assigned_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `assigned_alliance_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Alliance Code');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `assigned_alliance_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|occupied|closed|blocked');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `average_processing_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Processing Time (Minutes)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `baggage_scale_integrated_flag` SET TAGS ('dbx_business_glossary_term' = 'Baggage Scale Integrated Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `baggage_tag_printer_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Baggage Tag Printer Available Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `biometric_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Capability Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `biometric_capability_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `biometric_capability_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `boarding_pass_printer_type` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Printer Type');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `boarding_pass_printer_type` SET TAGS ('dbx_value_regex' = 'thermal|laser|inkjet|none');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_number` SET TAGS ('dbx_business_glossary_term' = 'Counter Number');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_position_latitude` SET TAGS ('dbx_business_glossary_term' = 'Counter Position Latitude');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_position_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_position_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_position_longitude` SET TAGS ('dbx_business_glossary_term' = 'Counter Position Longitude');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_position_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_position_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_type` SET TAGS ('dbx_business_glossary_term' = 'Counter Type');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_type` SET TAGS ('dbx_value_regex' = 'full_service|self_service_kiosk|cuss|bag_drop|premium|group');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `counter_zone` SET TAGS ('dbx_business_glossary_term' = 'Counter Zone');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `cute_cupps_device_code` SET TAGS ('dbx_business_glossary_term' = 'Common Use Terminal Equipment (CUTE) / Common Use Passenger Processing System (CUPPS) Device Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `cute_cupps_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `cute_cupps_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `dcs_workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Departure Control System (DCS) Workstation Identifier (ID)');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `maximum_queue_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Queue Capacity');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `network_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Network Internet Protocol (IP) Address');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `network_ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `network_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|out_of_service|maintenance|reserved|decommissioned');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `passport_scanner_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Passport Scanner Available Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `passport_scanner_available_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `passport_scanner_available_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `payment_terminal_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Terminal Available Flag');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'common_use|dedicated|hybrid');
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ALTER COLUMN `terminal_identifier` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` SET TAGS ('dbx_association_edges' = 'maintenance.approved_maintenance_org,airport.station');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `station_mro_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Station MRO Contract ID');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Station Mro Contract - Approved Maintenance Org Id');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Mro Contract - Station Id');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `aog_support_available_flag` SET TAGS ('dbx_business_glossary_term' = 'AOG Support Available Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `performance_metrics` SET TAGS ('dbx_business_glossary_term' = 'Performance Metrics');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'SLA Terms');
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ALTER COLUMN `twenty_four_seven_coverage_flag` SET TAGS ('dbx_business_glossary_term' = '24/7 Coverage Flag');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` SET TAGS ('dbx_association_edges' = 'maintenance.certifying_staff,airport.station');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `station_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Station Authorization ID');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Station Authorization - Certifying Staff Id');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Authorization - Station Id');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `authorization_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `base_station_code` SET TAGS ('dbx_business_glossary_term' = 'Base Station Code');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `base_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `on_call_status` SET TAGS ('dbx_business_glossary_term' = 'On-Call Status');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ALTER COLUMN `station_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Station Qualification Date');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` SET TAGS ('dbx_subdomain' = 'operations_coordination');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` SET TAGS ('dbx_association_edges' = 'flight.scheduled_flight,airport.slot');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `airport_slot_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'airport_slot_allocation Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation - Scheduled Flight Id');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `slot_allocation_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation - Slot Id');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `allocated_time` SET TAGS ('dbx_business_glossary_term' = 'Allocated Time');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `historic_precedence_flag` SET TAGS ('dbx_business_glossary_term' = 'Historic Precedence Flag');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `slot_time_arrival` SET TAGS ('dbx_business_glossary_term' = 'Arrival Slot Time');
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ALTER COLUMN `slot_time_departure` SET TAGS ('dbx_business_glossary_term' = 'Departure Slot Time');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` SET TAGS ('dbx_subdomain' = 'equipment_services');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `deicing_crew_id` SET TAGS ('dbx_business_glossary_term' = 'Deicing Crew Identifier');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Home Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `relieved_deicing_crew_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`airport`.`deicing_crew` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_confidential' = 'true');
