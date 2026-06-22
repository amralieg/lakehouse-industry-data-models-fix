-- Schema for Domain: safety | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-22 17:24:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`safety` COMMENT 'HSE (Health Safety Environment) domain managing incident reports, LTI (Lost Time Injury), TRIR (Total Recordable Incident Rate), near-miss records, SWMS (Safe Work Method Statements), PTW (Permit to Work), TBM (Toolbox Meeting) records, safety audits, corrective actions, PPE compliance, and environmental compliance records. Integrates with Intelex for incident management and OSHA/ISO 45001 regulatory reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique system-generated identifier for each HSE safety event record. Primary key for the incident master register sourced from Intelex incident management module.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Regulatory incident reports must attribute each incident to the owning client account for liability and contract compliance.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project on which the incident occurred. Links the incident to the project master for site-level TRIR and LTIFR calculations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Incident cost allocation for insurance and budgeting; safety team records cost_center to charge incident expenses to the appropriate financial ledger.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the injured or involved party (employee, subcontractor worker, or visitor) from the workforce master. Supports PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: Incident reports capture the crew responsible for the work area, supporting root‑cause analysis and crew‑level safety metrics.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Incidents are often the realization of a known hazard that was identified in the hazard register. Linking incidents to the hazard register entry enables analysis of whether known hazards resulted in a',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Incidents occur within the context of a project HSE Plan. Linking incidents to the governing HSE plan enables analysis of incident rates against plan targets (lti_target, trir_target), supports regula',
    `insurance_register_id` BIGINT COMMENT 'Foreign key linking to contract.insurance_register. Business justification: Safety incidents triggering insurance claims (workers comp, property damage, public liability) must reference the applicable insurance policy. Claims management and insurance compliance reporting requ',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Incident investigations record the material that caused the event; linking to material master supports root‑cause analysis and corrective action.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Incident investigations need to identify the responsible contract party (e.g., subcontractor) for corrective actions and claim settlement.',
    `permit_to_work_id` BIGINT COMMENT 'Reference to the active Permit to Work (PTW) that was in place at the time of the incident. Critical for determining whether the incident occurred under a valid permit and whether permit controls were adequate or breached.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Incident logging captures the client contact who reported the event, enabling audit trails and follow‑up communication.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Incidents are often linked to a risk assessment that failed to prevent the event, or to the risk assessment that covered the activity being performed at the time of the incident. This link is critical',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Incidents involving subcontractor workers must be linked to the specific subcontract for subcontractor safety performance tracking, insurance claims processing, and regulatory reporting. Existing part',
    `swms_id` BIGINT COMMENT 'Reference to the Safe Work Method Statement (SWMS) applicable to the task being performed at the time of the incident. Used to assess whether the SWMS was adequate, followed, or requires revision as a corrective action.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Incident investigation requires identifying the responsible vendor for equipment/material causing the incident, mandated by OSHA incident reporting.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Incidents occur at specific work fronts. Linking enables work-front-level incident rate analysis (TRIFR, LTIFR per work front) — a key HSE KPI used by project managers and HSE teams to identify high-r',
    `body_part_affected` STRING COMMENT 'Specific body part injured (e.g., right hand, lower back, left eye, head). Required field for OSHA 300 log and BLS injury classification. Supports ergonomic and PPE gap analysis. [ENUM-REF-CANDIDATE: head|eye|neck|back|shoulder|arm|hand|finger|leg|knee|foot|toe|multiple|other — promote to reference product]',
    `corrective_action_count` STRING COMMENT 'Number of corrective actions raised against this incident. Provides a quick indicator of investigation depth and systemic response. Detailed corrective actions are tracked in the corrective_action product linked to this incident.',
    `created_at` TIMESTAMP COMMENT 'System audit timestamp recording when the incident record was first created in the data platform. Supports data lineage and Silver layer audit trail requirements.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the injured worker was away from work due to the incident, excluding the day of injury. Core component of the DART (Days Away, Restricted, or Transferred) rate calculation and OSHA 300 log column G.',
    `days_restricted_or_transferred` STRING COMMENT 'Number of calendar days the injured worker was on restricted work duty or transferred to another job due to the incident. Combined with days_away_from_work to compute the DART (Days Away, Restricted, or Transferred) rate. Maps to OSHA 300 log column H.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident including what happened, the sequence of events, conditions at the time, and any immediate actions taken. Core field for OSHA 300 log column F and investigation reports.',
    `environmental_media_affected` STRING COMMENT 'Environmental media impacted by the incident (soil, groundwater, surface water, air). Populated only when is_environmental_event is true. Required for EPA reportable quantity determination and ISO 14001 environmental incident reporting.. Valid values are `soil|groundwater|surface_water|air|none|multiple`',
    `immediate_cause` STRING COMMENT 'Direct, proximate cause of the incident as determined during initial investigation (e.g., struck by falling object, slip on wet surface, equipment malfunction, electrical contact). Supports causal pattern analysis.',
    `incident_number` STRING COMMENT 'Externally-known, human-readable reference number assigned to the incident at the time of reporting (e.g., INC-2024-000123). Used in correspondence, regulatory submissions, and OSHA 300 log entries.. Valid values are `^INC-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident record within the Intelex workflow. Drives investigation assignment, corrective action tracking, and regulatory notification obligations.. Valid values are `open|under_investigation|pending_review|closed|void`',
    `incident_type` STRING COMMENT 'Primary classification of the safety event (e.g., injury, near_miss, unsafe_condition, property_damage, environmental_event, dangerous_occurrence, behavioral_observation). Drives OSHA recordability determination and TRIR contribution. [ENUM-REF-CANDIDATE: injury|near_miss|unsafe_condition|property_damage|environmental_event|dangerous_occurrence|behavioral_observation — promote to reference product]',
    `injured_party_job_title` STRING COMMENT 'Job title or trade classification of the injured party at the time of the incident (e.g., Ironworker, Electrician, Crane Operator). Used for occupational injury pattern analysis and targeted safety training.',
    `injured_party_name` STRING COMMENT 'Full name of the person injured or involved in the incident. Required for OSHA 300 log, workers compensation claim, and medical case management. Classified as restricted PII.',
    `injured_party_type` STRING COMMENT 'Classification of the person involved in the incident. Determines OSHA recordability scope (employees and supervised workers are recordable; visitors may not be). Affects workers compensation claim eligibility.. Valid values are `employee|subcontractor|visitor|public|third_party`',
    `injury_nature` STRING COMMENT 'Nature or type of the injury or illness sustained (e.g., laceration, fracture, sprain, burn, crush injury, chemical exposure, heat stress). Required for OSHA 300 log and BLS OIICS coding. [ENUM-REF-CANDIDATE: laceration|fracture|sprain_strain|burn|crush|chemical_exposure|heat_stress|contusion|amputation|other — promote to reference product]',
    `intelex_record_reference` STRING COMMENT 'Native record identifier from the Intelex HSE Management system from which this incident record was sourced. Enables bi-directional traceability between the Silver layer data product and the operational system of record for reconciliation and audit purposes.',
    `investigation_completed_date` DATE COMMENT 'Date on which the formal incident investigation was completed and root cause analysis finalized. Used to measure investigation cycle time compliance (typically 5–10 business days per HSE policy) and trigger corrective action issuance.',
    `investigation_lead` STRING COMMENT 'Name or identifier of the HSE officer or supervisor assigned as lead investigator for the incident. Supports investigation accountability tracking and workload management within the HSE team.',
    `is_environmental_event` BOOLEAN COMMENT 'Indicates whether the incident involved an environmental impact such as a spill, release, or contamination event. Triggers EPA reporting obligations and ISO 14001 environmental management corrective action workflows.',
    `is_fit_for_duty` BOOLEAN COMMENT 'Indicates whether the injured worker has been medically cleared for full unrestricted duty upon return to work. Prevents premature return to hazardous tasks and supports site access control decisions.',
    `is_lti` BOOLEAN COMMENT 'Indicates whether the incident resulted in at least one full calendar day away from work beyond the day of injury. LTI (Lost Time Injury) flag is the primary driver of LTIFR (Lost Time Injury Frequency Rate) calculations and executive safety KPI dashboards.',
    `is_osha_recordable` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordability criteria under 29 CFR 1904.7 (medical treatment beyond first aid, days away, restricted work, job transfer, loss of consciousness, or diagnosis of a significant injury). Drives OSHA 300 log inclusion and TRIR calculation.',
    `occurred_at` TIMESTAMP COMMENT 'The precise date and time the safety event occurred on site. Principal business event timestamp used for OSHA 300 log date, TRIR period attribution, and trend analysis. Distinct from the report creation timestamp.',
    `ppe_compliance` STRING COMMENT 'Indicates whether the injured party was wearing required Personal Protective Equipment (PPE) at the time of the incident. Non-compliance is a key causal factor and triggers disciplinary and training corrective actions.. Valid values are `compliant|non_compliant|not_applicable|unknown`',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of property, plant, or equipment damage resulting from the incident in USD. Used for insurance claim valuation, project cost impact reporting, and safety cost of poor quality (COPQ) analysis.',
    `regulatory_notification_date` DATE COMMENT 'Date on which the regulatory authority (OSHA, EPA, or other) was formally notified of the incident. Used to verify compliance with mandatory notification timeframes and document regulatory correspondence.',
    `regulatory_notification_status` STRING COMMENT 'Status of mandatory regulatory notification to OSHA or other governing bodies. OSHA requires fatality notification within 8 hours and inpatient hospitalization within 24 hours. Tracks compliance with notification deadlines.. Valid values are `not_required|pending|notified|overdue`',
    `remarks` STRING COMMENT '',
    `reported_at` TIMESTAMP COMMENT 'Date and time the incident was formally reported and entered into the Intelex system. Used to measure reporting lag compliance (OSHA requires reporting of fatalities within 8 hours and hospitalizations within 24 hours).',
    `return_to_work_date` DATE COMMENT 'Date the injured worker returned to full or modified duty following the incident. Used to calculate actual days away from work, close the LTI case, and update DART rate calculations. Triggers fitness-for-duty clearance workflow.',
    `root_cause_category` STRING COMMENT 'High-level root cause category identified through formal investigation (e.g., inadequate_procedure, equipment_failure, human_error, environmental_condition, inadequate_supervision, training_deficiency). Drives systemic corrective action programs. [ENUM-REF-CANDIDATE: inadequate_procedure|equipment_failure|human_error|environmental_condition|inadequate_supervision|training_deficiency|design_deficiency — promote to reference product]',
    `severity` STRING COMMENT 'Severity level of the incident aligned to the OSHA recordability hierarchy and HSE severity matrix. LTI (Lost Time Injury) and fatality cases trigger mandatory regulatory notifications. Drives DART rate and TRIR calculations. [ENUM-REF-CANDIDATE: fatality|lti|medical_treatment|restricted_work|first_aid|near_miss|property_damage|environmental — 8 candidates stripped; promote to reference product]',
    `shift` STRING COMMENT 'Work shift during which the incident occurred (day, night, swing). Shift-based incident analysis identifies fatigue-related patterns and informs shift rotation and supervision scheduling decisions.. Valid values are `day|night|swing|not_applicable`',
    `treating_physician` STRING COMMENT 'Name of the physician or medical professional who provided treatment to the injured party. Required for OSHA 300 log and workers compensation case management. Classified as confidential due to medical case sensitivity.',
    `treatment_type` STRING COMMENT 'Type of medical treatment provided to the injured party. Distinguishes first aid cases (non-recordable) from medical treatment cases (OSHA recordable). Drives case management workflow and workers compensation claim initiation.. Valid values are `first_aid|medical_treatment|hospitalization|fatality|restricted_work|no_treatment`',
    `updated_at` TIMESTAMP COMMENT 'System audit timestamp recording the most recent modification to the incident record. Used to detect stale investigations and track investigation progress velocity.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions at the site at the time of the incident. Environmental factors such as rain, high winds, or extreme heat are frequently contributing causes in construction incidents and are required for thorough root cause analysis. [ENUM-REF-CANDIDATE: clear|rain|wind|fog|extreme_heat|extreme_cold|not_applicable — 7 candidates stripped; promote to reference product]',
    `workers_comp_claim_ref` STRING COMMENT 'Reference number of the workers compensation insurance claim associated with this incident. Links the safety event record to the financial claims management system for cost tracking and insurance reporting.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Core master record for ALL HSE safety events on construction sites, encompassing the full severity spectrum: Lost Time Injuries (LTI), medical treatment cases (including body part affected, treatment type, treating physician, return-to-work date, fitness-for-duty status), first aid cases, restricted work cases, near-misses, unsafe conditions, behavioral safety observations, property damage, dangerous occurrences, and environmental events. Captures incident classification/type, severity, location (project/site/area), date/time, injured party details, immediate cause, root cause category, OSHA recordability flag, TRIR contribution, days away/restricted/transferred (DART), regulatory notification status, environmental media affected, and workers compensation claim reference. Serves as the single unified safety event register supporting OSHA 300/300A log generation, TRIR/LTIFR/DART rate calculations, leading indicator trending, and ISO 45001 reporting. Sourced from Intelex incident management module.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`incident_investigation` (
    `incident_investigation_id` BIGINT COMMENT 'Unique system-generated identifier for the incident investigation record. Primary key for this entity in the Databricks Silver Layer.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project on which the incident under investigation occurred. Used to associate investigation findings with project-level Health Safety and Environment (HSE) performance.',
    `incident_id` BIGINT COMMENT 'Reference to the parent Health Safety and Environment (HSE) incident record that triggered this investigation. Links the investigation to the originating incident report in Intelex.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Incident investigations must examine whether a valid PTW was in place at the time of the incident. incident_investigation has ptw_reference (STRING) which is a denormalized text reference. Adding perm',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Incident investigations must review the risk assessment that was in place at the time of the incident to determine if the assessment was adequate and whether control measures were followed. Adding ris',
    `site_id` BIGINT COMMENT 'Reference to the construction site or work location where the incident under investigation occurred. Enables site-level Health Safety and Environment (HSE) performance reporting.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Incident investigations are conducted at the work front where the incident occurred. work_area_description is a denormalized text field. Linking enables work-front-level investigation tracking and r',
    `contributing_factors` STRING COMMENT 'Narrative description of secondary factors that contributed to the incident, such as environmental conditions, equipment state, worker fatigue, or inadequate supervision. Supports multi-causal analysis.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date by which all corrective actions arising from the investigation must be implemented and verified. Used for tracking overdue actions and management escalation.',
    `corrective_action_status` STRING COMMENT 'Aggregate status of corrective actions arising from this investigation, indicating whether actions have been initiated, completed, or verified as effective.. Valid values are `not_started|in_progress|completed|overdue|verified`',
    `corrective_action_summary` STRING COMMENT 'Summary description of the corrective and preventive actions recommended by the investigation team to address root causes and prevent recurrence. Detailed individual actions are tracked in the corrective action register.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident investigation record was first created in the system. Used for audit trail, data lineage, and compliance with record-keeping requirements.',
    `incident_investigation_description` STRING COMMENT '',
    `immediate_cause` STRING COMMENT 'Direct, observable cause of the incident — the unsafe act or unsafe condition that directly resulted in the event. Captured as a narrative description from the investigation findings.',
    `incident_category` STRING COMMENT 'High-level category of the incident type such as fall from height, struck-by, caught-in/between, electrical, chemical exposure, vehicle collision, or fire. Used for trend analysis and targeted safety interventions. [ENUM-REF-CANDIDATE: fall_from_height|struck_by|caught_in_between|electrical|chemical_exposure|vehicle|fire|ergonomic|other — promote to reference product]',
    `incident_classification` STRING COMMENT 'Severity classification of the incident under investigation per OSHA and ISO 45001 reporting categories. Lost Time Injury (LTI) and fatality classifications trigger mandatory regulatory reporting. [ENUM-REF-CANDIDATE: fatality|lti|medical_treatment|first_aid|near_miss|property_damage|environmental — promote to reference product]',
    `incident_date` DATE COMMENT 'Calendar date on which the original Health Safety and Environment (HSE) incident occurred. Used as the principal business event date for regulatory reporting and trend analysis.',
    `incident_investigation_status` STRING COMMENT '',
    `injured_party_type` STRING COMMENT 'Classification of the employment or affiliation status of the person(s) involved in the incident — distinguishing between direct employees, subcontractor workers, site visitors, or members of the public.. Valid values are `direct_employee|subcontractor|visitor|public|other`',
    `intelex_record_reference` STRING COMMENT 'Source system record identifier from the Intelex Health Safety and Environment (HSE) Management platform. Used for data lineage, reconciliation, and traceability back to the operational system of record.',
    `investigation_close_date` DATE COMMENT 'Date on which the investigation was formally closed following completion of root cause analysis, corrective action assignment, and management sign-off. Nullable until closure.',
    `investigation_findings` STRING COMMENT 'Comprehensive narrative summary of all findings from the investigation, including evidence gathered, witness statements reviewed, site conditions observed, and conclusions drawn by the investigation team.',
    `investigation_methodology` STRING COMMENT 'Root cause analysis methodology applied during the investigation. Common methods include 5-Why analysis, Fishbone (Ishikawa) diagram, Bowtie analysis, Fault Tree Analysis, and TapRooT. [ENUM-REF-CANDIDATE: 5_why|fishbone|bowtie|fault_tree|taproot|other — promote to reference product]. Valid values are `5_why|fishbone|bowtie|fault_tree|taproot|other`',
    `investigation_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to the investigation, used in correspondence, regulatory submissions, and audit trails. Format: INV-YYYY-NNNNNN.. Valid values are `^INV-[0-9]{4}-[0-9]{6}$`',
    `investigation_start_date` DATE COMMENT 'Date on which the formal investigation was initiated. Used to measure investigation response time and compliance with regulatory timelines for incident investigation commencement.',
    `investigation_status` STRING COMMENT 'Current lifecycle state of the incident investigation workflow, tracking progress from initial opening through root cause analysis, review, and formal closure.. Valid values are `open|in_progress|pending_review|closed|cancelled`',
    `investigation_team_members` STRING COMMENT 'Names and roles of all personnel who participated in the investigation team, including the lead investigator, HSE representative, site supervisor, and any subject matter experts. Stored as a structured text list.',
    `investigation_type` STRING COMMENT 'Classification of the investigation scope and formality level. Formal investigations are conducted for Lost Time Injuries (LTI), fatalities, and high-potential incidents. Informal investigations cover minor incidents and near-misses.. Valid values are `formal|informal|regulatory|internal`',
    `is_lti` BOOLEAN COMMENT 'Indicates whether the incident resulted in a Lost Time Injury (LTI), defined as any work-related injury or illness that results in at least one full day away from work beyond the day of the incident.',
    `is_recordable` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordability criteria and must be entered on the OSHA 300 Log. Recordable incidents include work-related fatalities, injuries, and illnesses meeting specific severity thresholds.',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether the incident requires mandatory notification to a regulatory authority such as OSHA, EPA, or local government within a prescribed timeframe (e.g., OSHA requires fatality reporting within 8 hours).',
    `lessons_learned` STRING COMMENT 'Key lessons identified from the investigation that should be communicated across the organisation and other project sites to prevent similar incidents. Used in Toolbox Meeting (TBM) communications and safety alerts.',
    `lost_time_days` STRING COMMENT 'Number of calendar days lost due to the incident as determined by the investigation. Used in calculating Lost Time Injury (LTI) frequency rates and Total Recordable Incident Rate (TRIR) for OSHA regulatory reporting.',
    `management_review_date` DATE COMMENT 'Date on which senior management formally reviewed and accepted the investigation report and corrective action plan. Required for ISO 45001 management review compliance.',
    `ppe_compliance_flag` BOOLEAN COMMENT 'Indicates whether the injured party was wearing the required Personal Protective Equipment (PPE) at the time of the incident. Non-compliance is a key contributing factor captured in the investigation.',
    `recurrence_prevention_measures` STRING COMMENT 'Narrative description of specific engineering controls, administrative controls, or procedural changes recommended to prevent recurrence of the incident type. Aligned with the hierarchy of controls.',
    `regulatory_reference_number` STRING COMMENT 'Reference or case number assigned by the regulatory authority (e.g., OSHA case number) upon submission of the incident report. Used for tracking regulatory correspondence and compliance status.',
    `regulatory_submission_date` DATE COMMENT 'Date on which the incident investigation report or notification was formally submitted to the relevant regulatory authority (e.g., OSHA, EPA). Nullable for non-reportable incidents.',
    `remarks` STRING COMMENT '',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the fundamental systemic root cause(s) identified through the investigation methodology (e.g., 5-Why, Fishbone). Represents the deepest causal factor that, if corrected, would prevent recurrence.',
    `swms_in_place_flag` BOOLEAN COMMENT 'Indicates whether a valid Safe Work Method Statement (SWMS) was in place and accessible for the work activity being performed at the time of the incident. Absence of SWMS is a key systemic cause indicator.',
    `systemic_cause` STRING COMMENT 'Organisational or management system failure that allowed the immediate and root causes to exist, such as inadequate procedures, insufficient training, or failed management controls. Distinct from immediate and root causes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident investigation record. Supports audit trail requirements and change tracking for regulatory compliance.',
    `witness_count` STRING COMMENT 'Number of witnesses interviewed during the investigation. Indicates the breadth of evidence gathering and supports completeness assessment of the investigation.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_incident_investigation PRIMARY KEY(`incident_investigation_id`)
) COMMENT 'Detailed investigation record linked to a reported HSE incident. Captures investigation team members, root cause analysis methodology (5-Why, Fishbone), contributing factors, immediate causes, systemic causes, investigation findings, corrective action recommendations, and regulatory submission details. Tracks investigation status from open through closed. Sourced from Intelex.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`swms` (
    `swms_id` BIGINT COMMENT 'Unique system-generated identifier for the Safe Work Method Statement (SWMS) record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client SWMS Submission and Approval: clients contractually mandate SWMS for work on their sites and require submission for approval. Linking SWMS to the client account enables client-specific SWMS com',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this SWMS was prepared. Links the SWMS to the project master record for site-level HSE reporting and compliance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SWMS implementation incurs labor and material costs; assigning a cost_center allows these costs to flow into project financials.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: SWMS are prepared for specific work activities budgeted under cost codes. Construction project controllers report SWMS compliance coverage by cost code for safety cost tracking and audit. No existing ',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: SWMS preparation requires referencing the construction drawing to identify work steps, spatial hazards, and equipment positions. HSE practitioners in construction universally reference the relevant dr',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: SWMS documents are developed and maintained under the project-level HSE Plan framework. The hse_plan has swms_required: BOOLEAN indicating whether SWMS are mandated under the plan. Adding hse_plan_id ',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: A Safe Work Method Statement is developed based on a formal risk assessment of the high-risk work activity. The SWMS documents the hazards, risk ratings, and control measures that are derived from the',
    `site_id` BIGINT COMMENT 'Reference to the specific construction site or work front where the SWMS applies. Enables site-level HSE compliance reporting and audit trail.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: SWMS control measures must align with technical specification requirements for materials, chemicals, and work methods. Regulatory compliance (e.g., WHS Act) requires SWMS to address hazards arising fr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: SWMS documents are prepared for and apply to specific subcontractors performing hazardous work. HSE compliance audits and vendor HSE performance scoring require linking each SWMS to the vendor whose w',
    `aconex_document_reference` STRING COMMENT 'The unique document identifier assigned by the Aconex document management system for this SWMS record. Used for cross-system traceability and transmittal tracking.',
    `activity_description` STRING COMMENT 'Detailed narrative description of the high-risk construction activity covered by this SWMS, including scope, location, and method of work. Provides the foundational context for all hazard and control entries.',
    `activity_type` STRING COMMENT 'Classification of the high-risk construction activity category covered by this SWMS (e.g., working at heights, confined space entry, excavation, demolition, crane lifts, hot works, electrical works). [ENUM-REF-CANDIDATE: working_at_heights|confined_space|excavation|demolition|crane_lift|hot_works|electrical|trenching|scaffolding|explosive_use — promote to reference product]',
    `applicable_legislation` STRING COMMENT 'List of applicable legislation, regulations, codes of practice, and industry standards that govern the high-risk activity described in this SWMS (e.g., OSHA 29 CFR 1926, IBC, NFPA, AISC, ACI). Required for regulatory compliance documentation.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the SWMS document within the approval workflow. Controls whether the SWMS is valid for use on site. Only approved SWMS documents may be used to authorise work commencement.. Valid values are `draft|under_review|approved|rejected|superseded|archived`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time at which the SWMS was formally approved by the authorised approver. Distinct from issue_date — captures the precise approval event for audit trail purposes.',
    `competency_requirements` STRING COMMENT 'Description of mandatory competency, certification, and licence requirements for workers performing the activity (e.g., Working at Heights certificate, Confined Space Entry certificate, Crane Operator licence). Supports workforce compliance verification.',
    `control_measures` STRING COMMENT 'Detailed description of all control measures to be implemented to eliminate or minimise the identified hazards, following the hierarchy of controls (elimination, substitution, engineering, administrative, PPE). Core content of the SWMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which this SWMS record was first created in the system. Provides the audit trail creation marker for data lineage and compliance purposes.',
    `swms_description` STRING COMMENT '',
    `document_url` STRING COMMENT 'URL or file path reference to the full SWMS document stored in the document management system (Aconex or Autodesk BIM 360). Provides direct access to the source document for audit and compliance purposes.',
    `emergency_procedures` STRING COMMENT 'Description of emergency response procedures specific to the high-risk activity, including evacuation routes, first aid requirements, emergency contacts, and incident notification protocols.',
    `environmental_controls` STRING COMMENT 'Description of environmental control measures required during the activity to prevent environmental harm, including spill containment, dust suppression, noise management, and waste disposal procedures.',
    `expiry_date` DATE COMMENT 'The date after which the SWMS is no longer valid for use and must be re-approved or superseded. Distinct from review_date — expiry renders the document invalid, whereas review_date triggers a re-assessment.',
    `hazard_description` STRING COMMENT 'Narrative description of all identified hazards associated with the high-risk activity, including physical, chemical, biological, ergonomic, and environmental hazards. Captured as a consolidated summary at the SWMS header level.',
    `initial_risk_consequence` STRING COMMENT 'Consequence severity rating of the identified hazard before any control measures are applied (inherent risk). Combined with initial_risk_likelihood to produce the initial risk rating score.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `initial_risk_likelihood` STRING COMMENT 'Likelihood rating of the identified hazard materialising before any control measures are applied (inherent risk). Used in conjunction with initial_risk_consequence to derive the initial risk rating per the risk matrix.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `initial_risk_rating` STRING COMMENT 'Overall risk rating derived from the combination of initial_risk_likelihood and initial_risk_consequence before any control measures are applied. Represents the inherent risk level of the activity.. Valid values are `low|medium|high|extreme`',
    `intelex_record_reference` STRING COMMENT 'The unique record identifier assigned by the Intelex HSE Management system for this SWMS. Enables bidirectional traceability between the lakehouse silver layer and the operational system of record.',
    `issue_date` DATE COMMENT 'The date on which the SWMS was formally issued and approved for use on site. Represents the principal business event date for this document.',
    `last_reviewed_date` DATE COMMENT 'The date on which the SWMS was most recently reviewed and confirmed as current and applicable. Updated each time a formal review is completed, even if no changes are made to the document content.',
    `plant_equipment_required` STRING COMMENT 'List of plant, equipment, and tools required to perform the high-risk activity safely as described in this SWMS (e.g., EWP, crane, excavator, scaffolding, welding equipment). Supports equipment deployment planning.',
    `ppe_requirements` STRING COMMENT 'Enumerated list of mandatory Personal Protective Equipment (PPE) items required for personnel performing the activity covered by this SWMS (e.g., hard hat, safety harness, respirator, face shield, cut-resistant gloves). Aligns with PPE compliance tracking in Intelex.',
    `ptw_required` BOOLEAN COMMENT 'Indicates whether a Permit to Work (PTW) must be issued and active before the activity described in this SWMS can commence. True for activities such as confined space entry, hot works, and electrical isolation.',
    `ptw_type` STRING COMMENT 'Type of Permit to Work (PTW) required in conjunction with this SWMS. Populated only when ptw_required is True. Drives the PTW issuance workflow in Intelex.. Valid values are `hot_work|confined_space|electrical|excavation|working_at_heights|general`',
    `remarks` STRING COMMENT '',
    `residual_risk_consequence` STRING COMMENT 'Consequence severity rating after all control measures have been applied. Combined with residual_risk_likelihood to produce the residual risk rating.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `residual_risk_likelihood` STRING COMMENT 'Likelihood rating of the hazard materialising after all control measures have been applied. Used to assess the effectiveness of controls and determine if the residual risk is acceptable.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `residual_risk_rating` STRING COMMENT 'Overall risk rating after all control measures have been applied. Represents the residual risk level that must be accepted or further mitigated before work can proceed. Extreme residual risk requires escalation to HSE Manager.. Valid values are `low|medium|high|extreme`',
    `review_date` DATE COMMENT 'The scheduled date by which the SWMS must be reviewed and re-validated for continued applicability. Triggers review workflow in Intelex when the date is reached or when site conditions change materially.',
    `revision_number` STRING COMMENT 'Sequential revision number of the SWMS document, incremented each time the document is formally revised and re-approved. Revision 0 represents the initial issue.',
    `swms_number` STRING COMMENT 'Externally-known unique document reference number for the SWMS, used for document control, transmittals, and regulatory submissions. Typically formatted as SWMS-[ProjectCode]-[Sequence]. Sourced from Intelex or Aconex document management.. Valid values are `^SWMS-[A-Z0-9]{2,10}-[0-9]{4,6}$`',
    `swms_status` STRING COMMENT '',
    `tbm_required` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) must be conducted with all workers before commencing the activity. TBMs are used to communicate SWMS content and obtain worker acknowledgement.',
    `title` STRING COMMENT 'Descriptive title of the Safe Work Method Statement identifying the high-risk construction activity covered (e.g., Elevated Work Platform Operations, Confined Space Entry – Stormwater Pit).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time at which this SWMS record was most recently modified in the system. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks lakehouse.',
    `work_steps` STRING COMMENT 'Sequential step-by-step description of the work procedure for the high-risk activity, detailing the specific actions workers must follow to complete the task safely. Core operational content of the SWMS.',
    `worker_acknowledgement_required` BOOLEAN COMMENT 'Indicates whether all workers performing the activity must sign the SWMS to confirm they have read, understood, and agree to comply with the documented procedures and controls.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_swms PRIMARY KEY(`swms_id`)
) COMMENT 'Safe Work Method Statement (SWMS) master records defining step-by-step work procedures for high-risk construction activities. Captures activity description, identified hazards, risk rating (before and after controls), control measures, PPE requirements, responsible supervisor, approval status, review date, and applicable legislation. SSOT for SWMS documentation across all projects and sites.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`permit_to_work` (
    `permit_to_work_id` BIGINT COMMENT 'Unique system-generated identifier for the Permit to Work record. Primary key for the permit_to_work data product in the Databricks Silver Layer.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this permit is issued. Links the PTW to the project context for cost, schedule, and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Permit issuance may involve fees or cost allocations; cost_center linkage enables proper expense recording in permit cost reports.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: PTWs are issued for work activities coded under cost codes. PTW compliance costs (isolation, gas testing, standby personnel) are tracked against cost codes for project cost control reporting. No exist',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: PTW is assigned to a specific crew for execution; tracking crew_id enables compliance reporting and work‑scope verification.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: PTW issuance requires referencing the approved construction drawing defining the work area, isolation points, and structural details. Safety engineers and PTW issuers routinely attach the relevant dra',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Permits to Work are issued within the framework of the project HSE Plan. The hse_plan has ptw_required: BOOLEAN indicating PTW requirements. Adding hse_plan_id to permit_to_work links each PTW to the ',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Permits are issued to a contract party (sub‑contractor) and must be linked for audit trails and responsibility tracking.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: PTW systems require a named performing authority — the individual who accepts responsibility for executing permitted work safely. performing_authority_name is a denormalized craft_worker reference. Ro',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: PTWs authorize specific work activities performed under a subcontract PO. Linking PTW to PO enables verification that only commercially authorized work is being performed, supports PO close-out compli',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Permits to Work are issued based on a formal risk assessment of the high-risk activity. The PTWs risk_level field captures the assessed risk, but linking to the full risk assessment record enables ac',
    `site_id` BIGINT COMMENT 'Reference to the physical construction site where the permitted work is to be performed. Supports site-level HSE reporting and geographic risk analysis.',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: PTW issuance in construction requires approved design submittals (method statements, shop drawings, material approvals) as a prerequisite. PTW issuers verify submittal approval status before authorizi',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: A Permit to Work is issued to authorize high-risk work that is governed by a Safe Work Method Statement. The permit_to_work table already has a text field swms_reference (STRING) which is a denormaliz',
    `toolbox_meeting_id` BIGINT COMMENT 'Reference to the Toolbox Meeting record conducted prior to commencing the permitted work. Links the PTW to the pre-work safety briefing documentation.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Permits to Work are issued to specific subcontractors/vendors performing hazardous work. Regulatory compliance and contractor HSE performance reporting require identifying which vendor holds each PTW.',
    `approval_level` STRING COMMENT 'The organizational authority level required to approve this permit, determined by the risk level and permit type. Enforces the sign-off hierarchy in the PTW system.. Valid values are `supervisor|hse_manager|project_manager|site_director`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time at which the permit received final approval from the designated authority. Distinct from issued_timestamp; represents the formal authorization event.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time at which the permit was formally closed upon completion or cancellation of the permitted work. Triggers site reinstatement and isolation removal procedures.',
    `concurrent_permit_flag` BOOLEAN COMMENT 'Indicates whether this permit is being executed concurrently with other active permits in the same work area. Triggers additional interface risk assessment requirements.',
    `control_measures` STRING COMMENT 'Detailed description of all hazard control measures required before and during the permitted work, including engineering controls, administrative controls, and PPE requirements. Sourced from Intelex PTW control measures field.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was first created in the system. Audit trail field for data lineage and compliance reporting in the Databricks Silver Layer.',
    `permit_to_work_description` STRING COMMENT '',
    `emergency_rescue_plan` STRING COMMENT 'Reference to or description of the emergency rescue and evacuation plan applicable to the permitted work. Mandatory for confined space entry and working at heights permits.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the permitted work has potential environmental impacts requiring additional controls or regulatory notifications (e.g., soil disturbance, chemical handling, noise).',
    `extension_count` STRING COMMENT 'Number of times the permit validity period has been extended beyond the original valid_until timestamp. Tracks permit lifecycle management and potential compliance risk.',
    `gas_test_required` BOOLEAN COMMENT 'Indicates whether atmospheric gas testing is required prior to and during the permitted work (mandatory for confined space entry and hot work near flammable materials).',
    `gas_test_result` STRING COMMENT 'Result of the atmospheric gas test conducted prior to commencing the permitted work. Must be pass before work can proceed when gas_test_required is True.. Valid values are `pass|fail|not_required`',
    `hazard_description` STRING COMMENT 'Narrative description of all identified hazards associated with the permitted work activity, as documented during the hazard identification process. Core HSE compliance field.',
    `isolation_details` STRING COMMENT 'Description of the specific isolation points, energy sources, and lockout/tagout procedures required for the permitted work. Populated when isolation_required is True.',
    `isolation_required` BOOLEAN COMMENT 'Indicates whether energy isolation (lockout/tagout) is required before commencing the permitted work. Mandatory for electrical, mechanical, and process isolation scenarios.',
    `issued_timestamp` TIMESTAMP COMMENT 'The date and time at which the permit was formally issued and authorized by the issuing authority. Represents the principal real-world business event time for this transaction. Sourced from Intelex.',
    `issuing_authority_name` STRING COMMENT 'Full name of the qualified person (typically HSE Manager, Area Authority, or Responsible Engineer) who issued and authorized the permit. Required for regulatory audit and sign-off chain documentation.',
    `issuing_authority_role` STRING COMMENT 'Job title or role designation of the person who issued the permit (e.g., HSE Manager, Area Authority, Electrical Supervisor). Validates competency and authorization level.',
    `last_extended_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent extension of the permit validity period. Populated when extension_count is greater than zero.',
    `permit_number` STRING COMMENT 'Externally-known, human-readable reference number assigned to the permit by the issuing authority. Used for field reference, correspondence, and regulatory audit trails. Sourced from Intelex Permit to Work module.. Valid values are `^PTW-[A-Z0-9]{3,10}-[0-9]{4,8}$`',
    `permit_status` STRING COMMENT 'Current lifecycle state of the permit within the approval and execution workflow. Drives field access control and compliance dashboards. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — promote to reference product]',
    `permit_to_work_status` STRING COMMENT '',
    `permit_type` STRING COMMENT 'Classification of the permit based on the category of high-risk work being authorized. Drives the applicable hazard controls, sign-off chain, and regulatory requirements. [ENUM-REF-CANDIDATE: hot_work|confined_space|working_at_heights|electrical_isolation|excavation|radiography|lifting_operations|general_work — promote to reference product]',
    `ppe_requirements` STRING COMMENT 'Specific PPE items mandated for the permitted work activity (e.g., hard hat, harness, SCBA, arc flash suit, gas monitor). Derived from hazard assessment and regulatory requirements.',
    `reinstatement_details` STRING COMMENT 'Description of site reinstatement actions completed upon permit closure, including removal of isolations, restoration of services, and area clearance confirmation.',
    `remarks` STRING COMMENT '',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the permitted work activity based on the hazard identification and risk assessment process. Determines the approval authority level required.. Valid values are `low|medium|high|critical`',
    `suspension_reason` STRING COMMENT 'Narrative reason for suspending the permit mid-execution (e.g., weather change, equipment failure, emergency evacuation). Populated when permit_status is suspended.',
    `tbm_conducted_flag` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted with the work crew prior to commencing the permitted work. Mandatory pre-work safety briefing requirement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was last modified in the system. Supports change tracking, audit compliance, and incremental data loading in the Silver Layer.',
    `valid_until` TIMESTAMP COMMENT 'The date and time at which the permit expires and work must cease unless renewed. Critical for field enforcement and compliance auditing.',
    `work_location_description` STRING COMMENT 'Specific location within the site where the permitted work is to be performed, including zone, level, grid reference, or equipment tag. Supplements the site_id with granular location detail.',
    `work_scope` STRING COMMENT 'Detailed narrative description of the specific work activities authorized under this permit, including methods, equipment, and materials involved. Sourced from Intelex PTW work description field.',
    `worker_count` STRING COMMENT 'Number of workers authorized to perform work under this permit. Used for site headcount control, emergency muster, and HSE exposure tracking.',
    `valid_from` TIMESTAMP COMMENT 'The date and time from which the permit is valid and work may commence. Must not precede the issued_timestamp. Used to enforce temporal access controls on site.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_permit_to_work PRIMARY KEY(`permit_to_work_id`)
) COMMENT 'Permit to Work (PTW) records authorizing high-risk construction activities such as hot work, confined space entry, working at heights, electrical isolation, and excavation. Captures permit type, issuing authority, work scope, hazard identification, control measures, validity period, site location, isolations required, and sign-off chain. Sourced from Intelex Permit to Work module.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` (
    `toolbox_meeting_id` BIGINT COMMENT 'Primary key for toolbox_meeting',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this Toolbox Meeting was conducted. Links the TBM to the project for HSE performance reporting and compliance tracking.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Toolbox meetings are conducted for specific crews at shift start — a daily construction safety ritual. Linking toolbox_meeting to crew enables reporting on TBM frequency per crew (a KPI in HSE plans),',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Toolbox meetings reference construction drawings to communicate work area boundaries, hazard locations, and work scope to crews before commencing work. Facilitators use the relevant drawing to visuall',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Toolbox meetings are conducted as a mandatory requirement of the project HSE Plan (hse_plan.tbm_frequency defines the required frequency). Adding hse_plan_id to toolbox_meeting links each TBM to the g',
    `risk_assessment_id` BIGINT COMMENT 'Reference to the risk assessment record whose identified hazards and controls were communicated during this Toolbox Meeting. Links TBM content to the formal risk register.',
    `site_id` BIGINT COMMENT 'Reference to the specific construction site or work front where the Toolbox Meeting was held. Enables site-level HSE compliance reporting and incident correlation.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Toolbox meetings are conducted to brief workers on the SWMS applicable to the work being performed. toolbox_meeting has swms_reference_number (STRING) which is a denormalized text reference. Adding sw',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Toolbox meetings are conducted per subcontractor trade group on construction sites. Linking to vendor enables tracking HSE communication compliance per subcontractor, which is a direct input to vendor',
    `actual_attendee_count` STRING COMMENT 'Actual number of workers who attended and signed off on the Toolbox Meeting. Used to compute attendance rate and demonstrate safety communication compliance under OSHA and ISO 45001.',
    `attendance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of planned attendees who actually attended and signed off on the Toolbox Meeting (actual_attendee_count / planned_attendee_count × 100). Key HSE KPI for safety communication coverage reporting.',
    `control_measures_communicated` STRING COMMENT 'Description of the specific hazard control measures (elimination, substitution, engineering controls, administrative controls, PPE) communicated to attendees. Demonstrates hierarchy-of-controls compliance per ISO 45001 Clause 8.1.2.',
    `corrective_action_raised` BOOLEAN COMMENT 'Indicates whether any corrective actions or follow-up items were raised as a result of the Toolbox Meeting (e.g., identified hazards requiring remediation, equipment defects reported). Triggers workflow in Intelex for corrective action tracking.',
    `corrective_action_reference` STRING COMMENT 'Reference number of the corrective action record raised in Intelex as a result of issues identified during the Toolbox Meeting. Enables traceability between TBM findings and corrective action closure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the Toolbox Meeting record was first created in the source system (Intelex) or ingested into the lakehouse silver layer. Supports audit trail and data lineage requirements.',
    `toolbox_meeting_description` STRING COMMENT '',
    `document_attachment_reference` STRING COMMENT 'Reference identifier or URL to supporting documents attached to the Toolbox Meeting record in Intelex or Aconex (e.g., signed attendance sheet, topic handout, SWMS extract). Supports document control under ISO 45001 Clause 7.5.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Actual duration of the Toolbox Meeting in minutes as recorded by the facilitator. Supports quality assurance checks to ensure meetings meet minimum required duration thresholds.',
    `emergency_procedures_reviewed` BOOLEAN COMMENT 'Indicates whether emergency response procedures (evacuation routes, muster points, emergency contacts) were reviewed with attendees during the Toolbox Meeting.',
    `end_time` TIMESTAMP COMMENT 'Date and timestamp when the Toolbox Meeting concluded. Used in conjunction with start_time to compute actual meeting duration for compliance and quality reporting.',
    `facilitator_name` STRING COMMENT 'Full name of the person who facilitated the Toolbox Meeting (supervisor, HSE officer, or foreman). Retained for accountability and regulatory audit purposes. Classified as confidential as it identifies an employee.',
    `facilitator_qualification` STRING COMMENT 'HSE qualification or certification held by the meeting facilitator (e.g., OSHA 30-Hour, ISO 45001 Lead Auditor, First Aid). Supports competency verification requirements under ISO 45001 Clause 7.2.',
    `hazards_highlighted` STRING COMMENT 'Description of the specific site hazards communicated to attendees during the Toolbox Meeting, drawn from the linked risk assessment or SWMS (Safe Work Method Statement). Supports evidence of hazard communication under OSHA and ISO 45001.',
    `hse_topic_category` STRING COMMENT 'Primary HSE topic category covered in the Toolbox Meeting (e.g., Working at Heights, Confined Space, Electrical Safety, Manual Handling, Environmental Compliance). Used for topic frequency analysis and gap identification. [ENUM-REF-CANDIDATE: working_at_heights|confined_space|electrical_safety|manual_handling|environmental|fire_prevention|excavation|crane_lifting|ppe_compliance|chemical_handling — promote to reference product]',
    `incident_review_included` BOOLEAN COMMENT 'Indicates whether a review of recent incidents, near-misses, or LTI (Lost Time Injury) events was included in the Toolbox Meeting agenda. Supports learning-from-incidents culture and ISO 45001 Clause 10.2 requirements.',
    `intelex_record_reference` STRING COMMENT 'Native record identifier from the Intelex HSE Management system from which this Toolbox Meeting record was sourced. Used for data lineage, reconciliation, and back-reference to the operational system of record.',
    `interpreter_required` BOOLEAN COMMENT 'Indicates whether an interpreter or translator was required and used during the Toolbox Meeting to communicate safety information to non-English-speaking workers.',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this Toolbox Meeting record is required to be included in regulatory compliance reports submitted to OSHA, EPA, or other governing bodies. Drives automated regulatory reporting workflows.',
    `language_conducted` STRING COMMENT 'ISO 639-2 three-letter language code for the primary language in which the Toolbox Meeting was conducted. Supports multilingual workforce compliance and OSHA Hazard Communication requirements for non-English-speaking workers.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the Toolbox Meeting record in the source system or lakehouse. Supports change tracking, audit compliance, and incremental data loading.',
    `meeting_date` DATE COMMENT 'Calendar date on which the Toolbox Meeting was conducted. Used for scheduling compliance checks, frequency reporting, and OSHA recordkeeping.',
    `meeting_location` STRING COMMENT 'Physical location or area on the construction site where the Toolbox Meeting was held (e.g., site office, work front, laydown area, specific grid reference). Supports site-level HSE reporting.',
    `meeting_reference_number` STRING COMMENT 'Externally-known unique business identifier for the Toolbox Meeting as assigned by the HSE management system (Intelex). Used for cross-referencing in safety registers, audit trails, and regulatory submissions.. Valid values are `^TBM-[A-Z0-9]{2,10}-[0-9]{4,8}$`',
    `meeting_status` STRING COMMENT 'Current lifecycle status of the Toolbox Meeting record. Drives workflow in Intelex and determines whether the meeting counts toward HSE compliance metrics.. Valid values are `draft|scheduled|completed|cancelled|pending_review`',
    `meeting_type` STRING COMMENT 'Classification of the Toolbox Meeting by its operational purpose. Pre-shift meetings occur at the start of each work shift; pre-task meetings are conducted immediately before a specific high-risk activity begins.. Valid values are `pre_shift|pre_task|weekly_safety|emergency|visitor_induction`',
    `planned_attendee_count` STRING COMMENT 'Number of workers expected to attend the Toolbox Meeting based on the crew deployment plan. Used to calculate attendance rate and identify gaps in safety communication coverage.',
    `ppe_requirements_communicated` BOOLEAN COMMENT 'Indicates whether PPE (Personal Protective Equipment) requirements specific to the work activity were communicated to attendees during the Toolbox Meeting. Supports PPE compliance tracking under OSHA PPE standards.',
    `ptw_reference_number` STRING COMMENT 'Reference number of the Permit to Work (PTW) associated with this Toolbox Meeting, where the meeting was conducted as part of the PTW pre-work briefing process.',
    `remarks` STRING COMMENT '',
    `sign_off_method` STRING COMMENT 'Method used to capture attendee acknowledgement and sign-off for the Toolbox Meeting. Determines the evidentiary value of the attendance record for regulatory compliance purposes.. Valid values are `paper_signature|digital_signature|biometric|verbal_acknowledgement`',
    `start_time` TIMESTAMP COMMENT 'Date and timestamp when the Toolbox Meeting commenced. Used to verify pre-shift or pre-task timing compliance and to calculate meeting duration.',
    `toolbox_meeting_status` STRING COMMENT '',
    `topics_discussed` STRING COMMENT 'Free-text or structured summary of the safety topics covered during the Toolbox Meeting, including hazard types, regulatory requirements, and site-specific risks communicated to the crew. Sourced from Intelex TBM topic fields.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `wbs_element_code` STRING COMMENT 'WBS (Work Breakdown Structure) element code from Oracle Primavera P6 identifying the specific work package or activity for which this Toolbox Meeting was conducted. Enables linkage of HSE communication to project schedule activities.',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions at the time of the Toolbox Meeting. Relevant for outdoor construction sites where weather-related hazards (heat stress, lightning, high winds) are discussed as part of the meeting agenda. [ENUM-REF-CANDIDATE: clear|cloudy|rain|high_wind|extreme_heat|fog|storm — 7 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_toolbox_meeting PRIMARY KEY(`toolbox_meeting_id`)
) COMMENT 'Toolbox Meeting (TBM) records capturing pre-shift and pre-task safety briefings conducted on construction sites. Records meeting date, time, location, project/site, crew/trade group, topics discussed (linked to site hazards from risk_assessment), hazards highlighted, specific control measures communicated, attendee list with sign-off confirmation, facilitator name, and duration. Supports demonstration of safety communication compliance under OSHA and ISO 45001 clause 7.4 (Communication). Attendance records are embedded as line items within the meeting record. Sourced from Intelex.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`hse_plan` (
    `hse_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the project-level HSE Plan record. Primary key for the hse_plan data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: HSE plans are client‑specific documents; associating them with the client account enables client‑wide HSE performance dashboards.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Client HSE Representative Approval process: construction contracts require a named client HSE contact to review, approve, and receive notifications for the project HSE plan. Role-prefix client_hse_ ',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this HSE Plan is the governing safety management framework document.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: HSE plans have defined budget allocations within the project budget (safety training, PPE, audits, emergency equipment). Project controllers and HSE managers link HSE plans to budget lines for cost co',
    `applicable_regulations` STRING COMMENT 'Comma-separated list of regulatory frameworks, standards, and governing body requirements applicable to this HSE Plan (e.g., OSHA 29 CFR 1926, ISO 45001:2018, ISO 14001:2015, NFPA 70E, local jurisdiction building codes). Drives compliance obligation tracking.',
    `approval_date` DATE COMMENT 'Date on which the HSE Plan was formally approved by the authorised approver (typically the Project HSE Manager or Client representative). Marks the transition from draft/review to approved status.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the authorised person who formally approved this version of the HSE Plan. Typically the Project Director, HSE Director, or Client HSE Representative.',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which formal HSE audits must be conducted on the project as specified in the HSE Plan. Drives the audit schedule in Intelex and ensures compliance with ISO 45001 internal audit requirements.',
    `client_hse_requirements` STRING COMMENT 'Summary of client-specific HSE requirements and standards that must be incorporated into the project HSE Plan, beyond the contractors standard requirements. Sourced from the contract HSE specification or client HSE management system.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction in which the construction site operates. Determines the applicable national HSE regulatory framework (e.g., USA, GBR, AUS, ARE).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HSE Plan record was first created in the system. Provides audit trail for record creation and supports data lineage tracking in the Databricks Silver Layer.',
    `hse_plan_description` STRING COMMENT '',
    `document_reference` STRING COMMENT 'Document management system reference or URL pointing to the full HSE Plan document stored in Aconex or the project document management system. Provides traceability to the source document.',
    `effective_date` DATE COMMENT 'Date from which this version of the HSE Plan becomes the binding governing document for the project. Aligns with the Notice to Proceed (NTP) or project mobilisation date for initial versions.',
    `emergency_contact_name` STRING COMMENT 'Name of the primary emergency response coordinator or HSE emergency contact for the project site. Referenced during incident response and emergency drills.',
    `emergency_contact_phone` STRING COMMENT 'Primary phone number for the site emergency response coordinator. Must be accessible 24/7 during active construction phases for incident notification and emergency mobilisation.',
    `environmental_aspects` STRING COMMENT 'Description of the significant environmental aspects and impacts identified for the project (e.g., noise, dust, stormwater runoff, waste management, soil contamination, protected species). Informs the environmental management controls within the HSE Plan.',
    `expiry_date` DATE COMMENT 'Date on which this version of the HSE Plan expires and must be reviewed or superseded. Nullable for open-ended plans that remain valid until explicitly superseded.',
    `hse_objective_description` STRING COMMENT 'Narrative description of the project-level HSE objectives and targets established for this plan period (e.g., zero LTI, TRIR below 0.5, 100% PPE compliance, zero environmental non-conformances). Aligns with corporate HSE KPI framework.',
    `hse_plan_status` STRING COMMENT '',
    `incident_reporting_procedure` STRING COMMENT 'Description or document reference number for the incident reporting and investigation procedure defined in the HSE Plan. Specifies notification timelines, investigation requirements, and regulatory reporting obligations (e.g., OSHA 300 log, fatality notification within 8 hours).',
    `induction_required` BOOLEAN COMMENT 'Indicates whether all personnel must complete a formal site HSE induction before commencing work on the project, as mandated by the HSE Plan. When true, no worker may access the site without a valid induction record.',
    `leed_applicable` BOOLEAN COMMENT 'Indicates whether the project is targeting LEED (Leadership in Energy and Environmental Design) certification, which imposes additional environmental management requirements on the HSE Plan including construction waste management, indoor air quality, and erosion control.',
    `lti_target` DECIMAL(18,2) COMMENT 'Target number of Lost Time Injuries (LTI) for the project duration as defined in the HSE Plan. Typically set to zero for major construction projects. Used as a benchmark for HSE performance reporting.',
    `muster_point_description` STRING COMMENT 'Description and location of the designated emergency assembly/muster point(s) for the construction site. Critical for emergency evacuation procedures and headcount verification.',
    `nearest_hospital` STRING COMMENT 'Name and address of the nearest hospital or medical facility to the construction site. Mandatory field for emergency response planning and first aid procedures documentation.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the HSE Plan. Drives the review calendar and ensures the plan remains current with site conditions, regulatory changes, and project phase transitions.',
    `plan_number` STRING COMMENT 'Externally-known unique document control number assigned to the HSE Plan, used for referencing in correspondence, audits, and regulatory submissions. Typically follows the project document numbering convention (e.g., HSE-PRJ001-2024-001).. Valid values are `^HSE-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the HSE Plan document. Controls whether the plan is the active governing document for site operations. approved indicates the plan is the current SSOT for project HSE governance.. Valid values are `draft|under_review|approved|superseded|cancelled`',
    `plan_title` STRING COMMENT 'Official title of the HSE Plan document as it appears on the cover page and in the document register (e.g., Project HSE Management Plan — Highway 7 Extension).',
    `plan_type` STRING COMMENT 'Classification of the HSE Plan by scope and purpose. Distinguishes between overarching project-level plans, site-specific plans, environmental management plans, emergency response plans, and construction phase plans. [ENUM-REF-CANDIDATE: project_hse_plan|site_specific_hse_plan|environmental_management_plan|emergency_response_plan|construction_phase_plan|occupational_health_plan — promote to reference product]. Valid values are `project_hse_plan|site_specific_hse_plan|environmental_management_plan|emergency_response_plan|construction_phase_plan`',
    `plan_version` STRING COMMENT 'Document version number of the HSE Plan following the project document control versioning convention (e.g., 1.0, 2.1, 3.0). Incremented upon each approved revision.. Valid values are `^[0-9]{1,3}.[0-9]{1,2}$`',
    `ppe_requirements` STRING COMMENT 'Description of the mandatory Personal Protective Equipment (PPE) requirements applicable across the project site as defined in the HSE Plan (e.g., hard hat, safety boots, hi-vis vest, safety glasses, gloves). Site-wide minimum PPE standard.',
    `prepared_by` STRING COMMENT 'Name or employee identifier of the HSE professional who authored and prepared this version of the HSE Plan. Typically the Project HSE Manager or HSE Coordinator.',
    `project_phase` STRING COMMENT 'Construction project phase to which this HSE Plan version primarily applies. HSE requirements and hazard profiles differ significantly across project phases.. Valid values are `pre_construction|mobilisation|construction|commissioning|demobilisation`',
    `ptw_required` BOOLEAN COMMENT 'Indicates whether a formal Permit to Work (PTW) system is mandated on this project as per the HSE Plan. When true, designated high-risk activities (hot work, confined space entry, electrical isolation, working at height) require a PTW before commencement.',
    `remarks` STRING COMMENT '',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which the HSE Plan must be formally reviewed and updated. Typically 6 or 12 months, or triggered by significant project phase changes, incidents, or regulatory updates.',
    `risk_rating` STRING COMMENT 'Overall HSE risk rating assigned to the project based on the site hazard assessment. Drives the level of HSE oversight, inspection frequency, and resource allocation required.. Valid values are `low|medium|high|critical`',
    `site_location` STRING COMMENT 'Physical address or geographic description of the primary construction site covered by this HSE Plan. Used for emergency response coordination and regulatory jurisdiction determination.',
    `site_specific_hazards` STRING COMMENT 'Narrative description of the key site-specific hazards identified for this project (e.g., working at height, confined spaces, high-voltage proximity, ground contamination, extreme weather, traffic management). Informs the risk control hierarchy documented in the plan.',
    `subcontractor_hse_requirements` STRING COMMENT 'Description of the HSE requirements imposed on subcontractors working under this project HSE Plan, including pre-qualification criteria, SWMS submission requirements, induction obligations, and compliance monitoring expectations.',
    `swms_required` BOOLEAN COMMENT 'Indicates whether Safe Work Method Statements (SWMS) are mandated for high-risk construction work activities on this project as per the HSE Plan. When true, SWMS must be prepared and approved before commencing designated high-risk activities.',
    `tbm_frequency` STRING COMMENT 'Required frequency of Toolbox Meetings (TBM) as mandated by the HSE Plan. TBMs are pre-work safety briefings conducted with the workforce to communicate hazards, controls, and daily work instructions.. Valid values are `daily|weekly|per_shift|as_required`',
    `trir_target` DECIMAL(18,2) COMMENT 'Target Total Recordable Incident Rate (TRIR) for the project as defined in the HSE Plan. Expressed per 200,000 man-hours worked. Used as the primary lagging indicator for HSE performance benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HSE Plan record was last modified in the system. Supports change tracking, audit trail requirements, and incremental data loading in the Databricks Silver Layer.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_hse_plan PRIMARY KEY(`hse_plan_id`)
) COMMENT 'Project-level HSE (Health Safety Environment) Plan master record defining the safety management framework for a specific construction project. Captures plan version, approval status, applicable regulations, site-specific hazards, emergency response procedures, HSE objectives and targets, organizational responsibilities, and review schedule. SSOT for project HSE governance documentation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique surrogate identifier for each risk assessment record in the hazard and risk register. Primary key for the risk_assessment data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Risk assessments for tasks must reference the exact equipment used to evaluate equipment‑related risks and control measures.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: BIM-based safety planning uses the model for spatial hazard identification including clash detection, confined space mapping, and fall risk analysis. ISO 19650-compliant projects require risk assessme',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Risk assessments are performed for client projects; linking to the client account allows aggregation of risk metrics at the client level.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Client Risk Acknowledgement process: on client-owned sites, the clients nominated HSE representative must formally review and acknowledge high-risk assessments. Role-prefix client_approver_ disting',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project against which this risk assessment is registered. Links the hazard record to the project portfolio.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Risk mitigation actions have budgeted costs; assigning a cost_center allows integration with risk‑based budgeting reports.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Risk assessments are spatially referenced to construction drawings to identify location-specific hazards (confined spaces, fall heights, structural elements). Safety engineers reference the relevant d',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Risk assessments are conducted as part of the project HSE Plans hazard management framework. The HSE plan defines the risk management approach, risk matrix version, and assessment requirements. Addin',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Risk assessments evaluate hazards of specific materials; linking provides material specs for accurate risk calculations.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Risk assessments are conducted for subcontractor-specific work packages. Subcontractor prequalification, safety compliance audits, and subcontract close-out require linking risk assessments to the gov',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Risk assessments for construction activities must review technical specifications to identify hazardous materials, chemical exposures, and process-specific risks. HSE regulatory compliance requires ri',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Risk assessments in construction are scoped to specific subcontractors performing work packages. Vendor-specific risk assessments are required for contractor HSE prequalification reviews and feed dire',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element or work package to which this hazard and risk assessment applies, enabling task-level risk traceability.',
    `activity_description` STRING COMMENT 'Description of the specific construction activity, task, or work scope during which the hazard is present or could be realised. Supports Job Hazard Analysis (JHA) documentation.',
    `approval_date` DATE COMMENT 'Date on which the risk assessment was formally reviewed and approved by the authorised approver.',
    `approved_by` STRING COMMENT 'Name of the authorised approver (typically HSE Manager or Project Manager) who reviewed and formally approved this risk assessment record.',
    `assessed_by` STRING COMMENT 'Name of the HSE professional, engineer, or competent person who conducted and documented this risk assessment.',
    `assessment_date` DATE COMMENT 'The date on which this risk assessment was formally conducted and documented. Represents the principal business event date for this record.',
    `assessment_number` STRING COMMENT 'Externally-known unique alphanumeric reference number assigned to this risk assessment record, used in SWMS, PTW, and HSE correspondence. Format: RA-{ProjectCode}-{Sequence}.. Valid values are `^RA-[A-Z0-9]{3,10}-[0-9]{4,6}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment record: Open (hazard identified, controls not yet fully implemented), Controlled (controls in place, residual risk tolerable), Eliminated (hazard fully removed), Closed (no longer applicable), or Under Review (being reassessed).. Valid values are `open|controlled|eliminated|closed|under_review`',
    `assessment_type` STRING COMMENT 'Classification of the purpose and context of this risk assessment: Job Hazard Analysis (JHA) for task-level evaluation, SWMS support, PTW issuance support, design review, field inspection, or derived from an incident investigation.. Valid values are `jha|swms|ptw_support|design_review|inspection|incident_derived`',
    `control_hierarchy` STRING COMMENT 'Highest level of the Hierarchy of Controls applied to this hazard: Eliminate, Substitute, Engineering controls, Administrative controls, or Personal Protective Equipment (PPE). Reflects the most effective control measure in place.. Valid values are `eliminate|substitute|engineering|administrative|ppe`',
    `control_measures` STRING COMMENT 'Detailed narrative of all control measures implemented to eliminate or reduce the risk, including engineering controls, administrative procedures, PPE requirements, and any combination of controls applied.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action has been raised against this risk assessment due to inadequate controls or elevated residual risk (True = corrective action required). Triggers workflow in Intelex.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was first created in the system. Supports audit trail and data lineage requirements.',
    `risk_assessment_description` STRING COMMENT '',
    `environmental_aspect` BOOLEAN COMMENT 'Indicates whether this risk assessment includes an environmental aspect or impact in addition to occupational health and safety considerations (True = environmental component present). Supports ISO 14001 compliance.',
    `environmental_impact_description` STRING COMMENT 'Description of the environmental impact or aspect associated with this hazard, where applicable (e.g., soil contamination from chemical spill, noise pollution, stormwater runoff). Populated when environmental_aspect is True.',
    `hazard_description` STRING COMMENT 'Detailed narrative description of the identified hazard, including the source, agent, or condition that has the potential to cause harm or adverse health effects.',
    `hazard_type` STRING COMMENT 'Classification of the hazard category identified in this assessment. [ENUM-REF-CANDIDATE: fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure|environmental|fire_explosion|manual_handling|noise_vibration|biological|radiation — promote to reference product]',
    `initial_consequence` STRING COMMENT 'Consequence/severity score assigned before control measures are applied, rated on the project risk matrix scale (typically 1–5: 1=Insignificant, 2=Minor, 3=Moderate, 4=Major, 5=Catastrophic).',
    `initial_likelihood` STRING COMMENT 'Likelihood score assigned before control measures are applied, rated on the project risk matrix scale (typically 1–5: 1=Rare, 2=Unlikely, 3=Possible, 4=Likely, 5=Almost Certain).',
    `initial_risk_level` STRING COMMENT 'Qualitative risk band derived from the initial risk score using the project risk matrix (e.g., Low, Medium, High, Extreme). Used for prioritisation and reporting before controls are applied.. Valid values are `low|medium|high|extreme`',
    `initial_risk_score` STRING COMMENT 'Pre-control risk score calculated as the product of initial likelihood and initial consequence ratings (Likelihood × Consequence). Represents the inherent risk level before any controls are applied.',
    `intelex_record_reference` STRING COMMENT 'Unique identifier of the corresponding record in the Intelex HSE Management system, used for data lineage, reconciliation, and cross-system traceability between the lakehouse and the operational system of record.',
    `last_reviewed_date` DATE COMMENT 'Date on which this risk assessment record was most recently reviewed and updated. Supports audit trail and demonstrates ongoing management of the living hazard register.',
    `next_review_date` DATE COMMENT 'Scheduled date by which this risk assessment must be reviewed and updated to ensure continued relevance and effectiveness of control measures. Triggered by elapsed time, scope change, or incident.',
    `ppe_requirements` STRING COMMENT 'Specific Personal Protective Equipment (PPE) items mandated for personnel performing the activity associated with this hazard (e.g., hard hat, safety harness, chemical-resistant gloves, respirator, safety glasses).',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory standard, clause, or legal obligation that this risk assessment addresses (e.g., OSHA 29 CFR 1926.502 Fall Protection, ISO 45001 Clause 6.1.2, EPA 40 CFR). Supports compliance reporting.',
    `remarks` STRING COMMENT '',
    `residual_consequence` STRING COMMENT 'Consequence/severity score after all control measures have been applied, rated on the project risk matrix scale (typically 1–5). Reflects the remaining severity of harm post-control.',
    `residual_likelihood` STRING COMMENT 'Likelihood score after all control measures have been applied, rated on the project risk matrix scale (typically 1–5). Reflects the remaining probability of the hazard being realised post-control.',
    `residual_risk_level` STRING COMMENT 'Qualitative risk band derived from the residual risk score using the project risk matrix (e.g., Low, Medium, High, Extreme). Determines whether the risk is tolerable and whether additional controls are required.. Valid values are `low|medium|high|extreme`',
    `residual_risk_score` STRING COMMENT 'Post-control risk score calculated as the product of residual likelihood and residual consequence ratings (Likelihood × Consequence). Represents the remaining risk after all controls are applied.',
    `responsible_party_role` STRING COMMENT 'Job role or organisational function of the person responsible for implementing and monitoring the control measures associated with this risk assessment.. Valid values are `hse_officer|site_supervisor|project_manager|subcontractor|engineer|foreman`',
    `risk_assessment_status` STRING COMMENT '',
    `risk_matrix_version` STRING COMMENT 'Version identifier of the project or corporate risk matrix used to score likelihood and consequence for this assessment. Ensures consistent interpretation of risk scores across assessments and over time.',
    `site_zone` STRING COMMENT 'Specific site area, zone, level, or grid reference where the hazard exists or the activity is performed (e.g., Zone A, Level 3, Grid B4, Excavation Area 2).',
    `source_type` STRING COMMENT 'Origin or trigger that led to the identification and recording of this hazard — e.g., field inspection, incident investigation, design review, JHA session, HSE audit, near-miss report, or Toolbox Meeting (TBM). [ENUM-REF-CANDIDATE: inspection|incident|design_review|jha|audit|near_miss|toolbox_meeting — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was most recently modified. Supports change tracking, audit trail, and the living hazard register update cycle.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Unified hazard and risk register serving as the single source of truth for all identified hazards and their risk evaluations across construction project sites. Captures hazard identification (type: fall, struck-by, caught-between, electrocution, excavation collapse, chemical exposure, environmental), activity/task scope, site location/zone, initial risk rating (likelihood x consequence matrix), control hierarchy applied (eliminate/substitute/engineer/admin/PPE), residual risk rating, control measures in place, responsible party, status (open/controlled/eliminated/closed), source (inspection/incident/design review/JHA), review date, and approver. Serves triple purpose: (1) formal risk assessment for specific activities supporting SWMS development and PTW issuance, (2) live site hazard inventory (hazard register) supporting daily pre-start briefings and toolbox meeting topic selection, and (3) Job Hazard Analysis (JHA) documentation for task-level risk evaluation. Maintains hazard register entries as living records updated through inspections, incidents, and periodic reviews. SSOT for all identified hazards, risk evaluations, and control effectiveness across the project portfolio.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`hazard_register` (
    `hazard_register_id` BIGINT COMMENT 'Unique system-generated identifier for each hazard record in the site hazard register. Primary key for the hazard_register data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project on which this hazard was identified. Links the hazard to the project master record for site-level hazard visibility and project-level HSE reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Hazard mitigation budgets are charged to specific cost_centers; linking enables hazard‑related cost roll‑up in financial statements.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Hazard register entries are spatially referenced to construction drawings to enable location-based hazard reporting and site safety management. Safety managers use drawing references to communicate ha',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: The hazard register is maintained as a core deliverable of the project HSE Plan. The HSE plan defines the site-specific hazards (site_specific_hazards) and the hazard register operationalizes this by ',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Required for Hazard Register to associate each hazard entry with the master material record for regulatory reporting and traceability.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: The hazard register is the live inventory of identified hazards; risk assessments are the formal evaluations of those hazards. Each hazard register entry should reference its primary/current risk asse',
    `site_id` BIGINT COMMENT 'Reference to the specific construction site where the hazard exists. Supports site-level hazard visibility and pre-start briefing content selection.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Hazards in the register are controlled via Safe Work Method Statements. hazard_register has swms_reference (STRING) which is a denormalized text reference. Adding swms_id as a proper FK to safety.swms',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Hazards introduced by specific subcontractors (equipment, methods, materials) must be tracked against the responsible vendor. This enables vendor HSE performance reporting, feeds prequalification scor',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Hazards are identified and registered at specific work fronts. location_description is a denormalized text field. Linking enables work-front-level hazard register reporting — pre-start safety checks',
    `actual_closure_date` DATE COMMENT 'Date on which the hazard was verified as eliminated or controlled to an acceptable residual risk level and the record was formally closed. Null if the hazard remains open or controlled.',
    `affected_workers_count` STRING COMMENT 'Estimated number of workers potentially exposed to this hazard during normal site operations. Used for exposure assessment, risk prioritisation, and OSHA regulatory reporting.',
    `control_measures_description` STRING COMMENT 'Narrative description of all control measures currently in place to manage the hazard, including engineering controls, administrative procedures, PPE requirements, and permit conditions. Sourced from Intelex corrective actions and SWMS documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the hazard record was first created in the data platform. Supports audit trail, data lineage, and regulatory record-keeping requirements.',
    `hazard_register_description` STRING COMMENT '',
    `environmental_aspect` BOOLEAN COMMENT 'Indicates whether this hazard also constitutes an environmental aspect with potential environmental impact (e.g., chemical spill risk, dust generation, noise pollution). True = environmental aspect present. Supports ISO 14001 environmental management integration.',
    `hazard_category` STRING COMMENT 'Broad category grouping the hazard by agent type for aggregate HSE reporting and trend analysis. Supports ISO 45001 hazard identification and risk assessment processes.. Valid values are `physical|chemical|biological|ergonomic|environmental|psychosocial`',
    `hazard_description` STRING COMMENT 'Detailed narrative describing the nature of the hazard, the conditions under which it exists, and the potential harm it could cause. Supports risk assessment documentation and SWMS (Safe Work Method Statement) preparation.',
    `hazard_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the hazard record, used in HSE correspondence, toolbox meeting (TBM) briefings, and regulatory submissions. Sourced from Intelex HSE Management system.. Valid values are `^HAZ-[A-Z0-9]{3,10}-[0-9]{4,6}$`',
    `hazard_register_status` STRING COMMENT '',
    `hazard_status` STRING COMMENT 'Current lifecycle status of the hazard record. open = identified but controls not yet fully implemented; controlled = controls in place and residual risk is tolerable; eliminated = hazard has been fully removed; closed = record closed after verification. Drives the live hazard inventory for site visibility.. Valid values are `open|controlled|eliminated|closed`',
    `hazard_title` STRING COMMENT 'Short, human-readable title describing the hazard (e.g., Unguarded floor opening — Level 3, Overhead power line proximity — Zone B). Used in pre-start briefings and toolbox meeting topic selection.',
    `hazard_type` STRING COMMENT 'Classification of the hazard by primary injury mechanism aligned with OSHA Fatal Four and construction industry taxonomy. Values: fall (working at height), struck_by (moving objects/vehicles), caught_between (pinch/crush points), electrocution (electrical contact), excavation_collapse (trench/shoring failure), chemical_exposure (hazardous substances). [ENUM-REF-CANDIDATE: fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure|fire_explosion|noise|manual_handling|biological — promote to reference product]. Valid values are `fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure`',
    `hierarchy_of_controls` STRING COMMENT 'Highest level of the hierarchy of controls applied to manage this hazard, per ISO 45001 and OSHA guidance. Values: elimination (remove hazard), substitution (replace with lesser hazard), engineering (physical barriers/guards), administrative (procedures/training), ppe (Personal Protective Equipment). Drives control effectiveness assessment.. Valid values are `elimination|substitution|engineering|administrative|ppe`',
    `identification_source` STRING COMMENT 'The originating activity or process through which the hazard was identified. Supports root-cause analysis and evaluation of hazard identification program effectiveness. Values: risk_assessment, inspection, incident, audit, near_miss, worker_report.. Valid values are `risk_assessment|inspection|incident|audit|near_miss|worker_report`',
    `identified_date` DATE COMMENT 'Calendar date on which the hazard was first identified and recorded. Used for ageing analysis, regulatory compliance timelines, and trend reporting.',
    `initial_consequence_rating` STRING COMMENT 'Numeric consequence/severity score assigned during initial risk assessment before controls are applied, typically on a 1–5 scale (1=Insignificant, 5=Catastrophic). Component of the initial risk rating matrix (likelihood × consequence).',
    `initial_likelihood_rating` STRING COMMENT 'Numeric likelihood score assigned during initial risk assessment before controls are applied, typically on a 1–5 scale (1=Rare, 5=Almost Certain). Component of the initial risk rating matrix (likelihood × consequence).',
    `initial_risk_level` STRING COMMENT 'Qualitative risk band derived from the initial risk score (e.g., low, medium, high, critical). Used for risk prioritisation, escalation thresholds, and executive HSE dashboards.. Valid values are `low|medium|high|critical`',
    `initial_risk_score` STRING COMMENT 'Pre-control risk score calculated as the product of initial_likelihood_rating × initial_consequence_rating. Represents the inherent risk level before any control measures are applied. Used to prioritise hazard treatment actions.',
    `intelex_record_reference` STRING COMMENT 'Source system record identifier from the Intelex HSE Management platform. Used for data lineage, reconciliation, and bi-directional synchronisation between the Databricks Silver layer and the operational Intelex system.',
    `last_review_date` DATE COMMENT 'Date on which the hazard record was most recently reviewed and updated by the responsible HSE officer or site supervisor. Supports periodic review compliance requirements under ISO 45001 and regulatory obligations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the hazard record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this hazard record. Drives automated review reminders and overdue review reporting in the Intelex HSE system.',
    `permit_to_work_required` BOOLEAN COMMENT 'Indicates whether a Permit to Work (PTW) is mandatory before any work activity associated with this hazard can commence. True = PTW required (e.g., confined space entry, hot work, electrical isolation). Integrates with Intelex Permit to Work module.',
    `ppe_requirements` STRING COMMENT 'Specific PPE items mandated for workers operating in proximity to this hazard (e.g., Hard hat, safety harness, hi-vis vest, safety glasses). Supports PPE compliance checks during pre-start briefings and site inspections.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether this hazard requires formal notification to a regulatory authority (e.g., OSHA, EPA) due to its nature or severity. True = notification required. Supports regulatory compliance workflow management.',
    `remarks` STRING COMMENT '',
    `residual_consequence_rating` STRING COMMENT 'Numeric consequence/severity score after all control measures have been applied, on the same 1–5 scale as initial_consequence_rating. Reflects the effectiveness of controls in reducing severity of potential harm.',
    `residual_likelihood_rating` STRING COMMENT 'Numeric likelihood score after all control measures have been applied, on the same 1–5 scale as initial_likelihood_rating. Reflects the effectiveness of controls in reducing probability of harm.',
    `residual_risk_level` STRING COMMENT 'Qualitative risk band derived from the residual risk score after controls are applied. Determines whether the hazard is tolerable (low/medium) or requires escalation and further treatment (high/critical).. Valid values are `low|medium|high|critical`',
    `residual_risk_score` STRING COMMENT 'Post-control risk score calculated as residual_likelihood_rating × residual_consequence_rating. Represents the remaining risk after controls are applied. Used to determine if the risk is tolerable or requires further treatment.',
    `responsible_party` STRING COMMENT 'Name or role of the individual or team accountable for implementing and maintaining the control measures for this hazard (e.g., Site Supervisor — Civil Works, HSE Manager). Supports accountability tracking and corrective action follow-up.',
    `site_zone` STRING COMMENT 'Designated zone, area, or work front on the construction site where the hazard is located (e.g., Zone A — Excavation, Level 4 — Formwork, Laydown Area 2). Used for spatial hazard mapping and pre-start briefing targeting.',
    `target_closure_date` DATE COMMENT 'Target date by which the hazard is expected to be eliminated or reduced to a tolerable residual risk level. Used for corrective action scheduling and overdue hazard reporting.',
    `tbm_topic_flag` BOOLEAN COMMENT 'Indicates whether this hazard has been selected or is recommended as a topic for an upcoming Toolbox Meeting (TBM). True = flagged for TBM discussion. Supports automated TBM topic selection from the live hazard register.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_hazard_register PRIMARY KEY(`hazard_register_id`)
) COMMENT 'Site-level hazard register maintaining a live inventory of identified hazards across construction project sites. Captures hazard type (fall, struck-by, caught-between, electrocution, excavation collapse, chemical exposure), location/zone, initial risk rating (likelihood x consequence), control measures in place, hierarchy of controls applied, responsible party, status (open/controlled/eliminated/closed), last review date, and source (risk assessment/inspection/incident). Serves as the operational SSOT for site hazard visibility, supports daily pre-start briefings, and feeds toolbox meeting topic selection.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`safety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`safety` SET TAGS ('dbx_domain' = 'safety');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `insurance_register_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Safe Work Method Statement (SWMS) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `corrective_action_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `days_restricted_or_transferred` SET TAGS ('dbx_business_glossary_term' = 'Days Restricted or Transferred (DART)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('dbx_business_glossary_term' = 'Environmental Media Affected');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('dbx_value_regex' = 'soil|groundwater|surface_water|air|none|multiple');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `immediate_cause` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause of Incident');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_review|closed|void');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_job_title` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Job Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Full Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_value_regex' = 'employee|subcontractor|visitor|public|third_party');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Nature of Injury or Illness');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `intelex_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Intelex Source Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `investigation_lead` SET TAGS ('dbx_business_glossary_term' = 'Investigation Lead Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_environmental_event` SET TAGS ('dbx_business_glossary_term' = 'Environmental Event Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_fit_for_duty` SET TAGS ('dbx_business_glossary_term' = 'Fitness for Duty Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_lti` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_osha_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `occurred_at` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurred At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `ppe_compliance` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `ppe_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable|unknown');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|notified|overdue');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `reported_at` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity Classification');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift at Time of Incident');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|not_applicable');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treating_physician` SET TAGS ('dbx_business_glossary_term' = 'Treating Physician Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treating_physician` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treatment_type` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|hospitalization|fatality|restricted_work|no_treatment');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions at Time of Incident');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `workers_comp_claim_ref` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `workers_comp_claim_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|verified');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Summary');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `immediate_cause` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_classification` SET TAGS ('dbx_business_glossary_term' = 'Incident Classification');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_value_regex' = 'direct_employee|subcontractor|visitor|public|other');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `intelex_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Intelex Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_close_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_methodology` SET TAGS ('dbx_value_regex' = '5_why|fishbone|bowtie|fault_tree|taproot|other');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_review|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_team_members` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team Members');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'formal|informal|regulatory|internal');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `is_lti` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `is_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Incident Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `lost_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Days');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `management_review_date` SET TAGS ('dbx_business_glossary_term' = 'Management Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `ppe_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `swms_in_place_flag` SET TAGS ('dbx_business_glossary_term' = 'Safe Work Method Statement (SWMS) In Place Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `systemic_cause` SET TAGS ('dbx_business_glossary_term' = 'Systemic Cause');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` SET TAGS ('dbx_subdomain' = 'risk_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Safe Work Method Statement (SWMS) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `aconex_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Aconex Document ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'High-Risk Activity Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'High-Risk Construction Activity Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `applicable_legislation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Legislation and Standards');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'SWMS Approval Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|superseded|archived');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SWMS Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `competency_requirements` SET TAGS ('dbx_business_glossary_term' = 'Worker Competency and Licence Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'SWMS Document URL');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `emergency_procedures` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedures');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `environmental_controls` SET TAGS ('dbx_business_glossary_term' = 'Environmental Control Measures');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'SWMS Expiry Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Identified Hazard Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_consequence` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_consequence` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_likelihood` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Rating (Before Controls)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `intelex_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Intelex HSE Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'SWMS Issue Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `plant_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Plant and Equipment Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ptw_required` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ptw_type` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ptw_type` SET TAGS ('dbx_value_regex' = 'hot_work|confined_space|electrical|excavation|working_at_heights|general');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_consequence` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_consequence` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_likelihood` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating (After Controls)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'SWMS Scheduled Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'SWMS Revision Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `swms_number` SET TAGS ('dbx_business_glossary_term' = 'Safe Work Method Statement (SWMS) Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `swms_number` SET TAGS ('dbx_value_regex' = '^SWMS-[A-Z0-9]{2,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `tbm_required` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'SWMS Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `work_steps` SET TAGS ('dbx_business_glossary_term' = 'Step-by-Step Work Procedure');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `worker_acknowledgement_required` SET TAGS ('dbx_business_glossary_term' = 'Worker Acknowledgement Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` SET TAGS ('dbx_subdomain' = 'risk_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Authority Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Permit Approval Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'supervisor|hse_manager|project_manager|site_director');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Closed Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `concurrent_permit_flag` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Permit Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `emergency_rescue_plan` SET TAGS ('dbx_business_glossary_term' = 'Emergency Rescue Plan Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Extension Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `gas_test_required` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `gas_test_result` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Result');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `gas_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_required');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identification Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `isolation_details` SET TAGS ('dbx_business_glossary_term' = 'Isolation Details Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `isolation_required` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Issued Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issuing_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Role');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `last_extended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Permit Extension Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('dbx_value_regex' = '^PTW-[A-Z0-9]{3,10}-[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `reinstatement_details` SET TAGS ('dbx_business_glossary_term' = 'Site Reinstatement Details');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Permit Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Permit Suspension Reason');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `tbm_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Conducted Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Permit Validity Expiry');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `work_location_description` SET TAGS ('dbx_business_glossary_term' = 'Work Location Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `work_scope` SET TAGS ('dbx_business_glossary_term' = 'Permitted Work Scope Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `worker_count` SET TAGS ('dbx_business_glossary_term' = 'Permitted Worker Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Permit Validity Start');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` SET TAGS ('dbx_subdomain' = 'risk_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting Identifier');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `actual_attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendee Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `attendance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Attendance Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `control_measures_communicated` SET TAGS ('dbx_business_glossary_term' = 'Control Measures Communicated');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `corrective_action_raised` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Raised');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `document_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Duration (Minutes)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `emergency_procedures_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procedures Reviewed');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) End Time');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Facilitator Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `facilitator_qualification` SET TAGS ('dbx_business_glossary_term' = 'Facilitator HSE Qualification');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hazards_highlighted` SET TAGS ('dbx_business_glossary_term' = 'Hazards Highlighted');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hse_topic_category` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Topic Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `incident_review_included` SET TAGS ('dbx_business_glossary_term' = 'Incident Review Included');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `intelex_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Intelex Source Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `interpreter_required` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `language_conducted` SET TAGS ('dbx_business_glossary_term' = 'Language Conducted');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `language_conducted` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_reference_number` SET TAGS ('dbx_value_regex' = '^TBM-[A-Z0-9]{2,10}-[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|completed|cancelled|pending_review');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_value_regex' = 'pre_shift|pre_task|weekly_safety|emergency|visitor_induction');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `planned_attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Attendee Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `ppe_requirements_communicated` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements Communicated');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `ptw_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `sign_off_method` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Sign-Off Method');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `sign_off_method` SET TAGS ('dbx_value_regex' = 'paper_signature|digital_signature|biometric|verbal_acknowledgement');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Start Time');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `topics_discussed` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Topics Discussed');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions at Meeting');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Hse Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Approval Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Approved By');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Audit Frequency (Months)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `client_hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Client Health Safety Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Document Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Effective Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `environmental_aspects` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspects');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Expiry Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `hse_objective_description` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Objective Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `incident_reporting_procedure` SET TAGS ('dbx_business_glossary_term' = 'Incident Reporting Procedure');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `induction_required` SET TAGS ('dbx_business_glossary_term' = 'Site HSE Induction Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `leed_applicable` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Applicable');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `lti_target` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Target');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `muster_point_description` SET TAGS ('dbx_business_glossary_term' = 'Muster Point Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `nearest_hospital` SET TAGS ('dbx_business_glossary_term' = 'Nearest Hospital');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Next Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^HSE-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|superseded|cancelled');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'project_hse_plan|site_specific_hse_plan|environmental_management_plan|emergency_response_plan|construction_phase_plan');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Version');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,2}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Prepared By');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'pre_construction|mobilisation|construction|commissioning|demobilisation');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `ptw_required` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Plan Review Frequency (Months)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Project Health Safety Environment (HSE) Risk Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `site_specific_hazards` SET TAGS ('dbx_business_glossary_term' = 'Site-Specific Hazards');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `subcontractor_hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Health Safety Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `swms_required` SET TAGS ('dbx_business_glossary_term' = 'Safe Work Method Statement (SWMS) Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `tbm_frequency` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Frequency');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `tbm_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|per_shift|as_required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `trir_target` SET TAGS ('dbx_business_glossary_term' = 'Total Recordable Incident Rate (TRIR) Target');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Approver Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity / Task Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Person Name)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessed By (Person Name)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^RA-[A-Z0-9]{3,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'open|controlled|eliminated|closed|under_review');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'jha|swms|ptw_support|design_review|inspection|incident_derived');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `control_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Control Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `control_hierarchy` SET TAGS ('dbx_value_regex' = 'eliminate|substitute|engineering|administrative|ppe');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `environmental_aspect` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `environmental_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_consequence` SET TAGS ('dbx_business_glossary_term' = 'Initial Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Initial Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `intelex_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Intelex Source Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_consequence` SET TAGS ('dbx_business_glossary_term' = 'Residual Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `responsible_party_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Role');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `responsible_party_role` SET TAGS ('dbx_value_regex' = 'hse_officer|site_supervisor|project_manager|subcontractor|engineer|foreman');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `risk_matrix_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Matrix Version');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `site_zone` SET TAGS ('dbx_business_glossary_term' = 'Site Zone / Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Source Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` SET TAGS ('dbx_subdomain' = 'risk_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `affected_workers_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Workers Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `control_measures_description` SET TAGS ('dbx_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `environmental_aspect` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_category` SET TAGS ('dbx_value_regex' = 'physical|chemical|biological|ergonomic|environmental|psychosocial');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Hazard Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_reference_number` SET TAGS ('dbx_value_regex' = '^HAZ-[A-Z0-9]{3,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_status` SET TAGS ('dbx_value_regex' = 'open|controlled|eliminated|closed');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_title` SET TAGS ('dbx_business_glossary_term' = 'Hazard Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hierarchy_of_controls` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy of Controls');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hierarchy_of_controls` SET TAGS ('dbx_value_regex' = 'elimination|substitution|engineering|administrative|ppe');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `identification_source` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identification Source');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `identification_source` SET TAGS ('dbx_value_regex' = 'risk_assessment|inspection|incident|audit|near_miss|worker_report');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identified Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_consequence_rating` SET TAGS ('dbx_business_glossary_term' = 'Initial Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Initial Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `intelex_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Intelex Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `permit_to_work_required` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_consequence_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `responsible_party` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `site_zone` SET TAGS ('dbx_business_glossary_term' = 'Site Zone');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `tbm_topic_flag` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Topic Flag');
