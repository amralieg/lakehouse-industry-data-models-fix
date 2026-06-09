-- Schema for Domain: safety | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`safety` COMMENT 'Aviation safety management including SMS (Safety Management System), incident and occurrence reporting, accident investigation, CVR (Cockpit Voice Recorder) and FDR (Flight Data Recorder) event analysis, NOTAM (Notice to Air Missions) tracking, hazard identification, risk assessment, safety audits, corrective action plans, SOP version control, and fatigue risk management. SSOT for all safety occurrence and risk data. Aligns with ICAO Annex 19 SMS framework.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`occurrence` (
    `occurrence_id` BIGINT COMMENT 'Unique identifier for the safety occurrence record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Every safety occurrence in aviation must be tracked to specific aircraft for regulatory reporting (ICAO Annex 13), trend analysis, and airworthiness monitoring. Occurrence.aircraft_registration is den',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Fleet safety analysis requires occurrence trending by aircraft type for manufacturer safety bulletins, type-specific risk assessment, and fleet-wide safety performance monitoring. Standard practice in',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Airlines run safety transparency campaigns citing occurrence statistics (e.g., Our Safety Record campaigns). Real business process: safety communications campaigns reference specific occurrence data',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Safety occurrences generate direct costs (investigations, repairs, AOG, insurance deductibles) that must be allocated to specific cost centres for budget tracking and financial reporting. Standard air',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine-related occurrences (IFSD, failure, fire) must be tracked to specific engine serial numbers for trend analysis, manufacturer reporting (per FAA Part 21), and warranty claims. Enables engine rel',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Safety occurrence investigation and regulatory reporting (ICAO Annex 13, FAA Part 830) requires linking incidents to specific flight inventory records for passenger impact assessment, load factor anal',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Flight numbers are primary identifiers in safety reporting (ICAO ADREP, FAA ASRS). Links occurrence to specific flight number registration for codeshare liability, slot performance tracking, and regul',
    `fuel_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_contract. Business justification: Fuel quality incidents (contamination, wrong grade) link to fuel contracts. Regulatory reporting, supplier performance evaluation, and contract compliance verification require tracking which contract ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Major occurrences trigger GL postings for insurance claim reserves, liability accruals, repair cost accruals, and asset impairments. Required for IFRS compliance and financial statement accuracy in ai',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Occurrences may involve specific part failures or malfunctions. Linking to part master enables fleet-wide safety bulletins, airworthiness directive compliance tracking, and identification of parts req',
    `profile_id` BIGINT COMMENT 'Foreign key linking to passenger.profile. Business justification: Accessibility-related safety occurrences (wheelchair damage, mobility aid failures, service animal incidents, PRM boarding injuries) require linking to passenger accessibility profiles for investigati',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Every occurrence must be assessed against applicable regulatory requirements to determine reportability, compliance status, and notification obligations. Essential for regulatory notification workflow',
    `seasonal_schedule_id` BIGINT COMMENT 'Foreign key linking to route.seasonal_schedule. Business justification: Links safety events to specific schedule instances for operational analysis of schedule-related factors (turnaround pressure, slot timing, crew pairing). Used in schedule safety reviews and slot coord',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Aircraft incidents often involve vendor-supplied parts or services. Root cause analysis, warranty claims, and supplier quality investigations require linking occurrences to responsible vendors for acc',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Safety hazards drive awareness campaigns to crew, ground staff, and passengers (e.g., runway safety campaigns, wildlife strike awareness). Real business process: safety awareness campaigns target iden',
    `employee_id` BIGINT COMMENT 'Identifier of the accountable executive (typically Director of Safety or VP Operations) who has ultimate accountability for this hazard and its mitigation per ICAO SMS requirements.',
    `hazard_employee_id` BIGINT COMMENT 'Identifier of the safety officer or safety manager assigned as the owner of this hazard record, responsible for tracking mitigation and closure.',
    `hazard_reported_by_employee_id` BIGINT COMMENT 'Identifier of the employee or crew member who reported or identified the hazard. May be anonymized per just culture policy.',
    `occurrence_id` BIGINT COMMENT 'Identifier of the safety occurrence or incident report that led to the identification of this hazard. Null if hazard was identified proactively.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Hazards may be part-specific, such as known design defects or reliability issues. SMS proactive risk management requires linking hazards to part master for fleet-wide mitigation, alternative sourcing ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Hazards are assessed against regulatory requirements to determine reportability, risk tolerance, and mitigation obligations. Essential for SMS-compliance integration and demonstrating regulatory adher',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Hazards are often route-specific (terrain clearance, weather patterns, airspace complexity, political risk). Required for route risk registers, ETOPS approval, and route authority applications. Replac',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Hazards may originate from vendor-supplied equipment, parts, or services. SMS risk management requires tracking vendor association for mitigation planning, contract reviews, and supplier development p',
    `affected_operations_area` STRING COMMENT 'Operational domain or business area impacted by the hazard (e.g., flight operations, ground handling, maintenance, cargo, passenger services, crew scheduling).',
    `affected_station` STRING COMMENT 'IATA three-letter airport or station code where the hazard is localized. Null if hazard is not station-specific.. Valid values are `^[A-Z]{3}$`',
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
    `corrective_action_id` BIGINT COMMENT 'Reference to the formal corrective action plan (CAP) initiated in response to this risk assessment. Links risk assessment to mitigation execution. Nullable if no CAP required (acceptable risk).',
    `hazard_id` BIGINT COMMENT 'Reference to the hazard being assessed. Links this risk assessment to the identified hazard in the SMS hazard register.',
    `occurrence_id` BIGINT COMMENT 'Reference to the safety occurrence or incident that triggered this risk assessment. Nullable if assessment is proactive rather than reactive.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who conducted the risk assessment. Must be a qualified safety professional or designated assessor within the SMS organization.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the employee who reviewed and approved the risk assessment. Typically a senior safety manager or accountable executive. Nullable if assessment not yet reviewed.',
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
    `audit_id` BIGINT COMMENT 'Foreign key reference to the safety audit record if this action was raised against an audit finding.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Corrective actions have implementation costs (modifications, training, equipment purchases) that must be budgeted and tracked to specific cost centres. Essential for safety investment tracking and bud',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Corrective action costs (repairs, modifications, training programs, external consultants) post to GL accounts. Links actual_cost field to GL for financial reporting and audit trail of safety expenditu',
    `hazard_id` BIGINT COMMENT 'Foreign key reference to the hazard record if this action was raised against an identified hazard.',
    `investigation_id` BIGINT COMMENT 'Foreign key reference to the accident or incident investigation if this action was raised as a formal investigation recommendation.',
    `occurrence_id` BIGINT COMMENT 'Foreign key reference to the safety occurrence record if this action was raised against a specific occurrence event.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Corrective actions may mandate part substitution, upgrade, or fleet-wide replacement. Fleet modification tracking, airworthiness compliance, and budget planning require linking actions to part master ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Corrective actions often require procurement of new equipment, parts, or services. Linking to purchase orders enables budget tracking, implementation verification, cost allocation to safety programs, ',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Corrective actions implement formal safety recommendations. Adding corrective_action.recommendation_id → recommendation.recommendation_id tracks which recommendation the action implements. No redundan',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Corrective actions may be route-specific (procedure changes for specific approaches, crew training for specific routes, route suspension). Required for tracking route-level safety improvements and reg',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Safety corrective actions may trigger contract amendments for enhanced SLAs, quality requirements, or service specifications. Contract management requires linking actions to contracts for compliance v',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Corrective actions frequently require vendor engagement for part replacement, service modifications, or process changes. Tracking vendor responsibility ensures accountability, monitors implementation ',
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
    `risk_assessment_id` BIGINT COMMENT 'Foreign key reference to the risk assessment record if this action was raised to mitigate an assessed risk.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Regulatory audits (IOSA, FAA, EASA) trigger corrective action communication campaigns or transparency initiatives. Real business process: audit response communication programs inform stakeholders of c',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Safety audits (IOSA, regulatory, internal) have costs (auditor time, travel, external consultants, certification fees) allocated to cost centres. Required for SMS budget tracking and departmental cost',
    `employee_id` BIGINT COMMENT 'Employee identifier of the lead auditor.',
    `actual_end_date` DATE COMMENT 'Actual date when the audit concluded. May differ from planned date due to scope changes or findings requiring extended investigation.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit commenced. May differ from planned date due to operational changes.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including areas, processes, and standards being audited (e.g., Flight Operations SMS compliance - all hub stations, IOSA IRM sections 1.1-1.5, Part 121 operational control procedures).',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Values: planned (scheduled but not started), in_progress (fieldwork underway), completed (fieldwork finished, report pending), closed (report issued and all corrective actions tracked), cancelled (audit cancelled before completion).. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit. Values: internal_sms (internal Safety Management System audit), iosa_preparation (IATA Operational Safety Audit preparation audit), regulatory_authority (FAA/EASA/CAA audit), losa (Line Operations Safety Audit), line_station (line station operational audit), maintenance (MRO facility audit).. Valid values are `internal_sms|iosa_preparation|regulatory_authority|losa|line_station|maintenance`',
    `audited_department` STRING COMMENT 'Name of the department, division, or functional area being audited (e.g., Flight Operations, Ground Handling, Maintenance Engineering, Crew Scheduling).',
    `audited_function` STRING COMMENT 'Specific operational function or process being audited (e.g., Dispatch Release Procedures, Fuel Uplift Operations, Cabin Safety Procedures, MEL Compliance).',
    `audited_station_code` STRING COMMENT 'Three-letter IATA airport code of the station being audited, if the audit is station-specific (e.g., JFK, LHR, DXB). Null for non-station audits.. Valid values are `^[A-Z]{3}$`',
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
    `audit_id` BIGINT COMMENT 'Reference to the parent safety audit, inspection, or surveillance activity during which this finding was raised. Links to the audit event that generated this finding.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Audit findings spawn corrective actions. Adding audit_finding.corrective_action_id → corrective_action.corrective_action_id links findings to their formal corrective action records. Removes corrective',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Audit findings may identify non-conforming parts, unapproved substitutions, or counterfeit components. Quality assurance and regulatory compliance require linking findings to part master for correctiv',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the previous audit finding record if this is a recurrence. Links to historical finding for trend analysis and corrective action effectiveness review.',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Audit findings can result in formal safety recommendations. Adding audit_finding.recommendation_id → recommendation.recommendation_id links findings to recommendations they generate. No redundant colu',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Audit findings may identify vendor non-conformance with quality standards, regulatory requirements, or contract terms. Supplier quality management requires linking findings to vendors for corrective a',
    `aircraft_registration` STRING COMMENT 'Aircraft registration number (tail number) if the finding is specific to a particular aircraft. Null if finding is organizational or process-related rather than aircraft-specific.. Valid values are `^[A-Z0-9-]+$`',
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
    `flight_number` STRING COMMENT 'Flight number if the finding was identified during or relates to a specific flight operation. Null if not flight-specific.',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`fdr_event` (
    `fdr_event_id` BIGINT COMMENT 'Unique identifier for the FDR event record. Primary key for the FDR event entity.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: FOQA/FDM programs require FDR event trending by tail number to identify aircraft-specific performance degradation, maintenance issues, or configuration anomalies. Essential for predictive maintenance ',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg during which this FDR event occurred.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: FDR events that meet severity thresholds are classified as occurrences. Adding fdr_event.occurrence_id → occurrence.occurrence_id links FDR events to their master occurrence record when reportable. Re',
    `report_id` BIGINT COMMENT 'Reference identifier linking this FDR event to a formal safety occurrence report if one was filed.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: FDR exceedances may indicate specific part performance degradation or failure. Reliability engineering requires linking events to part master records for fleet-wide trend analysis, airworthiness direc',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: FDR exceedances (altitude, speed, stabilized approach violations) can constitute regulatory violations requiring notification and corrective action. Links flight data monitoring to enforcement trackin',
    `altitude_feet` STRING COMMENT 'The aircraft altitude in feet above mean sea level at the time of the event.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The date and time when the FDR data was analyzed and the event was identified by the FDM system.',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by the safety analyst reviewing this FDR event.',
    `corrective_action_status` STRING COMMENT 'The status of corrective actions associated with this FDR event. Values: not_required (no action needed), pending (action identified but not started), in_progress (action underway), completed (action finished), closed (event resolved).. Valid values are `not_required|pending|in_progress|completed|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this FDR event record was first created in the safety management system.',
    `crew_notified_flag` BOOLEAN COMMENT 'Indicates whether the flight crew was notified of the FDR event for follow-up or corrective action. True if notified, False otherwise.',
    `data_source` STRING COMMENT 'The source system from which the event data was extracted. Values: fdr (Flight Data Recorder), qar (Quick Access Recorder), acars (Aircraft Communications Addressing and Reporting System), ems (Engine Monitoring System).. Valid values are `fdr|qar|acars|ems`',
    `event_category` STRING COMMENT 'High-level categorization of the event cause or nature: operational (procedure-related), technical (aircraft system), environmental (weather/terrain), crew_action (pilot input).. Valid values are `operational|technical|environmental|crew_action`',
    `event_type` STRING COMMENT 'The classification of the FDR event. Types include: exceedance (parameter limit exceeded), parameter_breach (operational threshold violated), unusual_attitude (abnormal aircraft orientation), hard_landing (excessive vertical speed at touchdown), gpws_alert (Ground Proximity Warning System activation), tcas_ra (Traffic Collision Avoidance System Resolution Advisory).. Valid values are `exceedance|parameter_breach|unusual_attitude|hard_landing|gpws_alert|tcas_ra`',
    `exceedance_duration_seconds` DECIMAL(18,2) COMMENT 'The duration in seconds for which the parameter remained outside the threshold limit. Null if the event was instantaneous.',
    `fdm_program_version` STRING COMMENT 'The version identifier of the FDM/FOQA program rules and thresholds used to detect this event.',
    `indicated_airspeed_knots` STRING COMMENT 'The indicated airspeed in knots at the time of the event.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether the event requires formal safety investigation. True if investigation is required, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this FDR event record was last updated or modified.',
    `parameter_name` STRING COMMENT 'The name of the flight parameter that triggered the event (e.g., airspeed, altitude, pitch, roll, vertical_speed, engine_n1, flap_position).',
    `recorded_value` DECIMAL(18,2) COMMENT 'The actual value of the flight parameter recorded by the FDR at the time of the event.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this FDR event meets the criteria for mandatory reporting to aviation regulatory authorities (FAA, EASA, national CAA). True if reportable, False otherwise.',
    `risk_score` STRING COMMENT 'Numerical risk score assigned to the event based on severity, frequency, and consequence analysis. Higher scores indicate greater safety risk.',
    `severity_level` STRING COMMENT 'The assessed severity classification of the FDR event based on risk assessment criteria. Levels: low (minor deviation), medium (notable exceedance), high (significant safety concern), critical (immediate safety risk).. Valid values are `low|medium|high|critical`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The defined operational or safety threshold value for the parameter. Exceedances occur when recorded_value breaches this threshold.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for the recorded and threshold values (e.g., knots, feet, degrees, fpm, percent, psi).',
    CONSTRAINT pk_fdr_event PRIMARY KEY(`fdr_event_id`)
) COMMENT 'Flight Data Recorder (FDR) exceedance and event records generated from Flight Data Monitoring (FDM/FOQA) programmes. Captures tail number, flight identifier, event date, event type (exceedance/parameter breach/unusual attitude/hard landing/GPWS/TCAS RA), parameter name, recorded value, threshold value, exceedance duration, flight phase, altitude, airspeed, and severity classification. Supports proactive safety monitoring and trend analysis per ICAO Annex 6 FDM requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`report` (
    `report_id` BIGINT COMMENT 'Unique identifier for the safety report or alert. Primary key.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Safety reports can identify hazards. Adding report.hazard_id → hazard.hazard_id links reports to hazards they identify or reference. No redundant columns visible in report schema.',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safety.investigation. Business justification: Reports can trigger or be associated with investigations. Adding report.investigation_id → investigation.investigation_id tracks which investigation a report spawned or references. Removes redundant i',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety reports document occurrences. Adding report.occurrence_id → occurrence.occurrence_id allows linking reports to the master occurrence record. Removes redundant occurrence attributes that should ',
    `employee_id` BIGINT COMMENT 'Internal employee identifier of the person who submitted the safety report. May be null for confidential/anonymous reports to support Just Culture principles.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Major investigations trigger public relations and customer confidence campaigns. Real business process: crisis communication campaigns are launched in response to high-profile investigations to manage',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Investigations incur costs (investigator time, travel, external experts, lab analysis, CVR/FDR readout) tracked to cost centres. investigation_cost_estimate field requires cost centre allocation for b',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine investigations require detailed engine history including TSN/CSN, shop visit records, LLP status, and component traceability by ESN. Direct link enables investigation teams to access complete e',
    `employee_id` BIGINT COMMENT 'Reference to the employee or investigator assigned as the lead investigator responsible for coordinating the investigation and producing the final report.',
    `investigation_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system account that last modified this investigation record.',
    `occurrence_id` BIGINT COMMENT 'Reference to the safety occurrence that triggered this investigation.',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: Investigations often originate from regulatory violations or uncover violations during root cause analysis. Links investigation findings to enforcement actions, penalties, and corrective action plans ',
    `repair_order_id` BIGINT COMMENT 'Foreign key linking to procurement.repair_order. Business justification: Safety investigations may examine repair quality, workmanship, or adherence to specifications. Linking to repair orders supports vendor accountability, EASA Part-145/FAA repair station oversight, and ',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Investigations analyze route-specific factors (airspace design, terrain, weather patterns, ATC procedures). Required for route safety case updates, ETOPS reviews, and route authority renewals. Links i',
    `hazard_id` BIGINT COMMENT 'Reference to the SMS hazard record that was identified or updated as a result of this investigation. Links investigation findings back to the hazard identification and risk assessment process.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Safety investigations often trace causal factors to vendor-supplied components, maintenance services, or ground handling. Linking investigations to vendors supports root cause analysis, liability dete',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Safety recommendations from regulators or audits require communication campaigns to ensure compliance across operations. Real business process: safety directive dissemination campaigns communicate reg',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Safety recommendations require budget allocation to cost centres for implementation. estimated_implementation_cost field needs cost centre linkage for financial planning, budget approval workflows, an',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Safety recommendations may specify part changes, upgrades, or alternative sourcing. Regulatory compliance and SMS effectiveness require linking recommendations to part master for implementation tracki',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Safety recommendations frequently cite specific regulatory requirements as the basis for action. Links recommendation compliance tracking to regulatory obligations, enabling gap closure verification a',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Safety recommendations may be route-specific (procedure changes, equipment requirements, crew qualification). Required for tracking route-level safety improvements and regulatory compliance. Links rec',
    `audit_id` BIGINT COMMENT 'Reference to the safety audit or inspection that generated this recommendation, if applicable. Links to audit record in safety management system.',
    `investigation_id` BIGINT COMMENT 'Reference to the accident or incident investigation that generated this recommendation, if applicable. Links to investigation record in safety management system.',
    `occurrence_id` BIGINT COMMENT 'Reference to the safety occurrence or event that triggered this recommendation, if applicable. Links to occurrence reporting system.',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Safety recommendations may require contract modifications for enhanced safety provisions, quality standards, or service levels. Regulatory compliance and SMS effectiveness depend on linking recommenda',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Safety recommendations may mandate vendor changes, part upgrades, or service modifications. Tracking vendor association ensures implementation accountability, supports contract amendments, and enables',
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
    `hazard_description` STRING COMMENT 'Description of the identified hazard or unsafe condition that the recommendation is intended to mitigate or eliminate.',
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
    `related_sop_reference` STRING COMMENT 'Reference number or identifier of the SOP that was revised or created as a result of implementing this recommendation.',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`fatigue_report` (
    `fatigue_report_id` BIGINT COMMENT 'Unique identifier for the fatigue report record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: FRMS analysis correlates crew fatigue with aircraft utilization patterns, cabin environment (pressurization, noise), and route characteristics. Linking fatigue reports to aircraft enables identificati',
    `employee_id` BIGINT COMMENT 'Identifier of the safety analyst or FRMS coordinator who reviewed the fatigue report. Links to user or employee records.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Fatigue reports reference specific flight numbers for duty period analysis and FRMS trend identification. Required for flight number-level fatigue risk profiling and crew scheduling adjustments. Repla',
    `occurrence_id` BIGINT COMMENT 'Identifier of the related safety occurrence or incident report if the fatigue report is associated with a documented safety event. Links to safety occurrence records.',
    `member_id` BIGINT COMMENT 'Identifier of the crew member who submitted the fatigue report. Links to crew master data.',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to marketing.nps_survey. Business justification: Crew fatigue reports correlate with passenger experience issues (delayed flights, service quality degradation). Real business process: operational safety issues impact customer satisfaction metrics; l',
    `confidential_report` BOOLEAN COMMENT 'Indicates whether the fatigue report was submitted confidentially under the airlines voluntary safety reporting program, protecting the reporters identity from disciplinary action.',
    `contributing_factor_circadian_disruption` BOOLEAN COMMENT 'Indicates whether circadian rhythm disruption (time zone changes, night operations, irregular schedules) was identified as a contributing factor to the reported fatigue.',
    `contributing_factor_irop` BOOLEAN COMMENT 'Indicates whether irregular operations (delays, diversions, cancellations, weather disruptions, mechanical issues) were identified as a contributing factor to the reported fatigue.',
    `contributing_factor_other` STRING COMMENT 'Free-text description of other contributing factors to fatigue not captured by standard categories, such as personal health issues, environmental conditions, or operational stressors.',
    `contributing_factor_sleep_disruption` BOOLEAN COMMENT 'Indicates whether sleep disruption (insufficient sleep, poor sleep quality, interrupted rest) was identified as a contributing factor to the reported fatigue.',
    `contributing_factor_workload` BOOLEAN COMMENT 'Indicates whether excessive workload (high task demands, complex operations, extended duty periods) was identified as a contributing factor to the reported fatigue.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken or planned in response to the fatigue report, such as duty period adjustments, crew rest enhancements, or scheduling policy changes.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions (schedule adjustments, rest period modifications, operational changes) are required based on the fatigue report findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fatigue report record was first created in the system. Audit trail field.',
    `duty_period_reference` STRING COMMENT 'Reference identifier for the duty period during which the fatigue was experienced. Links to crew scheduling duty period records. Format: DP-YYYY-NNNNNN.. Valid values are `^DP-[0-9]{4}-[0-9]{6}$`',
    `fatigue_scale_type` STRING COMMENT 'Type of fatigue assessment scale used for the reported fatigue level: Samn-Perelli (1-7), Karolinska Sleepiness Scale (1-9), custom airline scale, or other.. Valid values are `samn_perelli|karolinska|custom|other`',
    `fatigue_symptoms_description` STRING COMMENT 'Free-text description of fatigue symptoms experienced by the crew member, such as drowsiness, difficulty concentrating, microsleeps, impaired decision-making, or physical exhaustion.',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight during which fatigue was experienced, if applicable.',
    `flight_phase_experienced` STRING COMMENT 'Phase of flight or duty period during which the fatigue was most acutely experienced: pre-flight preparation, taxi out, takeoff, climb, cruise, descent, approach, landing, taxi in, post-flight duties, ground duty, or other. [ENUM-REF-CANDIDATE: pre_flight|taxi_out|takeoff|climb|cruise|descent|approach|landing|taxi_in|post_flight|ground_duty|other — 12 candidates stripped; promote to reference product]',
    `frms_trend_category` STRING COMMENT 'Category assigned for FRMS trend analysis: route-specific (fatigue patterns on specific routes), fleet-specific (aircraft type related), crew base-specific (location related), seasonal (time-of-year patterns), operational pattern (duty structure related), individual (crew member specific), systemic (organization-wide), or other. [ENUM-REF-CANDIDATE: route_specific|fleet_specific|crew_base_specific|seasonal|operational_pattern|individual|systemic|other — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fatigue report record was last modified. Audit trail field for tracking changes.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the fatigue report requires notification to the national Civil Aviation Authority (CAA) or other regulatory body based on severity or regulatory thresholds.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the fatigue report was notified to the regulatory authority, if required.',
    `report_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the fatigue report for tracking and audit purposes. Format: FR-YYYY-NNNNNN.. Valid values are `^FR-[0-9]{4}-[0-9]{6}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the fatigue report: submitted (initial submission), under review (being assessed by safety team), investigation (detailed analysis in progress), closed (review complete, actions identified), or archived (historical record).. Valid values are `submitted|under_review|investigation|closed|archived`',
    `reported_fatigue_level` STRING COMMENT 'Numeric fatigue level reported by crew member using standardized scale. Typically Samn-Perelli scale (1-7) or Karolinska Sleepiness Scale (KSS, 1-9). Lower values indicate alertness, higher values indicate severe fatigue.',
    `reporter_crew_category` STRING COMMENT 'Category of crew member submitting the fatigue report: flight crew (pilots), cabin crew (flight attendants), ground crew, maintenance crew, dispatch, or other operational staff.. Valid values are `flight_crew|cabin_crew|ground_crew|maintenance_crew|dispatch|other`',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the fatigue report review was completed by the safety team.',
    `safety_event_occurred` BOOLEAN COMMENT 'Indicates whether a safety event (incident, error, deviation, near-miss) occurred as a result of or in conjunction with the reported fatigue.',
    `safety_impact_assessment` STRING COMMENT 'Assessment of the actual or potential safety impact of the reported fatigue: none (no safety consequence), minor (minimal impact), moderate (noticeable impact on performance), major (significant safety concern), or critical (severe safety risk).. Valid values are `none|minor|moderate|major|critical`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the fatigue report was submitted by the crew member. Principal business event timestamp for the report lifecycle.',
    CONSTRAINT pk_fatigue_report PRIMARY KEY(`fatigue_report_id`)
) COMMENT 'Fatigue risk management records submitted by flight crew and cabin crew under the airlines Fatigue Risk Management System (FRMS) as required by ICAO Annex 6 and national CAA regulations. Captures report reference, reporter crew category, submission date, duty period reference, reported fatigue level (Samn-Perelli or KSS scale), fatigue symptoms described, contributing factors (sleep disruption/circadian disruption/workload/IROP), flight phase when fatigue experienced, and safety impact assessment. Feeds into FRMS trend monitoring.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`emergency_drill` (
    `emergency_drill_id` BIGINT COMMENT 'Unique identifier for the emergency drill record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Emergency preparedness drills are accompanied by awareness campaigns to staff and passengers. Real business process: emergency preparedness communication programs promote drill participation and safet',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Emergency drills have costs (participant time, equipment, external observers, regulatory fees) allocated to cost centres. Required for SMS budget tracking and regulatory compliance cost reporting (ICA',
    `employee_id` BIGINT COMMENT 'Employee identifier of the exercise controller. Links to the workforce or crew management system.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Emergency drills simulate type-specific scenarios (evacuation times vary by aircraft type, door configuration, exit count). Linking drills to aircraft type ensures scenario realism and enables type-sp',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Emergency drills simulate response to specific occurrence types. Adding emergency_drill.simulated_occurrence_id → occurrence.occurrence_id links drills to the occurrence scenario they simulate or were',
    `communication_systems_tested` STRING COMMENT 'List of communication systems and technologies tested during the drill (e.g., emergency hotline, ACARS, satellite phone, radio frequencies, mass notification system, crisis management software).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency drill record was first created in the safety management system.',
    `debrief_date` DATE COMMENT 'Date on which the post-drill debrief session was conducted with participants, observers, and stakeholders to review performance and identify lessons learned.',
    `debrief_findings` STRING COMMENT 'Comprehensive summary of observations, strengths, weaknesses, and lessons learned identified during the post-drill debrief. Includes feedback from participants and observers.',
    `drill_date` DATE COMMENT 'The calendar date on which the emergency drill was conducted or is scheduled to be conducted.',
    `drill_end_time` TIMESTAMP COMMENT 'Timestamp marking the official conclusion of the emergency drill exercise, including time zone.',
    `drill_reference_number` STRING COMMENT 'Business identifier for the emergency drill, typically formatted as station code, year, and sequence number (e.g., JFK-2024-001).. Valid values are `^[A-Z]{3}-[0-9]{4}-[0-9]{3}$`',
    `drill_start_time` TIMESTAMP COMMENT 'Timestamp marking the official commencement of the emergency drill exercise, including time zone.',
    `drill_status` STRING COMMENT 'Current lifecycle status of the emergency drill. Tracks progression from planning through execution to completion or cancellation.. Valid values are `planned|scheduled|in_progress|completed|cancelled|deferred`',
    `drill_type` STRING COMMENT 'Classification of the emergency drill exercise type. Full-scale involves live simulation with all resources; tabletop is discussion-based; functional tests specific functions; communications tests notification systems; evacuation tests passenger/crew egress; medical tests triage and casualty handling.. Valid values are `full_scale|tabletop|functional|communications|evacuation|medical`',
    `duration_minutes` STRING COMMENT 'Total elapsed time of the drill exercise in minutes, from start to end.',
    `erp_version_reference` STRING COMMENT 'Version identifier of the Emergency Response Plan (ERP) document that was being tested and validated by this drill.',
    `exercise_controller_name` STRING COMMENT 'Full name of the individual responsible for directing and controlling the drill exercise, typically a senior safety or emergency response manager.',
    `external_agencies_involved` STRING COMMENT 'Comma-separated list of external organizations and agencies that participated in the drill (e.g., Airport Fire Rescue, Local Police, Emergency Medical Services, Hospital, Red Cross, Airport Authority).',
    `improvement_action_count` STRING COMMENT 'Total number of improvement actions identified from the drill debrief that require follow-up and implementation.',
    `improvement_actions_identified` STRING COMMENT 'Detailed list of corrective and preventive actions identified from the drill to enhance emergency response procedures, training, resources, or coordination. Each action should include description and responsible party.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency drill record was last updated or modified in the safety management system.',
    `next_drill_due_date` DATE COMMENT 'Scheduled date for the next emergency drill of this type or at this station, based on regulatory requirements and internal safety management system (SMS) schedules.',
    `objectives_defined` STRING COMMENT 'Detailed list of specific learning and performance objectives established for the drill, aligned with Emergency Response Plan (ERP) competencies and regulatory requirements.',
    `objectives_met_count` STRING COMMENT 'Number of drill objectives that were successfully achieved during the exercise, as assessed by observers and the exercise controller.',
    `objectives_not_met_count` STRING COMMENT 'Number of drill objectives that were not achieved or only partially achieved during the exercise.',
    `observer_list` STRING COMMENT 'Comma-separated list of names and roles of individuals assigned to observe and evaluate the drill performance, including regulatory observers if present.',
    `overall_performance_rating` STRING COMMENT 'Summary assessment of the drill performance across all objectives and participants. Reflects readiness and effectiveness of emergency response capabilities.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `participant_count` STRING COMMENT 'Total number of personnel actively participating in the drill exercise, including airline staff, contractors, and external agency responders.',
    `participating_departments` STRING COMMENT 'Comma-separated list of airline departments and external agencies participating in the drill (e.g., Flight Operations, Ground Ops, Maintenance, Airport Authority, Fire Rescue, Medical Services, Local Police).',
    `participating_stations` STRING COMMENT 'Comma-separated list of IATA station codes for all airports and facilities participating in the drill, including remote coordination centers.',
    `primary_station_code` STRING COMMENT 'Three-letter IATA airport code of the primary station where the drill is conducted. The lead location for the exercise.. Valid values are `^[A-Z]{3}$`',
    `regulatory_compliance_status` STRING COMMENT 'Assessment of whether the drill met regulatory requirements for emergency preparedness and response as mandated by applicable aviation authorities.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `regulatory_observer_agency` STRING COMMENT 'Name of the regulatory authority or agency whose representative observed the drill (e.g., FAA, EASA, Transport Canada, national Civil Aviation Authority).',
    `regulatory_observer_present` BOOLEAN COMMENT 'Indicates whether a representative from a regulatory authority (FAA, EASA, national CAA) was present to observe the drill.',
    `report_completed_date` DATE COMMENT 'Date on which the formal drill report was completed and submitted to management and regulatory authorities as required.',
    `report_submitted_to` STRING COMMENT 'Comma-separated list of internal departments and external agencies to whom the drill report was submitted (e.g., Safety Department, Executive Management, FAA, EASA, Airport Authority).',
    `scenario_category` STRING COMMENT 'High-level classification of the emergency scenario type being exercised. Aligns with Emergency Response Plan (ERP) scenario taxonomy.. Valid values are `aircraft_accident|medical_emergency|security_threat|fire|hazmat|natural_disaster`',
    `scenario_description` STRING COMMENT 'Detailed narrative of the emergency scenario being simulated in the drill, including incident type, location, scale, and key conditions (e.g., aircraft fire on gate, medical emergency in-flight, security threat, hazmat spill).',
    `sop_references` STRING COMMENT 'Comma-separated list of Standard Operating Procedure (SOP) document identifiers and version numbers that were exercised during the drill.',
    CONSTRAINT pk_emergency_drill PRIMARY KEY(`emergency_drill_id`)
) COMMENT 'Emergency response drill and exercise records conducted to test the airlines Emergency Response Plan (ERP) and station emergency procedures. Captures drill reference number, drill type (full-scale/tabletop/functional/communications), scenario description, participating stations and departments, drill date, duration, exercise controller, observer list, objectives met/not met, debrief findings, and improvement actions identified. Supports ICAO Annex 19 SMS emergency preparedness and response requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`performance_indicator` (
    `performance_indicator_id` BIGINT COMMENT 'Unique identifier for the safety performance indicator definition. Primary key.',
    `aggregation_method` STRING COMMENT 'The statistical method used to aggregate raw data into the indicator value (e.g., sum, average, count, rate, percentage, maximum, minimum). [ENUM-REF-CANDIDATE: sum|average|count|rate|percentage|maximum|minimum — 7 candidates stripped; promote to reference product]',
    `alert_threshold` DECIMAL(18,2) COMMENT 'The threshold value at which an alert is triggered, indicating that the indicator has reached a critical level requiring immediate management attention and corrective action.',
    `approval_authority` STRING COMMENT 'The role, position, or individual who approved this indicator definition for use in the SMS (e.g., Director of Safety, Accountable Executive, Safety Review Board).',
    `approval_date` DATE COMMENT 'The date on which this indicator definition was formally approved for use in safety performance monitoring.',
    `benchmark_source` STRING COMMENT 'Identifies the external benchmark or industry standard used for comparison (e.g., IATA Safety Report, peer airline group average, regional safety statistics). Null if no external benchmark is used.',
    `calculation_method` STRING COMMENT 'Detailed description or formula defining how the indicator value is calculated from source data. Includes numerator, denominator, and any normalization factors (e.g., incidents per 100,000 flight hours = (total incidents / total flight hours) * 100,000).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this indicator definition record was first created in the system.',
    `data_source` STRING COMMENT 'Identifies the operational system or data source from which the indicator data is collected (e.g., AMOS for maintenance events, Flight Operations Control for OOOI data, SMS database for occurrence reports).',
    `easa_alignment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this indicator is explicitly aligned with EASA Part-ORO SMS requirements (True) or not (False).',
    `effective_from_date` DATE COMMENT 'The date from which this indicator definition becomes effective and is used for safety performance monitoring.',
    `effective_to_date` DATE COMMENT 'The date until which this indicator definition remains effective. Null if the indicator is currently active with no planned end date.',
    `faa_alignment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this indicator is explicitly aligned with FAA SMS requirements and guidance (True) or not (False).',
    `icao_alignment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this indicator is explicitly aligned with ICAO Annex 19 SMS framework requirements (True) or is an airline-specific custom indicator (False).',
    `indicator_category` STRING COMMENT 'Classification of the indicator as either leading (predictive, proactive measures such as safety audits completed or training compliance) or lagging (reactive, outcome-based measures such as accident rate or incidents reported).. Valid values are `leading|lagging`',
    `indicator_code` STRING COMMENT 'Unique alphanumeric code assigned to the safety performance indicator for reference and reporting purposes. Typically follows organizational coding standards (e.g., SFT-001, OPS-1234).. Valid values are `^[A-Z]{3,6}-[0-9]{3,4}$`',
    `indicator_description` STRING COMMENT 'Detailed explanation of what the indicator measures, its purpose within the SMS, and how it contributes to safety oversight and risk management.',
    `indicator_name` STRING COMMENT 'Full descriptive name of the safety performance indicator as used in safety management reporting and dashboards.',
    `indicator_status` STRING COMMENT 'Current lifecycle status of the indicator definition. Active indicators are in use for monitoring; inactive indicators are temporarily suspended; under_review indicators are being evaluated for changes; retired indicators are no longer used.. Valid values are `active|inactive|under_review|retired`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this indicator definition record was last modified or updated.',
    `last_review_date` DATE COMMENT 'The date on which this indicator definition was last reviewed by the responsible authority or safety committee.',
    `measurement_frequency` STRING COMMENT 'The frequency at which the indicator is measured and reported (e.g., daily, weekly, monthly, quarterly, annually, or real-time for continuous monitoring).. Valid values are `daily|weekly|monthly|quarterly|annually|real-time`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the indicator value (e.g., count, percentage, rate per 100,000 flight hours, days, hours). Defines how the indicator is quantified.',
    `next_review_date` DATE COMMENT 'The date on which this indicator definition is scheduled for its next formal review.',
    `notes` STRING COMMENT 'Free-text field for additional notes, clarifications, or context regarding the indicator definition, calculation nuances, or historical changes.',
    `regulatory_framework` STRING COMMENT 'Identifies the regulatory framework(s) or standard(s) to which this indicator aligns, such as ICAO Annex 19, FAA SMS requirements, EASA Part-ORO, or national civil aviation authority mandates. May list multiple frameworks separated by semicolons.',
    `reporting_level` STRING COMMENT 'Classification of the organizational level at which this indicator is primarily reported and monitored (operational for front-line teams, tactical for department managers, strategic for senior leadership, executive for board and accountable executive).. Valid values are `operational|tactical|strategic|executive`',
    `responsible_department` STRING COMMENT 'The department, division, or organizational unit responsible for monitoring this indicator, collecting data, and taking corrective action when thresholds are breached (e.g., Safety Department, Flight Operations, Maintenance).',
    `review_frequency` STRING COMMENT 'The frequency at which this indicator definition is reviewed for continued relevance, accuracy, and alignment with safety objectives (e.g., quarterly, annually).. Valid values are `monthly|quarterly|semi-annually|annually`',
    `target_value` DECIMAL(18,2) COMMENT 'The target or goal value set for this indicator as part of the Safety Performance Target (SPT) framework. Represents the desired performance level the organization aims to achieve.',
    `trend_analysis_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether trend analysis and statistical process control are enabled for this indicator (True) or if it is monitored as a point-in-time value only (False).',
    `version_number` STRING COMMENT 'Version number of the indicator definition, used to track changes to calculation methods, thresholds, or other parameters over time. Follows semantic versioning (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    `warning_threshold` DECIMAL(18,2) COMMENT 'The threshold value at which a warning is issued, indicating that the indicator is approaching an unacceptable level and requires monitoring and potential intervention.',
    CONSTRAINT pk_performance_indicator PRIMARY KEY(`performance_indicator_id`)
) COMMENT 'Safety Performance Indicator (SPI) and Safety Performance Target (SPT) master definitions used to monitor SMS effectiveness as required by ICAO Annex 19. Captures indicator code, indicator name, description, indicator category (lagging/leading), measurement unit, data source, calculation method, target value, alert threshold, warning threshold, measurement frequency, responsible department, and regulatory framework alignment (ICAO/FAA/EASA). Defines the KPI framework — actual measured values are stored in spi_measurement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`spi_measurement` (
    `spi_measurement_id` BIGINT COMMENT 'Unique identifier for the SPI measurement record. Primary key.',
    `performance_indicator_id` BIGINT COMMENT 'Reference to the defined SPI being measured. Links to the SPI definition catalog.',
    `employee_id` BIGINT COMMENT 'Reference to the safety analyst or employee responsible for recording and validating this SPI measurement.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured value of the SPI for the measurement period. This is the primary quantitative result of the measurement.',
    `alert_threshold_breached_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the actual value breached the alert threshold for this measurement period. True indicates breach requiring immediate action.',
    `alert_threshold_value` DECIMAL(18,2) COMMENT 'The alert threshold value for this SPI. When actual value crosses this threshold, it triggers an alert requiring immediate action.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this SPI measurement was approved for publication or regulatory reporting.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this measurement result requires corrective action to be initiated. True when thresholds are breached or performance is unacceptable.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SPI measurement record was first created in the system. Audit trail field.',
    `data_quality_flag` STRING COMMENT 'Categorical flag indicating the quality status of the measurement data (verified, provisional, estimated, incomplete, suspect).. Valid values are `verified|provisional|estimated|incomplete|suspect`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A quality score (0-100) indicating the reliability and completeness of the measurement data. Higher scores indicate higher confidence in the measurement.',
    `data_source_system` STRING COMMENT 'The name or identifier of the source system from which the measurement data was extracted (e.g., SMS database, FOQA system, maintenance system).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SPI measurement record was last modified. Audit trail field.',
    `measurement_date` DATE COMMENT 'The date when the SPI measurement was recorded or calculated. Represents the business event timestamp for this measurement.',
    `measurement_method` STRING COMMENT 'The method used to collect or calculate this SPI measurement (automated system, manual data entry, hybrid, calculated from other metrics).. Valid values are `automated|manual|hybrid|calculated`',
    `measurement_notes` STRING COMMENT 'Free-text notes providing additional context, explanations, or observations about this SPI measurement. May include reasons for anomalies or data quality issues.',
    `measurement_period_end_date` DATE COMMENT 'The end date of the measurement period covered by this SPI measurement.',
    `measurement_period_start_date` DATE COMMENT 'The start date of the measurement period covered by this SPI measurement.',
    `measurement_period_type` STRING COMMENT 'The frequency or type of measurement period for this SPI measurement (daily, weekly, monthly, quarterly, annual, ad-hoc).. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `measurement_status` STRING COMMENT 'The current lifecycle status of this SPI measurement record (draft, submitted for review, reviewed, approved, published).. Valid values are `draft|submitted|reviewed|approved|published`',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when this SPI measurement was published to stakeholders or submitted to regulatory authorities.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this SPI measurement must be reported to regulatory authorities (FAA, EASA, national CAA).',
    `reporting_period_month` STRING COMMENT 'The calendar month (1-12) of the measurement period. Used for monthly aggregation and trend analysis.',
    `reporting_period_quarter` STRING COMMENT 'The calendar quarter (1-4) of the measurement period. Used for quarterly aggregation and trend analysis.',
    `reporting_period_year` STRING COMMENT 'The calendar year of the measurement period. Used for annual aggregation and regulatory reporting.',
    `responsible_department` STRING COMMENT 'The department or organizational unit responsible for this SPI measurement (e.g., Flight Safety, Ground Safety, Maintenance Safety).',
    `sample_size` BIGINT COMMENT 'The number of observations or data points used to calculate this SPI measurement. Relevant for rate-based or statistical SPIs.',
    `target_met_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the actual value met or exceeded the target value for this measurement period.',
    `target_value` DECIMAL(18,2) COMMENT 'The target or goal value defined for this SPI during the measurement period. Used to assess performance against objectives.',
    `trend_direction` STRING COMMENT 'The trend direction of the SPI compared to previous measurement periods (improving, stable, deteriorating, insufficient data).. Valid values are `improving|stable|deteriorating|insufficient_data`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the SPI values (e.g., count, percentage, rate per 1000 flights, hours, incidents per million departures).',
    `variance_from_target` DECIMAL(18,2) COMMENT 'The calculated variance between actual value and target value. Positive indicates performance above target, negative indicates below target.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance from target expressed as a percentage. Calculated as ((actual - target) / target) * 100.',
    `warning_threshold_breached_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the actual value breached the warning threshold for this measurement period. True indicates breach requiring attention.',
    `warning_threshold_value` DECIMAL(18,2) COMMENT 'The warning threshold value for this SPI. When actual value crosses this threshold, it triggers a warning requiring attention.',
    CONSTRAINT pk_spi_measurement PRIMARY KEY(`spi_measurement_id`)
) COMMENT 'Periodic measurement records for Safety Performance Indicators (SPIs) capturing actual measured values against defined targets and thresholds. Captures indicator reference, measurement period (month/quarter), measurement date, actual value, target value, alert threshold breached flag, warning threshold breached flag, trend direction, data quality flag, measurement notes, and responsible analyst. Enables SMS performance monitoring and regulatory reporting to FAA, EASA, and national CAAs.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`wildlife_strike` (
    `wildlife_strike_id` BIGINT COMMENT 'Unique identifier for the wildlife strike occurrence record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Wildlife strike damage assessment, repair tracking, and airworthiness restoration require linkage to specific aircraft. Enables analysis of aircraft vulnerability patterns (e.g., radome strikes on spe',
    `destination_content_id` BIGINT COMMENT 'Foreign key linking to marketing.destination_content. Business justification: Wildlife strike patterns at specific airports inform destination content warnings or operational communications. Real business process: destination safety information for route planning and passenger ',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg during which the wildlife strike occurred.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Wildlife strikes generate repair costs, insurance claims, and AOG costs posted to GL. cost_estimate_usd and repair_hours fields require GL linkage for financial impact tracking and insurance claim rec',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Wildlife strikes are a specific type of occurrence. Adding wildlife_strike.occurrence_id → occurrence.occurrence_id links wildlife strike records to their master occurrence record. Removes redundant o',
    `report_id` BIGINT COMMENT 'Reference to the parent safety occurrence report if this strike is part of a broader safety event investigation.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Wildlife strikes have specific FAA/ICAO reporting requirements (FAA Form 5200-7). Links strike records to regulatory reporting obligations, ensuring timely submission and compliance with wildlife haza',
    `repair_order_id` BIGINT COMMENT 'Foreign key linking to procurement.repair_order. Business justification: Wildlife strikes cause aircraft damage requiring vendor repairs. Linking strikes to repair orders supports cost tracking, insurance claims, regulatory reporting to FAA/ICAO, and analysis of repair tur',
    `aircraft_out_of_service_hours` DECIMAL(18,2) COMMENT 'The total number of hours the aircraft was out of service due to the wildlife strike, including inspection, repair, and testing time.',
    `aircraft_part_struck` STRING COMMENT 'The specific part or component of the aircraft that was struck by the wildlife. [ENUM-REF-CANDIDATE: engine|windshield|radome|nose|wing|fuselage|landing_gear|tail|propeller|rotor|other|unknown — 12 candidates stripped; promote to reference product]',
    `altitude_feet` STRING COMMENT 'The altitude of the aircraft in feet above ground level (AGL) or mean sea level (MSL) at the time of the wildlife strike.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required as a result of this wildlife strike. True if actions required, False otherwise.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'The estimated total cost of the wildlife strike including aircraft repair, operational disruption, and other direct costs, expressed in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this wildlife strike record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `damage_level` STRING COMMENT 'The severity level of damage sustained by the aircraft as a result of the wildlife strike, following FAA damage classification standards.. Valid values are `none|minor|substantial|destroyed|unknown`',
    `effect_on_flight` STRING COMMENT 'The operational impact of the wildlife strike on the flight, including any immediate actions taken by the crew.. Valid values are `none|aborted_takeoff|precautionary_landing|engine_shutdown|other|unknown`',
    `engine_ingestion_flag` BOOLEAN COMMENT 'Indicates whether the wildlife was ingested into one or more aircraft engines. True if ingestion occurred, False otherwise.',
    `faa_report_number` STRING COMMENT 'The unique report number assigned by the FAA Wildlife Strike Database upon submission of the strike report.',
    `icao_report_reference` STRING COMMENT 'The reference number or identifier for the wildlife strike report submitted to ICAO under Circular 107 reporting requirements.',
    `indicated_airspeed_knots` STRING COMMENT 'The indicated airspeed of the aircraft in knots at the time of the wildlife strike.',
    `investigation_status` STRING COMMENT 'The current status of any safety investigation triggered by this wildlife strike occurrence.. Valid values are `not_required|pending|in_progress|completed|closed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this wildlife strike record was most recently updated or modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `pilot_warned_flag` BOOLEAN COMMENT 'Indicates whether the pilot was warned of wildlife presence prior to the strike. True if warning was issued, False otherwise.',
    `precipitation` STRING COMMENT 'The type of precipitation present at the time of the wildlife strike, if any.. Valid values are `none|rain|snow|fog|unknown`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this wildlife strike meets the threshold for mandatory regulatory reporting to FAA or other civil aviation authorities. True if reportable, False otherwise.',
    `remains_collected_flag` BOOLEAN COMMENT 'Indicates whether wildlife remains were collected for species identification or analysis. True if collected, False otherwise.',
    `remains_sent_to_lab_flag` BOOLEAN COMMENT 'Indicates whether collected wildlife remains were sent to a laboratory for identification or forensic analysis. True if sent, False otherwise.',
    `remarks` STRING COMMENT 'Free-text field for additional observations, context, or details about the wildlife strike that are not captured in structured fields.',
    `repair_hours` DECIMAL(18,2) COMMENT 'The total number of maintenance labor hours required to repair damage caused by the wildlife strike.',
    `reporter_name` STRING COMMENT 'The name of the individual who reported the wildlife strike occurrence, typically the pilot, crew member, or airport operations personnel.',
    `reporter_role` STRING COMMENT 'The operational role or position of the individual who reported the wildlife strike. [ENUM-REF-CANDIDATE: pilot|first_officer|cabin_crew|maintenance|airport_ops|atc|other — 7 candidates stripped; promote to reference product]',
    `sky_condition` STRING COMMENT 'The weather and sky conditions at the time of the wildlife strike.. Valid values are `clear|overcast|fog|rain|snow|unknown`',
    `species_identified` STRING COMMENT 'The common or scientific name of the wildlife species involved in the strike, if identified. May be unknown if species could not be determined.',
    `species_quantity` STRING COMMENT 'The estimated number of wildlife individuals involved in the strike event.',
    CONSTRAINT pk_wildlife_strike PRIMARY KEY(`wildlife_strike_id`)
) COMMENT 'Wildlife strike occurrence records capturing bird and wildlife strikes as required by FAA Wildlife Strike Database reporting and ICAO circular 107. Captures strike date, airport ICAO code, flight phase (approach/takeoff/en-route/taxi), species identified, species quantity, aircraft part struck (engine/windshield/radome/wing/fuselage), damage level (none/minor/substantial/destroyed), effect on flight (none/aborted takeoff/precautionary landing/engine shutdown), ingestion flag, and FAA/ICAO report submission reference.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`runway_incursion` (
    `runway_incursion_id` BIGINT COMMENT 'Unique identifier for the runway incursion event record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Runway incursion investigations require aircraft performance data (braking capability, wingspan for clearance analysis) and equipment status (TCAS, ADS-B). Direct aircraft link enables investigation t',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg involved in the runway incursion event, if applicable.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Runway incursions are a specific type of occurrence. Adding runway_incursion.occurrence_id → occurrence.occurrence_id links runway incursion records to their master occurrence record. Removes redundan',
    `report_id` BIGINT COMMENT 'Reference to the parent safety occurrence report under which this runway incursion is documented.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Runway incursions have mandatory reporting requirements to aviation authorities. Links incursion records to regulatory notification obligations, enabling compliance tracking and demonstrating adherenc',
    `atc_clearance_status` STRING COMMENT 'Whether the entity involved had proper ATC clearance to enter the runway area at the time of the incursion.. Valid values are `cleared|not_cleared|unclear|not_applicable`',
    `atc_instruction` STRING COMMENT 'The specific ATC instruction or clearance that was active at the time of the incursion, if available from voice recordings or transcripts.',
    `collision_avoidance_action` STRING COMMENT 'Description of any evasive action taken to avoid collision (e.g., rejected takeoff, go-around, emergency braking, evasive steering).',
    `contributing_factor_communication` BOOLEAN COMMENT 'Flag indicating whether communication issues (misunderstood clearance, readback error, language barrier, radio congestion) contributed to the runway incursion.',
    `contributing_factor_lighting` BOOLEAN COMMENT 'Flag indicating whether inadequate or inoperative runway/taxiway lighting contributed to the runway incursion.',
    `contributing_factor_procedures` BOOLEAN COMMENT 'Flag indicating whether inadequate or non-compliance with standard operating procedures contributed to the runway incursion.',
    `contributing_factor_signage` BOOLEAN COMMENT 'Flag indicating whether inadequate, missing, or confusing airport signage contributed to the runway incursion.',
    `contributing_factor_situational_awareness` BOOLEAN COMMENT 'Flag indicating whether loss of situational awareness (disorientation, confusion about position, distraction) contributed to the runway incursion.',
    `contributing_factor_training` BOOLEAN COMMENT 'Flag indicating whether inadequate training or lack of familiarity with airport layout contributed to the runway incursion.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required to prevent recurrence of similar runway incursion events.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective actions identified to address the runway incursion root causes.. Valid values are `not_required|planned|in_progress|completed|verified`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this runway incursion record was first created in the safety management system.',
    `detection_method` STRING COMMENT 'How the runway incursion was detected (e.g., ATC visual observation, pilot report, ASDE-X/surface radar, runway status lights, airport surface detection equipment).',
    `event_description` STRING COMMENT 'Detailed narrative description of the runway incursion event, including sequence of events, parties involved, and circumstances.',
    `event_number` STRING COMMENT 'Externally-known unique identifier for the runway incursion event, formatted as RI-YYYY-NNNNNN for tracking and regulatory reporting.. Valid values are `^RI-[0-9]{4}-[0-9]{6}$`',
    `incursion_category` STRING COMMENT 'ICAO severity classification of the runway incursion: A (serious incident with collision narrowly avoided), B (significant potential for collision), C (ample time/distance to avoid collision), D (little or no chance of collision).. Valid values are `A|B|C|D`',
    `incursion_type` STRING COMMENT 'Type of entity that entered the protected runway area: aircraft, vehicle, pedestrian, or mixed (multiple types).. Valid values are `aircraft|vehicle|pedestrian|mixed`',
    `investigation_status` STRING COMMENT 'Current status of the runway incursion investigation.. Valid values are `open|in_progress|closed|pending_review`',
    `investigator_notes` STRING COMMENT 'Additional notes and observations recorded by the safety investigator during the runway incursion investigation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this runway incursion record was last updated, supporting audit trail and data lineage.',
    `regulatory_notification_date` DATE COMMENT 'Date when the runway incursion was formally notified to the relevant civil aviation authority.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this runway incursion event meets the threshold for mandatory reporting to civil aviation authorities (FAA, EASA, national CAA).',
    `risk_score` STRING COMMENT 'Quantitative risk assessment score assigned to the runway incursion event based on severity, likelihood, and consequence, per SMS risk matrix.',
    `runway_designator` STRING COMMENT 'Runway identifier where the incursion occurred, formatted as magnetic heading with optional L/C/R suffix (e.g., 27L, 09R, 18).. Valid values are `^[0-9]{2}[LCR]?$`',
    `separation_distance_meters` DECIMAL(18,2) COMMENT 'Minimum separation distance in meters between the incurring entity and other aircraft or vehicles on the runway at the closest point of approach.',
    `time_of_day` STRING COMMENT 'Lighting conditions at the time of the incursion: day, night, dawn, or dusk.. Valid values are `day|night|dawn|dusk`',
    `vehicle_operator` STRING COMMENT 'Organization or department operating the vehicle involved in the runway incursion (e.g., airline ground handling, airport operations, third-party contractor).',
    `vehicle_type` STRING COMMENT 'Type of ground vehicle involved in the runway incursion (e.g., fuel truck, catering vehicle, maintenance vehicle, snow removal equipment), if applicable.',
    `visibility_meters` STRING COMMENT 'Prevailing visibility in meters at the time of the runway incursion event.',
    `weather_condition` STRING COMMENT 'Meteorological conditions at the time of the incursion: VMC (Visual Meteorological Conditions), IMC (Instrument Meteorological Conditions), or marginal.. Valid values are `VMC|IMC|marginal`',
    CONSTRAINT pk_runway_incursion PRIMARY KEY(`runway_incursion_id`)
) COMMENT 'Runway incursion and excursion event records capturing incidents where an aircraft, vehicle, or person incorrectly entered a protected runway area. Captures event date, airport ICAO code, runway designator, incursion category (ICAO A/B/C/D severity), aircraft/vehicle/person involved, ATC clearance status, contributing factors (communication/situational awareness/signage/lighting), weather conditions, time of day, and regulatory notification status. Supports ICAO runway safety programme reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`airspace_deviation` (
    `airspace_deviation_id` BIGINT COMMENT 'Unique identifier for the airspace deviation event. Primary key for this product.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Airspace deviation analysis requires aircraft performance characteristics (climb rate, cruise speed) and avionics capabilities (RVSM, RNP) to determine if deviation was equipment-related. Links deviat',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg during which the airspace deviation occurred.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Airspace deviations are a specific type of occurrence. Adding airspace_deviation.occurrence_id → occurrence.occurrence_id links airspace deviation records to their master occurrence record. Removes re',
    `report_id` BIGINT COMMENT 'Reference to the parent safety occurrence report if this deviation was formally reported as a safety event.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Airspace deviations must be assessed against ATC separation requirements and reporting regulations. Links deviation records to regulatory notification obligations and enables compliance verification f',
    `actual_altitude_feet` STRING COMMENT 'The actual altitude in feet at which the aircraft was flying at the time of deviation detection. Null if deviation type is not altitude-related.',
    `actual_route` STRING COMMENT 'The actual route or waypoint sequence flown by the aircraft at the time of deviation. Null if deviation type is not route or lateral-related.',
    `actual_speed_knots` STRING COMMENT 'The actual indicated airspeed in knots at the time of deviation detection. Null if deviation type is not speed-related.',
    `altitude_deviation_feet` STRING COMMENT 'The magnitude of altitude deviation in feet (actual minus cleared). Positive indicates above cleared altitude, negative indicates below. Null if deviation type is not altitude-related.',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by the safety analyst or investigator during review of the deviation event.',
    `atc_clearance_text` STRING COMMENT 'The verbatim or summarized text of the ATC clearance or instruction that was deviated from.',
    `atc_facility_code` STRING COMMENT 'The identifier of the ATC facility or control center that had jurisdiction over the airspace at the time of deviation.. Valid values are `^[A-Z0-9]{3,6}$`',
    `atc_sector` STRING COMMENT 'The specific ATC sector or control zone within the facility where the deviation occurred.',
    `caa_report_date` DATE COMMENT 'The date on which the deviation was reported to the national civil aviation authority, in yyyy-MM-dd format. Null if not yet reported.',
    `caa_report_reference` STRING COMMENT 'The reference number or identifier assigned by the national civil aviation authority for this deviation report. Null if not yet reported.',
    `caa_reported_flag` BOOLEAN COMMENT 'Indicates whether the deviation has been formally reported to the national civil aviation authority. True if reported, False otherwise.',
    `cause_classification` STRING COMMENT 'The primary root cause category for the airspace deviation: crew error, FMS (Flight Management System) error, ATC error, weather, equipment malfunction, communication failure, or other. [ENUM-REF-CANDIDATE: crew_error|fms_error|atc_error|weather|equipment_malfunction|communication_failure|traffic_conflict|navigation_error|procedural_error|other — promote to reference product]',
    `cleared_altitude_feet` STRING COMMENT 'The altitude in feet that was cleared by ATC for the aircraft at the time of deviation. Null if deviation type is not altitude-related.',
    `cleared_route` STRING COMMENT 'The ATC-cleared route or waypoint sequence that the aircraft was authorized to fly. Null if deviation type is not route or lateral-related.',
    `cleared_speed_knots` STRING COMMENT 'The indicated airspeed in knots that was cleared or assigned by ATC. Null if deviation type is not speed-related.',
    `contributing_factors` STRING COMMENT 'Free-text description of any contributing factors or secondary causes that led to or exacerbated the airspace deviation.',
    `corrective_action_taken` STRING COMMENT 'Description of the immediate corrective action taken by the crew or ATC to resolve the deviation and return to cleared parameters.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this airspace deviation record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `crew_notified_flag` BOOLEAN COMMENT 'Indicates whether the flight crew was notified of the deviation by ATC or onboard systems during the event. True if notified, False otherwise.',
    `detection_source` STRING COMMENT 'The source or system that first detected or reported the airspace deviation: ATC, crew, FMS (Flight Management System), ACARS, FDM (Flight Data Monitoring), ground radar, or other. [ENUM-REF-CANDIDATE: atc|crew|fms|acars|fdm|ground_radar|tcas|egpws|airline_ops|other — promote to reference product]',
    `deviation_category` STRING COMMENT 'The severity classification of the deviation based on magnitude and safety impact: minor, moderate, major, or critical.. Valid values are `minor|moderate|major|critical`',
    `deviation_type` STRING COMMENT 'The category of airspace deviation: altitude (vertical deviation), lateral (horizontal route deviation), speed (airspeed deviation), clearance (ATC clearance not followed), route (flight plan route deviation), or other.. Valid values are `altitude|lateral|speed|clearance|route|other`',
    `icao_adrep_reported_flag` BOOLEAN COMMENT 'Indicates whether the deviation has been reported to the ICAO ADREP system for international safety data sharing. True if reported, False otherwise.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether the deviation event requires formal safety investigation per SMS procedures. True if investigation is required, False otherwise.',
    `investigation_status` STRING COMMENT 'The current status of the safety investigation for this deviation: not required, pending, in progress, completed, or closed.. Valid values are `not_required|pending|in_progress|completed|closed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this airspace deviation record was last updated or modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `lateral_deviation_nm` DECIMAL(18,2) COMMENT 'The magnitude of lateral deviation from the cleared route in nautical miles. Null if deviation type is not lateral or route-related.',
    `minimum_separation_nm` DECIMAL(18,2) COMMENT 'The minimum horizontal separation in nautical miles between the deviating aircraft and other traffic during the event. Null if no traffic conflict occurred.',
    `pilot_acknowledgement_flag` BOOLEAN COMMENT 'Indicates whether the flight crew acknowledged the ATC clearance or instruction prior to the deviation. True if acknowledged, False if not acknowledged or unclear.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the airspace deviation meets the threshold for mandatory reporting to the national civil aviation authority (CAA) or ICAO ADREP. True if reportable, False otherwise.',
    `risk_score` STRING COMMENT 'Numerical risk score assigned to the deviation event based on likelihood and consequence, typically on a scale of 1-25 per SMS risk matrix.',
    `separation_loss_flag` BOOLEAN COMMENT 'Indicates whether the airspace deviation resulted in a loss of required separation from other aircraft or obstacles. True if separation was lost, False otherwise.',
    `severity_level` STRING COMMENT 'The assessed safety severity level of the deviation event based on risk assessment: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `speed_deviation_knots` STRING COMMENT 'The magnitude of speed deviation in knots (actual minus cleared). Positive indicates faster than cleared, negative indicates slower. Null if deviation type is not speed-related.',
    `weather_conditions` STRING COMMENT 'The meteorological conditions at the time of deviation: VMC (Visual Meteorological Conditions), IMC (Instrument Meteorological Conditions), marginal, or unknown.. Valid values are `vmc|imc|marginal|unknown`',
    CONSTRAINT pk_airspace_deviation PRIMARY KEY(`airspace_deviation_id`)
) COMMENT 'Airspace deviation and ATC instruction deviation records capturing events where an aircraft deviated from its cleared route, altitude, or ATC instruction. Captures deviation date, flight identifier, deviation type (altitude/lateral/speed/clearance), cleared value, actual value, deviation magnitude, ATC facility involved, pilot acknowledgement, cause classification (crew error/FMS error/ATC error/weather/equipment), and regulatory reporting status to national CAA and ICAO ADREP.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` (
    `dangerous_goods_incident_id` BIGINT COMMENT 'Unique identifier for the dangerous goods incident record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: DG incidents require aircraft contamination assessment, decontamination tracking, and airworthiness restoration documentation. Direct aircraft link enables maintenance teams to access incident history',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Dangerous goods incident investigation per ICAO Technical Instructions requires flight inventory context to assess passenger/cargo mix, capacity utilization, and segregation compliance. Critical for d',
    `flight_leg_id` BIGINT COMMENT 'Reference to the flight leg on which the dangerous goods incident occurred, if applicable.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: DG incidents trigger regulatory fines, cleanup costs, legal reserves, and potential liability claims posted to GL. Required for IATA DGR compliance reporting and financial statement disclosure of cont',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Dangerous goods incidents are a specific type of occurrence. Adding dangerous_goods_incident.occurrence_id → occurrence.occurrence_id links DG incident records to their master occurrence record. Remov',
    `report_id` BIGINT COMMENT 'Reference to the broader safety occurrence report if this dangerous goods incident is part of a larger safety occurrence.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Dangerous goods incidents have specific ICAO/IATA reporting requirements and packaging regulations. Links incident records to regulatory obligations, enabling compliance tracking for hazmat transporta',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Dangerous goods incidents involve shipper or handler vendors. ICAO/IATA DG regulations require tracking vendor responsibility for packaging failures, documentation errors, and regulatory notifications',
    `awb_number` STRING COMMENT 'The air waybill number associated with the cargo shipment containing the dangerous goods, if applicable.',
    `caa_notification_date` DATE COMMENT 'The date on which the dangerous goods incident was reported to the national civil aviation authority.',
    `caa_notification_status` STRING COMMENT 'The status of notification to the national civil aviation authority regarding this dangerous goods incident (e.g., not required, pending, submitted, acknowledged).. Valid values are `not_required|pending|submitted|acknowledged`',
    `consignee_name` STRING COMMENT 'The name of the consignee or recipient of the dangerous goods shipment.',
    `corrective_action_status` STRING COMMENT 'The status of corrective actions arising from this dangerous goods incident (e.g., not required, planned, in progress, completed).. Valid values are `not_required|planned|in_progress|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this dangerous goods incident record was first created in the system.',
    `damage_description` STRING COMMENT 'Description of any damage to aircraft, property, or other goods caused by the dangerous goods incident.',
    `damage_occurred_flag` BOOLEAN COMMENT 'Indicates whether any damage to aircraft, property, or other goods occurred as a result of the dangerous goods incident.',
    `detection_method` STRING COMMENT 'The method by which the dangerous goods incident was detected (e.g., visual inspection, X-ray screening, canine detection, crew observation, passenger report).',
    `detection_point` STRING COMMENT 'The point in the handling or flight process where the dangerous goods incident was detected (e.g., check-in, cargo acceptance, screening, loading, in-flight, unloading, post-flight). [ENUM-REF-CANDIDATE: check_in|cargo_acceptance|screening|loading|in_flight|unloading|post_flight — 7 candidates stripped; promote to reference product]',
    `dg_class` STRING COMMENT 'The IATA/ICAO dangerous goods class (e.g., Class 1 Explosives, Class 3 Flammable Liquids, Class 8 Corrosives) of the substance involved.',
    `dg_division` STRING COMMENT 'The subdivision within the dangerous goods class (e.g., Division 1.1, Division 2.2) providing further classification detail.',
    `icao_notification_date` DATE COMMENT 'The date on which the dangerous goods incident was reported to ICAO.',
    `icao_notification_status` STRING COMMENT 'The status of notification to ICAO regarding this dangerous goods incident (e.g., not required, pending, submitted, acknowledged).. Valid values are `not_required|pending|submitted|acknowledged`',
    `incident_description` STRING COMMENT 'Detailed narrative description of the dangerous goods incident, including circumstances, observations, and actions taken.',
    `incident_number` STRING COMMENT 'Externally-known unique reference number assigned to this dangerous goods incident for tracking and regulatory reporting purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the dangerous goods incident (e.g., reported, under investigation, closed, regulatory notified).. Valid values are `reported|under_investigation|closed|regulatory_notified`',
    `incident_type` STRING COMMENT 'Classification of the dangerous goods incident type (e.g., undeclared dangerous goods, misdeclared dangerous goods, packaging failure, leakage, spillage, fire).. Valid values are `undeclared_dg|misdeclared_dg|packaging_failure|leakage|spillage|fire`',
    `injury_description` STRING COMMENT 'Description of any injuries sustained by persons as a result of the dangerous goods incident.',
    `injury_occurred_flag` BOOLEAN COMMENT 'Indicates whether any injury to persons occurred as a result of the dangerous goods incident.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether a formal safety investigation is required for this dangerous goods incident.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this dangerous goods incident record was last updated in the system.',
    `packaging_failure_type` STRING COMMENT 'Description of the packaging failure mode if packaging failure contributed to the incident (e.g., seal failure, container rupture, inadequate cushioning).',
    `packaging_type` STRING COMMENT 'The type of packaging used for the dangerous goods (e.g., drum, cylinder, box, bag).',
    `packing_group` STRING COMMENT 'The packing group (I, II, or III) indicating the degree of danger presented by the dangerous goods.. Valid values are `I|II|III`',
    `proper_shipping_name` STRING COMMENT 'The proper shipping name of the dangerous goods as specified in the IATA Dangerous Goods Regulations.',
    `quantity_involved` DECIMAL(18,2) COMMENT 'The quantity of dangerous goods involved in the incident.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the quantity of dangerous goods involved (e.g., kg, L, g, mL, pieces).. Valid values are `kg|L|g|mL|pieces`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods incident meets the criteria for mandatory reporting to national civil aviation authority (CAA) or ICAO.',
    `reported_by_name` STRING COMMENT 'The name of the person who reported the dangerous goods incident.',
    `reported_by_role` STRING COMMENT 'The role or job function of the person who reported the dangerous goods incident (e.g., cargo agent, flight crew, ground handler).',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause analysis findings for the dangerous goods incident, if investigation was conducted.',
    `severity_level` STRING COMMENT 'The assessed severity level of the dangerous goods incident based on potential or actual consequences (e.g., minor, moderate, serious, critical).. Valid values are `minor|moderate|serious|critical`',
    `un_number` STRING COMMENT 'The four-digit UN number identifying the dangerous goods substance or article involved in the incident.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_dangerous_goods_incident PRIMARY KEY(`dangerous_goods_incident_id`)
) COMMENT 'Dangerous goods (DG) incident and undeclared dangerous goods occurrence records as required by ICAO Annex 18 and IATA DGR reporting. Captures incident date, flight or shipment reference, DG class and division (IATA/ICAO), UN number, proper shipping name, quantity involved, packaging failure type, detection point (check-in/cargo/in-flight/post-flight), injury or damage caused, shipper details, and regulatory notification status to national CAA and ICAO. Supports IATA DGR compliance management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`alert` (
    `alert_id` BIGINT COMMENT 'Unique identifier for the safety alert record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Safety alerts (airworthiness directives, manufacturer service bulletins) are issued for specific aircraft types. Proper FK enables automated alert distribution to affected fleet, compliance tracking, ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Safety alerts (manufacturer bulletins, regulatory notices) require immediate communication campaigns to affected personnel. Real business process: urgent safety communication distribution campaigns en',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Alerts are issued for specific hazards to communicate risk and required actions. Adding alert.hazard_id → hazard.hazard_id links alerts to the hazards they address. No redundant columns visible.',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safety.investigation. Business justification: Safety alerts can be issued in response to investigations or to communicate investigation findings. Adding alert.investigation_id → investigation.investigation_id tracks the source investigation. No r',
    `occurrence_id` BIGINT COMMENT 'Reference to the occurrence report that triggered or is associated with this alert. Null if alert is not linked to a specific occurrence.',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Alerts can be issued to communicate formal safety recommendations to operational teams. Adding alert.recommendation_id → recommendation.recommendation_id tracks which recommendation the alert communic',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`case` (
    `case_id` BIGINT COMMENT 'Unique identifier for the safety case record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the accountable executive or safety manager who approved the safety case for submission to the regulatory authority.',
    `case_prepared_by_employee_id` BIGINT COMMENT 'Employee identifier of the safety analyst or engineer who prepared the safety case documentation.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Safety cases justify operations in the context of identified hazards. Adding case.hazard_id → hazard.hazard_id links safety cases to the primary hazard they address. No redundant columns visible.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Safety cases are built to demonstrate compliance with specific regulatory requirements (ETOPS, RNP, low-visibility operations). Links safety case submissions to regulatory approval tracking and compli',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Safety cases reference formal risk assessments as evidence. Adding case.risk_assessment_id → risk_assessment.risk_assessment_id links cases to their supporting risk assessments. No redundant columns v',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Safety cases justify route-specific operations (ETOPS, special procedures, reduced separation). Required for route authority applications and regulatory approvals. Replaces text field with structured ',
    `acceptance_conditions` STRING COMMENT 'Specific conditions, limitations, or operational restrictions imposed by the regulatory authority as part of conditional acceptance, such as crew training requirements, route restrictions, weather minima, or periodic reporting obligations.',
    `acceptance_status` STRING COMMENT 'Final acceptance status from the regulatory authority: accepted (fully approved), conditionally_accepted (approved with conditions or limitations), rejected (not approved), or pending_clarification (awaiting additional information).. Valid values are `accepted|conditionally_accepted|rejected|pending_clarification`',
    `aircraft_type_codes` STRING COMMENT 'Comma-separated list of ICAO aircraft type codes (e.g., B789, A359, B77W) to which this safety case applies.',
    `approval_authority` STRING COMMENT 'Regulatory authority or internal governance body responsible for reviewing and accepting the safety case: FAA (Federal Aviation Administration), EASA (European Union Aviation Safety Agency), ICAO (International Civil Aviation Organization), CAAC (Civil Aviation Administration of China), DGCA (Directorate General of Civil Aviation), Transport Canada, or internal SMS (Safety Management System) committee. [ENUM-REF-CANDIDATE: FAA|EASA|ICAO|CAAC|DGCA|Transport_Canada|internal_SMS — 7 candidates stripped; promote to reference product]',
    `associated_project_code` STRING COMMENT 'Reference code of the operational change project, fleet introduction program, or route expansion initiative that this safety case supports.',
    `assumptions` STRING COMMENT 'Documented assumptions underpinning the safety case, such as operational environment conditions, crew qualifications, maintenance standards, air traffic control capabilities, and weather minima. Critical for validity and scope boundaries.',
    `case_status` STRING COMMENT 'Current lifecycle status of the safety case: draft (in preparation), under_review (internal review), submitted (sent to regulatory authority), accepted (approved by authority), rejected (not accepted), or withdrawn (retracted by airline).. Valid values are `draft|under_review|submitted|accepted|rejected|withdrawn`',
    `case_type` STRING COMMENT 'Classification of the safety case by operational domain: ETOPS (Extended-range Twin-engine Operational Performance Standards), RNAV/RNP (Area Navigation/Required Navigation Performance), new route approval, aircraft introduction, operational change, or regulatory exemption request.. Valid values are `ETOPS|RNAV_RNP|new_route|aircraft_introduction|operational_change|regulatory_exemption`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety case record was first created in the system.',
    `document_storage_location` STRING COMMENT 'File path, URL, or document management system reference where the full safety case documentation is stored for retrieval and audit purposes.',
    `effective_from_date` DATE COMMENT 'Date from which the approved safety case becomes operationally effective and the authorized operation may commence.',
    `evidence_references` STRING COMMENT 'Comma-separated list or structured references to supporting evidence documents, including risk assessments, hazard analyses, operational data, simulator trials, crew training records, maintenance programs, and third-party certifications.',
    `expiry_date` DATE COMMENT 'Date on which the safety case approval expires and requires renewal, re-submission, or operational cessation. Nullable for indefinite approvals subject to ongoing compliance.',
    `internal_approval_date` DATE COMMENT 'Date on which the safety case received internal approval from the accountable executive or SMS committee prior to regulatory submission.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety case record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or revalidation of the safety case.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information related to the safety case, including lessons learned, stakeholder feedback, or special considerations.',
    `operational_limitations` STRING COMMENT 'Documented operational limitations or restrictions associated with the safety case approval, such as weather minima, time-of-day restrictions, crew qualification requirements, or equipment mandates.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for the safety case, typically formatted as SC-YYYY-NNNN for tracking and regulatory submission purposes.. Valid values are `^SC-[0-9]{4}-[0-9]{4}$`',
    `regulatory_response_date` DATE COMMENT 'Date on which the regulatory authority provided formal response, feedback, or decision regarding the safety case submission.',
    `regulatory_response_summary` STRING COMMENT 'Summary of the regulatory authoritys response, including acceptance decision, conditions, requested clarifications, additional evidence requirements, or reasons for rejection.',
    `regulatory_tracking_reference` STRING COMMENT 'External tracking number or reference code assigned by the regulatory authority for monitoring the safety case submission and approval process.',
    `residual_risk_statement` STRING COMMENT 'Formal statement of residual risks remaining after all mitigations have been applied, including risk levels, acceptability rationale, and any ongoing monitoring or contingency measures required.',
    `review_frequency` STRING COMMENT 'Required frequency for periodic review and revalidation of the safety case: annual, biennial (every 2 years), triennial (every 3 years), event-driven (triggered by operational changes), or continuous (ongoing monitoring).. Valid values are `annual|biennial|triennial|event_driven|continuous`',
    `revision_history` STRING COMMENT 'Summary of revisions and updates made to the safety case over its lifecycle, including version numbers, dates, and descriptions of changes.',
    `safety_argument_structure` STRING COMMENT 'Structured outline or narrative of the safety argument, including claims, evidence, and reasoning that demonstrate acceptable safety levels for the proposed operation. May reference Goal Structuring Notation (GSN) or Claims-Arguments-Evidence (CAE) frameworks.',
    `scope_description` STRING COMMENT 'Detailed narrative describing the operational scope, boundaries, and applicability of the safety case, including aircraft types, routes, operational conditions, and any limitations or exclusions.',
    `submission_date` DATE COMMENT 'Date on which the safety case was formally submitted to the approval authority for review and acceptance.',
    `submission_method` STRING COMMENT 'Method by which the safety case was submitted to the regulatory authority: electronic portal, email, postal mail, or in-person delivery.. Valid values are `electronic_portal|email|postal_mail|in_person`',
    `title` STRING COMMENT 'Concise title summarizing the safety case subject, such as ETOPS Approval for B787-9 on Transatlantic Routes or RNAV RNP AR Approach Authorization for KJFK.',
    `version_number` STRING COMMENT 'Version number of the safety case document, typically in major.minor format (e.g., 1.0, 2.1), to track revisions and updates.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Formal safety case records used to justify safety arguments for new operations, route approvals, aircraft introductions, or operational changes requiring regulatory acceptance. Captures safety case reference, title, scope, associated change or project, safety argument structure, evidence references, assumptions, residual risk statement, approval authority, submission date, regulatory authority response, and acceptance status. Supports ETOPS approvals, RNAV/RNP authorisations, and new route safety assessments.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`committee` (
    `committee_id` BIGINT COMMENT 'Unique identifier for the safety committee record. Primary key. Role: MASTER_RESOURCE (safety governance body).',
    `employee_id` BIGINT COMMENT 'Employee identifier for the committee chairperson. Links to workforce master data for role verification and accountability tracking.',
    `committee_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this committee record. Provides accountability for data changes and supports audit trail requirements.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Safety committees review and make decisions on hazards. Adding committee.hazard_id → hazard.hazard_id tracks the primary hazard discussed in a committee meeting. No redundant columns visible.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety committees review occurrences as part of governance. Adding committee.occurrence_id → occurrence.occurrence_id tracks the primary occurrence under review in a committee meeting. No redundant co',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Safety committees review risk assessments and make risk acceptance decisions. Adding committee.risk_assessment_id → risk_assessment.risk_assessment_id tracks the primary risk assessment under review. ',
    `parent_committee_id` BIGINT COMMENT 'Self-referencing FK on committee (parent_committee_id)',
    `action_deadlines` STRING COMMENT 'Target completion dates for assigned action items. May be structured as comma-separated dates or narrative description of multiple deadlines.',
    `action_item_count` STRING COMMENT 'Total number of action items assigned during the committee meeting. Used for tracking committee productivity and follow-up workload.',
    `action_items_assigned` STRING COMMENT 'List of corrective actions, safety recommendations, and follow-up tasks assigned during the committee meeting. Includes action item descriptions and assignment details.',
    `action_owners` STRING COMMENT 'Comma-separated list of individuals or departments assigned responsibility for completing action items. Establishes accountability for safety improvement actions.',
    `agenda_items` STRING COMMENT 'Structured list or narrative description of topics and items scheduled for discussion during the committee meeting. Provides context for safety topics reviewed and decisions made.',
    `attendee_count` STRING COMMENT 'Total number of individuals who attended the committee meeting. Used for quorum verification and meeting effectiveness tracking.',
    `attendee_list` STRING COMMENT 'Comma-separated list of names of all individuals who attended the committee meeting. Provides audit trail for management participation and decision-making accountability per ICAO Annex 19 requirements.',
    `chairperson_name` STRING COMMENT 'Full name of the individual who chaired the safety committee meeting. Typically the Accountable Executive for Safety Review Board meetings per ICAO Annex 19 Component 1 requirements.',
    `committee_status` STRING COMMENT 'Current lifecycle status of the safety committee. Active committees hold regular meetings and exercise governance authority. Inactive committees are temporarily paused. Dissolved committees have been permanently disbanded.. Valid values are `Active|Inactive|Suspended|Dissolved`',
    `committee_type` STRING COMMENT 'Classification of the safety committee within the SMS (Safety Management System) governance structure. Safety Review Board (SRB) is the highest-level management committee responsible for safety policy and risk acceptance decisions. Safety Action Groups are operational-level committees addressing specific safety domains.. Valid values are `Safety Review Board|Safety Action Group|Flight Safety Committee|Ground Safety Committee|Cabin Safety Committee|MRO Safety Committee`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this committee record was first created in the system. Audit trail for record creation.',
    `escalation_decisions` STRING COMMENT 'Summary of decisions made to escalate safety issues to higher management levels or external regulatory authorities. Documents when issues require Accountable Executive attention or regulatory notification.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether any safety issues discussed in the meeting require escalation to higher management or regulatory authorities. True if escalation is required, False otherwise.',
    `hazards_discussed` STRING COMMENT 'List or narrative of specific hazard identifications reviewed by the committee, including hazard numbers and brief descriptions. Links to hazard register for detailed hazard data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this committee record was last updated. Audit trail for record modifications and data lineage tracking.',
    `meeting_date` DATE COMMENT 'Date on which the safety committee meeting occurred. Principal business event timestamp for this governance record. Used for tracking meeting frequency compliance and audit trail per ICAO Annex 19 requirements.',
    `meeting_end_time` TIMESTAMP COMMENT 'Timestamp when the committee meeting concluded. Used for meeting duration tracking and resource planning.',
    `meeting_frequency` STRING COMMENT 'Scheduled frequency at which the committee is required to meet per SMS governance framework. Safety Review Boards typically meet quarterly or monthly; operational committees may meet more frequently. [ENUM-REF-CANDIDATE: Weekly|Bi-Weekly|Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc — 7 candidates stripped; promote to reference product]',
    `meeting_location` STRING COMMENT 'Physical or virtual location where the committee meeting was held (e.g., headquarters conference room, station code, or virtual platform identifier).',
    `meeting_start_time` TIMESTAMP COMMENT 'Timestamp when the committee meeting commenced. Used for meeting duration tracking and scheduling compliance.',
    `minutes_approval_date` DATE COMMENT 'Date on which the committee meeting minutes were formally approved. Required for audit trail and regulatory compliance documentation.',
    `minutes_approved_flag` BOOLEAN COMMENT 'Indicates whether the meeting minutes have been formally reviewed and approved by the committee. True if approved, False if pending approval.',
    `minutes_reference` STRING COMMENT 'Document reference number or storage location for the detailed meeting minutes. Links to full meeting documentation for audit and regulatory review.',
    `next_meeting_date` DATE COMMENT 'Scheduled date for the next committee meeting. Used for tracking meeting frequency compliance with SMS requirements and regulatory standards.',
    `notes` STRING COMMENT 'Additional notes, observations, or context regarding the committee meeting. May include special circumstances, attendance issues, or other relevant information not captured in structured fields.',
    `quorum_met_flag` BOOLEAN COMMENT 'Indicates whether the minimum required attendance (quorum) was achieved for the meeting to conduct official business and make binding decisions. True if quorum was met, False otherwise.',
    `reference_number` STRING COMMENT 'Business identifier for the committee record, typically formatted as airline code-committee type-year (e.g., AAL-SRB-2024). Externally-known unique code for audit trail and regulatory reporting.. Valid values are `^[A-Z]{3}-[A-Z]{2,4}-[0-9]{4}$`',
    `regulatory_observer_agency` STRING COMMENT 'Name of the regulatory authority whose representative attended the meeting as an observer (e.g., FAA, EASA, Transport Canada, national Civil Aviation Authority).',
    `regulatory_observer_present` BOOLEAN COMMENT 'Indicates whether a representative from a regulatory authority (FAA, EASA, national CAA) attended the meeting as an observer. True if regulatory observer was present, False otherwise.',
    `risk_acceptance_decisions` STRING COMMENT 'Formal decisions made by the committee regarding acceptance of identified safety risks. Documents which risks were accepted, conditionally accepted, or rejected, along with management rationale. Critical for ICAO Annex 19 Component 1 management accountability requirements.',
    `risk_acceptance_rationale` STRING COMMENT 'Detailed justification and business reasoning provided by management for accepting specific safety risks. Required documentation for regulatory compliance and audit trail per ICAO Annex 19.',
    `risks_discussed` STRING COMMENT 'Summary of safety risk assessments and risk levels reviewed by the committee. Includes discussion of risk mitigation strategies and residual risk evaluations.',
    `safety_topics_reviewed` STRING COMMENT 'Summary of safety management topics, hazards, risks, and safety performance indicators discussed during the meeting. Core content of the committees safety oversight function.',
    `sms_accountable_executive_present` BOOLEAN COMMENT 'Indicates whether the SMS Accountable Executive (the senior management position with ultimate responsibility for safety performance) attended the meeting. Required for Safety Review Board meetings per ICAO Annex 19 Component 1.',
    CONSTRAINT pk_committee PRIMARY KEY(`committee_id`)
) COMMENT 'Safety committee and Safety Review Board (SRB) governance records capturing formal safety management decisions within the SMS framework. Records committee type (Safety Review Board/Safety Action Group/Flight Safety Committee/Ground Safety Committee/Cabin Safety Committee), meeting date, attendees and roles, agenda items, safety topics reviewed, hazards and risks discussed, risk acceptance decisions with rationale, action items assigned with owners and deadlines, minutes reference, escalation decisions, and next review date. Provides the audit trail for management accountability per ICAO Annex 19 Component 1 (Safety Policy and Objectives) requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`safety`.`alert_distribution` (
    `alert_distribution_id` BIGINT COMMENT 'Unique identifier for this alert distribution record. Primary key.',
    `alert_id` BIGINT COMMENT 'Foreign key linking to the safety alert being distributed',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the marketing channel used for distribution',
    `acknowledgement_count` STRING COMMENT 'Number of recipients who acknowledged receipt of this alert through this specific channel',
    `channel_effectiveness_score` DECIMAL(18,2) COMMENT 'Calculated effectiveness score for this alert-channel combination based on delivery rate and acknowledgement rate',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this distribution record was created',
    `delivery_attempt_count` STRING COMMENT 'Number of delivery attempts made for this alert through this channel',
    `delivery_status` STRING COMMENT 'Current delivery status of the alert through this channel',
    `distribution_status` STRING COMMENT 'Current state of alert dissemination to relevant departments and personnel: pending (awaiting distribution), distributed (sent to stakeholders), acknowledged (receipt confirmed), or overdue (acknowledgement deadline passed). [Moved from alert: Distribution status is specific to each alert-channel combination, not a global property of the alert. Different channels may have different distribution statuses for the same alert.]. Valid values are `pending|distributed|acknowledged|overdue`',
    `distribution_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was distributed through this specific channel',
    `last_delivery_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent delivery attempt for this alert through this channel',
    `target_recipient_count` STRING COMMENT 'Total number of recipients targeted for this alert through this specific channel',
    CONSTRAINT pk_alert_distribution PRIMARY KEY(`alert_distribution_id`)
) COMMENT 'This association product represents the distribution event between safety alerts and marketing channels. It captures the operational process of disseminating safety-critical information through various communication channels to ensure timely delivery and acknowledgement tracking. Each record links one alert to one marketing channel with attributes that exist only in the context of this distribution relationship.. Existence Justification: In airline safety operations, a single safety alert must be distributed through multiple communication channels simultaneously (email to management, SMS to critical personnel, crew app notifications, intranet posting) to ensure comprehensive reach. Each channel serves different recipient populations with different delivery characteristics, acknowledgement rates, and effectiveness metrics. The business actively manages alert distribution as an operational process, tracking delivery status, acknowledgement compliance, and channel effectiveness for each alert-channel combination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `airlines_ecm`.`safety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ADD CONSTRAINT `fk_safety_fdr_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ADD CONSTRAINT `fk_safety_fdr_event_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ADD CONSTRAINT `fk_safety_fatigue_report_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ADD CONSTRAINT `fk_safety_spi_measurement_performance_indicator_id` FOREIGN KEY (`performance_indicator_id`) REFERENCES `airlines_ecm`.`safety`.`performance_indicator`(`performance_indicator_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ADD CONSTRAINT `fk_safety_runway_incursion_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ADD CONSTRAINT `fk_safety_runway_incursion_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ADD CONSTRAINT `fk_safety_airspace_deviation_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ADD CONSTRAINT `fk_safety_airspace_deviation_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_superseded_by_alert_id` FOREIGN KEY (`superseded_by_alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`safety`.`case` ADD CONSTRAINT `fk_safety_case_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`case` ADD CONSTRAINT `fk_safety_case_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `airlines_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `airlines_ecm`.`safety`.`committee` ADD CONSTRAINT `fk_safety_committee_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`safety`.`committee` ADD CONSTRAINT `fk_safety_committee_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`safety`.`committee` ADD CONSTRAINT `fk_safety_committee_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `airlines_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `airlines_ecm`.`safety`.`committee` ADD CONSTRAINT `fk_safety_committee_parent_committee_id` FOREIGN KEY (`parent_committee_id`) REFERENCES `airlines_ecm`.`safety`.`committee`(`committee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ADD CONSTRAINT `fk_safety_alert_distribution_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`safety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`safety` SET TAGS ('dbx_domain' = 'safety');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence ID');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Pax Profile Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `seasonal_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Schedule Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`safety`.`hazard` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Accountable Executive Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Safety Officer Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `hazard_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `affected_operations_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Operations Area');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `affected_station` SET TAGS ('dbx_business_glossary_term' = 'Affected Station Code');
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ALTER COLUMN `affected_station` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (ID)');
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
ALTER TABLE `airlines_ecm`.`safety`.`audit` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_sms|iosa_preparation|regulatory_authority|losa|line_station|maintenance');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audited_department` SET TAGS ('dbx_business_glossary_term' = 'Audited Department');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audited_function` SET TAGS ('dbx_business_glossary_term' = 'Audited Function');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audited_station_code` SET TAGS ('dbx_business_glossary_term' = 'Audited Station Code');
ALTER TABLE `airlines_ecm`.`safety`.`audit` ALTER COLUMN `audited_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
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
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
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
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` SET TAGS ('dbx_subdomain' = 'flight_monitoring');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `fdr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Data Recorder (FDR) Event ID');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Report ID');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `altitude_feet` SET TAGS ('dbx_business_glossary_term' = 'Altitude (Feet)');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|closed');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `crew_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Notified Flag');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'fdr|qar|acars|ems');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'operational|technical|environmental|crew_action');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'FDR Event Type');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'exceedance|parameter_breach|unusual_attitude|hard_landing|gpws_alert|tcas_ra');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `exceedance_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Duration (Seconds)');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `fdm_program_version` SET TAGS ('dbx_business_glossary_term' = 'Flight Data Monitoring (FDM) Program Version');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `indicated_airspeed_knots` SET TAGS ('dbx_business_glossary_term' = 'Indicated Airspeed (Knots)');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Parameter Name');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `recorded_value` SET TAGS ('dbx_business_glossary_term' = 'Recorded Parameter Value');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Event Severity Level');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit Value');
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `airlines_ecm`.`safety`.`report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`report` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Report Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Employee Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `airlines_ecm`.`safety`.`investigation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `investigation_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Management System (SMS) Hazard Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Source Audit Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Source Investigation Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Source Occurrence Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
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
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ALTER COLUMN `related_sop_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Standard Operating Procedure (SOP) Reference');
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
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` SET TAGS ('dbx_subdomain' = 'flight_monitoring');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `fatigue_report_id` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Report Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Safety Occurrence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `confidential_report` SET TAGS ('dbx_business_glossary_term' = 'Confidential Report');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `contributing_factor_circadian_disruption` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Circadian Disruption');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `contributing_factor_irop` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Irregular Operations (IROP)');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `contributing_factor_other` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Other');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `contributing_factor_sleep_disruption` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Sleep Disruption');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `contributing_factor_workload` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Workload');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `duty_period_reference` SET TAGS ('dbx_business_glossary_term' = 'Duty Period Reference');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `duty_period_reference` SET TAGS ('dbx_value_regex' = '^DP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `fatigue_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Scale Type');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `fatigue_scale_type` SET TAGS ('dbx_value_regex' = 'samn_perelli|karolinska|custom|other');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `fatigue_symptoms_description` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Symptoms Description');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `flight_phase_experienced` SET TAGS ('dbx_business_glossary_term' = 'Flight Phase When Fatigue Experienced');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `frms_trend_category` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Management System (FRMS) Trend Category');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Report Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_value_regex' = '^FR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Report Status');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|investigation|closed|archived');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `reported_fatigue_level` SET TAGS ('dbx_business_glossary_term' = 'Reported Fatigue Level');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `reporter_crew_category` SET TAGS ('dbx_business_glossary_term' = 'Reporter Crew Category');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `reporter_crew_category` SET TAGS ('dbx_value_regex' = 'flight_crew|cabin_crew|ground_crew|maintenance_crew|dispatch|other');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `review_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `safety_event_occurred` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Occurred');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `safety_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Assessment');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `safety_impact_assessment` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `emergency_drill_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Exercise Controller Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Simulated Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Simulated Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `communication_systems_tested` SET TAGS ('dbx_business_glossary_term' = 'Communication Systems Tested');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `debrief_date` SET TAGS ('dbx_business_glossary_term' = 'Debrief Date');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `debrief_findings` SET TAGS ('dbx_business_glossary_term' = 'Debrief Findings');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_date` SET TAGS ('dbx_business_glossary_term' = 'Drill Date');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_end_time` SET TAGS ('dbx_business_glossary_term' = 'Drill End Time');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Drill Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_start_time` SET TAGS ('dbx_business_glossary_term' = 'Drill Start Time');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Status');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_status` SET TAGS ('dbx_value_regex' = 'planned|scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Type');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_type` SET TAGS ('dbx_value_regex' = 'full_scale|tabletop|functional|communications|evacuation|medical');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `erp_version_reference` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) Version Reference');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `exercise_controller_name` SET TAGS ('dbx_business_glossary_term' = 'Exercise Controller Name');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `exercise_controller_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `external_agencies_involved` SET TAGS ('dbx_business_glossary_term' = 'External Agencies Involved');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `improvement_action_count` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Count');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `improvement_actions_identified` SET TAGS ('dbx_business_glossary_term' = 'Improvement Actions Identified');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `next_drill_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Drill Due Date');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `objectives_defined` SET TAGS ('dbx_business_glossary_term' = 'Objectives Defined');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `objectives_met_count` SET TAGS ('dbx_business_glossary_term' = 'Objectives Met Count');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `objectives_not_met_count` SET TAGS ('dbx_business_glossary_term' = 'Objectives Not Met Count');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `observer_list` SET TAGS ('dbx_business_glossary_term' = 'Observer List');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `observer_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `participating_departments` SET TAGS ('dbx_business_glossary_term' = 'Participating Departments');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `participating_stations` SET TAGS ('dbx_business_glossary_term' = 'Participating Stations');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `primary_station_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Station Code');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `primary_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `regulatory_observer_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Observer Agency');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `regulatory_observer_present` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Observer Present');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `report_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Report Completed Date');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `report_submitted_to` SET TAGS ('dbx_business_glossary_term' = 'Report Submitted To');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `scenario_category` SET TAGS ('dbx_business_glossary_term' = 'Scenario Category');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `scenario_category` SET TAGS ('dbx_value_regex' = 'aircraft_accident|medical_emergency|security_threat|fire|hazmat|natural_disaster');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ALTER COLUMN `sop_references` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) References');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `performance_indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Indicator (SPI) Identifier');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Method Type');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `alert_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Value');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Role');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source Reference');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method Formula');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `easa_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union Aviation Safety Agency (EASA) Alignment Flag');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `faa_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Aviation Administration (FAA) Alignment Flag');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `icao_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Alignment Flag');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Indicator (SPI) Category');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_value_regex' = 'leading|lagging');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Indicator (SPI) Code');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}-[0-9]{3,4}$');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Indicator (SPI) Description');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Indicator (SPI) Name');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_business_glossary_term' = 'Indicator Lifecycle Status');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|retired');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency Period');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|real-time');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Indicator Definition Notes');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Alignment');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Level Classification');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `reporting_level` SET TAGS ('dbx_value_regex' = 'operational|tactical|strategic|executive');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department or Division');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Indicator Review Frequency');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Target (SPT) Value');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `trend_analysis_enabled` SET TAGS ('dbx_business_glossary_term' = 'Trend Analysis Enabled Flag');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Indicator Definition Version Number');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `airlines_ecm`.`safety`.`performance_indicator` ALTER COLUMN `warning_threshold` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold Value');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `spi_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Indicator (SPI) Measurement ID');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `performance_indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Indicator (SPI) ID');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Analyst ID');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Value');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `alert_threshold_breached_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Breached Flag');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `alert_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Value');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|provisional|estimated|incomplete|suspect');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid|calculated');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|published');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `reporting_period_month` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Month');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `reporting_period_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Quarter');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `reporting_period_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Year');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `target_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Target Met Flag');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|deteriorating|insufficient_data');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `variance_from_target` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `warning_threshold_breached_flag` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold Breached Flag');
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ALTER COLUMN `warning_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold Value');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` SET TAGS ('dbx_subdomain' = 'flight_monitoring');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `wildlife_strike_id` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Strike Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `destination_content_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Content Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Report Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `aircraft_out_of_service_hours` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Out of Service Hours');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `aircraft_out_of_service_hours` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `aircraft_part_struck` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Part Struck');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `altitude_feet` SET TAGS ('dbx_business_glossary_term' = 'Altitude in Feet');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate in United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `damage_level` SET TAGS ('dbx_business_glossary_term' = 'Damage Level');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `damage_level` SET TAGS ('dbx_value_regex' = 'none|minor|substantial|destroyed|unknown');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `effect_on_flight` SET TAGS ('dbx_business_glossary_term' = 'Effect on Flight Operations');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `effect_on_flight` SET TAGS ('dbx_value_regex' = 'none|aborted_takeoff|precautionary_landing|engine_shutdown|other|unknown');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `engine_ingestion_flag` SET TAGS ('dbx_business_glossary_term' = 'Engine Ingestion Flag');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `faa_report_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Aviation Administration (FAA) Report Number');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `icao_report_reference` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Report Reference');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `indicated_airspeed_knots` SET TAGS ('dbx_business_glossary_term' = 'Indicated Airspeed in Knots');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|closed');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `pilot_warned_flag` SET TAGS ('dbx_business_glossary_term' = 'Pilot Warned Flag');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `precipitation` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Type');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `precipitation` SET TAGS ('dbx_value_regex' = 'none|rain|snow|fog|unknown');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `remains_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Remains Collected Flag');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `remains_sent_to_lab_flag` SET TAGS ('dbx_business_glossary_term' = 'Remains Sent to Laboratory Flag');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Repair Hours');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `repair_hours` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `reporter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `reporter_role` SET TAGS ('dbx_business_glossary_term' = 'Reporter Role');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `sky_condition` SET TAGS ('dbx_business_glossary_term' = 'Sky Condition');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `sky_condition` SET TAGS ('dbx_value_regex' = 'clear|overcast|fog|rain|snow|unknown');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `species_identified` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Species Identified');
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ALTER COLUMN `species_quantity` SET TAGS ('dbx_business_glossary_term' = 'Species Quantity');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` SET TAGS ('dbx_subdomain' = 'flight_monitoring');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `runway_incursion_id` SET TAGS ('dbx_business_glossary_term' = 'Runway Incursion Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Report Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `atc_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'ATC (Air Traffic Control) Clearance Status');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `atc_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|not_cleared|unclear|not_applicable');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `atc_instruction` SET TAGS ('dbx_business_glossary_term' = 'ATC (Air Traffic Control) Instruction');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `collision_avoidance_action` SET TAGS ('dbx_business_glossary_term' = 'Collision Avoidance Action');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `contributing_factor_communication` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Communication');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `contributing_factor_lighting` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Lighting');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `contributing_factor_procedures` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Procedures');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `contributing_factor_signage` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Signage');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `contributing_factor_situational_awareness` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Situational Awareness');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `contributing_factor_training` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factor - Training');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|verified');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Runway Incursion Event Number');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^RI-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `incursion_category` SET TAGS ('dbx_business_glossary_term' = 'Incursion Category');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `incursion_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `incursion_type` SET TAGS ('dbx_business_glossary_term' = 'Incursion Type');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `incursion_type` SET TAGS ('dbx_value_regex' = 'aircraft|vehicle|pedestrian|mixed');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|pending_review');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `investigator_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigator Notes');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `runway_designator` SET TAGS ('dbx_business_glossary_term' = 'Runway Designator');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `runway_designator` SET TAGS ('dbx_value_regex' = '^[0-9]{2}[LCR]?$');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `separation_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Separation Distance in Meters');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `time_of_day` SET TAGS ('dbx_business_glossary_term' = 'Time of Day');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `time_of_day` SET TAGS ('dbx_value_regex' = 'day|night|dawn|dusk');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `vehicle_operator` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Operator');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `visibility_meters` SET TAGS ('dbx_business_glossary_term' = 'Visibility in Meters');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'VMC|IMC|marginal');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` SET TAGS ('dbx_subdomain' = 'flight_monitoring');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `airspace_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Airspace Deviation ID');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Report ID');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `actual_altitude_feet` SET TAGS ('dbx_business_glossary_term' = 'Actual Altitude (Feet)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `actual_route` SET TAGS ('dbx_business_glossary_term' = 'Actual Route');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `actual_speed_knots` SET TAGS ('dbx_business_glossary_term' = 'Actual Speed (Knots)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `altitude_deviation_feet` SET TAGS ('dbx_business_glossary_term' = 'Altitude Deviation (Feet)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `atc_clearance_text` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Clearance Text');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `atc_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Facility Code');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `atc_facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `atc_sector` SET TAGS ('dbx_business_glossary_term' = 'Air Traffic Control (ATC) Sector');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `caa_report_date` SET TAGS ('dbx_business_glossary_term' = 'Civil Aviation Authority (CAA) Report Date');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `caa_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Civil Aviation Authority (CAA) Report Reference');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `caa_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Civil Aviation Authority (CAA) Reported Flag');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Cause Classification');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `cleared_altitude_feet` SET TAGS ('dbx_business_glossary_term' = 'Cleared Altitude (Feet)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `cleared_route` SET TAGS ('dbx_business_glossary_term' = 'Cleared Route');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `cleared_speed_knots` SET TAGS ('dbx_business_glossary_term' = 'Cleared Speed (Knots)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `crew_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Notified Flag');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_business_glossary_term' = 'Deviation Type');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_value_regex' = 'altitude|lateral|speed|clearance|route|other');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `icao_adrep_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'ICAO Accident/Incident Data Reporting (ADREP) Reported Flag');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|closed');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `lateral_deviation_nm` SET TAGS ('dbx_business_glossary_term' = 'Lateral Deviation (Nautical Miles)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `minimum_separation_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Separation (Nautical Miles)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `pilot_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Pilot Acknowledgement Flag');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `separation_loss_flag` SET TAGS ('dbx_business_glossary_term' = 'Separation Loss Flag');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `speed_deviation_knots` SET TAGS ('dbx_business_glossary_term' = 'Speed Deviation (Knots)');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_value_regex' = 'vmc|imc|marginal|unknown');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `dangerous_goods_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Incident ID');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Report ID');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `caa_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Civil Aviation Authority (CAA) Notification Date');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `caa_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Civil Aviation Authority (CAA) Notification Status');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `caa_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `damage_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Occurred Flag');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `detection_point` SET TAGS ('dbx_business_glossary_term' = 'Detection Point');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `dg_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Class');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `dg_division` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Division');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `icao_notification_date` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Notification Date');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `icao_notification_status` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Notification Status');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `icao_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|closed|regulatory_notified');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'undeclared_dg|misdeclared_dg|packaging_failure|leakage|spillage|fire');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `injury_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `injury_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Injury Occurred Flag');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `packaging_failure_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Failure Type');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `quantity_involved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Involved');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|L|g|mL|pieces');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reported By Role');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|serious|critical');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`safety`.`alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`safety`.`alert` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Identifier (ID)');
ALTER TABLE `airlines_ecm`.`safety`.`alert` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`safety`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`safety`.`case` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Case ID');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_prepared_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee ID');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_prepared_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_prepared_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `acceptance_conditions` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Conditions');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Acceptance Status');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|conditionally_accepted|rejected|pending_clarification');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `aircraft_type_codes` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Codes');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `associated_project_code` SET TAGS ('dbx_business_glossary_term' = 'Associated Project Code');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Assumptions');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Status');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|submitted|accepted|rejected|withdrawn');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Type');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'ETOPS|RNAV_RNP|new_route|aircraft_introduction|operational_change|regulatory_exemption');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Effective From Date');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `evidence_references` SET TAGS ('dbx_business_glossary_term' = 'Evidence References');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Expiry Date');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Safety Case Review Date');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Notes');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `operational_limitations` SET TAGS ('dbx_business_glossary_term' = 'Operational Limitations');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `regulatory_response_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Response Date');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `regulatory_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Response Summary');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `regulatory_tracking_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tracking Reference');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `residual_risk_statement` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Statement');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Review Frequency');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|event_driven|continuous');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'Revision History');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `safety_argument_structure` SET TAGS ('dbx_business_glossary_term' = 'Safety Argument Structure');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Scope Description');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Submission Date');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_portal|email|postal_mail|in_person');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Title');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Version Number');
ALTER TABLE `airlines_ecm`.`safety`.`case` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `airlines_ecm`.`safety`.`committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`safety`.`committee` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_id` SET TAGS ('dbx_business_glossary_term' = 'Committee ID');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Employee ID');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `parent_committee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `action_deadlines` SET TAGS ('dbx_business_glossary_term' = 'Action Deadlines');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `action_item_count` SET TAGS ('dbx_business_glossary_term' = 'Action Item Count');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `action_items_assigned` SET TAGS ('dbx_business_glossary_term' = 'Action Items Assigned');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `action_owners` SET TAGS ('dbx_business_glossary_term' = 'Action Owners');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `action_owners` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `action_owners` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `agenda_items` SET TAGS ('dbx_business_glossary_term' = 'Agenda Items');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `attendee_list` SET TAGS ('dbx_business_glossary_term' = 'Attendee List');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `attendee_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `attendee_list` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Name');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Dissolved');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_value_regex' = 'Safety Review Board|Safety Action Group|Flight Safety Committee|Ground Safety Committee|Cabin Safety Committee|MRO Safety Committee');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `escalation_decisions` SET TAGS ('dbx_business_glossary_term' = 'Escalation Decisions');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `hazards_discussed` SET TAGS ('dbx_business_glossary_term' = 'Hazards Discussed');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `meeting_end_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting End Time');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `meeting_start_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting Start Time');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `minutes_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Minutes Approval Date');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `minutes_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Minutes Approved Flag');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `minutes_reference` SET TAGS ('dbx_business_glossary_term' = 'Minutes Reference');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `next_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Next Meeting Date');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Committee Notes');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `quorum_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Quorum Met Flag');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Committee Reference Number');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z]{2,4}-[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `regulatory_observer_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Observer Agency');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `regulatory_observer_present` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Observer Present');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `risk_acceptance_decisions` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Decisions');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `risk_acceptance_rationale` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Rationale');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `risks_discussed` SET TAGS ('dbx_business_glossary_term' = 'Risks Discussed');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `safety_topics_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Safety Topics Reviewed');
ALTER TABLE `airlines_ecm`.`safety`.`committee` ALTER COLUMN `sms_accountable_executive_present` SET TAGS ('dbx_business_glossary_term' = 'SMS (Safety Management System) Accountable Executive Present');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` SET TAGS ('dbx_association_edges' = 'safety.alert,marketing.marketing_channel');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `alert_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Distribution ID');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Distribution - Alert Id');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Distribution - Marketing Channel Id');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `acknowledgement_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Count');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `channel_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Channel Effectiveness Score');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `delivery_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Count');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|distributed|acknowledged|overdue');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `last_delivery_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Delivery Attempt Timestamp');
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ALTER COLUMN `target_recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Target Recipient Count');
