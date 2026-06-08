-- Schema for Domain: crew | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`crew` COMMENT 'Crew scheduling, rostering, pairings, duty periods, rest requirements, crew qualifications, type ratings, recency, crew bases, deadhead positioning, crew legality checks, fatigue risk management, and crew-to-flight leg assignments. Manages flight crew, cabin crew, and crew resource allocation per FAR Part 117 and EASA FTL. Aligns with AIMS Crew Management System.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`member` (
    `member_id` BIGINT COMMENT 'Unique identifier for the crew member record. Primary key. This is the single source of truth for crew identity within the crew domain.',
    `base_id` BIGINT COMMENT 'Foreign key linking to crew.crew_base. Business justification: Normalize crew_member to reference crew_base by FK. Currently crew_member stores crew_base_code (STRING) as a denormalized reference. The crew_base table is the authoritative master for crew domicile ',
    `certifying_staff_id` BIGINT COMMENT 'Foreign key linking to maintenance.certifying_staff. Business justification: Dual-role personnel: pilots/engineers holding maintenance certifications perform sign-offs. Business process: tracking crew members authorized for maintenance release, Part-145 compliance, dual-role w',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Crew members are assigned to cost centres for payroll allocation, CASK calculation, and crew cost attribution in airline financial reporting. Fundamental to operational cost accounting and route profi',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Airlines track crew members loyalty program memberships for employee travel benefits, staff travel privileges, recognition programs, and discounted/complimentary award bookings. Standard HR-loyalty i',
    `employee_id` BIGINT COMMENT 'Reference to the workforce domain employee record which owns HR and payroll data. Links crew operational identity to corporate HR identity.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Crew members have a home station for domicile-based scheduling, regulatory rest requirements, commuting logistics, and operational planning. Essential for crew resource management and FAA/EASA complia',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Crew member licenses are issued under specific regulatory authority jurisdiction (FAA, EASA, TCCA). Essential for validating license validity, determining applicable regulations, and regulatory report',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Crew scheduling and qualification tracking require knowing each crew members primary aircraft type rating. Essential for daily crew assignment validation, reserve crew callout, and regulatory complia',
    `aims_crew_code` STRING COMMENT 'External crew identifier from the AIMS Crew Management System. Used for integration and reconciliation with the source system of record.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew member record was first created in the system.',
    `crew_category` STRING COMMENT 'Primary classification of crew member role: flight deck (pilots, first officers), cabin (flight attendants, pursers), ground operations, maintenance, dispatch, or other support roles.. Valid values are `flight_deck|cabin|ground_operations|maintenance|dispatch|other`',
    `crew_position` STRING COMMENT 'Specific job title or position within the crew category (e.g., Captain, First Officer, Senior Flight Attendant, Purser, Relief Pilot).',
    `date_of_birth` DATE COMMENT 'Crew members date of birth, used for age-related regulatory compliance, retirement planning, and medical certification tracking.',
    `date_of_hire` DATE COMMENT 'The date the crew member was originally hired by the airline, used for seniority calculations and benefit eligibility.',
    `email_address` STRING COMMENT 'Primary corporate email address for crew communications, scheduling notifications, and operational updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the crew members designated emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the crew members designated emergency contact person.',
    `employment_status` STRING COMMENT 'Current employment classification indicating the crew members contractual relationship with the airline.. Valid values are `full_time|part_time|contract|probationary|terminated`',
    `family_name` STRING COMMENT 'The crew members legal last name or surname as it appears on official documents and travel credentials.',
    `given_name` STRING COMMENT 'The crew members legal first name as it appears on official documents and travel credentials.',
    `language_proficiency_codes` STRING COMMENT 'Comma-separated list of language codes and proficiency levels (e.g., ENG:6, SPA:4) per ICAO Language Proficiency Requirements for international operations.',
    `last_line_check_date` DATE COMMENT 'Date of the crew members most recent line check or proficiency check conducted during actual flight operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew member record was last updated or modified.',
    `last_recurrent_training_date` DATE COMMENT 'Date of the crew members most recent recurrent training completion, required annually or semi-annually per regulatory requirements.',
    `license_expiry_date` DATE COMMENT 'Expiration date of the crew members aviation license or certificate, if applicable.',
    `license_number` STRING COMMENT 'Aviation license or certificate number issued by the regulatory authority (e.g., ATP certificate number, cabin crew attestation number).',
    `medical_certificate_class` STRING COMMENT 'Classification of the crew members aviation medical certificate (Class 1 for airline transport pilots, Class 2 for commercial pilots, cabin crew medical, etc.).. Valid values are `class_1|class_2|class_3|cabin_crew|none`',
    `medical_certificate_expiry_date` DATE COMMENT 'Expiration date of the crew members current aviation medical certificate, critical for maintaining operational legality.',
    `middle_name` STRING COMMENT 'The crew members middle name or initial, if applicable.',
    `mobile_phone_number` STRING COMMENT 'Primary mobile contact number for crew scheduling, irregular operations (IROP) notifications, and emergency contact.',
    `nationality_code` STRING COMMENT 'Three-letter ISO country code representing the crew members nationality, relevant for visa requirements and international operations.. Valid values are `^[A-Z]{3}$`',
    `next_recurrent_training_due_date` DATE COMMENT 'Date by which the crew member must complete their next recurrent training to maintain operational currency.',
    `operational_status` STRING COMMENT 'Current operational availability status of the crew member for flight assignments and duty scheduling. [ENUM-REF-CANDIDATE: active|inactive|on_leave|suspended|training|medical_hold|retired — 7 candidates stripped; promote to reference product]',
    `passport_expiry_date` DATE COMMENT 'Expiration date of the crew members passport, monitored to ensure compliance with six-month validity rules for international operations.',
    `passport_number` STRING COMMENT 'Crew members passport number required for international flight operations and border crossing documentation.',
    `security_clearance_expiry_date` DATE COMMENT 'Expiration date of the crew members airport security clearance or background check, required for access to secure areas.',
    `seniority_number` STRING COMMENT 'Numeric ranking representing the crew members seniority within their crew category and base, used for bidding, scheduling priority, and career progression decisions.',
    `termination_date` DATE COMMENT 'Date the crew members employment or operational status was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Brief description or code indicating the reason for employment termination (e.g., resignation, retirement, dismissal, medical).',
    `total_flight_hours` DECIMAL(18,2) COMMENT 'Cumulative total flight hours logged by the crew member across their entire career, used for experience tracking and regulatory compliance.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the crew member is a member of a labor union or collective bargaining unit.',
    CONSTRAINT pk_member PRIMARY KEY(`member_id`)
) COMMENT 'Master record for all crew personnel — flight crew (pilots, first officers) and cabin crew (flight attendants, pursers). Owns the authoritative identity, employment status, crew base assignment, crew category (flight deck vs cabin), seniority number, date of hire, AIMS crew ID, and current operational status. This is the SSOT for crew identity within the crew domain, distinct from the workforce domain employee record which owns HR/payroll data.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the crew qualification record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Qualifications are aircraft-type-specific certifications (A320 type rating, B777 PIC qualification). Core regulatory requirement - crew cannot operate aircraft without valid type-specific qualificatio',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Qualification requirements (type ratings, endorsements) may be corrective actions from safety audits or competency findings. Real business process: competency-based corrective actions and qualificatio',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each qualification (type rating, endorsement) is governed by specific regulatory authority standards. Critical for determining qualification validity periods, recency requirements, and checking compli',
    `licence_id` BIGINT COMMENT 'Foreign key linking to crew.licence. Business justification: Normalize qualification to reference licence by FK. Currently qualification stores licence_number (STRING) and licence_authority (STRING) as denormalized references. The licence table is the authorita',
    `member_id` BIGINT COMMENT 'Identifier of the crew member holding this qualification. Links to crew member master record.',
    `operational_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.operational_approval. Business justification: Specific crew qualifications enable operational approvals (ETOPS-qualified crew required for ETOPS operations, RNP-AR qualified crew for RNP-AR approaches). Direct operational dependency for flight as',
    `type_rating_id` BIGINT COMMENT 'Foreign key linking to workforce.type_rating. Business justification: Crew scheduling eligibility verification requires linking operational qualification records (crew domain) to HR compliance records of type ratings (workforce domain). When qualification_category indic',
    `check_type` STRING COMMENT 'Type of check or evaluation that resulted in this qualification: initial (first-time qualification), recurrent (periodic revalidation), upgrade (promotion to higher position), requalification (after lapse), line_check (operational line check). Null if not check-based.. Valid values are `initial|recurrent|upgrade|requalification|line_check|^$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the qualification becomes valid and the crew member is authorized to operate under this qualification.',
    `endorsement_codes` STRING COMMENT 'Comma-separated list of additional endorsements or restrictions on this qualification (e.g., ETOPS, CAT III, RNP AR, VFR only). Aligns with ICAO and FAA endorsement standards.',
    `expiry_date` DATE COMMENT 'Date on which the qualification expires and is no longer valid. Null for qualifications without expiry (e.g., permanent endorsements).',
    `flight_hours` DECIMAL(18,2) COMMENT 'Total flight hours logged under this qualification. Used for tracking experience and recency requirements.',
    `instructor_name` STRING COMMENT 'Name of the check airman or instructor who conducted the final proficiency check or issued the qualification.',
    `is_pic_qualified` BOOLEAN COMMENT 'Indicates whether this qualification authorizes the crew member to act as Pilot in Command (PIC). True if PIC-qualified, False otherwise.',
    `is_sic_qualified` BOOLEAN COMMENT 'Indicates whether this qualification authorizes the crew member to act as Second in Command (SIC). True if SIC-qualified, False otherwise.',
    `issue_date` DATE COMMENT 'Date the qualification was originally issued or granted to the crew member.',
    `landings_count` STRING COMMENT 'Total number of landings performed under this qualification. Critical for recency requirements (e.g., 3 takeoffs and landings in 90 days).',
    `last_check_date` DATE COMMENT 'Date of the most recent proficiency check, simulator check, or line check for this qualification. Used to track recency and currency.',
    `last_flight_date` DATE COMMENT 'Date of the most recent flight operated under this qualification. Used to determine recency and currency status.',
    `medical_class` STRING COMMENT 'Class of medical certificate required or held for this qualification: class_1 (airline transport pilot), class_2 (commercial pilot), class_3 (private pilot). Null for cabin crew qualifications.. Valid values are `class_1|class_2|class_3|^$`',
    `next_check_due_date` DATE COMMENT 'Date by which the next proficiency check or recurrent training must be completed to maintain qualification currency.',
    `position_code` STRING COMMENT 'Crew position this qualification authorizes: CA (Captain), FO (First Officer), SO (Second Officer), CP (Co-Pilot), FA (Flight Attendant), PS (Purser), LS (Lead Steward). Null for non-position qualifications.. Valid values are `CA|FO|SO|CP|FA|PS|LS|^$`',
    `qualification_category` STRING COMMENT 'High-level category of the qualification: type_rating (aircraft type), position_authorization (Captain, FO, Purser), endorsement (ICAO/FAA licence endorsement), recurrent_training (annual recurrency), special_qualification (ETOPS, CAT III), medical_certificate (Class 1/2 medical).. Valid values are `type_rating|position_authorization|endorsement|recurrent_training|special_qualification|medical_certificate`',
    `qualification_code` STRING COMMENT 'Standardized code representing the qualification type (e.g., B737, A320, B777, PURSER, FA). Aligns with ICAO and FAA type rating nomenclature.. Valid values are `^[A-Z0-9]{2,10}$`',
    `qualification_name` STRING COMMENT 'Full descriptive name of the qualification (e.g., Boeing 737-800 Type Rating, Airbus A320 Family Type Rating, Purser Qualification).',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification: current (valid and active), expired (past expiry date), suspended (temporarily invalid), revoked (permanently invalid), pending (awaiting approval), in_training (training in progress).. Valid values are `current|expired|suspended|revoked|pending|in_training`',
    `recency_status` STRING COMMENT 'Indicates whether the crew member meets recency requirements for this qualification: current (meets all recency rules), expiring_soon (within alert window), expired (recency lapsed), not_applicable (no recency requirement).. Valid values are `current|expiring_soon|expired|not_applicable`',
    `remarks` STRING COMMENT 'Additional free-text notes or comments about this qualification, including special circumstances, waivers, or administrative notes.',
    `restrictions` STRING COMMENT 'Free-text description of any operational restrictions or limitations on this qualification (e.g., VFR only, daylight operations only, supervised operations required).',
    `simulator_hours` DECIMAL(18,2) COMMENT 'Total simulator training hours logged for this qualification. Used for tracking training investment and proficiency.',
    `training_organization` STRING COMMENT 'Name of the training organization or flight school that provided the initial qualification training (e.g., CAE, FlightSafety International, internal airline training center).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified in the system.',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Crew qualification and type rating master records. Captures aircraft type ratings (e.g., B737, A320), position authorizations (Captain, First Officer, Purser), ICAO/FAA licence endorsements, simulator check currency, and qualification expiry dates. Tracks both flight deck type ratings and cabin crew aircraft-specific qualifications. Aligns with AIMS qualification module and FAR/EASA regulatory requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`recency_record` (
    `recency_record_id` BIGINT COMMENT 'Unique identifier for the crew recency record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Identifier of the aircraft type for which this recency record applies. Links to aircraft type master data.',
    `employee_id` BIGINT COMMENT 'The user identifier of the crew scheduling or training records staff member who last verified this recency record.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member to whom this recency record applies. Links to the crew member master data.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Recency requirements vary significantly by regulatory authority (FAA 90-day rule vs EASA 90-day rule have different specifics). The recency_requirement_reference must link to specific authority. Repla',
    `currency_status` STRING COMMENT 'The current currency status of the crew member for this recency type and aircraft type. Current=within recency period, Expired=beyond recency period, Expiring Soon=within warning threshold, Not Applicable=recency not required for this position/type combination.. Valid values are `current|expired|expiring_soon|not_applicable`',
    `effective_date` DATE COMMENT 'The date from which this recency record becomes effective and applicable for crew legality checks.',
    `grace_period_end_date` DATE COMMENT 'The end date of any regulatory or company grace period during which the crew member may still operate under supervision or restricted conditions after recency expiry.',
    `instrument_conditions_flag` BOOLEAN COMMENT 'Indicates whether this recency requirement applies to operations under Instrument Flight Rules (IFR) or in instrument meteorological conditions (IMC).',
    `last_qualifying_event_date` DATE COMMENT 'The date of the last qualifying event that satisfied this recency requirement (e.g., last takeoff, last landing, last line check, last emergency drill).',
    `last_qualifying_event_flight_number` STRING COMMENT 'The flight number or training session identifier associated with the last qualifying event.',
    `last_verification_timestamp` TIMESTAMP COMMENT 'The timestamp when this recency record was last verified or updated by crew scheduling or training records systems.',
    `line_check_required_flag` BOOLEAN COMMENT 'Indicates whether a line check (supervised flight with a check airman) is required to restore currency after expiry of this recency requirement.',
    `night_operations_flag` BOOLEAN COMMENT 'Indicates whether this recency requirement specifically applies to night operations (one hour after sunset to one hour before sunrise).',
    `notes` STRING COMMENT 'Free-text notes regarding this recency record, including any special circumstances, waivers, or deviations approved by the regulatory authority or chief pilot.',
    `passenger_carrying_flag` BOOLEAN COMMENT 'Indicates whether this recency requirement applies specifically to passenger-carrying operations (as opposed to cargo-only or ferry flights).',
    `position_code` STRING COMMENT 'The crew position for which recency applies. CA=Captain, FO=First Officer, SO=Second Officer, PU=Pilot Under Supervision, FA=Flight Attendant, CSM=Cabin Service Manager.. Valid values are `CA|FO|SO|PU|FA|CSM`',
    `qualifying_event_count` STRING COMMENT 'The number of qualifying events completed within the recency period (e.g., three takeoffs and landings in the preceding 90 days).',
    `recency_expiry_date` DATE COMMENT 'The date on which this recency requirement expires if no further qualifying events occur. Calculated as last_qualifying_event_date plus recency_period_days.',
    `recency_period_days` STRING COMMENT 'The regulatory or company-defined period (in days) within which qualifying events must occur to maintain currency (e.g., 90 days for takeoff/landing recency).',
    `recency_requirement_reference` STRING COMMENT 'The specific regulatory or company policy reference that defines this recency requirement (e.g., FAR 61.57(a), EASA FTL.3.225, Company Operations Manual Section 8.4.2).',
    `recency_type` STRING COMMENT 'The type of recency requirement being tracked. Includes takeoff, landing, instrument approach, ETOPS (Extended-range Twin-engine Operational Performance Standards), low-visibility operations, and emergency procedures drill.. Valid values are `takeoff|landing|instrument|etops|low_visibility|emergency_procedure`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this recency record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this recency record was last updated in the system.',
    `simulator_qualified_flag` BOOLEAN COMMENT 'Indicates whether this recency requirement can be satisfied using a qualified flight simulator or flight training device instead of actual aircraft operations.',
    `warning_threshold_days` STRING COMMENT 'The number of days before recency expiry when the system should issue a warning to crew scheduling and the crew member (e.g., 14 days before expiry).',
    CONSTRAINT pk_recency_record PRIMARY KEY(`recency_record_id`)
) COMMENT 'Tracks crew recency requirements and currency status per aircraft type and position. Records the last qualifying event date (e.g., last takeoff/landing, last line check, last emergency procedures drill), recency expiry date, recency type (takeoff, landing, instrument, ETOPS, low-visibility), and current currency status (current/expired). Critical for legality checks prior to flight assignment. Aligns with FAR Part 61/117 and EASA FTL recency rules.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`base` (
    `base_id` BIGINT COMMENT 'Unique identifier for the crew base. Primary key for the crew base reference master.',
    `cost_centre_id` BIGINT COMMENT 'FK to finance.cost_centre',
    `employee_id` BIGINT COMMENT 'Employee identifier for the base manager. Links to HR system for organizational hierarchy and contact information.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each crew base operates under primary regulatory authority jurisdiction determining applicable FTL rules, crew qualification requirements, and operational standards. Essential for compliance program d',
    `base_code` STRING COMMENT 'Three-letter IATA airport code representing the crew domicile base (e.g., JFK, LAX, ORD). This is the operational identifier used in crew scheduling and pairing construction.. Valid values are `^[A-Z]{3}$`',
    `base_name` STRING COMMENT 'Full descriptive name of the crew base (e.g., New York JFK Base, Los Angeles International Base). Human-readable identifier for business users.',
    `base_status` STRING COMMENT 'Current operational status of the crew base. Active = fully operational, Inactive = temporarily not staffed, Seasonal = operates during specific periods, Temporary = short-term base, Closed = permanently shut down.. Valid values are `active|inactive|seasonal|temporary|closed`',
    `base_type` STRING COMMENT 'Classification of the crew base by operational role within the network (hub = major connecting base, spoke = destination base, regional = regional operations, international = international crew base, domestic = domestic-only operations, satellite = secondary base).. Valid values are `hub|spoke|regional|international|domestic|satellite`',
    `cabin_crew_capacity` STRING COMMENT 'Authorized headcount for cabin crew (flight attendants) assigned to this base. Used for crew planning, reserve pool sizing, and capacity management.',
    `contact_email` STRING COMMENT 'Primary email address for the crew base operations office. Used for crew communication, scheduling notifications, and administrative correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the crew base operations office. Used for crew communication, scheduling coordination, and operational support.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the base location (e.g., USA, GBR, DEU). Used for regulatory compliance, labor law application, and crew work permit validation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew base record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `crew_categories_served` STRING COMMENT 'Indicates which crew categories are domiciled at this base (flight_deck_only = pilots only, cabin_crew_only = flight attendants only, both = pilots and cabin crew, all = all crew types including ground crew).. Valid values are `flight_deck_only|cabin_crew_only|both|all`',
    `crew_training_facility_available` BOOLEAN COMMENT 'Indicates whether crew training facilities (simulators, classrooms, recurrent training) are available at or near this base. Impacts crew recency management and type rating maintenance.',
    `current_cabin_crew_count` STRING COMMENT 'Current actual number of cabin crew members assigned to this base. Used to calculate staffing gaps and utilization.',
    `current_flight_deck_count` STRING COMMENT 'Current actual number of flight deck crew members assigned to this base. Used to calculate staffing gaps and utilization.',
    `deadhead_positioning_allowed` BOOLEAN COMMENT 'Indicates whether crew can be deadheaded (repositioned without revenue duty) to or from this base. Used in crew positioning decisions and irregular operations recovery.',
    `effective_date` DATE COMMENT 'Date when this crew base became operational and available for crew assignments and pairing construction. Format: yyyy-MM-dd.',
    `flight_deck_capacity` STRING COMMENT 'Authorized headcount for flight deck crew (pilots) assigned to this base. Used for crew planning, reserve pool sizing, and capacity management.',
    `ftl_regulation_applicable` STRING COMMENT 'Specific flight time limitations and rest requirements regulation applicable to crew based at this location (FAR_117 = US FAR Part 117, EASA_FTL = EASA Flight Time Limitations, CAP_371 = UK CAA Flight Time Limitations, other = jurisdiction-specific regulations).. Valid values are `FAR_117|EASA_FTL|CAP_371|other`',
    `icao_code` STRING COMMENT 'Four-letter ICAO airport code for the crew base location (e.g., KJFK, KLAX, KORD). Used for international flight operations and regulatory reporting.. Valid values are `^[A-Z]{4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew base record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or base-specific considerations relevant to crew scheduling and operations.',
    `operational_timezone` STRING COMMENT 'IANA timezone identifier for the crew base location (e.g., America/New_York, America/Los_Angeles). Used for duty period calculations, rest requirement enforcement, and fatigue risk management per FAR Part 117 and EASA FTL.',
    `pairing_start_end_base` BOOLEAN COMMENT 'Indicates whether this base is used as a start/end point for crew pairings. True = pairings are constructed to begin and end at this base, False = crew may be positioned but pairings do not originate here.',
    `physical_address` STRING COMMENT 'Full physical address of the crew base operations office or crew reporting location. Used for crew reporting instructions and facility management.',
    `reserve_pool_required` BOOLEAN COMMENT 'Indicates whether a reserve crew pool is maintained at this base for operational contingencies, irregular operations, and last-minute crew substitutions.',
    `reserve_pool_size_cabin` STRING COMMENT 'Target number of cabin crew members to maintain in reserve status at this base. Used for reserve pool sizing and crew resource allocation.',
    `reserve_pool_size_flight_deck` STRING COMMENT 'Target number of flight deck crew members to maintain in reserve status at this base. Used for reserve pool sizing and crew resource allocation.',
    `rest_facility_available` BOOLEAN COMMENT 'Indicates whether crew rest facilities are available at this base for pre-duty rest, post-duty rest, or reserve crew standby. Critical for fatigue risk management and crew legality checks.',
    `rest_facility_capacity` STRING COMMENT 'Maximum number of crew members that can be accommodated simultaneously in the base rest facilities. Used for reserve crew planning and irregular operations (IROP) management.',
    `rest_facility_type` STRING COMMENT 'Type of rest facility available at the base (hotel = contracted hotel rooms, crew_lounge = airport crew lounge, dedicated_facility = airline-owned rest facility, none = no rest facility).. Valid values are `hotel|crew_lounge|dedicated_facility|none`',
    `termination_date` DATE COMMENT 'Date when this crew base was closed or deactivated. Null for active bases. Format: yyyy-MM-dd.',
    `utc_offset_hours` DECIMAL(18,2) COMMENT 'Standard UTC offset in hours for the base location (e.g., -5.00 for EST, -8.00 for PST). Used for time zone conversions in crew scheduling and pairing construction.',
    CONSTRAINT pk_base PRIMARY KEY(`base_id`)
) COMMENT 'Reference master for crew domicile bases — the home airports from which crew are assigned, rostered, and begin/end pairings. Captures IATA/ICAO airport code, base name, crew categories served (flight deck, cabin, or both), base capacity (authorized headcount by category), base manager, operational timezone, and associated rest facilities. Used as the anchor point for pairing construction (pairings start/end at base), deadhead planning, reserve pool sizing, and crew positioning decisions. The SSOT for crew base definitions within the crew domain. Aligns with AIMS base management module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`pairing` (
    `pairing_id` BIGINT COMMENT 'Unique identifier for the crew pairing (trip or rotation). Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Pairings are constructed for specific aircraft types in crew scheduling optimization. PBS systems must match crew qualifications to pairing aircraft types. Essential for legal crew assignment and sche',
    `base_id` BIGINT COMMENT 'Reference to the crew base (domicile) where this pairing starts and ends. All pairings are round-trip from a single base.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Pairings generate crew costs allocated to cost centres for route profitability analysis, operational cost tracking, and unit cost (CASK) calculation. Essential for flight-level P&L and hub economics.',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Pairings are multi-leg crew duty sequences; operations control, crew tracking, and actual-vs-planned analysis require resolving which specific flight_leg instances comprise each pairing. This enables ',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Occurrences linked to pairings enable pattern analysis (high-risk pairings, fatigue-prone sequences). Real business process: pairing risk assessment, schedule optimization, and proactive safety manage',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Pairings originate from specific stations where crew report for duty. Critical for crew scheduling optimization, deadhead planning, and ensuring crew base alignment with operational requirements.',
    `cost` DECIMAL(18,2) COMMENT 'Estimated total cost of operating this pairing, including crew pay, per diem, hotel, transportation, and deadhead costs. Used by the pairing optimizer for cost minimization.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the pairing cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pairing record was first created in the system. Audit field for record creation tracking.',
    `crew_position` STRING COMMENT 'The crew position or role this pairing is designed for (captain, first officer, flight attendant, purser, relief pilot). Determines qualification and legality requirements.. Valid values are `captain|first_officer|flight_attendant|purser|relief_pilot`',
    `deadhead_segments` STRING COMMENT 'Count of deadhead (non-revenue positioning) segments in this pairing where crew travel as passengers to reposition for operational duty.',
    `effective_end_date` DATE COMMENT 'The last date this pairing is valid for crew assignment. End of the pairings operational window. Nullable for open-ended pairings.',
    `effective_start_date` DATE COMMENT 'The first date this pairing is valid and available for crew assignment. Start of the pairings operational window.',
    `end_datetime` TIMESTAMP COMMENT 'The scheduled date and time when the pairing ends (crew release time at base). Represents the end of the last duty period.',
    `fatigue_risk_score` DECIMAL(18,2) COMMENT 'Calculated fatigue risk score for this pairing based on duty patterns, circadian disruption, and rest opportunities. Used in Fatigue Risk Management System (FRMS). Higher scores indicate higher fatigue risk.',
    `hotel_cost` DECIMAL(18,2) COMMENT 'Estimated total hotel accommodation cost for all layovers in this pairing. Used for pairing cost calculation.',
    `international_flag` BOOLEAN COMMENT 'Indicates whether this pairing includes any international (cross-border) flight legs. True if any leg crosses international boundaries, false if all legs are domestic.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pairing record was last updated. Audit field for change tracking.',
    `legality_status` STRING COMMENT 'Indicates whether this pairing meets all regulatory crew duty and rest requirements (legal), violates regulations (illegal), is under review (pending_review), or has an approved waiver (waiver_approved).. Valid values are `legal|illegal|pending_review|waiver_approved`',
    `max_duty_period_hours` DECIMAL(18,2) COMMENT 'The longest single duty period (in hours) within this pairing. Used to verify compliance with FAR Part 117 and EASA FTL maximum duty limits.',
    `min_rest_period_hours` DECIMAL(18,2) COMMENT 'The shortest rest period (in hours) within this pairing. Must meet or exceed minimum rest requirements per FAR Part 117 and EASA FTL.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or comments about this pairing (e.g., special qualifications required, known issues, crew preferences).',
    `number_of_duty_periods` STRING COMMENT 'Total count of duty periods in this pairing. A duty period is a continuous block of work time from crew report to crew release, separated by rest periods.',
    `number_of_layovers` STRING COMMENT 'Total count of overnight layovers (rest periods away from base) in this pairing. Each layover occurs at an overnight station.',
    `number_of_legs` STRING COMMENT 'Total count of flight legs (segments) included in this pairing. Each leg is a single takeoff-to-landing flight.',
    `optimization_run_code` STRING COMMENT 'Identifier of the specific optimization run that produced this pairing. Links pairing to the batch optimization process.',
    `optimizer_version` STRING COMMENT 'Version identifier of the crew pairing optimizer software that generated this pairing. Used for audit and reproducibility.',
    `overnight_stations` STRING COMMENT 'Comma-separated list of IATA airport codes where crew have overnight layovers during this pairing (e.g., JFK,LAX,ORD). Sequence reflects pairing order.',
    `pairing_code` STRING COMMENT 'Business identifier for the pairing, externally known code used in crew scheduling and operations. Typically alphanumeric format assigned by the pairing optimizer.. Valid values are `^[A-Z0-9]{4,12}$`',
    `pairing_status` STRING COMMENT 'Current lifecycle status of the pairing: draft (under construction), published (available for assignment), assigned (crew assigned), in_progress (currently being flown), completed (finished), cancelled (no longer valid).. Valid values are `draft|published|assigned|in_progress|completed|cancelled`',
    `pairing_type` STRING COMMENT 'Classification of the pairing based on route characteristics: domestic (all legs within one country), international (crosses borders), mixed (combination), reserve (standby duty), training (instructional flights), or positioning (deadhead crew movement).. Valid values are `domestic|international|mixed|reserve|training|positioning`',
    `per_diem_amount` DECIMAL(18,2) COMMENT 'Total per diem allowance payable to crew for this pairing, covering meals and incidental expenses during layovers. Calculated per CBA rules.',
    `premium_pay_flag` BOOLEAN COMMENT 'Indicates whether this pairing qualifies for premium pay under CBA rules (e.g., due to red-eye flights, long duty periods, or undesirable layovers). True if premium pay applies.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this pairing was published and made available for crew assignment. Nullable if pairing has not yet been published.',
    `red_eye_flag` BOOLEAN COMMENT 'Indicates whether this pairing includes any red-eye (overnight) flights that operate during typical sleep hours (typically 10 PM to 6 AM). True if any leg is a red-eye flight.',
    `start_datetime` TIMESTAMP COMMENT 'The scheduled date and time when the pairing begins (crew report time at base). Represents the start of the first duty period.',
    `time_away_from_base_hours` DECIMAL(18,2) COMMENT 'Total elapsed time from pairing start to pairing end, representing how long crew are away from their base. Includes duty time, rest time, and layover time. Key quality-of-life metric.',
    `total_block_hours` DECIMAL(18,2) COMMENT 'Total flight time (block hours) accumulated across all legs in this pairing, measured from gate departure (off-blocks) to gate arrival (on-blocks). Used for crew pay and legality checks.',
    `total_credit_hours` DECIMAL(18,2) COMMENT 'Total pay credit hours for this pairing, calculated per collective bargaining agreement rules. May differ from block hours due to minimum guarantees, premiums, and duty rigs.',
    `total_duty_hours` DECIMAL(18,2) COMMENT 'Total duty time across all duty periods in this pairing, from crew report to crew release. Includes flight time, ground time, and pre/post-flight duties. Subject to FAR Part 117 and EASA FTL limits.',
    `total_rest_hours` DECIMAL(18,2) COMMENT 'Total rest time provided across all rest periods in this pairing. Must meet minimum rest requirements per FAR Part 117 and EASA FTL.',
    CONSTRAINT pk_pairing PRIMARY KEY(`pairing_id`)
) COMMENT 'A crew pairing (also called a trip or rotation) is the core operational scheduling unit — a sequence of duty periods and rest periods starting and ending at the same crew base, built during the schedule construction phase. Captures pairing code, base, effective date range, total block hours, total duty time, total credit hours, number of legs, overnight stations, and pairing cost. Pairings are the output of the crew pairing optimizer and the input to rostering. Aligns with AIMS pairing module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`duty_period` (
    `duty_period_id` BIGINT COMMENT 'Unique identifier for the duty period. Primary key.',
    `base_id` BIGINT COMMENT 'Foreign key linking to crew.crew_base. Business justification: Normalize duty_period to reference crew_base by FK. Currently duty_period stores crew_base_code (STRING) as a denormalized reference to the crews home base for the duty period. Adding crew_base_id FK',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Duty periods drive crew cost allocation for flight-level P&L, activity-based costing, and cost centre reporting. Supports detailed operational cost analysis and variance reporting against budget.',
    `member_id` BIGINT COMMENT 'Reference to the crew member assigned to this duty period.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Occurrences happen during specific duty periods. Essential for fatigue analysis, FTL investigation, and causal factor determination. Real business process: occurrence context analysis and fatigue risk',
    `pairing_id` BIGINT COMMENT 'Reference to the pairing that contains this duty period. A pairing is a sequence of duty periods and rest periods assigned to a crew member.',
    `acclimation_status` STRING COMMENT 'Indicates whether the crew member is acclimated to the local time zone at duty start. Acclimated means the crew member has been in the time zone for sufficient time per FAR Part 117 definitions. Affects maximum FDP limits.. Valid values are `acclimated|unacclimated|unknown`',
    `actual_flag` BOOLEAN COMMENT 'Indicates whether this duty period was actually operated (True) or was planned but not executed (False). Used for payroll and compliance reporting.',
    `augmented_crew_flag` BOOLEAN COMMENT 'Indicates whether this duty period involves augmented crew (additional crew members allowing in-flight rest). True if augmented, False otherwise. Affects maximum FDP limits.',
    `block_hours_minutes` STRING COMMENT 'Total block time (gate departure to gate arrival) in minutes for all flight segments within this duty period. Null for non-flight duty types.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating why the duty period was cancelled if actual_flag is False (e.g., CREW_SICK, AIRCRAFT_MAINTENANCE, WEATHER, SCHEDULE_CHANGE). Null if duty was operated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this duty period record was first created in the system.',
    `duty_end_station_code` STRING COMMENT 'Three-letter IATA airport code where the duty period ends (release location).. Valid values are `^[A-Z]{3}$`',
    `duty_period_number` STRING COMMENT 'Sequential number of this duty period within the pairing (1, 2, 3, etc.).',
    `duty_start_station_code` STRING COMMENT 'Three-letter IATA airport code where the duty period begins (report location).. Valid values are `^[A-Z]{3}$`',
    `duty_type` STRING COMMENT 'Classification of the duty period: flight duty (operating flights), ground duty (administrative/ground tasks), deadhead (crew repositioning without revenue duty), training (simulator/classroom), standby (on-call at airport), or reserve (on-call at home/hotel).. Valid values are `flight_duty|ground_duty|deadhead|training|standby|reserve`',
    `easa_ftl_compliant_flag` BOOLEAN COMMENT 'Indicates whether this duty period is compliant with EASA FTL regulations. True if compliant, False if violation detected.',
    `far_117_compliant_flag` BOOLEAN COMMENT 'Indicates whether this duty period is compliant with FAA FAR Part 117 flight and duty time limitations. True if compliant, False if violation detected.',
    `fatigue_risk_level` STRING COMMENT 'Categorical fatigue risk level derived from the fatigue risk score: low (acceptable), moderate (monitor), high (mitigate), critical (unacceptable).. Valid values are `low|moderate|high|critical`',
    `fatigue_risk_score` DECIMAL(18,2) COMMENT 'Calculated fatigue risk score for this duty period based on biomathematical fatigue models (e.g., SAFTE-FAST, Boeing Alertness Model). Higher scores indicate higher fatigue risk. Scale typically 0-100.',
    `fdp_elapsed_time_minutes` STRING COMMENT 'Total elapsed time in minutes from FDP start to FDP end. Critical for FAR Part 117 and EASA FTL maximum FDP limit checks. Null for non-flight duty types.',
    `fdp_end_time` TIMESTAMP COMMENT 'Timestamp marking the end of the flight duty period, which ends when the aircraft finally comes to rest and the engines are shut down at the last flight segment. Null for non-flight duty types.',
    `fdp_start_time` TIMESTAMP COMMENT 'Timestamp marking the start of the flight duty period, which begins when a crew member is required to report for duty with the intention of conducting a flight. Null for non-flight duty types.',
    `flight_segments_count` STRING COMMENT 'Number of flight segments (takeoff and landing cycles) operated during this duty period. Used for fatigue risk assessment. Null for non-flight duty types.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this duty period record was last modified in the system.',
    `legality_status` STRING COMMENT 'Overall legality status of the duty period considering all applicable regulations (FAR Part 117, EASA FTL, company policies). Legal means all checks passed; illegal means one or more violations detected; waiver_granted means a regulatory waiver was approved; under_review means legality is being assessed.. Valid values are `legal|illegal|waiver_granted|under_review`',
    `legality_violation_codes` STRING COMMENT 'Comma-separated list of violation codes if the duty period is illegal (e.g., MAX_FDP_EXCEEDED, INSUFFICIENT_REST, MAX_DUTY_EXCEEDED). Null if legal.',
    `release_time` TIMESTAMP COMMENT 'Timestamp when the crew member is released from duty. Marks the end of the duty period.',
    `report_time` TIMESTAMP COMMENT 'Timestamp when the crew member is required to report for duty. Marks the start of the duty period.',
    `rest_period_after_minutes` STRING COMMENT 'Duration in minutes of the rest period immediately following this duty period. Used to verify minimum rest requirements per FAR Part 117 and EASA FTL.',
    `rest_period_before_minutes` STRING COMMENT 'Duration in minutes of the rest period immediately preceding this duty period. Used to verify minimum rest requirements per FAR Part 117 and EASA FTL.',
    `scheduled_flag` BOOLEAN COMMENT 'Indicates whether this duty period was part of the original published schedule (True) or was added/modified after publication (False). Used for operational performance tracking.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this duty period record (e.g., AIMS, NetLine/Ops).',
    `split_duty_flag` BOOLEAN COMMENT 'Indicates whether this duty period qualifies as split duty (duty period interrupted by a rest opportunity). True if split duty, False otherwise. Affects FDP extension calculations.',
    `split_duty_rest_minutes` STRING COMMENT 'Duration in minutes of the rest opportunity during a split duty period. Null if not a split duty. Used to calculate FDP extensions.',
    `time_zone_crossings_count` STRING COMMENT 'Number of time zones crossed during this duty period. Used for fatigue risk and circadian disruption assessment.',
    `time_zone_end` STRING COMMENT 'IANA time zone identifier for the duty end station (e.g., Europe/London). Used for circadian rhythm and fatigue risk calculations.',
    `time_zone_start` STRING COMMENT 'IANA time zone identifier for the duty start station (e.g., America/New_York). Used for circadian rhythm and fatigue risk calculations.',
    `total_duty_elapsed_time_minutes` STRING COMMENT 'Total elapsed time in minutes from report time to release time. Used for FAR Part 117 and EASA FTL compliance calculations.',
    CONSTRAINT pk_duty_period PRIMARY KEY(`duty_period_id`)
) COMMENT 'A duty period is a continuous block of time during which a crew member is on duty, bounded by report time and release time. Belongs to a pairing. Captures report time, release time, total duty elapsed time (TDT), flight duty period (FDP) start/end, rest period before and after, duty type (flight duty, ground duty, deadhead, training), and FAR Part 117 / EASA FTL legality status. The atomic unit for fatigue risk and FTL compliance calculations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`roster` (
    `roster_id` BIGINT COMMENT 'Unique identifier for the crew roster record. Primary key.',
    `base_id` BIGINT COMMENT 'Foreign key linking to crew.crew_base. Business justification: Normalize roster to reference crew_base by FK. Currently roster stores crew_base_code (STRING) as a denormalized reference. The roster is published for a crew member at a specific base. Adding crew_ba',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Rosters represent planned crew costs allocated to cost centres for budget vs actual analysis, crew cost planning, and monthly financial close. Core to crew cost forecasting and variance analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or manager who approved this roster version, if applicable.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member to whom this roster is assigned. Links to the crew member master record.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Rosters are built for crew operating from specific stations. Essential for monthly crew scheduling, bid period management, and ensuring adequate crew coverage at each operational station.',
    `approval_status` STRING COMMENT 'Approval status of the roster by crew scheduling management or union representatives, if applicable.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster version was approved, if applicable.',
    `bid_period_month` STRING COMMENT 'The month component of the bid period for which this roster is published (1-12).',
    `bid_period_year` STRING COMMENT 'The year component of the bid period for which this roster is published (e.g., 2024).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster record was first created in the system.',
    `crew_position` STRING COMMENT 'The crew members assigned position or role for this roster period (e.g., captain, first officer, purser, flight attendant).. Valid values are `captain|first_officer|flight_engineer|purser|flight_attendant|relief_pilot`',
    `days_off_count` STRING COMMENT 'Total number of days off (rest days, leave days) scheduled in this roster period. Used for union compliance and crew rest verification.',
    `deadhead_segments_count` STRING COMMENT 'Number of deadhead positioning segments (crew repositioning flights without duty) included in this roster.',
    `effective_end_date` DATE COMMENT 'The last date of the roster period (typically the last day of the bid month).',
    `effective_start_date` DATE COMMENT 'The first date of the roster period (typically the first day of the bid month).',
    `fatigue_risk_score` DECIMAL(18,2) COMMENT 'Calculated fatigue risk score for this roster based on duty patterns, rest periods, and circadian disruption. Higher scores indicate higher fatigue risk. Used for Fatigue Risk Management System (FRMS) compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster record was last modified or updated.',
    `leave_days_count` STRING COMMENT 'Number of approved leave days (vacation, sick leave, personal leave) included in this roster period.',
    `legality_check_status` STRING COMMENT 'Result of automated legality checks against FAR Part 117, EASA FTL, and CBA rules. Passed indicates roster is compliant; failed indicates violations; warning indicates potential issues.. Valid values are `passed|failed|warning|not_checked`',
    `legality_check_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent legality check was performed on this roster.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this roster, such as special instructions, exceptions, or crew member requests.',
    `pbs_award_reference` STRING COMMENT 'Reference identifier to the PBS award or bid result that generated this roster, if applicable. Empty if roster was manually constructed or assigned outside PBS.',
    `publication_date` DATE COMMENT 'The date on which this roster version was officially published to the crew member.',
    `reserve_days_count` STRING COMMENT 'Total number of days the crew member is assigned to reserve or standby duty in this roster period.',
    `roster_source` STRING COMMENT 'The method or system by which this roster was generated. PBS indicates Preferential Bidding System; manual indicates crew scheduler assignment; optimization indicates automated optimizer; crew_request indicates crew-initiated swap or change.. Valid values are `pbs|manual|optimization|crew_request`',
    `roster_status` STRING COMMENT 'Current lifecycle status of the roster. Draft indicates preliminary assignment; published indicates official release; revised indicates changes after publication; frozen indicates locked for payroll; cancelled indicates roster voided.. Valid values are `draft|published|revised|frozen|cancelled`',
    `total_credited_block_hours` DECIMAL(18,2) COMMENT 'Total block hours (gate-to-gate flight time) credited to the crew member for this roster period. Used for pay calculation and regulatory compliance.',
    `total_duty_days` STRING COMMENT 'Total number of days in the roster period on which the crew member has assigned duty (flight, training, standby, or other duty).',
    `total_duty_hours` DECIMAL(18,2) COMMENT 'Total duty hours (time from report to release) accumulated across all duty periods in this roster. Used for FAR Part 117 and EASA FTL compliance checks.',
    `total_flight_duty_periods` STRING COMMENT 'Total number of flight duty periods (FDPs) assigned in this roster. An FDP is a continuous duty period that includes one or more flight segments.',
    `training_events_count` STRING COMMENT 'Number of training events (simulator sessions, recurrent training, line checks) scheduled in this roster period.',
    `union_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this roster complies with all applicable Collective Bargaining Agreement (CBA) rules. True indicates compliance; false indicates violations.',
    `version` STRING COMMENT 'Version number of the roster for the given bid period. Increments with each revision or republication.',
    CONSTRAINT pk_roster PRIMARY KEY(`roster_id`)
) COMMENT 'The published monthly crew roster — the assignment of pairings, training events, days off, standby duties, and leave to individual crew members for a bid period. Captures crew member, bid period (month/year), roster publication date, roster version, total credited block hours, total duty days, days off count, reserve days count, roster status (draft, published, revised, frozen), and PBS award reference (if applicable). The SSOT for what each crew member is scheduled to do in a given month. Supports roster comparison (planned vs actual), crew pay calculation inputs, and union compliance verification. Aligns with AIMS rostering module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`roster_activity` (
    `roster_activity_id` BIGINT COMMENT 'Unique identifier for the roster activity line item. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the crew scheduling manager or system user who approved the swap. Null if swap not approved or no swap occurred.',
    `pairing_id` BIGINT COMMENT 'Reference to the pairing (sequence of flight legs and duty periods) if this activity is of type pairing. Null for non-pairing activities.',
    `member_id` BIGINT COMMENT 'Reference to the crew member assigned to this roster activity.',
    `roster_id` BIGINT COMMENT 'Foreign key linking to crew.roster. Business justification: Line-to-header relationship: roster_activity is an individual activity line item within a crew roster. Each roster_activity must belong to exactly one roster (the monthly published schedule). The bid_',
    `tertiary_roster_swap_receiving_crew_member_id` BIGINT COMMENT 'Reference to the crew member who accepted or was assigned to take over this activity in a swap. Null if no swap occurred.',
    `training_course_id` BIGINT COMMENT 'Reference to the specific training course or curriculum if activity_type is training. Null for non-training activities.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg that the standby crew member was assigned to upon activation. Null if not activated or for non-standby activities.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the roster activity.. Valid values are `scheduled|completed|cancelled|swapped|pending|confirmed`',
    `activity_type` STRING COMMENT 'Type of roster activity assigned to the crew member. [ENUM-REF-CANDIDATE: pairing|training|standby|day_off|deadhead|leave|ground_duty|medical|administrative|union|vacation|sick_leave|personal_leave|jury_duty|bereavement|simulator|classroom|line_check|proficiency_check|recurrent_training|initial_training|transition_training|upgrade_training|airport_standby|home_standby|hot_standby|cold_standby|office_duty|meeting|project_work — promote to reference product]. Valid values are `pairing|training|standby|day_off|deadhead|leave`',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual end date and time when the crew member completed the activity in UTC. Null if activity has not completed or was cancelled.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual start date and time when the crew member commenced the activity in UTC. Null if activity has not started or was cancelled.',
    `block_hours` DECIMAL(18,2) COMMENT 'Total block hours (gate departure to gate arrival time) for pairing activities. Null for non-flight activities.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this roster activity record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours assigned to this activity for crew pay and scheduling purposes. Calculated based on block hours, duty hours, or contractual rules depending on activity type.',
    `deadhead_flag` BOOLEAN COMMENT 'Indicates whether this activity involves deadhead crew repositioning (crew traveling as passengers to position for a duty assignment). True for deadhead activities; false otherwise.',
    `duty_hours` DECIMAL(18,2) COMMENT 'Total duty hours for this activity, calculated from check-in to release time for pairings, or scheduled duration for other duty activities. Used for FAR Part 117 and EASA FTL compliance.',
    `fatigue_risk_score` DECIMAL(18,2) COMMENT 'Calculated fatigue risk score for this activity based on duty duration, time of day, circadian rhythm, and cumulative duty. Used for Fatigue Risk Management System (FRMS) compliance. Higher scores indicate greater fatigue risk. Null if not calculated.',
    `irop_related_flag` BOOLEAN COMMENT 'Indicates whether this roster activity was created or modified as a result of irregular operations (flight delays, cancellations, crew recovery). True if IROP-related; false for normal scheduled activities.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this roster activity record was last modified. Used for audit trail and roster change tracking.',
    `leave_type` STRING COMMENT 'Type of leave if activity_type is leave. Vacation is planned time off; sick is illness-related absence; personal is discretionary leave; medical is extended medical leave; bereavement is compassionate leave; jury_duty is civic duty. Null for non-leave activities.. Valid values are `vacation|sick|personal|medical|bereavement|jury_duty`',
    `legality_check_status` STRING COMMENT 'Result of automated crew legality check against FAR Part 117, EASA FTL, and contractual rules. Legal means activity complies with all regulations; illegal means violation detected; warning indicates potential issue; not_checked means validation pending.. Valid values are `legal|illegal|warning|not_checked`',
    `legality_violation_code` STRING COMMENT 'Code identifying the specific regulation or rule violated if legality_check_status is illegal or warning. Examples: FDP_EXCEEDED (flight duty period limit), REST_INSUFFICIENT (minimum rest not met), RECENCY_EXPIRED (currency requirement lapsed). Null if legal or not checked.',
    `roster_publish_datetime` TIMESTAMP COMMENT 'Date and time when the roster containing this activity was published to the crew member. Used to track roster stability and last-minute changes.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Scheduled end date and time of the roster activity in UTC. Represents the conclusion of the duty period, training session, standby window, or leave period.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Scheduled start date and time of the roster activity in UTC. Represents the beginning of the duty period, training session, standby window, or leave period.',
    `standby_activation_datetime` TIMESTAMP COMMENT 'Date and time when the standby crew member was activated and assigned to a flight. Null if not activated or for non-standby activities.',
    `standby_activation_status` STRING COMMENT 'Indicates whether the standby crew member was activated for a flight assignment. Not_activated means crew remained on standby; activated means crew was called out; released means standby period ended without activation. Null for non-standby activities.. Valid values are `not_activated|activated|released`',
    `standby_contact_end_time` TIMESTAMP COMMENT 'End of the contact window during which crew on standby must be reachable. Null for non-standby activities.',
    `standby_contact_start_time` TIMESTAMP COMMENT 'Start of the contact window during which crew on standby must be reachable. Null for non-standby activities.',
    `standby_type` STRING COMMENT 'Type of standby duty if activity_type is standby. Airport standby requires crew to be at the airport; home standby allows crew to remain at home; hot standby requires immediate availability; cold standby allows longer call-out time. Null for non-standby activities.. Valid values are `airport|home|hot|cold`',
    `station_code` STRING COMMENT 'Three-letter IATA airport code representing the station where the activity takes place or originates. For pairings, this is the check-in station. For standby, this is the standby location. For training, this is the training facility location.. Valid values are `^[A-Z]{3}$`',
    `swap_approval_datetime` TIMESTAMP COMMENT 'Date and time when the swap was approved. Null if swap not approved or no swap occurred.',
    `swap_approval_status` STRING COMMENT 'Approval status of the swap request. Pending indicates awaiting management approval; approved means swap is confirmed; rejected means swap was denied; cancelled means swap request was withdrawn. Null if no swap was requested.. Valid values are `pending|approved|rejected|cancelled`',
    `swap_requested_flag` BOOLEAN COMMENT 'Indicates whether this activity has been requested for swap by the assigned crew member. True if swap request is pending or approved; false otherwise.',
    `training_type` STRING COMMENT 'Type of training if activity_type is training. Simulator is flight simulator session; classroom is ground school; line_check is operational proficiency check; recurrent is periodic requalification; initial is new-hire or type-rating training. Null for non-training activities. [ENUM-REF-CANDIDATE: simulator|classroom|line_check|recurrent|initial|transition|upgrade|proficiency_check|emergency_procedures|differences_training|cbt|elearning — promote to reference product]. Valid values are `simulator|classroom|line_check|recurrent|initial`',
    CONSTRAINT pk_roster_activity PRIMARY KEY(`roster_activity_id`)
) COMMENT 'Individual activity line items within a crew roster — each row represents one scheduled activity assigned to a crew member within a bid period. Activity types include: pairing, training, standby (airport or home reserve), day off, deadhead, leave, and ground duty. Captures activity type, start/end datetime, station, pairing reference (if applicable), activity status (scheduled, completed, cancelled, swapped), credit hours, and swap metadata (requesting/receiving crew, approval status) for traded activities. For standby-type activities: additionally captures standby type (airport/home), contact window, activation status, activation time, and triggered flight assignment. Enables day-by-day crew schedule visibility, reserve pool management, roster change audit trail, and IROP crew recovery tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` (
    `flight_leg_assignment_id` BIGINT COMMENT 'Unique identifier for the flight leg assignment record. Primary key for the operational assignment of a crew member to a specific flight leg.',
    `duty_period_id` BIGINT COMMENT 'Identifier of the duty period that contains this flight leg assignment. A duty period is a continuous block of crew work time bounded by rest periods.',
    `flight_leg_id` BIGINT COMMENT 'Identifier of the flight leg to which the crew member is assigned. Links to the flight operations domain.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member assigned to this flight leg. Links to the crew member master record.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Direct link between crew assignment and occurrence for investigation. Real business process: crew involvement determination, witness identification, and assignment-specific causal factors (e.g., last-',
    `pairing_id` BIGINT COMMENT 'Identifier of the crew pairing sequence that contains this assignment. A pairing is a multi-leg duty sequence starting and ending at crew base.',
    `swap_request_id` BIGINT COMMENT 'Identifier of the crew swap request that resulted in this assignment, if applicable. Links to crew self-service swap transactions.',
    `actual_checkin_time` TIMESTAMP COMMENT 'The actual time the crew member checked in for duty, as recorded by crew tracking systems or airport operations.',
    `assignment_cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment was cancelled, if applicable.',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment record was first created in the crew management system.',
    `assignment_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment record was last modified.',
    `assignment_source` STRING COMMENT 'Origin of the assignment. Roster=planned schedule, Reserve=standby callout, Swap=crew trade, Voluntary=open-time pickup, IROP=irregular operations recovery, Manual=dispatcher override.. Valid values are `roster|reserve|swap|voluntary|irop_recovery|manual`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the crew assignment. Tracks progression from initial roster through completion or cancellation. [ENUM-REF-CANDIDATE: rostered|confirmed|checked_in|boarded|completed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `assignment_type` STRING COMMENT 'Discriminator indicating whether this is an operating crew assignment (crew member performs duty) or deadhead positioning (crew member travels as passenger for repositioning).. Valid values are `operating|deadhead`',
    `augmented_crew_flag` BOOLEAN COMMENT 'Indicates whether this assignment is part of an augmented crew configuration for extended-range or long-haul operations requiring additional crew for rest rotation.',
    `cancellation_reason` STRING COMMENT 'Business reason for assignment cancellation (e.g., flight cancelled, crew illness, crew swap, schedule change, IROP recovery).',
    `crew_acknowledgement_flag` BOOLEAN COMMENT 'Indicates whether the crew member has acknowledged receipt and acceptance of this assignment via crew portal or mobile app.',
    `crew_acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the crew member acknowledged the assignment.',
    `crew_position_code` STRING COMMENT 'The assigned crew position for this flight leg. CA=Captain, FO=First Officer, SO=Second Officer, CP=Cruise Pilot, FA=Flight Attendant, PS=Purser, LD=Lead Flight Attendant, GS=Galley Supervisor. Applicable for operating assignments. [ENUM-REF-CANDIDATE: CA|FO|SO|CP|FA|PS|LD|GS — 8 candidates stripped; promote to reference product]',
    `deadhead_booking_class` STRING COMMENT 'The booking class (fare class) used for deadhead crew travel. Single uppercase letter (e.g., Y, J, F). Applicable only for deadhead assignments.. Valid values are `^[A-Z]$`',
    `deadhead_reason` STRING COMMENT 'The business reason for deadhead positioning. Applicable only when assignment_type is deadhead. Pairing_start/end=crew repositioning for duty sequence, IROP_recovery=irregular operations recovery, Training=training event travel.. Valid values are `pairing_start|pairing_end|irop_recovery|training|medical|administrative`',
    `deadhead_seat_number` STRING COMMENT 'The assigned seat number for deadhead crew travel (e.g., 12A, 23F). Applicable only for deadhead assignments.. Valid values are `^[0-9]{1,3}[A-K]$`',
    `fatigue_risk_score` DECIMAL(18,2) COMMENT 'Calculated fatigue risk score for this assignment based on duty duration, time of day, rest history, and circadian factors. Used for Fatigue Risk Management System (FRMS) compliance.',
    `interline_carrier_code` STRING COMMENT 'The IATA two-character airline code of the operating carrier when deadhead travel is on another airline. Null if own_metal_flag is true.. Valid values are `^[A-Z0-9]{2}$`',
    `legality_check_status` STRING COMMENT 'Result of automated crew legality checks against flight time limitations, duty time limitations, and rest requirements per FAR Part 117 and EASA FTL regulations.. Valid values are `legal|illegal|warning|override_approved`',
    `notes` STRING COMMENT 'Free-text notes or comments related to this assignment, entered by crew schedulers or operations staff.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether assignment notification has been sent to the crew member via crew portal, mobile app, or other communication channel.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when assignment notification was sent to the crew member.',
    `override_approved_by` STRING COMMENT 'Name or identifier of the authorized person (e.g., crew scheduler, chief pilot, operations manager) who approved the override.',
    `override_reason` STRING COMMENT 'Business justification for manual override of qualification or legality checks. Required when assignment proceeds despite system warnings or illegal status.',
    `override_timestamp` TIMESTAMP COMMENT 'Date and time when the override was approved.',
    `own_metal_flag` BOOLEAN COMMENT 'Indicates whether the deadhead travel is on the airlines own aircraft (true) or on another carrier via interline agreement (false). Applicable for deadhead assignments.',
    `qualification_check_status` STRING COMMENT 'Result of automated qualification and legality checks for this assignment. Indicates whether crew member meets all type ratings, recency, and regulatory requirements for the assigned position and aircraft.. Valid values are `qualified|override_approved|waiver_granted|not_qualified`',
    `relief_crew_flag` BOOLEAN COMMENT 'Indicates whether this crew member is assigned as relief crew for in-flight rest rotation on long-haul flights.',
    `reserve_callout_time` TIMESTAMP COMMENT 'The time the reserve crew member was called out for this assignment. Applicable only when assignment_source is reserve.',
    `scheduled_checkin_time` TIMESTAMP COMMENT 'The planned time the crew member is required to check in for duty prior to the flight leg, per crew scheduling rules and regulatory requirements.',
    `scheduled_report_location` STRING COMMENT 'The designated location where the crew member is scheduled to report for duty (e.g., crew room, gate, operations center).',
    `source_system` STRING COMMENT 'The operational system that created or last updated this assignment record (e.g., AIMS, Sabre Crew, Lufthansa NetLine/Crew).',
    CONSTRAINT pk_flight_leg_assignment PRIMARY KEY(`flight_leg_assignment_id`)
) COMMENT 'The operational assignment of a specific crew member to a specific flight leg — both operating crew and deadhead (positioning) movements. For operating crew: captures assigned position (Captain, FO, Purser, FA), check-in time, actual report time, augmented crew flag, relief crew flag, and assignment source (rostered, reserve, swap, IROP recovery). For deadhead crew: captures deadhead reason (pairing start, pairing end, IROP recovery, training), booking class, and own-metal/interline indicator. The deadhead_flag discriminates between operating and positioning assignments. The SSOT for who flew (or repositioned on) which leg in what capacity. Links crew domain to flight domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`ftl_legality_check` (
    `ftl_legality_check_id` BIGINT COMMENT 'Unique identifier for the FTL legality check record. Primary key.',
    `duty_period_id` BIGINT COMMENT 'Identifier of the duty period being evaluated for legality. Nullable if check is pairing-level.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member being assessed for fitness to operate.',
    `pairing_id` BIGINT COMMENT 'Identifier of the crew pairing being evaluated. Nullable if check is duty-period-level.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each FTL legality check validates against specific regulatory requirement (FAR 117.23(b), EU 965/2012 ORO.FTL.205). Essential for audit trails, compliance reporting, and understanding which specific r',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: Failed FTL legality checks may constitute regulatory violations requiring formal reporting and corrective action. Links legality check to violation record for compliance tracking and enforcement. Opti',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the check result, waiver, or mitigation was approved by the authority. Nullable for automated pass results.',
    `approving_authority` STRING COMMENT 'Name or identifier of the authority who approved the check result, waiver, or mitigation (e.g., Crew Control Manager, Chief Pilot, Duty Manager). Nullable for automated pass results.',
    `assessment_method` STRING COMMENT 'Method used for the fitness assessment: regulatory_rule (FAR Part 117, EASA FTL rule-based check) or biomathematical_model (SAFE, FAID, FRMS model-based fatigue risk assessment).. Valid values are `regulatory_rule|biomathematical_model`',
    `check_notes` STRING COMMENT 'Free-text notes or comments regarding the legality check, including rationale for waivers, mitigation details, or special circumstances. Nullable if no additional context required.',
    `check_timestamp` TIMESTAMP COMMENT 'Date and time when the FTL legality or fatigue risk check was executed.',
    `check_trigger` STRING COMMENT 'Event or condition that triggered the legality check: pre-assignment (during rostering), pre-departure (gate check), post-duty (compliance audit), IROP extension (irregular operations duty extension request), manual audit, or scheduled review.. Valid values are `pre_assignment|pre_departure|post_duty|irop_extension|manual_audit|scheduled_review`',
    `fatigue_risk_band` STRING COMMENT 'Categorical fatigue risk band derived from the fatigue score: low, moderate, elevated, high, or critical. Nullable for regulatory rule-based checks.. Valid values are `low|moderate|elevated|high|critical`',
    `fatigue_score` DECIMAL(18,2) COMMENT 'Numeric fatigue risk score generated by the biomathematical model (e.g., SAFE effectiveness score, FAID fatigue index). Nullable for regulatory rule-based checks.',
    `fdp_actual_hours` DECIMAL(18,2) COMMENT 'Actual or projected FDP duration in hours for the duty period being evaluated.',
    `fdp_limit_hours` DECIMAL(18,2) COMMENT 'Maximum allowable FDP duration in hours per the applicable regulation, adjusted for number of sectors, time of day, and crew augmentation.',
    `fitness_result` STRING COMMENT 'Overall fitness-to-operate result: legal (crew is legal and fit), illegal (crew exceeds FTL limits), waiver_granted (regulatory waiver issued for non-compliance), or elevated_risk_accepted (biomathematical model shows elevated risk but accepted with mitigation).. Valid values are `legal|illegal|waiver_granted|elevated_risk_accepted`',
    `flight_time_28_day` DECIMAL(18,2) COMMENT 'Cumulative flight time in hours for the crew member over the preceding 28-day rolling window at the time of check.',
    `flight_time_365_day` DECIMAL(18,2) COMMENT 'Cumulative flight time in hours for the crew member over the preceding 365-day rolling window at the time of check.',
    `mitigation_applied` STRING COMMENT 'Description of any mitigation measures applied to address elevated fatigue risk or legality concerns (e.g., crew augmentation, duty period reduction, additional rest, flight reassignment). Nullable if no mitigation required.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this legality check record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this legality check record was last updated in the system.',
    `rest_compliance_status` STRING COMMENT 'Status of rest period compliance: compliant (meets minimum), non_compliant (below minimum), reduced_rest_approved (approved reduced rest per regulation), or waiver_granted (regulatory waiver issued).. Valid values are `compliant|non_compliant|reduced_rest_approved|waiver_granted`',
    `rest_period_actual_hours` DECIMAL(18,2) COMMENT 'Actual rest period in hours provided or projected before the next duty period.',
    `rest_period_required_hours` DECIMAL(18,2) COMMENT 'Minimum rest period required in hours before the next duty period per applicable regulation.',
    `system_source` STRING COMMENT 'Source system or module that generated the legality check record (e.g., AIMS Crew Management System, SAFE Model Engine, FAID Quantum, Manual Entry).',
    CONSTRAINT pk_ftl_legality_check PRIMARY KEY(`ftl_legality_check_id`)
) COMMENT 'Unified crew fitness-to-operate assessment records encompassing both regulatory FTL/FDP legality checks (FAR Part 117, EASA FTL) and biomathematical fatigue risk model assessments (SAFE, FAID, FRMS). Each record captures: check timestamp, crew member, duty period or pairing evaluated, assessment method (regulatory_rule or biomathematical_model), regulation/model applied, check trigger (pre-assignment, pre-departure, post-duty, IROP extension), cumulative flight time windows (28-day, 365-day), FDP limit and actual FDP, rest compliance status, fatigue score and risk band (for model-based), mitigations applied, approving authority, and overall fitness result (legal/illegal/waiver/elevated-risk). The SSOT for crew legality and fatigue risk audit trail. Supports SMS, FRMS (ICAO Doc 9966), and regulatory compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`training_event` (
    `training_event_id` BIGINT COMMENT 'Unique identifier for the crew training event record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Training events (simulator sessions, type rating courses, recurrent training) are aircraft-type-specific. Required for tracking qualification currency, regulatory compliance reporting, and training pr',
    `capa_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_capa. Business justification: Training events are frequently corrective actions from compliance findings (audit finding requires additional crew training, regulatory violation requires remedial training). Links training to formal ',
    `certifying_staff_id` BIGINT COMMENT 'Foreign key linking to maintenance.certifying_staff. Business justification: Maintenance certifying staff deliver technical training to flight crew on aircraft systems, MEL procedures, technical limitations. Business process: instructor qualification tracking, training deliver',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Training events are often corrective actions from safety findings, audit findings, or occurrence investigations. Real business process: safety-driven training requirements, competency remediation, and',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Training costs post to general ledger for financial reporting, audit trail, and IFRS compliance. Direct accounting integration linking operational training events to financial transactions and period ',
    `operational_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.operational_approval. Business justification: Specific training events maintain operational approvals (ETOPS training maintains ETOPS approval, CAT III training maintains low-visibility approval). Essential for tracking approval validity and sche',
    `member_id` BIGINT COMMENT 'Identifier of the crew member who participated in this training event.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Individual training events generate purchase orders for the training service. Critical for three-way match (PO-training completion-invoice), accrual accounting, cost center allocation, training spend ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Training events satisfy specific regulatory requirements (recurrent training mandates, initial qualification requirements). Critical for compliance tracking, audit evidence, and determining next due d',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Recurrent training is typically procured under multi-year framework agreements with training centers. Links training events to master contracts for compliance verification, rate validation, volume com',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Training events are significant cost items allocated to training cost centres for budget tracking, cost recovery, and regulatory compliance reporting. Essential for training cost management and financ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Training events occur at stations with training facilities (simulators, classrooms). Required for training logistics planning, crew travel arrangements, and facility capacity management. Replaces deno',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Airlines procure simulator time, type rating courses, and recurrent training from external vendors. Essential for training cost analysis, vendor performance tracking, invoice reconciliation, and regul',
    `approval_authority` STRING COMMENT 'Name or identifier of the regulatory authority or company official who approved or certified this training event.',
    `booking_reference` STRING COMMENT 'Booking or reservation reference number for the training event, used for scheduling and resource allocation.',
    `certification_number` STRING COMMENT 'Certificate or credential number issued upon successful completion of the training event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training event record was first created in the system.',
    `crew_position_code` STRING COMMENT 'Position for which the training was conducted. CA=Captain, FO=First Officer, SO=Second Officer, PU=Pilot Under Supervision, FA=Flight Attendant, CSM=Cabin Service Manager, LSM=Lead Service Manager. [ENUM-REF-CANDIDATE: CA|FO|SO|PU|FA|CSM|LSM — 7 candidates stripped; promote to reference product]',
    `instructor_name` STRING COMMENT 'Full name of the instructor or examiner who conducted the training event.',
    `is_regulatory_required` BOOLEAN COMMENT 'Flag indicating whether this training event is mandated by regulatory authority (FAA, EASA) or is voluntary/company-initiated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training event record was last updated or modified.',
    `next_due_date` DATE COMMENT 'Date by which the next recurrent training event must be completed to maintain qualification.',
    `pass_threshold_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training event, if applicable.',
    `remarks` STRING COMMENT 'Free-text remarks or notes about the training event, including instructor observations, areas for improvement, or special circumstances.',
    `scheduled_date` DATE COMMENT 'Originally scheduled date for the training event, which may differ from actual training_date if rescheduled.',
    `simulator_device_code` STRING COMMENT 'Identifier of the flight simulator or training device used for the training event. Null for non-simulator training.',
    `training_category` STRING COMMENT 'Category of training event. INITIAL=First-time qualification, RECURRENT=Periodic revalidation, UPGRADE=Promotion to higher position, TRANSITION=Change to different aircraft type, REQUALIFICATION=Return after lapse, REFRESHER=Skill maintenance.. Valid values are `INITIAL|RECURRENT|UPGRADE|TRANSITION|REQUALIFICATION|REFRESHER`',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training event, including instructor fees, simulator time, materials, and facility charges.',
    `training_cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the training cost amount.. Valid values are `^[A-Z]{3}$`',
    `training_date` DATE COMMENT 'Date on which the training event occurred or was completed.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training event in hours.',
    `training_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the training session ended.',
    `training_method` STRING COMMENT 'Method by which the training was delivered. SIMULATOR=Flight simulator session, CLASSROOM=In-person classroom, CBT=Computer-Based Training, LINE=Line operational training, PRACTICAL=Hands-on practical, ONLINE=Remote online training.. Valid values are `SIMULATOR|CLASSROOM|CBT|LINE|PRACTICAL|ONLINE`',
    `training_result_code` STRING COMMENT 'Outcome of the training event. PASS=Successfully completed, FAIL=Did not meet standards, INCOMPLETE=Not finished, PARTIAL=Partially completed, DEFERRED=Postponed, CANCELLED=Event cancelled.. Valid values are `PASS|FAIL|INCOMPLETE|PARTIAL|DEFERRED|CANCELLED`',
    `training_score` DECIMAL(18,2) COMMENT 'Numerical score or grade achieved in the training event, if applicable. Null for pass/fail only training.',
    `training_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the training session began.',
    `training_status` STRING COMMENT 'Current status of the training event in its lifecycle. SCHEDULED=Planned but not started, IN_PROGRESS=Currently underway, COMPLETED=Finished, CANCELLED=Event cancelled, NO_SHOW=Crew member did not attend.. Valid values are `SCHEDULED|IN_PROGRESS|COMPLETED|CANCELLED|NO_SHOW`',
    `training_syllabus_version` STRING COMMENT 'Version identifier of the training syllabus or curriculum used for this event.',
    `training_type_code` STRING COMMENT 'Code representing the type of training event. PC=Proficiency Check, OPC=Operator Proficiency Check, LOE=Line Operational Evaluation, EPT=Emergency Procedures Training, CRM=Crew Resource Management, ETOPS=Extended-range Twin-engine Operational Performance Standards, DG=Dangerous Goods, SEC=Security Training, GND=Ground Training, DIFF=Differences Training, RECUR=Recurrent Training. [ENUM-REF-CANDIDATE: PC|OPC|LOE|EPT|CRM|ETOPS|DG|SEC|GND|DIFF|RECUR — 11 candidates stripped; promote to reference product]',
    `validity_end_date` DATE COMMENT 'Date on which the training qualification expires and recurrent training is required.',
    `validity_start_date` DATE COMMENT 'Date from which the training qualification becomes valid.',
    CONSTRAINT pk_training_event PRIMARY KEY(`training_event_id`)
) COMMENT 'Records of crew training events including simulator checks (PC — Proficiency Check, OPC — Operator Proficiency Check, LOE — Line Operational Evaluation), line checks, emergency procedures training (EPT), CRM (Crew Resource Management), ETOPS training, dangerous goods, and security training. Captures training type, aircraft type, training date, training centre, instructor, result (pass/fail/incomplete), and next due date. The SSOT for crew training history and upcoming training requirements. Aligns with AIMS training module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`medical_certificate` (
    `medical_certificate_id` BIGINT COMMENT 'Unique identifier for the crew medical certificate record. Primary key.',
    `finding_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_finding. Business justification: Medical certificate deficiencies discovered during audits become compliance findings (expired certificates, missing examinations, invalid AME signatures). Links certificate to finding for corrective a',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Medical certificates issued under specific regulatory authority oversight (FAA designates AMEs, EASA designates AeMCs). Essential for validating certificate validity, determining examination requireme',
    `member_id` BIGINT COMMENT 'Identifier of the crew member to whom this medical certificate belongs. Links to crew member master record.',
    `certificate_class` STRING COMMENT 'ICAO medical certificate class. Class 1 for airline transport pilots and commercial pilots, Class 2 for private pilots and cabin crew, Class 3 for air traffic controllers.. Valid values are `Class 1|Class 2|Class 3`',
    `certificate_number` STRING COMMENT 'Unique certificate number issued by the Aviation Medical Examiner (AME) or Designated Aviation Medical Examiner (DAME). Official identifier for regulatory tracking.',
    `certificate_type` STRING COMMENT 'Type of medical certificate issuance. Initial for first-time, Renewal for standard periodic renewal, Revalidation for extension, Special Issuance for conditional approval with limitations or waivers.. Valid values are `Initial|Renewal|Revalidation|Special Issuance`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical certificate record was first created in the AIMS Crew Management System.',
    `document_reference_url` STRING COMMENT 'URL or file path reference to the scanned or digital copy of the physical medical certificate document stored in the document management system.',
    `examination_date` DATE COMMENT 'Date the crew member underwent the medical examination that resulted in this certificate issuance. May differ from issue date if additional review or approval was required.',
    `examination_type` STRING COMMENT 'Type of medical examination conducted. Standard for routine periodic examinations, Extended for comprehensive examinations with additional tests, Special for examinations required due to medical events or regulatory requests.. Valid values are `Standard|Extended|Special`',
    `expiry_date` DATE COMMENT 'Date the medical certificate expires. Crew member cannot operate beyond this date without a valid renewed certificate. Critical for crew legality checks.',
    `hearing_aid_required_flag` BOOLEAN COMMENT 'Indicates whether the crew member requires a hearing aid to meet hearing standards. True if hearing aid is required, False otherwise.',
    `issue_date` DATE COMMENT 'Date the medical certificate was issued by the Aviation Medical Examiner (AME) or Designated Aviation Medical Examiner (DAME).',
    `issuing_authority_license_number` STRING COMMENT 'License or designation number of the Aviation Medical Examiner (AME) or Designated Aviation Medical Examiner (DAME) who issued the certificate. Used for regulatory verification.',
    `issuing_authority_name` STRING COMMENT 'Name of the Aviation Medical Examiner (AME) or Designated Aviation Medical Examiner (DAME) who issued the certificate.',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the medical certificate was issued. Determines applicable regulatory authority (FAA, EASA, etc.).. Valid values are `^[A-Z]{3}$`',
    `limitations` STRING COMMENT 'Any operational limitations or restrictions imposed on the crew member as a condition of the medical certificate. Examples include corrective lenses required, valid only with co-pilot, daytime operations only, or specific medical monitoring requirements.',
    `next_examination_due_date` DATE COMMENT 'Date by which the crew member must undergo the next medical examination to maintain continuous medical certification. Used for proactive crew scheduling and compliance planning.',
    `remarks` STRING COMMENT 'Additional remarks, notes, or comments from the Aviation Medical Examiner (AME) or regulatory authority regarding the medical certificate. May include follow-up requirements, monitoring instructions, or clarifications.',
    `special_issuance_flag` BOOLEAN COMMENT 'Indicates whether this certificate was issued under special issuance provisions due to a medical condition that does not meet standard requirements but has been granted a waiver or authorization. True if special issuance, False for standard issuance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical certificate record was last updated in the AIMS Crew Management System. Tracks any modifications to certificate details, status changes, or verification updates.',
    `validity_status` STRING COMMENT 'Current validity status of the medical certificate. Valid indicates the certificate is active and within its validity period. Expired indicates the certificate has passed its expiry date. Suspended or Revoked indicates regulatory action. Pending indicates awaiting final approval or special issuance decision.. Valid values are `Valid|Expired|Suspended|Revoked|Pending`',
    `verification_date` DATE COMMENT 'Date the medical certificate was last verified with the issuing regulatory authority or through the AIMS Crew Management System.',
    `verification_status` STRING COMMENT 'Status of verification of the medical certificate with the issuing regulatory authority. Verified indicates the certificate has been confirmed as authentic and valid with the authority. Used for compliance audits and crew legality validation.. Valid values are `Verified|Pending Verification|Failed Verification|Not Verified`',
    `vision_corrected_flag` BOOLEAN COMMENT 'Indicates whether the crew member requires corrective lenses (glasses or contact lenses) to meet vision standards. True if corrective lenses are required, False otherwise.',
    `waivers` STRING COMMENT 'Any medical waivers or special issuance conditions granted by the regulatory authority. Indicates exceptions to standard medical requirements with documented justification.',
    CONSTRAINT pk_medical_certificate PRIMARY KEY(`medical_certificate_id`)
) COMMENT 'Crew medical certificate records tracking ICAO Class 1 (flight crew) and Class 2 (cabin crew) medical certificates. Captures certificate class, issuing authority (AME/DAME), issue date, expiry date, certificate number, any limitations or waivers, and current validity status. Critical for crew legality — a crew member cannot operate without a valid medical certificate. Aligns with FAA/EASA medical certification requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`licence` (
    `licence_id` BIGINT COMMENT 'Unique identifier for the crew aviation licence record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user (crew records administrator) who performed the licence verification.',
    `finding_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_finding. Business justification: License deficiencies discovered during audits become compliance findings (expired ratings, missing endorsements, invalid licenses). Links license to finding for corrective action tracking and audit cl',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Licenses issued by specific aviation regulatory authorities. Critical for license validation, determining applicable regulations, reciprocity agreements, and regulatory reporting. Replaces denormalize',
    `member_id` BIGINT COMMENT 'Reference to the crew member who holds this licence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this licence record was first created in the system.',
    `document_url` STRING COMMENT 'URL or file path to the scanned or electronic copy of the licence document stored in the document management system.',
    `expiry_date` DATE COMMENT 'The date on which the licence expires and is no longer valid unless renewed. Null if the licence has no expiration (lifetime validity).',
    `issue_date` DATE COMMENT 'The date on which the licence was originally issued by the regulatory authority.',
    `language_proficiency_expiry_date` DATE COMMENT 'The date on which the language proficiency endorsement expires and must be re-assessed. Null if no expiry (level 6 Expert has no expiry).',
    `language_proficiency_level` STRING COMMENT 'ICAO language proficiency rating for aviation English (or other endorsed language). Scale 1-6, where 4 (Operational) is the minimum for international operations, 6 is Expert. Per ICAO Annex 1.',
    `licence_number` STRING COMMENT 'The unique licence number issued by the regulatory authority. This is the official identifier on the physical or electronic licence document.',
    `licence_status` STRING COMMENT 'Current lifecycle status of the licence: valid (active and in good standing), expired (past expiry date), suspended (temporarily invalid), revoked (permanently cancelled), pending_renewal (renewal in process), surrendered (voluntarily returned).. Valid values are `valid|expired|suspended|revoked|pending_renewal|surrendered`',
    `licence_type` STRING COMMENT 'The category of aviation licence. ATPL (Airline Transport Pilot Licence), CPL (Commercial Pilot Licence), MPL (Multi-crew Pilot Licence), cabin crew attestation, flight engineer, or flight navigator.. Valid values are `ATPL|CPL|MPL|cabin_crew_attestation|flight_engineer|flight_navigator`',
    `medical_class` STRING COMMENT 'The class of medical certificate associated with this licence. Class 1 for ATPL/CPL, Class 2 for private pilots, Class 3 for air traffic controllers, cabin crew medical for cabin crew attestation.. Valid values are `class_1|class_2|class_3|cabin_crew_medical`',
    `medical_expiry_date` DATE COMMENT 'The date on which the associated medical certificate expires. Crew cannot exercise licence privileges without a valid medical.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this licence record.',
    `ratings_held` STRING COMMENT 'Comma-separated list of ratings and endorsements held on this licence (e.g., instrument rating, multi-engine, type ratings). This is a summary field; detailed type ratings are tracked in the qualification product.',
    `renewal_date` DATE COMMENT 'The date on which the licence was last renewed. Null if the licence has never been renewed since original issue.',
    `restrictions` STRING COMMENT 'Free-text description of any restrictions or limitations placed on the licence by the issuing authority (e.g., Valid only with corrective lenses, VFR only, Co-pilot only).',
    `revocation_date` DATE COMMENT 'The date on which the licence was permanently revoked by the issuing authority. Null if the licence has never been revoked.',
    `revocation_reason` STRING COMMENT 'Free-text description of the reason for licence revocation (e.g., serious safety violation, fraud, criminal conviction).',
    `suspension_end_date` DATE COMMENT 'The date on which a suspension of the licence is scheduled to end or was lifted. Null if currently suspended with no defined end date.',
    `suspension_reason` STRING COMMENT 'Free-text description of the reason for licence suspension (e.g., medical disqualification, regulatory violation, administrative hold).',
    `suspension_start_date` DATE COMMENT 'The date on which a suspension of the licence became effective. Null if the licence has never been suspended.',
    `total_flight_hours_at_issue` DECIMAL(18,2) COMMENT 'The total flight hours logged by the crew member at the time the licence was issued. Captured for historical record and regulatory audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this licence record was last updated in the system.',
    `verification_date` DATE COMMENT 'The date on which the licence was last verified with the issuing authority.',
    `verification_status` STRING COMMENT 'Status of the licence verification process with the issuing authority. Verified means the airline has confirmed authenticity with the regulator.. Valid values are `verified|pending_verification|verification_failed|not_verified`',
    CONSTRAINT pk_licence PRIMARY KEY(`licence_id`)
) COMMENT 'Crew aviation licence master records — ATPL (Airline Transport Pilot Licence), CPL (Commercial Pilot Licence), MPL (Multi-crew Pilot Licence), and cabin crew attestation/licence. Captures licence number, issuing authority (FAA, EASA, national CAA), licence type, issue date, ratings held, language proficiency endorsement (ICAO level), and current validity. Distinct from qualification (which tracks type ratings and currency) — this is the base legal authorisation to act as crew.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`absence` (
    `absence_id` BIGINT COMMENT 'Unique identifier for the crew absence record. Primary key.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member who is absent. Links to the crew member master record.',
    `absence_replacement_crew_member_id` BIGINT COMMENT 'Identifier of the crew member assigned to replace the absent crew member. Nullable if no replacement has been assigned yet.',
    `base_id` BIGINT COMMENT 'FK to crew.crew_base',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Absences impact crew cost allocation and trigger replacement costs charged to specific cost centres. Essential for operational cost tracking, sick leave cost analysis, and crew productivity reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the crew scheduling manager or supervisor who approved the absence request. Nullable if not yet approved or if approval is not required.',
    `medical_certificate_id` BIGINT COMMENT 'Foreign key linking to crew.medical_certificate. Business justification: Normalize crew_absence to reference medical_certificate by FK. Currently crew_absence stores medical_certificate_reference (STRING), medical_certificate_issued_date, and medical_certificate_expiry_dat',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Crew absences due to safety events (injuries, fatigue, medical issues from incidents) must be linked to the safety occurrence for SMS tracking and trend analysis. This FK enables correlation of crew a',
    `previous_absence_id` BIGINT COMMENT 'Identifier of the previous absence record if this absence is a recurrence or continuation. Nullable if this is the first occurrence.',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: Crew absences may result from or trigger regulatory violations (duty time violations requiring mandatory rest, medical certificate suspension). Links absence to formal violation record for compliance ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Absences are reported and managed at crews assigned station for operational impact assessment, replacement crew sourcing, and station-level crew availability tracking. Critical for daily operations c',
    `absence_status` STRING COMMENT 'Current lifecycle status of the absence record: pending approval, approved, rejected, active (ongoing), completed, or cancelled.. Valid values are `pending|approved|rejected|active|completed|cancelled`',
    `absence_type` STRING COMMENT 'Classification of the absence reason: sick leave, maternity/paternity leave, compassionate leave, suspension, administrative leave, or unplanned absence. [ENUM-REF-CANDIDATE: sick_leave|maternity_leave|paternity_leave|compassionate_leave|suspension|administrative_leave|unplanned_absence — 7 candidates stripped; promote to reference product]',
    `affected_duty_periods_count` STRING COMMENT 'The number of scheduled duty periods impacted by this absence, requiring roster adjustments or crew reassignments.',
    `affected_flight_legs_count` STRING COMMENT 'The number of individual flight legs that the absent crew member was originally scheduled to operate, now requiring coverage.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the absence was approved by the authorized personnel. Nullable if not yet approved.',
    `clearance_authority` STRING COMMENT 'The name or identifier of the medical examiner, HR officer, or other authority who issued the return-to-duty clearance.',
    `collective_agreement_reference` STRING COMMENT 'Reference to the specific clause or section of the collective bargaining agreement that governs this type of absence (e.g., sick leave policy, maternity leave entitlement).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this absence record was first created in the system.',
    `crew_position` STRING COMMENT 'The operational position or role of the absent crew member: captain, first officer, flight engineer, purser, flight attendant, or cabin crew.. Valid values are `captain|first_officer|flight_engineer|purser|flight_attendant|cabin_crew`',
    `duration_days` STRING COMMENT 'Total number of calendar days the crew member is absent, calculated from start date to end date inclusive.',
    `end_date` DATE COMMENT 'The date when the crew absence period ends. Nullable for open-ended absences.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this absence record was last updated or modified.',
    `notification_method` STRING COMMENT 'The channel through which the absence was reported: phone, email, mobile app, in-person, crew portal, or third-party notification.. Valid values are `phone|email|mobile_app|in_person|crew_portal|third_party`',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the crew member or representative notified the airline of the absence.',
    `pay_status` STRING COMMENT 'Indicates whether the crew member receives full pay, no pay, or partial pay during the absence period, as per company policy and collective agreement.. Valid values are `paid|unpaid|partial_pay`',
    `reason_notes` STRING COMMENT 'Free-text notes providing additional context or details about the reason for the absence. May contain sensitive personal information.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this absence is a recurrence of a previous absence for the same or related reason. True if recurrent, False otherwise. Used for absence pattern monitoring.',
    `replacement_required_flag` BOOLEAN COMMENT 'Indicates whether a replacement crew member is required to cover the absent crew members scheduled duties. True if replacement is needed, False otherwise.',
    `return_to_duty_clearance_flag` BOOLEAN COMMENT 'Indicates whether the crew member has received medical or administrative clearance to return to duty. True if cleared, False otherwise.',
    `return_to_duty_date` DATE COMMENT 'The actual date when the crew member returned to active duty following the absence. Nullable if the crew member has not yet returned.',
    `start_date` DATE COMMENT 'The date when the crew absence period begins.',
    CONSTRAINT pk_absence PRIMARY KEY(`absence_id`)
) COMMENT 'Records of crew absences from scheduled duty — sick leave, maternity/paternity leave, compassionate leave, suspension, administrative leave, and unplanned absences. Captures absence type, start date, end date, duration, notification method, medical certificate reference (if sick), and impact on roster (replacement required flag). Used for crew availability planning, absence pattern monitoring, and collective agreement compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`bid` (
    `bid_id` BIGINT COMMENT 'Unique identifier for the crew bid submission. Primary key for the crew bid product.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Crew bid for monthly schedules on aircraft types they hold qualifications for. PBS (Preferential Bidding System) core functionality requires matching crew bids to available pairings by aircraft type. ',
    `base_id` BIGINT COMMENT 'Foreign key linking to crew.crew_base. Business justification: Normalize crew_bid to reference crew_base by FK. Currently crew_bid stores crew_base_code (STRING) as a denormalized reference. Crew bidding is base-specific (crew members bid for lines at their domic',
    `employee_id` BIGINT COMMENT 'Identifier of the crew scheduling manager or authorized user who approved the manual override. Null if no override occurred.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member who submitted this bid. Links to the crew member who is bidding for schedule preferences.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Crew bids are submitted for operations at specific stations. Essential for preferential bidding system (PBS) processing, ensuring crew preferences align with station operational needs and base assignm',
    `amended_bid_id` BIGINT COMMENT 'Self-referencing FK on bid (amended_bid_id)',
    `avoid_red_eye_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the crew member prefers to avoid red-eye flights (overnight flights departing late evening and arriving early morning). True means avoid red-eyes.',
    `award_publish_timestamp` TIMESTAMP COMMENT 'Date and time when the PBS award results were published and made available to crew members. Crew can view their awarded lines after this time.',
    `award_score` DECIMAL(18,2) COMMENT 'Numerical score calculated by PBS representing how well the awarded line matches the crew members bid preferences. Higher scores indicate better preference satisfaction.',
    `awarded_line_number` STRING COMMENT 'The line number or pairing sequence identifier awarded to the crew member by the PBS system after bid processing. Null if bid not yet awarded or if reserve status.',
    `bid_category` STRING COMMENT 'Category of the bid submission indicating the crew members operational status during the bid period. Line holder bids for regular pairings, reserve bids for standby duty, transition for crew changing status.. Valid values are `line_holder|reserve|transition|training|leave`',
    `bid_status` STRING COMMENT 'Current lifecycle status of the bid submission. Tracks the bid from initial draft through submission, closure of bidding window, PBS award processing, and final state.. Valid values are `draft|submitted|closed|awarded|cancelled|expired`',
    `collective_agreement_reference` STRING COMMENT 'Reference to the applicable collective bargaining agreement (CBA) or union contract section governing bidding rules, seniority application, and PBS parameters for this bid.',
    `commuter_friendly_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the crew member requires commuter-friendly patterns with late report times and early release times to accommodate commuting from non-base locations. True means commuter-friendly patterns preferred.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this bid record was first created in the system. Represents the initial capture of the bid in the database.',
    `crew_position` STRING COMMENT 'The crew members operational position for which this bid applies. Determines which pairing pools and line types are available for bidding.. Valid values are `captain|first_officer|flight_engineer|purser|flight_attendant|lead_flight_attendant`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this bid record was most recently updated. Tracks the latest modification to any field in the record.',
    `lines_json` STRING COMMENT 'JSON-encoded ordered preference list of pairings, days off, vacation slots, and training events. Contains the crew members ranked preferences submitted to PBS for schedule optimization.',
    `max_duty_days_constraint` STRING COMMENT 'Maximum number of duty days the crew member is willing to work in the bid period. Used by PBS to filter and rank pairing options.',
    `min_days_off_constraint` STRING COMMENT 'Minimum number of days off the crew member requests in the bid period. PBS will attempt to honor this constraint when awarding lines.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the crew member or crew scheduling regarding this bid submission. May include special requests, explanations, or operational context.',
    `override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this bid or its award was subject to manual override by crew scheduling management. True indicates an override occurred.',
    `override_reason` STRING COMMENT 'Free-text explanation of why a manual override was applied to this bid or award. Populated only when override_flag is true. Documents operational or contractual justification.',
    `pbs_processing_timestamp` TIMESTAMP COMMENT 'Date and time when the PBS system processed this bid and generated the award. Represents when the optimization algorithm ran and assigned lines to crew members.',
    `period_month` STRING COMMENT 'Month component of the bid period for which the crew member is submitting preferences (1-12).',
    `period_year` STRING COMMENT 'Year component of the bid period for which the crew member is submitting preferences (e.g., 2024).',
    `preferred_days_off` STRING COMMENT 'Comma-separated list of specific dates (YYYY-MM-DD format) or day-of-week patterns the crew member prefers as days off. Used by PBS to optimize schedule satisfaction.',
    `preferred_layover_stations` STRING COMMENT 'Comma-separated list of IATA or ICAO airport codes representing the crew members preferred layover destinations. PBS uses this to prioritize pairings with these overnight stations.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking how many times the crew member modified their bid during the open bidding window. Starts at 1 for initial submission, increments with each update.',
    `satisfaction_percentage` DECIMAL(18,2) COMMENT 'Percentage (0-100) representing the degree to which the awarded line satisfies the crew members bid preferences. Calculated by PBS based on preference weights and constraints met.',
    `seniority_number` STRING COMMENT 'The crew members seniority ranking number at the time of bid submission. Lower numbers indicate higher seniority. Used by PBS to prioritize bid awards in seniority order.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the crew member submitted their bid preferences to the Preferential Bidding System (PBS). Represents the principal business event timestamp for this transaction.',
    `training_slot_requests` STRING COMMENT 'Comma-separated list of training event identifiers or date ranges for which the crew member is requesting scheduled training slots within the bid period.',
    `vacation_request_dates` STRING COMMENT 'Comma-separated list of date ranges (start-end pairs) for which the crew member is requesting vacation time within the bid period. Subject to seniority-based approval.',
    `window_close_timestamp` TIMESTAMP COMMENT 'Date and time when the bidding window closed for this bid period. No further bid submissions or modifications are accepted after this time. PBS processing begins after closure.',
    `window_open_timestamp` TIMESTAMP COMMENT 'Date and time when the bidding window opened for this bid period. Crew members can begin submitting or modifying bids after this time.',
    CONSTRAINT pk_bid PRIMARY KEY(`bid_id`)
) COMMENT 'Crew bidding and preference submissions for Preferential Bidding System (PBS) and line-holder bid processes. Each record captures a crew members monthly bid submission including bid period (month/year), bid submission timestamp, bid lines (ordered preference list of pairings, days off, vacation, training slots), bid category (line holder, reserve, transition), bid constraints (max duty days, preferred layover stations, avoid red-eyes, commuter-friendly patterns), PBS award result (awarded line number, award score, satisfaction percentage), and bid status (draft, submitted, closed, awarded). The SSOT for crew scheduling preferences and PBS award outcomes. Aligns with AIMS PBS module and supports both seniority-based and preferential bidding workflows.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`maintenance_authorization` (
    `maintenance_authorization_id` BIGINT COMMENT 'Unique identifier for this crew maintenance authorization record. Primary key.',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to the Part-145 approved maintenance organisation where the crew member is authorized',
    `member_id` BIGINT COMMENT 'Foreign key linking to the crew member holding the maintenance authorization',
    `authorization_effective_date` DATE COMMENT 'Date when the crew members authorization to perform maintenance at this organisation became effective. Explicitly identified in detection phase relationship data.',
    `authorization_expiry_date` DATE COMMENT 'Date when the crew members authorization to perform maintenance at this organisation expires and requires renewal. Explicitly identified in detection phase relationship data.',
    `authorization_reference` STRING COMMENT 'Reference number or document identifier for the authorization certificate or approval letter issued by the organisation or regulatory authority. Explicitly identified in detection phase relationship data.',
    `authorization_scope` STRING COMMENT 'Textual description of the specific maintenance activities, aircraft types, or component categories the crew member is authorized to work on at this organisation (e.g., B737 line maintenance, engine borescope inspection, avionics troubleshooting). Explicitly identified in detection phase relationship data.',
    `authorization_status` STRING COMMENT 'Current operational status of this authorization record: active (in use), inactive (not currently used but valid), revoked (permanently cancelled), pending (awaiting approval).',
    `last_activity_date` DATE COMMENT 'Date of the crew members most recent maintenance activity performed at this organisation, used to track recency requirements and authorization currency.',
    `recency_status` STRING COMMENT 'Current status of the crew members authorization recency at this organisation: current (actively authorized), expired (authorization lapsed), suspended (temporarily revoked), pending_renewal (renewal in progress). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_maintenance_authorization PRIMARY KEY(`maintenance_authorization_id`)
) COMMENT 'This association product represents the regulatory authorization relationship between crew members holding maintenance certifications and Part-145 Approved Maintenance Organisations. It captures the authorization scope, validity periods, and recency status for crew-technicians (pilot-engineers, A&P holders) authorized to perform maintenance activities at specific AMOs. Each record links one crew member to one approved maintenance organisation with attributes that exist only in the context of this regulatory authorization relationship.. Existence Justification: In aviation operations, crew members with maintenance certifications (pilot-engineers, A&P mechanics) can hold authorizations at multiple Part-145 approved maintenance organisations simultaneously (e.g., authorized at home base maintenance, multiple line stations, and contracted MRO facilities). Conversely, each maintenance organisation authorizes multiple crew-technicians to perform work within specific scopes. The business actively manages these authorizations with validity periods, scope definitions, and recency tracking as a regulatory compliance requirement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`operational_qualification` (
    `operational_qualification_id` BIGINT COMMENT 'Unique identifier for this crew operational qualification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key to workforce.employee representing the instructor or check airman who conducted the qualifying training or check for this operational approval.',
    `member_id` BIGINT COMMENT 'Foreign key linking to the crew member who holds this operational qualification',
    `operational_approval_id` BIGINT COMMENT 'Foreign key linking to the operational approval for which the crew member is qualified',
    `approval_status` STRING COMMENT 'Current status of this crew members qualification for this operational approval. Indicates whether the crew member is currently authorized to operate under this approval.',
    `check_date` DATE COMMENT 'Date of the most recent proficiency check or line check conducted to validate the crew members competency for operations under this approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew operational qualification record was first created in the system.',
    `expiry_date` DATE COMMENT 'Date on which this crew members qualification for this operational approval expires and must be renewed. Critical for crew scheduling and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew operational qualification record was last updated or modified.',
    `qualification_date` DATE COMMENT 'Date on which the crew member was initially qualified or authorized to operate under this operational approval. Represents successful completion of required training and checks.',
    `remarks` STRING COMMENT 'Free-text field for additional notes regarding this crew members qualification for this operational approval, including any restrictions, conditions, or special circumstances.',
    `training_completion_date` DATE COMMENT 'Date on which the crew member completed the specific training required for this operational approval (e.g., ETOPS training, CAT III training, RNP-AR training).',
    `training_device_used` STRING COMMENT 'Identifier of the simulator or training device used for qualification training (e.g., SIM-001, FTD-B737-02), if applicable to this operational approval.',
    CONSTRAINT pk_operational_qualification PRIMARY KEY(`operational_qualification_id`)
) COMMENT 'This association product represents the qualification relationship between crew members and operational approvals. It captures the specific authorization of individual crew members to operate under particular operational approvals (ETOPS, CAT II/III, RNP-AR, RVSM, etc.). Each record links one crew member to one operational approval with qualification-specific attributes including qualification date, expiry, training completion, check dates, and approval status that exist only in the context of this crew-approval relationship.. Existence Justification: In airline operations, crew members must hold specific operational qualifications to operate flights under various regulatory approvals (ETOPS, CAT II/III, RNP-AR, RVSM, etc.). A single crew member typically holds multiple operational approvals (e.g., a captain may be ETOPS-qualified, CAT III-qualified, and RNP-AR qualified), and each operational approval is held by multiple crew members across the airlines crew base. The airline actively manages these qualifications through training programs, proficiency checks, and expiry tracking to ensure regulatory compliance and operational capability.';

CREATE OR REPLACE TABLE `airlines_ecm`.`crew`.`swap_request` (
    `swap_request_id` BIGINT COMMENT 'Primary key for swap_request',
    `employee_id` BIGINT COMMENT 'Identifier of the crew scheduler or manager who approved or rejected the swap request.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member initiating the swap request.',
    `pairing_id` BIGINT COMMENT 'Identifier of the pairing that the requesting crew member wants to swap away from.',
    `target_crew_member_id` BIGINT COMMENT 'Identifier of the crew member being asked to swap assignments.',
    `target_pairing_id` BIGINT COMMENT 'Identifier of the pairing that the requesting crew member wants to swap into.',
    `counterpart_swap_request_id` BIGINT COMMENT 'Self-referencing FK on swap_request (counterpart_swap_request_id)',
    `approval_notes` STRING COMMENT 'Comments or notes provided by the approver regarding the decision.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the swap request was approved by crew scheduling or management.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the swap was fully executed and assignments updated in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the swap request record was first created in the system.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time after which the swap request is no longer valid if not acted upon.',
    `fatigue_risk_score` DECIMAL(18,2) COMMENT 'Calculated fatigue risk score for the swap, based on duty periods, rest requirements, and circadian factors.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the swap request record was last updated.',
    `legality_check_status` STRING COMMENT 'Result of automated legality validation against FAR Part 117 and EASA FTL regulations.',
    `legality_check_timestamp` TIMESTAMP COMMENT 'Date and time when the legality check was performed.',
    `legality_violation_details` STRING COMMENT 'Detailed description of any legality violations or warnings identified during the check.',
    `mutual_swap_flag` BOOLEAN COMMENT 'Indicates whether this is a mutual swap where both crew members exchange assignments (true) or a one-way swap (false).',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification has been sent to the target crew member about the swap request.',
    `priority_level` STRING COMMENT 'Priority assigned to the swap request for processing and approval.',
    `qualification_check_status` STRING COMMENT 'Result of the crew qualification and type rating validation for the swap.',
    `qualification_violation_details` STRING COMMENT 'Details of any qualification, type rating, or recency violations identified.',
    `reason_code` STRING COMMENT 'Categorized reason for the swap request.',
    `reason_description` STRING COMMENT 'Free-text explanation provided by the requesting crew member for the swap request.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a swap request is rejected.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the swap request, formatted as SWP-YYYYMMDD-NNNN.',
    `request_status` STRING COMMENT 'Current lifecycle status of the swap request.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the swap request was initially created by the requesting crew member.',
    `requesting_crew_base_code` STRING COMMENT 'Three-letter IATA code of the crew base for the requesting crew member.',
    `requires_qualification_check` BOOLEAN COMMENT 'Indicates whether the swap requires validation of crew qualifications, type ratings, and recency requirements.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the swap request was formally submitted for approval.',
    `swap_type` STRING COMMENT 'Type of swap being requested: pairing (full sequence), trip, duty period, single leg, reserve day, or day off.',
    `system_generated_flag` BOOLEAN COMMENT 'Indicates whether the swap request was automatically generated by the system (true) or manually created by a crew member (false).',
    `target_crew_base_code` STRING COMMENT 'Three-letter IATA code of the crew base for the target crew member.',
    `target_response` STRING COMMENT 'Response from the target crew member regarding the swap request.',
    `target_response_timestamp` TIMESTAMP COMMENT 'Date and time when the target crew member responded to the swap request.',
    CONSTRAINT pk_swap_request PRIMARY KEY(`swap_request_id`)
) COMMENT 'Master reference table for swap_request. Referenced by swap_request_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `airlines_ecm`.`crew`.`licence`(`licence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ADD CONSTRAINT `fk_crew_recency_record_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_pairing_id` FOREIGN KEY (`pairing_id`) REFERENCES `airlines_ecm`.`crew`.`pairing`(`pairing_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_pairing_id` FOREIGN KEY (`pairing_id`) REFERENCES `airlines_ecm`.`crew`.`pairing`(`pairing_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `airlines_ecm`.`crew`.`roster`(`roster_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_tertiary_roster_swap_receiving_crew_member_id` FOREIGN KEY (`tertiary_roster_swap_receiving_crew_member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_duty_period_id` FOREIGN KEY (`duty_period_id`) REFERENCES `airlines_ecm`.`crew`.`duty_period`(`duty_period_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_pairing_id` FOREIGN KEY (`pairing_id`) REFERENCES `airlines_ecm`.`crew`.`pairing`(`pairing_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_swap_request_id` FOREIGN KEY (`swap_request_id`) REFERENCES `airlines_ecm`.`crew`.`swap_request`(`swap_request_id`);
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ADD CONSTRAINT `fk_crew_ftl_legality_check_duty_period_id` FOREIGN KEY (`duty_period_id`) REFERENCES `airlines_ecm`.`crew`.`duty_period`(`duty_period_id`);
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ADD CONSTRAINT `fk_crew_ftl_legality_check_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ADD CONSTRAINT `fk_crew_ftl_legality_check_pairing_id` FOREIGN KEY (`pairing_id`) REFERENCES `airlines_ecm`.`crew`.`pairing`(`pairing_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ADD CONSTRAINT `fk_crew_medical_certificate_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`licence` ADD CONSTRAINT `fk_crew_licence_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_absence_replacement_crew_member_id` FOREIGN KEY (`absence_replacement_crew_member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_medical_certificate_id` FOREIGN KEY (`medical_certificate_id`) REFERENCES `airlines_ecm`.`crew`.`medical_certificate`(`medical_certificate_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_previous_absence_id` FOREIGN KEY (`previous_absence_id`) REFERENCES `airlines_ecm`.`crew`.`absence`(`absence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`bid` ADD CONSTRAINT `fk_crew_bid_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);
ALTER TABLE `airlines_ecm`.`crew`.`bid` ADD CONSTRAINT `fk_crew_bid_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`bid` ADD CONSTRAINT `fk_crew_bid_amended_bid_id` FOREIGN KEY (`amended_bid_id`) REFERENCES `airlines_ecm`.`crew`.`bid`(`bid_id`);
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ADD CONSTRAINT `fk_crew_maintenance_authorization_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ADD CONSTRAINT `fk_crew_operational_qualification_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ADD CONSTRAINT `fk_crew_swap_request_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ADD CONSTRAINT `fk_crew_swap_request_pairing_id` FOREIGN KEY (`pairing_id`) REFERENCES `airlines_ecm`.`crew`.`pairing`(`pairing_id`);
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ADD CONSTRAINT `fk_crew_swap_request_target_crew_member_id` FOREIGN KEY (`target_crew_member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ADD CONSTRAINT `fk_crew_swap_request_target_pairing_id` FOREIGN KEY (`target_pairing_id`) REFERENCES `airlines_ecm`.`crew`.`pairing`(`pairing_id`);
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ADD CONSTRAINT `fk_crew_swap_request_counterpart_swap_request_id` FOREIGN KEY (`counterpart_swap_request_id`) REFERENCES `airlines_ecm`.`crew`.`swap_request`(`swap_request_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`crew` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`crew` SET TAGS ('dbx_domain' = 'crew');
ALTER TABLE `airlines_ecm`.`crew`.`member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`crew`.`member` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `base_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Base Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Home Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'License Issuing Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `aims_crew_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Integrated Management System (AIMS) Crew Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `aims_crew_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `crew_category` SET TAGS ('dbx_business_glossary_term' = 'Crew Category');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `crew_category` SET TAGS ('dbx_value_regex' = 'flight_deck|cabin|ground_operations|maintenance|dispatch|other');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `crew_position` SET TAGS ('dbx_business_glossary_term' = 'Crew Position');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `date_of_hire` SET TAGS ('dbx_business_glossary_term' = 'Date of Hire');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|probationary|terminated');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `language_proficiency_codes` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency Codes');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `last_line_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Line Check Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `last_recurrent_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recurrent Training Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `medical_certificate_class` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Class');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `medical_certificate_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|cabin_crew|none');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `medical_certificate_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `medical_certificate_class` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `next_recurrent_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recurrent Training Due Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Passport Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `security_clearance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `seniority_number` SET TAGS ('dbx_business_glossary_term' = 'Seniority Number');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `total_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Flight Hours');
ALTER TABLE `airlines_ecm`.`crew`.`member` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification ID');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Licence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member ID');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `operational_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `type_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Check Type');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'initial|recurrent|upgrade|requalification|line_check|^$');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `endorsement_codes` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Codes');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Flight Hours');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `is_pic_qualified` SET TAGS ('dbx_business_glossary_term' = 'Pilot In Command (PIC) Qualified Flag');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `is_sic_qualified` SET TAGS ('dbx_business_glossary_term' = 'Second In Command (SIC) Qualified Flag');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `landings_count` SET TAGS ('dbx_business_glossary_term' = 'Landings Count');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `last_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Check Date');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `last_flight_date` SET TAGS ('dbx_business_glossary_term' = 'Last Flight Date');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `medical_class` SET TAGS ('dbx_business_glossary_term' = 'Medical Class');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `medical_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|^$');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `medical_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `medical_class` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `next_check_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Check Due Date');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = 'CA|FO|SO|CP|FA|PS|LS|^$');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_business_glossary_term' = 'Qualification Category');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_value_regex' = 'type_rating|position_authorization|endorsement|recurrent_training|special_qualification|medical_certificate');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'current|expired|suspended|revoked|pending|in_training');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `recency_status` SET TAGS ('dbx_business_glossary_term' = 'Recency Status');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `recency_status` SET TAGS ('dbx_value_regex' = 'current|expiring_soon|expired|not_applicable');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Restrictions');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `simulator_hours` SET TAGS ('dbx_business_glossary_term' = 'Simulator Hours');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `training_organization` SET TAGS ('dbx_business_glossary_term' = 'Training Organization');
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` SET TAGS ('dbx_subdomain' = 'compliance_tracking');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `recency_record_id` SET TAGS ('dbx_business_glossary_term' = 'Recency Record Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `currency_status` SET TAGS ('dbx_business_glossary_term' = 'Currency Status');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `currency_status` SET TAGS ('dbx_value_regex' = 'current|expired|expiring_soon|not_applicable');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `instrument_conditions_flag` SET TAGS ('dbx_business_glossary_term' = 'Instrument Conditions Flag');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `last_qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualifying Event Date');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `last_qualifying_event_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Last Qualifying Event Flight Number');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `line_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Check Required Flag');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `night_operations_flag` SET TAGS ('dbx_business_glossary_term' = 'Night Operations Flag');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recency Notes');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `passenger_carrying_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Carrying Flag');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Position Code');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = 'CA|FO|SO|PU|FA|CSM');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `qualifying_event_count` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Count');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `recency_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Recency Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `recency_period_days` SET TAGS ('dbx_business_glossary_term' = 'Recency Period Days');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `recency_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Recency Requirement Reference');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `recency_type` SET TAGS ('dbx_business_glossary_term' = 'Recency Type');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `recency_type` SET TAGS ('dbx_value_regex' = 'takeoff|landing|instrument|etops|low_visibility|emergency_procedure');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `simulator_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulator Qualified Flag');
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ALTER COLUMN `warning_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold Days');
ALTER TABLE `airlines_ecm`.`crew`.`base` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`crew`.`base` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Base Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Base Manager Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_code` SET TAGS ('dbx_business_glossary_term' = 'Base Code');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_name` SET TAGS ('dbx_business_glossary_term' = 'Base Name');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_status` SET TAGS ('dbx_business_glossary_term' = 'Base Status');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|temporary|closed');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_type` SET TAGS ('dbx_business_glossary_term' = 'Base Type');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `base_type` SET TAGS ('dbx_value_regex' = 'hub|spoke|regional|international|domestic|satellite');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `cabin_crew_capacity` SET TAGS ('dbx_business_glossary_term' = 'Cabin Crew Capacity');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `crew_categories_served` SET TAGS ('dbx_business_glossary_term' = 'Crew Categories Served');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `crew_categories_served` SET TAGS ('dbx_value_regex' = 'flight_deck_only|cabin_crew_only|both|all');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `crew_training_facility_available` SET TAGS ('dbx_business_glossary_term' = 'Crew Training Facility Available');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `current_cabin_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Current Cabin Crew Count');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `current_flight_deck_count` SET TAGS ('dbx_business_glossary_term' = 'Current Flight Deck Count');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `deadhead_positioning_allowed` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Positioning Allowed');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `flight_deck_capacity` SET TAGS ('dbx_business_glossary_term' = 'Flight Deck Capacity');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `ftl_regulation_applicable` SET TAGS ('dbx_business_glossary_term' = 'Flight Time Limitations (FTL) Regulation Applicable');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `ftl_regulation_applicable` SET TAGS ('dbx_value_regex' = 'FAR_117|EASA_FTL|CAP_371|other');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `icao_code` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Code');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `icao_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `operational_timezone` SET TAGS ('dbx_business_glossary_term' = 'Operational Timezone');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `pairing_start_end_base` SET TAGS ('dbx_business_glossary_term' = 'Pairing Start End Base');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `physical_address` SET TAGS ('dbx_business_glossary_term' = 'Physical Address');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `physical_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `physical_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `reserve_pool_required` SET TAGS ('dbx_business_glossary_term' = 'Reserve Pool Required');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `reserve_pool_size_cabin` SET TAGS ('dbx_business_glossary_term' = 'Reserve Pool Size Cabin');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `reserve_pool_size_flight_deck` SET TAGS ('dbx_business_glossary_term' = 'Reserve Pool Size Flight Deck');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `rest_facility_available` SET TAGS ('dbx_business_glossary_term' = 'Rest Facility Available');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `rest_facility_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rest Facility Capacity');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `rest_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Rest Facility Type');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `rest_facility_type` SET TAGS ('dbx_value_regex' = 'hotel|crew_lounge|dedicated_facility|none');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `airlines_ecm`.`crew`.`base` ALTER COLUMN `utc_offset_hours` SET TAGS ('dbx_business_glossary_term' = 'Coordinated Universal Time (UTC) Offset Hours');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `pairing_id` SET TAGS ('dbx_business_glossary_term' = 'Pairing Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `base_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Base Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Pairing Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Pairing Cost');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pairing Cost Currency Code');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `crew_position` SET TAGS ('dbx_business_glossary_term' = 'Crew Position');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `crew_position` SET TAGS ('dbx_value_regex' = 'captain|first_officer|flight_attendant|purser|relief_pilot');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `deadhead_segments` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Segments');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Pairing End Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `hotel_cost` SET TAGS ('dbx_business_glossary_term' = 'Hotel Cost');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `international_flag` SET TAGS ('dbx_business_glossary_term' = 'International Flag');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `legality_status` SET TAGS ('dbx_business_glossary_term' = 'Legality Status');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `legality_status` SET TAGS ('dbx_value_regex' = 'legal|illegal|pending_review|waiver_approved');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `max_duty_period_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duty Period Hours');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `min_rest_period_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Period Hours');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pairing Notes');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `number_of_duty_periods` SET TAGS ('dbx_business_glossary_term' = 'Number of Duty Periods');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `number_of_layovers` SET TAGS ('dbx_business_glossary_term' = 'Number of Layovers');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `number_of_legs` SET TAGS ('dbx_business_glossary_term' = 'Number of Flight Legs');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `optimization_run_code` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `optimizer_version` SET TAGS ('dbx_business_glossary_term' = 'Optimizer Version');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `overnight_stations` SET TAGS ('dbx_business_glossary_term' = 'Overnight Stations');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `pairing_code` SET TAGS ('dbx_business_glossary_term' = 'Pairing Code');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `pairing_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `pairing_status` SET TAGS ('dbx_business_glossary_term' = 'Pairing Status');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `pairing_status` SET TAGS ('dbx_value_regex' = 'draft|published|assigned|in_progress|completed|cancelled');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `pairing_type` SET TAGS ('dbx_business_glossary_term' = 'Pairing Type');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `pairing_type` SET TAGS ('dbx_value_regex' = 'domestic|international|mixed|reserve|training|positioning');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `per_diem_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Amount');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `premium_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Pay Flag');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `red_eye_flag` SET TAGS ('dbx_business_glossary_term' = 'Red Eye Flag');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Pairing Start Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `time_away_from_base_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Away From Base (TAFB) Hours');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `total_block_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Block Hours');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `total_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Hours');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `total_duty_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Duty Hours');
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ALTER COLUMN `total_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Rest Hours');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_period_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Period Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `base_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Base Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `pairing_id` SET TAGS ('dbx_business_glossary_term' = 'Pairing Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `acclimation_status` SET TAGS ('dbx_business_glossary_term' = 'Acclimation Status');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `acclimation_status` SET TAGS ('dbx_value_regex' = 'acclimated|unacclimated|unknown');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `actual_flag` SET TAGS ('dbx_business_glossary_term' = 'Actual Duty Flag');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `augmented_crew_flag` SET TAGS ('dbx_business_glossary_term' = 'Augmented Crew Flag');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `block_hours_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Hours in Minutes');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Cancellation Reason Code');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_end_station_code` SET TAGS ('dbx_business_glossary_term' = 'Duty End Station Code');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_end_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_period_number` SET TAGS ('dbx_business_glossary_term' = 'Duty Period Sequence Number');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_start_station_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Start Station Code');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_start_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_type` SET TAGS ('dbx_business_glossary_term' = 'Duty Type');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `duty_type` SET TAGS ('dbx_value_regex' = 'flight_duty|ground_duty|deadhead|training|standby|reserve');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `easa_ftl_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union Aviation Safety Agency (EASA) Flight Time Limitations (FTL) Compliant Flag');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `far_117_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Aviation Regulation (FAR) Part 117 Compliant Flag');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `fatigue_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Level');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `fatigue_risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `fdp_elapsed_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Flight Duty Period (FDP) Elapsed Time in Minutes');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `fdp_end_time` SET TAGS ('dbx_business_glossary_term' = 'Flight Duty Period (FDP) End Time');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `fdp_start_time` SET TAGS ('dbx_business_glossary_term' = 'Flight Duty Period (FDP) Start Time');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `flight_segments_count` SET TAGS ('dbx_business_glossary_term' = 'Flight Segments Count');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `legality_status` SET TAGS ('dbx_business_glossary_term' = 'Duty Period Legality Status');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `legality_status` SET TAGS ('dbx_value_regex' = 'legal|illegal|waiver_granted|under_review');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `legality_violation_codes` SET TAGS ('dbx_business_glossary_term' = 'Legality Violation Codes');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `release_time` SET TAGS ('dbx_business_glossary_term' = 'Duty Release Time');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `report_time` SET TAGS ('dbx_business_glossary_term' = 'Duty Report Time');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `rest_period_after_minutes` SET TAGS ('dbx_business_glossary_term' = 'Rest Period After Duty in Minutes');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `rest_period_before_minutes` SET TAGS ('dbx_business_glossary_term' = 'Rest Period Before Duty in Minutes');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duty Flag');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `split_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Split Duty Flag');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `split_duty_rest_minutes` SET TAGS ('dbx_business_glossary_term' = 'Split Duty Rest Period in Minutes');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `time_zone_crossings_count` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Crossings Count');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `time_zone_end` SET TAGS ('dbx_business_glossary_term' = 'Time Zone at Duty End');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `time_zone_start` SET TAGS ('dbx_business_glossary_term' = 'Time Zone at Duty Start');
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ALTER COLUMN `total_duty_elapsed_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Duty Elapsed Time (TDT) in Minutes');
ALTER TABLE `airlines_ecm`.`crew`.`roster` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`crew`.`roster` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `base_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Base Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Approver Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Approval Status');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roster Approval Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `bid_period_month` SET TAGS ('dbx_business_glossary_term' = 'Bid Period Month');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `bid_period_year` SET TAGS ('dbx_business_glossary_term' = 'Bid Period Year');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `crew_position` SET TAGS ('dbx_business_glossary_term' = 'Crew Position');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `crew_position` SET TAGS ('dbx_value_regex' = 'captain|first_officer|flight_engineer|purser|flight_attendant|relief_pilot');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `days_off_count` SET TAGS ('dbx_business_glossary_term' = 'Days Off Count');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `deadhead_segments_count` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Segments Count');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Effective End Date');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Effective Start Date');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `leave_days_count` SET TAGS ('dbx_business_glossary_term' = 'Leave Days Count');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `legality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Legality Check Status');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `legality_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_checked');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `legality_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Legality Check Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Roster Notes');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `pbs_award_reference` SET TAGS ('dbx_business_glossary_term' = 'Preferential Bidding System (PBS) Award Reference');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Publication Date');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `reserve_days_count` SET TAGS ('dbx_business_glossary_term' = 'Reserve Days Count');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `roster_source` SET TAGS ('dbx_business_glossary_term' = 'Roster Source');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `roster_source` SET TAGS ('dbx_value_regex' = 'pbs|manual|optimization|crew_request');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Status');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_value_regex' = 'draft|published|revised|frozen|cancelled');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `total_credited_block_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Credited Block Hours');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `total_duty_days` SET TAGS ('dbx_business_glossary_term' = 'Total Duty Days');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `total_duty_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Duty Hours');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `total_flight_duty_periods` SET TAGS ('dbx_business_glossary_term' = 'Total Flight Duty Periods (FDP)');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `training_events_count` SET TAGS ('dbx_business_glossary_term' = 'Training Events Count');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `union_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Compliance Flag');
ALTER TABLE `airlines_ecm`.`crew`.`roster` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Roster Version Number');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `roster_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Activity Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Approved By User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `pairing_id` SET TAGS ('dbx_business_glossary_term' = 'Pairing Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `tertiary_roster_swap_receiving_crew_member_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Receiving Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `tertiary_roster_swap_receiving_crew_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `tertiary_roster_swap_receiving_crew_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|swapped|pending|confirmed');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'pairing|training|standby|day_off|deadhead|leave');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `block_hours` SET TAGS ('dbx_business_glossary_term' = 'Block Hours');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `deadhead_flag` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Flag');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `duty_hours` SET TAGS ('dbx_business_glossary_term' = 'Duty Hours');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `irop_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Related Flag');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'vacation|sick|personal|medical|bereavement|jury_duty');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `legality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Legality Check Status');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `legality_check_status` SET TAGS ('dbx_value_regex' = 'legal|illegal|warning|not_checked');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `legality_violation_code` SET TAGS ('dbx_business_glossary_term' = 'Legality Violation Code');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `roster_publish_datetime` SET TAGS ('dbx_business_glossary_term' = 'Roster Publish Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `standby_activation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Standby Activation Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `standby_activation_status` SET TAGS ('dbx_business_glossary_term' = 'Standby Activation Status');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `standby_activation_status` SET TAGS ('dbx_value_regex' = 'not_activated|activated|released');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `standby_contact_end_time` SET TAGS ('dbx_business_glossary_term' = 'Standby Contact Window End Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `standby_contact_start_time` SET TAGS ('dbx_business_glossary_term' = 'Standby Contact Window Start Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `standby_type` SET TAGS ('dbx_business_glossary_term' = 'Standby Type');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `standby_type` SET TAGS ('dbx_value_regex' = 'airport|home|hot|cold');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code (IATA Airport Code)');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `swap_approval_datetime` SET TAGS ('dbx_business_glossary_term' = 'Swap Approval Date and Time');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `swap_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Swap Approval Status');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `swap_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `swap_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Swap Requested Flag');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'simulator|classroom|line_check|recurrent|initial');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `flight_leg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Assignment ID');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `duty_period_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Period ID');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member ID');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `pairing_id` SET TAGS ('dbx_business_glossary_term' = 'Pairing ID');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Request ID');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `actual_checkin_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Check-In Time');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'roster|reserve|swap|voluntary|irop_recovery|manual');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'operating|deadhead');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `augmented_crew_flag` SET TAGS ('dbx_business_glossary_term' = 'Augmented Crew Flag');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `crew_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Acknowledgement Flag');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `crew_acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crew Acknowledgement Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `crew_position_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Position Code');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `deadhead_booking_class` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Booking Class');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `deadhead_booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `deadhead_reason` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Reason');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `deadhead_reason` SET TAGS ('dbx_value_regex' = 'pairing_start|pairing_end|irop_recovery|training|medical|administrative');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `deadhead_seat_number` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Seat Number');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `deadhead_seat_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}[A-K]$');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `interline_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Interline Carrier Code');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `interline_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `legality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Legality Check Status');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `legality_check_status` SET TAGS ('dbx_value_regex' = 'legal|illegal|warning|override_approved');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `override_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Override Approved By');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `own_metal_flag` SET TAGS ('dbx_business_glossary_term' = 'Own Metal Flag');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `qualification_check_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Check Status');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `qualification_check_status` SET TAGS ('dbx_value_regex' = 'qualified|override_approved|waiver_granted|not_qualified');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `relief_crew_flag` SET TAGS ('dbx_business_glossary_term' = 'Relief Crew Flag');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `reserve_callout_time` SET TAGS ('dbx_business_glossary_term' = 'Reserve Callout Time');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `scheduled_checkin_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Check-In Time');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `scheduled_report_location` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Report Location');
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` SET TAGS ('dbx_subdomain' = 'compliance_tracking');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `ftl_legality_check_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Time Limitations (FTL) Legality Check Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `duty_period_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Period Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `pairing_id` SET TAGS ('dbx_business_glossary_term' = 'Pairing Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method Type');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'regulatory_rule|biomathematical_model');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `check_notes` SET TAGS ('dbx_business_glossary_term' = 'Check Notes');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Execution Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `check_trigger` SET TAGS ('dbx_business_glossary_term' = 'Check Trigger Event');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `check_trigger` SET TAGS ('dbx_value_regex' = 'pre_assignment|pre_departure|post_duty|irop_extension|manual_audit|scheduled_review');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `fatigue_risk_band` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Band');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `fatigue_risk_band` SET TAGS ('dbx_value_regex' = 'low|moderate|elevated|high|critical');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `fatigue_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `fdp_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Flight Duty Period (FDP) Actual Duration (Hours)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `fdp_limit_hours` SET TAGS ('dbx_business_glossary_term' = 'Flight Duty Period (FDP) Limit (Hours)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `fitness_result` SET TAGS ('dbx_business_glossary_term' = 'Fitness to Operate Result');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `fitness_result` SET TAGS ('dbx_value_regex' = 'legal|illegal|waiver_granted|elevated_risk_accepted');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `flight_time_28_day` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Flight Time 28-Day Window (Hours)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `flight_time_365_day` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Flight Time 365-Day Window (Hours)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `mitigation_applied` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures Applied');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `rest_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Rest Compliance Status');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `rest_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|reduced_rest_approved|waiver_granted');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `rest_period_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Rest Period Actual (Hours)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `rest_period_required_hours` SET TAGS ('dbx_business_glossary_term' = 'Rest Period Required (Hours)');
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` SET TAGS ('dbx_subdomain' = 'compliance_tracking');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_event_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Training Event Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Capa Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Instructor Certifying Staff Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `operational_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Training Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Training Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Training Approval Authority');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Booking Reference');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Number');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `crew_position_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Position Code');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `instructor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `instructor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Required Training');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `pass_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Pass Threshold Score');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Training Event Remarks');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Training Date');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `simulator_device_code` SET TAGS ('dbx_business_glossary_term' = 'Simulator Device Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `simulator_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `simulator_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'INITIAL|RECURRENT|UPGRADE|TRANSITION|REQUALIFICATION|REFRESHER');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Currency Code');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Training Event Date');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training End Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_method` SET TAGS ('dbx_value_regex' = 'SIMULATOR|CLASSROOM|CBT|LINE|PRACTICAL|ONLINE');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_result_code` SET TAGS ('dbx_business_glossary_term' = 'Training Result Code');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_result_code` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|INCOMPLETE|PARTIAL|DEFERRED|CANCELLED');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_score` SET TAGS ('dbx_business_glossary_term' = 'Training Score');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Start Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Event Status');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'SCHEDULED|IN_PROGRESS|COMPLETED|CANCELLED|NO_SHOW');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_syllabus_version` SET TAGS ('dbx_business_glossary_term' = 'Training Syllabus Version');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `training_type_code` SET TAGS ('dbx_business_glossary_term' = 'Training Type Code');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Training Validity End Date');
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Validity Start Date');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate ID');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member ID');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `certificate_class` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Class');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `certificate_class` SET TAGS ('dbx_value_regex' = 'Class 1|Class 2|Class 3');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Number');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Type');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'Initial|Renewal|Revalidation|Special Issuance');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference URL');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `examination_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Examination Date');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `examination_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Examination Type');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `examination_type` SET TAGS ('dbx_value_regex' = 'Standard|Extended|Special');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `hearing_aid_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hearing Aid Required Flag');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Issue Date');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `issuing_authority_license_number` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority License Number');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `limitations` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Limitations');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `limitations` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `next_examination_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Medical Examination Due Date');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Remarks');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `remarks` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `special_issuance_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Issuance Flag');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `validity_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Validity Status');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `validity_status` SET TAGS ('dbx_value_regex' = 'Valid|Expired|Suspended|Revoked|Pending');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending Verification|Failed Verification|Not Verified');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `vision_corrected_flag` SET TAGS ('dbx_business_glossary_term' = 'Vision Corrected Flag');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `waivers` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Waivers');
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ALTER COLUMN `waivers` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`crew`.`licence` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Licence ID');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member ID');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Licence Document URL');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `language_proficiency_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `language_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'ICAO Language Proficiency Level');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_number` SET TAGS ('dbx_business_glossary_term' = 'Licence Number');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_status` SET TAGS ('dbx_business_glossary_term' = 'Licence Status');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_status` SET TAGS ('dbx_value_regex' = 'valid|expired|suspended|revoked|pending_renewal|surrendered');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_type` SET TAGS ('dbx_business_glossary_term' = 'Licence Type');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `licence_type` SET TAGS ('dbx_value_regex' = 'ATPL|CPL|MPL|cabin_crew_attestation|flight_engineer|flight_navigator');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `medical_class` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Class');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `medical_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|cabin_crew_medical');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `medical_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `medical_class` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `medical_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `medical_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `medical_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Licence Notes');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `ratings_held` SET TAGS ('dbx_business_glossary_term' = 'Ratings Held');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Licence Restrictions');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `total_flight_hours_at_issue` SET TAGS ('dbx_business_glossary_term' = 'Total Flight Hours at Issue');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `airlines_ecm`.`crew`.`licence` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|verification_failed|not_verified');
ALTER TABLE `airlines_ecm`.`crew`.`absence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`crew`.`absence` SET TAGS ('dbx_subdomain' = 'compliance_tracking');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `absence_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Absence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `absence_replacement_crew_member_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `absence_replacement_crew_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `absence_replacement_crew_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `base_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `previous_absence_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Absence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `absence_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Status');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `absence_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|active|completed|cancelled');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `absence_type` SET TAGS ('dbx_business_glossary_term' = 'Absence Type');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `affected_duty_periods_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Duty Periods Count');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `affected_flight_legs_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Flight Legs Count');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `clearance_authority` SET TAGS ('dbx_business_glossary_term' = 'Clearance Authority');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `collective_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Collective Agreement Reference');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `crew_position` SET TAGS ('dbx_business_glossary_term' = 'Crew Position');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `crew_position` SET TAGS ('dbx_value_regex' = 'captain|first_officer|flight_engineer|purser|flight_attendant|cabin_crew');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Days');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'phone|email|mobile_app|in_person|crew_portal|third_party');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Absence Notification Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `pay_status` SET TAGS ('dbx_business_glossary_term' = 'Pay Status During Absence');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `pay_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial_pay');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Notes');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `reason_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `replacement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Required Flag');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `return_to_duty_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Duty Clearance Flag');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `return_to_duty_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Duty Date');
ALTER TABLE `airlines_ecm`.`crew`.`absence` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `airlines_ecm`.`crew`.`bid` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`crew`.`bid` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `bid_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Bid Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `base_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Base Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Override Approved By User Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `amended_bid_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `avoid_red_eye_flag` SET TAGS ('dbx_business_glossary_term' = 'Avoid Red-Eye Flag');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `award_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Award Publish Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `award_score` SET TAGS ('dbx_business_glossary_term' = 'Award Score');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `awarded_line_number` SET TAGS ('dbx_business_glossary_term' = 'Awarded Line Number');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `bid_category` SET TAGS ('dbx_business_glossary_term' = 'Bid Category');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `bid_category` SET TAGS ('dbx_value_regex' = 'line_holder|reserve|transition|training|leave');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Status');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|closed|awarded|cancelled|expired');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `collective_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Collective Agreement Reference');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `commuter_friendly_flag` SET TAGS ('dbx_business_glossary_term' = 'Commuter-Friendly Flag');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `crew_position` SET TAGS ('dbx_business_glossary_term' = 'Crew Position');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `crew_position` SET TAGS ('dbx_value_regex' = 'captain|first_officer|flight_engineer|purser|flight_attendant|lead_flight_attendant');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `lines_json` SET TAGS ('dbx_business_glossary_term' = 'Bid Lines JSON');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `max_duty_days_constraint` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duty Days Constraint');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `min_days_off_constraint` SET TAGS ('dbx_business_glossary_term' = 'Minimum Days Off Constraint');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bid Notes');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `pbs_processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preferential Bidding System (PBS) Processing Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `period_month` SET TAGS ('dbx_business_glossary_term' = 'Bid Period Month');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `period_year` SET TAGS ('dbx_business_glossary_term' = 'Bid Period Year');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `preferred_days_off` SET TAGS ('dbx_business_glossary_term' = 'Preferred Days Off');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `preferred_layover_stations` SET TAGS ('dbx_business_glossary_term' = 'Preferred Layover Stations');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Revision Number');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `satisfaction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Percentage');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `seniority_number` SET TAGS ('dbx_business_glossary_term' = 'Seniority Number');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `training_slot_requests` SET TAGS ('dbx_business_glossary_term' = 'Training Slot Requests');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `vacation_request_dates` SET TAGS ('dbx_business_glossary_term' = 'Vacation Request Dates');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `window_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Window Close Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`bid` ALTER COLUMN `window_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Window Open Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` SET TAGS ('dbx_subdomain' = 'compliance_tracking');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` SET TAGS ('dbx_association_edges' = 'crew.crew_member,maintenance.approved_maintenance_org');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `maintenance_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Maintenance Authorization ID');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Maintenance Authorization - Approved Maintenance Org Id');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Maintenance Authorization - Crew Member Id');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `authorization_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `authorization_scope` SET TAGS ('dbx_business_glossary_term' = 'Authorization Scope');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ALTER COLUMN `recency_status` SET TAGS ('dbx_business_glossary_term' = 'Recency Status');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` SET TAGS ('dbx_subdomain' = 'compliance_tracking');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` SET TAGS ('dbx_association_edges' = 'crew.crew_member,compliance.operational_approval');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `operational_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Operational Qualification ID');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Instructor');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Operational Qualification - Crew Member Id');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `operational_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Operational Qualification - Operational Approval Id');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Approval Status');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Check Date');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Qualification Remarks');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ALTER COLUMN `training_device_used` SET TAGS ('dbx_business_glossary_term' = 'Training Device');
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ALTER COLUMN `swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Request Identifier');
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ALTER COLUMN `counterpart_swap_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
