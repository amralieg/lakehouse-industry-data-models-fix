-- Schema for Domain: safety | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`safety` COMMENT 'Aviation safety management including SMS (Safety Management System), incident and occurrence reporting, accident investigation, CVR (Cockpit Voice Recorder) and FDR (Flight Data Recorder) event analysis, NOTAM (Notice to Air Missions) tracking, hazard identification, risk assessment, safety audits, corrective action plans, SOP version control, and fatigue risk management. SSOT for all safety occurrence and risk data. Aligns with ICAO Annex 19 SMS framework.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`occurrence` (
    `occurrence_id` BIGINT COMMENT 'Unique identifier for the safety occurrence record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Every safety occurrence in aviation must be tracked to specific aircraft for regulatory reporting (ICAO Annex 13), trend analysis, and airworthiness monitoring. Occurrence.aircraft_registration is den',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Fleet safety analysis requires occurrence trending by aircraft type for manufacturer safety bulletins, type-specific risk assessment, and fleet-wide safety performance monitoring. Standard practice in',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Cabin depressurization, seat injury, and evacuation occurrences require recording the exact cabin layout installed at the time of the event. Aviation safety investigators and regulators (EASA/FAA) exp',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Safety occurrences generate direct costs (investigations, repairs, AOG, insurance deductibles) that must be allocated to specific cost centres for budget tracking and financial reporting. Standard air',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine-related occurrences (IFSD, failure, fire) must be tracked to specific engine serial numbers for trend analysis, manufacturer reporting (per FAA Part 21), and warranty claims. Enables engine rel',
    `etops_authorization_id` BIGINT COMMENT 'Foreign key linking to fleet.etops_authorization. Business justification: ETOPS regulatory requirements (FAA AC 120-42B, EASA AMC 20-6) mandate that engine shutdown events, diversions, and other ETOPS-significant occurrences be recorded against the specific ETOPS authorizat',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Safety occurrence investigation and regulatory reporting (ICAO Annex 13, FAA Part 830) requires linking incidents to specific flight inventory records for passenger impact assessment, load factor anal',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Flight numbers are primary identifiers in safety reporting (ICAO ADREP, FAA ASRS). Links occurrence to specific flight number registration for codeshare liability, slot performance tracking, and regul',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Major occurrences trigger GL postings for insurance claim reserves, liability accruals, repair cost accruals, and asset impairments. Required for IFRS compliance and financial statement accuracy in ai',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: Ground handling incidents (ramp damage, FOD, ground vehicle collisions) are a major occurrence category. Linking occurrences to the responsible handler is required for ISAGO compliance tracking, handl',
    `inventory_leg_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_leg. Business justification: Aviation safety occurrences happen on a specific flight leg (e.g., turbulence injury on leg 2 of a multi-leg flight). Occurrence links to flight_inventory (the overall flight) but not the specific leg',
    `profile_id` BIGINT COMMENT 'Foreign key linking to passenger.profile. Business justification: Accessibility-related safety occurrences (wheelchair damage, mobility aid failures, service animal incidents, PRM boarding injuries) require linking to passenger accessibility profiles for investigati',
    `seasonal_schedule_id` BIGINT COMMENT 'Foreign key linking to route.seasonal_schedule. Business justification: Links safety events to specific schedule instances for operational analysis of schedule-related factors (turnaround pressure, slot timing, crew pairing). Used in schedule safety reviews and slot coord',
    `actual_altitude_ft` STRING COMMENT 'Actual altitude in feet flown during an airspace deviation occurrence. Populated only for airspace_deviation subtype.',
    `aircraft_damage_level` STRING COMMENT 'Extent of damage sustained by the aircraft: destroyed (total loss), substantial (major structural damage affecting airworthiness), minor (cosmetic or repairable without affecting airworthiness), or none.. Valid values are `destroyed|substantial|minor|none`',
    `arrival_airport_code` STRING COMMENT 'IATA or ICAO airport code for the destination airport of the flight involved in the occurrence.. Valid values are `^[A-Z]{3,4}$`',
    `category_code` STRING COMMENT 'ICAO CICTT (Common Taxonomy Team) occurrence category code classifying the event type (e.g., LOC-I for Loss of Control In-flight, CFIT for Controlled Flight Into Terrain, RE for Runway Excursion).. Valid values are `^[A-Z]{2,6}$`',
    `classification` STRING COMMENT 'Primary classification of the safety event per ICAO Annex 13 definitions: accident (fatal or substantial damage), serious incident (near-accident), incident (safety concern), or occurrence (reportable event).. Valid values are `accident|serious_incident|incident|occurrence`',
    `cleared_altitude_ft` STRING COMMENT 'ATC-cleared altitude in feet for an airspace deviation occurrence. Populated only for airspace_deviation subtype.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this occurrence record was first created in the SMS system.',
    `dangerous_goods_class` STRING COMMENT 'ICAO/IATA dangerous goods classification (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Populated only for dangerous_goods_incident subtype.',
    `dangerous_goods_un_number` STRING COMMENT 'United Nations identification number for dangerous goods involved in a dangerous goods incident (e.g., UN1950 for aerosols). Populated only for dangerous_goods_incident subtype.. Valid values are `^UN[0-9]{4}$`',
    `departure_airport_code` STRING COMMENT 'IATA or ICAO airport code for the departure airport of the flight involved in the occurrence.. Valid values are `^[A-Z]{3,4}$`',
    `fatalities_count` STRING COMMENT 'Total number of fatalities resulting from the occurrence (passengers, crew, and ground personnel).',
    `flight_phase` STRING COMMENT 'Phase of flight during which the occurrence took place (taxi, takeoff, initial climb, enroute, descent, approach, landing, parked, ground operations, unknown). [ENUM-REF-CANDIDATE: taxi|takeoff|initial_climb|enroute|descent|approach|landing|parked|ground_operations|unknown — 10 candidates stripped; promote to reference product]',
    `initial_causal_factors` STRING COMMENT 'Preliminary assessment of contributing or causal factors identified during initial occurrence reporting. Subject to revision during formal investigation.',
    `injury_severity` STRING COMMENT 'Highest level of injury sustained by any person involved in the occurrence (fatal, serious, minor, none) per ICAO definitions.. Valid values are `fatal|serious|minor|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this occurrence record was last updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate (decimal degrees) of the occurrence location if available.',
    `location` STRING COMMENT 'Textual description of the geographic location where the occurrence took place (airport name, airspace sector, coordinates, or nearest landmark).',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate (decimal degrees) of the occurrence location if available.',
    `minor_injuries_count` STRING COMMENT 'Total number of persons who sustained minor injuries not meeting the serious injury threshold.',
    `narrative_description` STRING COMMENT 'Detailed free-text narrative describing the sequence of events, circumstances, and conditions surrounding the occurrence. Captures initial reporter observations and factual account.',
    `occurrence_date` DATE COMMENT 'Date on which the safety occurrence took place (UTC).',
    `occurrence_number` STRING COMMENT 'Externally-known unique reference number assigned to the occurrence for tracking and regulatory reporting. Format varies by airline SMS system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `occurrence_timestamp` TIMESTAMP COMMENT 'Precise date and time (UTC) when the safety occurrence event happened. Principal business event timestamp.',
    `packaging_failure_description` STRING COMMENT 'Description of packaging failure or non-compliance that led to a dangerous goods incident. Populated only for dangerous_goods_incident subtype.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the occurrence meets regulatory thresholds requiring mandatory notification to civil aviation authority (FAA, EASA, national CAA) per applicable regulations.',
    `regulatory_notification_status` STRING COMMENT 'Current status of regulatory notification process: not required, pending submission, submitted to authority, or acknowledged by authority.. Valid values are `not_required|pending|submitted|acknowledged`',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the occurrence was formally notified to the regulatory authority (FAA, EASA, national CAA).',
    `reporter_name` STRING COMMENT 'Name of the individual who reported the occurrence. Confidential to encourage just culture reporting per SMS principles.',
    `reporting_source` STRING COMMENT 'Source or role of the individual or system that initially reported the occurrence (crew, maintenance, ground staff, ATC, passenger, external party, automated system). [ENUM-REF-CANDIDATE: crew|maintenance|ground_staff|atc|passenger|external|automated_system — 7 candidates stripped; promote to reference product]',
    `runway_designator` STRING COMMENT 'Runway identifier involved in a runway incursion occurrence (e.g., 27L, 09R, 33). Populated only for runway_incursion subtype.. Valid values are `^[0-9]{2}[LCR]?$`',
    `runway_incursion_severity` STRING COMMENT 'FAA/ICAO severity classification for runway incursion: A (extreme risk of collision), B (significant potential for collision), C (ample time to avoid collision), D (little or no chance of collision). Populated only for runway_incursion subtype.. Valid values are `A|B|C|D`',
    `serious_injuries_count` STRING COMMENT 'Total number of persons who sustained serious injuries as defined by ICAO Annex 13 (hospitalization >48 hours, fractures, severe burns, etc.).',
    `subtype` STRING COMMENT 'Detailed subtype classification for the occurrence enabling subtype-specific attribute capture (wildlife strike, runway incursion, airspace deviation, dangerous goods incident, CFIT, loss of control, turbulence encounter, ground collision, fuel emergency, cabin safety, other). [ENUM-REF-CANDIDATE: wildlife_strike|runway_incursion|airspace_deviation|dangerous_goods_incident|cfit|loss_of_control|turbulence_encounter|ground_collision|fuel_emergency|cabin_safety|other — 11 candidates stripped; promote to reference product]',
    `wildlife_ingestion_flag` BOOLEAN COMMENT 'Indicates whether wildlife was ingested into an engine during a wildlife strike. Populated only for wildlife_strike subtype.',
    `wildlife_species` STRING COMMENT 'Species of wildlife involved in a wildlife strike occurrence (bird species, mammal, reptile). Populated only for wildlife_strike subtype.',
    `wildlife_strike_location` STRING COMMENT 'Aircraft component or area struck by wildlife (engine, nose, windshield, wing, fuselage, landing gear). Populated only for wildlife_strike subtype.',
    CONSTRAINT pk_occurrence PRIMARY KEY(`occurrence_id`)
) COMMENT 'Master record for all aviation safety occurrences including incidents, accidents, serious incidents, near-misses, and all occurrence subtypes (wildlife strikes, runway incursions, airspace deviations, dangerous goods incidents, CFIT events, loss of control, turbulence encounters) as defined under ICAO Annex 13 and Annex 19 SMS framework. Captures occurrence classification (accident/serious incident/incident/occurrence), ICAO occurrence category (CICTT taxonomy), occurrence subtype with subtype-specific extended attributes, date/time/location, aircraft registration, flight phase, injury severity, damage level, narrative description, initial causal factors, reporting source, and regulatory notification status. Subtype-specific fields accommodate wildlife strike details (species, aircraft part struck, ingestion), runway incursion details (runway designator, severity category A-D), airspace deviation details (cleared vs actual values), and dangerous goods details (UN number, DG class, packaging failure). SSOT for all safety occurrence data across the airline.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`hazard` (
    `hazard_id` BIGINT COMMENT 'Unique identifier for the safety hazard record within the SMS (Safety Management System) hazard register. Primary key for the hazard entity.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Hazards are frequently identified for specific aircraft tail numbers (recurring technical issues, configuration-specific risks). SMS hazard registers track aircraft-specific hazards for targeted mitig',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Type-specific hazards (design limitations, system vulnerabilities) drive airworthiness directives and fleet-wide mitigations. Proper FK enables type certificate holder reporting and fleet risk assessm',
    `audit_id` BIGINT COMMENT 'Identifier of the safety audit or inspection that identified this hazard. Null if hazard was not identified through an audit.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Hazard mitigation activities are assigned to operational departments (cost centres) for budget accountability. Aviation SMS requires cost centre attribution of hazard management to track departmental ',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine-specific hazards (oil leaks, vibration anomalies, LLP life limits, uncontained failure risk) must reference the specific engine serial number. SMS hazard registers in aviation routinely track e',
    `etops_authorization_id` BIGINT COMMENT 'Foreign key linking to fleet.etops_authorization. Business justification: ETOPS-specific hazards (e.g., identified risks to extended twin-engine operations such as fuel system anomalies, communication failures) must reference the ETOPS authorization to assess whether the au',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Aviation SMS requires tracking hazards at the flight-number level — e.g., recurring bird strikes or NOTAM-triggered hazards on a specific flight number. Hazard already has route_id but flight-number g',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to ancillary.product_catalog. Business justification: Hazard identification in airline SMS frequently targets specific ancillary products (e.g., lithium battery products, specific seat types, dangerous goods sold as ancillaries). Product safety risk trac',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.member. Business justification: Crew members are primary hazard reporters in an airline SMS. hazard.identification_source is a text field. A FK to the reporting crew member enables SMS hazard reporting traceability, crew safety part',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Hazards are often route-specific (terrain clearance, weather patterns, airspace complexity, political risk). Required for route risk registers, ETOPS approval, and route authority applications. Replac',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Station-level hazard management is a core SMS process: wildlife strike hazards, runway incursion risks, and FOD hazards are station-specific. Aviation safety managers run station risk dashboards requi',
    `affected_operations_area` STRING COMMENT 'Operational domain or business area impacted by the hazard (e.g., flight operations, ground handling, maintenance, cargo, passenger services, crew scheduling).',
    `closure_date` DATE COMMENT 'Date on which the hazard was formally closed in the SMS register, either due to successful mitigation or acceptance of residual risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hazard record was first created in the SMS system.',
    `current_likelihood_rating` STRING COMMENT 'Current qualitative assessment of the probability that the hazard will result in a safety event, reflecting any mitigations applied since initial identification.. Valid values are `frequent|occasional|remote|improbable|extremely_improbable`',
    `current_risk_index` STRING COMMENT 'Current composite risk score derived from current likelihood and severity ratings using the ICAO SMS risk matrix, reflecting residual risk after mitigations. [ENUM-REF-CANDIDATE: 5A|5B|5C|4A|4B|4C|3A|3B|3C|2A|2B|1A — 12 candidates stripped; promote to reference product]',
    `current_severity_rating` STRING COMMENT 'Current qualitative assessment of the worst credible consequence if the hazard materializes, reflecting any mitigations applied since initial identification.. Valid values are `catastrophic|hazardous|major|minor|negligible`',
    `hazard_category` STRING COMMENT 'Primary classification of the hazard type: operational (flight ops, ground ops), technical (aircraft systems, equipment), organizational (procedures, management), environmental (weather, terrain), human_factors (crew performance, fatigue), or external (third-party, regulatory).. Valid values are `operational|technical|organizational|environmental|human_factors|external`',
    `hazard_description` STRING COMMENT 'Detailed narrative description of the hazard, including conditions, circumstances, and potential consequences that could lead to safety events.',
    `hazard_number` STRING COMMENT 'Business-facing unique reference number assigned to the hazard for tracking and reporting purposes. Format: HAZ-NNNNNN.. Valid values are `^HAZ-[0-9]{6,10}$`',
    `hazard_status` STRING COMMENT 'Current lifecycle status of the hazard in the SMS register: open (newly identified), under_review (being assessed), mitigation_in_progress (controls being implemented), mitigated (controls in place, residual risk acceptable), closed (no longer applicable), accepted (risk accepted by accountable executive).. Valid values are `open|under_review|mitigation_in_progress|mitigated|closed|accepted`',
    `identification_source` STRING COMMENT 'Method or channel through which the hazard was identified: safety audit, incident report, occurrence report, crew observation, maintenance finding, proactive analysis (FMEA, FHA), regulatory inspection, or third-party report. [ENUM-REF-CANDIDATE: safety_audit|incident_report|occurrence_report|crew_observation|maintenance_finding|proactive_analysis|regulatory_inspection|third_party_report — 8 candidates stripped; promote to reference product]',
    `identified_date` DATE COMMENT 'Date on which the hazard was first identified and entered into the SMS hazard register.',
    `initial_likelihood_rating` STRING COMMENT 'Initial qualitative assessment of the probability that the hazard will result in a safety event, using ICAO SMS risk matrix categories: frequent, occasional, remote, improbable, extremely_improbable.. Valid values are `frequent|occasional|remote|improbable|extremely_improbable`',
    `initial_risk_index` STRING COMMENT 'Initial composite risk score derived from likelihood and severity ratings using the ICAO SMS risk matrix (e.g., 5A = frequent/catastrophic, 1A = extremely_improbable/negligible). Format: <likelihood_level><severity_level>. [ENUM-REF-CANDIDATE: 5A|5B|5C|4A|4B|4C|3A|3B|3C|2A|2B|1A — 12 candidates stripped; promote to reference product]',
    `initial_severity_rating` STRING COMMENT 'Initial qualitative assessment of the worst credible consequence if the hazard materializes, using ICAO SMS risk matrix categories: catastrophic, hazardous, major, minor, negligible.. Valid values are `catastrophic|hazardous|major|minor|negligible`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hazard record was last updated in the SMS system, reflecting any changes to status, risk ratings, or other attributes.',
    `mitigation_target_date` DATE COMMENT 'Target date by which mitigation controls are planned to be fully implemented and effective.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next mandatory review of the hazard status and risk assessment, per SMS periodic review requirements.',
    `notam_issued_flag` BOOLEAN COMMENT 'Indicates whether a NOTAM (Notice to Air Missions) was issued to communicate this hazard to flight crews and operational personnel.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or updates related to the hazard that do not fit structured fields.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this hazard meets the criteria for mandatory reporting to the national civil aviation authority (e.g., FAA, EASA) under occurrence reporting regulations.',
    `review_date` DATE COMMENT 'Date of the most recent formal review of the hazard by the safety review board or safety action group.',
    `sop_revision_required_flag` BOOLEAN COMMENT 'Indicates whether this hazard has triggered a requirement to revise or create a Standard Operating Procedure (SOP) as part of mitigation.',
    `subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the primary hazard category (e.g., under technical: avionics, hydraulics, engines).',
    `title` STRING COMMENT 'Short descriptive title summarizing the identified hazard for quick reference in the hazard register.',
    CONSTRAINT pk_hazard PRIMARY KEY(`hazard_id`)
) COMMENT 'Master record for identified safety hazards within the SMS (Safety Management System) hazard register. Captures hazard title, description, hazard category (operational/technical/organizational/environmental), source of identification (audit/report/observation/proactive analysis), affected operations area, initial likelihood rating, initial severity rating, initial risk index, current status (open/mitigated/closed/accepted), date identified, and responsible safety officer. Core to ICAO Annex 19 proactive safety management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the risk assessment record within the Safety Management System (SMS). Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.audit. Business justification: Risk assessments are conducted as part of safety audits — auditors perform risk assessments of identified findings and systemic issues. Adding audit_id to risk_assessment enables direct linkage betwee',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Risk assessments drive resource allocation and mitigation budgets attributed to specific cost centres. Aviation SMS financial management assigns risk assessment activities (external consultants, data ',
    `hazard_id` BIGINT COMMENT 'Reference to the hazard being assessed. Links this risk assessment to the identified hazard in the SMS hazard register.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Risk assessments evaluate route-specific risks (ETOPS, mountainous terrain, conflict zones, weather). Required for route approval safety cases, insurance underwriting, and bilateral agreement negotiat',
    `affected_operations` STRING COMMENT 'Description of the operational scope impacted by the assessed risk (e.g., specific aircraft types, routes, phases of flight, operational procedures, airports). Used for targeted risk mitigation and communication.',
    `assessment_date` DATE COMMENT 'The date on which this risk assessment was formally conducted and documented. Represents the principal business event timestamp for the assessment.',
    `assessment_methodology` STRING COMMENT 'The formal risk assessment technique or framework applied (e.g., ICAO 5×5 Matrix, Bow-Tie Analysis, FMEA, HAZOP, Preliminary Hazard Analysis). Documents the analytical approach for audit and repeatability.',
    `assessment_narrative` STRING COMMENT 'Detailed textual justification for the likelihood and severity scores assigned, including rationale, assumptions, data sources, and expert judgment applied. Critical for audit trail and knowledge transfer.',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier for the risk assessment, typically formatted as RA-YYYYNNNNNN for external reference and audit trails.. Valid values are `^RA-[0-9]{6,10}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the risk assessment record. Draft = in progress; Submitted = awaiting review; Under Review = being evaluated by safety committee; Approved = formally accepted; Closed = actions completed; Superseded = replaced by newer assessment.. Valid values are `draft|submitted|under_review|approved|closed|superseded`',
    `assessment_team_members` STRING COMMENT 'Names or identifiers of additional subject matter experts, operational personnel, or safety committee members who contributed to the assessment. Captures collaborative input beyond the primary assessor.',
    `assessment_type` STRING COMMENT 'Classification of the assessment stage within the risk management lifecycle. Initial = first assessment of a new hazard; Residual = assessment after controls applied; Reviewed = periodic re-evaluation; Reassessment = triggered by new information; Periodic = scheduled routine review.. Valid values are `initial|residual|reviewed|reassessment|periodic`',
    `assessor_name` STRING COMMENT 'Full name of the individual who performed the risk assessment, captured for audit and accountability purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this risk assessment record was first created in the SMS database. Used for audit trail and data lineage.',
    `data_sources` STRING COMMENT 'List of data sources, evidence, and references used to inform the risk assessment (e.g., FDR/CVR analysis, incident reports, maintenance records, industry safety bulletins, statistical data). Supports traceability and repeatability.',
    `existing_controls_summary` STRING COMMENT 'Summary of current risk mitigation controls, barriers, and defenses already in place at the time of assessment. Used to distinguish initial vs residual risk.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this risk assessment record was last updated. Tracks changes over the assessment lifecycle for audit and version control.',
    `likelihood_score` STRING COMMENT 'Probability rating of the hazard occurring, scored on the ICAO 1-5 scale where 1=Extremely Improbable, 2=Improbable, 3=Remote, 4=Occasional, 5=Frequent. Used to calculate risk index.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic reassessment of this risk. Ensures ongoing monitoring and compliance with SMS continuous improvement requirements.',
    `notification_date` DATE COMMENT 'Date on which the risk assessment was formally reported to the regulatory authority. Nullable if notification not required or not yet completed.',
    `notification_reference_number` STRING COMMENT 'Official reference number or tracking identifier assigned by the regulatory authority upon receipt of the risk assessment notification. Used for compliance audit trails.',
    `recommended_actions` STRING COMMENT 'Proposed corrective actions, additional controls, or risk treatments recommended by the assessor to reduce risk to an acceptable level. May link to formal corrective action plans.',
    `regulatory_authority_notified_flag` BOOLEAN COMMENT 'Indicates whether the risk assessment and associated hazard were reported to the national civil aviation authority (e.g., FAA, EASA) as required for high-severity or intolerable risks.',
    `review_comments` STRING COMMENT 'Feedback, observations, or directives provided by the reviewer during the approval process. May include requests for additional analysis or clarification.',
    `review_date` DATE COMMENT 'Date on which the risk assessment was formally reviewed and approved by the designated reviewer. Nullable if assessment not yet reviewed.',
    `risk_category` STRING COMMENT 'High-level classification of the risk domain. Operational = flight operations and procedures; Technical = aircraft systems and equipment; Organizational = management and processes; Environmental = weather and external conditions; Human Factors = crew performance and fatigue; Security = intentional threats.. Valid values are `operational|technical|organizational|environmental|human_factors|security`',
    `risk_index` STRING COMMENT 'Calculated risk score derived from likelihood and severity scores, typically computed as likelihood × severity. Range 1-25 on ICAO matrix. Determines risk tolerance classification.',
    `risk_matrix_quadrant` STRING COMMENT 'Visual position on the 5×5 ICAO risk matrix, typically expressed as coordinate notation (e.g., L3S4) or color-coded zone (green/yellow/amber/red). Used for dashboard visualization and executive reporting.',
    `risk_tolerance_level` STRING COMMENT 'Management decision on acceptability of the assessed risk. Acceptable = no further action required; Tolerable = acceptable with mitigation and monitoring; Intolerable = unacceptable, immediate action required. Aligns with ALARP (As Low As Reasonably Practicable) principle.. Valid values are `acceptable|tolerable|intolerable`',
    `severity_score` STRING COMMENT 'Consequence rating of the hazard if it occurs, scored on the ICAO 1-5 scale where 1=Negligible, 2=Minor, 3=Major, 4=Hazardous, 5=Catastrophic. Used to calculate risk index.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Formal risk assessment record linked to a hazard or occurrence within the SMS risk management process. Captures assessment date, assessor identity, risk type (initial/residual/reviewed), likelihood score (1-5 ICAO scale), severity score (1-5 ICAO scale), risk index, risk tolerance level (acceptable/tolerable/intolerable), risk matrix quadrant, assessment methodology, and narrative justification. Tracks the evolution of risk ratings over time as controls are applied. Aligns with ICAO Annex 19 risk management requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record within the Safety Management System (SMS).',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Fleet-wide corrective actions implementing airworthiness directives or type-level safety recommendations must reference the aircraft type to scope implementation across the fleet. Aviation safety mana',
    `audit_id` BIGINT COMMENT 'Foreign key reference to the safety audit record if this action was raised against an audit finding.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Corrective actions have implementation costs (modifications, training, equipment purchases) that must be budgeted and tracked to specific cost centres. Essential for safety investment tracking and bud',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Corrective action costs (repairs, modifications, training programs, external consultants) post to GL accounts. Links actual_cost field to GL for financial reporting and audit trail of safety expenditu',
    `hazard_id` BIGINT COMMENT 'Foreign key reference to the hazard record if this action was raised against an identified hazard.',
    `investigation_id` BIGINT COMMENT 'Foreign key reference to the accident or incident investigation if this action was raised as a formal investigation recommendation.',
    `occurrence_id` BIGINT COMMENT 'Foreign key reference to the safety occurrence record if this action was raised against a specific occurrence event.',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Corrective actions implement formal safety recommendations. Adding corrective_action.recommendation_id → recommendation.recommendation_id tracks which recommendation the action implements. No redundan',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Corrective actions may be route-specific (procedure changes for specific approaches, crew training for specific routes, route suspension). Required for tracking route-level safety improvements and reg',
    `action_description` STRING COMMENT 'Detailed narrative describing the corrective action, preventive measure, or safety recommendation including scope, methodology, and expected outcome.',
    `action_number` STRING COMMENT 'Business-facing unique reference number for the corrective action, typically formatted as CA-YYYYNNNNNN for external communication and tracking.. Valid values are `^CA-[0-9]{6,10}$`',
    `action_title` STRING COMMENT 'Short descriptive title summarizing the corrective action or recommendation.',
    `action_type` STRING COMMENT 'Classification of the action: corrective (addresses existing deficiency), preventive (prevents future occurrence), mitigating (reduces severity), or recommendation (formal safety recommendation from investigation body).. Valid values are `corrective|preventive|mitigating|recommendation`',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action implementation was completed, prior to verification.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action.',
    `addressee_response` STRING COMMENT 'Formal response received from the external addressee or AIB regarding acceptance, implementation plan, or rejection of the recommendation.',
    `assigned_department` STRING COMMENT 'Internal department or organizational unit responsible for implementing the corrective action.',
    `closure_date` DATE COMMENT 'Date when the corrective action was formally closed after successful effectiveness review or other closure criteria met.',
    `closure_notes` STRING COMMENT 'Detailed justification and notes supporting the closure decision including effectiveness evidence and lessons learned.',
    `closure_status` STRING COMMENT 'Final disposition status indicating whether the corrective action has been formally closed and the reason for closure.. Valid values are `open|closed_effective|closed_superseded|closed_not_required|closed_ineffective`',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action from identification through closure and effectiveness review. [ENUM-REF-CANDIDATE: open|in_progress|pending_verification|verified|closed|overdue|cancelled — 7 candidates stripped; promote to reference product]',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action including labor, materials, training, and system modifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action record was first created in the SMS.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost estimates and actual costs.. Valid values are `^[A-Z]{3}$`',
    `effectiveness_rating` STRING COMMENT 'Assessment of whether the corrective action achieved its intended safety improvement objective after monitoring period.. Valid values are `effective|partially_effective|ineffective|under_review`',
    `effectiveness_review_date` DATE COMMENT 'Scheduled or actual date for reviewing the long-term effectiveness of the corrective action after a monitoring period.',
    `external_addressee` STRING COMMENT 'Name of external organization or Accident Investigation Body (AIB) to whom this recommendation is addressed, if applicable.',
    `implementation_evidence` STRING COMMENT 'Description or reference to documentation, records, or artifacts that provide evidence of corrective action implementation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action record was last updated in the SMS.',
    `priority_level` STRING COMMENT 'Urgency and importance classification of the corrective action based on risk severity and operational impact.. Valid values are `critical|high|medium|low`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or AIB that issued the recommendation or is monitoring the corrective action (e.g., FAA, EASA, NTSB, national AIB).',
    `regulatory_tracking_reference` STRING COMMENT 'External reference number assigned by regulatory authority or AIB for tracking formal safety recommendations requiring airline response.',
    `responsible_person_email` STRING COMMENT 'Email address of the individual accountable for the corrective action implementation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'Name of the individual accountable for ensuring the corrective action is completed and effective.',
    `source_reference_number` STRING COMMENT 'Reference identifier of the source event, occurrence report, audit finding, investigation, hazard, or risk assessment that generated this action.',
    `source_type` STRING COMMENT 'Category of the originating event or process that triggered this corrective action within the SMS.. Valid values are `occurrence|hazard|audit|investigation|risk_assessment|external_recommendation`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action should be fully implemented and verified.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as implemented and initially effective.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action has been implemented as intended and is effective.. Valid values are `document_review|site_inspection|audit|test|observation|interview`',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process including findings, evidence reviewed, and any concerns identified.',
    `verification_status` STRING COMMENT 'Current status of the verification process to confirm corrective action implementation and initial effectiveness.. Valid values are `not_started|pending|verified|failed|not_applicable`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective actions, preventive actions, mitigating actions, and formal safety recommendations raised against occurrences, hazards, audit findings, risk assessments, or investigations within the SMS. Captures action/recommendation title, description, action type (corrective/preventive/mitigating/recommendation), priority level, assigned department or external addressee (including national AIBs), responsible person, target completion date, actual completion date, verification method, verification status, effectiveness review date, closure status, source reference (investigation/audit/hazard/occurrence), and recommendation-specific fields (addressee response, implementation evidence, regulatory tracking reference). Tracks the full lifecycle from identification through closure and effectiveness review. Encompasses both internally generated recommendations and those received from Accident Investigation Bodies requiring airline response and tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the safety audit record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Aircraft-specific airworthiness audits and line maintenance audits target individual tail numbers. Aviation regulators (EASA Part-M, FAA AC 120-16) require audits to be traceable to specific aircraft.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: ETOPS authorization audits, type-specific maintenance program audits, and IOSA audits scoped to a specific aircraft type require this FK. Aviation quality managers routinely filter audit findings by a',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Safety audits (IOSA, regulatory, internal) have costs (auditor time, travel, external consultants, certification fees) allocated to cost centres. Required for SMS budget tracking and departmental cost',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: ISAGO audits are specifically conducted on ground handling companies. Linking the audit record to the ground_handler being audited is essential for ISAGO certification tracking, handler performance ma',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: IOSA and internal SMS audits are conducted against specific routes — e.g., new long-haul route operational readiness audits or route-specific crew procedure compliance audits. Audit has audited_statio',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: IOSA and ramp safety audits are conducted at specific stations. Station-level audit compliance reporting and scheduling depend on this FK. `audited_station_code` is a denormalized text field; a proper',
    `actual_end_date` DATE COMMENT 'Actual date when the audit concluded. May differ from planned date due to scope changes or findings requiring extended investigation.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit commenced. May differ from planned date due to operational changes.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including areas, processes, and standards being audited (e.g., Flight Operations SMS compliance - all hub stations, IOSA IRM sections 1.1-1.5, Part 121 operational control procedures).',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Values: planned (scheduled but not started), in_progress (fieldwork underway), completed (fieldwork finished, report pending), closed (report issued and all corrective actions tracked), cancelled (audit cancelled before completion).. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit. Values: internal_sms (internal Safety Management System audit), iosa_preparation (IATA Operational Safety Audit preparation audit), regulatory_authority (FAA/EASA/CAA audit), losa (Line Operations Safety Audit), line_station (line station operational audit), maintenance (MRO facility audit).. Valid values are `internal_sms|iosa_preparation|regulatory_authority|losa|line_station|maintenance`',
    `audited_department` STRING COMMENT 'Name of the department, division, or functional area being audited (e.g., Flight Operations, Ground Handling, Maintenance Engineering, Crew Scheduling).',
    `audited_function` STRING COMMENT 'Specific operational function or process being audited (e.g., Dispatch Release Procedures, Fuel Uplift Operations, Cabin Safety Procedures, MEL Compliance).',
    `corrective_action_plan_due_date` DATE COMMENT 'Date by which the corrective action plan must be submitted to the audit authority or safety management team. Null if no CAP required.',
    `corrective_action_plan_required` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan is required based on audit findings. True if findings require documented corrective actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical findings requiring immediate corrective action due to significant safety risk or regulatory non-compliance.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify implementation of corrective actions. True if findings severity or regulatory requirement mandates follow-up.',
    `follow_up_audit_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up audit to verify corrective action effectiveness. Null if no follow-up required.',
    `iosa_registration_number` STRING COMMENT 'IATA IOSA registration number if this audit is part of IOSA certification or renewal process (e.g., IOSA-123456). Null for non-IOSA audits.. Valid values are `^IOSA-[0-9]{6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last modified.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and reporting the audit.',
    `major_findings_count` STRING COMMENT 'Number of major findings representing significant non-conformities that could affect safety or compliance if not addressed.',
    `minor_findings_count` STRING COMMENT 'Number of minor findings representing isolated non-conformities or opportunities for improvement with low safety impact.',
    `notes` STRING COMMENT 'Additional notes, observations, or context relevant to the audit that do not fit in structured fields.',
    `overall_finding_summary` STRING COMMENT 'Executive summary of the audit findings, including overall compliance assessment, number of findings by severity, and key themes identified.',
    `planned_end_date` DATE COMMENT 'Scheduled date when the audit is planned to conclude.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the audit is planned to commence.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for the audit, typically formatted as type-year-sequence (e.g., IOSA-2024-001234, LOSA-2024-000567).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{4,6}$`',
    `regulatory_authority_name` STRING COMMENT 'Name of the regulatory authority conducting or sponsoring the audit (e.g., FAA, EASA, UK CAA, DGCA India). Null for internal audits.',
    `regulatory_authority_reference` STRING COMMENT 'Reference number or identifier assigned by the regulatory authority for this audit. Null for internal audits.',
    `report_document_reference` STRING COMMENT 'Document management system reference or file path to the formal audit report document.',
    `report_issued_date` DATE COMMENT 'Date when the formal audit report was issued to the audited department and relevant stakeholders.',
    `sms_accountable_executive_notified` BOOLEAN COMMENT 'Indicates whether the SMS Accountable Executive has been notified of the audit findings, as required for critical or major findings under ICAO Annex 19.',
    `standard_reference` STRING COMMENT 'Reference to the standard, regulation, or framework against which the audit was conducted (e.g., IOSA IRM Edition 14, FAA Part 121, ICAO Annex 19, ISO 9001:2015).',
    `team_members` STRING COMMENT 'Comma-separated list of audit team member names participating in the audit.',
    `total_findings_count` STRING COMMENT 'Total number of findings (non-conformities, observations, opportunities for improvement) identified during the audit.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Safety audit and inspection programme records covering internal SMS audits, IOSA (IATA Operational Safety Audit) preparation audits, regulatory authority audits (FAA, EASA, national CAA), and line operations safety audits (LOSA). Captures audit reference number, audit type, audit scope, audited department/station/function, lead auditor, audit team members, planned date, actual date, audit status (planned/in-progress/completed/closed), overall finding summary, and regulatory authority reference where applicable.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: audit_finding.aircraft_registration is a denormalized text field. Aviation audit findings against specific tail numbers (MEL compliance, airworthiness directive status) require a proper FK to aircraft',
    `audit_id` BIGINT COMMENT 'Reference to the parent safety audit, inspection, or surveillance activity during which this finding was raised. Links to the audit event that generated this finding.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Audit findings spawn corrective actions. Adding audit_finding.corrective_action_id → corrective_action.corrective_action_id links findings to their formal corrective action records. Removes corrective',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: audit_finding has a plain-text `flight_number` column — a classic denormalization. Aviation audit findings are formally tied to specific flight numbers (e.g., crew procedure non-compliance on flight B',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Audit findings frequently identify or relate to specific hazards in the SMS hazard register. An audit finding may confirm an existing hazard, identify a new one, or assess the effectiveness of hazard ',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Audit findings can be directly linked to specific safety occurrences — for example, an audit may review how a specific incident was handled, or a finding may reference a recurrent occurrence pattern. ',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the previous audit finding record if this is a recurrence. Links to historical finding for trend analysis and corrective action effectiveness review.',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to ancillary.product_catalog. Business justification: IOSA and regulatory audits produce findings against specific ancillary products (e.g., seat product not meeting safety standards, ancillary item sold without proper documentation). Audit finding trace',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Audit findings can result in formal safety recommendations. Adding audit_finding.recommendation_id → recommendation.recommendation_id links findings to recommendations they generate. No redundant colu',
    `audit_organization` STRING COMMENT 'Organization or authority that conducted the audit (e.g., IATA IOSA, FAA, EASA, Internal Audit, National CAA). Identifies the source and authority level of the finding.',
    `auditor_name` STRING COMMENT 'Name of the auditor or inspector who identified and documented the finding. May be internal auditor, IOSA auditor, FAA inspector, or EASA inspector.',
    `closure_date` DATE COMMENT 'Date on which the finding was formally closed after verification of corrective action effectiveness. Null if finding remains open.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was first created in the system. Audit trail for data lineage and compliance.',
    `due_date` DATE COMMENT 'Target date by which corrective actions must be completed and the finding resolved. Determined based on risk level and regulatory requirements.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the finding has been escalated to senior management or the accountable executive due to high risk, regulatory significance, or overdue corrective actions. True if escalated, false otherwise.',
    `finding_category` STRING COMMENT 'Business or operational category of the finding (e.g., Flight Operations, Maintenance, Ground Operations, Crew Training, Safety Management, Security, Cargo). Aligns with airline operational domains.',
    `finding_date` DATE COMMENT 'Date on which the finding was identified and documented during the audit or inspection activity.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the finding, including what was observed, the context, and why it constitutes a finding. Provides full business context for auditors, management, and corrective action teams.',
    `finding_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this finding for tracking and communication purposes. Used in audit reports and corrective action tracking.. Valid values are `^[A-Z0-9-]+$`',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding. Tracks progression from identification through corrective action implementation to closure and verification. [ENUM-REF-CANDIDATE: open|under_review|corrective_action_assigned|in_progress|pending_verification|closed|overdue — 7 candidates stripped; promote to reference product]',
    `finding_type` STRING COMMENT 'Classification of the finding severity and nature. Non-conformance indicates a breach of regulatory or standard requirements; observation is a noted concern without immediate compliance impact; opportunity for improvement suggests enhancement areas; positive finding recognizes good practice.. Valid values are `non-conformance|observation|opportunity_for_improvement|positive_finding|minor_finding|major_finding`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was last updated. Tracks changes to finding status, corrective actions, or other attributes over the finding lifecycle.',
    `management_response` STRING COMMENT 'Formal response from management acknowledging the finding, accepting or disputing it, and committing to corrective actions. Part of the audit finding closure process.',
    `notam_reference` STRING COMMENT 'Reference to a NOTAM (Notice to Air Missions) if the finding relates to non-compliance with or failure to act upon a published NOTAM.',
    `preventive_action` STRING COMMENT 'Description of preventive measures implemented to prevent recurrence of similar findings across the organization. Addresses systemic improvements beyond immediate corrective action.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this finding is a recurrence of a previously identified and closed finding. True if recurrent, false if new. Recurrent findings indicate ineffective corrective actions and require escalation.',
    `regulatory_reference` STRING COMMENT 'Specific regulation, standard, or requirement that was breached or is relevant to this finding. May reference FAA regulations (e.g., 14 CFR Part 121), EASA regulations (e.g., EU-OPS), ICAO Annexes, or IOSA standards.',
    `responsible_department` STRING COMMENT 'Department or organizational unit responsible for addressing and resolving the finding. Accountable for implementing corrective actions and providing closure evidence.',
    `responsible_person_name` STRING COMMENT 'Name of the individual assigned accountability for resolving the finding and implementing corrective actions. Business-confidential operational data.',
    `risk_level` STRING COMMENT 'Risk severity level assigned to the finding based on safety risk assessment. Determines priority for corrective action and management escalation. Aligns with SMS risk matrix (likelihood x severity).. Valid values are `critical|high|medium|low|negligible`',
    `risk_score` STRING COMMENT 'Numeric risk score calculated from the SMS risk matrix, typically ranging from 1 (lowest risk) to 25 (highest risk). Used for quantitative risk prioritization and trending.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause(s) that led to the finding. May reference human factors, procedural gaps, training deficiencies, equipment failures, or systemic issues. Critical for effective corrective action planning.',
    `sop_reference` STRING COMMENT 'Reference to the specific Standard Operating Procedure (SOP) document, version, or section that was not followed or requires revision as a result of this finding.',
    `station_code` STRING COMMENT 'Three-letter IATA airport code of the station where the finding was identified, if location-specific. Null if finding is not tied to a specific airport or station.. Valid values are `^[A-Z]{3}$`',
    `verification_date` DATE COMMENT 'Date on which the effectiveness of corrective actions was verified by the audit authority or quality assurance team.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual findings raised during safety audits, inspections, or surveillance activities. Captures finding reference number, parent audit reference, finding type (non-conformance/observation/opportunity for improvement), finding category, regulatory reference breached (if applicable), finding description, root cause analysis, risk level assigned to finding, responsible department for resolution, and linkage to corrective actions. Supports IOSA, FAA, EASA, and national CAA audit finding management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`report` (
    `report_id` BIGINT COMMENT 'Unique identifier for the safety report or alert. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Safety reports filed against a specific aircraft (ASR, MOR, SDR) must reference the tail number for regulatory submission to CAA/NTSB/EASA. report.affected_fleet_tail_numbers is a multi-value text fie',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Type-level safety reports (fleet-wide airworthiness concerns, manufacturer safety bulletins) must reference the aircraft type for IOSA/regulatory reporting and fleet-wide safety trend analysis. report',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.audit. Business justification: Safety reports can be issued as direct outputs of safety audits (e.g., audit summary reports, IOSA audit reports). Adding audit_id to report normalizes this relationship and allows direct traceability',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine-specific safety reports (oil contamination events, uncontained failure reports, IFSD reports) must reference the specific engine serial number for regulatory submission (FAA SDR, EASA occurrenc',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Air Safety Reports (ASRs) filed by crew are always associated with a specific flight number for regulatory traceability (ECCAIRS, ASRS). Report has route_id but lacks direct flight_number_id, preventi',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Safety reports can identify hazards. Adding report.hazard_id → hazard.hazard_id links reports to hazards they identify or reference. No redundant columns visible in report schema.',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safety.investigation. Business justification: Reports can trigger or be associated with investigations. Adding report.investigation_id → investigation.investigation_id tracks which investigation a report spawned or references. Removes redundant i',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety reports document occurrences. Adding report.occurrence_id → occurrence.occurrence_id allows linking reports to the master occurrence record. Removes redundant occurrence attributes that should ',
    `profile_id` BIGINT COMMENT 'Foreign key linking to passenger.profile. Business justification: Aviation SMS accepts voluntary safety reports from passengers. Airlines must track which passenger submitted a report for de-identification, follow-up, and regulatory audit purposes. Named process: P',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.member. Business justification: Crew members file Air Safety Reports (ASRs) as a core SMS regulatory requirement. report.reporter_role is a denormalized text field; a proper FK to the reporting crew member enables SMS traceability, ',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Safety reports (ASR, MOR, ASRS) often reference specific routes for context. Required for route safety trend analysis, regulatory reporting, and route risk profiling. Links report to route entity.',
    `acknowledgement_count` STRING COMMENT 'Number of required recipients who have acknowledged the safety communication.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Indicates whether recipients are required to formally acknowledge receipt and understanding of the safety communication. True/False.',
    `affected_aircraft_types` STRING COMMENT 'Comma-separated list of aircraft type codes affected by the safety alert or bulletin.',
    `affected_fleet_tail_numbers` STRING COMMENT 'Comma-separated list of specific aircraft registrations in the fleet affected by the safety alert or bulletin.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the safety report was closed after all required actions and reviews were completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `compliance_deadline` DATE COMMENT 'Date by which required actions must be completed for safety alerts and bulletins. Format: yyyy-MM-dd.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this safety report record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `de_identification_flag` BOOLEAN COMMENT 'Indicates whether personally identifiable information has been removed from the report to protect reporter identity under Just Culture principles. True/False.',
    `distribution_status` STRING COMMENT 'Status of distribution of the safety alert or bulletin to relevant personnel and departments.. Valid values are `pending|distributed|acknowledged`',
    `distribution_timestamp` TIMESTAMP COMMENT 'Date and time when the safety alert or bulletin was distributed to the organization. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether the safety event requires formal investigation. True/False.',
    `issuing_authority` STRING COMMENT 'Name of the external authority or organization that issued the safety alert, bulletin, or communication (e.g., FAA, EASA, manufacturer). Null for internal voluntary/mandatory reports.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this safety report record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `narrative` STRING COMMENT 'Detailed free-text narrative describing the safety event, circumstances, and observations. May be de-identified for confidential reports.',
    `notam_reference` STRING COMMENT 'Reference number of related NOTAM (Notice to Air Missions) if the safety event resulted in operational restrictions or notifications.. Valid values are `^[A-Z0-9]{8,15}$`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the safety report or alert for tracking and citation purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `regulatory_notification_flag` BOOLEAN COMMENT 'Indicates whether the safety event was reported to external regulatory authorities (FAA, EASA, etc.). True/False.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the safety event was reported to external regulatory authorities. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `report_status` STRING COMMENT 'Current processing status of the safety report in the SMS workflow.. Valid values are `submitted|under_review|classified|closed|distributed`',
    `report_type` STRING COMMENT 'Classification of the safety report: voluntary (crew-initiated), mandatory (regulatory requirement), confidential (anonymous), safety_alert (urgent communication), SIB (Safety Information Bulletin), SAFO (Safety Alert for Operators).. Valid values are `voluntary|mandatory|confidential|safety_alert|SIB|SAFO`',
    `reporter_role` STRING COMMENT 'Functional role of the person who submitted the safety report.. Valid values are `pilot|cabin_crew|maintenance|ground_staff|dispatcher|other`',
    `required_action_description` STRING COMMENT 'Description of corrective actions, compliance requirements, or operational changes required in response to the safety alert or bulletin.',
    `severity_level` STRING COMMENT 'Initial assessed severity or risk level of the safety event.. Valid values are `critical|high|medium|low|informational`',
    `subject` STRING COMMENT 'Brief subject line or title summarizing the safety report or alert.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the safety report was submitted or the alert was issued. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `urgency_level` STRING COMMENT 'Urgency classification for safety alerts and bulletins indicating required response timeframe.. Valid values are `immediate|urgent|routine`',
    CONSTRAINT pk_report PRIMARY KEY(`report_id`)
) COMMENT 'Voluntary and mandatory safety reports, safety alerts, safety information bulletins, and urgent safety communications submitted by crew/staff or received from external authorities through the airlines safety reporting and communication system. Captures report/alert reference number, report type (voluntary/mandatory/confidential/safety_alert/SIB/SAFO/manufacturer_bulletin), reporter or issuing authority, submission/issue date, event date, event location, flight phase, narrative/subject, initial classification, affected aircraft types, urgency level, required action description, compliance deadline, acknowledgement tracking, de-identification status, distribution status, and processing status. Supports Just Culture principles, ICAO Annex 19 safety reporting requirements, and timely dissemination of safety-critical information.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Unique identifier for the safety investigation record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Investigations require complete aircraft history including maintenance records, configuration changes, and prior occurrences. Direct link enables investigation teams to access aircraft technical data,',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Investigations incur costs (investigator time, travel, external experts, lab analysis, CVR/FDR readout) tracked to cost centres. investigation_cost_estimate field requires cost centre allocation for b',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine investigations require detailed engine history including TSN/CSN, shop visit records, LLP status, and component traceability by ESN. Direct link enables investigation teams to access complete e',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Investigations often span or reference specific flight inventory records directly for evidence (load sheets, passenger manifests, seat availability data). Investigation links to occurrence but investi',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Accident/incident investigations (ATSB, NTSB, EASA) are formally initiated against a specific flight number. Investigation has route_id but a direct flight_number_id is required for regulatory investi',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Aviation SMS investigations incur costs (external experts, CVR/FDR analysis, regulatory fees) requiring GL-level posting for financial reporting. ICAO Annex 13 investigations with cost tracking need G',
    `occurrence_id` BIGINT COMMENT 'Reference to the safety occurrence that triggered this investigation.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to passenger.profile. Business justification: Passenger injury investigations require direct reference to the injured or witness passengers profile for regulatory reporting (ICAO Annex 13), injury documentation, and next-of-kin notification. The',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to ancillary.product_catalog. Business justification: Investigations into product-related incidents (seat malfunction, dangerous goods product failure, food poisoning from catering ancillary) require direct reference to the implicated ancillary product. ',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Investigations under ICAO Annex 13 produce or update formal risk assessments as part of the safety management process. The investigation table already has a boolean flag risk_assessment_updated indi',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Investigations analyze route-specific factors (airspace design, terrain, weather patterns, ATC procedures). Required for route safety case updates, ETOPS reviews, and route authority renewals. Links i',
    `hazard_id` BIGINT COMMENT 'Reference to the SMS hazard record that was identified or updated as a result of this investigation. Links investigation findings back to the hazard identification and risk assessment process.',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.member. Business justification: Safety investigations involve specific crew members as subjects or key witnesses. investigation.team_members is a denormalized text field. A FK to the subject crew member supports regulatory investiga',
    `acars_data_reviewed` BOOLEAN COMMENT 'Indicates whether ACARS (Aircraft Communications Addressing and Reporting System) messages and data were reviewed as part of the investigation.',
    `actual_completion_date` DATE COMMENT 'Actual date when the investigation was completed and the final report was issued. Null if investigation is still in progress.',
    `causal_factors_identified` STRING COMMENT 'Detailed description of the root causal factors identified during the investigation that directly led to the occurrence. May include human factors, technical failures, procedural deficiencies, or organizational factors.',
    `contributing_factors` STRING COMMENT 'Description of contributing factors that did not directly cause the occurrence but increased the likelihood or severity of the event. May include environmental conditions, latent organizational weaknesses, or systemic issues.',
    `corrective_actions_required` STRING COMMENT 'Description of mandatory corrective actions required to address the causal and contributing factors identified in the investigation. Links to corrective action tracking systems.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost of conducting the investigation, including personnel time, external consultants, laboratory analysis, travel, and administrative expenses. Expressed in the airlines reporting currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was first created in the system.',
    `cvr_fdr_data_reviewed` BOOLEAN COMMENT 'Indicates whether CVR (Cockpit Voice Recorder) and FDR (Flight Data Recorder) data were reviewed as part of the investigation. True if recorder data were analyzed, false otherwise.',
    `external_expert_consulted` BOOLEAN COMMENT 'Indicates whether external subject matter experts, technical specialists, or consultants were engaged to support the investigation.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation: open (assigned but not started), in-progress (active investigation), draft-report (findings being documented), final (report completed), closed (all actions complete), suspended (temporarily halted).. Valid values are `open|in-progress|draft-report|final|closed|suspended`',
    `investigation_type` STRING COMMENT 'Classification of the investigation scope and authority: internal SMS investigation, regulatory authority-led investigation, joint investigation with multiple parties, independent third-party investigation, or preliminary investigation.. Valid values are `internal|regulatory|joint|independent|preliminary`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for investigator notes, observations, and supplementary information that may not fit structured fields. May include interim findings, open questions, or areas requiring further investigation.',
    `priority` STRING COMMENT 'Priority level assigned to the investigation based on severity of the occurrence, potential safety impact, and regulatory requirements.. Valid values are `critical|high|medium|low`',
    `reference_number` STRING COMMENT 'External reference number assigned to this investigation for tracking and regulatory reporting purposes. May include NTSB, AAIB, BEA, or national AIB case numbers.',
    `regulatory_authority_notified` STRING COMMENT 'Regulatory or accident investigation authority that was notified of this investigation. NTSB (US National Transportation Safety Board), AAIB (UK Air Accidents Investigation Branch), BEA (French Bureau of Enquiry and Analysis), TSB (Transportation Safety Board of Canada), JTSB (Japan Transport Safety Board), or national AIB. [ENUM-REF-CANDIDATE: NTSB|AAIB|BEA|EASA|FAA|TSB|JTSB|national-AIB|none — 9 candidates stripped; promote to reference product]',
    `regulatory_notification_date` DATE COMMENT 'Date when the regulatory authority was formally notified of the occurrence and investigation, as required by ICAO Annex 13 and national regulations.',
    `regulatory_notification_status` STRING COMMENT 'Status of regulatory authority notification: not-required (internal investigation only), pending (notification required but not yet sent), notified (authority has been informed), acknowledged (authority confirmed receipt), under-review (authority is actively reviewing).. Valid values are `not-required|pending|notified|acknowledged|under-review`',
    `report_reference` STRING COMMENT 'Reference identifier or document management system link to the formal investigation report, including preliminary, interim, and final reports.',
    `risk_assessment_updated` BOOLEAN COMMENT 'Indicates whether the SMS risk assessment was updated based on the findings of this investigation. True if risk matrices or risk registers were revised.',
    `safety_recommendations_issued` STRING COMMENT 'Detailed list of safety recommendations issued as a result of the investigation findings. Recommendations may address procedural changes, training enhancements, equipment modifications, or policy updates.',
    `start_date` DATE COMMENT 'Date when the formal investigation was initiated and the investigation team was assigned.',
    `target_completion_date` DATE COMMENT 'Planned or regulatory-mandated date by which the investigation should be completed and final report issued.',
    `team_members` STRING COMMENT 'Comma-separated list or structured text identifying all members of the investigation team, including subject matter experts, technical specialists, and support personnel.',
    `witness_statements_collected` BOOLEAN COMMENT 'Indicates whether witness statements from crew, passengers, ground personnel, or other parties were collected and documented as part of the investigation.',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Safety investigation records for occurrences requiring formal investigation under ICAO Annex 13 or internal SMS investigation procedures. Captures investigation reference number, linked occurrence, investigation type (internal/regulatory/joint), lead investigator, investigation team, investigation start date, target completion date, actual completion date, investigation status (open/in-progress/draft-report/final/closed), causal factors identified, contributing factors, safety recommendations issued, and regulatory authority notification status (NTSB/AAIB/BEA/national AIB).';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`recommendation` (
    `recommendation_id` BIGINT COMMENT 'Unique identifier for the safety recommendation record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: NTSB/AAIB/BEA safety recommendations are frequently issued against specific aircraft types (e.g., B737 MAX MCAS recommendations). Tracking recommendations by aircraft_type enables operators to monitor',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Safety recommendations require budget allocation to cost centres for implementation. estimated_implementation_cost field needs cost centre linkage for financial planning, budget approval workflows, an',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Formal safety recommendations are frequently issued to address specific identified hazards in the SMS hazard register, independent of a specific occurrence or investigation. Adding hazard_id to recomm',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Safety recommendations are often direct outputs of formal risk assessments — the risk assessment process identifies residual risk and generates recommendations to reduce it to tolerable levels (ALARP)',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Safety recommendations may be route-specific (procedure changes, equipment requirements, crew qualification). Required for tracking route-level safety improvements and regulatory compliance. Links rec',
    `audit_id` BIGINT COMMENT 'Reference to the safety audit or inspection that generated this recommendation, if applicable. Links to audit record in safety management system.',
    `occurrence_id` BIGINT COMMENT 'Reference to the safety occurrence or event that triggered this recommendation, if applicable. Links to occurrence reporting system.',
    `actual_implementation_date` DATE COMMENT 'Actual date when the recommended action was fully implemented and verified.',
    `addressee_department` STRING COMMENT 'Internal department or organizational unit responsible for responding to and implementing the recommendation (e.g., Flight Operations, Maintenance, Training, Ground Operations).',
    `addressee_external_organization` STRING COMMENT 'External organization or regulatory authority to whom the recommendation is addressed, if applicable (e.g., FAA, EASA, aircraft manufacturer, airport authority).',
    `closure_date` DATE COMMENT 'Date when the recommendation was formally closed after verification of successful implementation and effectiveness.',
    `closure_verification_method` STRING COMMENT 'Method used to verify that the recommendation has been effectively implemented (e.g., audit, inspection, documentation review, operational monitoring, SMS assessment).',
    `closure_verified_by` STRING COMMENT 'Name or role of the individual or body that verified and approved closure of the recommendation (e.g., Safety Manager, SMS Committee, external auditor).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated implementation cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recommendation record was first created in the safety management system.',
    `effectiveness_assessment` STRING COMMENT 'Narrative assessment of the effectiveness of the implemented recommendation in achieving its intended safety improvement, based on operational data and monitoring.',
    `effectiveness_review_date` DATE COMMENT 'Scheduled date for post-implementation review to assess the effectiveness of the implemented recommendation in reducing safety risk.',
    `estimated_implementation_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the recommendation, including capital expenditure, operational changes, training, and ongoing costs. Used for resource planning and cost-benefit analysis.',
    `implementation_action_plan` STRING COMMENT 'Detailed description of the corrective actions, procedural changes, or system modifications planned or executed to implement the recommendation.',
    `issue_date` DATE COMMENT 'Date when the safety recommendation was formally issued by the originating authority or body.',
    `issuing_authority` STRING COMMENT 'Name of the organization or body that issued the recommendation (e.g., NTSB, AAIB, BEA, internal Safety Department, SMS Committee).',
    `issuing_authority_code` STRING COMMENT 'Standardized code for the issuing authority (e.g., NTSB for National Transportation Safety Board, AAIB for Air Accidents Investigation Branch, FAA for Federal Aviation Administration, EASA for European Union Aviation Safety Agency).. Valid values are `^[A-Z]{2,5}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recommendation record was last updated, reflecting the most recent status change or information update.',
    `priority_level` STRING COMMENT 'Urgency and importance classification of the recommendation based on safety risk: critical (immediate action required), high (prompt action needed), medium (action within normal timeframe), or low (action when resources permit).. Valid values are `critical|high|medium|low`',
    `recommendation_status` STRING COMMENT 'Current lifecycle status of the safety recommendation: open (newly issued), under_review (being evaluated), accepted (approved for action), in_progress (implementation underway), implemented (action completed), closed (verified and closed), rejected (not accepted with justification), or superseded (replaced by newer recommendation). [ENUM-REF-CANDIDATE: open|under_review|accepted|in_progress|implemented|closed|rejected|superseded — 8 candidates stripped; promote to reference product]',
    `recommendation_text` STRING COMMENT 'Full text of the safety recommendation as issued, describing the specific action or change recommended to improve safety.',
    `recommendation_type` STRING COMMENT 'Classification of the recommendation based on its origin: internal (generated by airline), external_received (from national AIB or other authority), regulatory_mandate (required by regulator), audit_finding (from safety audit), proactive_study (from safety analysis), or sms_output (from SMS process).. Valid values are `internal|external_received|regulatory_mandate|audit_finding|proactive_study|sms_output`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the safety recommendation, typically following format AAA-YYYY-NNN where AAA is issuing authority code, YYYY is year, and NNN is sequence number.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4}-[0-9]{3,4}$`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this recommendation is mandated by regulatory authority and requires formal compliance response (true) or is advisory/voluntary (false).',
    `rejection_justification` STRING COMMENT 'Detailed justification provided when a recommendation is rejected, including technical, operational, or economic rationale and alternative mitigations if applicable.',
    `response_due_date` DATE COMMENT 'Date by which a formal response to the recommendation is required, particularly for external recommendations from regulatory authorities or AIBs.',
    `response_narrative` STRING COMMENT 'Detailed narrative of the airlines response to the recommendation, including acceptance rationale, implementation plan, or justification for rejection.',
    `response_submitted_date` DATE COMMENT 'Date when the formal response to the recommendation was submitted to the issuing authority.',
    `responsible_person_name` STRING COMMENT 'Name of the individual assigned primary responsibility for coordinating the response and implementation of the recommendation.',
    `responsible_person_role` STRING COMMENT 'Job title or role of the individual responsible for the recommendation (e.g., Chief Pilot, Director of Safety, Maintenance Manager, Training Manager).',
    `safety_risk_category` STRING COMMENT 'Classification of the safety risk addressed by this recommendation (e.g., flight operations, maintenance, ground handling, crew fatigue, airworthiness, ATC coordination).',
    `sms_integration_flag` BOOLEAN COMMENT 'Indicates whether this recommendation has been formally integrated into the airlines SMS processes and risk register (true) or remains external tracking only (false).',
    `summary` STRING COMMENT 'Brief executive summary or title of the recommendation for quick reference and reporting purposes.',
    `target_implementation_date` DATE COMMENT 'Target or required date by which the recommendation should be implemented. May be mandated by regulator or set internally based on risk assessment.',
    CONSTRAINT pk_recommendation PRIMARY KEY(`recommendation_id`)
) COMMENT 'Formal safety recommendations issued as outputs of investigations, audits, or proactive safety studies. Captures recommendation reference number, source investigation or audit, recommendation text, addressee (internal department or external authority), priority level, target implementation date, implementation status, response narrative, and closure verification. Tracks both internally generated recommendations and those received from national Accident Investigation Bodies (AIBs) requiring airline response.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`alert` (
    `alert_id` BIGINT COMMENT 'Unique identifier for the safety alert record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Safety alerts targeting specific tail numbers (post-incident fleet checks, AD compliance on individual aircraft) require a direct FK to the aircraft. alert.affected_fleet_tail_numbers is a denormalize',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Safety alerts (airworthiness directives, manufacturer service bulletins) are issued for specific aircraft types. Proper FK enables automated alert distribution to affected fleet, compliance tracking, ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.audit. Business justification: Safety alerts can be issued as a direct result of audit findings or audit outcomes (e.g., an urgent safety communication following a critical audit finding). Adding audit_id to alert enables direct li',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Cabin-specific safety alerts (seat AD compliance, IFE fire risk bulletins, emergency equipment configuration alerts) must reference the specific cabin configuration to determine applicability. Aviatio',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Safety alerts (Airworthiness Directives, safety bulletins) drive mandatory compliance actions with significant costs attributed to specific cost centres (maintenance, flight ops). Aviation finance tra',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine-specific safety alerts (airworthiness directives on specific engine serial numbers, service bulletins targeting individual engines) require a direct FK to the engine. Aviation maintenance contr',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Alerts are issued for specific hazards to communicate risk and required actions. Adding alert.hazard_id → hazard.hazard_id links alerts to the hazards they address. No redundant columns visible.',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safety.investigation. Business justification: Safety alerts can be issued in response to investigations or to communicate investigation findings. Adding alert.investigation_id → investigation.investigation_id tracks the source investigation. No r',
    `occurrence_id` BIGINT COMMENT 'Reference to the occurrence report that triggered or is associated with this alert. Null if alert is not linked to a specific occurrence.',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to ancillary.product_catalog. Business justification: Safety alerts (e.g., dangerous goods bulletins, recalled cabin product notices) are issued against specific ancillary products. Airlines must distribute product-specific safety alerts to cabin crew an',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Alerts can be issued to communicate formal safety recommendations to operational teams. Adding alert.recommendation_id → recommendation.recommendation_id tracks which recommendation the alert communic',
    `report_id` BIGINT COMMENT 'Foreign key linking to safety.report. Business justification: Safety alerts (safety information bulletins, urgent safety communications) are frequently issued in response to or referencing a specific safety report. Adding report_id to alert establishes direct tr',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Safety alerts may be route-specific (weather, NOTAM, airspace restrictions, political risk). Required for operational control, dispatch decision-making, and crew briefing. Links alert to affected rout',
    `superseded_by_alert_id` BIGINT COMMENT 'Reference to the alert_id of a newer alert that replaces or supersedes this alert. Null if this alert is still current.',
    `acknowledgement_count` STRING COMMENT 'Number of departments or individuals who have formally acknowledged receipt of this alert.',
    `acknowledgement_deadline` DATE COMMENT 'Date by which all required departments and personnel must acknowledge receipt of the alert. Null if no acknowledgement is required.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Indicates whether recipients must formally acknowledge receipt and understanding of this alert (True) or if acknowledgement is optional (False).',
    `affected_fleet_tail_numbers` STRING COMMENT 'Comma-separated list of specific aircraft registration numbers (tail numbers) affected by this alert. Empty if alert applies broadly by aircraft type rather than specific airframes.',
    `affected_operations` STRING COMMENT 'Description of the operational areas, flight phases, or activities impacted by this alert (e.g., ETOPS operations, CAT III approaches, cargo operations, maintenance procedures).',
    `alert_description` STRING COMMENT 'Detailed narrative describing the safety issue, hazard, or concern that prompted the alert, including background context and technical details.',
    `alert_status` STRING COMMENT 'Current lifecycle status of the safety alert: draft (under preparation), issued (distributed to stakeholders), acknowledged (receipt confirmed by departments), complied (required actions completed), closed (alert lifecycle complete), or superseded (replaced by newer alert).. Valid values are `draft|issued|acknowledged|complied|closed|superseded`',
    `alert_type` STRING COMMENT 'Classification of the safety alert by its originating source: internal (airline-issued), EASA SIB (European Union Aviation Safety Agency Safety Information Bulletin), FAA SAFO (Federal Aviation Administration Safety Alert for Operators), manufacturer (OEM safety bulletin), IATA (International Air Transport Association safety alert), or ICAO NOTAM (International Civil Aviation Organization Notice to Air Missions).. Valid values are `internal|easa_sib|faa_safo|manufacturer|iata|icao_notam`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was formally closed after all required actions were completed and verified. Null if alert is still open.',
    `compliance_deadline` DATE COMMENT 'Date by which the required actions must be completed to maintain regulatory compliance and operational safety. Null if no specific deadline is mandated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was first created in the safety management system.',
    `distribution_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was distributed to internal departments and operational personnel.',
    `issue_date` DATE COMMENT 'Date on which the safety alert was officially issued by the originating authority.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise date and time when the safety alert was issued, including timezone information for global coordination.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, manufacturer, or internal department that issued the safety alert (e.g., EASA, FAA, Boeing, Airbus, Safety Department).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was most recently updated or modified.',
    `manufacturer_bulletin_reference` STRING COMMENT 'Reference number of the original equipment manufacturer (OEM) safety bulletin or service bulletin that this alert is based on or references. Null if not applicable.',
    `notam_reference` STRING COMMENT 'Reference number of the associated NOTAM if this alert relates to a published Notice to Air Missions. Null if not applicable.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or supplementary information related to the alert, its distribution, or implementation.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the safety alert for tracking and citation purposes (e.g., EASA-2024-00123, FAA-SAFO-2024-05).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$`',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was formally reported to the relevant regulatory authority (FAA, EASA, national CAA). Null if not yet reported or not reportable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this alert must be reported to external regulatory authorities (True) or is for internal use only (False).',
    `required_action_description` STRING COMMENT 'Detailed description of the corrective or preventive actions that must be taken in response to this alert, including specific procedures, inspections, or operational changes.',
    `responsible_department` STRING COMMENT 'Name of the primary department responsible for coordinating the response to this alert and ensuring compliance with required actions (e.g., Flight Operations, Maintenance, Safety Department).',
    `severity_level` STRING COMMENT 'Assessment of the potential safety impact if the alert is not addressed: catastrophic (multiple fatalities, hull loss), hazardous (serious injury, major damage), major (significant injury or damage), minor (minor injury or damage), or negligible (minimal impact).. Valid values are `catastrophic|hazardous|major|minor|negligible`',
    `subject` STRING COMMENT 'Concise subject line or title summarizing the safety concern addressed by the alert.',
    `target_recipient_count` STRING COMMENT 'Total number of departments or individuals to whom this alert was distributed and from whom acknowledgement is expected.',
    `urgency_level` STRING COMMENT 'Priority classification indicating the time-sensitivity and criticality of the alert: critical (immediate action required), high (urgent attention needed), medium (timely response required), low (routine attention), or informational (awareness only).. Valid values are `critical|high|medium|low|informational`',
    CONSTRAINT pk_alert PRIMARY KEY(`alert_id`)
) COMMENT 'Safety alerts, safety information bulletins, and urgent safety communications issued internally or received from external sources (EASA Safety Information Bulletins, FAA SAFOs, manufacturer safety bulletins, IATA safety alerts). Captures alert reference number, alert type (internal/EASA SIB/FAA SAFO/manufacturer/IATA), issuing authority, issue date, subject, affected aircraft types, affected operations, urgency level, required action description, compliance deadline, acknowledgement tracking by department, and distribution status. Ensures timely dissemination and tracking of safety-critical information across all operational departments.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `airlines_ecm`.`safety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `airlines_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `airlines_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_superseded_by_alert_id` FOREIGN KEY (`superseded_by_alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`safety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`safety` SET TAGS ('dbx_domain' = 'safety');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` SET TAGS ('dbx_subdomain' = 'incident_reporting');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence ID');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `etops_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Etops Authorization Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `inventory_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Pax Profile Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `seasonal_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Schedule Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `actual_altitude_ft` SET TAGS ('dbx_business_glossary_term' = 'Actual Altitude (Feet)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `aircraft_damage_level` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Damage Level');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `aircraft_damage_level` SET TAGS ('dbx_value_regex' = 'destroyed|substantial|minor|none');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Arrival Airport Code');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'ICAO Occurrence Category Code');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Classification');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'accident|serious_incident|incident|occurrence');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `cleared_altitude_ft` SET TAGS ('dbx_business_glossary_term' = 'Cleared Altitude (Feet)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Class');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `dangerous_goods_un_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods UN Number');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `dangerous_goods_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Departure Airport Code');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `fatalities_count` SET TAGS ('dbx_business_glossary_term' = 'Fatalities Count');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `flight_phase` SET TAGS ('dbx_business_glossary_term' = 'Flight Phase');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `initial_causal_factors` SET TAGS ('dbx_business_glossary_term' = 'Initial Causal Factors');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity Level');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'fatal|serious|minor|none');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Latitude');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Location Description');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Longitude');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `minor_injuries_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Injuries Count');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `narrative_description` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Narrative Description');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `occurrence_number` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `occurrence_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `packaging_failure_description` SET TAGS ('dbx_business_glossary_term' = 'Packaging Failure Description');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `reporter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `reporting_source` SET TAGS ('dbx_business_glossary_term' = 'Reporting Source');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `runway_designator` SET TAGS ('dbx_business_glossary_term' = 'Runway Designator');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `runway_designator` SET TAGS ('dbx_value_regex' = '^[0-9]{2}[LCR]?$');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `runway_incursion_severity` SET TAGS ('dbx_business_glossary_term' = 'Runway Incursion Severity Category');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `runway_incursion_severity` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `serious_injuries_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Injuries Count');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Subtype');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `wildlife_ingestion_flag` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Ingestion Flag');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `wildlife_species` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Species');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `wildlife_strike_location` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Strike Location on Aircraft');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `etops_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Etops Authorization Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `affected_operations_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Operations Area');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Hazard Closure Date');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `current_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Current Likelihood Rating');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `current_likelihood_rating` SET TAGS ('dbx_value_regex' = 'frequent|occasional|remote|improbable|extremely_improbable');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `current_risk_index` SET TAGS ('dbx_business_glossary_term' = 'Current Risk Index');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `current_severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Current Severity Rating');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `current_severity_rating` SET TAGS ('dbx_value_regex' = 'catastrophic|hazardous|major|minor|negligible');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_category` SET TAGS ('dbx_value_regex' = 'operational|technical|organizational|environmental|human_factors|external');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_number` SET TAGS ('dbx_business_glossary_term' = 'Hazard Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_number` SET TAGS ('dbx_value_regex' = '^HAZ-[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Status');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_status` SET TAGS ('dbx_value_regex' = 'open|under_review|mitigation_in_progress|mitigated|closed|accepted');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `identification_source` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identification Source');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identification Date');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `initial_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Initial Likelihood Rating');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `initial_likelihood_rating` SET TAGS ('dbx_value_regex' = 'frequent|occasional|remote|improbable|extremely_improbable');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `initial_risk_index` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Index');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `initial_severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Initial Severity Rating');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `initial_severity_rating` SET TAGS ('dbx_value_regex' = 'catastrophic|hazardous|major|minor|negligible');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `mitigation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Target Date');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `notam_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'NOTAM (Notice to Air Missions) Issued Flag');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hazard Notes');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Hazard Review Date');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `sop_revision_required_flag` SET TAGS ('dbx_business_glossary_term' = 'SOP (Standard Operating Procedure) Revision Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Hazard Subcategory');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Hazard Title');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `affected_operations` SET TAGS ('dbx_business_glossary_term' = 'Affected Flight Operations');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Methodology');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_narrative` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Narrative Justification');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|closed|superseded');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Team Members');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|residual|reviewed|reassessment|periodic');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Full Name');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Data Sources');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `existing_controls_summary` SET TAGS ('dbx_business_glossary_term' = 'Existing Controls Summary');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `notification_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Risk Mitigation Actions');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `regulatory_authority_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified Flag');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Review Date');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'operational|technical|organizational|environmental|human_factors|security');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_index` SET TAGS ('dbx_business_glossary_term' = 'Risk Index');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_matrix_quadrant` SET TAGS ('dbx_business_glossary_term' = 'Risk Matrix Quadrant');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_tolerance_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Level');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_tolerance_level` SET TAGS ('dbx_value_regex' = 'acceptable|tolerable|intolerable');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Title');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|mitigating|recommendation');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `addressee_response` SET TAGS ('dbx_business_glossary_term' = 'Addressee Response');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed_effective|closed_superseded|closed_not_required|closed_ineffective');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|under_review');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `external_addressee` SET TAGS ('dbx_business_glossary_term' = 'External Addressee');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `implementation_evidence` SET TAGS ('dbx_business_glossary_term' = 'Implementation Evidence');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `regulatory_tracking_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tracking Reference');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email Address');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `source_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'occurrence|hazard|audit|investigation|risk_assessment|external_recommendation');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|site_inspection|audit|test|observation|interview');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|not_applicable');
ALTER TABLE `airlines_ecm`.`safety`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`audit` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_sms|iosa_preparation|regulatory_authority|losa|line_station|maintenance');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audited_department` SET TAGS ('dbx_business_glossary_term' = 'Audited Department');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audited_function` SET TAGS ('dbx_business_glossary_term' = 'Audited Function');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Required');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `iosa_registration_number` SET TAGS ('dbx_business_glossary_term' = 'IATA Operational Safety Audit (IOSA) Registration Number');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `iosa_registration_number` SET TAGS ('dbx_value_regex' = '^IOSA-[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `overall_finding_summary` SET TAGS ('dbx_business_glossary_term' = 'Overall Finding Summary');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `regulatory_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Reference');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Reference');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `sms_accountable_executive_notified` SET TAGS ('dbx_business_glossary_term' = 'Safety Management System (SMS) Accountable Executive Notified');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Standard Reference');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `audit_organization` SET TAGS ('dbx_business_glossary_term' = 'Audit Organization');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'non-conformance|observation|opportunity_for_improvement|positive_finding|minor_finding|major_finding');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `notam_reference` SET TAGS ('dbx_business_glossary_term' = 'Notice to Air Missions (NOTAM) Reference');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `sop_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Reference');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code (IATA Airport Code)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`safety`.`report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`report` SET TAGS ('dbx_subdomain' = 'incident_reporting');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Report Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Pax Profile Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `acknowledgement_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Count');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `affected_aircraft_types` SET TAGS ('dbx_business_glossary_term' = 'Affected Aircraft Types');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `affected_fleet_tail_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Fleet Tail Numbers');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Closed Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `de_identification_flag` SET TAGS ('dbx_business_glossary_term' = 'De-Identification Flag');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|distributed|acknowledged');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Event Narrative');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `notam_reference` SET TAGS ('dbx_business_glossary_term' = 'Notice to Air Missions (NOTAM) Reference');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `notam_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `regulatory_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Flag');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Processing Status');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|classified|closed|distributed');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'voluntary|mandatory|confidential|safety_alert|SIB|SAFO');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `reporter_role` SET TAGS ('dbx_business_glossary_term' = 'Reporter Role');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `reporter_role` SET TAGS ('dbx_value_regex' = 'pilot|cabin_crew|maintenance|ground_staff|dispatcher|other');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `required_action_description` SET TAGS ('dbx_business_glossary_term' = 'Required Action Description');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Report Subject');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'immediate|urgent|routine');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` SET TAGS ('dbx_subdomain' = 'incident_reporting');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Pax Profile Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Management System (SMS) Hazard Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `acars_data_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Communications Addressing and Reporting System (ACARS) Data Reviewed');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `causal_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Causal Factors Identified');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Investigation Cost Estimate');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `cvr_fdr_data_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Cockpit Voice Recorder (CVR) and Flight Data Recorder (FDR) Data Reviewed');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `external_expert_consulted` SET TAGS ('dbx_business_glossary_term' = 'External Expert Consulted');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in-progress|draft-report|final|closed|suspended');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'internal|regulatory|joint|independent|preliminary');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|notified|acknowledged|under-review');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Investigation Report Reference');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `risk_assessment_updated` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Updated');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `safety_recommendations_issued` SET TAGS ('dbx_business_glossary_term' = 'Safety Recommendations Issued');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team Members');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `witness_statements_collected` SET TAGS ('dbx_business_glossary_term' = 'Witness Statements Collected');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Source Audit Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Source Occurrence Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `addressee_department` SET TAGS ('dbx_business_glossary_term' = 'Addressee Department');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `addressee_external_organization` SET TAGS ('dbx_business_glossary_term' = 'Addressee External Organization');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `closure_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Closure Verification Method');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `closure_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Closure Verified By');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `effectiveness_assessment` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Assessment');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Cost');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `implementation_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Implementation Action Plan');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Status');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `recommendation_text` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Text');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Type');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_value_regex' = 'internal|external_received|regulatory_mandate|audit_finding|proactive_study|sms_output');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4}-[0-9]{3,4}$');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `rejection_justification` SET TAGS ('dbx_business_glossary_term' = 'Rejection Justification');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `response_narrative` SET TAGS ('dbx_business_glossary_term' = 'Response Narrative');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `responsible_person_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Role');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `safety_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Safety Risk Category');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `sms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Management System (SMS) Integration Flag');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Summary');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `target_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Implementation Date');
ALTER TABLE `airlines_ecm`.`safety`.`alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`alert` SET TAGS ('dbx_subdomain' = 'incident_reporting');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `superseded_by_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Alert Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgement_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Count');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgement_deadline` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Deadline');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `affected_fleet_tail_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Fleet Tail Numbers');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `affected_operations` SET TAGS ('dbx_business_glossary_term' = 'Affected Operations');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `alert_description` SET TAGS ('dbx_business_glossary_term' = 'Alert Description');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'draft|issued|acknowledged|complied|closed|superseded');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'internal|easa_sib|faa_safo|manufacturer|iata|icao_notam');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `manufacturer_bulletin_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Bulletin Reference');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `notam_reference` SET TAGS ('dbx_business_glossary_term' = 'Notice to Air Missions (NOTAM) Reference');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Alert Notes');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `required_action_description` SET TAGS ('dbx_business_glossary_term' = 'Required Action Description');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'catastrophic|hazardous|major|minor|negligible');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Alert Subject');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `target_recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Target Recipient Count');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
