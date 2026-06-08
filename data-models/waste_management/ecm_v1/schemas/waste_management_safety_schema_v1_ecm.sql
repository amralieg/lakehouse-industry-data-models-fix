-- Schema for Domain: safety | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`safety` COMMENT 'Occupational health and safety management for field operations including job hazard analyses, safety observations, incident investigations, PPE management, safety meetings, and OSHA recordkeeping for waste collection, landfill, MRF, and hazmat operations';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`safety_program` (
    `safety_program_id` BIGINT COMMENT 'Unique identifier for the occupational health and safety program record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee (typically EHS manager or safety director) who is accountable for the design, implementation, and compliance of this safety program.',
    `primary_safety_coordinator_employee_id` BIGINT COMMENT 'Identifier of the employee who coordinates day-to-day program activities, training scheduling, and documentation for this safety program.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Safety programs (OSHA PSM, RCRA contingency plans, SPCC) are driven by specific regulatory requirements. This link is fundamental for program design, audit trails, and demonstrating regulatory complia',
    `parent_safety_program_id` BIGINT COMMENT 'Self-referencing FK on safety_program (parent_safety_program_id)',
    `applicable_facility_types` STRING COMMENT 'Comma-separated list of facility types where this safety program must be implemented (e.g., Landfill, MRF, Transfer Station, Maintenance Depot, Administrative Office, TSDF). Null if program applies to field operations only.',
    `applicable_operation_types` STRING COMMENT 'Comma-separated list of operation types to which this safety program applies (e.g., Residential Collection, Commercial Collection, Landfill, MRF, Hazmat, Fleet Maintenance, WTE Facility). Indicates scope of program applicability.',
    `approval_date` DATE COMMENT 'The date on which this safety program was formally approved by management or the designated authority for implementation.',
    `audit_frequency_months` STRING COMMENT 'The required interval in months between formal compliance audits of this safety program (e.g., 12 for annual audit, 6 for semi-annual audit). Null if no periodic audit is required.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated for the implementation, training, equipment, and administration of this safety program in USD.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether employees must obtain formal certification or qualification to participate in activities governed by this safety program (True) or not (False).',
    `compliance_score` DECIMAL(18,2) COMMENT 'Most recent overall compliance score for this safety program based on audits, inspections, and performance metrics, expressed as a percentage (0.00 to 100.00). Null if not yet assessed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety program record was first created in the system.',
    `document_url` STRING COMMENT 'URL or file path to the official written safety program document, policy manual, or standard operating procedure that defines this program in detail.. Valid values are `^https?://.*$`',
    `effective_date` DATE COMMENT 'The date on which this safety program became or will become effective and enforceable across applicable operations.',
    `expiration_date` DATE COMMENT 'The date on which this safety program is scheduled to expire or be retired. Null for ongoing programs without a defined end date.',
    `incident_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether incidents or near-misses related to this safety program must be formally reported and investigated (True) or not (False).',
    `last_audit_date` DATE COMMENT 'The most recent date on which a formal compliance audit of this safety program was conducted.',
    `last_review_date` DATE COMMENT 'The most recent date on which this safety program was formally reviewed for compliance, effectiveness, and currency with regulatory requirements.',
    `medical_surveillance_required_flag` BOOLEAN COMMENT 'Indicates whether this safety program requires periodic medical examinations or health monitoring for covered employees (True) or not (False). Common for respiratory protection, hearing conservation, and hazmat programs.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next formal compliance audit of this safety program.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this safety program to ensure ongoing compliance and effectiveness.',
    `non_compliance_count` STRING COMMENT 'Total number of non-compliance findings or violations identified for this safety program during the most recent audit or reporting period.',
    `objectives` STRING COMMENT 'Specific measurable objectives or goals that this safety program is designed to achieve (e.g., zero lost-time injuries, 100% PPE compliance, reduction in exposure incidents).',
    `ppe_required_flag` BOOLEAN COMMENT 'Indicates whether this safety program mandates the use of specific Personal Protective Equipment (PPE) for covered employees (True) or not (False).',
    `ppe_types_required` STRING COMMENT 'Comma-separated list of PPE types required under this safety program (e.g., Hard Hat, Safety Glasses, Respirator, Gloves, Steel-Toe Boots, High-Visibility Vest, Hearing Protection). Null if no PPE is required.',
    `program_code` STRING COMMENT 'Unique alphanumeric code assigned to the safety program for internal reference and system integration (e.g., HAZCOM, LOTO, RESPPROT).. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the safety programs purpose, scope, key requirements, and objectives. Provides context for program implementation and compliance.',
    `program_name` STRING COMMENT 'Full official name of the occupational health and safety program (e.g., Hazard Communication Program, Lockout/Tagout Program, Respiratory Protection Program).',
    `program_status` STRING COMMENT 'Current lifecycle status of the safety program indicating whether it is actively enforced, under development, suspended, or archived.. Valid values are `Active|Inactive|Under Development|Under Review|Suspended|Archived`',
    `program_type` STRING COMMENT 'Classification of the safety program based on its regulatory or business origin (OSHA-mandated, internal voluntary initiative, industry best practice, client-required, state-mandated, DOT-required).. Valid values are `OSHA Mandated|Internal Voluntary|Industry Best Practice|Client Required|State Mandated|DOT Required`',
    `record_retention_years` STRING COMMENT 'The number of years that records related to this safety program must be retained to meet regulatory and legal requirements (e.g., 5 years for OSHA 300 logs, 30 years for exposure records). Null if no specific retention requirement.',
    `recordkeeping_required_flag` BOOLEAN COMMENT 'Indicates whether this safety program requires formal recordkeeping and documentation to demonstrate compliance (True) or not (False). Most OSHA-mandated programs require recordkeeping.',
    `review_frequency_months` STRING COMMENT 'The required interval in months between formal reviews of this safety program (e.g., 12 for annual review, 36 for triennial review). Driven by regulatory requirements or internal policy.',
    `source_system` STRING COMMENT 'The operational system from which this safety program record originated (Enviance EHS, SAP EHS, manual entry, or legacy system).. Valid values are `Enviance EHS|SAP EHS|Manual Entry|Legacy System`',
    `training_frequency_months` STRING COMMENT 'The required interval in months between mandatory training sessions for employees covered by this safety program (e.g., 12 for annual refresher training). Null if training is one-time or not required.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal employee training is required as part of this safety program (True) or not (False).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety program record was last modified in the system.',
    `version` STRING COMMENT 'Version number of the safety program document or policy, used to track revisions and updates over time (e.g., 1.0, 2.1, 3.0).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_safety_program PRIMARY KEY(`safety_program_id`)
) COMMENT 'Master record for each formal occupational health and safety program operated by Waste Management, including OSHA-mandated programs (Hazard Communication, Lockout/Tagout, Respiratory Protection, Hearing Conservation, Bloodborne Pathogens) and internal programs specific to waste collection, landfill, MRF, and hazmat operations. Captures program name, regulatory basis (OSHA standard citation), program owner, applicable operation types, effective date, review cycle, and current status.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`jha` (
    `jha_id` BIGINT COMMENT 'Unique identifier for the Job Hazard Analysis record. Primary key for the JHA master data.',
    `facility_id` BIGINT COMMENT 'Reference to the facility where this JHA applies. Links to the facility master data for site-specific safety planning.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this JHA document. Typically a safety director or operations manager.',
    `jha_created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created this JHA document. Typically a safety manager or supervisor.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Job Hazard Analyses for permitted operations (landfill gas extraction, leachate treatment, air emission control equipment) must reference the permit to ensure work procedures comply with permit-requir',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: JHAs must incorporate regulatory requirements (OSHA confined space, lockout/tagout, respiratory protection standards). This link ensures safety procedures meet regulatory standards and provides audit ',
    `safety_program_id` BIGINT COMMENT 'Reference to the parent safety program under which this JHA is managed (e.g., Fleet Safety Program, Landfill Safety Program).',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: JHAs are created for specific service offerings (residential rear-loader collection, commercial front-loader service, hazmat pickup). Safety teams develop offering-specific JHAs; operations teams refe',
    `vehicle_class_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_class. Business justification: Job hazard analyses specify vehicle types/classes for which hazards apply (rear loader vs side loader operations, compaction hazards, lift mechanism risks) for targeted safety controls.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: JHAs are waste-stream-specific because hazards differ dramatically (medical sharps vs. construction debris vs. chemical waste). Safety teams create stream-specific JHAs; EPA and OSHA require waste-spe',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Job hazard analyses are facility-specific for WTE operations, reflecting unique equipment configurations, permit requirements, and site-specific hazards. Required for OSHA compliance and operational s',
    `superseded_jha_id` BIGINT COMMENT 'Self-referencing FK on jha (superseded_jha_id)',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this JHA is currently active and in use. False indicates the JHA has been retired or superseded.',
    `administrative_controls` STRING COMMENT 'Administrative controls and work practices to reduce hazard exposure (e.g., job rotation, training requirements, work permits, buddy system, lockout/tagout procedures).',
    `approved_date` DATE COMMENT 'Date when this JHA was formally approved for use in operations.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether specific certifications are required to perform this job task (e.g., CDL, HAZMAT endorsement, equipment operator certification).',
    `created_date` DATE COMMENT 'Date when this JHA record was first created in the system.',
    `crew_size_required` STRING COMMENT 'Minimum number of workers required to safely perform this job task (e.g., 2 for confined space entry, 1 for standard route collection).',
    `document_url` STRING COMMENT 'URL or file path to the full JHA document stored in the document management system.',
    `effective_end_date` DATE COMMENT 'Date when this JHA expires or is scheduled for review. Null indicates no expiration date set.',
    `effective_start_date` DATE COMMENT 'Date when this JHA becomes active and must be followed for the specified job task.',
    `emergency_procedures` STRING COMMENT 'Emergency response procedures specific to hazards identified in this JHA (e.g., evacuation routes, spill response, first aid, emergency contacts).',
    `engineering_controls` STRING COMMENT 'Engineering controls implemented to eliminate or reduce hazards (e.g., machine guards, ventilation systems, automated equipment, safety interlocks, spill containment).',
    `environmental_conditions` STRING COMMENT 'Environmental factors that affect safety during this job task (e.g., extreme heat, cold, rain, wind, noise, dust, confined space, outdoor exposure).',
    `equipment_required` STRING COMMENT 'List of equipment and tools required to perform this job task safely (e.g., collection truck, compactor, forklift, gas monitor, fire extinguisher).',
    `estimated_duration_minutes` STRING COMMENT 'Estimated time in minutes to complete the job task under normal conditions.',
    `frequency_of_task` STRING COMMENT 'How often this job task is typically performed. Values: daily, weekly, monthly, quarterly, annual, as_needed.. Valid values are `daily|weekly|monthly|quarterly|annual|as_needed`',
    `hazard_category` STRING COMMENT 'Primary hazard categories identified in this JHA. Comma-separated list may include: physical, chemical, biological, ergonomic, environmental, struck_by, caught_in, fall, electrical, fire_explosion, confined_space, vehicle, machinery.',
    `incident_history_count` STRING COMMENT 'Number of safety incidents historically associated with this job task. Used for risk trending and prioritization.',
    `jha_number` STRING COMMENT 'Business identifier for the JHA document. Human-readable unique number used for tracking and reference in safety programs.. Valid values are `^JHA-[0-9]{6,10}$`',
    `jha_status` STRING COMMENT 'Current lifecycle status of the JHA document. Values: draft (initial creation), under_review (submitted for approval), approved (approved but not yet active), active (in use for operations), expired (past review date), archived (retired from use).. Valid values are `draft|under_review|approved|active|expired|archived`',
    `job_task_description` STRING COMMENT 'Detailed description of the job task including steps, equipment used, and work environment conditions.',
    `job_task_name` STRING COMMENT 'Name of the specific job task or work activity being analyzed for hazards (e.g., Residential Route Collection, Landfill Cell Compaction, MRF Sorting Line Operation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this JHA record was last modified in the system.',
    `last_review_date` DATE COMMENT 'Date when this JHA was last reviewed for accuracy and relevance. JHAs should be reviewed annually or after incidents.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this JHA. Typically annual or after significant process changes.',
    `operation_type` STRING COMMENT 'Type of waste management operation where the job task is performed. Values: collection (waste collection routes), landfill (landfill operations), mrf (Materials Recovery Facility), hazmat (hazardous waste handling), transfer_station (transfer station operations), wte (Waste-to-Energy facility).. Valid values are `collection|landfill|mrf|hazmat|transfer_station|wte`',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether incidents related to this job task are typically OSHA recordable under 29 CFR 1904.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a work permit is required before performing this job task (e.g., hot work permit, confined space entry permit, excavation permit).',
    `pre_task_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a pre-task safety inspection or checklist must be completed before starting this job task.',
    `required_ppe` STRING COMMENT 'List of required Personal Protective Equipment for the job task. May include: hard hat, safety glasses, gloves, steel-toe boots, high-visibility vest, respirator, hearing protection, fall protection harness, chemical suit.',
    `revision_notes` STRING COMMENT 'Notes describing changes made in the current revision of the JHA (e.g., updated PPE requirements, added new hazard controls).',
    `revision_number` STRING COMMENT 'Version number of this JHA document. Incremented each time the JHA is updated or revised.',
    `risk_level` STRING COMMENT 'Overall risk level assessment for the job task after hazard identification. Values: low (minimal risk), moderate (manageable risk with controls), high (significant risk requiring strict controls), critical (severe risk requiring immediate mitigation).. Valid values are `low|moderate|high|critical`',
    `training_requirements` STRING COMMENT 'Specific safety training required before performing this job task (e.g., HAZWOPER, CDL, forklift certification, confined space entry, fall protection).',
    CONSTRAINT pk_jha PRIMARY KEY(`jha_id`)
) COMMENT 'Job Hazard Analysis (JHA) master record defining the formal hazard identification and risk control documentation for a specific job task or work activity performed at Waste Management operations. Captures JHA number, job task description, operation type (collection, landfill, MRF, hazmat, transfer), associated safety program, hazard categories identified, required PPE, engineering controls, administrative controls, and approval status. Serves as the authoritative pre-task safety planning document for field operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`jha_step` (
    `jha_step_id` BIGINT COMMENT 'Unique identifier for the individual job step within a Job Hazard Analysis. Primary key for the JHA step record.',
    `jha_id` BIGINT COMMENT 'Reference to the parent Job Hazard Analysis document that contains this step. Links the step to the overall JHA assessment.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: JHA steps may require specific certifications (confined space, forklift, hazmat). Links step requirements to certification definitions, enabling verification that assigned employees hold required cert',
    `parent_jha_step_id` BIGINT COMMENT 'Self-referencing FK on jha_step (parent_jha_step_id)',
    `control_hierarchy` STRING COMMENT 'Classification of the control measure according to the OSHA hierarchy of controls. Elimination (remove hazard) is most effective; PPE (Personal Protective Equipment) is least effective but often necessary as last line of defense.. Valid values are `elimination|substitution|engineering_controls|administrative_controls|ppe`',
    `control_measure` STRING COMMENT 'Specific preventive action, safeguard, or control required to eliminate or reduce the hazard to an acceptable level. Describes the mitigation strategy (e.g., Wear high-visibility vest and maintain 10-foot clearance from moving equipment, Use chemical-resistant gloves rated for leachate contact).',
    `emergency_response_procedure` STRING COMMENT 'Immediate actions to be taken if an incident occurs during this job step. Describes emergency protocols (e.g., If struck by vehicle, call 911 immediately and secure scene, If chemical exposure, activate eyewash station and notify supervisor).',
    `environmental_condition` STRING COMMENT 'Relevant environmental or atmospheric conditions that affect hazard exposure during this step. Describes conditions such as temperature extremes, weather exposure, confined atmosphere, noise levels, or presence of hazardous gases (e.g., Outdoor work in temperatures exceeding 90°F, Potential methane atmosphere in landfill cell).',
    `equipment_required` STRING COMMENT 'Specialized equipment, tools, or machinery required to safely perform this job step. Lists all necessary equipment (e.g., Automated Side Loader (ASL) truck with functional safety interlocks, Gas detection monitor calibrated within 30 days, Fall arrest harness and lanyard).',
    `frequency_per_shift` STRING COMMENT 'Number of times this job step is typically performed during a single work shift. Used to calculate cumulative exposure and ergonomic risk factors.',
    `hazard_description` STRING COMMENT 'Detailed description of the specific hazard or risk present during this job step. Identifies what could cause injury or illness (e.g., Worker could be struck by moving vehicle in collection area, Exposure to leachate during container handling).',
    `hazard_type` STRING COMMENT 'Primary classification of the hazard associated with this job step. Categories align with OSHA hazard taxonomy for waste operations including struck-by hazards, caught-in/between hazards, fall hazards, exposure hazards, and ergonomic risks. [ENUM-REF-CANDIDATE: struck_by|caught_in|fall_same_level|fall_elevation|chemical_exposure|biological_exposure|ergonomic|electrical|thermal|noise|radiation|confined_space|vehicle_collision|equipment_failure|other — 15 candidates stripped; promote to reference product]',
    `incident_history_flag` BOOLEAN COMMENT 'Indicates whether past safety incidents or near-misses have been associated with this job step. True if historical incidents exist; False if no incident history. Used to prioritize high-risk steps for enhanced controls.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this job step hazard analysis. Ensures JHA remains current with operational changes, regulatory updates, and incident learnings. Typically reviewed annually or after incidents.',
    `notes` STRING COMMENT 'Additional comments, observations, or context relevant to this job step hazard analysis. Captures supplementary information such as site-specific considerations, seasonal variations, or lessons learned from incident investigations.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether this job step requires a work permit before execution. True if permit is required (e.g., hot work permit, confined space entry permit, excavation permit); False if no permit needed.',
    `permit_type` STRING COMMENT 'Type of work permit required for this job step, if applicable. Specifies the regulatory permit category needed before work can commence.. Valid values are `confined_space|hot_work|excavation|lockout_tagout|elevated_work|none`',
    `ppe_required` STRING COMMENT 'Specific Personal Protective Equipment required for this job step. Lists all PPE items necessary (e.g., Safety glasses, steel-toed boots, high-visibility vest, cut-resistant gloves, Respirator (half-face with organic vapor cartridge), chemical suit, nitrile gloves).',
    `probability_rating` STRING COMMENT 'Likelihood that the hazard will result in an incident during normal operations. Frequent = occurs often; Probable = will occur several times; Occasional = likely to occur sometime; Remote = unlikely but possible; Improbable = so unlikely it can be assumed will not occur.. Valid values are `frequent|probable|occasional|remote|improbable`',
    `regulatory_standard` STRING COMMENT 'Specific OSHA, EPA, DOT, or other regulatory standard that governs safety requirements for this job step. Provides regulatory traceability (e.g., OSHA 1910.178 - Powered Industrial Trucks, RCRA 40 CFR 264 - Hazardous Waste Management, DOT 49 CFR 383 - Commercial Driver Licensing).',
    `residual_risk_score` STRING COMMENT 'Calculated risk score after control measures are applied. Represents the remaining risk level after mitigation. Used to verify that controls reduce risk to acceptable levels per company risk tolerance thresholds.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the safety professional, supervisor, or subject matter expert who reviewed and validated this job step hazard analysis. Provides accountability for hazard assessment quality.',
    `reviewed_date` DATE COMMENT 'Date when this job step hazard analysis was last reviewed and validated. Used to track currency of hazard assessments and trigger periodic re-evaluation.',
    `risk_score` STRING COMMENT 'Calculated risk score derived from severity and probability ratings. Typically uses a risk matrix (e.g., 1-25 scale) to prioritize hazards requiring control measures. Higher scores indicate higher priority for mitigation.',
    `severity_rating` STRING COMMENT 'Assessment of the potential severity of injury or illness if the hazard results in an incident. Catastrophic = fatality or permanent total disability; Critical = permanent partial disability or temporary total disability; Moderate = medical treatment; Minor = first aid; Negligible = no injury.. Valid values are `catastrophic|critical|moderate|minor|negligible`',
    `step_description` STRING COMMENT 'Detailed narrative description of the specific work step or task action being performed. Describes what the worker does at this stage of the job (e.g., Approach container and position truck, Lift container using automated side loader).',
    `step_duration_minutes` STRING COMMENT 'Estimated time in minutes required to complete this job step under normal conditions. Used for exposure time calculations and work planning.',
    `step_sequence_number` STRING COMMENT 'Sequential order of this step within the job task breakdown. Defines the chronological position of the step in the work process (e.g., 1, 2, 3).',
    `step_status` STRING COMMENT 'Current lifecycle status of this JHA step record. Active = currently in use; Under Review = being evaluated for changes; Revised = updated version exists; Obsolete = no longer applicable.. Valid values are `active|under_review|revised|obsolete`',
    `training_required` STRING COMMENT 'Specific training or certification required for workers performing this job step. Identifies competency requirements (e.g., CDL Class B with air brake endorsement, RCRA hazardous waste handler training, Confined space entry certification).',
    `worker_count` STRING COMMENT 'Number of workers typically involved in performing this job step. Identifies crew size requirements and coordination needs (e.g., 1 for solo driver tasks, 2 for two-person lift operations, 3 for confined space entry with attendants).',
    CONSTRAINT pk_jha_step PRIMARY KEY(`jha_step_id`)
) COMMENT 'Individual job step line item within a Job Hazard Analysis (JHA), decomposing the work task into discrete sequential steps. For each step, captures the step sequence number, step description, associated hazards (struck-by, caught-in, fall, chemical exposure, ergonomic, etc.), hazard severity rating, probability rating, risk score, and the specific preventive measures and controls required. Enables granular hazard tracking at the task-step level for field operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`observation` (
    `observation_id` BIGINT COMMENT 'Unique identifier for the safety observation record. Primary key.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Equipment-specific safety observations during boiler operations (unsafe work practices, PPE compliance, lockout violations) tracked for targeted interventions and equipment-specific safety training ne',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Safety observations, particularly negative observations identifying unsafe behaviors or hazards, trigger corrective actions to address the identified issues. The safety_observation product currently h',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Safety observations of driver behavior (backing procedures, PPE use, safe driving) require direct driver link for coaching, performance reviews, and behavior-based safety program tracking.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management operational facility where the observation took place (landfill, MRF, transfer station, maintenance yard).',
    `incident_id` BIGINT COMMENT 'Identifier linking this observation to a formal safety incident record if the observation resulted in or is related to a reportable incident. Null if no incident occurred.',
    `lfg_collection_system_id` BIGINT COMMENT 'Foreign key linking to energy.lfg_collection_system. Business justification: LFG operations observations (gas monitoring compliance, confined space entry procedures, PPE use) tracked to systems for hazard-specific safety interventions and regulatory compliance verification.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager assigned responsibility for completing the corrective action. Null if no corrective action is required.',
    `observation_observed_employee_id` BIGINT COMMENT 'Identifier of the employee whose behavior or work activity was observed. Null if observation is crew-level or condition-based.',
    `observation_observer_employee_id` BIGINT COMMENT 'Identifier of the employee who conducted the safety observation (supervisor, safety manager, or peer observer).',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: Safety observations document behaviors of employees performing specific job positions. Enables "observations by position" analysis to identify high-risk positions requiring targeted training or engine',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Safety observations document unsafe practices during specific service delivery (improper container handling during residential pickup, unsafe compactor operation). Supervisors tag observations to offe',
    `org_unit_id` BIGINT COMMENT 'Identifier of the crew or team observed if the observation applies to a group rather than an individual employee.',
    `route_id` BIGINT COMMENT 'Identifier of the collection route if the observation occurred during route operations. Null for non-route observations.',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Safety observations during specific assignments link observation to route, shift, and driver-vehicle pairing context for targeted coaching and operational safety analysis.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle or mobile equipment involved in the observed activity. Null for stationary operations.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Behavioral safety observations at WTE facilities tracked for facility-level safety culture metrics, BBS program effectiveness, and proactive hazard identification. Standard practice in high-hazard fac',
    `follow_up_observation_id` BIGINT COMMENT 'Self-referencing FK on observation (follow_up_observation_id)',
    `bbs_program_flag` BOOLEAN COMMENT 'Indicates whether this observation is part of a formal Behavior-Based Safety (BBS) program initiative (True = BBS observation, False = general observation).',
    `behavior_description` STRING COMMENT 'Detailed narrative description of the specific behavior, condition, or activity observed during the safety observation event.',
    `closure_date` DATE COMMENT 'Date when the safety observation was formally closed after all corrective actions were completed and verified. Null if observation is not yet closed.',
    `closure_notes` STRING COMMENT 'Notes documenting the resolution and closure of the observation, including verification of corrective action completion. Null if observation is not yet closed.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for the required corrective action. Null if no corrective action is required.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether formal corrective action beyond immediate feedback is required (True = action needed, False = no action needed).',
    `corrective_feedback_provided` BOOLEAN COMMENT 'Indicates whether immediate corrective feedback or coaching was provided to the observed employee at the time of observation (True = feedback given, False = no feedback).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the safety observation record was first created in the system.',
    `feedback_description` STRING COMMENT 'Narrative description of the corrective feedback, coaching, or positive recognition provided to the observed employee during the observation.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the observation location, captured from mobile device or vehicle telematics. Null for stationary facility observations.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the observation location, captured from mobile device or vehicle telematics. Null for stationary facility observations.',
    `hazard_type` STRING COMMENT 'Classification of the hazard identified if the observation involves an unsafe condition or at-risk behavior (e.g., struck-by, caught-in, fall, exposure, ergonomic). [ENUM-REF-CANDIDATE: struck_by|caught_in|fall_from_elevation|slip_trip_fall|exposure_chemical|exposure_biological|exposure_physical|ergonomic|electrical|fire|confined_space — promote to reference product]',
    `location_description` STRING COMMENT 'Detailed description of the specific location within the facility or route where the observation took place (e.g., cell 5 north face, sort line station 3, residential route block 400).',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the safety observation record was last modified or updated.',
    `observation_category` STRING COMMENT 'Primary classification of the observation: safe behavior (positive), at-risk behavior, near-miss event, unsafe condition, positive recognition, or hazard identification.. Valid values are `safe_behavior|at_risk_behavior|near_miss|unsafe_condition|positive_recognition|hazard_identification`',
    `observation_date` DATE COMMENT 'Calendar date when the safety observation was conducted.',
    `observation_number` STRING COMMENT 'Business-facing unique identifier for the safety observation, formatted as OBS-YYYYMMDD-XXXXXX for external reference and tracking.. Valid values are `^OBS-[0-9]{8}-[A-Z0-9]{6}$`',
    `observation_status` STRING COMMENT 'Current lifecycle status of the safety observation record: open, pending review, action assigned, in progress, closed, or cancelled.. Valid values are `open|pending_review|action_assigned|in_progress|closed|cancelled`',
    `observation_time` TIMESTAMP COMMENT 'Precise timestamp when the safety observation event occurred, including time zone information.',
    `observation_type` STRING COMMENT 'Secondary classification indicating the nature of the observation: behavioral, environmental condition, equipment-related, procedural compliance, PPE compliance, or ergonomic.. Valid values are `behavioral|environmental|equipment|procedural|ppe_compliance|ergonomic`',
    `observer_name` STRING COMMENT 'Full name of the employee who conducted the safety observation.',
    `observer_role` STRING COMMENT 'Role or position of the person conducting the observation within the organization.. Valid values are `supervisor|safety_manager|peer_observer|operations_manager|site_manager|ehs_specialist`',
    `operation_type` STRING COMMENT 'Type of operational activity being performed at the time of observation (collection route, landfill cell operations, MRF sort line, hazmat handling, etc.). [ENUM-REF-CANDIDATE: collection_route|landfill_cell|mrf_sort_line|hazmat_handling|transfer_station|maintenance_shop|vehicle_operation|equipment_operation — 8 candidates stripped; promote to reference product]',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the observation is associated with an OSHA recordable incident or near-miss that requires formal documentation (True = recordable, False = not recordable).',
    `photo_attachment_count` STRING COMMENT 'Number of photos or images attached to the observation record for documentation purposes. Zero if no photos were captured.',
    `ppe_compliance_flag` BOOLEAN COMMENT 'Indicates whether the observed employee was in full compliance with required PPE for the task being performed (True = compliant, False = non-compliant).',
    `ppe_deficiency_description` STRING COMMENT 'Description of any PPE deficiencies observed (missing equipment, improper use, damaged equipment). Null if PPE compliance flag is True.',
    `severity_level` STRING COMMENT 'Assessed severity or risk level of the observed unsafe behavior or condition: low, medium, high, or critical based on potential for injury or incident.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'System or application from which the safety observation record originated (Enviance EHS, mobile safety app, Workday HCM, manual entry).. Valid values are `enviance_ehs|mobile_safety_app|workday_hcm|manual_entry`',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of observation if relevant to the safety observation (e.g., rain, ice, extreme heat, high wind). Null if not applicable.',
    CONSTRAINT pk_observation PRIMARY KEY(`observation_id`)
) COMMENT 'Transactional record of a field safety observation event conducted by a supervisor, safety manager, or peer observer at a Waste Management operational site. Captures observation date and time, observer identity, observed employee or crew, operation type (collection route, landfill cell, MRF sort line, hazmat handling), observation category (safe behavior, at-risk behavior, near-miss, unsafe condition), specific behavior or condition observed, corrective feedback provided, and closure status. Supports behavior-based safety (BBS) programs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the safety and health incident record. Primary key for the incident entity.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Boiler-related incidents (burns, steam releases, equipment failures) require equipment-specific tracking for root cause analysis, maintenance correlation, and OSHA compliance. Critical for WTE operati',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Some safety incidents trigger or result from regulatory compliance inspections. This link enables tracking of inspection-related incidents and ensures proper follow-up on regulatory findings through t',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Incidents during hazmat disposal operations (transport, TSDF delivery, manifest handling) must link to disposal PO for RCRA incident reporting, workers comp cost allocation to disposal contracts, ven',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Incidents involving drivers (vehicle accidents, injuries during collection) require direct driver link for investigation, workers compensation claims, DOT compliance reporting, and driver safety perfo',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the incident occurred (landfill, MRF, transfer station, maintenance yard, or administrative office).',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the equipment or machinery involved in the incident (e.g., compactor, baler, loader, conveyor).',
    `employee_id` BIGINT COMMENT 'Reference to the employee who was injured or involved in the incident.',
    `incident_investigator_employee_id` BIGINT COMMENT 'Reference to the safety professional or manager who led the incident investigation.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Incidents are categorized by waste stream involved (chemical exposure from industrial waste, sharps injury from medical waste). EPA and OSHA require waste-stream-specific incident reporting; risk team',
    `lfg_collection_system_id` BIGINT COMMENT 'Foreign key linking to energy.lfg_collection_system. Business justification: LFG system incidents (methane exposure, H2S exposure, equipment failures) require system-specific tracking for hazard mitigation, regulatory compliance (NSPS), and worker protection in landfill gas op',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Incidents at permitted facilities must track which permit was in effect for regulatory reporting (RCRA, air quality violations, stormwater). Required for incident investigation reports submitted to re',
    `rng_processing_unit_id` BIGINT COMMENT 'Foreign key linking to energy.rng_processing_unit. Business justification: RNG unit incidents (gas leaks, pressure vessel failures, chemical exposure) tracked to specific processing units for process safety management, EPA RMP compliance, and equipment-specific hazard contro',
    `route_id` BIGINT COMMENT 'Reference to the collection route where the incident occurred, if applicable to field collection operations.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Incidents are tagged to the service being performed at time of incident (injury during compactor service, exposure during hazmat collection). Risk managers analyze incident rates by offering to identi',
    `srf_production_line_id` BIGINT COMMENT 'Foreign key linking to energy.srf_production_line. Business justification: SRF line incidents (material handling injuries, equipment entanglement, dust exposure) require line-specific tracking for production safety analysis, equipment guarding improvements, and worker protec',
    `turbine_generator_id` BIGINT COMMENT 'Foreign key linking to energy.turbine_generator. Business justification: Turbine incidents (electrical hazards, rotating equipment injuries) tracked to specific units for safety-maintenance correlation, equipment reliability analysis, and targeted corrective actions. Stand',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Incidents during specific vehicle assignments require link to assignment context for investigation (route conditions, shift timing, driver-vehicle pairing analysis) and operational risk assessment.',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle involved in the incident, if applicable (collection truck, roll-off truck, support vehicle).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Contractor and vendor-caused incidents must link to vendor master for safety performance evaluation, vendor scorecard updates, insurance claims processing, contract compliance verification, and future',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Incidents at WTE facilities require facility-specific tracking for OSHA recordkeeping, EPA reporting, and facility-level safety performance metrics. Domain experts expect incident-to-facility linkage ',
    `related_incident_id` BIGINT COMMENT 'Self-referencing FK on incident (related_incident_id)',
    `body_part_affected` STRING COMMENT 'Primary body part or region affected by the injury or illness. [ENUM-REF-CANDIDATE: head|neck|back|shoulder|arm|hand|finger|chest|abdomen|leg|knee|ankle|foot|toe|multiple — promote to reference product]',
    `classification` STRING COMMENT 'Primary classification category of the incident for safety management and regulatory reporting purposes.. Valid values are `injury|illness|near_miss|property_damage|vehicle_accident|environmental_release`',
    `corrective_actions_description` STRING COMMENT 'Summary of corrective and preventive actions identified and implemented following the incident investigation.',
    `corrective_actions_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions were identified as necessary to prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the safety management system.',
    `days_away_from_work` STRING COMMENT 'Total number of calendar days the employee was unable to work as a result of the incident.',
    `days_of_restricted_work` STRING COMMENT 'Total number of calendar days the employee was on restricted work duty or job transfer due to the incident.',
    `employee_job_title` STRING COMMENT 'Job title or position of the employee at the time of the incident (e.g., CDL Driver, Equipment Operator, Sorter, Mechanic).',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated total cost impact of the incident including medical expenses, lost time, equipment damage, and administrative costs in USD.',
    `illness_type` STRING COMMENT 'Category of occupational illness if the incident is classified as an illness rather than injury.. Valid values are `respiratory|skin_disorder|poisoning|hearing_loss|other_illness`',
    `incident_date` DATE COMMENT 'Calendar date on which the occupational safety or health incident occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of how the incident occurred, including sequence of events, contributing factors, and immediate circumstances.',
    `incident_number` STRING COMMENT 'Business-facing unique incident tracking number assigned at time of incident report. Format: INC-YYYYMMDD sequence.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident record in the safety management system.. Valid values are `open|under_investigation|pending_review|closed`',
    `incident_time` TIMESTAMP COMMENT 'Precise timestamp when the incident occurred, including time zone information.',
    `injury_type` STRING COMMENT 'Specific type or nature of injury sustained (e.g., laceration, fracture, strain, contusion, burn, puncture). [ENUM-REF-CANDIDATE: laceration|fracture|strain|sprain|contusion|burn|puncture|amputation|crushing|abrasion — promote to reference product]',
    `investigation_completed_date` DATE COMMENT 'Date when the formal incident investigation was completed and findings documented.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation process.. Valid values are `not_started|in_progress|completed|closed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was last updated or modified.',
    `location_description` STRING COMMENT 'Detailed narrative description of the specific location where the incident occurred (e.g., loading dock, cell 4 north face, customer driveway at 123 Main St).',
    `operation_type` STRING COMMENT 'Type of waste management operation being performed at the time of the incident. [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|roll_off_service|landfill_operations|mrf_operations|transfer_station|maintenance_shop|hazmat_handling|administrative|other — 10 candidates stripped; promote to reference product]',
    `osha_recordability_determination_date` DATE COMMENT 'Date when the formal determination of OSHA recordability was made by qualified safety personnel.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordability on Form 300 Log of Work-Related Injuries and Illnesses.',
    `ppe_adequate_flag` BOOLEAN COMMENT 'Indicates whether the PPE in use was adequate and appropriate for the task being performed.',
    `ppe_in_use` STRING COMMENT 'Description of personal protective equipment the employee was wearing or using at the time of the incident.',
    `regulatory_notification_date` DATE COMMENT 'Date when OSHA or other regulatory authority was notified of the incident, if required.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the incident severity requires notification to OSHA or other regulatory authorities.',
    `reported_date` DATE COMMENT 'Date when the incident was formally reported to management or safety personnel.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the incident was formally reported into the safety management system.',
    `root_cause_description` STRING COMMENT 'Analysis and description of the underlying root cause(s) identified through incident investigation.',
    `severity_level` STRING COMMENT 'Classification of incident severity based on outcome and impact to the injured party.. Valid values are `fatality|lost_time|restricted_work|medical_treatment|first_aid|near_miss`',
    `witness_count` STRING COMMENT 'Number of witnesses to the incident who provided statements during the investigation.',
    `workers_comp_claim_number` STRING COMMENT 'Workers compensation insurance claim number associated with this incident, if a claim was filed.. Valid values are `^WC-[A-Z0-9]{10,15}$`',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Core transactional record for every occupational safety and health incident at Waste Management operations, including OSHA recordable injuries, first-aid cases, near-misses, property damage events, and environmental releases. Captures incident number, incident date and time, facility or route location, operation type, incident classification (injury, illness, near-miss, property damage, vehicle accident), OSHA recordability determination, body part affected, nature of injury, initial description, and reporting status. The authoritative SSOT for all safety incident events.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`incident_investigation` (
    `incident_investigation_id` BIGINT COMMENT 'Unique identifier for the incident investigation record. Primary key.',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Incident investigations involving drivers require direct driver link for root cause analysis, human factors assessment, training gap identification, and driver performance evaluation.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the primary investigator responsible for leading the investigation and coordinating the team.',
    `facility_id` BIGINT COMMENT 'Identifier for the facility where the incident occurred and investigation was conducted. Links to landfill, Materials Recovery Facility (MRF), transfer station, or other operational site.',
    `incident_id` BIGINT COMMENT 'Reference to the safety incident that triggered this investigation. Links to the parent incident record.',
    `document_id` BIGINT COMMENT 'Reference identifier for the formal investigation report document stored in the document management system.',
    `supplemental_incident_investigation_id` BIGINT COMMENT 'Self-referencing FK on incident_investigation (supplemental_incident_investigation_id)',
    `contributing_factors` STRING COMMENT 'Additional factors that contributed to the incident but were not the primary root cause. May include secondary conditions, behaviors, or circumstances.',
    `corrective_action_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of assigned corrective actions that have been completed and verified. Calculated as (completed actions / total actions) * 100.',
    `corrective_actions_assigned` STRING COMMENT 'Summary of corrective and preventive actions assigned as a result of the investigation findings. Details specific actions, responsible parties, and target completion dates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was first created in the system.',
    `environmental_factors_identified` STRING COMMENT 'Environmental conditions that contributed to the incident such as weather, lighting, noise, temperature, or site layout issues.',
    `equipment_factors_identified` STRING COMMENT 'Equipment-related factors such as mechanical failure, design deficiency, maintenance issues, or lack of proper guarding that contributed to the incident.',
    `equipment_inspection_conducted_flag` BOOLEAN COMMENT 'Indicates whether involved equipment was inspected as part of the investigation to identify mechanical or design deficiencies.',
    `human_factors_identified` STRING COMMENT 'Specific human factors contributing to the incident such as fatigue, distraction, inadequate training, communication breakdown, or procedural non-compliance.',
    `immediate_causes` STRING COMMENT 'Direct, proximate causes that immediately preceded the incident. Typically unsafe acts or unsafe conditions that triggered the event.',
    `investigation_closure_date` DATE COMMENT 'Date when all corrective actions were verified as implemented and the investigation was formally closed.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation findings, root cause analysis, and corrective actions were finalized and documented.',
    `investigation_duration_days` STRING COMMENT 'Number of calendar days from investigation start to completion. Used to track investigation cycle time and efficiency.',
    `investigation_findings_summary` STRING COMMENT 'Executive summary of the investigation findings, conclusions, and key takeaways. Used for management reporting and lessons learned.',
    `investigation_method` STRING COMMENT 'Specific investigation methodology or framework used such as 5 Whys, Fishbone Diagram, Fault Tree Analysis, or Bow Tie Analysis.',
    `investigation_number` STRING COMMENT 'Externally-known unique investigation tracking number assigned to this formal investigation. Format: INV-YYYY-NNNNNN.. Valid values are `^INV-[0-9]{4}-[0-9]{6}$`',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the investigation based on incident severity, potential for recurrence, and regulatory implications.. Valid values are `critical|high|medium|low`',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation was initiated. Typically within 24-48 hours of the incident occurrence per OSHA guidelines.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation process. Tracks progression from initiation through closure.. Valid values are `initiated|in_progress|pending_review|completed|closed`',
    `investigation_team_members` STRING COMMENT 'Comma-separated list of employee names or IDs who participated in the investigation team. Includes subject matter experts, witnesses, and support personnel.',
    `investigation_type` STRING COMMENT 'Classification of the investigation depth and methodology. Root Cause Analysis (RCA) is the most comprehensive structured investigation.. Valid values are `root_cause_analysis|preliminary|comprehensive|follow_up`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was last updated or modified.',
    `lead_investigator_name` STRING COMMENT 'Full name of the lead investigator assigned to this investigation.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the investigation that should be communicated across the organization to prevent similar incidents.',
    `management_system_gaps` STRING COMMENT 'Identified deficiencies in management systems, policies, procedures, or oversight that allowed the incident to occur.',
    `operation_type` STRING COMMENT 'Type of waste management operation where the incident occurred. Aligns with core business process areas.. Valid values are `waste_collection|landfill|mrf|hazmat|fleet_maintenance|transfer_station`',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordability on the OSHA 300 Log. True if recordable, False if not.',
    `photographic_evidence_collected_flag` BOOLEAN COMMENT 'Indicates whether photographs or video evidence of the incident scene were collected and documented.',
    `preventive_measures_recommended` STRING COMMENT 'Recommended preventive measures to eliminate or control the identified hazards and prevent recurrence of similar incidents.',
    `regulatory_notification_date` DATE COMMENT 'Date when the incident was reported to OSHA or other regulatory authorities, if required.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the incident severity requires notification to OSHA or other regulatory authorities within mandated timeframes.',
    `reviewed_by_operations_manager_flag` BOOLEAN COMMENT 'Indicates whether the investigation findings and corrective actions were reviewed and approved by the operations manager.',
    `reviewed_by_safety_manager_flag` BOOLEAN COMMENT 'Indicates whether the investigation findings and corrective actions were reviewed and approved by the safety manager.',
    `root_cause_category` STRING COMMENT 'Primary classification of the underlying root cause identified through the investigation. Aligns with standard RCA taxonomy.. Valid values are `human_factors|equipment_failure|environmental_conditions|management_system_failure|procedural_gap|training_deficiency`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the identified root cause(s) that led to the incident. Documents the fundamental systemic or process failure.',
    `site_inspection_conducted_flag` BOOLEAN COMMENT 'Indicates whether a physical site inspection was conducted to assess environmental and situational factors.',
    `witness_statements_collected_flag` BOOLEAN COMMENT 'Indicates whether witness statements were collected as part of the investigation process.',
    CONSTRAINT pk_incident_investigation PRIMARY KEY(`incident_investigation_id`)
) COMMENT 'Formal incident investigation record linked to a safety incident, capturing the structured root cause analysis (RCA) and corrective action findings. Captures investigation number, lead investigator, investigation team members, investigation start and completion dates, root cause categories (human factors, equipment failure, environmental conditions, management system failure), contributing factors, immediate causes, root causes identified, corrective actions assigned, and investigation closure status. Supports OSHA 300 log recordkeeping and internal safety management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record. Primary key for the corrective action entity.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Corrective actions may require service offering modifications (adding PPE requirements, changing collection procedures, restricting service hours). Safety and operations teams coordinate on offering-l',
    `facility_id` BIGINT COMMENT 'Foreign key reference to the facility where the corrective action is to be implemented. Links to landfill, MRF, transfer station, or other operational facility.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Corrective actions from safety incidents at permitted facilities must reference the permit for regulatory closure documentation. Agencies require proof that corrective actions address permit condition',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or contractor assigned as the owner responsible for implementing and completing this corrective action.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Corrective actions requiring capital expenditure (equipment upgrades, PPE purchases, engineering controls) must link to purchase orders for cost tracking, budget justification, audit trail, and verifi',
    `quaternary_corrective_last_modified_by_employee_id` BIGINT COMMENT 'Foreign key reference to the employee who last modified the corrective action record. Provides audit trail for changes to action status, completion, or verification.',
    `quinary_corrective_responsible_party_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Safety corrective actions often stem from specific regulatory requirements (OSHA standards, EPA rules, DOT regulations). This link is essential for compliance audits, demonstrating regulatory adherenc',
    `tertiary_corrective_created_by_employee_id` BIGINT COMMENT 'Foreign key reference to the employee who created the corrective action record. Typically a safety manager, supervisor, or incident investigator.',
    `originating_corrective_action_id` BIGINT COMMENT 'Self-referencing FK on corrective_action (originating_corrective_action_id)',
    `action_category` STRING COMMENT 'Classification of the corrective action based on the hierarchy of controls. Categories include engineering control (physical changes to eliminate hazard), administrative control (policy/procedure changes), PPE (personal protective equipment), training, procedure update, or equipment repair.. Valid values are `engineering_control|administrative_control|ppe|training|procedure_update|equipment_repair`',
    `action_description` STRING COMMENT 'Detailed description of the corrective or preventive action to be taken. Includes specific steps, controls to be implemented, and expected outcomes to prevent recurrence of the safety issue.',
    `action_number` STRING COMMENT 'Business-facing unique identifier for the corrective action, typically formatted as CA-NNNNNN. Used for tracking and reference in safety meetings and audits.. Valid values are `^CA-[0-9]{6,10}$`',
    `action_priority` STRING COMMENT 'Priority level assigned to the corrective action based on risk severity and potential for recurrence. Critical actions address imminent hazards, high priority addresses serious risks, medium for moderate risks, and low for minor improvements.. Valid values are `critical|high|medium|low`',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action was completed and verified. Null if action is still in progress or not yet started.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost in US dollars incurred to implement the corrective action. Captured upon completion for budget tracking and cost-benefit analysis.',
    `closure_date` DATE COMMENT 'Date when the corrective action was formally closed after verification of effectiveness. Represents final administrative closure of the action.',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action. Open indicates newly assigned, in progress indicates work has started, completed indicates action finished but not yet verified, verified indicates effectiveness confirmed, closed indicates final closure, overdue indicates past target date, cancelled indicates action no longer required. [ENUM-REF-CANDIDATE: open|in_progress|completed|verified|closed|overdue|cancelled — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first created in the system. Represents when the action was formally assigned and entered into the safety management system.',
    `effectiveness_rating` STRING COMMENT 'Assessment of how effective the corrective action was in preventing recurrence and improving safety. Populated during effectiveness review after sufficient time has elapsed post-implementation.. Valid values are `highly_effective|effective|partially_effective|ineffective|not_yet_assessed`',
    `effectiveness_review_date` DATE COMMENT 'Scheduled date for follow-up review to assess long-term effectiveness of the corrective action. Typically 30, 60, or 90 days after closure to ensure sustained improvement.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost in US dollars to implement the corrective action. Includes labor, materials, equipment, and training costs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the corrective action record. Tracks when status changes, completion updates, or verification activities were recorded.',
    `preventive_action_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this action is preventive (true) or corrective (false). Preventive actions address potential hazards before incidents occur, corrective actions address issues after an event.',
    `recurrence_prevention_measures` STRING COMMENT 'Detailed description of measures implemented to prevent recurrence of the safety issue across similar operations, facilities, or equipment. Captures systemic improvements beyond the immediate corrective action.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this corrective action is required by OSHA, EPA, DOT, or other regulatory authority. True indicates regulatory mandate, false indicates voluntary safety improvement.',
    `responsible_department` STRING COMMENT 'Department or business unit responsible for implementing the corrective action (e.g., Fleet Maintenance, Landfill Operations, MRF Operations, Hazmat Handling, Safety Department).',
    `root_cause_analysis_completed` BOOLEAN COMMENT 'Boolean flag indicating whether a formal root cause analysis was conducted for the source event prior to defining this corrective action. True indicates RCA was performed, false indicates action was defined without formal RCA.',
    `root_cause_category` STRING COMMENT 'High-level category of the root cause identified through investigation. Used to identify systemic patterns and prioritize preventive actions across the safety program.. Valid values are `equipment_failure|human_error|procedure_inadequate|training_gap|environmental_factor|management_system`',
    `source_event_reference` STRING COMMENT 'Business reference number of the originating event (e.g., incident number, observation ID, audit finding number). Provides human-readable traceability to the source event.',
    `source_event_type` STRING COMMENT 'Type of safety event that triggered this corrective action. Distinguishes whether the action originated from an incident investigation, safety observation, audit finding, regulatory inspection, near miss, or hazard report.. Valid values are `incident|observation|audit|inspection|near_miss|hazard_report`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action must be completed. Established based on risk priority and resource availability.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as effective. Typically occurs after actual completion date once effectiveness has been confirmed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was implemented effectively and achieved the intended outcome. Options include physical inspection, safety audit, field observation, documentation review, equipment testing, or training completion verification.. Valid values are `inspection|audit|observation|documentation_review|testing|training_completion`',
    `verification_notes` STRING COMMENT 'Detailed notes documenting the verification process, findings, and confirmation that the corrective action achieved the intended safety improvement.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and preventive action (CAPA) record generated from incident investigations, safety observations, safety audits, or regulatory inspections within the safety domain. Captures action number, source event type and reference, action description, action category (engineering control, administrative control, PPE, training, procedure update), assigned responsible party, target completion date, actual completion date, verification method, and closure status. Distinct from compliance.corrective_action which is driven by regulatory violations — this entity is safety-program-driven.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`osha_recordable` (
    `osha_recordable_id` BIGINT COMMENT 'Unique identifier for the OSHA 300 Log recordable case record.',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: OSHA recordable cases involving drivers require direct driver link for OSHA 300 log reporting, case classification, days away/restricted work tracking, and driver safety performance analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who sustained the work-related injury or illness.',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the injury or illness occurred.',
    `incident_id` BIGINT COMMENT 'Reference to the underlying safety incident that triggered this OSHA recordable case.',
    `recurrence_osha_recordable_id` BIGINT COMMENT 'Self-referencing FK on osha_recordable (recurrence_osha_recordable_id)',
    `body_part_affected` STRING COMMENT 'The specific body part or system affected by the injury or illness (e.g., hand, back, eyes, respiratory system).',
    `case_closure_date` DATE COMMENT 'The date when the OSHA recordable case was officially closed after all required documentation and follow-up actions were completed.',
    `case_status` STRING COMMENT 'Current lifecycle status of the OSHA recordable case in the investigation and documentation workflow.. Valid values are `open|closed|under_review|pending_classification`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OSHA recordable case record was first created in the system.',
    `days_away_from_work` STRING COMMENT 'Total number of calendar days the employee was unable to work as a result of the injury or illness, excluding the day of injury or onset.',
    `days_of_job_transfer_or_restriction` STRING COMMENT 'Total number of calendar days the employee was on restricted work activity or temporary job transfer due to the injury or illness.',
    `death_flag` BOOLEAN COMMENT 'Indicates whether the injury or illness resulted in the death of the employee.',
    `establishment_name` STRING COMMENT 'The name of the establishment (facility or site) where the injury or illness occurred, as it appears on OSHA reporting.',
    `event_exposure_type` STRING COMMENT 'The event or exposure that directly produced the injury or illness (e.g., struck by object, fall from elevation, overexertion, contact with chemical, repetitive motion).',
    `injury_illness_date` DATE COMMENT 'The date the work-related injury occurred or the date the occupational illness was diagnosed or first manifested.',
    `injury_illness_description` STRING COMMENT 'Detailed narrative description of the injury or illness, including the part of body affected and the nature of the injury or illness (e.g., laceration to left hand, chemical burn to forearm, lower back strain).',
    `injury_illness_time` TIMESTAMP COMMENT 'The time of day when the injury occurred or illness symptoms first appeared, in 24-hour HH:MM format.',
    `injury_nature` STRING COMMENT 'The type or nature of the injury sustained (e.g., laceration, fracture, sprain, burn, contusion, puncture).',
    `job_title` STRING COMMENT 'The job title or occupation of the employee at the time of the injury or illness (e.g., Waste Collection Driver, Landfill Equipment Operator, MRF Sorter).',
    `location_where_event_occurred` STRING COMMENT 'Specific location or area within the facility where the injury or illness event took place (e.g., loading dock, landfill cell 5, MRF sorting line 2, vehicle cab).',
    `loss_of_consciousness_flag` BOOLEAN COMMENT 'Indicates whether the employee lost consciousness as a result of the work-related injury or illness.',
    `medical_treatment_beyond_first_aid_flag` BOOLEAN COMMENT 'Indicates whether the injury or illness required medical treatment beyond first aid as defined in 29 CFR 1904.7(b)(5).',
    `notes` STRING COMMENT 'Additional notes, comments, or supplementary information related to the OSHA recordable case for internal tracking and compliance purposes.',
    `osha_300a_reporting_year` STRING COMMENT 'The calendar year for which this case will be included in the annual OSHA 300A summary report.',
    `osha_case_number` STRING COMMENT 'The official OSHA 300 Log case number assigned to this recordable injury or illness, typically formatted as year-sequence (e.g., 2024-0001).. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `osha_case_type` STRING COMMENT 'Classification of the recordable case into one of the six OSHA 300 Log categories as defined in 29 CFR 1904.12.. Valid values are `injury|skin_disorder|respiratory_condition|poisoning|hearing_loss|all_other_illnesses`',
    `physician_recommendation_flag` BOOLEAN COMMENT 'Indicates whether a physician or licensed health care professional recommended days away from work or work restriction/transfer.',
    `ppe_used` STRING COMMENT 'Description of the personal protective equipment the employee was wearing or using at the time of the incident.',
    `privacy_case_flag` BOOLEAN COMMENT 'Indicates whether this case qualifies as a privacy concern case under 29 CFR 1904.29(b)(6)-(b)(10), requiring the employee name to be withheld from the OSHA 300 Log.',
    `recordable_determination_by` STRING COMMENT 'Name or identifier of the safety professional who made the recordability determination.',
    `recordable_determination_date` DATE COMMENT 'The date when the safety team determined that the incident met OSHA recordability criteria under 29 CFR 1904.7.',
    `remained_at_work_flag` BOOLEAN COMMENT 'Indicates whether the employee remained at work and continued their normal duties without any days away or job transfer/restriction.',
    `source_of_injury` STRING COMMENT 'The object, substance, or equipment that directly produced or inflicted the injury or illness (e.g., waste container, truck tailgate, chemical substance, machinery).',
    `treating_physician_name` STRING COMMENT 'Name of the physician or licensed health care professional who provided treatment for the injury or illness.',
    `treatment_facility_name` STRING COMMENT 'Name of the medical facility, clinic, or hospital where the employee received treatment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this OSHA recordable case record was last modified or updated.',
    `work_process_at_time_of_incident` STRING COMMENT 'The work activity or process the employee was performing when the injury or illness occurred (e.g., residential route collection, landfill compaction, MRF sorting, vehicle maintenance).',
    CONSTRAINT pk_osha_recordable PRIMARY KEY(`osha_recordable_id`)
) COMMENT 'OSHA 300 Log recordable case record for each work-related injury or illness that meets OSHA recordability criteria under 29 CFR Part 1904. Captures OSHA case number, linked incident reference, employee job title, date of injury or illness onset, where the event occurred, description of injury or illness, days away from work, days of restricted work or job transfer, OSHA case type (injury, skin disorder, respiratory condition, poisoning, hearing loss, all other illnesses), and privacy case flag. Serves as the authoritative OSHA 300 log data source for annual OSHA 300A summary reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`ppe_issuance` (
    `ppe_issuance_id` BIGINT COMMENT 'Unique identifier for the PPE issuance transaction record.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility, storeroom, or distribution center from which the PPE was issued.',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: PPE is issued based on job position requirements defined in position master. Links issuance to position enables "ensure all employees in position X have required PPE" compliance audits per OSHA PPE st',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: PPE issuances must link to material master for cost allocation, inventory management, certification standard verification (ANSI, OSHA), manufacturer traceability, and procurement replenishment trigger',
    `employee_id` BIGINT COMMENT 'Identifier of the Waste Management employee receiving the PPE items.',
    `replaced_ppe_issuance_id` BIGINT COMMENT 'Reference to the prior PPE issuance record if this issuance is a replacement for worn, damaged, or lost equipment.',
    `replacement_ppe_issuance_id` BIGINT COMMENT 'Self-referencing FK on ppe_issuance (replacement_ppe_issuance_id)',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the employee signed acknowledgment of PPE receipt.',
    `certification_standard` STRING COMMENT 'Industry or regulatory certification standard met by the PPE item (e.g., ANSI Z87.1 for eye protection, ANSI Z89.1 for hard hats, NIOSH for respirators).',
    `condition` STRING COMMENT 'Physical condition of the PPE item at time of issuance.. Valid values are `new|refurbished|reconditioned`',
    `cost_center` STRING COMMENT 'Financial cost center to which the PPE issuance cost is allocated.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the PPE issuance record was first created in the database.',
    `employee_acknowledgment_signature` STRING COMMENT 'Digital or scanned signature of the employee acknowledging receipt of the PPE items.',
    `expected_replacement_date` DATE COMMENT 'Anticipated date when the PPE item will need to be replaced based on manufacturer specifications and usage patterns.',
    `fit_test_date` DATE COMMENT 'Date of most recent fit test for respiratory protection equipment, if applicable.',
    `fit_test_result` STRING COMMENT 'Result of the fit test for respiratory protection equipment.. Valid values are `pass|fail|not_applicable`',
    `general_ledger_account` STRING COMMENT 'General ledger account code for PPE expense recognition.. Valid values are `^[0-9]{6,10}$`',
    `inspection_frequency_days` STRING COMMENT 'Number of days between required inspections for the PPE item.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the PPE item requires periodic inspection per manufacturer or regulatory requirements.',
    `issuance_date` DATE COMMENT 'Date when the PPE items were physically issued to the employee.',
    `issuance_number` STRING COMMENT 'Business-readable unique identifier for the PPE issuance transaction, formatted as PPE-YYYYMMDD-NNNN.. Valid values are `^PPE-[0-9]{8}-[0-9]{4}$`',
    `issuance_reason` STRING COMMENT 'Business reason for issuing the PPE to the employee. [ENUM-REF-CANDIDATE: new_hire|replacement_worn|replacement_damaged|replacement_lost|seasonal|special_project|regulatory_requirement — 7 candidates stripped; promote to reference product]',
    `issuance_timestamp` TIMESTAMP COMMENT 'Precise date and time when the PPE issuance transaction was recorded in the system.',
    `issuing_location_name` STRING COMMENT 'Name of the facility, storeroom, or distribution center from which the PPE was issued.',
    `job_role` STRING COMMENT 'Job role or position of the receiving employee at time of issuance (e.g., CDL Driver, MRF Sorter, Landfill Operator, Hazmat Technician).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the PPE issuance record was last updated.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer of the PPE item.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the PPE issuance transaction, special circumstances, or employee requests.',
    `ppe_category` STRING COMMENT 'Classification of the PPE item by body protection area per OSHA standards. [ENUM-REF-CANDIDATE: head_protection|eye_face_protection|hearing_protection|respiratory_protection|hand_protection|foot_protection|body_protection|fall_protection|high_visibility_clothing — 9 candidates stripped; promote to reference product]',
    `quantity_issued` STRING COMMENT 'Number of units of the PPE item issued in this transaction.',
    `return_condition` STRING COMMENT 'Condition of the PPE item when returned by the employee.. Valid values are `good|worn|damaged|lost|destroyed`',
    `return_date` DATE COMMENT 'Date when the PPE item was returned by the employee, if applicable.',
    `return_required_flag` BOOLEAN COMMENT 'Indicates whether the employee is required to return the PPE item upon separation or replacement.',
    `serial_number` STRING COMMENT 'Manufacturer serial number or lot number of the PPE item, used for traceability and recall management.',
    `size` STRING COMMENT 'Size specification of the PPE item issued (e.g., S, M, L, XL, 2XL, numeric sizes for gloves/boots).',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the PPE issuance transaction (quantity issued multiplied by unit cost) in USD.',
    `training_completion_date` DATE COMMENT 'Date when the employee completed required PPE usage training for the issued equipment type.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the PPE item at time of issuance in USD.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity issued (e.g., each for hard hats, pair for gloves).. Valid values are `each|pair|set|box|case`',
    `work_location_type` STRING COMMENT 'Type of work location where the employee will use the issued PPE. [ENUM-REF-CANDIDATE: collection_route|landfill|mrf|transfer_station|hazmat_facility|maintenance_shop|office — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_ppe_issuance PRIMARY KEY(`ppe_issuance_id`)
) COMMENT 'Transactional record of PPE items issued to individual Waste Management employees, capturing the physical distribution of personal protective equipment. Records issuance date, employee reference, PPE item type and description, size, quantity issued, condition (new, refurbished), issuing facility or storeroom, and employee acknowledgment signature. Tracks PPE inventory consumption and ensures each employee has received required protective equipment. Distinct from compliance.ppe_issuance — this is the safety-domain authoritative record for PPE distribution management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`meeting` (
    `meeting_id` BIGINT COMMENT 'Unique identifier for the safety meeting record. Primary key.',
    `district_id` BIGINT COMMENT 'Identifier of the operational district where the safety meeting was held, used for route-based or field operations meetings.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the safety meeting was conducted (landfill, MRF, transfer station, district office, or maintenance yard).',
    `incident_id` BIGINT COMMENT 'Identifier of the safety incident or accident that prompted this meeting, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who conducted or presented the safety meeting (safety manager, supervisor, or designated safety representative).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Safety meetings often cover regulatory topics (OSHA standards, EPA rules, DOT requirements). This link tracks which regulatory requirements were addressed in training, supporting compliance with regul',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Safety meetings held at WTE facilities tracked for facility-level training compliance, safety communication documentation, and OSHA recordkeeping. Facility-specific meeting tracking enables compliance',
    `follow_up_meeting_id` BIGINT COMMENT 'Self-referencing FK on meeting (follow_up_meeting_id)',
    `action_items_identified` STRING COMMENT 'List of follow-up actions, corrective measures, or safety improvements identified during the meeting that require further attention or implementation.',
    `attendance_verified` BOOLEAN COMMENT 'Indicates whether employee attendance was formally verified through sign-in sheet, electronic check-in, or other documented method.',
    `attendee_count` STRING COMMENT 'Total number of employees who attended the safety meeting, used for compliance documentation and participation tracking.',
    `completion_verified_by` BIGINT COMMENT 'Identifier of the supervisor or safety manager who verified and approved the completion of the safety meeting documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety meeting record was first created in the system.',
    `document_reference_number` STRING COMMENT 'Reference number or file location of supporting documentation, attendance sheets, training materials, or presentation files associated with the meeting.',
    `dot_training_topic` BOOLEAN COMMENT 'Indicates whether the meeting covered DOT-mandated training topics for commercial drivers or hazardous materials transportation.',
    `duration_minutes` STRING COMMENT 'Total duration of the safety meeting in minutes, calculated from start to end time.',
    `end_time` TIMESTAMP COMMENT 'Timestamp when the safety meeting concluded, including time zone information.',
    `hazard_categories_addressed` STRING COMMENT 'Categories of workplace hazards addressed in the meeting (e.g., chemical exposure, physical hazards, ergonomic risks, biological hazards, environmental hazards).',
    `incident_related` BOOLEAN COMMENT 'Indicates whether the safety meeting was conducted in response to a specific safety incident, near-miss, or accident investigation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety meeting record was last updated or modified.',
    `materials_description` STRING COMMENT 'Description of training materials, handouts, videos, or other resources used or distributed during the safety meeting.',
    `meeting_date` DATE COMMENT 'Calendar date on which the safety meeting was conducted.',
    `meeting_number` STRING COMMENT 'Business identifier or reference number assigned to the safety meeting for tracking and documentation purposes.',
    `meeting_status` STRING COMMENT 'Current status of the safety meeting in its lifecycle (scheduled, completed, cancelled, or rescheduled).. Valid values are `scheduled|completed|cancelled|rescheduled`',
    `meeting_type` STRING COMMENT 'Classification of the safety meeting format and frequency (daily tailgate/toolbox talk, weekly safety meeting, monthly safety committee, quarterly review, annual safety day, incident debrief, or special topic session). [ENUM-REF-CANDIDATE: daily_tailgate|toolbox_talk|weekly_safety_meeting|monthly_safety_committee|quarterly_safety_review|annual_safety_day|incident_debrief|special_topic — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Detailed notes capturing key discussion points, questions raised, action items identified, and any safety concerns or observations shared during the meeting.',
    `operation_type` STRING COMMENT 'Type of waste management operation for which the safety meeting was conducted (residential collection, commercial collection, recycling/MRF operations, landfill operations, hazardous waste operations, fleet maintenance, transfer station, or administrative). [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|recycling_operations|landfill_operations|hazmat_operations|fleet_maintenance|transfer_station|administrative — 8 candidates stripped; promote to reference product]',
    `osha_compliance_topic` BOOLEAN COMMENT 'Indicates whether the meeting covered OSHA-mandated training topics or compliance requirements.',
    `ppe_requirements_discussed` BOOLEAN COMMENT 'Indicates whether personal protective equipment requirements, proper usage, or maintenance were discussed during the meeting.',
    `presenter_name` STRING COMMENT 'Full name of the employee who conducted the safety meeting, for documentation and audit purposes.',
    `presenter_title` STRING COMMENT 'Job title or role of the meeting presenter (e.g., Safety Manager, Operations Supervisor, EHS Coordinator).',
    `questions_raised` STRING COMMENT 'Summary of questions or concerns raised by attendees during the safety meeting, along with responses or follow-up plans.',
    `rcra_training_topic` BOOLEAN COMMENT 'Indicates whether the meeting covered RCRA-mandated hazardous waste training requirements for personnel handling hazardous materials.',
    `safety_topics_covered` STRING COMMENT 'Comma-separated list or detailed description of all safety topics discussed during the meeting (e.g., PPE usage, lockout/tagout procedures, hazard communication, ergonomics, vehicle safety).',
    `start_time` TIMESTAMP COMMENT 'Timestamp when the safety meeting commenced, including time zone information.',
    `topic` STRING COMMENT 'Primary subject or theme of the safety meeting (e.g., Proper Lifting Techniques, Hazardous Waste Handling, Winter Driving Safety, PPE Requirements).',
    `training_materials_provided` BOOLEAN COMMENT 'Indicates whether written training materials, handouts, or reference documents were distributed to attendees.',
    `verification_date` DATE COMMENT 'Date when the safety meeting documentation was reviewed and verified by the responsible supervisor or safety manager.',
    CONSTRAINT pk_meeting PRIMARY KEY(`meeting_id`)
) COMMENT 'Transactional record of a safety meeting or toolbox talk conducted at a Waste Management facility, district, or route operation. Captures meeting date and time, meeting type (daily tailgate/toolbox talk, weekly safety meeting, monthly safety committee, annual safety day), facility or district location, operation type, meeting topic, presenter identity, safety topics covered, number of attendees, and meeting notes. Supports OSHA-required safety training documentation and internal safety culture programs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`meeting_attendance` (
    `meeting_attendance_id` BIGINT COMMENT 'Unique identifier for the safety meeting attendance record.',
    `meeting_id` BIGINT COMMENT 'Reference to the specific safety meeting or toolbox talk that the employee attended.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who attended the safety meeting.',
    `proxy_meeting_attendance_id` BIGINT COMMENT 'Self-referencing FK on meeting_attendance (proxy_meeting_attendance_id)',
    `acknowledgment_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee acknowledged understanding of the safety topics covered during the meeting.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The date and time when the employee provided acknowledgment of the safety topics covered.',
    `attendance_date` DATE COMMENT 'The date on which the employee attended the safety meeting.',
    `attendance_duration_minutes` STRING COMMENT 'The total duration in minutes that the employee was present at the safety meeting.',
    `attendance_method` STRING COMMENT 'The method by which the employee attended the safety meeting (in-person, virtual/remote, hybrid, or via recorded session).. Valid values are `in_person|virtual|hybrid|recorded`',
    `attendance_notes` STRING COMMENT 'Free-text notes or comments regarding the employees attendance, such as reasons for late arrival, early departure, or special circumstances.',
    `attendance_status` STRING COMMENT 'Status indicating whether the employee was present, absent, excused, or arrived late to the safety meeting.. Valid values are `present|absent|excused|late`',
    `cdl_holder_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee holds a Commercial Driver License, relevant for DOT-mandated safety training requirements.',
    `check_in_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee checked in or was marked present at the safety meeting.',
    `completion_status` STRING COMMENT 'Status indicating whether the employee completed all requirements of the safety meeting attendance (full participation, acknowledgment, signature).. Valid values are `completed|incomplete|partial|pending_verification`',
    `compliance_year` STRING COMMENT 'The calendar year to which this safety meeting attendance is attributed for annual OSHA compliance and training hour tracking.',
    `department_code` STRING COMMENT 'Code identifying the department or operational unit to which the employee belonged at the time of attendance.',
    `device_type` STRING COMMENT 'The type of device used to capture attendance and signature (tablet, mobile phone, desktop computer, or paper form).. Valid values are `tablet|mobile|desktop|paper`',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate of the employees location at the time of check-in, captured via GPS for verification of physical presence.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate of the employees location at the time of check-in, captured via GPS for verification of physical presence.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is certified for hazardous materials handling, relevant for RCRA and DOT compliance training.',
    `ip_address` STRING COMMENT 'The IP address from which the employee checked in or signed the attendance record, used for audit and verification purposes.',
    `job_role_code` STRING COMMENT 'Code identifying the employees job role or position at the time of the safety meeting, relevant for role-specific training requirements.',
    `location_code` STRING COMMENT 'Code identifying the physical location or facility where the employee attended the safety meeting (e.g., landfill site, MRF, district office).',
    `osha_recordable_flag` BOOLEAN COMMENT 'Boolean indicator of whether this attendance record is required for OSHA 300 log recordkeeping and compliance reporting.',
    `record_created_by` STRING COMMENT 'The username or identifier of the user or system process that created this attendance record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this attendance record was first created in the system.',
    `record_source_system` STRING COMMENT 'The name or code of the source system from which this attendance record originated (e.g., Enviance EHS, Workday HCM, manual entry).',
    `record_updated_by` STRING COMMENT 'The username or identifier of the user or system process that last updated this attendance record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this attendance record was last modified or updated.',
    `signature_captured_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employees signature (digital or physical) was captured for attendance verification.',
    `signature_image_url` STRING COMMENT 'URL or file path reference to the stored digital signature image if captured electronically.',
    `signature_timestamp` TIMESTAMP COMMENT 'The date and time when the employees signature was captured.',
    `signature_type` STRING COMMENT 'The method by which the employees signature was captured (digital, physical paper, electronic tablet, or verbal confirmation).. Valid values are `digital|physical|electronic|verbal`',
    `training_credit_hours` DECIMAL(18,2) COMMENT 'The number of training credit hours awarded to the employee for attending this safety meeting, used for OSHA compliance tracking.',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the supervisor or system verified the attendance record.',
    CONSTRAINT pk_meeting_attendance PRIMARY KEY(`meeting_attendance_id`)
) COMMENT 'Association record capturing individual employee attendance at a safety meeting or toolbox talk. Links each attendee to a specific safety meeting record, capturing employee reference, attendance date, acknowledgment of topics covered, and digital or physical signature status. Enables per-employee safety training attendance tracking and supports OSHA documentation requirements for safety training participation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the safety audit record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reviewed and closed the audit after verifying completion of all corrective actions.',
    `audit_employee_id` BIGINT COMMENT 'Identifier of the employee who served as the lead auditor responsible for conducting and documenting the safety audit.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Safety audits evaluate compliance during specific service delivery operations (auditing hazmat collection procedures, compactor operation safety). Auditors document offering-specific findings; operati',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the audit was conducted (landfill, MRF, transfer station, maintenance depot, or administrative office).',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Safety audits at permitted facilities must verify compliance with permit-required safety measures (emergency response capabilities, equipment inspections, operator training). Auditors reference permit',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Safety audits verify compliance with specific regulatory requirements. Audit protocols are structured around regulatory citations (OSHA standards, EPA rules). This link enables audit finding traceabil',
    `route_id` BIGINT COMMENT 'Identifier of the collection route audited, applicable when the audit scope is a field route rather than a fixed facility.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Safety audits of fleet operations inspect specific vehicles for compliance (backup alarms, fire extinguishers, safety decals, equipment condition) requiring direct vehicle link for finding tracking.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Facility-level safety audits at WTE facilities tracked for regulatory compliance, safety program effectiveness, and facility-specific corrective action tracking. Standard practice for high-hazard faci',
    `follow_up_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (follow_up_audit_id)',
    `audit_date` DATE COMMENT 'The date on which the safety audit was conducted or scheduled to be conducted.',
    `audit_number` STRING COMMENT 'Business identifier for the safety audit, formatted as SA-YYYYMMDD or similar pattern for external reference and tracking.. Valid values are `^SA-[0-9]{8}$`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including specific areas, processes, equipment, or safety programs evaluated during the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the safety audit: scheduled (planned but not started), in_progress (audit underway), completed (audit finished but findings open), closed (all findings resolved), or cancelled.. Valid values are `scheduled|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the safety audit indicating the scope and focus area: facility walkthrough, operational audit, program compliance audit, pre-task inspection, vehicle inspection, or PPE (Personal Protective Equipment) audit.. Valid values are `facility_walkthrough|operational_audit|program_compliance_audit|pre_task_inspection|vehicle_inspection|ppe_audit`',
    `closure_date` DATE COMMENT 'Date when the safety audit was formally closed after all findings were addressed and corrective actions verified.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions identified in the audit must be completed and verified.',
    `corrective_actions_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective actions are required as a result of the audit findings (True if corrective actions needed, False otherwise).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical or high-severity findings identified that pose immediate risk to worker safety and require urgent corrective action.',
    `end_time` TIMESTAMP COMMENT 'Timestamp when the safety audit was completed, used to calculate audit duration and resource allocation.',
    `equipment_condition_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the condition and safety features of equipment, vehicles, or machinery were verified during the audit (True if verified, False otherwise).',
    `follow_up_audit_date` DATE COMMENT 'Scheduled date for the follow-up audit to verify corrective action effectiveness and sustained compliance.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up audit is required to verify implementation and effectiveness of corrective actions (True if follow-up needed, False otherwise).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety audit record was last updated or modified.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor who conducted the safety audit, for reporting and accountability purposes.',
    `major_findings_count` STRING COMMENT 'Number of major findings representing significant safety gaps or non-compliance with established safety standards that require timely corrective action.',
    `minor_findings_count` STRING COMMENT 'Number of minor findings or observations representing low-risk issues or opportunities for continuous improvement in safety practices.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, context, or recommendations documented by the audit team that do not fit into structured fields.',
    `operation_type` STRING COMMENT 'Type of operational area being audited: residential collection, commercial collection, landfill operations, MRF (Materials Recovery Facility) operations, hazmat (hazardous materials) handling, fleet maintenance, or WTE (Waste-to-Energy) operations. [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|landfill_operations|mrf_operations|hazmat_handling|fleet_maintenance|wte_operations — 7 candidates stripped; promote to reference product]',
    `overall_audit_score` DECIMAL(18,2) COMMENT 'Composite numerical score representing the overall safety performance observed during the audit, typically expressed as a percentage (0.00 to 100.00) or weighted score.',
    `positive_observations_count` STRING COMMENT 'Number of positive safety observations or best practices identified during the audit that should be recognized and replicated.',
    `ppe_compliance_verified` BOOLEAN COMMENT 'Boolean flag indicating whether PPE (Personal Protective Equipment) compliance was verified during the audit (True if verified, False otherwise).',
    `rating` STRING COMMENT 'Qualitative rating assigned to the audit based on the overall score and findings: excellent, satisfactory, needs improvement, unsatisfactory, or critical.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory|critical`',
    `regulatory_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether findings from this audit must be reported to regulatory agencies such as OSHA, EPA, or state authorities (True if reportable, False otherwise).',
    `report_url` STRING COMMENT 'URL or file path to the detailed audit report document containing findings, photos, corrective action plans, and supporting documentation.. Valid values are `^https?://.*`',
    `start_time` TIMESTAMP COMMENT 'Timestamp when the safety audit commenced, capturing precise start time for duration tracking and operational scheduling.',
    `team_members` STRING COMMENT 'Comma-separated list or narrative description of additional team members who participated in the audit alongside the lead auditor.',
    `total_findings_count` STRING COMMENT 'Total number of safety findings, observations, or non-conformances identified during the audit, regardless of severity.',
    `training_compliance_verified` BOOLEAN COMMENT 'Boolean flag indicating whether employee safety training compliance was verified during the audit (True if verified, False otherwise).',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of the audit, relevant for outdoor operations such as collection routes, landfill operations, or outdoor facility areas.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Transactional record of a formal internal safety audit or inspection conducted at a Waste Management facility or operational area. Captures audit number, audit date, audit type (facility walkthrough, operational audit, program compliance audit, pre-task inspection), audited facility or route, operation type, lead auditor, audit scope, overall audit score or rating, number of findings, and audit closure status. Distinct from compliance.compliance_inspection which is driven by regulatory agency inspections — this entity covers internal safety-driven audits.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the safety audit finding record. Primary key.',
    `audit_id` BIGINT COMMENT 'Reference to the parent safety audit or inspection during which this finding was identified. Links to the audit event that generated this finding.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Equipment-specific audit findings (boiler safety valve deficiencies, pressure gauge issues, guarding violations) tracked to units for targeted corrective actions and equipment-specific compliance mana',
    `corrective_action_id` BIGINT COMMENT 'Reference to the assigned corrective action plan or work order created to address this finding. Null if corrective action has not yet been assigned. Links finding to remediation tracking system.',
    `employee_id` BIGINT COMMENT 'Reference to the employee observed performing an unsafe act or associated with the finding, if applicable. Null if finding is condition-based or not employee-specific. Used for coaching, training needs assessment, and confidential safety performance tracking. Confidential per OSHA recordkeeping privacy requirements.',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility where the finding was identified (landfill, MRF, transfer station, hazmat facility, fleet maintenance depot, or administrative office). Enables facility-level safety performance tracking and benchmarking.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to specific equipment, vehicle, or asset involved in the finding, if applicable (e.g., compactor, loader, collection truck, conveyor system, baler). Null if finding is not equipment-specific. Enables equipment-related safety trend analysis and targeted maintenance interventions.',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the previous audit finding that this finding is a recurrence of, if applicable. Null if this is not a recurrence. Enables tracking of repeat findings and effectiveness of corrective actions.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Audit findings may be vehicle-specific (missing safety equipment, defective backup cameras, inadequate fire suppression) requiring direct vehicle link for corrective action assignment and closure veri',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Audit findings tied to specific WTE facilities for facility-level corrective action tracking, compliance management, and safety performance trending. Required for regulatory audit response and facilit',
    `parent_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on audit_finding (parent_audit_finding_id)',
    `actual_closure_date` DATE COMMENT 'Actual date when the finding was verified as corrected and closed. Null if finding remains open. Used to calculate corrective action cycle time and overdue metrics.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost in USD incurred to implement corrective action for this finding. Null if corrective action has not been completed or cost has not been tracked. Used for cost-benefit analysis of safety investments.',
    `assigned_to` STRING COMMENT 'Name or identifier of the individual or department responsible for implementing corrective action to address the finding. Typically facility manager, operations supervisor, maintenance supervisor, or safety coordinator.',
    `confined_space_flag` BOOLEAN COMMENT 'Boolean indicator whether the finding involves confined space entry violations (e.g., landfill gas wells, storage tanks, hoppers, bins). True if confined space violation is present; false otherwise. Critical for preventing asphyxiation and toxic exposure incidents.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action taken or planned to address the finding and prevent recurrence. Includes immediate corrective actions (e.g., stop work, remove hazard) and long-term systemic corrective actions (e.g., procedure revision, training program enhancement, engineering controls).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was first created in the system. Used for audit trail and data lineage tracking.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD to implement corrective action for this finding, including labor, materials, equipment, and contractor costs. Used for budgeting and prioritization of corrective actions. Null if cost has not been estimated.',
    `fall_protection_flag` BOOLEAN COMMENT 'Boolean indicator whether the finding involves missing or inadequate fall protection (guardrails, safety nets, personal fall arrest systems) for work at heights greater than 4 feet. True if fall protection violation is present; false otherwise. Leading cause of construction and landfill fatalities.',
    `finding_category` STRING COMMENT 'Classification of the type of safety deficiency identified. Unsafe act refers to employee behavior violations; unsafe condition refers to physical hazards; program gap refers to missing or inadequate safety management system elements; regulatory non-conformance refers to violations of OSHA, EPA, DOT, or RCRA requirements; documentation deficiency refers to missing or incomplete safety records; training deficiency refers to inadequate or missing employee safety training.. Valid values are `unsafe_act|unsafe_condition|program_gap|regulatory_non_conformance|documentation_deficiency|training_deficiency`',
    `finding_description` STRING COMMENT 'Detailed narrative description of the safety deficiency or non-conformance observed during the audit. Includes specific location, equipment involved, personnel observed, and conditions present at the time of observation. Should be sufficiently detailed to support corrective action planning and regulatory reporting if required.',
    `finding_number` STRING COMMENT 'Business-assigned sequential or structured identifier for the finding within the audit (e.g., F-001, AUD-2024-001-F03). Used for tracking and reference in corrective action plans and management reports.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding. Open indicates newly identified finding awaiting assignment; assigned indicates corrective action has been assigned to responsible party; in progress indicates corrective action is underway; pending verification indicates corrective action completed and awaiting audit verification; closed indicates finding has been verified as corrected and closed; overdue indicates corrective action has exceeded target completion date.. Valid values are `open|assigned|in_progress|pending_verification|closed|overdue`',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator whether the finding involves hazardous waste or hazardous materials handling, storage, or transportation violations. True if hazmat violation is present; false otherwise. Critical for RCRA and DOT compliance.',
    `identified_by` STRING COMMENT 'Name or identifier of the auditor, safety professional, or inspector who identified the finding. May be internal safety staff, third-party auditor, or regulatory inspector.',
    `identified_date` DATE COMMENT 'Date when the safety finding was identified during the audit or inspection. Used for aging analysis and corrective action timeline tracking.',
    `lockout_tagout_flag` BOOLEAN COMMENT 'Boolean indicator whether the finding involves failure to follow lockout/tagout procedures for equipment servicing or maintenance. True if LOTO violation is present; false otherwise. Critical for preventing equipment-related injuries and fatalities.',
    `machine_guarding_flag` BOOLEAN COMMENT 'Boolean indicator whether the finding involves missing or inadequate machine guarding on conveyors, balers, compactors, shredders, or other powered equipment with moving parts. True if machine guarding violation is present; false otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was last modified. Used for audit trail and change tracking. Updated whenever any field in the record is changed.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the finding, corrective action, or verification. May include communication with responsible parties, escalation history, or special circumstances.',
    `operation_area` STRING COMMENT 'Specific operational area, zone, or work location within the facility or operation where the finding was identified (e.g., Tipping Floor, MRF Sorting Line 2, Landfill Cell 5, Fleet Maintenance Bay 3, Hazmat Storage Building A). Enables spatial analysis of safety deficiencies and targeted corrective actions.',
    `photo_reference` STRING COMMENT 'File path, URL, or document management system reference to photographic evidence of the finding. Photos provide visual documentation for corrective action planning, verification, and training purposes. Null if no photos were taken.',
    `ppe_deficiency_flag` BOOLEAN COMMENT 'Boolean indicator whether the finding involves missing, inadequate, or improperly used personal protective equipment (hard hat, safety glasses, gloves, respirator, high-visibility vest, steel-toe boots, hearing protection). True if PPE deficiency is present; false otherwise.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean indicator whether this finding is a repeat of a previously identified and closed finding at the same location or involving the same equipment or process. True if recurrence; false if new finding. Indicates ineffective corrective action or systemic management system failure.',
    `regulatory_citation` STRING COMMENT 'Specific OSHA, EPA, DOT, or RCRA regulation or standard violated by this finding, if applicable (e.g., 29 CFR 1910.134, 40 CFR 264.175, 49 CFR 172.704). Null for non-regulatory findings. Critical for regulatory reporting and compliance tracking.',
    `root_cause_analysis` STRING COMMENT 'Documented root cause analysis of why the finding occurred, identifying underlying system failures, training gaps, procedural deficiencies, or management system weaknesses. Used to prevent recurrence and drive continuous improvement. Typically completed for major and critical findings.',
    `severity_level` STRING COMMENT 'Risk-based classification of the findings potential impact on worker safety and health. Critical indicates imminent danger or serious injury/fatality risk requiring immediate action; major indicates significant risk requiring prompt corrective action; minor indicates low-risk deficiency requiring corrective action within standard timeframes; observation indicates improvement opportunity with no immediate safety risk.. Valid values are `critical|major|minor|observation`',
    `target_closure_date` DATE COMMENT 'Target date by which the finding must be corrected and closed. Determined based on severity level and regulatory requirements. Critical findings typically require immediate or same-day closure; major findings within 7-30 days; minor findings within 90 days.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective. Null if finding has not yet been verified. Used to calculate total finding resolution cycle time.',
    `verification_method` STRING COMMENT 'Method used to verify that corrective action has been effectively implemented and the finding has been resolved. Physical inspection involves on-site verification; document review involves reviewing updated procedures or training records; employee interview involves confirming employee understanding; photographic evidence involves before/after photos; measurement involves quantitative verification; testing involves functional testing of equipment or controls.. Valid values are `physical_inspection|document_review|employee_interview|photographic_evidence|measurement|testing`',
    `verified_by` STRING COMMENT 'Name or identifier of the individual who verified that the corrective action was effectively implemented and the finding was resolved. Typically safety manager, auditor, or facility manager. Null if finding has not yet been verified.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding or deficiency identified during a safety audit or inspection at a Waste Management facility or operation. Captures finding number, linked audit reference, finding category (unsafe act, unsafe condition, program gap, regulatory non-conformance), finding description, severity level (critical, major, minor, observation), operation area or zone where found, assigned corrective action reference, and finding closure status. Enables granular tracking of safety deficiencies and corrective action follow-through.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`hazard_register` (
    `hazard_register_id` BIGINT COMMENT 'Unique identifier for the hazard register entry. Primary key for the hazard register.',
    `facility_id` BIGINT COMMENT 'Reference to the facility where this hazard is identified. Links to landfills, MRFs, transfer stations, maintenance yards, or administrative offices.',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: Hazards are identified and assessed for specific job positions. Links hazard exposure to position enables "show all hazards for this position" for JHA development and position-specific training per IS',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Hazard registers for permitted operations must identify permit-related hazards (emission exceedances, waste handling risks, equipment failures that could cause permit violations). Required for ISO 140',
    `employee_id` BIGINT COMMENT 'Reference to the employee who identified or reported this hazard. Supports worker participation in safety programs.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Hazard identification must incorporate regulatory requirements to ensure all compliance-related hazards are captured in risk assessments. This link enables tracking which hazards are driven by regulat',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Hazards are registered per service offering (compactor operation hazards, rear-loader pinch points, hazmat exposure risks). Safety teams maintain offering-specific hazard registers; operations teams r',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Hazards are waste-stream-specific (biohazard exposure from medical waste, chemical reactivity in industrial streams, combustion risk in organics). EPA and OSHA require stream-specific hazard identific',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Facility-specific hazard registers for WTE operations document site-specific hazards, control measures, and risk assessments. Required for ISO 45001, process safety management, and facility-level risk',
    `parent_hazard_register_id` BIGINT COMMENT 'Self-referencing FK on hazard_register (parent_hazard_register_id)',
    `action_plan_due_date` DATE COMMENT 'Target completion date for implementing additional control measures or improvements identified in the action plan.',
    `action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether an action plan is required to implement additional controls or improvements. True when residual risk is not accepted or controls are inadequate.',
    `administrative_controls` STRING COMMENT 'Policies, procedures, training, and work practices implemented to reduce hazard exposure. Examples: job rotation, safety meetings, standard operating procedures, permit systems.',
    `control_adequacy_status` STRING COMMENT 'Assessment of whether current control measures are sufficient to reduce risk to an acceptable level. Drives action planning for additional controls.. Valid values are `adequate|inadequate|under_review|improvement_required`',
    `control_measures` STRING COMMENT 'Detailed description of current control measures in place to mitigate the hazard. Includes engineering controls, administrative controls, and PPE requirements following hierarchy of controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hazard register record was first created in the system.',
    `engineering_controls` STRING COMMENT 'Physical modifications or equipment designed to eliminate or reduce the hazard. Examples: machine guards, ventilation systems, safety interlocks, backup alarms.',
    `exposure_frequency` STRING COMMENT 'How often workers are exposed to this hazard. Used in risk assessment calculations.. Valid values are `continuous|daily|weekly|monthly|occasional|rare`',
    `hazard_category` STRING COMMENT 'Primary classification of the hazard type. Chemical: exposure to hazardous substances; Physical: noise, temperature, radiation; Biological: bacteria, viruses, waste pathogens; Ergonomic: repetitive motion, lifting; Electrical: shock, arc flash; Struck-by: moving vehicles, falling objects; Caught-in: machinery, equipment; Fall: same level, elevated surfaces. [ENUM-REF-CANDIDATE: chemical|physical|biological|ergonomic|electrical|struck-by|caught-in|fall — 8 candidates stripped; promote to reference product]',
    `hazard_code` STRING COMMENT 'Unique business identifier for the hazard. Format: HAZ- followed by alphanumeric code.. Valid values are `^HAZ-[A-Z0-9]{6,12}$`',
    `hazard_description` STRING COMMENT 'Detailed description of the workplace hazard including specific conditions, locations, and circumstances under which the hazard is present.',
    `hazard_name` STRING COMMENT 'Short descriptive name of the hazard for quick identification and reporting.',
    `hazard_register_status` STRING COMMENT 'Current lifecycle status of the hazard in the register. Active: hazard present and managed; Mitigated: controls in place, residual risk accepted; Eliminated: hazard removed; Under Investigation: newly identified, assessment in progress; Archived: no longer applicable.. Valid values are `active|mitigated|eliminated|under_investigation|archived`',
    `hazard_source` STRING COMMENT 'Specific source or origin of the hazard. Examples: collection truck hydraulics, landfill working face, MRF sorting line, leachate handling system, compactor equipment.',
    `hazard_subcategory` STRING COMMENT 'Secondary or more specific classification within the primary hazard category. Examples: confined space, vehicle collision, needle stick, heat stress, landfill gas exposure.',
    `identification_date` DATE COMMENT 'Date when the hazard was first identified and entered into the register.',
    `incident_history_count` STRING COMMENT 'Number of recorded safety incidents or near-misses associated with this hazard. Used to validate risk ratings and control effectiveness.',
    `inherent_likelihood_rating` STRING COMMENT 'Likelihood score of the hazard occurring without any controls in place. Typically scored 1-5 where 1=rare, 5=almost certain. Used to calculate inherent risk.',
    `inherent_risk_level` STRING COMMENT 'Qualitative risk level derived from inherent risk score. Typically: 1-5=low, 6-12=medium, 13-20=high, 21-25=critical.. Valid values are `low|medium|high|critical`',
    `inherent_risk_score` STRING COMMENT 'Calculated inherent risk score (likelihood × severity) before any control measures are applied. Represents the raw risk level.',
    `inherent_severity_rating` STRING COMMENT 'Severity score of potential consequences without any controls in place. Typically scored 1-5 where 1=negligible injury, 5=fatality. Used to calculate inherent risk.',
    `last_incident_date` DATE COMMENT 'Date of the most recent incident or near-miss related to this hazard. Triggers review of control adequacy.',
    `last_review_date` DATE COMMENT 'Date when the hazard register entry was most recently reviewed and validated for accuracy and control effectiveness.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this hazard and its controls. Ensures living register is kept current.',
    `notes` STRING COMMENT 'Additional notes, observations, or context about the hazard, its assessment, or control measures. Free-text field for supplementary information.',
    `operation_type` STRING COMMENT 'Type of waste management operation where the hazard is present. Determines applicable safety protocols and regulatory requirements. [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|landfill_operations|mrf_operations|hazmat_handling|fleet_maintenance|wte_operations|transfer_station — 8 candidates stripped; promote to reference product]',
    `ppe_required` STRING COMMENT 'Specific PPE required when exposed to this hazard. Examples: hard hat, safety glasses, high-visibility vest, steel-toed boots, respirator, cut-resistant gloves, hearing protection.',
    `residual_likelihood_rating` STRING COMMENT 'Likelihood score after control measures are applied. Scored 1-5. Represents the reduced probability of occurrence with controls in place.',
    `residual_risk_level` STRING COMMENT 'Qualitative risk level derived from residual risk score after controls. Used to determine if additional controls are needed.. Valid values are `low|medium|high|critical`',
    `residual_risk_score` STRING COMMENT 'Calculated residual risk score (likelihood × severity) after control measures are applied. Represents the remaining risk level.',
    `residual_severity_rating` STRING COMMENT 'Severity score after control measures are applied. Scored 1-5. Represents the reduced consequence severity with controls in place.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this hazard. Typically 6 or 12 months, or more frequent for high-risk hazards.',
    `risk_acceptance_status` STRING COMMENT 'Whether the residual risk level has been formally accepted by management or requires further mitigation.. Valid values are `accepted|not_accepted|conditional|pending_review`',
    `source_system` STRING COMMENT 'Name of the source system from which this hazard register entry originated. Typically Enviance EHS or SAP EHS module.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this hazard register record was most recently updated. Tracks currency of information.',
    `work_area_location` STRING COMMENT 'Specific work area, zone, or location within the facility where the hazard exists. Examples: Cell 5 working face, tipping floor, maintenance bay 3, sorting line A.',
    CONSTRAINT pk_hazard_register PRIMARY KEY(`hazard_register_id`)
) COMMENT 'Master record for the facility-level or operation-level hazard register, cataloging identified workplace hazards at each Waste Management site. Captures hazard ID, facility or operation type, hazard description, hazard category (chemical, physical, biological, ergonomic, electrical, struck-by, caught-in, fall), hazard source, inherent risk rating (likelihood × severity), current control measures in place, residual risk rating after controls, control adequacy assessment, and review date. Serves as the living risk register for each operational site.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`safety_training_record` (
    `safety_training_record_id` BIGINT COMMENT 'Unique identifier for the safety training record. Primary key for this transactional record of a completed safety training event.',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Driver-specific safety training (defensive driving, hazmat, DOT compliance) requires direct driver link for qualification tracking, certification management, and regulatory compliance verification.',
    `employee_id` BIGINT COMMENT 'Reference to the Waste Management employee who completed this safety training event.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Training records document employee qualification for specific service offerings (hazmat endorsement for hazmat collection, confined space certification for underground compactor service). Operations m',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: External training providers must link to vendor master for payment processing, 1099 reporting, training provider qualification verification, contract compliance, and cost allocation to safety programs',
    `refresher_safety_training_record_id` BIGINT COMMENT 'Self-referencing FK on safety_training_record (refresher_safety_training_record_id)',
    `applicable_job_roles` STRING COMMENT 'Comma-separated list or description of job roles, positions, or classifications for which this training is required or applicable (e.g., CDL Driver, Landfill Operator, MRF Sorter, Hazmat Technician).',
    `applicable_operation_types` STRING COMMENT 'Types of Waste Management operations for which this training is relevant (e.g., Residential Collection, Commercial Hauling, Landfill Operations, MRF Processing, Hazardous Waste Handling, WTE Facility).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the employee on the training assessment or examination, expressed as a percentage (0-100). Null if no formal assessment was required.',
    `attendance_verification_method` STRING COMMENT 'Method used to verify and document employee attendance at the training event (e.g., physical sign-in sheet, electronic badge scan, biometric verification, supervisor confirmation, online learning management system tracking).. Valid values are `sign_in_sheet|electronic_badge|biometric|supervisor_confirmation|online_tracking`',
    `certificate_expiration_date` DATE COMMENT 'Date on which the training certificate or qualification expires and requires renewal or recertification. Null for training that does not expire.',
    `certificate_issue_date` DATE COMMENT 'Date on which the training certificate or credential was officially issued to the employee.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion of the safety training, used for verification and audit purposes.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to this training event (e.g., accommodations provided, remedial actions required, exceptional performance).',
    `completion_status` STRING COMMENT 'Current status of the training record indicating whether the employee successfully passed, failed, did not complete, is still in progress, or was granted a waiver.. Valid values are `passed|failed|incomplete|in_progress|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety training record was first created in the system. Audit trail field for data governance and compliance tracking.',
    `delivery_method` STRING COMMENT 'Method by which the safety training was delivered: classroom instruction, online/e-learning, field demonstration, tailgate meeting, simulator-based, or blended approach combining multiple methods.. Valid values are `classroom|online|field_demonstration|tailgate|simulator|blended`',
    `dot_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this training is mandated by DOT regulations for hazardous materials transportation (49 CFR 172.704) or commercial driver licensing.',
    `epa_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this training is mandated by EPA regulations such as RCRA personnel training requirements (40 CFR 265.16) or CERCLA emergency response.',
    `hazard_categories_covered` STRING COMMENT 'Categories of workplace hazards addressed in this training (e.g., chemical exposure, confined space, electrical hazards, vehicle operations, ergonomic risks, biological hazards).',
    `next_training_due_date` DATE COMMENT 'Calculated date by which the employee must complete refresher or recertification training to maintain compliance with regulatory or company requirements.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this training record must be maintained for OSHA recordkeeping and inspection purposes under 29 CFR 1910.1020.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score percentage required to pass the training assessment for this course (e.g., 80.00 for 80% passing threshold).',
    `ppe_topics_covered` STRING COMMENT 'Description of PPE topics, equipment types, or usage protocols covered in this training (e.g., respirator fit testing, fall protection, chemical-resistant gloves, high-visibility clothing).',
    `record_retention_years` STRING COMMENT 'Number of years this training record must be retained to satisfy regulatory requirements (e.g., OSHA requires 30 years for exposure records, 3 years for most training records).',
    `regulatory_standard` STRING COMMENT 'Specific OSHA, DOT, EPA, or other regulatory standard citation that this training satisfies (e.g., OSHA 29 CFR 1910.120, DOT 49 CFR 172.704, RCRA 40 CFR 265.16).',
    `source_system` STRING COMMENT 'Name of the operational system from which this training record originated (e.g., Workday HCM, Enviance EHS, SAP EHS, Learning Management System). Used for data lineage and integration troubleshooting.',
    `trainer_name` STRING COMMENT 'Full name of the instructor, facilitator, or safety professional who delivered the training. May be internal Waste Management safety staff or external certified trainer.',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training event, including instructor fees, materials, facility rental, and employee time. Used for training budget tracking and ROI analysis.',
    `training_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount (USD for United States Dollar, CAD for Canadian Dollar, MXN for Mexican Peso).. Valid values are `USD|CAD|MXN`',
    `training_course_code` STRING COMMENT 'Unique code identifying the specific safety training course or program completed (e.g., HAZWOPER-40, OSHA-10, CDL-HAZMAT, PPE-101).',
    `training_course_name` STRING COMMENT 'Full descriptive name of the safety training course completed (e.g., Hazardous Waste Operations and Emergency Response 40-Hour, OSHA 10-Hour General Industry Safety).',
    `training_date` DATE COMMENT 'Date on which the employee successfully completed the safety training course. This is the principal business event timestamp for this transaction.',
    `training_document_url` STRING COMMENT 'URL or file path to the digital repository location where training certificates, attendance records, course materials, and assessment results are stored for audit and compliance purposes.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours of instruction completed for this safety training event, required for regulatory compliance documentation (e.g., OSHA 10-hour, 40-hour HAZWOPER).',
    `training_location` STRING COMMENT 'Physical location or facility where the training was conducted (e.g., facility name, training center, field site). For online training, may indicate Remote or Online.',
    `training_materials_provided` STRING COMMENT 'Description of training materials, handouts, manuals, or resources provided to the employee during or after the training event.',
    `training_start_date` DATE COMMENT 'Date on which the employee began the safety training course, relevant for multi-day or multi-session training programs.',
    `training_type` STRING COMMENT 'Classification of the training event indicating whether it is initial qualification, periodic refresher, recertification, remedial retraining, advanced skill development, or specialized topic training.. Valid values are `initial|refresher|recertification|remedial|advanced|specialized`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety training record was last modified in the system. Audit trail field for data governance and change tracking.',
    CONSTRAINT pk_safety_training_record PRIMARY KEY(`safety_training_record_id`)
) COMMENT 'Transactional record of each safety-specific training event completed by a Waste Management employee, capturing safety training completions that are managed and owned by the safety function. Captures training record ID, employee reference, training course name and type, delivery method (classroom, online, field demonstration, tailgate), training date, trainer or provider, pass/fail result, score if applicable, certificate number, expiration date, and regulatory standard satisfied. Complements workforce.training_record by providing the safety domains authoritative view of safety-mandated training completions.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`near_miss` (
    `near_miss_id` BIGINT COMMENT 'Unique identifier for the near-miss event record. Primary key.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Equipment-specific near-miss tracking for boiler operations (steam leaks, pressure excursions, equipment malfunctions) enables proactive maintenance and equipment-specific hazard mitigation before inc',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Near-miss events are critical safety incidents that did not result in injury but had the potential to do so. The business process requires formal corrective action plans to prevent recurrence. The nea',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the near-miss event occurred, such as a landfill, MRF (Materials Recovery Facility), transfer station, or administrative office.',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: Near misses occur during specific job tasks/positions. Links near miss to position enables "near miss frequency by position" trending analysis to identify high-risk positions requiring targeted interv',
    `lfg_collection_system_id` BIGINT COMMENT 'Foreign key linking to energy.lfg_collection_system. Business justification: LFG system near-miss events (gas detection alarms, equipment failures, exposure potential) tracked to systems for proactive hazard control and system-specific safety improvements in landfill gas opera',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Near-miss events at permitted facilities should reference the permit for trend analysis and proactive compliance management. Helps identify permit condition risks before violations occur. Used in perm',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported or observed the near-miss event.',
    `route_id` BIGINT COMMENT 'Identifier of the collection route where the near-miss occurred, applicable when the event happened during field collection operations rather than at a fixed facility.',
    `safety_program_id` BIGINT COMMENT 'Identifier of the safety program under which this near-miss is tracked, linking the event to specific safety initiatives or compliance programs.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Near-miss events are tagged to service type for trend analysis and preventive action (near-miss during residential collection, close call during compactor maintenance). Safety teams analyze near-miss ',
    `tertiary_near_corrective_action_owner_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for implementing and completing the corrective actions.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the collection vehicle or fleet asset involved in the near-miss event, if applicable.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Near-miss events at WTE facilities tracked for proactive hazard identification, facility-level safety culture metrics, and incident prevention. Facility-specific tracking enables targeted safety inter',
    `related_near_miss_id` BIGINT COMMENT 'Self-referencing FK on near_miss (related_near_miss_id)',
    `communication_method` STRING COMMENT 'Method used to communicate the near-miss findings and lessons learned to the workforce.. Valid values are `safety_meeting|toolbox_talk|email|bulletin_board|training_session|all_hands`',
    `contributing_factors` STRING COMMENT 'Narrative description of factors that contributed to the near-miss event, including environmental conditions, equipment issues, procedural gaps, or human factors.',
    `corrective_action_complete_date` DATE COMMENT 'Actual date when all corrective actions were completed and verified.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for implementing the corrective actions identified in the investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this near-miss record was first created in the system.',
    `environmental_conditions` STRING COMMENT 'Description of environmental conditions at the time of the near-miss, including weather, lighting, temperature, or other factors that may have contributed.',
    `equipment_involved` STRING COMMENT 'Description or identifier of equipment, vehicles, or machinery involved in the near-miss event.',
    `hazard_description` STRING COMMENT 'Detailed narrative description of the hazard condition or unsafe act that created the potential for injury, illness, or property damage.',
    `hazard_type` STRING COMMENT 'Classification of the primary hazard involved in the near-miss event, aligned with OSHA hazard categories for waste management operations. [ENUM-REF-CANDIDATE: struck_by|caught_in_between|fall_from_elevation|slip_trip_fall|vehicle_collision|equipment_failure|chemical_exposure|fire_explosion|electrical|ergonomic|environmental — 11 candidates stripped; promote to reference product]',
    `immediate_action_taken` STRING COMMENT 'Description of the immediate corrective actions taken at the time of the near-miss to prevent recurrence or mitigate the hazard.',
    `incident_date` DATE COMMENT 'The calendar date on which the near-miss event occurred.',
    `incident_time` TIMESTAMP COMMENT 'The precise date and time when the near-miss event occurred, capturing the real-world event timestamp for investigation and pattern analysis.',
    `investigation_complete_date` DATE COMMENT 'The date when the investigation was completed and findings were documented.',
    `investigation_start_date` DATE COMMENT 'The date when the formal investigation of the near-miss event was initiated.',
    `investigation_status` STRING COMMENT 'Current status of the near-miss investigation workflow, tracking progress from initial report through closure.. Valid values are `reported|under_investigation|investigation_complete|closed`',
    `lessons_learned` STRING COMMENT 'Summary of key lessons learned from the near-miss event and investigation, used for safety training and organizational learning.',
    `location_description` STRING COMMENT 'Free-text description of the specific location where the near-miss occurred, including details such as area within facility, street address on route, or equipment location.',
    `near_miss_description` STRING COMMENT 'Comprehensive narrative description of the near-miss event, including what happened, how it was avoided, and any contributing factors.',
    `near_miss_number` STRING COMMENT 'Business identifier for the near-miss event, typically formatted as a human-readable tracking number used in safety reports and investigations.',
    `operation_type` STRING COMMENT 'The type of waste management operation being performed when the near-miss occurred, categorizing the business context of the event. [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|landfill_operations|mrf_operations|hazmat_handling|transfer_station|maintenance|administrative — 8 candidates stripped; promote to reference product]',
    `osha_recordable_potential_flag` BOOLEAN COMMENT 'Indicates whether the near-miss had the potential to result in an OSHA recordable injury or illness if it had escalated. True if recordable potential, False otherwise.',
    `potential_injury_type` STRING COMMENT 'Description of the type of injury that could have occurred if the near-miss had resulted in harm, such as laceration, fracture, burn, or respiratory exposure.',
    `potential_severity` STRING COMMENT 'Assessment of the potential severity of injury, illness, or property damage if the near-miss event had resulted in an actual incident, used for risk prioritization.. Valid values are `minor|moderate|serious|catastrophic`',
    `ppe_adequate_flag` BOOLEAN COMMENT 'Indicates whether the PPE in use was adequate for the hazard encountered. True if adequate, False if inadequate or missing.',
    `ppe_in_use` STRING COMMENT 'Description of the PPE (Personal Protective Equipment) that was being worn or used by the employee at the time of the near-miss event.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the near-miss event was formally reported into the safety management system.',
    `root_cause` STRING COMMENT 'Identified root cause of the near-miss event as determined through investigation, focusing on underlying systemic issues rather than proximate causes.',
    `shift` STRING COMMENT 'The work shift during which the near-miss event occurred, used for pattern analysis and shift-specific safety interventions.. Valid values are `day|night|swing|weekend`',
    `source_system` STRING COMMENT 'Identifier of the source system from which this near-miss record originated, typically the EHS (Environmental Health and Safety) management system such as Enviance.',
    `supervisor_notified_flag` BOOLEAN COMMENT 'Indicates whether the immediate supervisor was notified of the near-miss event at the time it occurred. True if notified, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this near-miss record was last modified.',
    `witness_count` STRING COMMENT 'Number of witnesses who observed the near-miss event, used to assess the availability of corroborating information.',
    `work_activity` STRING COMMENT 'Detailed description of the specific work activity or task being performed at the time of the near-miss event.',
    CONSTRAINT pk_near_miss PRIMARY KEY(`near_miss_id`)
) COMMENT 'Transactional record specifically capturing near-miss events — unplanned incidents that did not result in injury, illness, or property damage but had the potential to do so. Captures near-miss number, date and time, reporting employee, facility or route location, operation type, near-miss description, hazard type involved, potential severity if the event had resulted in harm, immediate corrective actions taken, and investigation status. Near-misses are tracked separately from full incidents to support leading indicator safety programs and proactive hazard elimination.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` (
    `lockout_tagout_procedure_id` BIGINT COMMENT 'Unique identifier for the lockout/tagout procedure record. Primary key for the procedure master data.',
    `air_pollution_control_unit_id` BIGINT COMMENT 'Foreign key linking to energy.air_pollution_control_unit. Business justification: APC equipment LOTO procedures (baghouse, scrubber, ESP isolation) required for maintenance safety. Equipment-specific energy sources and isolation points documented per OSHA 1910.147 for environmental',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: LOTO procedures are equipment-specific for boiler units (electrical, steam, hydraulic isolation). OSHA 1910.147 requires documented procedures for high-energy equipment. Critical for maintenance safet',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the equipment is located (MRF, landfill, transfer station, maintenance depot).',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset or equipment record in the asset management system that this LOTO procedure applies to.',
    `lfg_collection_system_id` BIGINT COMMENT 'Foreign key linking to energy.lfg_collection_system. Business justification: LFG system LOTO procedures (blower isolation, flare shutdown, well isolation) required for maintenance in explosive atmosphere. System-specific procedures critical for worker protection during LFG equ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: LOTO procedures for permitted equipment (compactors, gas flares, leachate pumps, air pollution control devices) must align with permit-required maintenance protocols and safety conditions. Permits oft',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically safety manager or facility manager) who approved this LOTO procedure.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: LOTO procedures require authorized employees with specific LOTO certification. Links procedure to certification requirement enables verification that only certified employees execute LOTO per OSHA 191',
    `rng_processing_unit_id` BIGINT COMMENT 'Foreign key linking to energy.rng_processing_unit. Business justification: RNG processing equipment LOTO procedures (compressor isolation, pressure vessel lockout, gas line isolation) required for process safety management and maintenance safety in high-pressure gas processi',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: LOTO procedures are required for equipment used in specific service offerings (compactor maintenance during commercial service, container repair equipment). Safety teams develop offering-specific LOTO',
    `srf_production_line_id` BIGINT COMMENT 'Foreign key linking to energy.srf_production_line. Business justification: SRF line LOTO procedures (conveyor lockout, shredder isolation, classifier shutdown) required for equipment maintenance safety. Line-specific procedures prevent entanglement and equipment startup inju',
    `turbine_generator_id` BIGINT COMMENT 'Foreign key linking to energy.turbine_generator. Business justification: Turbine-specific LOTO procedures required for electrical isolation, steam isolation, and rotating equipment lockout. OSHA compliance and electrical safety standards mandate equipment-specific procedur',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: LOTO procedures for vehicle maintenance specify vehicle-specific energy isolation points (hydraulic, electrical, pneumatic systems) critical for technician safety during maintenance operations.',
    `superseded_lockout_tagout_procedure_id` BIGINT COMMENT 'Self-referencing FK on lockout_tagout_procedure (superseded_lockout_tagout_procedure_id)',
    `approval_date` DATE COMMENT 'Date when this LOTO procedure was formally approved by the authorized safety manager or facility manager.',
    `authorized_employee_roles` STRING COMMENT 'Comma-separated list of job roles or positions authorized to perform this LOTO procedure (e.g., Maintenance Technician, Electrician, Equipment Operator Level 3).',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether employees must hold a specific certification to perform this LOTO procedure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOTO procedure record was first created in the system.',
    `diagram_available_flag` BOOLEAN COMMENT 'Indicates whether a visual diagram or schematic of lockout points is available for this procedure.',
    `effective_date` DATE COMMENT 'Date when this LOTO procedure becomes effective and may be used in field operations.',
    `electrical_isolation_required_flag` BOOLEAN COMMENT 'Indicates whether electrical energy isolation is required for this equipment.',
    `energy_sources_controlled` STRING COMMENT 'Comma-separated list of all energy sources that must be controlled during lockout: electrical, hydraulic, pneumatic, gravitational, thermal, chemical, mechanical, stored energy.',
    `equipment_name` STRING COMMENT 'The common name or designation of the equipment or machinery covered by this LOTO procedure (e.g., Baler Unit 3, Compactor A, Conveyor Belt 2).',
    `equipment_type` STRING COMMENT 'Classification of the equipment type requiring lockout/tagout procedures. [ENUM-REF-CANDIDATE: baler|compactor|conveyor|shredder|sorter|loader|excavator|dozer|crane|pump|press|grinder|other — 13 candidates stripped; promote to reference product]',
    `group_lockout_required_flag` BOOLEAN COMMENT 'Indicates whether this procedure requires group lockout provisions when multiple employees are working on the same equipment.',
    `hazard_description` STRING COMMENT 'Description of the specific hazards associated with the equipment that necessitate lockout/tagout procedures (e.g., unexpected startup, release of stored energy, electrical shock, crushing hazard).',
    `hydraulic_isolation_required_flag` BOOLEAN COMMENT 'Indicates whether hydraulic energy isolation is required for this equipment.',
    `incident_count` STRING COMMENT 'Number of safety incidents or near-misses associated with this equipment that involved failure to follow LOTO procedures.',
    `last_incident_date` DATE COMMENT 'Date of the most recent safety incident involving this equipment related to LOTO procedures.',
    `last_review_date` DATE COMMENT 'Date when this LOTO procedure was last reviewed for accuracy and completeness.',
    `lockout_device_count` STRING COMMENT 'Total number of lockout devices required to complete the procedure.',
    `lockout_device_types_required` STRING COMMENT 'Comma-separated list of lockout device types required for this procedure (e.g., padlock, circuit breaker lockout, valve lockout, cable lockout, hasp).',
    `lockout_steps_sequence` STRING COMMENT 'Detailed step-by-step sequence of actions required to safely lock out the equipment. Includes preparation, shutdown, isolation, lockout device application, stored energy release, and verification steps.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this LOTO procedure. OSHA requires annual review at minimum.',
    `osha_inspection_ready_flag` BOOLEAN COMMENT 'Indicates whether this LOTO procedure meets all OSHA 29 CFR 1910.147 requirements and is ready for regulatory inspection.',
    `pneumatic_isolation_required_flag` BOOLEAN COMMENT 'Indicates whether pneumatic energy isolation is required for this equipment.',
    `ppe_required` STRING COMMENT 'Comma-separated list of PPE items required when performing this LOTO procedure (e.g., arc-rated gloves, face shield, insulated tools, hard hat, safety glasses).',
    `procedure_document_url` STRING COMMENT 'URL or file path to the full LOTO procedure document, including diagrams, photos, and detailed instructions.. Valid values are `^https?://.*`',
    `procedure_notes` STRING COMMENT 'Additional notes, special considerations, or warnings specific to this LOTO procedure.',
    `procedure_number` STRING COMMENT 'Business identifier for the LOTO procedure, typically formatted as LOTO-XXXXXX. Used for external reference and documentation.. Valid values are `^LOTO-[A-Z0-9]{6,12}$`',
    `procedure_status` STRING COMMENT 'Current lifecycle status of the LOTO procedure. Only active procedures may be used for field operations.. Valid values are `draft|active|under_review|suspended|retired`',
    `procedure_version` STRING COMMENT 'Version number of the LOTO procedure document, typically in major.minor format (e.g., 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    `restoration_steps` STRING COMMENT 'Step-by-step sequence for safely restoring equipment to normal operation after maintenance or servicing is complete, including removal of lockout devices and re-energization.',
    `review_frequency_months` STRING COMMENT 'Number of months between required reviews of this LOTO procedure. OSHA mandates at least annual (12 months) review.',
    `source_system` STRING COMMENT 'System of record where this LOTO procedure was originally created or maintained (SAP EHS, Enviance EHS, Infor EAM, or manual entry).. Valid values are `SAP_EHS|Enviance|Infor_EAM|Manual_Entry`',
    `stored_energy_release_method` STRING COMMENT 'Detailed instructions for safely releasing or dissipating stored energy (springs, capacitors, elevated components, pressurized lines) before servicing.',
    `tagout_required_flag` BOOLEAN COMMENT 'Indicates whether tagout devices (warning tags) are required in addition to lockout devices.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether specific training is required before an employee can execute this LOTO procedure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOTO procedure record was last modified.',
    `verification_method` STRING COMMENT 'Method used to verify that equipment is properly isolated and de-energized before work begins (e.g., test start button, voltage meter check, pressure gauge reading).',
    CONSTRAINT pk_lockout_tagout_procedure PRIMARY KEY(`lockout_tagout_procedure_id`)
) COMMENT 'Master record for each equipment-specific Lockout/Tagout (LOTO) procedure developed under OSHA 29 CFR 1910.147 for Waste Management equipment and machinery. Captures procedure ID, equipment name and asset reference, facility location, energy sources to be controlled (electrical, hydraulic, pneumatic, gravitational, thermal, chemical), lockout steps sequence, required lockout devices, authorized employees, procedure review date, and approval status. Critical for MRF equipment, compactors, balers, and landfill machinery.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`loto_execution` (
    `loto_execution_id` BIGINT COMMENT 'Unique identifier for each execution of a Lockout/Tagout procedure on equipment. Primary key for the LOTO execution transaction record.',
    `air_pollution_control_unit_id` BIGINT COMMENT 'Foreign key linking to energy.air_pollution_control_unit. Business justification: APC equipment lockout executions tracked for maintenance safety verification and compliance documentation. Links lockout events to specific environmental control equipment for safety audit trail.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Actual lockout events tracked to specific boiler units for compliance verification, lockout duration analysis, and correlation with maintenance work orders. Required for OSHA audit trail and safety pe',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility (landfill, MRF, transfer station, maintenance depot, hazmat TSDF) where the LOTO execution occurred.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the specific piece of equipment (compactor, baler, conveyor, loader, truck) on which the LOTO procedure was executed. Links to the asset master record.',
    `incident_id` BIGINT COMMENT 'Reference to the safety incident record if an incident occurred during this LOTO execution. Links to the incident investigation and OSHA recordkeeping system.',
    `lfg_collection_system_id` BIGINT COMMENT 'Foreign key linking to energy.lfg_collection_system. Business justification: LFG system lockout executions tracked for explosive atmosphere work permits, maintenance safety verification, and regulatory compliance. System-specific lockout tracking critical for landfill gas oper',
    `lockout_tagout_procedure_id` BIGINT COMMENT 'Reference to the standard LOTO procedure document that governs this execution. Links to the master procedure defining energy isolation steps for this equipment type.',
    `employee_id` BIGINT COMMENT 'Reference to the OSHA-authorized employee who performed the lockout. This employee must have completed LOTO training and be certified to execute energy isolation procedures.',
    `quaternary_loto_deviation_approved_by_employee_id` BIGINT COMMENT 'Reference to the supervisor or safety manager who approved any deviation from the standard LOTO procedure. Required for accountability when procedures are modified.',
    `quinary_loto_supervisor_employee_id` BIGINT COMMENT 'Reference to the supervisor responsible for overseeing this LOTO execution and ensuring compliance with safety procedures.',
    `rng_processing_unit_id` BIGINT COMMENT 'Foreign key linking to energy.rng_processing_unit. Business justification: RNG unit lockout executions tracked for process safety management compliance, high-pressure equipment maintenance safety, and EPA RMP documentation. Unit-specific lockout tracking required for gas pro',
    `srf_production_line_id` BIGINT COMMENT 'Foreign key linking to energy.srf_production_line. Business justification: SRF line lockout executions tracked for production equipment maintenance safety, lockout compliance verification, and equipment-specific safety performance. Line-specific tracking prevents unauthorize',
    `tertiary_loto_employee_id` BIGINT COMMENT 'Reference to the employee designated as the group lockout coordinator responsible for managing the group LOTO execution and ensuring all workers apply and remove their locks properly.',
    `turbine_generator_id` BIGINT COMMENT 'Foreign key linking to energy.turbine_generator. Business justification: Turbine lockout executions tracked for electrical safety compliance, maintenance coordination, and equipment-specific lockout verification. Critical for power generation equipment maintenance safety a',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: LOTO execution events occur on specific vehicles during maintenance. Links execution to vehicle for compliance verification, incident investigation, and maintenance safety tracking.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance or repair work order that required the LOTO execution. Links to the PM or corrective maintenance work order.',
    `reversal_loto_execution_id` BIGINT COMMENT 'Self-referencing FK on loto_execution (reversal_loto_execution_id)',
    `affected_employees_count` STRING COMMENT 'Number of affected employees who were notified of the LOTO execution. Tracks communication reach for safety compliance.',
    `affected_employees_notified_flag` BOOLEAN COMMENT 'Boolean indicator confirming that all affected employees (operators, production workers) in the area were notified before the LOTO procedure was applied.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this LOTO execution record was first created in the database. Audit trail for data lineage.',
    `deviation_description` STRING COMMENT 'Detailed description of any deviations from the standard LOTO procedure, including reasons for the deviation and compensating controls applied. Required for audit trail when deviations occur.',
    `deviation_from_procedure_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether any deviations from the standard LOTO procedure occurred during this execution. Triggers additional review and documentation requirements.',
    `employees_notified_of_restoration_flag` BOOLEAN COMMENT 'Boolean indicator confirming that all affected employees were notified that lockout devices are being removed and equipment is being returned to service.',
    `energy_sources_isolated` STRING COMMENT 'Comma-separated list of all energy sources that were isolated during this LOTO execution (electrical, hydraulic, pneumatic, mechanical, thermal, chemical, gravitational). Documents all hazardous energy types controlled.',
    `equipment_inspection_before_restoration_flag` BOOLEAN COMMENT 'Boolean indicator confirming that the authorized employee inspected the equipment and work area to ensure all tools, parts, and personnel are clear before restoring energy.',
    `execution_number` STRING COMMENT 'Human-readable business identifier for this LOTO execution event. Typically formatted as facility code, date, and sequence number for audit trail purposes.',
    `execution_status` STRING COMMENT 'Current lifecycle status of the LOTO execution. Tracks progression from initiation through lockout, verification, work performance, and restoration of energy sources. [ENUM-REF-CANDIDATE: initiated|locked_out|verified|work_in_progress|restored|completed|aborted — 7 candidates stripped; promote to reference product]',
    `group_lockout_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this LOTO execution involved multiple authorized employees working simultaneously on the same equipment, requiring group lockout procedures.',
    `incident_occurred_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether any safety incident, near-miss, or equipment damage occurred during this LOTO execution. Triggers incident investigation procedures.',
    `isolation_points_count` STRING COMMENT 'Total number of energy isolation points (circuit breakers, valves, switches, disconnects) that were locked out during this execution. Used for verification completeness.',
    `lock_serial_numbers` STRING COMMENT 'Comma-separated list of unique serial numbers for all physical locks applied to energy isolation devices. Enables tracking of individual lock inventory and assignment.',
    `lockout_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all energy isolation devices were successfully applied and locked, and the equipment was confirmed in a zero-energy state.',
    `lockout_devices_applied` STRING COMMENT 'Detailed list of lockout devices applied including lock serial numbers, tag numbers, and isolation point locations. Provides auditable record of physical lockout hardware used.',
    `lockout_start_timestamp` TIMESTAMP COMMENT 'Date and time when the authorized employee initiated the LOTO procedure and began applying lockout devices to energy isolation points. Principal business event timestamp for this transaction.',
    `notes` STRING COMMENT 'Free-text field for additional observations, special conditions, lessons learned, or other relevant information about this LOTO execution. Supports continuous improvement.',
    `restoration_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all lockout devices were removed, energy sources were restored, and the equipment was returned to normal operational status.',
    `restoration_start_timestamp` TIMESTAMP COMMENT 'Date and time when the authorized employee began the procedure to restore energy sources and remove lockout devices after work completion.',
    `shift_change_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this LOTO execution spanned multiple work shifts, requiring special shift-change procedures to maintain continuous protection.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this LOTO execution record (Enviance EHS, Infor EAM, or manual safety log). Supports data lineage and integration troubleshooting.',
    `tag_numbers` STRING COMMENT 'Comma-separated list of unique tag identification numbers affixed to locked-out equipment. Tags provide warning information and identify the authorized employee.',
    `total_lockout_duration_minutes` STRING COMMENT 'Total elapsed time in minutes from lockout initiation to restoration completion. Used for operational efficiency analysis and downtime tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this LOTO execution record was last modified. Audit trail for data lineage and change tracking.',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the authorized employee completed verification that all energy sources are isolated and the equipment is safe for servicing.',
    `work_description` STRING COMMENT 'Detailed description of the maintenance, repair, cleaning, or servicing work being performed on the equipment under lockout conditions. Explains why energy isolation was required.',
    `work_type` STRING COMMENT 'Classification of the work activity being performed under LOTO protection. Categorizes the nature of the maintenance or servicing task. [ENUM-REF-CANDIDATE: preventive_maintenance|corrective_maintenance|repair|cleaning|inspection|modification|installation|decommissioning — 8 candidates stripped; promote to reference product]',
    `zero_energy_verification_method` STRING COMMENT 'Method used to verify that all energy sources have been effectively isolated and the equipment is in a zero-energy or zero-potential state before work begins. [ENUM-REF-CANDIDATE: visual_inspection|meter_reading|test_equipment|operational_test|pressure_gauge|voltage_tester|multimeter|other — 8 candidates stripped; promote to reference product]',
    `zero_energy_verified_flag` BOOLEAN COMMENT 'Boolean indicator confirming that the authorized employee verified the equipment is in a zero-energy state and safe for work to proceed. Critical safety checkpoint.',
    CONSTRAINT pk_loto_execution PRIMARY KEY(`loto_execution_id`)
) COMMENT 'Transactional record capturing each execution of a Lockout/Tagout (LOTO) procedure on a specific piece of equipment at a Waste Management facility. Captures execution ID, linked LOTO procedure reference, equipment asset reference, execution date and time, authorized employee performing the lockout, work being performed under lockout, lockout devices applied, verification of zero energy state, restoration date and time, and any deviations from the standard procedure. Provides an auditable LOTO execution log for OSHA compliance.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`alert` (
    `alert_id` BIGINT COMMENT 'Unique identifier for the safety alert record. Primary key.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Safety alerts are issued for specific service types (alert about contaminated sharps containers in medical waste service, alert about unstable loads in construction debris collection). Operations team',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Alerts are waste-stream-specific (alert about reactive chemicals in industrial waste stream, alert about infectious materials in medical waste). Safety teams issue stream-specific alerts; operations t',
    `employee_id` BIGINT COMMENT 'Senior safety or operations leader who approved the issuance of this safety alert. Required for critical and high-severity alerts.',
    `alert_issuing_employee_id` BIGINT COMMENT 'Employee who authored and issued this safety alert. Typically a safety manager, EHS director, or corporate safety officer.',
    `incident_id` BIGINT COMMENT 'Reference to the incident record that triggered this safety alert, if applicable. Links lesson-learned alerts to their source incidents.',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Safety alerts triggered by manifest discrepancies, transportation incidents, or waste characterization issues must reference the manifest for operational communication. Links lessons learned from hazm',
    `osha_recordable_id` BIGINT COMMENT 'Reference to the OSHA recordable case that prompted this safety alert, if applicable. Links alerts to formal OSHA recordkeeping.',
    `primary_superseded_by_alert_id` BIGINT COMMENT 'Reference to the newer safety alert that replaces this one. Populated when an alert is superseded by updated guidance or corrected information.',
    `superseded_alert_id` BIGINT COMMENT 'Self-referencing FK on alert (superseded_alert_id)',
    `acknowledged_count` STRING COMMENT 'Number of recipients who have acknowledged the safety alert. Updated as acknowledgments are received. Used to track compliance progress.',
    `acknowledgment_deadline_date` DATE COMMENT 'Date by which all required recipients must acknowledge the safety alert. Used to track compliance and escalate non-acknowledgments.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether recipients must formally acknowledge receipt and understanding of this safety alert. True for critical and high-severity alerts.',
    `affected_facility_types` STRING COMMENT 'Comma-separated list of facility types to which this safety alert applies (e.g., transfer station, landfill, MRF, maintenance shop, hazmat TSDF). Used for targeted distribution.',
    `affected_operation_types` STRING COMMENT 'Comma-separated list of operation types to which this safety alert applies (e.g., residential collection, commercial hauling, landfill operations, MRF processing, hazmat handling). Determines distribution scope.',
    `alert_description` STRING COMMENT 'Detailed narrative describing the hazard, incident background, lessons learned, regulatory requirements, or safety directive. Provides full context and guidance for field operations.',
    `alert_number` STRING COMMENT 'Business identifier for the safety alert, formatted as SA-YYYY-NNNNN where YYYY is the year and NNNNN is a sequential number. Used for external communication and reference.. Valid values are `^SA-[0-9]{4}-[0-9]{5}$`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the safety alert. Tracks the alert from creation through acknowledgment to closure.. Valid values are `draft|issued|active|acknowledged|closed|superseded`',
    `alert_type` STRING COMMENT 'Classification of the safety alert indicating the nature of the hazard or communication. Determines the urgency and distribution requirements.. Valid values are `incident_lesson_learned|regulatory_update|equipment_hazard|weather_environmental_hazard|ppe_requirement|procedural_change`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the safety alert was approved for distribution. Marks the transition from draft to issued status.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, images, or files attached to this safety alert. Used to indicate availability of supplemental materials.',
    `closure_date` DATE COMMENT 'Date when the safety alert was formally closed after all acknowledgments were received or the alert was superseded. Marks the end of the alert lifecycle.',
    `communication_method` STRING COMMENT 'Primary method used to distribute this safety alert to the target audience. Multiple methods may be used for critical alerts.. Valid values are `email|mobile_app|safety_meeting|posted_notice|all_hands|toolbox_talk`',
    `corrective_actions_required` STRING COMMENT 'Description of specific corrective actions, procedural changes, or control measures that must be implemented in response to this alert. Provides actionable guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this safety alert record was first created in the system. Audit trail for record creation.',
    `distribution_district_codes` STRING COMMENT 'Comma-separated list of district codes where this alert applies. Populated when distribution_scope is district or facility. Enables district-level targeting.',
    `distribution_facility_codes` STRING COMMENT 'Comma-separated list of facility codes where this alert applies. Populated when distribution_scope is facility. Enables facility-specific targeting.',
    `distribution_region_codes` STRING COMMENT 'Comma-separated list of region codes where this alert applies. Populated when distribution_scope is region or narrower. Enables regional targeting.',
    `distribution_scope` STRING COMMENT 'Geographic or organizational scope defining who must receive and acknowledge this safety alert. Determines the audience breadth.. Valid values are `company_wide|region|district|facility|department|role_specific`',
    `document_url` STRING COMMENT 'URL or file path to the full safety alert document, including attachments, photos, diagrams, or supporting materials. Stored in the enterprise document management system.',
    `effective_date` DATE COMMENT 'Date when the safety alert requirements or recommendations become mandatory or effective. May differ from issue date to allow preparation time.',
    `expiration_date` DATE COMMENT 'Date when the safety alert is no longer active or relevant. Nullable for alerts that remain in effect indefinitely until superseded.',
    `hazard_category` STRING COMMENT 'Primary hazard classification per OSHA hazard categories (e.g., struck-by, caught-in, fall, exposure, ergonomic). Used for hazard trend analysis and prevention program targeting. [ENUM-REF-CANDIDATE: struck_by|caught_in|fall_from_elevation|exposure_chemical|exposure_biological|ergonomic|electrical|fire_explosion|vehicle_collision|environmental — promote to reference product]',
    `issue_date` DATE COMMENT 'Date when the safety alert was officially issued and distributed to the target audience. Marks the start of the acknowledgment period.',
    `ppe_requirements` STRING COMMENT 'Comma-separated list of PPE types required or recommended in response to this alert (e.g., hard hat, safety glasses, gloves, respirator, high-visibility vest). Guides field compliance.',
    `regulatory_authority` STRING COMMENT 'Governing body or regulatory agency that issued the requirement or guidance referenced in this alert. Identifies the compliance jurisdiction.. Valid values are `OSHA|EPA|DOT|RCRA|state_environmental|local_enforcement`',
    `regulatory_citation` STRING COMMENT 'Specific OSHA, EPA, DOT, or RCRA regulation citation that this alert addresses. Populated for regulatory update alerts. Format: Authority Standard Section (e.g., OSHA 29 CFR 1910.134).',
    `severity_level` STRING COMMENT 'Risk severity classification indicating the potential impact of the hazard. Critical alerts require immediate action and acknowledgment.. Valid values are `critical|high|medium|low|informational`',
    `source_system` STRING COMMENT 'Name of the operational system that created or manages this safety alert record (e.g., Enviance EHS, SAP EHS, custom safety portal). Used for data lineage and integration troubleshooting.',
    `title` STRING COMMENT 'Concise title or subject line of the safety alert that summarizes the hazard or topic. Used in notifications and alert listings.',
    `total_recipients_count` STRING COMMENT 'Total number of employees or recipients to whom this safety alert was distributed. Used to calculate acknowledgment completion percentage.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training is required as a result of this safety alert. True when the alert introduces new procedures or equipment requiring competency verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this safety alert record was last modified. Audit trail for record changes.',
    `version` STRING COMMENT 'Version number of the safety alert document. Incremented when the alert is revised or updated. Format: major.minor (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_alert PRIMARY KEY(`alert_id`)
) COMMENT 'Master record for safety alerts and safety bulletins issued by Waste Managements safety organization to communicate hazard warnings, lessons learned from incidents, regulatory updates, or urgent safety directives to field operations. Captures alert number, issue date, alert type (incident lesson learned, regulatory update, equipment hazard, weather/environmental hazard), affected operation types, alert title and description, distribution scope (company-wide, region, district, facility), acknowledgment requirement flag, and closure date. Supports proactive safety communication across the enterprise.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` (
    `alert_acknowledgment_id` BIGINT COMMENT 'Unique identifier for the safety alert acknowledgment record. Primary key for tracking individual employee acknowledgments of safety alerts and bulletins.',
    `alert_id` BIGINT COMMENT 'Reference to the specific safety alert or safety bulletin that was acknowledged by the employee. Links to the safety alert master record.',
    `district_id` BIGINT COMMENT 'Identifier of the operational district or region where the acknowledgment was collected. Supports regional safety compliance tracking and management reporting.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or operational location where the acknowledgment was collected. Enables tracking of safety alert distribution by site and ensures location-specific compliance.',
    `incident_id` BIGINT COMMENT 'Reference to the specific safety incident or near-miss event that triggered this safety alert, if applicable. Links acknowledgment to root cause incident for tracking corrective action effectiveness.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who acknowledged the safety alert. Links to the employee master record to track individual compliance with safety communications.',
    `prior_alert_acknowledgment_id` BIGINT COMMENT 'Self-referencing FK on alert_acknowledgment (prior_alert_acknowledgment_id)',
    `acknowledgment_date` DATE COMMENT 'The date on which the employee acknowledged receipt and understanding of the safety alert. Critical for tracking distribution effectiveness and compliance timelines.',
    `acknowledgment_duration_minutes` STRING COMMENT 'The time in minutes that the employee spent reviewing the safety alert before acknowledging. Helps assess engagement level and comprehension time for safety communications.',
    `acknowledgment_location` STRING COMMENT 'Specific location or area within the facility where the acknowledgment was collected. Provides context for safety alert distribution and helps track field-based acknowledgments.',
    `acknowledgment_method` STRING COMMENT 'The method or channel through which the employee acknowledged the safety alert. Indicates whether acknowledgment was captured digitally, via paper sign-off, during toolbox talk delivery, or through other communication channels.. Valid values are `digital_signature|paper_signoff|toolbox_talk|email_confirmation|mobile_app|training_session`',
    `acknowledgment_notes` STRING COMMENT 'Free-text notes or comments recorded during the acknowledgment process. May include employee questions, concerns, clarifications, or supervisor observations about the acknowledgment session.',
    `acknowledgment_status` STRING COMMENT 'Current status of the acknowledgment record. Tracks whether the employee has completed acknowledgment, is pending, overdue, or has been waived or exempted from the requirement.. Valid values are `completed|pending|overdue|waived|exempt`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee completed the acknowledgment process. Provides audit trail for compliance verification and incident investigation.',
    `cdl_holder_flag` BOOLEAN COMMENT 'Indicates whether the employee holds a Commercial Driver License at the time of acknowledgment. True if employee is a CDL holder, false otherwise. Important for tracking DOT-regulated driver safety communications.',
    `comprehension_verified_flag` BOOLEAN COMMENT 'Indicates whether employee comprehension of the safety alert content was verified through testing, verbal confirmation, or other assessment method. True if comprehension was verified, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was first created in the system. Provides audit trail for record lifecycle tracking.',
    `department_code` STRING COMMENT 'Code identifying the department or business unit to which the employee belongs. Enables departmental safety compliance tracking and targeted safety communications.',
    `device_type` STRING COMMENT 'Type of device or medium used to capture the acknowledgment. Indicates whether acknowledgment was captured on desktop computer, laptop, tablet, mobile device, kiosk, or paper form.. Valid values are `desktop|laptop|tablet|mobile|kiosk|paper`',
    `due_date` DATE COMMENT 'The date by which the employee was required to acknowledge the safety alert. Used to identify overdue acknowledgments and track compliance timeliness.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate where the acknowledgment was captured, if location services were enabled. Helps verify field-based acknowledgments and track mobile workforce compliance.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate where the acknowledgment was captured, if location services were enabled. Helps verify field-based acknowledgments and track mobile workforce compliance.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee holds current hazardous materials handling certification. True if HAZMAT certified, false otherwise. Critical for tracking safety communications to hazmat-qualified personnel.',
    `incident_related_flag` BOOLEAN COMMENT 'Indicates whether this safety alert acknowledgment is related to a specific safety incident or near-miss event. True if incident-related, false if routine safety communication.',
    `ip_address` STRING COMMENT 'IP address of the device used to submit the digital acknowledgment. Provides technical audit trail for electronic acknowledgments and helps verify authenticity.',
    `job_role` STRING COMMENT 'The job role or position of the employee at the time of acknowledgment. Helps identify which roles have been reached by the safety communication and supports role-specific safety training tracking.',
    `language_code` STRING COMMENT 'Three-letter code indicating the language in which the safety alert was presented to the employee. Ensures compliance with multilingual workforce communication requirements. [ENUM-REF-CANDIDATE: ENG|SPA|FRE|POR|CHI|VIE|KOR — 7 candidates stripped; promote to reference product]',
    `operation_type` STRING COMMENT 'The type of waste management operation the employee was working in when the acknowledgment was collected. Indicates whether the alert applies to residential collection, commercial hauling, landfill operations, Materials Recovery Facility (MRF), hazardous waste handling, Waste-to-Energy (WTE), fleet maintenance, or transfer station operations. [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|landfill|mrf|hazmat|wte|fleet_maintenance|transfer_station — 8 candidates stripped; promote to reference product]',
    `osha_compliance_flag` BOOLEAN COMMENT 'Indicates whether this acknowledgment satisfies a specific OSHA training or communication requirement. True if OSHA-mandated, false if internal safety initiative.',
    `osha_standard_reference` STRING COMMENT 'Citation of the specific OSHA standard or regulation that this safety alert addresses. Provides regulatory traceability for compliance audits and documentation.',
    `ppe_requirements_acknowledged` STRING COMMENT 'Comma-separated list of Personal Protective Equipment (PPE) requirements that were specifically acknowledged as part of this safety alert. Documents which PPE items the employee confirmed understanding of.',
    `reminder_sent_count` STRING COMMENT 'Number of reminder notifications sent to the employee before acknowledgment was completed. Tracks follow-up effort required to achieve compliance.',
    `signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a physical or digital signature was captured as part of the acknowledgment process. True if signature was obtained, false otherwise.',
    `signature_image_url` STRING COMMENT 'URL or file path to the stored signature image or digital signature artifact. Provides access to the signature evidence for audit and compliance verification.',
    `signature_timestamp` TIMESTAMP COMMENT 'Precise date and time when the signature or verification was captured. Provides legal audit trail for acknowledgment verification.',
    `signature_type` STRING COMMENT 'The type of signature or verification method used to confirm acknowledgment. Indicates whether signature was electronic, wet (physical), biometric, PIN-based, or verbal confirmation.. Valid values are `electronic|wet_signature|biometric|pin|verbal_confirmation`',
    `source_system` STRING COMMENT 'Name of the source system or application from which this acknowledgment record originated. Identifies whether record came from Enviance EHS, Workday HCM, mobile app, or other safety management system.',
    `training_credit_hours` DECIMAL(18,2) COMMENT 'Number of training credit hours awarded for acknowledging and reviewing the safety alert. Used for tracking employee training compliance and certification requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was last modified. Tracks changes to acknowledgment status, verification results, or other record updates.',
    `verification_method` STRING COMMENT 'The method used to verify employee understanding of the safety alert content. Indicates whether verification was through quiz, verbal confirmation, practical demonstration, supervisor observation, or no verification performed.. Valid values are `quiz|verbal_confirmation|demonstration|observation|none`',
    `verification_score` DECIMAL(18,2) COMMENT 'Numerical score or percentage achieved on comprehension verification assessment. Used to measure effectiveness of safety communication and identify employees requiring additional training.',
    CONSTRAINT pk_alert_acknowledgment PRIMARY KEY(`alert_acknowledgment_id`)
) COMMENT 'Transactional record capturing individual employee acknowledgment of a safety alert or safety bulletin. Links each employee to a specific safety alert, recording acknowledgment date, acknowledgment method (digital signature, paper sign-off, toolbox talk delivery), and the facility or district where acknowledgment was collected. Enables tracking of safety alert distribution effectiveness and ensures critical safety communications reach all affected personnel.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`medical_case` (
    `medical_case_id` BIGINT COMMENT 'Unique identifier for the occupational medical case record. Primary key for the medical case management system.',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Work-related injuries to drivers require direct driver link for workers compensation case management, return-to-work coordination, work restriction tracking, and driver availability planning.',
    `incident_id` BIGINT COMMENT 'Reference to the originating workplace incident that resulted in this medical case. Links to the safety incident record that triggered medical treatment.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal safety or HR professional assigned to manage this medical case and coordinate return-to-work activities.',
    `primary_medical_employee_id` BIGINT COMMENT 'Identifier of the Waste Management employee who received medical treatment for the work-related injury or illness.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Medical treatment providers must link to vendor master for workers comp cost allocation, provider network management, payment processing, 1099 reporting, and provider qualification verification. Repl',
    `related_medical_case_id` BIGINT COMMENT 'Self-referencing FK on medical_case (related_medical_case_id)',
    `actual_medical_cost` DECIMAL(18,2) COMMENT 'Total actual medical expenses incurred for treatment of this case, including all provider bills, pharmacy, and rehabilitation costs.',
    `body_part_affected` STRING COMMENT 'Specific body part or region injured or affected by the occupational illness. Used for injury trend analysis and prevention program targeting.',
    `case_closure_date` DATE COMMENT 'Date when the medical case was officially closed after the employee returned to full duty and all medical treatment was completed.',
    `case_notes` STRING COMMENT 'Free-text notes documenting case management activities, physician communications, accommodation discussions, and return-to-work coordination efforts.',
    `case_number` STRING COMMENT 'Business identifier for the medical case used for tracking and reference across systems. Externally visible case tracking number used in workers compensation coordination and case management communications.',
    `case_status` STRING COMMENT 'Current lifecycle status of the medical case indicating whether the case is actively being managed, pending closure, or has been closed.. Valid values are `open|active|closed|pending_closure|under_review|appealed`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this medical case record was first created in the case management system.',
    `diagnosis_code` STRING COMMENT 'ICD-10 or other standardized medical diagnosis code assigned by the treating provider describing the injury or illness.',
    `diagnosis_description` STRING COMMENT 'Plain language description of the diagnosed injury or illness provided by the medical professional.',
    `estimated_medical_cost` DECIMAL(18,2) COMMENT 'Projected total medical treatment cost for this case based on initial diagnosis and treatment plan. Used for workers compensation reserve setting.',
    `full_duty_return_date` DATE COMMENT 'Date when the employee was medically cleared to return to full unrestricted duty without limitations.',
    `hospitalization_duration_days` STRING COMMENT 'Number of days the employee was hospitalized as an inpatient for treatment of the work-related injury or illness.',
    `hospitalization_required_flag` BOOLEAN COMMENT 'Indicates whether the injury or illness required inpatient hospitalization. Triggers additional OSHA reporting requirements for severe injuries.',
    `initial_treatment_date` DATE COMMENT 'Date when the employee first received medical treatment for the work-related injury or illness. Critical timestamp for OSHA recordkeeping and workers compensation claim initiation.',
    `initial_treatment_time` TIMESTAMP COMMENT 'Precise timestamp when initial medical treatment was administered, including time of day for emergency response tracking.',
    `injury_nature` STRING COMMENT 'Classification of the type of physical harm or illness sustained (e.g., laceration, fracture, strain, chemical exposure, respiratory condition).',
    `osha_case_classification` STRING COMMENT 'OSHA classification category for the medical case used for OSHA 300 log reporting and regulatory compliance.. Valid values are `injury|illness|death|not_recordable`',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether this medical case meets OSHA criteria for recordability on the OSHA 300 log based on treatment type and work restrictions.',
    `physical_therapy_required_flag` BOOLEAN COMMENT 'Indicates whether ongoing physical therapy or rehabilitation was prescribed as part of the treatment plan.',
    `privacy_case_flag` BOOLEAN COMMENT 'Indicates whether this case qualifies as a privacy concern case under OSHA rules, requiring special handling of employee identity information on posted logs.',
    `return_to_work_date` DATE COMMENT 'Date when the employee returned to any work capacity following the injury or illness. May differ from full duty return date if light duty was assigned.',
    `surgery_date` DATE COMMENT 'Date when surgical procedure was performed to treat the work-related injury or illness.',
    `surgery_required_flag` BOOLEAN COMMENT 'Indicates whether surgical intervention was required to treat the injury or illness. Impacts case severity classification and cost projections.',
    `total_days_away` STRING COMMENT 'Total number of calendar days the employee was unable to work due to the injury or illness. Used for OSHA 300 log column G reporting.',
    `total_days_restricted` STRING COMMENT 'Total number of calendar days the employee worked under physician-imposed restrictions or modified duty. Used for OSHA 300 log column H and I reporting.',
    `treating_provider_type` STRING COMMENT 'Classification of the medical facility or provider type that delivered treatment to the employee.. Valid values are `occupational_clinic|emergency_room|hospital|urgent_care|primary_care|specialist`',
    `treatment_type` STRING COMMENT 'Classification of the level of medical care provided. Determines OSHA recordability and workers compensation case classification.. Valid values are `first_aid|medical_treatment|emergency_room|hospitalization|observation`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this medical case record was last modified, reflecting the most recent case status or information update.',
    `work_restriction_end_date` DATE COMMENT 'Date when work restrictions were lifted or the employee returned to full duty. Nullable for ongoing restrictions.',
    `work_restriction_start_date` DATE COMMENT 'Date when physician-imposed work restrictions or days away from work began. Used to calculate total restricted or away days for OSHA reporting.',
    `work_restriction_type` STRING COMMENT 'Classification of work limitations imposed by the treating physician. Determines OSHA 300 log column classification and return-to-work planning.. Valid values are `full_duty|light_duty|restricted_duty|days_away|modified_duty`',
    `workers_comp_claim_number` STRING COMMENT 'Claim number assigned by the workers compensation insurance carrier for this medical case. Used for coordinating medical case management with insurance claims.',
    `workers_comp_claim_status` STRING COMMENT 'Current status of the associated workers compensation insurance claim.. Valid values are `pending|approved|denied|under_review|closed|appealed`',
    CONSTRAINT pk_medical_case PRIMARY KEY(`medical_case_id`)
) COMMENT 'Occupational medical case management record for Waste Management employees who receive medical treatment following a work-related injury or illness. Captures case number, linked incident reference, treating medical provider, initial treatment date, treatment type (first aid, medical treatment beyond first aid, emergency room, hospitalization), work restriction type (full duty, light duty, restricted duty, days away from work), return-to-work date, case management status, and total days away and restricted. Supports OSHA 300 log recordkeeping and workers compensation case coordination.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` (
    `industrial_hygiene_sample_id` BIGINT COMMENT 'Unique identifier for the industrial hygiene sampling event record.',
    `combustion_operating_log_id` BIGINT COMMENT 'Foreign key linking to energy.combustion_operating_log. Business justification: IH samples correlated with combustion operating conditions (furnace temperature, feedstock type, emissions) for exposure-operations analysis. Links worker exposure data to process conditions for root ',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the sampling event occurred.',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: IH samples assess exposure for specific job positions to hazardous substances. Links sample to position enables "exposure profile by position" for similar exposure group determination and medical surv',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Industrial hygiene sampling labs must link to vendor master for payment processing, laboratory accreditation verification, cost allocation to safety programs, and vendor qualification management. Repl',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being monitored for exposure, if this is a personal sample. Null for area samples.',
    `tertiary_industrial_reviewed_by_employee_id` BIGINT COMMENT 'Identifier of the certified industrial hygienist (CIH) or EHS manager who reviewed and validated the sampling results.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: IH sampling at WTE facilities (combustion byproducts, heavy metals, particulates) tracked for facility-specific exposure monitoring, OSHA compliance, and worker health protection. Facility-level expos',
    `follow_up_industrial_hygiene_sample_id` BIGINT COMMENT 'Self-referencing FK on industrial_hygiene_sample (follow_up_industrial_hygiene_sample_id)',
    `acgih_tlv` DECIMAL(18,2) COMMENT 'The ACGIH Threshold Limit Value for the contaminant, representing recommended exposure guidelines.',
    `analysis_date` DATE COMMENT 'The date the laboratory completed the analysis of the sample.',
    `cas_number` STRING COMMENT 'The unique Chemical Abstracts Service registry number for the chemical substance being sampled, if applicable.',
    `contaminant_name` STRING COMMENT 'The specific contaminant, chemical, or hazard being measured (e.g., silica, benzene, hydrogen sulfide, noise, heat index).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this industrial hygiene sample record was first created in the system.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum detectable concentration or level for the analytical method used.',
    `equipment_serial_number` STRING COMMENT 'Serial number of the sampling equipment used, for calibration traceability.',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the measured result exceeded the applicable exposure limit (OSHA PEL or ACGIH TLV).',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'The percentage of the exposure limit that was measured, calculated as (measured_result / exposure_limit) * 100.',
    `exposure_limit_type` STRING COMMENT 'The type of exposure limit being evaluated: Time-Weighted Average (TWA), Short-Term Exposure Limit (STEL), ceiling limit, or action level.. Valid values are `TWA|STEL|ceiling|action_level`',
    `flow_rate` DECIMAL(18,2) COMMENT 'The air flow rate in liters per minute (LPM) for air sampling pumps, if applicable.',
    `hazard_category` STRING COMMENT 'The broad category of occupational hazard being measured: chemical exposure, dust/particulate, gas/vapor, noise, heat stress, biological agent, or radiation. [ENUM-REF-CANDIDATE: chemical|dust|gas|noise|heat|biological|radiation — 7 candidates stripped; promote to reference product]',
    `job_task_description` STRING COMMENT 'Description of the work task or activity being performed by the employee during sampling, if this is a personal sample.',
    `laboratory_accreditation` STRING COMMENT 'The accreditation standard held by the laboratory (e.g., AIHA LAP LLC, ISO/IEC 17025).',
    `measured_result_value` DECIMAL(18,2) COMMENT 'The quantitative result of the exposure measurement (concentration, level, or dose).',
    `notes` STRING COMMENT 'Additional notes, observations, or contextual information about the sampling event, conditions, or results.',
    `operation_type` STRING COMMENT 'The type of Waste Management operation where the sample was collected: Materials Recovery Facility (MRF), landfill, collection route, hazardous waste (hazmat) handling, transfer station, Waste-to-Energy (WTE) facility, maintenance shop, or other. [ENUM-REF-CANDIDATE: MRF|landfill|collection|hazmat|transfer_station|WTE|maintenance|other — 8 candidates stripped; promote to reference product]',
    `osha_pel` DECIMAL(18,2) COMMENT 'The OSHA Permissible Exposure Limit for the contaminant, representing the maximum allowable exposure level.',
    `ppe_worn` STRING COMMENT 'Description of personal protective equipment worn by the employee during the sampling period (e.g., respirator type, hearing protection).',
    `quantification_limit` DECIMAL(18,2) COMMENT 'The minimum quantifiable concentration or level for the analytical method used.',
    `recommended_controls` STRING COMMENT 'Industrial hygienist recommendations for exposure controls based on the sampling results (e.g., engineering controls, administrative controls, PPE upgrades).',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this sampling result must be reported to OSHA or other regulatory authorities.',
    `result_unit` STRING COMMENT 'The unit of measure for the measured result (e.g., mg/m3, ppm, dBA, WBGT, fibers/cc).',
    `review_date` DATE COMMENT 'The date the sampling results were reviewed and validated by the responsible EHS professional.',
    `sample_number` STRING COMMENT 'Business identifier for the industrial hygiene sample, typically assigned by the laboratory or EHS system.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample: collected, in transit to lab, received by lab, analyzed, reported, or voided.. Valid values are `collected|in_transit|received|analyzed|reported|voided`',
    `sample_type` STRING COMMENT 'Classification of the sample collection method: personal (breathing zone), area (fixed location), bulk (material sample), wipe (surface contamination), or direct-reading (real-time instrument).. Valid values are `personal|area|bulk|wipe|direct_reading`',
    `sample_volume_liters` DECIMAL(18,2) COMMENT 'Total volume of air sampled in liters, calculated from flow rate and duration.',
    `sampling_date` DATE COMMENT 'The date on which the industrial hygiene sample was collected.',
    `sampling_duration_minutes` STRING COMMENT 'Total duration of the sampling event in minutes, calculated from start to end timestamp.',
    `sampling_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the sampling event concluded.',
    `sampling_equipment` STRING COMMENT 'Description of the sampling equipment used (e.g., personal air sampling pump, noise dosimeter, direct-reading gas detector, heat stress monitor).',
    `sampling_location_description` STRING COMMENT 'Detailed description of the specific location within the facility or operation where the sample was collected (e.g., tipping floor, sorting line, landfill cell 5, truck cab).',
    `sampling_method` STRING COMMENT 'The standardized sampling method or protocol used (e.g., NIOSH 0600, OSHA ID-121, dosimetry per NIOSH 0500).',
    `sampling_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the sampling event began.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this industrial hygiene sample record was last modified in the system.',
    CONSTRAINT pk_industrial_hygiene_sample PRIMARY KEY(`industrial_hygiene_sample_id`)
) COMMENT 'Transactional record of industrial hygiene sampling and exposure monitoring events conducted at Waste Management facilities and operations. Captures sample ID, sampling date, facility or operation location, operation type (MRF dust, landfill gas, hazmat chemical exposure, noise dosimetry, heat stress), employee or area being sampled, contaminant or hazard being measured, sampling method and equipment, sample duration, measured result value and unit, applicable OSHA PEL or ACGIH TLV threshold, exceedance flag, and recommended controls. Supports OSHA exposure monitoring compliance.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`incentive` (
    `incentive_id` BIGINT COMMENT 'Unique identifier for the safety incentive program record. Primary key.',
    `district_id` BIGINT COMMENT 'Identifier of the operational district where this incentive program is applicable. Null if program is company-wide.',
    `facility_id` BIGINT COMMENT 'Identifier of the specific facility where this incentive program is applicable. Null if program applies to multiple facilities or district-wide.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the safety incentive program (typically a senior safety leader or executive).',
    `incentive_program_coordinator_employee_id` BIGINT COMMENT 'Identifier of the employee who coordinates day-to-day administration of the safety incentive program.',
    `incentive_program_owner_employee_id` BIGINT COMMENT 'Identifier of the employee who owns and is accountable for the safety incentive program (typically a safety manager or director).',
    `parent_incentive_id` BIGINT COMMENT 'Self-referencing FK on incentive (parent_incentive_id)',
    `applicable_facility_types` STRING COMMENT 'Comma-separated list of facility types where this incentive program applies (e.g., transfer station, landfill, MRF, maintenance facility, administrative office).',
    `applicable_operation_types` STRING COMMENT 'Comma-separated list of operation types eligible for this incentive program (e.g., residential collection, commercial collection, landfill, MRF, hazmat, fleet maintenance, WTE).',
    `approval_date` DATE COMMENT 'Date when the safety incentive program was officially approved by management or safety committee.',
    `award_description` STRING COMMENT 'Detailed description of the award or recognition provided (e.g., gift card, plaque, certificate, paid time off, public recognition).',
    `award_frequency` STRING COMMENT 'Frequency at which awards are distributed under this program (monthly, quarterly, semi-annual, annual, milestone-based, continuous).. Valid values are `monthly|quarterly|semi_annual|annual|milestone_based|continuous`',
    `award_value` DECIMAL(18,2) COMMENT 'Monetary value of the incentive award in US dollars (USD). Null for non-monetary recognition programs.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for this safety incentive program in US dollars (USD) for the program period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety incentive program record was first created in the system.',
    `days_without_injury_threshold` STRING COMMENT 'Minimum number of consecutive days without a recordable injury required to qualify for the incentive award.',
    `effective_date` DATE COMMENT 'Date when the safety incentive program became or will become active and operational.',
    `eligibility_criteria` STRING COMMENT 'Detailed description of the criteria employees or teams must meet to qualify for the incentive (e.g., days without recordable injury, observation participation rate, training completion percentage).',
    `expiration_date` DATE COMMENT 'Date when the safety incentive program is scheduled to expire or be reviewed for renewal. Null for ongoing programs.',
    `incentive_type` STRING COMMENT 'Classification of the incentive program type indicating the recognition mechanism (milestone award, peer recognition, safety bonus, team recognition, individual achievement, department award).. Valid values are `milestone_award|peer_recognition|safety_bonus|team_recognition|individual_achievement|department_award`',
    `last_review_date` DATE COMMENT 'Date when the safety incentive program was last reviewed for effectiveness and compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the safety incentive program effectiveness and compliance.',
    `observation_participation_rate_threshold` DECIMAL(18,2) COMMENT 'Minimum percentage of required safety observations that must be completed to qualify for the incentive (expressed as percentage, e.g., 85.00 for 85%).',
    `osha_vpp_aligned_flag` BOOLEAN COMMENT 'Indicates whether this incentive program is aligned with OSHA Voluntary Protection Programs (VPP) guidelines and best practices.',
    `program_code` STRING COMMENT 'Unique business identifier code for the safety incentive program used for external reference and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_document_url` STRING COMMENT 'URL or file path to the official program documentation, guidelines, and terms and conditions.',
    `program_name` STRING COMMENT 'Descriptive name of the safety incentive program (e.g., Zero Injury Milestone Award, Safety Champion Recognition).',
    `program_notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the safety incentive program administration or eligibility.',
    `program_period_end_date` DATE COMMENT 'End date of the incentive program period. Null for ongoing programs without a defined end date.',
    `program_period_start_date` DATE COMMENT 'Start date of the incentive program period during which performance is measured for award eligibility.',
    `program_status` STRING COMMENT 'Current lifecycle status of the safety incentive program indicating whether it is currently operational.. Valid values are `active|inactive|suspended|planned|closed`',
    `reporting_discouraged_flag` BOOLEAN COMMENT 'Flag indicating whether this program has been reviewed and confirmed NOT to discourage injury or illness reporting, in compliance with OSHA anti-retaliation requirements.',
    `source_system` STRING COMMENT 'Name of the source system from which this safety incentive program record originated (e.g., SAP EHS, Enviance, custom safety management system).',
    `total_awards_issued` STRING COMMENT 'Cumulative count of awards issued under this program since inception.',
    `total_participants` STRING COMMENT 'Total number of employees or teams currently participating in or eligible for this safety incentive program.',
    `training_completion_threshold` DECIMAL(18,2) COMMENT 'Minimum percentage of required safety training courses that must be completed to qualify for the incentive (expressed as percentage, e.g., 100.00 for 100%).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety incentive program record was last modified in the system.',
    CONSTRAINT pk_incentive PRIMARY KEY(`incentive_id`)
) COMMENT 'Master record for safety incentive and recognition programs operated by Waste Management to promote safe behaviors and reward safety performance milestones. Captures program ID, program name, incentive type (milestone award, peer recognition, safety bonus, team recognition), eligibility criteria (days without recordable injury, observation participation rate, training completion), award value or description, program period, applicable operation type or district, and program status. Supports safety culture development and employee engagement in safety programs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` (
    `emergency_action_plan_id` BIGINT COMMENT 'Unique identifier for the Emergency Action Plan record. Primary key for the emergency action plan entity.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility (landfill, MRF, transfer station, hazmat facility, or administrative office) for which this Emergency Action Plan is established.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Emergency action plans for permitted facilities must incorporate permit-specific emergency procedures (spill response, air emission event protocols, fire suppression). Required by RCRA Part B permits ',
    `primary_emergency_coordinator_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Emergency action plans are tailored to waste streams handled at facility (hazmat spill response for chemical waste, biohazard containment for medical waste). Facility managers develop stream-specific ',
    `quaternary_emergency_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee (typically facility manager, safety manager, or regional operations director) who formally approved this Emergency Action Plan version for implementation.',
    `tertiary_emergency_alternate_coordinator_employee_id` BIGINT COMMENT 'Reference to the employee designated as the alternate or backup Emergency Coordinator who assumes responsibility when the primary coordinator is unavailable.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Facility-specific emergency action plans for WTE operations (fire, explosion, chemical release) required by OSHA 1910.38. Facility-level plans reflect site-specific hazards, evacuation routes, and eme',
    `superseded_emergency_action_plan_id` BIGINT COMMENT 'Self-referencing FK on emergency_action_plan (superseded_emergency_action_plan_id)',
    `alarm_system_description` STRING COMMENT 'Description of the alarm or notification system used to alert employees of an emergency, including type (audible horn, siren, PA system, text alert), location of alarm devices, and distinctive signals for different emergency types.',
    `approval_date` DATE COMMENT 'Date on which this Emergency Action Plan version was formally approved by management and authorized for implementation at the facility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this Emergency Action Plan record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_operations_shutdown` STRING COMMENT 'Procedures for shutting down critical plant operations and equipment before evacuation to prevent additional hazards, such as securing landfill gas collection systems, shutting down MRF conveyors, isolating hazmat storage, or securing waste-to-energy boilers.',
    `drill_frequency_months` STRING COMMENT 'Required frequency for conducting emergency drills at this facility, expressed in months (e.g., 12 for annual, 6 for semi-annual, 3 for quarterly). Driven by regulatory requirements and facility risk profile.',
    `effective_date` DATE COMMENT 'Date on which this Emergency Action Plan becomes the official, enforceable plan for the facility. All employees must be trained on the plan by this date.',
    `emergency_contact_list` STRING COMMENT 'Comprehensive list of emergency contacts including local fire department, police, EMS, hospital, poison control, hazmat response team, EPA regional office, state environmental agency, utility companies, and internal corporate emergency response. Includes names, phone numbers, and addresses.',
    `emergency_types_covered` STRING COMMENT 'Comma-separated list of emergency scenarios addressed in this plan, such as fire, chemical spill, medical emergency, severe weather (tornado, hurricane, flood), active threat, hazardous material release, equipment failure, gas leak, explosion, or natural disaster. Defines the scope of preparedness.',
    `employee_roles_responsibilities` STRING COMMENT 'Detailed description of roles and responsibilities assigned to employees during an emergency, including floor wardens, evacuation assistants, first aid responders, equipment shutdown personnel, and headcount coordinators. Defines who does what during emergency response.',
    `employee_training_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of employees at the facility who have completed required training on the current version of the Emergency Action Plan. Used to track compliance and readiness. Target is 100 percent.',
    `evacuation_procedures` STRING COMMENT 'Detailed description of evacuation procedures including routes, exits, assembly points, accountability processes, and special considerations for different facility areas (e.g., landfill cell, MRF processing floor, hazmat storage area).',
    `expiration_date` DATE COMMENT 'Date on which this Emergency Action Plan expires and must be reviewed, updated, and reissued. Typically set based on regulatory review frequency or facility operational changes.',
    `facility_map_url` STRING COMMENT 'URL or file path to the facility map showing evacuation routes, exits, assembly points, emergency equipment locations (fire extinguishers, AEDs, eyewash stations), and hazardous material storage areas.',
    `hazmat_specific_procedures` STRING COMMENT 'Special emergency procedures for facilities handling hazardous waste, including spill containment, leak isolation, vapor monitoring, decontamination protocols, and coordination with RCRA-certified hazmat response teams.',
    `last_drill_date` DATE COMMENT 'Date of the most recent emergency evacuation drill or tabletop exercise conducted at the facility to test the Emergency Action Plan and employee preparedness.',
    `last_review_date` DATE COMMENT 'Date on which the Emergency Action Plan was last reviewed and validated for accuracy, completeness, and alignment with current facility operations, staffing, and regulatory requirements.',
    `medical_emergency_procedures` STRING COMMENT 'Procedures for responding to medical emergencies including location of first aid kits, AED devices, eyewash stations, safety showers, and protocols for calling EMS and transporting injured employees to medical facilities.',
    `next_drill_date` DATE COMMENT 'Date scheduled for the next emergency evacuation drill or tabletop exercise. OSHA recommends annual drills at minimum; some facilities conduct quarterly drills.',
    `next_review_date` DATE COMMENT 'Date scheduled for the next comprehensive review and update of the Emergency Action Plan. OSHA requires review whenever the plan is initially developed, whenever employee responsibilities change, and whenever new equipment or hazards are introduced.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this Emergency Action Plan, such as facility-specific hazards, recent updates, lessons learned from drills, or pending revisions.',
    `osha_standard_citation` STRING COMMENT 'Specific OSHA standard citation(s) that this Emergency Action Plan is designed to comply with, typically 29 CFR 1910.38 (Emergency Action Plans) and may include 29 CFR 1910.120 (HAZWOPER) for hazmat facilities.',
    `plan_document_url` STRING COMMENT 'URL or file path to the complete Emergency Action Plan document stored in the document management system. Provides access to the full plan including maps, diagrams, contact lists, and detailed procedures.',
    `plan_number` STRING COMMENT 'Business identifier for the Emergency Action Plan, typically formatted as facility code plus version sequence (e.g., LF-001-EAP-2024-V3). Used for external reference and regulatory reporting.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the Emergency Action Plan indicating whether it is in draft, actively in force, under review for updates, expired and requiring renewal, superseded by a newer version, or archived for historical record.. Valid values are `draft|active|under_review|expired|superseded|archived`',
    `plan_version` STRING COMMENT 'Version identifier for the Emergency Action Plan document, incremented with each revision or update to track plan evolution and ensure current version is in use.',
    `ppe_requirements` STRING COMMENT 'Specification of PPE required for emergency response personnel, including respirators, chemical suits, gloves, boots, and eye protection. Defines what equipment must be available and who is trained to use it.',
    `primary_assembly_point` STRING COMMENT 'Designated primary location where all employees must gather after evacuating the facility for headcount and accountability. Typically a safe distance from the facility with clear visibility and access.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority governing emergency preparedness requirements for this facility, such as OSHA for occupational safety, EPA for environmental emergencies, state environmental agencies, local fire marshal, or DOT for transportation facilities.. Valid values are `OSHA|EPA|state_environmental|local_fire_marshal|DOT|multiple`',
    `rescue_non_rescue_duties` STRING COMMENT 'Specification of which employees, if any, are assigned rescue or medical duties during emergencies, and which employees are prohibited from rescue activities and must evacuate immediately. Critical for OSHA compliance and employee safety.',
    `review_frequency_months` STRING COMMENT 'Required frequency for comprehensive review and update of the Emergency Action Plan, expressed in months. Typically 12 months (annual) but may be more frequent for high-hazard facilities or after significant operational changes.',
    `secondary_assembly_point` STRING COMMENT 'Alternate assembly location to be used if the primary assembly point is inaccessible or unsafe due to the nature or location of the emergency (e.g., wind direction for chemical release, fire spread).',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training on this Emergency Action Plan is required for all employees at the facility. OSHA mandates training for all employees covered by the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this Emergency Action Plan record was last modified in the system. Used for audit trail and change tracking.',
    CONSTRAINT pk_emergency_action_plan PRIMARY KEY(`emergency_action_plan_id`)
) COMMENT 'Master record for facility-level Emergency Action Plans (EAPs) required under OSHA 29 CFR 1910.38 for each Waste Management facility. Captures plan ID, facility reference, plan version, effective date, emergency types covered (fire, chemical spill, medical emergency, severe weather, active threat), evacuation routes and assembly points, emergency contact list, employee roles and responsibilities, alarm system description, last drill date, and plan review date. Provides the authoritative emergency preparedness documentation for each operational site.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_parent_safety_program_id` FOREIGN KEY (`parent_safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_superseded_jha_id` FOREIGN KEY (`superseded_jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ADD CONSTRAINT `fk_safety_jha_step_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ADD CONSTRAINT `fk_safety_jha_step_parent_jha_step_id` FOREIGN KEY (`parent_jha_step_id`) REFERENCES `waste_management_ecm`.`safety`.`jha_step`(`jha_step_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_follow_up_observation_id` FOREIGN KEY (`follow_up_observation_id`) REFERENCES `waste_management_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_related_incident_id` FOREIGN KEY (`related_incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_supplemental_incident_investigation_id` FOREIGN KEY (`supplemental_incident_investigation_id`) REFERENCES `waste_management_ecm`.`safety`.`incident_investigation`(`incident_investigation_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_originating_corrective_action_id` FOREIGN KEY (`originating_corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_recurrence_osha_recordable_id` FOREIGN KEY (`recurrence_osha_recordable_id`) REFERENCES `waste_management_ecm`.`safety`.`osha_recordable`(`osha_recordable_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_replaced_ppe_issuance_id` FOREIGN KEY (`replaced_ppe_issuance_id`) REFERENCES `waste_management_ecm`.`safety`.`ppe_issuance`(`ppe_issuance_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_replacement_ppe_issuance_id` FOREIGN KEY (`replacement_ppe_issuance_id`) REFERENCES `waste_management_ecm`.`safety`.`ppe_issuance`(`ppe_issuance_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ADD CONSTRAINT `fk_safety_meeting_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ADD CONSTRAINT `fk_safety_meeting_follow_up_meeting_id` FOREIGN KEY (`follow_up_meeting_id`) REFERENCES `waste_management_ecm`.`safety`.`meeting`(`meeting_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ADD CONSTRAINT `fk_safety_meeting_attendance_meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `waste_management_ecm`.`safety`.`meeting`(`meeting_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ADD CONSTRAINT `fk_safety_meeting_attendance_proxy_meeting_attendance_id` FOREIGN KEY (`proxy_meeting_attendance_id`) REFERENCES `waste_management_ecm`.`safety`.`meeting_attendance`(`meeting_attendance_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_follow_up_audit_id` FOREIGN KEY (`follow_up_audit_id`) REFERENCES `waste_management_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `waste_management_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `waste_management_ecm`.`safety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_parent_audit_finding_id` FOREIGN KEY (`parent_audit_finding_id`) REFERENCES `waste_management_ecm`.`safety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_parent_hazard_register_id` FOREIGN KEY (`parent_hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ADD CONSTRAINT `fk_safety_safety_training_record_refresher_safety_training_record_id` FOREIGN KEY (`refresher_safety_training_record_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_training_record`(`safety_training_record_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_related_near_miss_id` FOREIGN KEY (`related_near_miss_id`) REFERENCES `waste_management_ecm`.`safety`.`near_miss`(`near_miss_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_superseded_lockout_tagout_procedure_id` FOREIGN KEY (`superseded_lockout_tagout_procedure_id`) REFERENCES `waste_management_ecm`.`safety`.`lockout_tagout_procedure`(`lockout_tagout_procedure_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_lockout_tagout_procedure_id` FOREIGN KEY (`lockout_tagout_procedure_id`) REFERENCES `waste_management_ecm`.`safety`.`lockout_tagout_procedure`(`lockout_tagout_procedure_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_reversal_loto_execution_id` FOREIGN KEY (`reversal_loto_execution_id`) REFERENCES `waste_management_ecm`.`safety`.`loto_execution`(`loto_execution_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_osha_recordable_id` FOREIGN KEY (`osha_recordable_id`) REFERENCES `waste_management_ecm`.`safety`.`osha_recordable`(`osha_recordable_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_primary_superseded_by_alert_id` FOREIGN KEY (`primary_superseded_by_alert_id`) REFERENCES `waste_management_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_superseded_alert_id` FOREIGN KEY (`superseded_alert_id`) REFERENCES `waste_management_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ADD CONSTRAINT `fk_safety_alert_acknowledgment_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `waste_management_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ADD CONSTRAINT `fk_safety_alert_acknowledgment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ADD CONSTRAINT `fk_safety_alert_acknowledgment_prior_alert_acknowledgment_id` FOREIGN KEY (`prior_alert_acknowledgment_id`) REFERENCES `waste_management_ecm`.`safety`.`alert_acknowledgment`(`alert_acknowledgment_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ADD CONSTRAINT `fk_safety_medical_case_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ADD CONSTRAINT `fk_safety_medical_case_related_medical_case_id` FOREIGN KEY (`related_medical_case_id`) REFERENCES `waste_management_ecm`.`safety`.`medical_case`(`medical_case_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_follow_up_industrial_hygiene_sample_id` FOREIGN KEY (`follow_up_industrial_hygiene_sample_id`) REFERENCES `waste_management_ecm`.`safety`.`industrial_hygiene_sample`(`industrial_hygiene_sample_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ADD CONSTRAINT `fk_safety_incentive_parent_incentive_id` FOREIGN KEY (`parent_incentive_id`) REFERENCES `waste_management_ecm`.`safety`.`incentive`(`incentive_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_superseded_emergency_action_plan_id` FOREIGN KEY (`superseded_emergency_action_plan_id`) REFERENCES `waste_management_ecm`.`safety`.`emergency_action_plan`(`emergency_action_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`safety` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `waste_management_ecm`.`safety` SET TAGS ('dbx_domain' = 'safety');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program ID');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `primary_safety_coordinator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Coordinator Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `primary_safety_coordinator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `primary_safety_coordinator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `parent_safety_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `applicable_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `applicable_operation_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Operation Types');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Program Approval Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Budget Amount');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Program Compliance Score');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Document URL');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `incident_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Program Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `medical_surveillance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Surveillance Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `medical_surveillance_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `medical_surveillance_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Program Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `non_compliance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Count');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `objectives` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Objectives');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `ppe_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `ppe_types_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Types Required');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Code');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Description');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Name');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Status');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Under Development|Under Review|Suspended|Archived');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Type');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'OSHA Mandated|Internal Voluntary|Industry Best Practice|Client Required|State Mandated|DOT Required');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period in Years');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `recordkeeping_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recordkeeping Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Enviance EHS|SAP EHS|Manual Entry|Legacy System');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency in Months');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Version');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` SET TAGS ('dbx_subdomain' = 'hazard_assessment');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis (JHA) Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Service Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `superseded_jha_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `administrative_controls` SET TAGS ('dbx_business_glossary_term' = 'Administrative Controls');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `crew_size_required` SET TAGS ('dbx_business_glossary_term' = 'Crew Size Required');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `emergency_procedures` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procedures');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `engineering_controls` SET TAGS ('dbx_business_glossary_term' = 'Engineering Controls');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Minutes');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `frequency_of_task` SET TAGS ('dbx_business_glossary_term' = 'Frequency of Task');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `frequency_of_task` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `incident_history_count` SET TAGS ('dbx_business_glossary_term' = 'Incident History Count');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_number` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis (JHA) Number');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_number` SET TAGS ('dbx_value_regex' = '^JHA-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_status` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis (JHA) Status');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `jha_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|expired|archived');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `job_task_description` SET TAGS ('dbx_business_glossary_term' = 'Job Task Description');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `job_task_name` SET TAGS ('dbx_business_glossary_term' = 'Job Task Name');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'collection|landfill|mrf|hazmat|transfer_station|wte');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `pre_task_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Task Inspection Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `required_ppe` SET TAGS ('dbx_business_glossary_term' = 'Required Personal Protective Equipment (PPE)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ALTER COLUMN `training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Training Requirements');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` SET TAGS ('dbx_subdomain' = 'hazard_assessment');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `jha_step_id` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis (JHA) Step Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis (JHA) Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Required Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `parent_jha_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `control_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy of Controls Classification');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `control_hierarchy` SET TAGS ('dbx_value_regex' = 'elimination|substitution|engineering_controls|administrative_controls|ppe');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `control_measure` SET TAGS ('dbx_business_glossary_term' = 'Control Measure');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `emergency_response_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedure');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `environmental_condition` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `frequency_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Frequency Per Shift');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `incident_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident History Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'confined_space|hot_work|excavation|lockout_tagout|elevated_work|none');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `probability_rating` SET TAGS ('dbx_business_glossary_term' = 'Hazard Probability Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `probability_rating` SET TAGS ('dbx_value_regex' = 'frequent|probable|occasional|remote|improbable');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Reference');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Hazard Severity Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'catastrophic|critical|moderate|minor|negligible');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Step Description');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `step_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Step Duration in Minutes');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `step_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'active|under_review|revised|obsolete');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ALTER COLUMN `worker_count` SET TAGS ('dbx_business_glossary_term' = 'Worker Count');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Collection System Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_observed_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Observed Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_observed_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_observed_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_observer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Observer Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_observer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_observer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Observed Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Observed Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Observed Crew ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `follow_up_observation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `bbs_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Behavior-Based Safety (BBS) Program Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `behavior_description` SET TAGS ('dbx_business_glossary_term' = 'Behavior Description');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `corrective_feedback_provided` SET TAGS ('dbx_business_glossary_term' = 'Corrective Feedback Provided');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `feedback_description` SET TAGS ('dbx_business_glossary_term' = 'Feedback Description');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_business_glossary_term' = 'Observation Category');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_value_regex' = 'safe_behavior|at_risk_behavior|near_miss|unsafe_condition|positive_recognition|hazard_identification');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Date');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_number` SET TAGS ('dbx_business_glossary_term' = 'Observation Number');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_number` SET TAGS ('dbx_value_regex' = '^OBS-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_value_regex' = 'open|pending_review|action_assigned|in_progress|closed|cancelled');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_time` SET TAGS ('dbx_business_glossary_term' = 'Observation Time');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_value_regex' = 'behavioral|environmental|equipment|procedural|ppe_compliance|ergonomic');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_business_glossary_term' = 'Observer Name');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_business_glossary_term' = 'Observer Role');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_value_regex' = 'supervisor|safety_manager|peer_observer|operations_manager|site_manager|ehs_specialist');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `photo_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Count');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `ppe_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `ppe_deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Deficiency Description');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'enviance_ehs|mobile_safety_app|workday_hcm|manual_entry');
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_investigator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Employee Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_investigator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_investigator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Involved Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Collection System Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `rng_processing_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Rng Processing Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `srf_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Srf Production Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `related_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Incident Classification');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'injury|illness|near_miss|property_damage|vehicle_accident|environmental_release');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `corrective_actions_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Description');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `corrective_actions_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `days_of_restricted_work` SET TAGS ('dbx_business_glossary_term' = 'Days of Restricted Work');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `employee_job_title` SET TAGS ('dbx_business_glossary_term' = 'Employee Job Title');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `illness_type` SET TAGS ('dbx_business_glossary_term' = 'Illness Type');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `illness_type` SET TAGS ('dbx_value_regex' = 'respiratory|skin_disorder|poisoning|hearing_loss|other_illness');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_review|closed');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `osha_recordability_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordability Determination Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `ppe_adequate_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Adequate Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `ppe_in_use` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) In Use');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'fatality|lost_time|restricted_work|medical_treatment|first_aid|near_miss');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_value_regex' = '^WC-[A-Z0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Report Document ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `supplemental_incident_investigation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Rate');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `corrective_actions_assigned` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Assigned');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `environmental_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Environmental Factors Identified');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `equipment_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Equipment Factors Identified');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `equipment_inspection_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inspection Conducted Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `human_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Human Factors Identified');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `immediate_causes` SET TAGS ('dbx_business_glossary_term' = 'Immediate Causes');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Investigation Duration Days');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings Summary');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_method` SET TAGS ('dbx_business_glossary_term' = 'Investigation Method');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|pending_review|completed|closed');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_team_members` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team Members');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'root_cause_analysis|preliminary|comprehensive|follow_up');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `lead_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator Name');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `management_system_gaps` SET TAGS ('dbx_business_glossary_term' = 'Management System Gaps');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'waste_collection|landfill|mrf|hazmat|fleet_maintenance|transfer_station');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `photographic_evidence_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Photographic Evidence Collected Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `preventive_measures_recommended` SET TAGS ('dbx_business_glossary_term' = 'Preventive Measures Recommended');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `reviewed_by_operations_manager_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed by Operations Manager Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `reviewed_by_safety_manager_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed by Safety Manager Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'human_factors|equipment_failure|environmental_conditions|management_system_failure|procedural_gap|training_deficiency');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `site_inspection_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Inspection Conducted Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ALTER COLUMN `witness_statements_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Statements Collected Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `quaternary_corrective_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `quaternary_corrective_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `quaternary_corrective_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `quinary_corrective_responsible_party_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `originating_corrective_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_category` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Category');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_category` SET TAGS ('dbx_value_regex' = 'engineering_control|administrative_control|ppe|training|procedure_update|equipment_repair');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (USD)');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly_effective|effective|partially_effective|ineffective|not_yet_assessed');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `preventive_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `root_cause_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Completed Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|human_error|procedure_inadequate|training_gap|environmental_factor|management_system');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `source_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Event Reference Number');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `source_event_type` SET TAGS ('dbx_business_glossary_term' = 'Source Event Type');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `source_event_type` SET TAGS ('dbx_value_regex' = 'incident|observation|audit|inspection|near_miss|hazard_report');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|audit|observation|documentation_review|testing|training_completion');
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_recordable_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable ID');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `recurrence_osha_recordable_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'OSHA Case Status');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|closed|under_review|pending_classification');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `days_of_job_transfer_or_restriction` SET TAGS ('dbx_business_glossary_term' = 'Days of Job Transfer or Restriction');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `death_flag` SET TAGS ('dbx_business_glossary_term' = 'Death Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `establishment_name` SET TAGS ('dbx_business_glossary_term' = 'Establishment Name');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `event_exposure_type` SET TAGS ('dbx_business_glossary_term' = 'Event or Exposure Type');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `injury_illness_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Injury or Illness Onset');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `injury_illness_description` SET TAGS ('dbx_business_glossary_term' = 'Description of Injury or Illness');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `injury_illness_time` SET TAGS ('dbx_business_glossary_term' = 'Time of Injury or Illness Onset');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Nature of Injury');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Employee Job Title');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `location_where_event_occurred` SET TAGS ('dbx_business_glossary_term' = 'Location Where Event Occurred');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `loss_of_consciousness_flag` SET TAGS ('dbx_business_glossary_term' = 'Loss of Consciousness Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `medical_treatment_beyond_first_aid_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Beyond First Aid Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `medical_treatment_beyond_first_aid_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `medical_treatment_beyond_first_aid_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_300a_reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) 300A Reporting Year');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_case_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Case Number');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_case_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_case_type` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Case Type');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_case_type` SET TAGS ('dbx_value_regex' = 'injury|skin_disorder|respiratory_condition|poisoning|hearing_loss|all_other_illnesses');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `physician_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Physician Recommendation Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `ppe_used` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Used');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `privacy_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Case Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `recordable_determination_by` SET TAGS ('dbx_business_glossary_term' = 'Recordable Determination Made By');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `recordable_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Recordable Determination Date');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `remained_at_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Remained at Work Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `source_of_injury` SET TAGS ('dbx_business_glossary_term' = 'Source of Injury or Illness');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treating_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Treating Physician Name');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treating_physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Facility Name');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ALTER COLUMN `work_process_at_time_of_incident` SET TAGS ('dbx_business_glossary_term' = 'Work Process at Time of Incident');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `ppe_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Issuance ID');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `replaced_ppe_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced PPE Issuance ID');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `replacement_ppe_issuance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Condition');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'new|refurbished|reconditioned');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_acknowledgment_signature` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Signature');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `expected_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Replacement Date');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `fit_test_date` SET TAGS ('dbx_business_glossary_term' = 'Fit Test Date');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `fit_test_result` SET TAGS ('dbx_business_glossary_term' = 'Fit Test Result');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `fit_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_number` SET TAGS ('dbx_business_glossary_term' = 'PPE Issuance Number');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_number` SET TAGS ('dbx_value_regex' = '^PPE-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_reason` SET TAGS ('dbx_business_glossary_term' = 'Issuance Reason');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issuance Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuing_location_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Location Name');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `ppe_category` SET TAGS ('dbx_business_glossary_term' = 'PPE Category');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Return Condition');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `return_condition` SET TAGS ('dbx_value_regex' = 'good|worn|damaged|lost|destroyed');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `return_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Size');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|pair|set|box|case');
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Meeting ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Presenter Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `follow_up_meeting_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `action_items_identified` SET TAGS ('dbx_business_glossary_term' = 'Action Items Identified');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `attendance_verified` SET TAGS ('dbx_business_glossary_term' = 'Attendance Verified');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `completion_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Completion Verified By');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `dot_training_topic` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Training Topic');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting End Time');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `hazard_categories_addressed` SET TAGS ('dbx_business_glossary_term' = 'Hazard Categories Addressed');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `incident_related` SET TAGS ('dbx_business_glossary_term' = 'Incident Related');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `materials_description` SET TAGS ('dbx_business_glossary_term' = 'Materials Description');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `meeting_number` SET TAGS ('dbx_business_glossary_term' = 'Meeting Number');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_business_glossary_term' = 'Meeting Status');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|rescheduled');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Type');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Meeting Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `osha_compliance_topic` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Compliance Topic');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `ppe_requirements_discussed` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements Discussed');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `presenter_name` SET TAGS ('dbx_business_glossary_term' = 'Presenter Name');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `presenter_title` SET TAGS ('dbx_business_glossary_term' = 'Presenter Title');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `questions_raised` SET TAGS ('dbx_business_glossary_term' = 'Questions Raised');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `rcra_training_topic` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Training Topic');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `safety_topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Safety Topics Covered');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting Start Time');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `topic` SET TAGS ('dbx_business_glossary_term' = 'Meeting Topic');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `training_materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Provided');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `meeting_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Meeting Attendance ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Meeting ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `proxy_meeting_attendance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `attendance_date` SET TAGS ('dbx_business_glossary_term' = 'Attendance Date');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `attendance_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Attendance Duration in Minutes');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `attendance_method` SET TAGS ('dbx_business_glossary_term' = 'Attendance Method');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `attendance_method` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid|recorded');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `attendance_notes` SET TAGS ('dbx_business_glossary_term' = 'Attendance Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'present|absent|excused|late');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `cdl_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Holder Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|incomplete|partial|pending_verification');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'tablet|mobile|desktop|paper');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `job_role_code` SET TAGS ('dbx_business_glossary_term' = 'Job Role Code');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `signature_type` SET TAGS ('dbx_business_glossary_term' = 'Signature Type');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `signature_type` SET TAGS ('dbx_value_regex' = 'digital|physical|electronic|verbal');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `training_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Credit Hours');
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` SET TAGS ('dbx_subdomain' = 'hazard_assessment');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit ID');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor ID');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^SA-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|closed|cancelled');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'facility_walkthrough|operational_audit|program_compliance_audit|pre_task_inspection|vehicle_inspection|ppe_audit');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Audit End Time');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `equipment_condition_verified` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition Verified');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `overall_audit_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Score');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `positive_observations_count` SET TAGS ('dbx_business_glossary_term' = 'Positive Observations Count');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `ppe_compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'PPE (Personal Protective Equipment) Compliance Verified');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Audit Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory|critical');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `report_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Time');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `training_compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Training Compliance Verified');
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'hazard_assessment');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `parent_audit_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `confined_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `fall_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Fall Protection Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'unsafe_act|unsafe_condition|program_gap|regulatory_non_conformance|documentation_deficiency|training_deficiency');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|assigned|in_progress|pending_verification|closed|overdue');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `lockout_tagout_flag` SET TAGS ('dbx_business_glossary_term' = 'Lockout Tagout (LOTO) Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `machine_guarding_flag` SET TAGS ('dbx_business_glossary_term' = 'Machine Guarding Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `operation_area` SET TAGS ('dbx_business_glossary_term' = 'Operation Area');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `ppe_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Deficiency Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'physical_inspection|document_review|employee_interview|photographic_evidence|measurement|testing');
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` SET TAGS ('dbx_subdomain' = 'hazard_assessment');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register ID');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Identified By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `parent_hazard_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `administrative_controls` SET TAGS ('dbx_business_glossary_term' = 'Administrative Controls');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `control_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Control Adequacy Status');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `control_adequacy_status` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|under_review|improvement_required');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `engineering_controls` SET TAGS ('dbx_business_glossary_term' = 'Engineering Controls');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `exposure_frequency` SET TAGS ('dbx_business_glossary_term' = 'Exposure Frequency');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `exposure_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|occasional|rare');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_code` SET TAGS ('dbx_business_glossary_term' = 'Hazard Code');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_code` SET TAGS ('dbx_value_regex' = '^HAZ-[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_name` SET TAGS ('dbx_business_glossary_term' = 'Hazard Name');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_register_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Status');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_register_status` SET TAGS ('dbx_value_regex' = 'active|mitigated|eliminated|under_investigation|archived');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_source` SET TAGS ('dbx_business_glossary_term' = 'Hazard Source');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Hazard Subcategory');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `incident_history_count` SET TAGS ('dbx_business_glossary_term' = 'Incident History Count');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Level');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Severity Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Date');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Severity Rating');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `risk_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Status');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `risk_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|not_accepted|conditional|pending_review');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ALTER COLUMN `work_area_location` SET TAGS ('dbx_business_glossary_term' = 'Work Area Location');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `safety_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Record ID');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `refresher_safety_training_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `applicable_job_roles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Roles');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `applicable_operation_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Operation Types');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score Percentage');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `attendance_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Attendance Verification Method');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `attendance_verification_method` SET TAGS ('dbx_value_regex' = 'sign_in_sheet|electronic_badge|biometric|supervisor_confirmation|online_tracking');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Training Record Comments');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'passed|failed|incomplete|in_progress|waived');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|field_demonstration|tailgate|simulator|blended');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `dot_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Required Training Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `epa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Required Training Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `hazard_categories_covered` SET TAGS ('dbx_business_glossary_term' = 'Hazard Categories Covered');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `next_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Training Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold Percentage');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `ppe_topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Topics Covered');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period Years');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Citation');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_cost_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_course_name` SET TAGS ('dbx_business_glossary_term' = 'Training Course Name');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_document_url` SET TAGS ('dbx_business_glossary_term' = 'Training Document URL');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Provided');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'initial|refresher|recertification|remedial|advanced|specialized');
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `near_miss_id` SET TAGS ('dbx_business_glossary_term' = 'Near Miss ID');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Collection System Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program ID');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `tertiary_near_corrective_action_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `tertiary_near_corrective_action_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `tertiary_near_corrective_action_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `related_near_miss_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'safety_meeting|toolbox_talk|email|bulletin_board|training_session|all_hands');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `corrective_action_complete_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Complete Date');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `equipment_involved` SET TAGS ('dbx_business_glossary_term' = 'Equipment Involved');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `investigation_complete_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Complete Date');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|investigation_complete|closed');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `near_miss_description` SET TAGS ('dbx_business_glossary_term' = 'Near Miss Description');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `near_miss_number` SET TAGS ('dbx_business_glossary_term' = 'Near Miss Number');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `osha_recordable_potential_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA (Occupational Safety and Health Administration) Recordable Potential Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `potential_injury_type` SET TAGS ('dbx_business_glossary_term' = 'Potential Injury Type');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `potential_severity` SET TAGS ('dbx_business_glossary_term' = 'Potential Severity');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `potential_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|serious|catastrophic');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `ppe_adequate_flag` SET TAGS ('dbx_business_glossary_term' = 'PPE (Personal Protective Equipment) Adequate Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `ppe_in_use` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) In Use');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|weekend');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `supervisor_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Notified Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ALTER COLUMN `work_activity` SET TAGS ('dbx_business_glossary_term' = 'Work Activity');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `lockout_tagout_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Procedure ID');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `air_pollution_control_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Collection System Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Required Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `rng_processing_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Rng Processing Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `srf_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Srf Production Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `superseded_lockout_tagout_procedure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `authorized_employee_roles` SET TAGS ('dbx_business_glossary_term' = 'Authorized Employee Roles');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `diagram_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagram Available Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `electrical_isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electrical Isolation Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `energy_sources_controlled` SET TAGS ('dbx_business_glossary_term' = 'Energy Sources Controlled');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `group_lockout_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Lockout Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `hydraulic_isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Isolation Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Date');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `lockout_device_count` SET TAGS ('dbx_business_glossary_term' = 'Lockout Device Count');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `lockout_device_types_required` SET TAGS ('dbx_business_glossary_term' = 'Lockout Device Types Required');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `lockout_steps_sequence` SET TAGS ('dbx_business_glossary_term' = 'Lockout Steps Sequence');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `osha_inspection_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Inspection Ready Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `pneumatic_isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pneumatic Isolation Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_document_url` SET TAGS ('dbx_business_glossary_term' = 'Procedure Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_notes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Procedure Number');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_value_regex' = '^LOTO-[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|retired');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_version` SET TAGS ('dbx_business_glossary_term' = 'Procedure Version');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `procedure_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `restoration_steps` SET TAGS ('dbx_business_glossary_term' = 'Restoration Steps');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_EHS|Enviance|Infor_EAM|Manual_Entry');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `stored_energy_release_method` SET TAGS ('dbx_business_glossary_term' = 'Stored Energy Release Method');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `tagout_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Tagout Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `loto_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Execution ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `air_pollution_control_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Collection System Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `lockout_tagout_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Procedure ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `quaternary_loto_deviation_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Approved By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `quaternary_loto_deviation_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `quaternary_loto_deviation_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `quinary_loto_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `quinary_loto_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `quinary_loto_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `rng_processing_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Rng Processing Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `srf_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Srf Production Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `tertiary_loto_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Group Lockout Coordinator Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `tertiary_loto_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `tertiary_loto_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `reversal_loto_execution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `affected_employees_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Employees Count');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `affected_employees_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Affected Employees Notified Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `deviation_from_procedure_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Procedure Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `employees_notified_of_restoration_flag` SET TAGS ('dbx_business_glossary_term' = 'Employees Notified of Restoration Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `energy_sources_isolated` SET TAGS ('dbx_business_glossary_term' = 'Energy Sources Isolated');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `equipment_inspection_before_restoration_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inspection Before Restoration Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Execution Number');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Execution Status');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `group_lockout_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Lockout Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `incident_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurred Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `isolation_points_count` SET TAGS ('dbx_business_glossary_term' = 'Isolation Points Count');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `lock_serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Lock Serial Numbers');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `lockout_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lockout Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `lockout_devices_applied` SET TAGS ('dbx_business_glossary_term' = 'Lockout Devices Applied');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `lockout_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lockout Start Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `restoration_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restoration Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `restoration_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restoration Start Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `shift_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Shift Change Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `tag_numbers` SET TAGS ('dbx_business_glossary_term' = 'Tag Numbers');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `total_lockout_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Lockout Duration Minutes');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Zero Energy Verification Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Type');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `zero_energy_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Zero Energy Verification Method');
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ALTER COLUMN `zero_energy_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Energy Verified Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_issuing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_issuing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_issuing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `osha_recordable_id` SET TAGS ('dbx_business_glossary_term' = 'Related OSHA Recordable Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `primary_superseded_by_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Alert Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `superseded_alert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `acknowledged_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Count');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Deadline Date');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `affected_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Affected Facility Types');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `affected_operation_types` SET TAGS ('dbx_business_glossary_term' = 'Affected Operation Types');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Description');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Number');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^SA-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Status');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'draft|issued|active|acknowledged|closed|superseded');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Type');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'incident_lesson_learned|regulatory_update|equipment_hazard|weather_environmental_hazard|ppe_requirement|procedural_change');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'email|mobile_app|safety_meeting|posted_notice|all_hands|toolbox_talk');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `distribution_district_codes` SET TAGS ('dbx_business_glossary_term' = 'Distribution District Codes');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `distribution_facility_codes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Codes');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `distribution_region_codes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Region Codes');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Distribution Scope');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'company_wide|region|district|facility|department|role_specific');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Effective Date');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Expiration Date');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Issue Date');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'OSHA|EPA|DOT|RCRA|state_environmental|local_enforcement');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Severity Level');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Title');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `total_recipients_count` SET TAGS ('dbx_business_glossary_term' = 'Total Recipients Count');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Version');
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `alert_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert Acknowledgment ID');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert ID');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `prior_alert_acknowledgment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Duration Minutes');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_location` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Location');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_value_regex' = 'digital_signature|paper_signoff|toolbox_talk|email_confirmation|mobile_app|training_session');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_notes` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'completed|pending|overdue|waived|exempt');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `cdl_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Holder Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `comprehension_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehension Verified Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|mobile|kiosk|paper');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `incident_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Related Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `osha_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Compliance Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `osha_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Standard Reference');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `ppe_requirements_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements Acknowledged');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `reminder_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Count');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('dbx_business_glossary_term' = 'Signature Type');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('dbx_value_regex' = 'electronic|wet_signature|biometric|pin|verbal_confirmation');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `training_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Credit Hours');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'quiz|verbal_confirmation|demonstration|observation|none');
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ALTER COLUMN `verification_score` SET TAGS ('dbx_business_glossary_term' = 'Verification Score');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `medical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Case ID');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `medical_case_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `medical_case_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `primary_medical_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `primary_medical_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `primary_medical_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Treating Provider Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `related_medical_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `actual_medical_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Medical Cost');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `actual_medical_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `case_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Case Closure Date');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Medical Case Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Case Number');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Case Status');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|active|closed|pending_closure|under_review|appealed');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Diagnosis Code');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Medical Diagnosis Description');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `estimated_medical_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Medical Cost');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `estimated_medical_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `full_duty_return_date` SET TAGS ('dbx_business_glossary_term' = 'Full Duty Return Date');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `hospitalization_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Duration in Days');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `hospitalization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `initial_treatment_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Medical Treatment Date');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `initial_treatment_time` SET TAGS ('dbx_business_glossary_term' = 'Initial Medical Treatment Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `initial_treatment_time` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `initial_treatment_time` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Nature of Injury or Illness');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `injury_nature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `injury_nature` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `osha_case_classification` SET TAGS ('dbx_business_glossary_term' = 'OSHA Case Classification');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `osha_case_classification` SET TAGS ('dbx_value_regex' = 'injury|illness|death|not_recordable');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `physical_therapy_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Physical Therapy Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `privacy_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Case Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `surgery_date` SET TAGS ('dbx_business_glossary_term' = 'Surgery Date');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `surgery_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Surgery Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `total_days_away` SET TAGS ('dbx_business_glossary_term' = 'Total Days Away from Work');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `total_days_restricted` SET TAGS ('dbx_business_glossary_term' = 'Total Days of Job Transfer or Restriction');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `treating_provider_type` SET TAGS ('dbx_business_glossary_term' = 'Treating Medical Provider Type');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `treating_provider_type` SET TAGS ('dbx_value_regex' = 'occupational_clinic|emergency_room|hospital|urgent_care|primary_care|specialist');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Type');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `treatment_type` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|emergency_room|hospitalization|observation');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `work_restriction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Work Restriction End Date');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `work_restriction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Work Restriction Start Date');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `work_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Work Restriction Type');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `work_restriction_type` SET TAGS ('dbx_value_regex' = 'full_duty|light_duty|restricted_duty|days_away|modified_duty');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `workers_comp_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Status');
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ALTER COLUMN `workers_comp_claim_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|under_review|closed|appealed');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` SET TAGS ('dbx_subdomain' = 'hazard_assessment');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `industrial_hygiene_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial Hygiene Sample ID');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `combustion_operating_log_id` SET TAGS ('dbx_business_glossary_term' = 'Combustion Operating Log Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `tertiary_industrial_reviewed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `tertiary_industrial_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `tertiary_industrial_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `follow_up_industrial_hygiene_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `acgih_tlv` SET TAGS ('dbx_business_glossary_term' = 'American Conference of Governmental Industrial Hygienists (ACGIH) Threshold Limit Value (TLV)');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Name');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `exposure_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Type');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `exposure_limit_type` SET TAGS ('dbx_value_regex' = 'TWA|STEL|ceiling|action_level');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `job_task_description` SET TAGS ('dbx_business_glossary_term' = 'Job Task Description');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `laboratory_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `measured_result_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Result Value');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `osha_pel` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Permissible Exposure Limit (PEL)');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `ppe_worn` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Worn');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `quantification_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantification Limit');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `recommended_controls` SET TAGS ('dbx_business_glossary_term' = 'Recommended Controls');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_value_regex' = 'collected|in_transit|received|analyzed|reported|voided');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'personal|area|bulk|wipe|direct_reading');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sample_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume Liters');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sampling_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Sampling Duration Minutes');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sampling_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sampling End Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sampling_equipment` SET TAGS ('dbx_business_glossary_term' = 'Sampling Equipment');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sampling_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Description');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `sampling_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sampling Start Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incentive ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_program_coordinator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Coordinator Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_program_coordinator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_program_coordinator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_program_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_program_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_program_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `parent_incentive_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `applicable_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `applicable_operation_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Operation Types');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `award_description` SET TAGS ('dbx_business_glossary_term' = 'Award Description');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `award_frequency` SET TAGS ('dbx_business_glossary_term' = 'Award Frequency');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `award_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|milestone_based|continuous');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `award_value` SET TAGS ('dbx_business_glossary_term' = 'Award Value');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `days_without_injury_threshold` SET TAGS ('dbx_business_glossary_term' = 'Days Without Injury Threshold');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'milestone_award|peer_recognition|safety_bonus|team_recognition|individual_achievement|department_award');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `observation_participation_rate_threshold` SET TAGS ('dbx_business_glossary_term' = 'Observation Participation Rate Threshold');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `osha_vpp_aligned_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Voluntary Protection Programs (VPP) Aligned Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_document_url` SET TAGS ('dbx_business_glossary_term' = 'Program Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Period End Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Period Start Date');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|closed');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `reporting_discouraged_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Discouraged Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `total_awards_issued` SET TAGS ('dbx_business_glossary_term' = 'Total Awards Issued');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `total_participants` SET TAGS ('dbx_business_glossary_term' = 'Total Participants');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `training_completion_threshold` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Threshold');
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `emergency_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) ID');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `primary_emergency_coordinator_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `quaternary_emergency_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `quaternary_emergency_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `quaternary_emergency_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `tertiary_emergency_alternate_coordinator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Alternate Emergency Coordinator Employee ID');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `tertiary_emergency_alternate_coordinator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `tertiary_emergency_alternate_coordinator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `superseded_emergency_action_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `alarm_system_description` SET TAGS ('dbx_business_glossary_term' = 'Alarm System Description');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `critical_operations_shutdown` SET TAGS ('dbx_business_glossary_term' = 'Critical Operations Shutdown Procedures');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `drill_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Drill Frequency in Months');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `emergency_contact_list` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact List');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `emergency_contact_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `emergency_contact_list` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `emergency_types_covered` SET TAGS ('dbx_business_glossary_term' = 'Emergency Types Covered');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `employee_roles_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Employee Roles and Responsibilities');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `employee_training_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Training Completion Rate Percentage');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `evacuation_procedures` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Procedures');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `facility_map_url` SET TAGS ('dbx_business_glossary_term' = 'Facility Map Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `hazmat_specific_procedures` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Specific Procedures');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Emergency Drill Date');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Plan Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `medical_emergency_procedures` SET TAGS ('dbx_business_glossary_term' = 'Medical Emergency Procedures');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `medical_emergency_procedures` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `medical_emergency_procedures` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `next_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Emergency Drill Date');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Plan Review Date');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `osha_standard_citation` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Standard Citation');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan Number');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|expired|superseded|archived');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `primary_assembly_point` SET TAGS ('dbx_business_glossary_term' = 'Primary Assembly Point');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'OSHA|EPA|state_environmental|local_fire_marshal|DOT|multiple');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `rescue_non_rescue_duties` SET TAGS ('dbx_business_glossary_term' = 'Rescue and Non-Rescue Duties');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Frequency in Months');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `secondary_assembly_point` SET TAGS ('dbx_business_glossary_term' = 'Secondary Assembly Point');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
