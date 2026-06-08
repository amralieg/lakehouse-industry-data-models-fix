-- Schema for Domain: hse | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`hse` COMMENT 'Manages Health, Safety, and Environment (HSE) compliance including incident reporting, permit-to-work (PTW), SIMOPS coordination, LDAR programs, NORM handling, H2S monitoring, GHG and ESG emissions tracking, spill reporting, environmental monitoring, and audit findings. Supports OSHA, EPA, BSEE, ISO 14001, and ISO 45001 regulatory compliance. Integrates with Enablon HSE Management for audit and compliance workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the HSE incident record. Primary key for the incident entity.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the specific facility, platform, refinery, plant, or rig where the incident occurred. Links to asset management master data.',
    `asset_id` BIGINT COMMENT 'Reference to the specific asset or equipment involved in the incident. Links to Maximo Asset Management CMMS for equipment history and maintenance records.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Incidents involving carriers reference carrier for vetting and performance scoring. Essential for carrier approval and contract renewal.',
    `charter_party_id` BIGINT COMMENT 'Foreign key linking to logistics.charter_party. Business justification: Incidents during charter party reference charter for liability and insurance claims. Essential for P&I reporting and demurrage disputes.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Incidents during contracted work (drilling, construction, maintenance) require contract reference for liability determination, insurance claims processing, contractor performance evaluation, and poten',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor company involved in the incident, if applicable. Used for contractor HSE performance evaluation and prequalification.',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key linking to petrochemical.conversion_unit. Business justification: Incidents often occur at specific process units (crackers, reformers). Investigation reports and equipment reliability analysis require identifying the exact conversion unit involved in the incident.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Incident costs (investigation, remediation, lost production) must be allocated to cost centers for HSE budget tracking and variance analysis. Standard oil-and-gas practice for incident cost accounting',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_order. Business justification: Incidents during delivery orders reference order for investigation and customer claims. Essential for liability determination and regulatory reporting.',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Incidents at exploration well sites (blowouts, H2S releases, equipment failures) require well linkage for investigation, regulatory reporting (BSEE, state agencies), trend analysis by well type/basin,',
    `employee_id` BIGINT COMMENT 'Reference to the employee who was injured in the incident, if applicable. Links to workforce master data for injury history and return-to-work tracking.',
    `incident_investigation_lead_employee_id` BIGINT COMMENT 'Reference to the employee assigned as lead investigator for the incident. Links to workforce master data for investigator qualifications and workload tracking.',
    `incident_observer_employee_id` BIGINT COMMENT 'Reference to the employee who observed or discovered the incident. Links to workforce master data. Critical for behavior-based safety program tracking.',
    `incident_reporter_employee_id` BIGINT COMMENT 'Reference to the employee who formally reported the incident into the HSE management system. May differ from observer for incidents reported through supervisory chain.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Incidents trigger cost recovery invoicing for cleanup, remediation, third-party claims, and regulatory penalties. Standard oil-and-gas practice: incident costs are allocated to responsible parties or ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Incidents at joint operations require JOA context for liability allocation, insurance claims, partner notification obligations, and cost recovery through joint account billing per COPAS standards.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Incidents occur on leased properties; regulatory reporting, liability determination, lease compliance verification, and lessor notification obligations require linking incidents to the specific lease.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Incidents often occur during permitted work activities; linking incident to PTW enables analysis of work-related incidents. Business reality: PTW violations or inadequate hazard controls during permit',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Incidents occur at specific petrochemical plants. Root cause analysis, regulatory reporting (OSHA 300, PSM), and safety performance metrics require linking incidents to the plant where they occurred.',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Turnarounds are high-risk periods with elevated incident rates. Safety management tracks incidents occurring during turnaround execution to assess turnaround safety performance and contractor manageme',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Incidents involving petroleum products (spills, releases, exposures) require product identification for regulatory reporting (NRC, EPA), material safety response planning, root cause analysis, and lia',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Incidents during pipeline nominations reference nomination for investigation and volume reconciliation. Essential for PHMSA reporting and liability determination.',
    `pipeline_throughput_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_throughput. Business justification: Incidents during pipeline throughput reference throughput for investigation and volume reconciliation. Essential for PHMSA reporting and liability determination.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Pre-drilling incidents during seismic acquisition, site surveys, or geotechnical work occur at prospect locations. Links incident to exploration target for risk profiling, future drilling hazard asses',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Incidents under PSA operations trigger government notification requirements, regulatory reporting obligations, and potential impact on cost recovery and profit oil calculations per production sharing ',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Incidents on ROW trigger specific reporting to ROW grantors, may affect ROW agreement terms, and require ROW-specific response protocols. Critical for grantor relations and ROW agreement compliance.',
    `storage_inventory_id` BIGINT COMMENT 'Foreign key linking to logistics.storage_inventory. Business justification: Incidents at storage facilities reference inventory for investigation and volume reconciliation. Essential for liability determination and regulatory reporting.',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Incidents at terminals reference terminal for facility safety records. Essential for OSHA reporting and operational approval.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Incidents occur on specific tracts; environmental impact assessments, surface owner notifications, geographic incident analysis, and tract-level remediation tracking require tract identification. Esse',
    `truck_ticket_id` BIGINT COMMENT 'Foreign key linking to logistics.truck_ticket. Business justification: Incidents during truck loading reference ticket for investigation and cost allocation. Essential for DOT reporting and liability determination.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Incidents involve specific partner personnel, assets, or operations; partner identification is required for liability determination, insurance claims processing, regulatory reporting, and JIB cost all',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Incidents on vessels reference vessel for fleet safety records. Essential for vetting status and P&I reporting.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well control events (kicks, blowouts), H2S releases, and well equipment failures require direct well linkage for state regulatory reporting, barrier failure analysis, and well-specific risk assessment',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the incident occurred. Determines applicable regulatory reporting requirements and HSE standards.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the incident record was first created in the data platform. Used for data lineage and audit trail.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the injured person was unable to work as a result of the incident, excluding the day of injury. Key metric for OSHA DART rate calculation.',
    `days_of_restricted_work` STRING COMMENT 'Number of calendar days the injured person was on restricted or light duty as a result of the incident. Used for OSHA DART rate calculation.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first discovered or observed. May differ from incident timestamp for delayed-discovery events such as chronic exposures or equipment failures.',
    `fatality_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in one or more fatalities. Triggers immediate OSHA and BSEE notification requirements.',
    `geographic_area` STRING COMMENT 'Geographic region or basin where the incident occurred. Used for regional HSE performance trending and regulatory jurisdiction determination.',
    `h2s_exposure_flag` BOOLEAN COMMENT 'Indicates whether the incident involved exposure to hydrogen sulfide gas, a highly toxic substance common in oil and gas operations. Requires specialized medical response and regulatory notification.',
    `immediate_action_taken` STRING COMMENT 'Description of immediate corrective actions taken at the time of the incident to prevent escalation, secure the scene, and protect personnel. Captured before formal investigation.',
    `incident_date` DATE COMMENT 'Calendar date when the HSE incident occurred. Used for trending, regulatory reporting, and performance indicator calculation.',
    `incident_number` STRING COMMENT 'Externally-known business identifier for the incident, typically generated by Enablon HSE Management system. Used for reporting and communication with regulatory bodies.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident record in the HSE management workflow. Tracks progression from initial report through investigation to closure.. Valid values are `reported|under_investigation|investigation_complete|closed|reopened`',
    `incident_timestamp` TIMESTAMP COMMENT 'Precise date and time when the HSE incident occurred, including time zone. Critical for SIMOPS coordination and root cause analysis.',
    `incident_type` STRING COMMENT 'Classification of the HSE event type. Distinguishes between safety observations, near-misses, injuries, environmental events, and process safety events. [ENUM-REF-CANDIDATE: safety_observation|near_miss|first_aid|recordable_injury|lost_time_injury|fatality|spill|fire|explosion|process_safety_event|behavioral_observation — 11 candidates stripped; promote to reference product]',
    `initial_description` STRING COMMENT 'Initial narrative description of the incident as reported by the observer or first responder. Captures immediate facts and circumstances before detailed investigation.',
    `injured_party_type` STRING COMMENT 'Classification of the person(s) injured or affected by the incident. Determines applicable workers compensation, liability, and regulatory reporting requirements.. Valid values are `employee|contractor|visitor|public|not_applicable`',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether the incident severity or circumstances require a formal root cause investigation. Typically true for recordable injuries, process safety events, and significant near-misses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the incident record was last updated. Used for change tracking and data quality monitoring.',
    `location_type` STRING COMMENT 'Type of facility or location where the incident occurred. Used for location-specific risk analysis and regulatory jurisdiction determination. [ENUM-REF-CANDIDATE: offshore_platform|onshore_facility|refinery|petrochemical_plant|pipeline|drilling_rig|office|warehouse|marine_vessel — 9 candidates stripped; promote to reference product]',
    `lopc_flag` BOOLEAN COMMENT 'Indicates whether the incident involved an unplanned or uncontrolled release of material from primary containment. Key process safety indicator per API RP 754.',
    `lost_time_incident_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in lost work time beyond the day of injury. Key lagging indicator for HSE performance measurement.',
    `norm_involvement_flag` BOOLEAN COMMENT 'Indicates whether the incident involved exposure to or release of naturally occurring radioactive materials, which can accumulate in oil and gas production equipment and require specialized handling.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordability on the OSHA 300 log. True if the incident resulted in death, days away from work, restricted work, medical treatment beyond first aid, loss of consciousness, or significant injury/illness diagnosed by a physician.',
    `pse_tier_classification` STRING COMMENT 'API RP 754 process safety indicator tier classification. Tier 1 represents most severe loss of primary containment events, Tier 2 represents lesser events, Tiers 3-4 represent leading indicators.. Valid values are `tier_1|tier_2|tier_3|tier_4|not_applicable`',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the incident meets criteria for mandatory notification to regulatory authorities such as OSHA, BSEE, EPA, or state agencies. Triggers compliance workflow.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of the incident. Used to verify compliance with notification timeframes (typically 8 hours for fatalities, 24 hours for hospitalizations).',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was formally reported into the Enablon HSE Management system. Used to measure reporting timeliness and compliance with internal HSE procedures.',
    `severity_classification` STRING COMMENT 'Severity level of the incident based on injury outcome. Aligns with OSHA recordability criteria and company HSE classification standards. [ENUM-REF-CANDIDATE: observation|near_miss|first_aid|medical_treatment|restricted_work|lost_time|fatality — 7 candidates stripped; promote to reference product]',
    `simops_flag` BOOLEAN COMMENT 'Indicates whether the incident occurred during simultaneous operations involving multiple work activities in proximity. SIMOPS scenarios require enhanced coordination and risk management.',
    `spill_to_environment_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in a release of material to the external environment (soil, water, air) requiring environmental remediation and regulatory notification.',
    `work_activity_type` STRING COMMENT 'Type of work activity being performed at the time of the incident. Used for activity-based risk analysis and permit-to-work effectiveness evaluation. [ENUM-REF-CANDIDATE: drilling|completion|production|maintenance|construction|inspection|turnaround|transportation|administrative|other — promote to reference product]',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Unified HSE event register serving as the single master record for all health, safety, and environmental events including safety observations, near-misses, first-aid cases, recordable injuries, illnesses, fatalities, spills, fires, explosions, process safety events (API RP 754 Tier 1/2), and behavioral observations. Captures event type, severity classification (OSHA recordable, lost-time, fatality, PSE tier), API RP 754 process safety indicator classification, location, date/time, initial description, H2S exposure flag, NORM involvement, loss of primary containment (LOPC) details, observer/reporter identity, immediate actions taken, and regulatory notification requirements. Supports behavior-based safety (BBS) programs, leading/lagging indicator tracking, and BSEE/OSHA incident reporting. Integrates with Enablon HSE Management incident reporting module. Serves as the SSOT for all HSE event data across the enterprise.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`incident_investigation` (
    `incident_investigation_id` BIGINT COMMENT 'Unique identifier for the incident investigation record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility where the incident occurred and investigation was conducted. Links to facility master data.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Root cause analysis of incidents involving contracted services/equipment requires contract reference to assess vendor obligations, scope compliance, HSE requirements adherence, and determine liability',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Investigation costs (investigation_cost_usd field present) require cost center allocation for HSE compliance budget management. Essential for tracking investigation expenses against facility/business ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Investigations analyze equipment failures beyond facility level. Equipment-specific link needed for failure mode analysis, barrier diagram development, and integration with asset reliability database ',
    `incident_id` BIGINT COMMENT 'Reference to the parent HSE incident that triggered this investigation. Links to the incident record in the HSE incident management system.',
    `employee_id` BIGINT COMMENT 'Reference to the employee assigned as the lead investigator responsible for coordinating the investigation and ensuring completion.',
    `tertiary_incident_lead_investigator_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `approval_date` DATE COMMENT 'The date when the investigation report was formally approved by the designated authority.',
    `business_unit` STRING COMMENT 'The business unit or division responsible for the facility where the incident occurred. Used for organizational reporting and accountability.. Valid values are `upstream|midstream|downstream|petrochemicals|corporate`',
    `capa_count` STRING COMMENT 'Total number of corrective and preventive actions generated from this investigation. Used to track investigation thoroughness and action item management.',
    `contributing_factors` STRING COMMENT 'Comprehensive description of all contributing factors identified during the investigation. Includes environmental conditions, equipment conditions, human factors, and organizational factors that contributed to the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was first created in the system. Audit trail field.',
    `equipment_failure_analysis` STRING COMMENT 'Technical analysis of any equipment, machinery, or system failures that contributed to or resulted from the incident. Includes failure modes, maintenance history review, and design deficiencies.',
    `evidence_collected` STRING COMMENT 'Description of physical evidence, photographs, video recordings, witness statements, documents, and other materials collected during the investigation.',
    `external_consultant_name` STRING COMMENT 'Name of the external consulting firm or expert organization engaged to support the investigation, if applicable.',
    `external_consultant_used` BOOLEAN COMMENT 'Indicates whether external subject matter experts or consulting firms were engaged to support the investigation.',
    `findings_summary` STRING COMMENT 'Executive summary of the investigation findings including key conclusions, identified causes, and high-level recommendations. Used for management reporting and regulatory submissions.',
    `human_factors_analysis` STRING COMMENT 'Analysis of human performance factors including fatigue, workload, competency, communication failures, situational awareness, and decision-making that contributed to the incident.',
    `immediate_cause_description` STRING COMMENT 'Detailed narrative describing the immediate or proximate causes that directly led to the incident. Captures the events or conditions immediately preceding the incident.',
    `investigation_closure_date` DATE COMMENT 'The date when the investigation was officially closed after all corrective actions were verified and documentation finalized.',
    `investigation_completion_date` DATE COMMENT 'The date when the investigation was formally completed and findings documented. Used to track compliance with regulatory investigation timelines.',
    `investigation_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the investigation including labor, external consultants, testing, analysis, and travel expenses. Reported in USD.',
    `investigation_number` STRING COMMENT 'Externally visible unique investigation reference number assigned by the HSE management system. Format: INV-YYYY-NNNNNN.. Valid values are `^INV-[0-9]{4}-[0-9]{6}$`',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the investigation based on incident severity, potential consequences, and regulatory requirements. Determines resource allocation and timeline expectations.. Valid values are `critical|high|medium|low`',
    `investigation_report_url` STRING COMMENT 'URL or file path to the complete investigation report document stored in the document management system. Provides access to detailed findings, evidence, and supporting documentation.',
    `investigation_start_date` DATE COMMENT 'The date when the formal investigation was initiated. Regulatory requirements often mandate investigation start within specific timeframes after incident occurrence.',
    `investigation_status` STRING COMMENT 'Current status of the investigation in its lifecycle. Tracks progression from initiation through completion and closure.. Valid values are `initiated|in_progress|under_review|completed|closed`',
    `investigation_team_members` STRING COMMENT 'Comma-separated list of investigation team member names or identifiers. Includes subject matter experts, safety personnel, operations representatives, and other stakeholders involved in the investigation.',
    `investigation_type` STRING COMMENT 'Classification of the investigation depth and scope. Determines the rigor and methodology applied based on incident severity and regulatory requirements.. Valid values are `preliminary|detailed|root_cause_analysis|regulatory_mandated|internal_audit`',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the investigation that should be communicated across the organization to prevent similar incidents. Supports continuous improvement and knowledge sharing.',
    `management_review_date` DATE COMMENT 'The date when the investigation findings were formally reviewed by management. Used to track governance and oversight compliance.',
    `management_review_required` BOOLEAN COMMENT 'Indicates whether the investigation findings require formal review and approval by senior management or executive leadership.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this investigation record. Supports audit trail and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was last updated. Audit trail field for tracking changes.',
    `procedural_deficiencies` STRING COMMENT 'Documentation of any inadequate, missing, or poorly followed procedures, work instructions, or operating guidelines identified during the investigation.',
    `rca_methodology` STRING COMMENT 'The structured root cause analysis methodology applied during the investigation. Common methods include TapRoot, Bow-Tie, 5-Why, Fishbone (Ishikawa), Fault Tree Analysis, and Barrier Analysis. [ENUM-REF-CANDIDATE: taproot|bow_tie|five_why|fishbone|fault_tree|barrier_analysis|change_analysis|other — 8 candidates stripped; promote to reference product]',
    `recommendations_summary` STRING COMMENT 'Summary of all recommendations made by the investigation team to prevent recurrence. Links to detailed corrective and preventive action records.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the investigation findings require formal notification to regulatory authorities such as OSHA, BSEE, EPA, or state agencies.',
    `regulatory_report_submission_date` DATE COMMENT 'The date when the investigation report was submitted to regulatory authorities. Used to track compliance with mandatory reporting timelines.',
    `regulatory_report_submitted` BOOLEAN COMMENT 'Indicates whether the required regulatory investigation report has been submitted to the appropriate authorities.',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the fundamental or systemic root causes identified through the RCA methodology. Describes the underlying organizational, procedural, or systemic failures that allowed the incident to occur.',
    `systemic_causes` STRING COMMENT 'Description of systemic or organizational causes such as inadequate management systems, insufficient training programs, poor safety culture, or deficient procedures that enabled the incident.',
    `witness_count` STRING COMMENT 'Total number of witnesses interviewed during the investigation. Used to assess investigation thoroughness.',
    CONSTRAINT pk_incident_investigation PRIMARY KEY(`incident_investigation_id`)
) COMMENT 'Detailed investigation record linked to an HSE incident. Captures root cause analysis (RCA) methodology used (e.g., TapRoot, Bow-Tie, 5-Why), contributing factors, immediate causes, systemic causes, investigation team members, findings narrative, and investigation completion status. Tracks corrective and preventive action (CAPA) linkage. Supports BSEE, OSHA, and internal investigation reporting requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` (
    `hse_corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective or preventive action record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key reference to the facility, plant, or offshore platform where the corrective action is being implemented.',
    `asset_id` BIGINT COMMENT 'Foreign key reference to the specific asset, equipment unit, or well associated with the corrective action, if applicable.',
    `compliance_audit_finding_id` BIGINT COMMENT 'Foreign key reference to the audit finding record if this corrective action arose from a regulatory or internal audit.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Corrective actions from incidents/audits often require contract amendments, vendor-executed remediation, or procurement of replacement equipment. Contract reference enables enforcement of vendor oblig',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Corrective actions have cost_estimate and actual_cost fields requiring cost center allocation for HSE improvement budget tracking. Standard practice for tracking corrective action expenditures against',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Corrective actions often target specific equipment (replace PRV, upgrade SIS logic solver). Equipment FK required for automatic work order generation in CMMS, equipment modification history tracking, ',
    `incident_id` BIGINT COMMENT 'Foreign key reference to the HSE incident record if this corrective action arose from an incident investigation.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Corrective actions addressing lease-specific HSE deficiencies require lease context; lease compliance corrective actions, lessor notifications, and lease-specific remediation tracking. Essential for l',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Turnarounds often generate corrective actions from pre-turnaround inspections and audits. Action tracking and closure verification require linking CAPAs to the turnaround event that triggered them.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline integrity corrective actions (coating repair, cathodic protection upgrade, inline inspection anomaly remediation) require segment-level tracking for integrity management plan compliance, regu',
    `previous_action_hse_corrective_action_id` BIGINT COMMENT 'Foreign key reference to a prior corrective action record if this action is addressing a recurrence or follow-up to an earlier ineffective action.',
    `jib_statement_id` BIGINT COMMENT 'Foreign key linking to venture.jib_statement. Business justification: HSE corrective action costs are billed to non-operators through JIB statements; cost recovery, partner allocation, and COPAS billing code assignment require JIB linkage for joint account charges.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Corrective actions from vessel inspections reference vessel for approval status and vetting improvement.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well integrity corrective actions (casing repair, wellhead replacement, tubing replacement) need well-specific linkage for mechanical integrity program tracking, state regulatory compliance, and well ',
    `action_description` STRING COMMENT 'Detailed narrative description of the corrective or preventive action to be taken, including specific tasks, deliverables, and expected outcomes.',
    `action_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the corrective action, typically generated by Enablon HSE Management system.',
    `action_status` STRING COMMENT 'Current lifecycle status of the corrective action in the workflow: open (assigned but not started), in_progress (work underway), pending_verification (awaiting effectiveness review), closed (completed and verified), overdue (past due date), cancelled (no longer required).. Valid values are `open|in_progress|pending_verification|closed|overdue|cancelled`',
    `action_type` STRING COMMENT 'Classification of the action: corrective (addresses existing nonconformity), preventive (eliminates potential nonconformity), or improvement (enhances performance beyond compliance).. Valid values are `corrective|preventive|improvement`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost in USD incurred to implement the corrective action, captured upon completion.',
    `assigned_date` DATE COMMENT 'Date when the corrective action was formally assigned to the responsible party.',
    `attachments_count` STRING COMMENT 'Number of supporting documents, photos, or evidence files attached to the corrective action record in Enablon HSE Management.',
    `business_unit` STRING COMMENT 'Business unit or operating division responsible for the corrective action (e.g., Upstream E&P, Downstream Refining, Midstream Transportation).',
    `closed_by` STRING COMMENT 'Name or identifier of the individual who authorized closure of the corrective action, typically an HSE manager or supervisor.',
    `closure_date` DATE COMMENT 'Date when the corrective action was formally closed in Enablon HSE Management after successful completion and effectiveness verification.',
    `completion_date` DATE COMMENT 'Actual date when the corrective action was completed by the responsible party. Null if action is still open or in progress.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost in USD to implement the corrective action, including labor, materials, equipment, and contractor expenses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first created in the HSE management system.',
    `due_date` DATE COMMENT 'Target completion date by which the corrective action must be completed, based on priority and regulatory requirements.',
    `effectiveness_review_comments` STRING COMMENT 'Narrative comments from the effectiveness review, documenting evidence of success or reasons for ineffectiveness.',
    `effectiveness_review_date` DATE COMMENT 'Date when the effectiveness of the corrective action was formally reviewed, typically 30-90 days after completion.',
    `effectiveness_review_status` STRING COMMENT 'Assessment of whether the corrective action successfully addressed the root cause and prevented recurrence: pending (not yet reviewed), effective (achieved intended outcome), ineffective (did not resolve issue), partially_effective (some improvement but further action needed).. Valid values are `pending|effective|ineffective|partially_effective`',
    `escalation_date` DATE COMMENT 'Date when the corrective action was escalated to senior management or regulatory authority.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this corrective action has been escalated to senior management due to overdue status, high risk, or repeated ineffectiveness.',
    `geographic_region` STRING COMMENT 'Geographic region or country where the corrective action is being implemented, using 3-letter ISO country codes (e.g., USA, GBR, SAU).',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last modified the corrective action record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was last updated in the HSE management system.',
    `priority` STRING COMMENT 'Business priority classification for the corrective action based on risk severity, regulatory impact, and operational criticality.. Valid values are `critical|high|medium|low`',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this corrective action addresses a recurring issue that has been previously reported and actioned.',
    `regulatory_requirement` STRING COMMENT 'Citation of the specific regulatory requirement, standard clause, or permit condition that this corrective action addresses (e.g., OSHA 1910.119, EPA 40 CFR 112, ISO 45001 Clause 10.2).',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual, team, or organizational unit assigned ownership and accountability for completing the corrective action.',
    `responsible_party_email` STRING COMMENT 'Email address of the responsible party for notification and escalation workflows.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `root_cause_description` STRING COMMENT 'Description of the identified root cause(s) that this corrective action is designed to address, typically derived from incident investigation or audit analysis.',
    `source_reference_code` STRING COMMENT 'Reference identifier linking this corrective action to the originating event record (incident ID, audit finding ID, inspection ID, etc.) in Enablon HSE Management.',
    `source_type` STRING COMMENT 'Type of originating event or activity that triggered the corrective action: incident investigation, audit finding, inspection deficiency, near-miss report, safety observation, or stakeholder complaint.. Valid values are `incident|audit|inspection|near_miss|observation|complaint`',
    `verification_date` DATE COMMENT 'Date when the corrective action implementation was verified by the HSE team or auditor.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was implemented as planned: document review, site inspection, audit, testing, direct observation, or stakeholder interview.. Valid values are `document_review|site_inspection|audit|testing|observation|interview`',
    `verified_by` STRING COMMENT 'Name or identifier of the individual who verified the completion and effectiveness of the corrective action.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the corrective action record.',
    CONSTRAINT pk_hse_corrective_action PRIMARY KEY(`hse_corrective_action_id`)
) COMMENT 'Tracks corrective and preventive actions (CAPAs) arising from incident investigations, audit findings, inspection deficiencies, and near-miss reports. Captures action description, responsible party, due date, completion date, verification method, effectiveness review status, and priority classification. Supports closure tracking and overdue escalation workflows in Enablon HSE Management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`permit_to_work` (
    `permit_to_work_id` BIGINT COMMENT 'Unique identifier for the permit-to-work record. Primary key for the permit_to_work product.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the oil and gas facility where the permitted work will be performed. Links to facility master data.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: High-risk work permits for contracted activities (turnarounds, well services, construction) require contract reference to verify vendor authorization, validate insurance coverage, confirm HSE plan com',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor company performing the work, if applicable. Null for internal workforce operations.',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key linking to petrochemical.conversion_unit. Business justification: PTW permits specify the exact equipment/unit where work will be performed. Isolation planning, energy source identification, and work authorization require linking permits to specific conversion units',
    `equipment_id` BIGINT COMMENT 'Identifier of the calibrated gas detection instrument used for atmospheric testing. Ensures traceability and compliance with calibration requirements.',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Permits to work issued for well operations (drilling, completion, testing, workover) must reference the specific well. Critical for operational control, regulatory compliance (MMS/BSEE), and linking P',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOAs mandate HSE standards and work authorization protocols for joint operations; permit issuance, approval authority, and associated costs are governed by JOA HSE provisions and overhead allocation.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Work permits on leased properties must verify lease terms allow the activity; lease restrictions, depth limitations, and operational constraints govern permissible work. Land department reviews permit',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: PTW systems are facility-specific. Petrochemical plants issue permits for hot work, confined space entry, and hazardous activities. Permit management and compliance tracking are plant-level processes.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Permit-to-work systems specify the petroleum product being handled to determine appropriate safety controls, gas testing requirements (LEL, H2S, benzene), PPE specifications, and isolation procedures.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Hot work, excavation, and maintenance permits on pipelines require segment identification for isolation planning, SIMOPS coordination with adjacent segments, and emergency response planning. Critical ',
    `employee_id` BIGINT COMMENT 'Reference to the authorized person who issued the permit. Typically a supervisor, safety officer, or operations manager with PTW authorization.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Work permits must reference authorizing regulatory permits (air, water, operating) to ensure activities comply with permit conditions. Critical for demonstrating regulatory compliance during work exec',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Permits must comply with surface use agreement terms; agreement restrictions, access rights, permitted activities, and compensation triggers are verified during permit issuance. Critical for surface o',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well intervention, workover, completion, and P&A permits must link to specific wells for state regulatory compliance (Form 4 in Texas), well control planning, H2S contingency activation, and SIMOPS co',
    `activated_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was activated and work commenced. May differ from issued timestamp if there is a delay between authorization and work start.',
    `approval_signature_digital_code` STRING COMMENT 'Digital signature identifier or electronic approval token from the issuing authority. Ensures non-repudiation and audit trail for permit authorization.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the permit was cancelled. Includes scope changes, safety concerns, or work no longer required. Nullable if permit was not cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was cancelled before work completion. Nullable if permit was not cancelled.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was closed upon successful completion of work. Represents the end of the permit lifecycle for completed work.',
    `concurrent_permit_check_flag` BOOLEAN COMMENT 'Indicates whether a check for conflicting concurrent permits was performed. True if SIMOPS coordination was verified, false otherwise.',
    `conflicting_permits` STRING COMMENT 'List of permit numbers that may conflict with this permit due to proximity, shared resources, or incompatible work activities. Used for SIMOPS coordination.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was first created in the system. Represents the initial capture of the permit in draft status.',
    `emergency_contact_name` STRING COMMENT 'Name of the designated emergency contact person for this work activity. Must be immediately available during work execution.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the designated emergency contact person. Must be reachable during the entire work period.',
    `energy_sources_isolated` STRING COMMENT 'List of energy sources that have been isolated for this work. Includes electrical, mechanical, hydraulic, pneumatic, thermal, chemical, and gravitational energy sources.',
    `environmental_conditions` STRING COMMENT 'Description of environmental conditions at the time of permit issuance. Includes weather, temperature, wind speed, visibility, and other factors that may affect work safety.',
    `gas_test_co_ppm` DECIMAL(18,2) COMMENT 'Measured Carbon Monoxide concentration in parts per million from atmospheric gas testing. CO is a toxic gas that can be present in combustion processes. OSHA permissible exposure limit is 50 ppm (8-hour TWA).',
    `gas_test_h2s_ppm` DECIMAL(18,2) COMMENT 'Measured Hydrogen Sulfide concentration in parts per million from atmospheric gas testing. H2S is a toxic and flammable gas common in oil and gas operations. OSHA permissible exposure limit is 10 ppm (8-hour TWA).',
    `gas_test_lel_percent` DECIMAL(18,2) COMMENT 'Measured Lower Explosive Limit percentage from atmospheric gas testing. Must be below 10% LEL for hot work permits. LEL represents the minimum concentration of flammable gas that can ignite.',
    `gas_test_oxygen_percent` DECIMAL(18,2) COMMENT 'Measured oxygen concentration from atmospheric gas testing. Must be between 19.5% and 23.5% for safe entry into confined spaces per OSHA standards.',
    `gas_test_timestamp` TIMESTAMP COMMENT 'Date and time when the atmospheric gas testing was performed. Gas tests must be current and may require periodic re-testing during work execution.',
    `hazard_identification_summary` STRING COMMENT 'Summary of identified hazards associated with the work activity. Derived from Job Safety Analysis (JSA) or risk assessment. Includes physical, chemical, biological, and environmental hazards.',
    `isolation_requirements` STRING COMMENT 'Description of required isolations for energy sources, process fluids, and utilities. Includes lockout/tagout (LOTO) points, valve closures, and electrical disconnects.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was officially issued by the issuing authority. Represents the authorization event in the permit lifecycle.',
    `jsa_reference_number` STRING COMMENT 'Reference number linking this permit to the associated Job Safety Analysis document. JSA identifies hazards and control measures for the work activity.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was last modified. Tracks changes throughout the permit lifecycle for audit and compliance purposes.',
    `permit_number` STRING COMMENT 'Externally-known unique permit number assigned by the issuing authority. Used for tracking and audit purposes.. Valid values are `^PTW-[A-Z0-9]{8,12}$`',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit. Draft permits are under preparation, issued permits are authorized but not yet active, active permits are in use, suspended permits are temporarily halted, closed permits are completed, and cancelled permits are voided.. Valid values are `draft|issued|active|suspended|closed|cancelled`',
    `permit_type` STRING COMMENT 'Classification of the permit based on the nature of high-risk work activity. Determines specific safety protocols and authorization requirements. SIMOPS refers to Simultaneous Operations coordination.. Valid values are `hot_work|confined_space_entry|electrical_isolation|excavation|working_at_height|simops`',
    `ppe_requirements` STRING COMMENT 'List of required Personal Protective Equipment for the work activity. May include hard hat, safety glasses, gloves, fire-resistant clothing, respirator, fall protection, and specialized equipment based on hazards.',
    `rescue_plan_reference` STRING COMMENT 'Reference to the emergency rescue plan applicable to this work activity. Required for confined space entry and working at height permits.',
    `simops_plan_reference` STRING COMMENT 'Reference to the SIMOPS coordination plan when multiple work activities are occurring concurrently at the facility. SIMOPS ensures safe coordination of overlapping operations to prevent conflicts and cascading hazards.',
    `suspended_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was suspended due to changing conditions, safety concerns, or operational requirements. Nullable if permit was never suspended.',
    `suspension_reason` STRING COMMENT 'Explanation for why the permit was suspended. Includes safety concerns, weather conditions, equipment failures, or operational changes. Nullable if permit was never suspended.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Date and time when the permit becomes valid and work may commence. Represents the start of the authorized work window.',
    `valid_until_timestamp` TIMESTAMP COMMENT 'Date and time when the permit expires and work must cease. Permits typically have limited validity periods (e.g., 8-12 hours) and must be renewed if work continues beyond expiration.',
    `work_completion_notes` STRING COMMENT 'Notes documenting the completion of work, including any deviations, observations, or follow-up actions required. Captured at permit closure.',
    `work_description` STRING COMMENT 'Detailed description of the work to be performed under this permit. Includes scope, methods, equipment, and expected duration.',
    `work_location` STRING COMMENT 'Specific location within the facility where the work will be performed. Includes unit, area, equipment tag, or GPS coordinates as applicable.',
    CONSTRAINT pk_permit_to_work PRIMARY KEY(`permit_to_work_id`)
) COMMENT 'Permit-to-Work (PTW) master record authorizing specific high-risk work activities at oil and gas facilities. Captures permit type (hot work, confined space entry, electrical isolation, excavation, working at height, SIMOPS, cold work, radiography), issuing authority, performing authority, work location, valid date/time window, hazard identification summary, required isolations and energy sources, gas test results (LEL, O2, H2S, CO), PPE requirements, simultaneous permit conflicts checked, and permit status lifecycle (draft, issued, active, suspended, closed, cancelled). Links to risk assessment (JSA) and SIMOPS plan for concurrent operations coordination. Integrates with Enablon PTW module and supports OSHA-required safe work authorization procedures.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`simops_plan` (
    `simops_plan_id` BIGINT COMMENT 'Unique identifier for the SIMOPS coordination plan. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility or offshore installation where simultaneous operations are planned.',
    `employee_id` BIGINT COMMENT 'Reference to the individual who created the SIMOPS plan record.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: SIMOPS plans coordinate simultaneous operations around critical equipment (compressor maintenance during turnaround, separator work during drilling). Equipment-level detail required for exclusion zone',
    `last_modified_by_employee_id` BIGINT COMMENT 'Reference to the individual who most recently modified the SIMOPS plan record.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: SIMOPS plans manage simultaneous operations at a petrochemical facility (e.g., turnaround during production). Plans are facility-specific and address site-specific hazards and exclusion zones.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline operations during concurrent activities (hot tap while segment operational, excavation near active line) require segment-specific SIMOPS planning for pressure management, isolation verificati',
    `primary_simops_employee_id` BIGINT COMMENT 'Reference to the individual responsible for coordinating and overseeing the execution of simultaneous operations.',
    `tertiary_simops_hse_reviewer_employee_id` BIGINT COMMENT 'Reference to the HSE professional who conducted the review of the SIMOPS plan.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Drilling near producing wells, well interventions during facility operations, and multi-well pad operations require well-specific SIMOPS coordination for H2S contingency, well control, pressure manage',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when simultaneous operations concluded, as recorded during execution.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when simultaneous operations commenced, as recorded during execution.',
    `approval_date` DATE COMMENT 'Date on which the SIMOPS plan received formal approval for execution.',
    `approval_status` STRING COMMENT 'Current approval status of the SIMOPS plan in its review and authorization workflow.. Valid values are `draft|pending_review|approved|rejected|suspended|expired`',
    `approved_by_name` STRING COMMENT 'Full name of the approving authority for the SIMOPS plan.',
    `communication_protocol` STRING COMMENT 'Defined communication procedures and protocols to be followed during SIMOPS, including radio channels, reporting frequencies, and escalation paths.',
    `conflicting_operations_identified` STRING COMMENT 'Enumeration and description of specific operations that may conflict or interfere with each other during simultaneous execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the SIMOPS plan record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the SIMOPS plan expires or is no longer valid, marking the end of the validity period.',
    `effective_start_date` DATE COMMENT 'Date from which the SIMOPS plan becomes active and governs concurrent operations.',
    `emergency_response_plan_reference` STRING COMMENT 'Reference to the emergency response plan applicable to the SIMOPS scenario.',
    `exclusion_zone_defined` BOOLEAN COMMENT 'Indicates whether physical exclusion zones have been established to separate conflicting operations spatially.',
    `exclusion_zone_description` STRING COMMENT 'Detailed description of exclusion zones including boundaries, restricted areas, and access control measures.',
    `hse_review_completed` BOOLEAN COMMENT 'Indicates whether the mandatory HSE review of the SIMOPS plan has been completed.',
    `hse_review_date` DATE COMMENT 'Date on which the HSE review of the SIMOPS plan was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the SIMOPS plan record was most recently modified.',
    `mitigation_measures` STRING COMMENT 'Detailed description of risk mitigation measures and controls implemented to manage SIMOPS hazards.',
    `permit_to_work_required` BOOLEAN COMMENT 'Indicates whether a formal Permit to Work is required for the simultaneous operations covered by this plan.',
    `plan_number` STRING COMMENT 'Externally-known business identifier for the SIMOPS plan, used for tracking and reference across operations teams.',
    `plan_title` STRING COMMENT 'Descriptive title summarizing the scope and nature of the simultaneous operations covered by this plan.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when simultaneous operations are scheduled to conclude.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when simultaneous operations are scheduled to commence.',
    `ptw_reference_number` STRING COMMENT 'Reference number of the associated Permit to Work document, if applicable.',
    `regulatory_compliance_notes` STRING COMMENT 'Notes documenting compliance with applicable regulatory requirements including BSEE, OSHA, EPA, and API standards.',
    `revision_date` DATE COMMENT 'Date of the most recent revision to the SIMOPS plan.',
    `revision_number` STRING COMMENT 'Version number of the SIMOPS plan, incremented with each revision or update.',
    `revision_reason` STRING COMMENT 'Explanation of the reason for the most recent revision, documenting changes to scope, risk assessment, or controls.',
    `risk_assessment_level` STRING COMMENT 'Overall risk level assigned to the SIMOPS scenario based on risk matrix assessment considering likelihood and consequence.. Valid values are `low|medium|high|critical`',
    `risk_matrix_score` STRING COMMENT 'Numerical score derived from the risk matrix assessment, quantifying the combined likelihood and severity of potential incidents.',
    `simops_coordinator_name` STRING COMMENT 'Full name of the SIMOPS coordinator responsible for plan execution and safety oversight.',
    `simops_scenario_description` STRING COMMENT 'Detailed description of the SIMOPS scenario, including the nature of concurrent activities such as drilling, production, maintenance, construction, or marine operations.',
    CONSTRAINT pk_simops_plan PRIMARY KEY(`simops_plan_id`)
) COMMENT 'Simultaneous Operations (SIMOPS) coordination plan governing concurrent activities at a facility or offshore installation. Captures SIMOPS scenario description, conflicting operations identified, risk matrix assessment, exclusion zones, communication protocols, responsible SIMOPS coordinator, approval status, and validity period. Ensures safe execution of overlapping drilling, production, maintenance, and construction activities.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility, site, or operational location being audited.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the audit record in the system.',
    `audit_employee_id` BIGINT COMMENT 'Identifier of the lead auditor responsible for conducting and overseeing the audit.',
    `audit_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the audit record.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: HSE audits of contracted operations require contract reference to assess vendor compliance with contractual HSE requirements, performance standards, certification obligations, and insurance provisions',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: HSE audit costs (internal labor, external consultants, travel) must be allocated to cost centers for compliance program budget management. Required for tracking audit program expenses in oil-and-gas r',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOA audit rights clauses mandate HSE audit frequency, scope, and cost allocation; partners exercise contractual audit rights to verify operator HSE compliance and joint account charge appropriateness.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: HSE audits (regulatory, internal, ISO) are conducted at specific petrochemical facilities. Audit planning, finding tracking, and compliance verification require linking audits to the plant being audit',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: HSE audits conducted by regulatory bodies (BSEE, EPA, OSHA) are the same events as compliance regulatory audits. Enables unified audit management across operational and compliance perspectives for enf',
    `actual_end_date` DATE COMMENT 'Actual date when the audit was completed.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit commenced.',
    `areas_audited` STRING COMMENT 'Comma-separated list or description of specific operational areas, departments, or processes audited (e.g., drilling operations, process safety management, environmental monitoring, emergency response).',
    `audit_number` STRING COMMENT 'Externally-known unique audit identifier or reference number assigned by the audit management system.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including the processes, systems, facilities, and management areas covered by the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit (Planned, In Progress, Completed, Report Issued, Closed, Cancelled).. Valid values are `Planned|In Progress|Completed|Report Issued|Closed|Cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit based on the standard or regulatory framework being assessed (e.g., ISO 14001 Environmental Management, ISO 45001 Occupational Health and Safety, OSHA Voluntary Protection Program, BSEE offshore safety, API Recommended Practice, internal HSE audit, external regulatory audit). [ENUM-REF-CANDIDATE: ISO 14001|ISO 45001|OSHA VPP|BSEE|API RP|Internal HSE|External Regulatory — 7 candidates stripped; promote to reference product]',
    `certification_expiry_date` DATE COMMENT 'Expiry date of the certification granted as a result of the audit, if applicable.',
    `certification_status` STRING COMMENT 'Certification status resulting from the audit for certification audits (Certified, Conditional, Suspended, Revoked, Not Applicable for non-certification audits).. Valid values are `Certified|Conditional|Suspended|Revoked|Not Applicable`',
    `closure_date` DATE COMMENT 'Date when the audit was formally closed after all corrective actions were verified and accepted.',
    `corrective_action_plan_due_date` DATE COMMENT 'Due date by which the corrective action plan must be submitted by the audited facility.',
    `corrective_action_plan_required` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan is required based on audit findings (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `criteria` STRING COMMENT 'Set of policies, procedures, standards, or requirements used as a reference against which audit evidence is compared.',
    `critical_findings_count` STRING COMMENT 'Number of critical severity findings identified that pose immediate risk to health, safety, or environment and require urgent corrective action.',
    `duration_days` STRING COMMENT 'Total number of days the audit took from start to completion.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify implementation of corrective actions (True/False).',
    `follow_up_audit_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up audit to verify corrective action implementation.',
    `key_risks_identified` STRING COMMENT 'Summary of key risks, gaps, or areas of concern identified during the audit that require management attention.',
    `key_strengths_identified` STRING COMMENT 'Summary of key strengths, best practices, or positive observations identified during the audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was last modified in the system.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and overseeing the audit.',
    `major_findings_count` STRING COMMENT 'Number of major severity findings identified that represent significant non-conformances requiring corrective action.',
    `management_response_date` DATE COMMENT 'Date when the formal management response to the audit findings was received.',
    `management_response_received` BOOLEAN COMMENT 'Indicates whether a formal management response to the audit findings has been received (True/False).',
    `methodology` STRING COMMENT 'Methodology used to conduct the audit (On-Site physical inspection, Remote virtual audit, Hybrid combination, Document Review only).. Valid values are `On-Site|Remote|Hybrid|Document Review`',
    `minor_findings_count` STRING COMMENT 'Number of minor severity findings identified that represent opportunities for improvement or minor non-conformances.',
    `objectives` STRING COMMENT 'Stated objectives and goals of the audit as defined in the audit plan.',
    `observations_count` STRING COMMENT 'Number of observations or recommendations noted during the audit that do not constitute non-conformances but represent best practice opportunities.',
    `overall_compliance_rating` STRING COMMENT 'Overall compliance rating assigned to the audited facility or process based on audit findings (Compliant, Substantially Compliant, Partially Compliant, Non-Compliant, Not Applicable).. Valid values are `Compliant|Substantially Compliant|Partially Compliant|Non-Compliant|Not Applicable`',
    `planned_end_date` DATE COMMENT 'Planned date when the audit is scheduled to conclude.',
    `planned_start_date` DATE COMMENT 'Planned date when the audit is scheduled to begin.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body or certification authority conducting or sponsoring the audit (e.g., OSHA, EPA, BSEE, ISO certification body).',
    `report_issued_date` DATE COMMENT 'Date when the formal audit report was issued to the audited facility and stakeholders.',
    `report_reference` STRING COMMENT 'Reference number or document identifier for the formal audit report issued following the audit.',
    `standards_assessed` STRING COMMENT 'List of specific standards, regulations, or management system requirements assessed during the audit (e.g., ISO 14001:2015, ISO 45001:2018, 29 CFR 1910, API RP 75).',
    `team_members` STRING COMMENT 'Comma-separated list or description of audit team members participating in the audit, including subject matter experts and technical specialists.',
    `total_findings_count` STRING COMMENT 'Total number of audit findings identified during the audit across all severity levels.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'HSE audit and inspection record capturing planned and unplanned audits of facilities, operations, and management systems. Captures audit type (ISO 14001, ISO 45001, OSHA VPP, BSEE, internal), audit scope, lead auditor, audit date range, facility audited, overall compliance rating, number of findings by severity, and audit report reference. Integrates with Enablon audit management module.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` (
    `hse_audit_finding_id` BIGINT COMMENT 'Unique identifier for the HSE audit finding record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility, site, or installation where the finding was identified.',
    `audit_id` BIGINT COMMENT 'Reference to the parent HSE audit or inspection during which this finding was raised.',
    `compliance_audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: HSE audit findings that cite regulatory violations become compliance audit findings. Links operational discovery to formal regulatory remediation tracking for enforcement response and penalty manageme',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Audit findings related to contractor performance must reference the contract for enforcement of corrective action requirements, assessment of liquidated damages, vendor performance scoring, and potent',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key linking to petrochemical.conversion_unit. Business justification: Audit findings often identify deficiencies at specific process units. Equipment-specific corrective actions and unit-level compliance tracking require linking findings to the conversion unit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit finding remediation costs (cost_estimate and actual_cost fields present) require cost center allocation for compliance corrective action budget tracking. Essential for managing audit finding clo',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Audit findings cite specific equipment deficiencies (PRV undersized, corrosion on V-101, SIS logic error). Equipment FK required for corrective action work order generation, equipment modification tra',
    `hse_corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.hse_corrective_action. Business justification: Audit findings require corrective actions to close non-conformances. Business reality: Each audit finding (non-conformance, observation, OFI) generates one or more CAPAs. Currently hse_corrective_acti',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Audit findings are plant-specific. Corrective action tracking, management review, and compliance closure reporting require linking findings to the specific petrochemical plant where the deficiency was',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline audit findings (coating defects, inadequate cathodic protection, missing markers) require segment-level tracking for integrity management plan updates, corrective action prioritization, and r',
    `employee_id` BIGINT COMMENT 'Reference to the auditor or inspector who identified and documented this finding.',
    `quaternary_hse_created_by_employee_id` BIGINT COMMENT 'Reference to the user or system that created this finding record.',
    `quinary_hse_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user or system that last modified this finding record.',
    `tertiary_hse_verified_by_employee_id` BIGINT COMMENT 'Reference to the auditor or HSE personnel who verified the closure of the finding.',
    `actual_closure_date` DATE COMMENT 'Actual date on which the finding was verified as resolved and formally closed.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to remediate the finding, in the reporting currency.',
    `auditor_name` STRING COMMENT 'Full name of the auditor or inspector who raised the finding.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan outlining the corrective actions to be implemented to address the finding and prevent recurrence.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to implement corrective actions and remediate the finding, in the reporting currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this finding record was first created in the system.',
    `finding_category` STRING COMMENT 'Primary HSE domain category to which this finding belongs: safety, environmental, health, process safety, or occupational health.. Valid values are `safety|environmental|health|process_safety|occupational_health`',
    `finding_date` DATE COMMENT 'Date on which the finding was identified during the audit or inspection.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit finding, including observed conditions, evidence, and context.',
    `finding_number` STRING COMMENT 'Business identifier for the finding, typically a sequential or structured code assigned during the audit (e.g., AUD-2024-001-F01).',
    `finding_title` STRING COMMENT 'Short descriptive title or summary of the finding for quick identification and reporting.',
    `finding_type` STRING COMMENT 'Classification of the finding severity and nature: nonconformity (violation of requirement), observation (potential issue), opportunity for improvement (enhancement suggestion), or positive practice (commendation).. Valid values are `nonconformity|observation|opportunity_for_improvement|positive_practice`',
    `hse_audit_finding_status` STRING COMMENT 'Current lifecycle status of the finding: open (newly identified), in_progress (corrective action underway), pending_verification (awaiting closure verification), closed (resolved and verified), or overdue (past target closure date).. Valid values are `open|in_progress|pending_verification|closed|overdue`',
    `immediate_action_taken` STRING COMMENT 'Description of any immediate corrective or containment actions taken at the time of the finding to mitigate risk.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this finding record was last updated.',
    `management_of_change_required` BOOLEAN COMMENT 'Indicates whether a formal Management of Change process is required to implement the corrective action for this finding.',
    `moc_reference_number` STRING COMMENT 'Reference number of the associated Management of Change record, if MOC is required.',
    `notes` STRING COMMENT 'Additional comments, context, or supplementary information related to the finding, its investigation, or remediation.',
    `previous_finding_reference` STRING COMMENT 'Reference number or identifier of the previous related finding, if this is a recurrence.',
    `process_area` STRING COMMENT 'Specific process unit, operational area, or functional zone within the facility where the finding was observed (e.g., Crude Distillation Unit, Drilling Rig Floor, Tank Farm).',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this finding is a recurrence of a previously identified and closed finding, signaling potential systemic issues.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, standard, or internal policy requirement that was violated or not met (e.g., OSHA 1910.146, API RP 75, ISO 14001 clause 8.1).',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier of the regulatory report filed in connection with this finding, if applicable.',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this finding must be reported to external regulatory authorities (e.g., OSHA, EPA, BSEE) due to its nature or severity.',
    `requirement_clause` STRING COMMENT 'Specific clause, section, or paragraph number of the regulatory or standard requirement that is the basis for this finding.',
    `responsible_party_name` STRING COMMENT 'Full name of the individual or organizational unit assigned ownership of the finding remediation.',
    `root_cause_analysis_required` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis is required for this finding, typically true for major or critical findings.',
    `root_cause_summary` STRING COMMENT 'Summary of the identified root cause(s) of the finding, if root cause analysis has been completed.',
    `severity_level` STRING COMMENT 'Risk-based severity classification of the finding: critical (immediate action required, high risk), major (significant risk), minor (moderate risk), or low (minimal risk).. Valid values are `critical|major|minor|low`',
    `target_closure_date` DATE COMMENT 'Planned or required date by which the finding must be resolved and closed, often driven by regulatory deadlines or risk severity.',
    `verification_date` DATE COMMENT 'Date on which the finding closure was verified and confirmed.',
    `verification_method` STRING COMMENT 'Method or approach used to verify that corrective actions have been effectively implemented (e.g., follow-up inspection, document review, testing).',
    `verified_by_name` STRING COMMENT 'Full name of the individual who verified the finding closure.',
    CONSTRAINT pk_hse_audit_finding PRIMARY KEY(`hse_audit_finding_id`)
) COMMENT 'Individual finding or observation raised during an HSE audit or inspection. Captures finding type (nonconformity, observation, opportunity for improvement), finding description, regulatory reference violated, severity classification, facility and process area, responsible owner, target closure date, and current status. Links to corrective_action records for remediation tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`ldar_survey` (
    `ldar_survey_id` BIGINT COMMENT 'Primary key for ldar_survey',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where the LDAR survey was conducted.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created the LDAR survey record in the HSE management system.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user or system that last modified the LDAR survey record.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: LDAR programs are facility-specific regulatory requirements under EPA NSPS/NESHAP. Surveys are conducted at individual petrochemical plants, and compliance tracking is plant-level.',
    `primary_ldar_employee_id` BIGINT COMMENT 'Identifier of the certified inspector or technician who conducted the LDAR survey.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Fahrenheit at the time of the survey, recorded to assess environmental conditions that may affect detection sensitivity.',
    `components_surveyed_count` STRING COMMENT 'Total number of equipment components inspected during the LDAR survey.',
    `contractor_company_name` STRING COMMENT 'Name of the third-party contractor company that performed the LDAR survey, if applicable.',
    `corrective_action_deadline_date` DATE COMMENT 'Regulatory deadline by which all detected leaks must be repaired, typically within a specified number of days from detection.',
    `corrective_actions_required` BOOLEAN COMMENT 'Indicates whether corrective actions (leak repairs) are required based on the survey findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the LDAR survey record was first created in the HSE management system.',
    `equipment_component_type` STRING COMMENT 'Type of equipment component surveyed for leaks, such as valves, flanges, connectors, pumps, compressors, pressure relief devices, open-ended lines, or sampling connections.',
    `hse_review_comments` STRING COMMENT 'Comments and observations recorded by the HSE reviewer regarding survey quality, findings, and compliance.',
    `hse_review_date` DATE COMMENT 'Date when the HSE reviewer completed the review and validation of the LDAR survey.',
    `instrument_calibration_date` DATE COMMENT 'Date of the most recent calibration of the monitoring instrument used in the survey, ensuring measurement accuracy and regulatory compliance.',
    `instrument_serial_number` STRING COMMENT 'Serial number of the monitoring instrument (OGI camera or Method 21 analyzer) used during the survey for traceability and calibration verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the LDAR survey record was last modified in the HSE management system.',
    `leak_detection_threshold_ppm` STRING COMMENT 'Regulatory threshold concentration in parts per million (ppm) above which a component is classified as leaking, typically 500 ppm or 1000 ppm depending on the program.',
    `leaks_detected_count` STRING COMMENT 'Total number of leaks detected during the LDAR survey that exceed the regulatory threshold concentration.',
    `maximum_leak_concentration_ppm` STRING COMMENT 'Highest fugitive emission concentration measured in parts per million (ppm) during the survey, indicating the most severe leak detected.',
    `monitoring_method` STRING COMMENT 'Method used to detect fugitive emissions during the survey: Optical Gas Imaging (OGI) camera, EPA Method 21 portable analyzer, Audio-Visual-Olfactory (AVO) inspection, Smart LDAR technology, or other approved method.. Valid values are `ogi_camera|method_21_analyzer|audio_visual_olfactory|smart_ldar|other`',
    `regulatory_program` STRING COMMENT 'Regulatory program under which the LDAR survey is conducted, such as EPA Method 21, 40 CFR Part 60 Subpart OOOOa, state-specific programs, or voluntary programs.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this LDAR survey must be included in regulatory reports submitted to EPA, BSEE, or state environmental agencies.',
    `regulatory_submission_date` DATE COMMENT 'Date when the LDAR survey results were submitted to the regulatory authority as part of compliance reporting.',
    `regulatory_submission_reference` STRING COMMENT 'Reference number or confirmation identifier for the regulatory submission that included this LDAR survey data.',
    `survey_completion_date` DATE COMMENT 'Date when the LDAR survey was marked as complete and all fieldwork and documentation finalized.',
    `survey_date` DATE COMMENT 'Date on which the LDAR survey was conducted at the facility.',
    `survey_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the LDAR survey fieldwork was completed.',
    `survey_notes` STRING COMMENT 'Additional notes, observations, or comments recorded by the inspector during the LDAR survey, including any operational constraints or unusual conditions.',
    `survey_number` STRING COMMENT 'Business identifier for the LDAR survey, typically assigned by the HSE management system or contractor.',
    `survey_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the LDAR survey fieldwork began.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the LDAR survey record: in progress, completed, under review by HSE team, approved for regulatory submission, or rejected requiring re-survey.. Valid values are `in_progress|completed|under_review|approved|rejected`',
    `survey_type` STRING COMMENT 'Classification of the LDAR survey: scheduled routine monitoring, unscheduled inspection, follow-up after previous detection, post-repair verification, or initial baseline survey.. Valid values are `scheduled|unscheduled|follow_up|post_repair|initial`',
    `total_estimated_emissions_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total estimated fugitive emissions expressed in metric tons of carbon dioxide equivalent (CO2e) for greenhouse gas (GHG) reporting and Environmental Social and Governance (ESG) disclosure.',
    `total_estimated_emissions_mcf` DECIMAL(18,2) COMMENT 'Total estimated fugitive emissions volume in thousand cubic feet (MCF) from all detected leaks during the survey, calculated using approved emission factors.',
    `weather_conditions` STRING COMMENT 'General weather conditions during the survey such as clear, cloudy, rain, fog, or snow, which may affect survey quality and detection capability.',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed in miles per hour during the survey, recorded as it may impact the ability to detect fugitive emissions.',
    CONSTRAINT pk_ldar_survey PRIMARY KEY(`ldar_survey_id`)
) COMMENT 'Leak Detection and Repair (LDAR) survey record capturing fugitive emissions monitoring activities at oil and gas facilities. Captures survey date, facility and equipment component surveyed, monitoring method (OGI camera, Method 21 analyzer, audio-visual-olfactory), inspector identity, ambient conditions, number of components surveyed, number of leaks detected, and regulatory program (EPA Method 21, OOOOa). Supports EPA 40 CFR Part 60 Subpart OOOOa compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`ldar_component` (
    `ldar_component_id` BIGINT COMMENT 'Unique identifier for the LDAR component record. Primary key for the LDAR component master data.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility where the LDAR component is located. Links to the facility master data.',
    `asset_id` BIGINT COMMENT 'Link to the parent asset or equipment record in the CMMS. Enables integration with maintenance management and asset lifecycle tracking.',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key linking to petrochemical.conversion_unit. Business justification: LDAR components are located on specific process units. Component tagging, monitoring schedules, and leak repair tracking require linking components to the conversion unit where they are installed.',
    `created_by_employee_id` BIGINT COMMENT 'Identifier of the user who created this LDAR component record. Part of audit trail for data governance.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or organization responsible for LDAR monitoring and compliance for this component. May be operator or contractor.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: LDAR components (valves, flanges, pumps, connectors) are physical equipment items. Equipment FK links fugitive emission monitoring to asset register for maintenance work order generation, component re',
    `last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this LDAR component record. Part of audit trail for data governance.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: LDAR components (valves, flanges, pumps) are registered at the plant level. Component inventories and monitoring schedules are managed at the facility level for regulatory compliance.',
    `process_unit_id` BIGINT COMMENT 'Identifier of the specific process unit or plant area where the component is installed. Used for operational and regulatory segmentation.',
    `component_status` STRING COMMENT 'Current operational status of the LDAR component. Determines whether monitoring is required and affects compliance calculations.. Valid values are `active|inactive|retired|temporarily_removed`',
    `component_subtype` STRING COMMENT 'Detailed classification within the component type (e.g., gate valve, ball valve, flange connector). Provides granular categorization for maintenance and inspection planning.',
    `component_tag_number` STRING COMMENT 'Unique physical tag identifier assigned to the equipment component in the field. Used for field inspection and maintenance tracking.',
    `component_type` STRING COMMENT 'Classification of the equipment component subject to LDAR monitoring. Determines monitoring frequency and regulatory requirements per EPA Method 21.. Valid values are `valve|connector|pump_seal|compressor_seal|open_ended_line|pressure_relief_device`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this LDAR component record was created in the system. Part of audit trail for data governance.',
    `exemption_approval_date` DATE COMMENT 'Date when the regulatory exemption was approved by the appropriate authority. Required for audit trail and compliance verification.',
    `exemption_justification` STRING COMMENT 'Detailed explanation and supporting documentation for any regulatory monitoring exemption claimed for this component.',
    `ghg_reporting_applicable` BOOLEAN COMMENT 'Indicates whether leaks from this component must be included in EPA GHG reporting under 40 CFR Part 98 Subpart W.',
    `hazardous_air_pollutant_service` BOOLEAN COMMENT 'Indicates whether the component handles hazardous air pollutants as defined by EPA Clean Air Act Section 112. Triggers enhanced monitoring requirements.',
    `installation_date` DATE COMMENT 'Date when the component was installed or placed into service. Establishes the start of LDAR monitoring obligations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent LDAR inspection performed on this component. Used to calculate next due date and compliance status.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent LDAR inspection. Determines follow-up actions and repair requirements.. Valid values are `no_leak_detected|leak_detected|repair_completed|delayed_repair`',
    `last_measured_concentration_ppm` DECIMAL(18,2) COMMENT 'Most recent leak concentration measurement in parts per million using EPA Method 21 portable analyzer. Values above 500 ppm typically trigger repair requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this LDAR component record was last modified. Part of audit trail for data governance and change tracking.',
    `leak_threshold_ppm` DECIMAL(18,2) COMMENT 'Regulatory leak definition threshold in parts per million for this component type and service. Typical values: 500 ppm for valves, 10000 ppm for pumps.',
    `manufacturer_name` STRING COMMENT 'Name of the equipment manufacturer. Used for maintenance planning and spare parts management.',
    `model_number` STRING COMMENT 'Manufacturer model or part number for the component. Critical for maintenance and replacement planning.',
    `monitoring_frequency_days` STRING COMMENT 'Required inspection interval in days as determined by regulatory requirements and component type. Typical values: 30, 90, 180, 365 days.',
    `next_inspection_due_date` DATE COMMENT 'Calculated date when the next LDAR inspection is required based on monitoring frequency and last inspection date. Critical for compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional information, special handling instructions, or historical context relevant to LDAR monitoring of this component.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating pressure of the component in pounds per square inch. Affects leak rate calculations and safety considerations.',
    `operating_temperature_f` DECIMAL(18,2) COMMENT 'Normal operating temperature of the component in degrees Fahrenheit. Influences leak detection methodology and component degradation.',
    `permit_number` STRING COMMENT 'Air quality permit number under which this component is regulated. Links LDAR compliance to facility operating permits.',
    `piping_and_instrumentation_diagram_reference` STRING COMMENT 'Reference to the P&ID drawing showing the component location and process context. Essential for field inspection and engineering analysis.',
    `regulatory_exemption_status` STRING COMMENT 'Indicates if the component qualifies for monitoring exemption under EPA regulations. Exemptions must be documented and justified.. Valid values are `not_exempt|unsafe_to_monitor|difficult_to_monitor|inaccessible|low_emissions_process`',
    `regulatory_program` STRING COMMENT 'Specific EPA or state regulatory program under which this component is monitored (e.g., NSPS Subpart VV, NESHAP Subpart H, state-specific program).',
    `retirement_date` DATE COMMENT 'Date when the component was permanently removed from service. Ends LDAR monitoring obligations for this component.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer. Used for warranty tracking and component history.',
    `service_classification` STRING COMMENT 'Physical state classification of the service fluid. Determines applicable monitoring methods and leak detection thresholds per EPA regulations.. Valid values are `light_liquid|heavy_liquid|gas_vapor|two_phase`',
    `service_fluid` STRING COMMENT 'Type of fluid or gas that the component handles (e.g., crude oil, natural gas, H2S, NGL). Critical for determining leak severity and regulatory classification.',
    `volatile_organic_compound_service` BOOLEAN COMMENT 'Indicates whether the component is in VOC service and subject to EPA LDAR regulations. True if VOC content exceeds regulatory thresholds.',
    CONSTRAINT pk_ldar_component PRIMARY KEY(`ldar_component_id`)
) COMMENT 'Master record for individual equipment components subject to LDAR monitoring programs. Captures component type (valve, connector, pump seal, compressor seal, open-ended line, pressure relief device), component tag number, facility, process unit, service fluid, monitoring frequency, last inspection date, next due date, and regulatory exemption status. Serves as the SSOT for LDAR component inventory required by EPA regulations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`emission_source` (
    `emission_source_id` BIGINT COMMENT 'Unique identifier for the emission source. Primary key for the emission source master record.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the oil and gas facility where this emission source is located. Links to the facility master record for site-level aggregation and reporting.',
    `asset_id` BIGINT COMMENT 'Reference to the physical asset record in the CMMS (Maximo) for maintenance history, asset lifecycle, and reliability tracking. Links emission source to asset management workflows.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Emission monitoring and control equipment costs must be allocated to cost centers for environmental compliance budget tracking. Essential for managing air quality compliance program expenses in oil-an',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Emission sources (heaters, boilers, engines, flares, storage tanks) are equipment assets. Equipment FK integrates emissions inventory with asset register for GHG accounting, permit limit tracking, and',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Emission sources consuming fuels/chemicals must link to material master for accurate emission factor application, fuel consumption reconciliation, GHG reporting (EPA GHGRP), and consistency between pr',
    `permit_id` BIGINT COMMENT 'Reference to the air quality permit (Title V, PSD, minor source permit) that authorizes emissions from this source. Links to permit conditions, emission limits, and compliance monitoring requirements.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Emission sources combusting or processing petroleum products require product identification for emission factor selection, EPA air permit compliance, GHG reporting calculations, and fuel quality track',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this emission source record in the HSE management system. Used for audit trail and data governance.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well venting, flaring, and fugitive emissions are tracked as emission sources for EPA Subpart W reporting, state GHG programs, and ESG disclosure. Well FK required for production-normalized emissions ',
    `cems_installed` BOOLEAN COMMENT 'Indicates whether a Continuous Emission Monitoring System is installed on this emission source for real-time measurement of pollutant concentrations and flow rates.',
    `commissioning_date` DATE COMMENT 'Date when the emission source was placed into service and began operations. Used to determine applicability of regulatory requirements and vintage-based emission standards.',
    `control_device_installed` BOOLEAN COMMENT 'Indicates whether an air pollution control device is installed on this emission source (e.g., catalytic converter, scrubber, vapor recovery unit, flare, thermal oxidizer).',
    `control_device_type` STRING COMMENT 'Type of air pollution control device installed. Examples: catalytic converter, selective catalytic reduction (SCR), vapor recovery unit (VRU), thermal oxidizer, flare, scrubber, baghouse, electrostatic precipitator. Null if no control device.',
    `control_efficiency_percent` DECIMAL(18,2) COMMENT 'Design or tested control efficiency of the air pollution control device as a percentage (0-100). Represents the fraction of pollutant removed or destroyed. Used to calculate controlled emissions from uncontrolled emission rates.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this emission source record was first created in the system. ISO 8601 format with timezone.',
    `data_quality_tier` STRING COMMENT 'EPA GHG Mandatory Reporting Rule data quality tier for emission calculations. Tier 4 (highest): CEMS or direct measurement. Tier 3: fuel sampling and analysis. Tier 2: default higher heating values with metered fuel. Tier 1 (lowest): default emission factors. Higher tiers provide greater accuracy.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `decommissioning_date` DATE COMMENT 'Date when the emission source was permanently retired from service. Null if still in service. Used for historical emissions inventory and asset retirement obligations.',
    `emission_factor_source` STRING COMMENT 'Reference to the emission factor database or methodology used for this source. Examples: EPA AP-42 Table 1.4-1, EPA Part 98 Table C-1, API Compendium, IPCC Guidelines, site-specific testing. Used for audit trail and methodology transparency.',
    `equipment_type` STRING COMMENT 'Specific type of equipment or unit operation that constitutes the emission source. Examples: reciprocating engine, gas turbine, glycol dehydrator, condensate tank, pneumatic controller, compressor seal, wellhead, separator.',
    `esg_reporting_scope` STRING COMMENT 'GHG Protocol scope classification for ESG and sustainability reporting. Scope 1: direct emissions from owned/controlled sources. Scope 2: indirect emissions from purchased electricity/steam. Scope 3: value chain emissions. Used for CDP, TCFD, and investor disclosures.. Valid values are `scope_1|scope_2|scope_3|not_applicable`',
    `fuel_heating_value` DECIMAL(18,2) COMMENT 'Higher heating value of the fuel in million British thermal units per unit volume or mass (MMBtu/scf, MMBtu/bbl, MMBtu/ton). Used for energy-based emission calculations per EPA Mandatory Reporting Rule.',
    `fuel_heating_value_unit` STRING COMMENT 'Unit of measure for the fuel heating value. Must align with fuel consumption reporting units.. Valid values are `MMBtu/scf|MMBtu/bbl|MMBtu/ton|MMBtu/kg|MJ/kg|MJ/m3`',
    `geographic_coordinates` STRING COMMENT 'Latitude and longitude of the emission source location in decimal degrees (WGS84 datum). Format: latitude,longitude. Used for spatial analysis, dispersion modeling, and regulatory reporting (EPA Facility Registry Service).',
    `ghg_reporting_required` BOOLEAN COMMENT 'Indicates whether this emission source is subject to EPA GHG Mandatory Reporting Rule (40 CFR Part 98). True if source emits 25,000 metric tons CO2e or more per year.',
    `h2s_concentration_ppm` DECIMAL(18,2) COMMENT 'Concentration of hydrogen sulfide in the gas stream or emissions from this source, measured in parts per million by volume. Critical for worker safety (OSHA PEL 10 ppm), sour gas handling procedures, and sulfur dioxide emissions from flaring or combustion.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this emission source record was last updated. ISO 8601 format with timezone. Used for change detection and data freshness assessment.',
    `ldar_component_count` STRING COMMENT 'Number of fugitive emission components (valves, flanges, connectors, pumps, compressor seals) associated with this emission source that are monitored under the LDAR program. Used for leak rate estimation and inspection scheduling.',
    `ldar_program_applicable` BOOLEAN COMMENT 'Indicates whether this emission source (typically fugitive equipment components) is subject to a Leak Detection and Repair program under EPA NSPS, NESHAP, or state regulations.',
    `monitoring_methodology` STRING COMMENT 'Method used to quantify emissions from this source. CEMS: Continuous Emission Monitoring System. PEMS: Predictive Emission Monitoring System. Fuel analysis: lab testing of fuel composition. Engineering calculation: equipment-specific algorithms. Emission factor: EPA AP-42 or industry factors. Mass balance: material input-output accounting. [ENUM-REF-CANDIDATE: CEMS|PEMS|fuel_analysis|engineering_calculation|emission_factor|mass_balance|direct_measurement — 7 candidates stripped; promote to reference product]',
    `neshap_subpart_applicable` STRING COMMENT 'EPA NESHAP subpart(s) applicable to this emission source for hazardous air pollutant (HAP) control. Examples: Subpart HH (oil and natural gas production), Subpart ZZZZ (stationary reciprocating internal combustion engines). Null if no NESHAP applies.',
    `norm_present` BOOLEAN COMMENT 'Indicates whether Naturally Occurring Radioactive Material (radium-226, radium-228) is present in scale, sludge, or waste streams from this emission source. Triggers special handling, disposal, and worker protection requirements.',
    `nsps_subpart_applicable` STRING COMMENT 'EPA NSPS subpart(s) applicable to this emission source. Examples: Subpart OOOO (oil and gas well completions), Subpart OOOOa (new/modified sources), Subpart Dc (steam generating units). Null if no NSPS applies.',
    `operational_status` STRING COMMENT 'Current operational status of the emission source. Active: in regular operation. Standby: available but not operating. Idle: temporarily shut down. Maintenance: undergoing repair or inspection. Decommissioned: permanently retired. Planned: not yet commissioned.. Valid values are `active|standby|idle|maintenance|decommissioned|planned`',
    `permit_emission_limit` DECIMAL(18,2) COMMENT 'Maximum allowable emission rate or annual emission quantity specified in the air permit for this source. Used for compliance tracking and exceedance detection. Unit of measure specified in permit_emission_limit_unit.',
    `permit_emission_limit_unit` STRING COMMENT 'Unit of measure for the permit emission limit. Must match the permit condition language.. Valid values are `tons/year|kg/year|lb/hr|g/s|metric_tons_CO2e/year`',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Maximum design capacity or nameplate rating of the emission source. For combustion equipment: maximum heat input (MMBtu/hr) or power output (MW). For storage tanks: working capacity (bbl). For compressors: horsepower (HP).',
    `rated_capacity_unit` STRING COMMENT 'Unit of measure for the rated capacity of the emission source. [ENUM-REF-CANDIDATE: MMBtu/hr|MW|HP|bbl|m3|scf/day|BOPD|MCFD — 8 candidates stripped; promote to reference product]',
    `regulatory_threshold_applicable` BOOLEAN COMMENT 'Indicates whether this emission source is subject to regulatory reporting thresholds (EPA Title V, GHG Mandatory Reporting Rule, state air permits). True if source meets or exceeds applicability thresholds.',
    `source_category` STRING COMMENT 'GHG Protocol source category for emissions inventory and ESG reporting. Aligns with Scope 1 direct emissions classification under ISO 14064-1.. Valid values are `stationary_combustion|mobile_combustion|process_emissions|fugitive_emissions|vented_emissions|flared_emissions`',
    `source_name` STRING COMMENT 'Descriptive name of the emission source for identification and reporting purposes. Examples: Flare Stack 1A, Compressor Engine 3B, Storage Tank 402, Glycol Dehydrator Unit 5.',
    `source_number` STRING COMMENT 'Business identifier for the emission source, typically assigned by facility HSE team. Used in regulatory filings, permits, and internal tracking systems. Must be unique within the facility.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `source_type` STRING COMMENT 'Classification of the emission source by emission mechanism. Combustion: engines, turbines, heaters, boilers. Venting: controlled release of gas. Flaring: combustion of waste gas. Fugitive: leaks from equipment. Process: chemical reactions. Storage: tank breathing losses. Loading: transfer operations. [ENUM-REF-CANDIDATE: combustion|venting|flaring|fugitive|process|storage|loading|other — 8 candidates stripped; promote to reference product]',
    `stack_diameter_meters` DECIMAL(18,2) COMMENT 'Inside diameter of the emission stack at the exit point in meters. Used for exit velocity calculation and dispersion modeling.',
    `stack_height_meters` DECIMAL(18,2) COMMENT 'Physical height of the emission stack or release point above ground level in meters. Used for air dispersion modeling and good engineering practice (GEP) stack height determination.',
    `title_v_major_source` BOOLEAN COMMENT 'Indicates whether this emission source contributes to the facility being classified as a Title V major source under the Clean Air Act (potential to emit 100 tons/year of any criteria pollutant or 10/25 tons/year of HAPs).',
    CONSTRAINT pk_emission_source PRIMARY KEY(`emission_source_id`)
) COMMENT 'Master record for stationary and fugitive emission sources at oil and gas facilities subject to GHG and criteria pollutant reporting. Captures source type (combustion, venting, flaring, fugitive, process), emission source ID, facility, process unit, fuel or feedstock type, applicable regulatory thresholds (EPA Title V, GHG MRR), monitoring methodology, and operational status. Supports EPA GHG Mandatory Reporting Rule (40 CFR Part 98) and ESG emissions inventory.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`ghg_emission` (
    `ghg_emission_id` BIGINT COMMENT 'Unique identifier for the greenhouse gas emission record.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility or site where the emission occurred.',
    `emission_source_id` BIGINT COMMENT 'Identifier of the specific emission source unit or equipment (e.g., flare, combustion unit, fugitive source).',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: GHG emissions are reported at the facility level. EPA GHGRP Subpart X (petrochemicals) requires plant-level annual emission quantification and reporting for ethylene, propylene, and other petrochemica',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: GHG emission calculations require product-specific emission factors and carbon intensity values. Product identification is mandatory for EPA Subpart C/W reporting, Scope 3 emissions tracking, and ESG ',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created the emission record.',
    `revenue_allocation_id` BIGINT COMMENT 'Foreign key linking to revenue.allocation. Business justification: GHG emissions determine carbon tax liabilities and emission credit allocations to revenue owners. Real business: production sharing agreements allocate environmental costs based on actual emissions. E',
    `activity_data_unit` STRING COMMENT 'Unit of measure for the activity data (e.g., MMBTU, MCF, barrels, tonnes).',
    `activity_data_value` DECIMAL(18,2) COMMENT 'Quantitative activity data used in the emission calculation (e.g., fuel consumed, gas flared, production volume).',
    `calculation_notes` STRING COMMENT 'Additional notes or comments regarding the emission calculation, methodology, or data quality.',
    `carbon_offset_applied` BOOLEAN COMMENT 'Indicates whether a carbon offset or credit has been applied to this emission.',
    `carbon_offset_tonnes` DECIMAL(18,2) COMMENT 'Quantity of carbon offset credits applied to this emission, measured in CO2e tonnes.',
    `co2e_tonnes` DECIMAL(18,2) COMMENT 'Total greenhouse gas emission expressed in carbon dioxide equivalent (CO2e) metric tonnes, calculated by multiplying GHG quantity by its global warming potential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission record was first created in the system.',
    `data_quality_tier` STRING COMMENT 'Data quality tier classification per EPA reporting requirements: tier 1 (highest accuracy), tier 2, tier 3, tier 4 (lowest accuracy/default factors).. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `data_source_system` STRING COMMENT 'Name of the source system or application from which the emission data was captured (e.g., Enablon, OSIsoft PI, manual entry).',
    `emission_event_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission event occurred or was measured, if available at event-level granularity.',
    `emission_factor_source` STRING COMMENT 'Source or reference for the emission factor used (e.g., EPA default, IPCC, site-specific test).',
    `emission_factor_unit` STRING COMMENT 'Unit of measure for the emission factor (e.g., kg CO2e per MMBTU, tonnes CO2 per barrel).',
    `emission_factor_value` DECIMAL(18,2) COMMENT 'Emission factor applied in the calculation, representing the quantity of GHG emitted per unit of activity.',
    `emission_source_category` STRING COMMENT 'Category of the emission source: combustion, flaring, venting, fugitive, process, or other.. Valid values are `combustion|flaring|venting|fugitive|process|other`',
    `epa_subpart_code` STRING COMMENT 'EPA 40 CFR Part 98 subpart code applicable to this emission source (e.g., Subpart W for petroleum and natural gas systems).',
    `esg_disclosure_included` BOOLEAN COMMENT 'Indicates whether this emission is included in ESG or TCFD sustainability disclosures.',
    `ghg_gas_type` STRING COMMENT 'Type of greenhouse gas emitted: CO2 (carbon dioxide), CH4 (methane), N2O (nitrous oxide), HFC (hydrofluorocarbon), PFC (perfluorocarbon), SF6 (sulfur hexafluoride).. Valid values are `CO2|CH4|N2O|HFC|PFC|SF6`',
    `ghg_quantity_tonnes` DECIMAL(18,2) COMMENT 'Quantity of the specific greenhouse gas emitted, measured in metric tonnes.',
    `global_warming_potential` DECIMAL(18,2) COMMENT 'Global warming potential factor for the gas type, used to convert to CO2 equivalent (e.g., CH4 = 25, N2O = 298).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission record was last modified.',
    `measurement_uncertainty_percent` DECIMAL(18,2) COMMENT 'Estimated uncertainty of the emission measurement or calculation, expressed as a percentage.',
    `net_emission_co2e_tonnes` DECIMAL(18,2) COMMENT 'Net greenhouse gas emission after applying carbon offsets, measured in CO2e tonnes.',
    `quantification_methodology` STRING COMMENT 'Methodology used to quantify the emission: direct measurement, emission factor, mass balance, engineering estimate, default factor, or continuous monitoring.. Valid values are `direct_measurement|emission_factor|mass_balance|engineering_estimate|default_factor|continuous_monitoring`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this emission record is subject to mandatory regulatory reporting (e.g., EPA GHGRP).',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period for which the emission is calculated.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period for which the emission is calculated.',
    `scope_classification` STRING COMMENT 'GHG Protocol scope classification: Scope 1 (direct emissions), Scope 2 (indirect emissions from purchased energy), Scope 3 (other indirect emissions).. Valid values are `scope_1|scope_2|scope_3`',
    `verification_date` DATE COMMENT 'Date when the emission data was verified.',
    `verification_status` STRING COMMENT 'Verification status of the emission data: unverified, verified, third-party verified, or pending verification.. Valid values are `unverified|verified|third_party_verified|pending_verification`',
    `verifier_name` STRING COMMENT 'Name of the third-party verifier or internal auditor who verified the emission data.',
    CONSTRAINT pk_ghg_emission PRIMARY KEY(`ghg_emission_id`)
) COMMENT 'Greenhouse gas (GHG) emission measurement and calculation record capturing CO2, CH4, N2O, and other GHG emissions by source, facility, and reporting period. Captures emission source, gas type, quantification methodology (direct measurement, emission factor, mass balance), activity data, emission factor applied, calculated CO2e tonnes, data quality tier, and verification status. Supports EPA 40 CFR Part 98 annual GHG reporting and ESG/TCFD disclosure.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`spill_event` (
    `spill_event_id` BIGINT COMMENT 'Unique identifier for the environmental spill or release event record. Primary key for the spill event entity.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility, platform, well site, refinery, terminal, or operational location where the spill event occurred.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Spills by carriers reference carrier for insurance claims and approval status. Essential for liability determination and vetting.',
    `charter_party_id` BIGINT COMMENT 'Foreign key linking to logistics.charter_party. Business justification: Spills during charter party reference charter for P&I claims and demurrage. Essential for liability determination and insurance claims.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spill cleanup costs (estimated_cleanup_cost_usd field present) must be allocated to cost centers for environmental incident cost tracking and insurance claims. Critical for oil-and-gas environmental l',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Spills during custody transfer reference transfer for environmental reporting and liability. Essential for volume reconciliation and regulatory compliance.',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_order. Business justification: Spills during delivery orders reference order for environmental reporting and liability. Essential for volume reconciliation and regulatory compliance.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Equipment failures cause spills (tank overflow, pump seal failure, valve packing leak). Equipment FK required for failure analysis, asset reliability tracking, equipment replacement prioritization, an',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Spills during exploration drilling (drilling mud, completion fluids, hydrocarbons from DST) must link to well for NRC/BSEE reporting, AFE cost allocation, environmental impact assessment, and well-spe',
    `freight_invoice_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_invoice. Business justification: Spills during freight operations reference invoice for environmental cost allocation. Essential for liability determination and financial reconciliation.',
    `incident_id` BIGINT COMMENT 'Foreign key reference to the parent HSE incident record for unified event tracking and root cause analysis across all incident types.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Spill events at joint operations trigger JOA liability provisions, insurance claims, cleanup cost allocation, and regulatory reporting obligations; cleanup costs are joint account charges billed throu',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Spills on leased land trigger lease clause reviews, lessor notifications, potential lease termination risk assessments, and lease-specific remediation obligations. Critical for land department spill r',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Spills occur at specific petrochemical facilities. NRC notifications, BSEE reporting, cleanup activities, and environmental impact assessments require linking spill events to the plant where they occu',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Spill events must identify the specific petroleum product released for NRC/BSEE regulatory reporting, cleanup method selection, environmental impact assessment, and financial liability calculations. R',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline spills must link to specific segment for integrity investigation, PHMSA incident reporting (Form 7000-1), risk model updates, segment-level spill rate tracking, and remediation cost allocatio',
    `pipeline_throughput_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_throughput. Business justification: Spills during pipeline throughput reference throughput for PHMSA reporting and liability. Essential for volume reconciliation and environmental compliance.',
    `port_call_id` BIGINT COMMENT 'Foreign key linking to logistics.port_call. Business justification: Spills during port calls reference port call for port authority reporting. Essential for liability determination and regulatory compliance.',
    `employee_id` BIGINT COMMENT 'Reference to the legal entity, operator, contractor, or joint venture partner determined to be the responsible party for the spill under OPA 90 or other applicable liability frameworks.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Spill cleanup and remediation costs are invoiced to responsible parties, JV partners, or third parties under JOA/PSA cost recovery provisions. Real business process: environmental incident cost alloca',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Spill response contractors and cleanup service vendors must be tracked for regulatory reporting (NRC, BSEE), cost recovery and insurance claims, vendor performance evaluation, and verification of vend',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Spills on ROW require grantor notification, remediation per ROW agreement terms, potential ROW termination risk assessment, and ROW-specific cleanup obligations. Essential for grantor relations and RO',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Spills at terminals reference terminal for environmental compliance. Essential for EPA SPCC reporting and operational approval.',
    `tertiary_spill_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user or system account that most recently updated the spill event record, supporting change tracking and accountability.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Spills require tract-level tracking for surface owner notifications, remediation boundary definition, title opinion updates regarding environmental encumbrances, and tract-specific cleanup cost alloca',
    `truck_ticket_id` BIGINT COMMENT 'Foreign key linking to logistics.truck_ticket. Business justification: Spills during truck loading reference ticket for volume reconciliation and environmental reporting. Essential for liability determination and regulatory compliance.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Spill events require partner notification per JOA terms; operator vs non-operator responsibilities, insurance claims coordination, and cleanup cost sharing follow partnership agreement provisions.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Spills from vessels reference vessel for P&I claims and vetting status. Essential for liability determination and charter approval.',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: Spills during voyages reference voyage for charter party claims and insurance. Essential for liability determination and regulatory reporting.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well spills (flowback, produced water, wellhead equipment leak) require well-specific linkage for state regulatory reporting, reserves impact assessment (lost production), well integrity investigation',
    `bsee_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether the spill occurred on offshore facilities under BSEE jurisdiction and meets incident reporting thresholds, triggering mandatory notification to BSEE.',
    `bsee_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the offshore spill was reported to BSEE, demonstrating compliance with immediate notification requirements for offshore incidents.',
    `cleanup_completion_date` DATE COMMENT 'Date when active cleanup operations were completed and the site was transitioned to monitoring or remediation phase, or declared clean by regulatory authorities.',
    `cleanup_method` STRING COMMENT 'Primary cleanup or remediation method employed to remove or treat the released substance from the environment. Selection depends on substance type, volume, receiving environment, and regulatory approval. [ENUM-REF-CANDIDATE: mechanical_recovery|chemical_dispersant|in_situ_burning|bioremediation|excavation|natural_attenuation|combination — 7 candidates stripped; promote to reference product]',
    `cleanup_start_date` DATE COMMENT 'Date when active cleanup and recovery operations commenced following containment activities. Used for tracking response timeline and regulatory compliance.',
    `confirmed_volume_barrels` DECIMAL(18,2) COMMENT 'Final confirmed volume of the spill in barrels (BBL) after investigation, measurement, and reconciliation. This is the official volume used for regulatory reporting, financial liability, and environmental impact assessment.',
    `containment_actions_taken` STRING COMMENT 'Narrative description of immediate containment measures deployed to prevent further spread of the released substance, including booms, berms, dikes, absorbent materials, or emergency shutdown procedures.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the spill event record was first created in the HSE management system. Part of audit trail for regulatory compliance and data governance.',
    `environmental_impact_assessment_completed` BOOLEAN COMMENT 'Boolean flag indicating whether a formal environmental impact assessment or natural resource damage assessment has been completed for the spill event, as required for significant releases.',
    `estimated_cleanup_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in United States Dollars for spill response, containment, cleanup, remediation, and regulatory compliance activities. Used for financial planning, insurance claims, and liability assessment.',
    `estimated_volume_barrels` DECIMAL(18,2) COMMENT 'Initial estimated volume of the spill in barrels (BBL), typically provided during immediate notification before confirmed measurements are available. Used for rapid response planning and regulatory notification.',
    `impacted_area_extent_acres` DECIMAL(18,2) COMMENT 'The geographic extent of the area affected by the spill measured in acres, including soil contamination, water body surface area, or shoreline length. Used for environmental impact assessment and remediation planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the spill event record was most recently updated. Part of audit trail for regulatory compliance and data governance.',
    `nrc_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether the spill meets EPA National Response Center reporting thresholds based on substance type, volume, and receiving environment. Determines immediate federal notification obligations.',
    `nrc_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the spill was reported to the EPA National Response Center, demonstrating compliance with immediate notification requirements (typically within 24 hours of discovery).',
    `nrc_report_number` STRING COMMENT 'Official report number assigned by the EPA National Response Center upon notification, used for tracking federal regulatory follow-up and cross-referencing with other agency reports.',
    `onshore_offshore_indicator` STRING COMMENT 'Classification indicating whether the spill occurred in an onshore facility, offshore platform or vessel, coastal zone, or inland waterway. Determines applicable regulatory jurisdiction and response protocols.. Valid values are `onshore|offshore|coastal|inland_water`',
    `receiving_environment` STRING COMMENT 'The environmental medium or compartment into which the released substance was discharged. Critical for determining environmental impact severity, cleanup methods, and regulatory notification requirements. [ENUM-REF-CANDIDATE: soil|surface_water|groundwater|open_ocean|coastal_water|wetland|containment_system|paved_surface — 8 candidates stripped; promote to reference product]',
    `regulatory_closure_date` DATE COMMENT 'Date when the spill event was officially closed by regulatory authorities (EPA, BSEE, state agency) following completion of cleanup, remediation, and all required reporting and documentation.',
    `release_cause_category` STRING COMMENT 'High-level classification of the root cause or contributing factor that led to the unplanned release. Used for trend analysis, preventive action planning, and regulatory reporting. [ENUM-REF-CANDIDATE: equipment_failure|corrosion|human_error|operational_upset|natural_event|third_party_damage|unknown|under_investigation — 8 candidates stripped; promote to reference product]',
    `release_cause_description` STRING COMMENT 'Detailed narrative description of the specific cause, failure mode, or sequence of events that resulted in the spill. Includes equipment identifiers, failure mechanisms, and contributing factors identified during investigation.',
    `remediation_status` STRING COMMENT 'Current status of long-term remediation activities for soil, groundwater, or ecological restoration following initial cleanup. Tracks progress toward final site closure and regulatory approval.. Valid values are `not_required|planned|in_progress|monitoring|completed|regulatory_approved`',
    `spill_discovery_timestamp` TIMESTAMP COMMENT 'The date and time when the spill was discovered or detected by personnel, monitoring systems, or third parties. May differ from occurrence time for slow leaks or delayed detection.',
    `spill_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the spill location for mapping, spatial analysis, and regulatory reporting. Critical for offshore spills and environmental impact assessment.',
    `spill_location_description` STRING COMMENT 'Detailed textual description of the specific location within the facility or operational area where the spill occurred, including equipment identifiers, unit names, or geographic landmarks.',
    `spill_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the spill location for mapping, spatial analysis, and regulatory reporting. Critical for offshore spills and environmental impact assessment.',
    `spill_occurrence_timestamp` TIMESTAMP COMMENT 'The date and time when the unplanned release or spill event occurred or was first observed. This is the principal business event timestamp for the spill.',
    `spill_reference_number` STRING COMMENT 'External business identifier or case number assigned to the spill event for regulatory reporting, insurance claims, and cross-system tracking. May include EPA NRC report number, BSEE incident number, or internal case identifier.',
    `spill_status` STRING COMMENT 'Current lifecycle status of the spill event indicating the stage of response, investigation, cleanup, remediation, and regulatory closure activities. [ENUM-REF-CANDIDATE: reported|under_investigation|containment_in_progress|cleanup_in_progress|remediation_in_progress|monitoring|closed|regulatory_review_pending — 8 candidates stripped; promote to reference product]',
    `state_agency_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether state environmental or emergency management agency notification is required based on spill location, volume, and state-specific reporting thresholds.',
    `state_agency_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the spill was reported to the applicable state environmental or emergency management agency, demonstrating compliance with state-level notification requirements.',
    `uscg_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether United States Coast Guard notification is required for spills in navigable waters, coastal zones, or offshore areas under USCG jurisdiction per OPA 90 requirements.',
    `uscg_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the spill was reported to the United States Coast Guard for spills affecting navigable waters or coastal zones.',
    `volume_recovered_barrels` DECIMAL(18,2) COMMENT 'Total volume of released substance successfully recovered during cleanup operations, measured in barrels. Used to calculate net environmental loss and cleanup effectiveness.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure used for reporting spill volume, accommodating different regulatory requirements and substance types. Barrels for crude oil, gallons for refined products, pounds for chemicals.. Valid values are `barrels|gallons|liters|cubic_meters|pounds|kilograms`',
    `wildlife_impact_reported` BOOLEAN COMMENT 'Boolean flag indicating whether the spill resulted in documented impacts to wildlife, including fish, birds, marine mammals, or protected species. Triggers additional regulatory reporting and remediation requirements.',
    CONSTRAINT pk_spill_event PRIMARY KEY(`spill_event_id`)
) COMMENT 'Environmental spill and release event record capturing unplanned releases of crude oil, refined products, chemicals, produced water, drilling fluids, or other hazardous materials from oil and gas operations. Captures spill date/time, location coordinates (onshore/offshore, GPS), substance released, estimated and confirmed volume (barrels, gallons, or pounds), release cause (equipment failure, corrosion, human error, natural event), receiving environment (soil, water body, groundwater, open water), impacted area extent, regulatory notification status and timestamps (BSEE, EPA NRC, state agency, USCG), containment actions taken, cleanup method, remediation status, and final closure date. Links to parent incident record for unified HSE event tracking. Supports BSEE, EPA National Response Center, OPA 90, and state spill reporting requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` (
    `h2s_monitoring_id` BIGINT COMMENT 'Unique identifier for the H2S monitoring record.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where H2S monitoring is performed.',
    `detector_id` BIGINT COMMENT 'Unique identifier or serial number of the H2S detection equipment used for the measurement.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: H2S detectors monitor specific equipment (separators, treaters, tanks, wellheads). Equipment FK required for alarm management system integration, detector maintenance work order generation, and equipm',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Continuous H2S monitoring at exploration wells with sour gas potential. Critical for personnel safety during drilling and testing. Links monitoring data to well for real-time alerts, evacuation decisi',
    `incident_id` BIGINT COMMENT 'Identifier of the HSE incident record if the H2S detection event resulted in a reportable incident.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: H2S monitoring on leased properties; lease compliance for sour gas operations, lessor safety notifications, lease-specific H2S protocols, and lease clause verification for H2S operations. Critical for',
    `permit_to_work_id` BIGINT COMMENT 'Identifier of the active Permit to Work at the time of H2S detection, if applicable.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: H2S monitoring systems are installed at sour service petrochemical facilities. Real-time monitoring, alarm management, and evacuation procedures are plant-specific safety systems.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Sour gas pipeline monitoring requires segment-level tracking for emergency response planning (evacuation zones), public safety notification, segment-specific H2S concentration trending, and regulatory',
    `simops_plan_id` BIGINT COMMENT 'Identifier of the active SIMOPS plan at the time of H2S detection, if applicable.',
    `well_asset_id` BIGINT COMMENT 'Identifier of the well site where H2S monitoring is performed, if applicable.',
    `alarm_level` STRING COMMENT 'Classification of the alarm level triggered by the H2S concentration: none (below threshold), low (warning level), high (action level), ceiling (OSHA 20 ppm ceiling), IDLH (Immediately Dangerous to Life or Health, 100 ppm).. Valid values are `none|low|high|ceiling|idlh`',
    `alarm_threshold_breached` BOOLEAN COMMENT 'Indicates whether the measured H2S concentration exceeded the configured alarm threshold.',
    `all_clear_timestamp` TIMESTAMP COMMENT 'Date and time when the all-clear signal was given and normal operations resumed after the H2S event.',
    `calibration_date` DATE COMMENT 'Date when the H2S detector was last calibrated prior to this measurement.',
    `calibration_due_date` DATE COMMENT 'Date when the next calibration of the H2S detector is due.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this H2S monitoring record was created in the system.',
    `data_source_system` STRING COMMENT 'Name of the source system that captured the H2S monitoring data (e.g., OSIsoft PI System, SCADA, Enablon HSE Management).',
    `detector_status` STRING COMMENT 'Operational status of the H2S detector at the time of measurement.. Valid values are `operational|fault|maintenance|calibration_overdue|offline`',
    `detector_type` STRING COMMENT 'Type of H2S detection equipment used for monitoring.. Valid values are `fixed_electrochemical|portable_personal_monitor|fixed_infrared|portable_colorimetric|area_monitor`',
    `evacuation_initiated` BOOLEAN COMMENT 'Indicates whether a facility or well site evacuation was initiated in response to the H2S detection event.',
    `evacuation_timestamp` TIMESTAMP COMMENT 'Date and time when the evacuation order was issued, if applicable.',
    `h2s_concentration_ppm` DECIMAL(18,2) COMMENT 'Measured concentration of hydrogen sulfide in parts per million at the monitoring location and timestamp.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the monitoring location and time, which can affect H2S detection accuracy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this H2S monitoring record was last modified in the system.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the H2S concentration measurement was recorded.',
    `monitoring_location` STRING COMMENT 'Specific location description within the facility or well site where the H2S detector is positioned (e.g., wellhead, separator, compressor station, tank battery).',
    `muster_station_activated` BOOLEAN COMMENT 'Indicates whether the muster station alarm was activated in response to the H2S detection event.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the H2S monitoring event, detector performance, or response actions.',
    `personnel_count_evacuated` STRING COMMENT 'Number of personnel evacuated from the facility or well site in response to the H2S detection event.',
    `personnel_count_onsite` STRING COMMENT 'Number of personnel present at the facility or well site at the time of the H2S detection event.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the H2S detection event requires notification to regulatory authorities (OSHA, EPA, BSEE) based on concentration levels and exposure duration.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of the H2S detection event, if required.',
    `response_action_taken` STRING COMMENT 'Description of the immediate response actions taken following the H2S detection event (e.g., area isolation, ventilation, source shutdown, emergency response team dispatch).',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Fahrenheit at the monitoring location and time, which can affect H2S detection accuracy.',
    `wind_direction_degrees` STRING COMMENT 'Wind direction in degrees (0-360) at the time of measurement, used for dispersion modeling and evacuation planning.',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed in miles per hour at the time of measurement, used for dispersion modeling and evacuation planning.',
    CONSTRAINT pk_h2s_monitoring PRIMARY KEY(`h2s_monitoring_id`)
) COMMENT 'Hydrogen sulfide (H2S) monitoring record capturing fixed and portable H2S detector readings at oil and gas facilities and well sites. Captures monitoring location, detector type (fixed electrochemical, portable personal monitor), measurement timestamp, H2S concentration (ppm), alarm threshold breached (OSHA ceiling 20 ppm, IDLH 100 ppm), wind direction and speed, muster station activation flag, and evacuation event flag. Critical for OSHA 29 CFR 1910.1000 compliance and worker safety.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`norm_record` (
    `norm_record_id` BIGINT COMMENT 'Unique identifier for the NORM management record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where NORM contamination was identified or managed.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: NORM contamination found on specific equipment (separators, filters, tubing, scale in vessels) requires equipment-level tracking for disposal planning during decommissioning, worker protection (ALARA)',
    `hierarchy_id` BIGINT COMMENT 'Identifier of the specific asset or equipment affected by NORM contamination (e.g., pipe, vessel, separator, tank).',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: NORM discovered on leased properties triggers lease clause reviews, lessor notifications, potential lease liability assessments, and lease-specific NORM handling requirements. Critical for lease compl',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline NORM scale accumulation (Ra-226, Ra-228 in produced water lines) requires segment-level tracking for disposal planning during decommissioning, maintenance planning (pigging, cutting), and wor',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: NORM contamination is tract-specific; surface owner notifications, title opinion updates regarding NORM encumbrances, tract-level remediation tracking, and tract value impact assessment required. Esse',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Wellbore NORM contamination (tubing, casing, downhole equipment) requires well-specific tracking for P&A planning, disposal cost estimation in ARO calculation, and regulatory compliance with state NOR',
    `activity_level_unit` STRING COMMENT 'Unit of measure for the activity level. Common units include pCi/g (picocuries per gram), Bq/kg (becquerels per kilogram), pCi/L (picocuries per liter), or Bq/L (becquerels per liter).. Valid values are `pci_per_g|bq_per_kg|pci_per_l|bq_per_l`',
    `activity_level_value` DECIMAL(18,2) COMMENT 'Measured radioactivity level of the NORM sample, expressed as a numeric value. Unit of measure is specified separately.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NORM record was first created in the system.',
    `decontamination_date` DATE COMMENT 'Date when decontamination activities were completed.',
    `decontamination_method` STRING COMMENT 'Method or technique used to decontaminate the NORM-affected equipment or area (e.g., chemical cleaning, mechanical removal, high-pressure washing).',
    `decontamination_performed_flag` BOOLEAN COMMENT 'Indicates whether decontamination was performed on the NORM-contaminated equipment or area.',
    `discovery_date` DATE COMMENT 'Date when the NORM contamination was first discovered or identified.',
    `discovery_method` STRING COMMENT 'Method by which the NORM contamination was discovered (e.g., routine survey, maintenance inspection, decommissioning survey, incident investigation, regulatory inspection).. Valid values are `routine_survey|maintenance_inspection|decommissioning_survey|incident_investigation|regulatory_inspection`',
    `disposal_date` DATE COMMENT 'Date when the NORM-contaminated material was disposed of or transferred to a disposal facility.',
    `disposal_facility_license_number` STRING COMMENT 'License or permit number of the disposal facility authorized to receive NORM waste.',
    `disposal_facility_name` STRING COMMENT 'Name of the licensed disposal facility where NORM-contaminated material was or will be disposed.',
    `disposal_manifest_number` STRING COMMENT 'Tracking or manifest number for the shipment of NORM waste to the disposal facility.',
    `disposal_method` STRING COMMENT 'Method used or planned for disposal of the NORM-contaminated material (e.g., licensed disposal facility, onsite storage, exempt landfill, recycling, decontamination, pending).. Valid values are `licensed_disposal_facility|onsite_storage|exempt_landfill|recycling|decontamination|pending`',
    `handling_procedure_reference` STRING COMMENT 'Reference to the internal procedure or work instruction governing the handling of this NORM material.',
    `laboratory_certification_number` STRING COMMENT 'Certification or license number of the laboratory that performed the NORM analysis.',
    `laboratory_name` STRING COMMENT 'Name of the certified laboratory that performed the NORM analysis, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NORM record was last updated or modified.',
    `location_description` STRING COMMENT 'Detailed description of the physical location within the facility where NORM contamination was identified.',
    `measurement_date` DATE COMMENT 'Date when the NORM activity level measurement was performed.',
    `measurement_method` STRING COMMENT 'Method or technique used to measure NORM activity levels (e.g., gamma spectroscopy, scintillation counting, field survey meter).',
    `norm_classification` STRING COMMENT 'Regulatory classification of the NORM material based on activity levels and applicable state or federal thresholds.. Valid values are `below_regulatory_threshold|above_regulatory_threshold|exempt|licensed_material`',
    `norm_record_number` STRING COMMENT 'Business-assigned unique tracking number for the NORM record, used for regulatory reporting and internal tracking.',
    `norm_source_description` STRING COMMENT 'Detailed description of the NORM source, including physical characteristics, location within the facility, and context of discovery.',
    `norm_source_type` STRING COMMENT 'Type of material or source where NORM contamination was detected. Common sources include pipe scale, vessel deposits, produced water sludge, drilling mud, completion fluids, and equipment surface contamination.. Valid values are `pipe_scale|vessel_deposits|produced_water_sludge|drilling_mud|completion_fluids|equipment_surface_contamination`',
    `post_decontamination_activity_level` DECIMAL(18,2) COMMENT 'Measured radioactivity level after decontamination, confirming effectiveness of decontamination efforts. Unit is same as activity_level_unit.',
    `radionuclide_type` STRING COMMENT 'Primary radionuclide detected in the NORM sample. Common types include Ra-226 (Radium-226), Ra-228 (Radium-228), Pb-210 (Lead-210), Po-210 (Polonium-210), Th-232 (Thorium-232), U-238 (Uranium-238), or mixed radionuclides. [ENUM-REF-CANDIDATE: ra_226|ra_228|pb_210|po_210|th_232|u_238|mixed — 7 candidates stripped; promote to reference product]',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status of the NORM record with respect to applicable state radiation control program requirements.. Valid values are `compliant|non_compliant|pending_review|exempted`',
    `regulatory_report_date` DATE COMMENT 'Date when the regulatory report was submitted to the applicable authority.',
    `regulatory_report_reference_number` STRING COMMENT 'Reference or confirmation number assigned by the regulatory authority for the submitted NORM report.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether a regulatory report has been submitted to the state radiation control program or other regulatory authority.',
    `regulatory_threshold_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the measured NORM activity level exceeds the applicable regulatory threshold requiring special handling or disposal.',
    `responsible_party_email` STRING COMMENT 'Email address of the responsible party for NORM management and compliance.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'Name of the individual or organization responsible for managing this NORM record and ensuring compliance.',
    `waste_volume_unit` STRING COMMENT 'Unit of measure for the waste volume (e.g., cubic feet, cubic meters, gallons, barrels, liters).. Valid values are `cubic_feet|cubic_meters|gallons|barrels|liters`',
    `waste_volume_value` DECIMAL(18,2) COMMENT 'Volume of NORM-contaminated waste material. Unit of measure is specified separately.',
    `waste_weight_unit` STRING COMMENT 'Unit of measure for the waste weight (e.g., pounds, kilograms, tons, metric tons).. Valid values are `pounds|kilograms|tons|metric_tons`',
    `waste_weight_value` DECIMAL(18,2) COMMENT 'Weight of NORM-contaminated waste material. Unit of measure is specified separately.',
    CONSTRAINT pk_norm_record PRIMARY KEY(`norm_record_id`)
) COMMENT 'Naturally Occurring Radioactive Material (NORM) management record tracking NORM-contaminated equipment, scale deposits, produced water, and waste streams at oil and gas facilities. Captures NORM source (pipe scale, vessel deposits, produced water sludge), radionuclide type (Ra-226, Ra-228, Pb-210), activity level (pCi/g or Bq/kg), equipment or location affected, disposal method, licensed disposal facility, and regulatory compliance status. Supports state radiation control program requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring record.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where monitoring was conducted.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Environmental monitoring program costs (sampling, laboratory analysis, equipment maintenance) require cost center allocation for regulatory compliance budget management. Standard practice for tracking',
    `detector_instrument_id` BIGINT COMMENT 'Unique serial number or asset tag of the specific detector or instrument used for this measurement.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Monitoring stations on leased land; lease compliance verification, lessor reporting obligations, baseline environmental condition tracking, and lease-specific monitoring requirements. Essential for le',
    `monitoring_station_id` BIGINT COMMENT 'Unique identifier for the monitoring station or sample point location (e.g., fixed air quality station, groundwater well, perimeter fence line).',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Environmental monitoring programs track product-specific parameters (benzene from gasoline, H2S from sour crude, VOCs from refined products) for air permit compliance, fence-line monitoring, and commu',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who collected the sample or performed the measurement.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Monitoring data tied to specific tracts for surface owner reporting, regulatory compliance by location, environmental baseline documentation, and tract-level impact assessment. Critical for surface ow',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an alarm was triggered by this measurement (True if alarm triggered, False otherwise).',
    `ambient_temperature` DECIMAL(18,2) COMMENT 'Ambient temperature at the time of measurement, typically in degrees Celsius or Fahrenheit.',
    `analytical_method` STRING COMMENT 'Analytical method or standard used for measurement or analysis (e.g., EPA Method 8260, NIOSH Method 6000, ASTM D5907).',
    `barometric_pressure` DECIMAL(18,2) COMMENT 'Barometric pressure at the time of measurement, typically in millibars or inches of mercury.',
    `calibration_date` DATE COMMENT 'Date when the detector or instrument was last calibrated prior to this measurement.',
    `comments` STRING COMMENT 'Additional comments, observations, or notes related to the monitoring event, sample collection, or measurement conditions.',
    `compliance_program` STRING COMMENT 'Name of the compliance program or regulatory framework this monitoring supports (e.g., LDAR, Title V Air Permit, SPCC, ISO 14001 EMS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental monitoring record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `detector_instrument_type` STRING COMMENT 'Type or model of detector, sensor, or analytical instrument used for the measurement (e.g., fixed H2S detector, portable gas monitor, water quality probe, noise dosimeter).',
    `evacuation_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an evacuation event was triggered as a result of this measurement or alarm (True if evacuation occurred, False otherwise).',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the measured value exceeded the applicable regulatory limit or alarm threshold (True if exceeded, False otherwise).',
    `laboratory_analysis_reference` STRING COMMENT 'Reference number or identifier for laboratory analysis if the sample was sent to a laboratory for detailed analysis.',
    `laboratory_certification_number` STRING COMMENT 'Certification or accreditation number of the laboratory that performed the analysis.',
    `laboratory_name` STRING COMMENT 'Name of the laboratory that performed the analysis if sample was sent for external analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental monitoring record was last modified in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value of the measurement result.',
    `monitoring_frequency_required` STRING COMMENT 'Required monitoring frequency per regulatory permit or internal HSE program (e.g., continuous, hourly, daily, weekly, monthly, quarterly, annual).',
    `monitoring_type` STRING COMMENT 'Type of environmental or occupational monitoring conducted (ambient air quality, groundwater, surface water, soil, noise, H2S fixed detector, H2S portable detector, toxic gas, personal exposure, area monitoring). [ENUM-REF-CANDIDATE: ambient_air_quality|groundwater|surface_water|soil|noise|h2s_fixed|h2s_portable|toxic_gas|personal_exposure|area_monitoring — 10 candidates stripped; promote to reference product]',
    `muster_station_activation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether muster stations were activated as a result of this measurement or alarm (True if activated, False otherwise).',
    `parameter_measured` STRING COMMENT 'Specific environmental or occupational parameter measured (e.g., VOCs, benzene, H2S ppm, TSS, pH, TDS, noise dBA, particulate matter PM2.5, CO, LEL).',
    `permit_reference_number` STRING COMMENT 'Reference number of the environmental permit or authorization under which this monitoring is conducted (e.g., EPA air permit, NPDES water discharge permit).',
    `pressure_unit` STRING COMMENT 'Unit of measure for barometric pressure (millibars, inches of mercury, kilopascals, pounds per square inch).. Valid values are `mbar|inHg|kPa|psi`',
    `quality_control_status` STRING COMMENT 'Quality control status of the measurement or analysis (passed, failed, pending, not applicable).. Valid values are `passed|failed|pending|not_applicable`',
    `regulatory_limit` DECIMAL(18,2) COMMENT 'Applicable regulatory limit, threshold, or alarm level for the measured parameter (e.g., OSHA PEL, IDLH, STEL, EPA permit limit).',
    `regulatory_limit_type` STRING COMMENT 'Type of regulatory limit or threshold (PEL - Permissible Exposure Limit, STEL - Short-Term Exposure Limit, IDLH - Immediately Dangerous to Life or Health, Ceiling, TWA - Time-Weighted Average, Permit Limit, Action Level, Alarm Threshold). [ENUM-REF-CANDIDATE: pel|stel|idlh|ceiling|twa|permit_limit|action_level|alarm_threshold — 8 candidates stripped; promote to reference product]',
    `relative_humidity` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of measurement.',
    `review_date` DATE COMMENT 'Date when the monitoring result was reviewed and validated by HSE personnel.',
    `reviewed_by_name` STRING COMMENT 'Name of the HSE professional or supervisor who reviewed and validated the monitoring result.',
    `sample_collection_method` STRING COMMENT 'Method or protocol used for sample collection (e.g., grab sample, composite sample, continuous monitoring, personal air sampling).',
    `sample_date` DATE COMMENT 'Date when the environmental or occupational sample was collected or measurement was taken.',
    `sample_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sample was collected or measurement was recorded, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `sampled_by_name` STRING COMMENT 'Name of the employee or contractor who collected the sample or performed the measurement.',
    `temperature_unit` STRING COMMENT 'Unit of measure for temperature (Celsius, Fahrenheit, Kelvin).. Valid values are `celsius|fahrenheit|kelvin`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the measured value (e.g., ppm, mg/L, dBA, µg/m³, percent LEL, pH units).',
    `wind_direction` STRING COMMENT 'Wind direction at the time of measurement, typically in compass degrees (0-360) or cardinal direction (N, NE, E, SE, S, SW, W, NW).',
    `wind_speed` DECIMAL(18,2) COMMENT 'Wind speed at the time of measurement, typically in meters per second or miles per hour.',
    `wind_speed_unit` STRING COMMENT 'Unit of measure for wind speed (meters per second, miles per hour, kilometers per hour, knots).. Valid values are `m/s|mph|km/h|knots`',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Environmental and occupational exposure monitoring record capturing ambient air quality, water quality, soil, noise, and hazardous gas measurements at or near oil and gas facilities. Covers both environmental compliance monitoring and occupational hygiene monitoring including H2S fixed/portable detector readings, personal exposure monitoring, and area monitoring. Captures monitoring type (air quality, groundwater, surface water, soil, noise, H2S, toxic gas), monitoring station or sample point, detector/instrument type, sample date and time, parameter measured (VOCs, benzene, H2S ppm, TSS, pH, TDS), measured value and units, applicable regulatory limit or alarm threshold (OSHA PEL, IDLH, STEL), exceedance/alarm flag, wind direction and speed, muster station activation flag, evacuation event flag, and laboratory analysis reference. Supports EPA permit compliance, OSHA 29 CFR 1910.1000 exposure limits, and ISO 14001 environmental monitoring programs.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility or operational site to which this regulatory submission pertains.',
    `charter_party_id` BIGINT COMMENT 'Foreign key linking to logistics.charter_party. Business justification: Regulatory submissions (MARPOL) reference charter party for compliance documentation. Links submission to charter for audit trail and port clearance.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: HSE regulatory submissions (incident reports, emissions data, spill notifications) are formalized as compliance regulatory filings. Links operational submission tracking to formal compliance filing re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory submission preparation costs (consultant fees, internal labor, filing fees) require cost center allocation for compliance program budget management. Standard practice for tracking regulator',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Regulatory submissions (custody transfer reports) reference transfer for compliance documentation. Links submission to transfer for audit trail and verification.',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_order. Business justification: Regulatory submissions (DOT, customs) reference order for compliance documentation. Links submission to order for audit trail and verification.',
    `incident_id` BIGINT COMMENT 'Identifier of the HSE incident that triggered this regulatory submission, if applicable (e.g., BSEE incident report).',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Regulatory submissions for joint operations require JOA context; operator reporting obligations, partner notification requirements, and submission cost allocation are governed by JOA regulatory compli',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Many HSE regulatory submissions are lease-specific (air permits, spill reports, NORM notifications); lease identification required for regulatory filings, lessor notifications, and lease compliance do',
    `original_submission_regulatory_submission_id` BIGINT COMMENT 'Identifier of the original submission record if this is a resubmission or correction.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Regulatory reports (Tier II, TRI, RMP, GHGRP) are submitted by facility. Each petrochemical plant has unique EPA/state IDs, and submissions are tracked at the plant level.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Many HSE regulatory submissions are product-specific: EPA fuel quality reports, state product registration, TSCA chemical notifications, DOT hazmat registrations, and SARA Title III hazardous substanc',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Regulatory submissions (PHMSA, FERC) reference nomination for compliance documentation. Links submission to nomination for audit trail and verification.',
    `pipeline_throughput_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_throughput. Business justification: Regulatory submissions (PHMSA, FERC) reference throughput for compliance documentation. Links submission to throughput for audit trail and verification.',
    `port_call_id` BIGINT COMMENT 'Foreign key linking to logistics.port_call. Business justification: Regulatory submissions (port state control) reference port call for compliance documentation. Links submission to port call for audit trail and clearance.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who prepared the regulatory submission.',
    `tertiary_regulatory_submitted_by_employee_id` BIGINT COMMENT 'Identifier of the employee who physically submitted the report to the regulatory agency.',
    `truck_ticket_id` BIGINT COMMENT 'Foreign key linking to logistics.truck_ticket. Business justification: Regulatory submissions (DOT hazmat) reference ticket for compliance documentation. Links submission to ticket for audit trail and verification.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Regulatory submissions identify responsible party (operator or non-operator); partner identification is required for regulatory authority contact, liability determination, and compliance verification ',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Regulatory submissions (SIRE, port state control) reference vessel for compliance. Links submission to vessel for vetting status and charter approval.',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory agency acknowledged receipt of the submission.',
    `acknowledgment_reference_number` STRING COMMENT 'Reference number or tracking identifier provided by the regulatory agency upon acknowledgment of the submission.',
    `acknowledgment_status` STRING COMMENT 'Status of acknowledgment or receipt confirmation from the regulatory agency.. Valid values are `pending|acknowledged|not_acknowledged|rejected|accepted_with_conditions`',
    `agency_jurisdiction` STRING COMMENT 'Geographic or operational jurisdiction of the regulatory agency (e.g., federal, state, regional office identifier).',
    `attachments_count` STRING COMMENT 'Number of supporting documents or attachments included with the regulatory submission.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for the submission (e.g., Upstream, Downstream, Refining, Petrochemicals).',
    `compliance_year` STRING COMMENT 'Calendar year for which compliance is being reported in this submission.',
    `contact_person_email` STRING COMMENT 'Email address of the primary contact person for agency follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the primary contact person for follow-up questions from the regulatory agency regarding this submission.',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary contact person for agency follow-up.',
    `correction_reason` STRING COMMENT 'Explanation of why a resubmission or correction was necessary.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the jurisdiction in which the submission is filed.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory submission record was first created in the system.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the submission must be filed to remain in compliance.',
    `facility_epa_code` STRING COMMENT 'EPA-assigned facility identifier used for environmental reporting (e.g., Tier II, GHG reporting).',
    `geographic_region` STRING COMMENT 'Geographic region or operational area associated with the submission (e.g., Gulf of Mexico, Permian Basin, North Sea).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory submission record was last updated in the system.',
    `late_submission_flag` BOOLEAN COMMENT 'Indicates whether the submission was filed after the regulatory due date. True if late, False if on time.',
    `prepared_by_name` STRING COMMENT 'Name of the employee or contractor who prepared the regulatory submission.',
    `regulatory_agency` STRING COMMENT 'Name of the government regulatory agency or authority to which the submission is made (e.g., OSHA, EPA, BSEE, state environmental agency, NRC).',
    `regulatory_requirement_reference` STRING COMMENT 'Citation or reference to the specific regulatory requirement or statute that mandates this submission (e.g., 29 CFR 1904.32, 40 CFR 98.3).',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this regulatory submission.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this regulatory submission.',
    `resubmission_flag` BOOLEAN COMMENT 'Indicates whether this submission is a resubmission or correction of a previously filed report. True if resubmission, False if original.',
    `review_date` DATE COMMENT 'Date on which the submission was reviewed and approved internally before filing.',
    `reviewed_by_name` STRING COMMENT 'Name of the employee who reviewed and approved the submission for filing.',
    `state_province_code` STRING COMMENT 'State or province code for the jurisdiction in which the submission is filed (e.g., TX, LA, CA).',
    `submission_date` DATE COMMENT 'Date on which the regulatory submission was officially submitted to the regulatory agency. Principal business event timestamp for this transaction.',
    `submission_description` STRING COMMENT 'Detailed description of the regulatory submission content, scope, and purpose.',
    `submission_method` STRING COMMENT 'Method or channel used to submit the regulatory report to the agency (e.g., electronic portal, paper mail, email).. Valid values are `electronic|paper|web_portal|email|fax|certified_mail`',
    `submission_number` STRING COMMENT 'Business identifier or reference number assigned to the regulatory submission, often provided by the submitting organization or regulatory agency upon receipt.',
    `submission_portal_name` STRING COMMENT 'Name of the electronic submission portal or system used for filing (e.g., EPA CDX, OSHA ITA, BSEE BSEE Online).',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission. Tracks the submission from draft through final acknowledgment or closure. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|accepted|rejected|under_review|resubmission_required|closed — 8 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'Type of regulatory submission being filed. Identifies the specific regulatory report or notification category.. Valid values are `OSHA 300A Annual Summary|EPA Tier II Chemical Inventory|EPA GHG Annual Report|BSEE Incident Report|NRC NORM Report|State Spill Notification`',
    `submitted_by_name` STRING COMMENT 'Name of the employee who physically submitted the report to the regulatory agency.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Regulatory submission and reporting record tracking mandatory HSE reports submitted to government agencies. Captures submission type (OSHA 300A annual summary, EPA Tier II chemical inventory, EPA GHG annual report, BSEE incident report, NRC NORM report, state spill notification), regulatory agency, submission date, reporting period, submission method (electronic, paper), submission reference number, and acknowledgment status. Supports multi-agency compliance tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`hse_training_record` (
    `hse_training_record_id` BIGINT COMMENT 'Primary key for training_record',
    `asset_facility_id` BIGINT COMMENT 'Unique identifier of the facility or site where the training was conducted or where the trainee is assigned.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Training records for carrier personnel reference carrier for certification tracking and DOT compliance.',
    `contractor_id` BIGINT COMMENT 'Unique identifier of the contractor company if the trainee is a contractor employee. Null for direct employees.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training costs (training_cost field present) require cost center allocation for workforce development budget tracking. Essential for managing HSE training program expenses against facility/business un',
    `hse_corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.hse_corrective_action. Business justification: Training is often mandated as a corrective action from incidents, audit findings, or safety observations. Business reality: CAPAs frequently require competency training as a remediation measure. This ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOA HSE standards mandate training requirements for joint operations personnel; training costs are allocated to partners through JOA overhead provisions and billed via JIB statements.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Lease-specific training requirements (e.g., H2S training for sour gas leases, NORM training for NORM-affected leases); lease terms may mandate specific training for personnel working on the lease. Cri',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: HSE training is often facility-specific (site orientation, local procedures, plant-specific hazards). Training records track which petrochemical plant employees were trained at for access authorizatio',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Turnarounds require specialized training (confined space, hot work, scaffolding, SIMOPS). Training records track turnaround-specific competency verification for contractors and employees before turnar',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Product-specific training is required for safe handling of specialized petroleum products (H2S sour crudes, NORM-containing streams, cryogenic LNG). Training records must track product competencies fo',
    `previous_training_hse_training_record_id` BIGINT COMMENT 'Reference to the previous training record if this is a refresher or recertification. Null for initial training.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or worker who completed the training. Links to workforce domain employee master data.',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Training records for terminal operations reference terminal for competency tracking and regulatory compliance (OSHA PSM).',
    `tertiary_hse_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user or system that last modified this training record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Vendor/contractor personnel training records are tracked for site access authorization, competency verification, and regulatory compliance (OSHA, API, client-specific requirements). Vendor reference e',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Training records for vessel crew reference vessel for certification tracking and STCW compliance.',
    `actual_start_date` DATE COMMENT 'Actual date when the trainee began the training course.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score or percentage achieved by the trainee in the competency assessment or examination.',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of training sessions attended by the trainee. Used to determine eligibility for certification.',
    `certification_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion of the training course.',
    `comments` STRING COMMENT 'Additional notes or comments about the training event, trainee performance, or special circumstances.',
    `competency_assessment_result` STRING COMMENT 'Outcome of the competency assessment or examination conducted at the end of the training course.. Valid values are `pass|fail|conditional_pass|not_assessed`',
    `completion_date` DATE COMMENT 'Date when the trainee successfully completed the training course.',
    `course_type` STRING COMMENT 'Category or type of HSE training course. [ENUM-REF-CANDIDATE: h2s_awareness|confined_space_entry|fire_fighting|hazwoper|norm_handling|bop_safety|offshore_survival|first_aid|rigging_lifting|fall_protection|lockout_tagout|hazard_communication|emergency_response|process_safety_management — promote to reference product]. Valid values are `h2s_awareness|confined_space_entry|fire_fighting|hazwoper|norm_handling|bop_safety`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered to the trainee.. Valid values are `classroom|e_learning|on_the_job|blended|simulation|field_exercise`',
    `expiration_date` DATE COMMENT 'Date when the training certification expires and requires renewal or refresher training.',
    `instructor_certification` STRING COMMENT 'Professional certification or qualification held by the instructor that authorizes them to deliver this training (e.g., OPITO Approved Instructor, IADC WellSharp Instructor).',
    `instructor_name` STRING COMMENT 'Name of the instructor or trainer who delivered the training course.',
    `job_role` STRING COMMENT 'Job role or position of the trainee at the time of training (e.g., Driller, Roustabout, Production Operator, HSE Coordinator).',
    `language_of_instruction` STRING COMMENT 'Primary language in which the training was delivered (e.g., English, Spanish, Portuguese).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was last updated in the system.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this training is mandatory for the employees role or work assignment (True) or voluntary (False).',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to pass the competency assessment for this training course.',
    `refresher_frequency_months` STRING COMMENT 'Number of months between required refresher training sessions to maintain certification. Null if no refresher is required.',
    `refresher_required_flag` BOOLEAN COMMENT 'Indicates whether periodic refresher training is required to maintain certification (True) or if the training is one-time only (False).',
    `regulatory_authority` STRING COMMENT 'Governing body or regulatory authority that mandates or oversees this training requirement. [ENUM-REF-CANDIDATE: osha|bsee|epa|api|opito|iadc|uscg|other — 8 candidates stripped; promote to reference product]',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory standard or requirement that mandates this training (e.g., OSHA 29 CFR 1910.146, BSEE 30 CFR 250, API RP 75).',
    `scheduled_end_date` DATE COMMENT 'Planned end date of the training course.',
    `scheduled_start_date` DATE COMMENT 'Planned start date of the training course.',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this training event including course fees, materials, travel, and instructor costs. Reported in USD.',
    `training_course_code` STRING COMMENT 'Standardized code or identifier for the training course as defined in the HSE training catalog.',
    `training_course_name` STRING COMMENT 'Full name of the HSE training course (e.g., H2S Awareness, Confined Space Entry, Fire Fighting, HAZWOPER, NORM Handling, Blowout Preventer (BOP) Safety, Offshore Survival).',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course in hours.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted (e.g., facility name, training center, online platform).',
    `training_materials_provided` STRING COMMENT 'Description of training materials provided to the trainee (e.g., manuals, handbooks, digital resources, PPE).',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that delivered the training (internal HSE department, external training provider, or contractor).',
    `training_provider_accreditation` STRING COMMENT 'Accreditation or certification held by the training provider (e.g., IADC, OPITO, IACET) that validates the quality and compliance of the training program.',
    `training_status` STRING COMMENT 'Current status of the training record in its lifecycle.. Valid values are `scheduled|in_progress|completed|failed|cancelled|expired`',
    `work_authorization_level` STRING COMMENT 'Level of work authorization or permit authority granted upon successful completion of this training (e.g., Confined Space Entrant, Hot Work Authorized, BOP Operator).',
    CONSTRAINT pk_hse_training_record PRIMARY KEY(`hse_training_record_id`)
) COMMENT 'HSE training course and certification record tracking mandatory and voluntary safety training for workers at oil and gas operations. Captures training course name, course type (H2S awareness, confined space entry, fire fighting, HAZWOPER, NORM handling, BOP safety, offshore survival), delivery method (classroom, e-learning, on-the-job), training provider, completion date, expiration date, competency assessment result, and regulatory requirement linkage (OSHA, BSEE). Distinct from workforce domain employee records — this tracks the HSE-specific training events.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` (
    `hazardous_substance_id` BIGINT COMMENT 'Unique identifier for the hazardous substance master record. Primary key for the hazardous substance entity.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where this hazardous substance is stored, used, or handled. Links to facility master data for location-specific inventory and compliance reporting.',
    `feedstock_id` BIGINT COMMENT 'Foreign key linking to petrochemical.feedstock. Business justification: Petrochemical feedstocks (naphtha, ethane, propane) are hazardous substances. SDS management, GHS classification, and SARA Title III Tier II reporting require linking feedstock materials to hazardous ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Hazardous substances in HSE tracking must link to procurement material master for SDS management consistency, inventory reconciliation, regulatory threshold calculations (SARA Title III, CERCLA), and ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Petroleum products classified as hazardous substances require integrated management linking product specifications to SDS, SARA Title III reporting, OSHA hazard communication, and emergency response p',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to petrochemical.product_catalog. Business justification: Petrochemical products (ethylene, benzene, toluene, xylene) are hazardous substances. GHS classification, SDS management, and regulatory reporting (TRI, Tier II) require linking products to hazardous ',
    `activity_level_bq_per_kg` DECIMAL(18,2) COMMENT 'Radioactivity concentration of NORM material measured in becquerels per kilogram (Bq/kg). International System of Units (SI) measurement for NORM classification.',
    `activity_level_pci_per_g` DECIMAL(18,2) COMMENT 'Radioactivity concentration of NORM material measured in picocuries per gram (pCi/g). Used to determine regulatory classification and disposal requirements.',
    `average_daily_quantity_lbs` DECIMAL(18,2) COMMENT 'Average amount of the substance present at the facility per day during the reporting year, measured in pounds. Required for EPA SARA Title III Tier II reporting.',
    `carcinogen_classification` STRING COMMENT 'Cancer hazard classification from authoritative sources (e.g., IARC Group 1 Known Human Carcinogen, NTP Known to be Human Carcinogen, OSHA Select Carcinogen). Critical for worker protection and medical surveillance programs.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to chemical substances for regulatory tracking and SDS cross-reference.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `chemical_family` STRING COMMENT 'Broad classification of the chemical substance by molecular structure or functional group (e.g., hydrocarbons, alcohols, acids, amines, sulfides).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hazardous substance record was first created in the system. Used for audit trail and data lineage.',
    `disposal_method` STRING COMMENT 'Approved disposal or treatment method for the substance or its waste (e.g., incineration, landfill, recycling, neutralization, licensed NORM disposal facility). Must comply with federal and state waste regulations.',
    `emergency_response_procedure` STRING COMMENT 'Summary of emergency response actions for spills, leaks, or exposures involving this substance. References facility emergency response plans and SDS Section 6 (Accidental Release Measures).',
    `epa_cercla_reportable_quantity_lbs` DECIMAL(18,2) COMMENT 'Threshold quantity in pounds above which a release of this substance must be reported to the National Response Center under CERCLA Section 103. Null if substance is not a CERCLA hazardous substance.',
    `exposure_limit_mg_per_m3` DECIMAL(18,2) COMMENT 'OSHA Permissible Exposure Limit (PEL) or ACGIH Threshold Limit Value (TLV) for airborne concentration, measured in milligrams per cubic meter. Used for industrial hygiene monitoring and worker protection.',
    `exposure_limit_ppm` DECIMAL(18,2) COMMENT 'OSHA Permissible Exposure Limit (PEL) or ACGIH Threshold Limit Value (TLV) for airborne concentration, measured in parts per million. Used for industrial hygiene monitoring and worker protection.',
    `flash_point_f` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors of the substance will ignite in the presence of an ignition source, measured in degrees Fahrenheit. Critical for flammability classification and storage requirements.',
    `ghs_pictogram_codes` STRING COMMENT 'Comma-separated list of GHS pictogram codes (e.g., GHS02 Flame, GHS06 Skull and Crossbones, GHS08 Health Hazard) required on labels and SDS.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Concentration of hydrogen sulfide gas in the substance measured in parts per million. Critical for sour gas/crude handling, worker safety, and OSHA exposure monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hazardous substance record was last updated. Used for audit trail and change tracking.',
    `maximum_daily_quantity_lbs` DECIMAL(18,2) COMMENT 'Maximum amount of the substance present at the facility on any single day during the reporting year, measured in pounds. Required for EPA SARA Title III Tier II reporting.',
    `nfpa_704_flammability_rating` STRING COMMENT 'NFPA 704 flammability hazard rating on a scale of 0 (will not burn) to 4 (extremely flammable). Used for emergency response and facility hazard communication signage.',
    `nfpa_704_health_rating` STRING COMMENT 'NFPA 704 health hazard rating on a scale of 0 (minimal hazard) to 4 (severe hazard). Used for emergency response and facility hazard communication signage.',
    `nfpa_704_instability_rating` STRING COMMENT 'NFPA 704 instability (reactivity) hazard rating on a scale of 0 (stable) to 4 (may detonate). Used for emergency response and facility hazard communication signage.',
    `nfpa_704_special_hazard` STRING COMMENT 'NFPA 704 special hazard symbols: W (reacts with water), OX (oxidizer), SA (simple asphyxiant), COR (corrosive). Used for emergency response and facility hazard communication signage.',
    `norm_classification` STRING COMMENT 'Regulatory classification of the material based on radionuclide activity levels: non-NORM (no detectable radioactivity), NORM-exempt (below regulatory thresholds), NORM-regulated (above thresholds, requires controls), NORM-licensed (requires state radiation control program license).. Valid values are `non_norm|norm_exempt|norm_regulated|norm_licensed`',
    `osha_hazard_classification` STRING COMMENT 'OSHA Globally Harmonized System (GHS) hazard classification codes for the substance (e.g., Flammable Liquid Category 2, Acute Toxicity Category 3, Carcinogen Category 1A).',
    `phmsa_hazard_class` STRING COMMENT 'Department of Transportation (DOT) hazard class and division for transportation of the substance (e.g., Class 3 Flammable Liquid, Class 2.1 Flammable Gas, Class 6.1 Toxic Substance).',
    `physical_state` STRING COMMENT 'Physical form of the substance under normal storage and handling conditions at the facility.. Valid values are `solid|liquid|gas|vapor|aerosol|mixture`',
    `ppe_requirements` STRING COMMENT 'Required personal protective equipment for handling the substance (e.g., chemical-resistant gloves, safety goggles, respirator, flame-resistant clothing). Derived from SDS Section 8 (Exposure Controls/Personal Protection).',
    `radionuclide_type` STRING COMMENT 'Specific radioactive isotopes present in NORM materials (e.g., Ra-226, Ra-228, Pb-210, Po-210) commonly found in oil and gas scale, sludge, and produced water.',
    `reporting_year` STRING COMMENT 'Calendar year for which the inventory quantities and regulatory reporting data apply. Tier II reports are submitted annually by March 1 for the previous calendar year.',
    `sara_title_iii_section_313_flag` BOOLEAN COMMENT 'Indicates whether the substance is listed as a toxic chemical subject to annual Toxics Release Inventory (TRI) reporting under EPCRA Section 313.',
    `sara_title_iii_tier_ii_threshold_lbs` DECIMAL(18,2) COMMENT 'Threshold quantity in pounds above which the substance must be reported on annual Tier II inventory reports to State Emergency Response Commissions (SERCs) and Local Emergency Planning Committees (LEPCs) under EPCRA Section 312.',
    `sds_document_number` STRING COMMENT 'Unique identifier or document control number for the current Safety Data Sheet (formerly MSDS) for this substance, used for document management and regulatory compliance verification.',
    `sds_manufacturer_name` STRING COMMENT 'Name of the manufacturer, importer, or responsible party listed on the Safety Data Sheet for the substance.',
    `sds_revision_date` DATE COMMENT 'Date of the most recent revision of the Safety Data Sheet. OSHA requires SDS to be updated within three months of new hazard information becoming available.',
    `storage_location` STRING COMMENT 'Specific storage area, tank, warehouse, or containment unit within the facility where the substance is kept (e.g., Tank 101, Chemical Storage Building A, Drum Storage Yard).',
    `storage_type` STRING COMMENT 'Type of containment or storage system used for the substance at the facility, relevant for spill prevention and emergency response planning. [ENUM-REF-CANDIDATE: bulk_tank|drum|tote|cylinder|pipeline|underground_storage_tank|aboveground_storage_tank — 7 candidates stripped; promote to reference product]',
    `substance_status` STRING COMMENT 'Current operational status of the substance at the facility: active (in use), discontinued (no longer used but may have residual inventory), restricted (use limited by internal policy), banned (prohibited by regulation or company policy).. Valid values are `active|discontinued|restricted|banned`',
    `un_number` STRING COMMENT 'Four-digit identification number assigned by the United Nations Committee of Experts on the Transport of Dangerous Goods for hazardous materials transportation (e.g., UN1203 for gasoline, UN1075 for LPG).. Valid values are `^UN[0-9]{4}$`',
    `waste_code` STRING COMMENT 'EPA hazardous waste code(s) if the substance or its residues are regulated as hazardous waste under RCRA (e.g., D001 Ignitable, F037 Petroleum Refinery Primary Oil/Water/Solids Separation Sludge). Used for waste characterization and disposal.',
    CONSTRAINT pk_hazardous_substance PRIMARY KEY(`hazardous_substance_id`)
) COMMENT 'Master record for hazardous chemicals, NORM materials, and facility-level chemical inventories at oil and gas operations. Captures substance identity (name, CAS number, chemical family, physical state), hazard properties (flash point, H2S content, OSHA hazard classification), NORM-specific attributes (radionuclide type Ra-226/Ra-228/Pb-210, activity level pCi/g or Bq/kg, NORM classification), regulatory thresholds (EPA CERCLA reportable quantity, SARA Title III Tier II threshold), SDS reference, and facility-level inventory data (maximum/average daily quantity, storage type, storage location, reporting year). Supports OSHA HazCom, EPA SARA Title III Section 312 Tier II reporting to SERCs/LEPCs, PHMSA hazardous materials compliance, and state radiation control program NORM requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` (
    `chemical_inventory_id` BIGINT COMMENT 'Unique identifier for the chemical inventory record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where the chemical is stored. Links to facility master data.',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to hse.hazardous_substance. Business justification: Chemical inventory records are facility-specific instances of hazardous substances from the master substance catalog. Business reality: Tier II reporting and chemical inventory management reference ma',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Chemical inventory reconciliation requires linkage to material master for accurate stock tracking, automated reorder triggers, regulatory threshold monitoring (Tier II reporting), and consistency betw',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Chemical inventories are facility-specific. SARA Title III Tier II reporting requires plant-level chemical inventory submission to SERC, LEPC, and fire departments annually.',
    `employee_id` BIGINT COMMENT 'Identifier of the HSE personnel or system user who created this chemical inventory record in the Enablon HSE Management system.',
    `average_daily_quantity` DECIMAL(18,2) COMMENT 'Average amount of the hazardous chemical present at the facility during the reporting year. Calculated as the sum of daily quantities divided by the number of days the chemical was present.',
    `confidential_location_flag` BOOLEAN COMMENT 'Indicates whether the specific storage location is withheld from public disclosure under trade secret provisions. Must be justified to EPA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this chemical inventory record was first created in the system. Supports audit trail and compliance verification.',
    `ehs_flag` BOOLEAN COMMENT 'Indicates whether the chemical is classified as an Extremely Hazardous Substance under SARA Title III Section 302. EHS chemicals trigger additional emergency planning requirements.',
    `emergency_contact_name` STRING COMMENT 'Name of the facility contact person for emergency response related to this chemical. Required for Tier II reporting.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency phone number for the facility contact person. Must be accessible to first responders.. Valid values are `^+?[0-9]{10,15}$`',
    `fire_department_submitted_date` DATE COMMENT 'Date the Tier II report was submitted to the local fire department for emergency response planning. Annual deadline is March 1.',
    `hazard_category` STRING COMMENT 'Primary hazard category classification for Tier II reporting: fire hazard, sudden release of pressure, reactive, immediate (acute) health hazard, or delayed (chronic) health hazard.. Valid values are `fire|sudden_release_pressure|reactive|immediate_acute|delayed_chronic`',
    `health_hazard_flag` BOOLEAN COMMENT 'Indicates whether the chemical presents health hazards such as toxicity, carcinogenicity, corrosivity, or sensitization per OSHA Hazard Communication Standard.',
    `inventory_number` STRING COMMENT 'Business identifier for the chemical inventory record, typically assigned by the facility or HSE system. Used for external reporting and audit trails.. Valid values are `^[A-Z0-9]{6,20}$`',
    `inventory_status` STRING COMMENT 'Current status of the chemical inventory at the facility. Active indicates ongoing storage, depleted indicates consumed, transferred indicates moved to another facility, disposed indicates waste disposal.. Valid values are `active|depleted|transferred|disposed`',
    `last_inventory_date` DATE COMMENT 'Date of the most recent physical inventory count or verification of the chemical quantity at the facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this chemical inventory record was last modified. Tracks changes for regulatory audit purposes.',
    `lepc_submitted_date` DATE COMMENT 'Date the Tier II report was submitted to the Local Emergency Planning Committee. Annual deadline is March 1.',
    `manufacturer_name` STRING COMMENT 'Name of the chemical manufacturer or supplier as listed on the Safety Data Sheet.',
    `maximum_daily_quantity` DECIMAL(18,2) COMMENT 'Maximum amount of the hazardous chemical present at the facility on any single day during the reporting year. Reported in pounds or gallons depending on physical state.',
    `mixture_flag` BOOLEAN COMMENT 'Indicates whether the chemical is a pure substance or a mixture of multiple components. Mixtures require reporting of hazardous constituents.',
    `physical_hazard_flag` BOOLEAN COMMENT 'Indicates whether the chemical presents physical hazards such as flammability, explosivity, reactivity, or oxidizing properties per OSHA Hazard Communication Standard.',
    `physical_state` STRING COMMENT 'Physical state of the chemical under normal storage conditions at the facility.. Valid values are `solid|liquid|gas|liquefied_gas`',
    `product_identifier` STRING COMMENT 'Manufacturers product code or identifier for the specific chemical formulation. Used to match inventory to SDS.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the chemical quantities reported. Tier II reporting typically uses pounds for solids and gallons for liquids.. Valid values are `pounds|gallons|kilograms|liters|barrels`',
    `regulatory_notes` STRING COMMENT 'Additional notes or comments related to regulatory compliance, exemptions, or special reporting considerations for this chemical inventory.',
    `reporting_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether the chemical quantity exceeds the Tier II reporting threshold (10,000 pounds for most chemicals, 500 pounds or Threshold Planning Quantity for EHS chemicals).',
    `reporting_year` STRING COMMENT 'Calendar year for which this chemical inventory is reported to regulatory authorities. Tier II reporting is annual.',
    `sds_date` DATE COMMENT 'Date of the most recent Safety Data Sheet on file for this chemical. SDS must be current and accessible to workers.',
    `serc_submitted_date` DATE COMMENT 'Date the Tier II report was submitted to the State Emergency Response Commission. Annual deadline is March 1.',
    `storage_location` STRING COMMENT 'Specific location within the facility where the hazardous chemical is stored (e.g., tank farm, warehouse, process unit, storage yard).',
    `storage_type` STRING COMMENT 'Type of storage vessel or container used for the hazardous chemical. Critical for emergency response planning and spill containment.. Valid values are `above_ground_tank|underground_tank|container|drum|tote|cylinder`',
    CONSTRAINT pk_chemical_inventory PRIMARY KEY(`chemical_inventory_id`)
) COMMENT 'Facility-level chemical inventory record tracking quantities of hazardous chemicals stored and used at oil and gas facilities. Captures facility, storage location, hazardous substance, maximum daily quantity, average daily quantity, storage type (above-ground tank, underground tank, container), physical and health hazard flags, and reporting year. Supports EPA SARA Title III Section 312 Tier II annual chemical inventory reporting to state emergency response commissions (SERCs) and local emergency planning committees (LEPCs).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`safety_observation` (
    `safety_observation_id` BIGINT COMMENT 'Unique identifier for the safety observation record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility, plant, or offshore platform where the observation was made. Links to asset or facility master data.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Identifier linking this observation to a formal corrective action record in the HSE corrective action tracking system, if follow-up action was initiated.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Safety observations during contracted work must reference the contract for contractor accountability, follow-up action assignment, vendor performance trending, and potential contract performance score',
    `contractor_id` BIGINT COMMENT 'Identifier of the contractor company involved in the observation, if the observation relates to contractor work or personnel.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created the observation record. May differ from observer_id if entered by HSE coordinator on behalf of observer.',
    `equipment_id` BIGINT COMMENT 'Identifier of the specific equipment, asset, or system involved in the observation, if applicable. Links to asset management master data.',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: Safety observations and near-miss reports often trigger formal risk assessments. Business reality: Field-level observations feed into the risk management process; high-severity observations require do',
    `last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the observation record. Audit trail field.',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Turnarounds have elevated safety observation activity. Behavioral safety programs intensify observations during turnarounds to manage contractor safety and high-risk work activities.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Safety observations during pipeline patrol (exposed pipe, encroachment, ROW violation, marker damage) require segment-level tracking for integrity threat identification, corrective action prioritizati',
    `primary_safety_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who reported the safety observation. Links to workforce or personnel master data.',
    `tertiary_safety_verified_by_employee_id` BIGINT COMMENT 'Identifier of the individual who verified closure of the observation and effectiveness of corrective actions.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well site safety observations (wellhead condition, lease housekeeping, spill containment deficiency) require well-specific tracking for compliance verification, well integrity risk assessment, and cor',
    `actual_closure_date` DATE COMMENT 'Actual date when the observation was closed after verification that corrective actions were completed and effective.',
    `attachments_count` STRING COMMENT 'Count of supporting documents, photographs, or other evidence files attached to the observation record in the HSE management system.',
    `bbs_program_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this observation was captured as part of a formal behavior-based safety program. True if part of BBS program.',
    `business_unit` STRING COMMENT 'Business unit or operating division responsible for the facility or operation where the observation was made (e.g., upstream E&P, midstream, downstream refining).',
    `closure_verification_method` STRING COMMENT 'Method used to verify that corrective actions were implemented and effective before closing the observation (e.g., field inspection, photographic evidence, supervisor sign-off).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the safety observation record was first created in the HSE management system. Audit trail field.',
    `follow_up_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether additional follow-up corrective action is required beyond the immediate action taken. True if further action is needed.',
    `geographic_region` STRING COMMENT 'Geographic region or operational area where the observation occurred, used for regional HSE performance tracking and benchmarking.',
    `hazard_category` STRING COMMENT 'Primary hazard category associated with the observation, aligned with oil and gas industry hazard classifications including H2S exposure, pressure release, and other process safety hazards. [ENUM-REF-CANDIDATE: slip_trip_fall|struck_by|caught_between|electrical|chemical_exposure|fire_explosion|confined_space|working_at_height|lifting_rigging|pressure_release|h2s_exposure|other — 12 candidates stripped; promote to reference product]',
    `immediate_action_taken` STRING COMMENT 'Description of any immediate corrective or preventive action taken at the time of observation to mitigate the hazard or unsafe condition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the safety observation record was last updated. Audit trail field for tracking changes through the observation lifecycle.',
    `lessons_learned` STRING COMMENT 'Summary of lessons learned from the observation and corrective actions, used for knowledge sharing and continuous improvement across the organization.',
    `location_description` STRING COMMENT 'Detailed description of the specific location within the facility where the observation was made (e.g., wellhead platform deck, compressor station unit 3, refinery CDU area).',
    `observation_date` DATE COMMENT 'Calendar date when the safety observation was made in the field. This is the business event date, distinct from system record timestamps.',
    `observation_description` STRING COMMENT 'Detailed narrative description of the observed behavior, condition, or hazard. Captures what was seen, the context, and any relevant circumstances.',
    `observation_number` STRING COMMENT 'Business identifier for the safety observation, typically a human-readable sequential or formatted number used for tracking and reference in HSE management systems.',
    `observation_status` STRING COMMENT 'Current lifecycle status of the safety observation in the workflow: open (newly reported), under review (being assessed), action assigned (corrective action initiated), closed (resolved), or cancelled.. Valid values are `open|under_review|action_assigned|closed|cancelled`',
    `observation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the safety observation occurred, supporting shift-level and time-of-day analysis for behavior-based safety programs.',
    `observation_type` STRING COMMENT 'Classification of the safety observation: unsafe act (behavior-based), unsafe condition (physical hazard), near-miss (potential incident), positive observation (safe behavior recognition), stop work authority exercise, or general hazard identification.. Valid values are `unsafe_act|unsafe_condition|near_miss|positive_observation|stop_work_authority|hazard_identification`',
    `observer_name` STRING COMMENT 'Full name of the individual who made the safety observation. Classified as restricted PII for confidentiality in behavior-based safety programs.',
    `observer_role` STRING COMMENT 'Job role or position of the observer at the time of observation (e.g., field operator, supervisor, safety officer, contractor).',
    `permit_to_work_reference` STRING COMMENT 'Reference number of the associated permit to work if the observation was made during permitted work activities. Links to PTW system for cross-reference.',
    `regulatory_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether the observation involves a condition or near-miss that meets regulatory reporting thresholds to OSHA, BSEE, EPA, or other authorities. True if reportable.',
    `responsible_party_name` STRING COMMENT 'Name of the individual or supervisor assigned responsibility for addressing the observation.',
    `risk_likelihood_rating` STRING COMMENT 'Assessment of the likelihood or probability that the observed hazard could result in an incident. Rated using standard risk assessment terminology.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `risk_matrix_score` STRING COMMENT 'Numerical risk score calculated from the risk matrix combining severity and likelihood ratings. Used for prioritization of corrective actions.',
    `risk_severity_rating` STRING COMMENT 'Assessment of the potential severity of consequences if the observed hazard or unsafe condition were to result in an incident. Rated as low, medium, high, or critical based on risk matrix methodology.. Valid values are `low|medium|high|critical`',
    `stop_work_authority_exercised` BOOLEAN COMMENT 'Boolean flag indicating whether stop work authority was exercised by the observer to halt unsafe work. True if work was stopped.',
    `target_closure_date` DATE COMMENT 'Target date by which the observation and any required corrective actions should be resolved and closed, based on risk priority.',
    `work_activity` STRING COMMENT 'Description of the work activity or operation being performed at the time of the observation (e.g., drilling operations, hot work, confined space entry, lifting operations).',
    CONSTRAINT pk_safety_observation PRIMARY KEY(`safety_observation_id`)
) COMMENT 'Safety observation and near-miss record capturing field-level safety observations reported by workers and supervisors. Captures observation type (unsafe act, unsafe condition, near-miss, positive observation), observer identity, observation date, location, description of observed behavior or condition, immediate action taken, risk severity rating, and follow-up action required flag. Supports behavior-based safety (BBS) programs and leading indicator tracking per API RP 754.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`process_safety_event` (
    `process_safety_event_id` BIGINT COMMENT 'Unique identifier for the process safety event record.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility where the process safety event occurred.',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key linking to petrochemical.conversion_unit. Business justification: Process safety events (Tier 1/2 per API RP 754) occur at specific process units. PSE reporting, loss of primary containment tracking, and equipment reliability analysis require unit-level PSE tracking',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: PSEs (loss of primary containment) involve specific equipment failures (vessel rupture, piping leak, relief valve lift). Equipment FK required for barrier analysis, bow-tie diagram updates, equipment ',
    `incident_id` BIGINT COMMENT 'Reference to the parent HSE incident record from which this process safety event was classified.',
    `incident_investigation_id` BIGINT COMMENT 'Reference to the formal incident investigation record if one was initiated for this process safety event.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Process safety events involving loss of primary containment must identify the petroleum product released for consequence analysis, API RP 754 Tier reporting, regulatory notification (EPA RMP, OSHA PSM',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline PSEs (rupture, significant leak) require segment-level linkage for integrity investigation, risk model updates (probability of failure), consequence analysis updates, and segment-specific PSE',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Process Safety Events (Tier 1/Tier 2 per API RP 754) often involve Loss of Primary Containment (LOPC) resulting in spills. Business reality: PSEs and spills are related but distinct regulatory reporti',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well control events (kick, blowout, uncontrolled flow) require well-specific linkage for barrier failure analysis, well control risk assessment updates, regulatory reporting (BSEE for offshore), and w',
    `consequence_category` STRING COMMENT 'Primary consequence category resulting from the process safety event, used for severity classification and trending.. Valid values are `Injury|Fatality|Environmental|Property Damage|Production Loss|Near Miss`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this process safety event record was first created in the system.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the process safety event was first discovered or detected by personnel or monitoring systems.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the process safety event resulted in environmental impact requiring regulatory notification or remediation.',
    `equipment_involved` STRING COMMENT 'Specific equipment, vessel, piping, or component involved in the process safety event (e.g., reactor, heat exchanger, pump, valve).',
    `esg_reportable_flag` BOOLEAN COMMENT 'Indicates whether the process safety event should be included in ESG sustainability reporting and disclosures.',
    `event_date` DATE COMMENT 'Calendar date on which the process safety event occurred.',
    `event_status` STRING COMMENT 'Current lifecycle status of the process safety event record in the investigation and reporting workflow.. Valid values are `Draft|Under Review|Confirmed|Closed|Cancelled`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the process safety event occurred, used for timeline analysis and SCADA correlation.',
    `event_type` STRING COMMENT 'Type of process safety event as defined by API RP 754. LOPC = Loss of Primary Containment.. Valid values are `LOPC|Fire|Explosion|Toxic Release|Overpressure|Runaway Reaction`',
    `fatality_count` STRING COMMENT 'Number of fatalities resulting from the process safety event.',
    `ignition_source` STRING COMMENT 'Identified or suspected ignition source for fire or explosion events (e.g., hot work, static electricity, electrical equipment, vehicle).',
    `immediate_cause_description` STRING COMMENT 'Brief description of the immediate or proximate cause of the process safety event, as determined during initial assessment.',
    `injury_count` STRING COMMENT 'Number of personnel injuries resulting from the process safety event.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether the process safety event requires formal root cause investigation per company policy or regulatory requirement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this process safety event record was last updated, used for audit trail and data quality monitoring.',
    `lopc_flag` BOOLEAN COMMENT 'Indicates whether the event involved a loss of primary containment as defined by API RP 754.',
    `process_unit` STRING COMMENT 'Name or identifier of the process unit, plant section, or equipment train where the process safety event occurred (e.g., CDU, FCC, HDS, compressor station).',
    `production_loss_boe` DECIMAL(18,2) COMMENT 'Estimated production loss resulting from the process safety event, expressed in barrels of oil equivalent.',
    `property_damage_usd` DECIMAL(18,2) COMMENT 'Estimated or actual cost of property damage resulting from the process safety event, in US dollars.',
    `pse_number` STRING COMMENT 'Unique business identifier for the process safety event, used for external reporting and tracking.',
    `pse_tier_classification` STRING COMMENT 'API RP 754 tier classification of the process safety event. Tier 1 represents the most severe events with actual consequences; Tier 2 represents events with lesser consequences or near misses.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the process safety event meets regulatory thresholds requiring notification to OSHA, EPA, BSEE, or other authorities.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of the process safety event.',
    `release_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of the material release in minutes, from initiation to isolation or cessation.',
    `release_quantity` DECIMAL(18,2) COMMENT 'Measured or estimated quantity of material released during the process safety event.',
    `release_rate` DECIMAL(18,2) COMMENT 'Peak or average rate of material release during the event, used for consequence modeling.',
    `release_rate_unit` STRING COMMENT 'Unit of measure for the release rate (e.g., barrels per hour, pounds per minute, kilograms per second).. Valid values are `BBL/HR|LBS/MIN|KG/SEC|MSCF/HR`',
    `release_unit_of_measure` STRING COMMENT 'Unit of measure for the release quantity (BBL = Barrels, BOE = Barrel of Oil Equivalent, MSCF = Thousand Standard Cubic Feet, LBS = Pounds, KG = Kilograms). [ENUM-REF-CANDIDATE: BBL|BOE|MSCF|LBS|KG|GAL|LITERS — 7 candidates stripped; promote to reference product]',
    `safety_system_demand_flag` BOOLEAN COMMENT 'Indicates whether the process safety event created a demand on a safety instrumented system or other safety barrier.',
    `safety_system_involved` STRING COMMENT 'Name or identifier of the safety instrumented system (SIS), pressure relief system, or other safety barrier that was challenged or activated during the event.',
    `safety_system_response` STRING COMMENT 'Assessment of whether the safety system responded as designed when challenged during the process safety event.. Valid values are `Responded as Designed|Partial Response|Failed to Respond|Not Applicable`',
    `sec_reportable_flag` BOOLEAN COMMENT 'Indicates whether the process safety event meets materiality thresholds for SEC disclosure in financial filings.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of the process safety event, relevant for dispersion modeling and consequence analysis.',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed in miles per hour at the time of the event, used for vapor cloud dispersion modeling.',
    CONSTRAINT pk_process_safety_event PRIMARY KEY(`process_safety_event_id`)
) COMMENT 'Process Safety Event (PSE) record capturing Tier 1 and Tier 2 process safety incidents as defined by API RP 754. Captures PSE tier classification, event type (loss of primary containment, fire, explosion, toxic release), process unit involved, material released, release quantity, consequence category, process demand on safety system, and whether safety system responded as designed. Supports API RP 754 process safety performance indicator benchmarking and SEC/ESG reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` (
    `emergency_response_plan_id` BIGINT COMMENT 'Unique identifier for the emergency response plan record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility or operation covered by this emergency response plan.',
    `basin_id` BIGINT COMMENT 'Foreign key linking to exploration.basin. Business justification: Basin-level emergency response plans cover multiple exploration activities (drilling, seismic, site surveys) across the basin. Plans tailored to basin-specific risks (offshore/onshore, water depth, en',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOAs require emergency response plans for joint operations; plan approval, funding allocation, mutual aid obligations, and response cost sharing are contractual requirements under JOA HSE provisions.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Emergency plans must cover leased properties; lease terms may require specific response protocols, lessor coordination is often mandated, and lease-specific emergency contacts and procedures are maint',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Emergency response plans (SPCC, FRP, OPA-90) are required by and submitted under specific permits. Links plan to authorizing permit for compliance verification, renewal tracking, and regulatory audit ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Emergency response plans are facility-specific documents. OPA 90, RMP, and state regulations require plant-level emergency plans. Plan management and drill tracking are plant-specific.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or role responsible for maintaining and updating the emergency response plan.',
    `quaternary_emergency_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the emergency response plan record.',
    `quinary_emergency_plan_owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Surface use agreements often require emergency response plans; agreement terms specify response obligations, surface owner notification protocols, and emergency access rights. Critical for surface own',
    `tertiary_emergency_created_by_employee_id` BIGINT COMMENT 'Identifier of the user who created the emergency response plan record.',
    `approval_date` DATE COMMENT 'Date when the emergency response plan was formally approved by management or regulatory authority.',
    `approved_by_name` STRING COMMENT 'Name of the individual who approved the emergency response plan.',
    `business_unit` STRING COMMENT 'Business unit or operating division responsible for the facility or operation covered by this plan.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary jurisdiction where the plan applies. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|NOR|BRA|AUS — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emergency response plan record was first created in the system.',
    `discharge_volume_unit` STRING COMMENT 'Unit of measure for worst case discharge volume (barrels, gallons, cubic meters, liters).. Valid values are `BBL|GAL|M3|L`',
    `drill_compliance_status` STRING COMMENT 'Current compliance status with respect to required emergency response drill frequency.. Valid values are `compliant|overdue|upcoming|not applicable`',
    `drill_frequency_requirement` STRING COMMENT 'Required frequency for conducting emergency response drills and exercises as mandated by regulation or company policy.. Valid values are `monthly|quarterly|semi-annually|annually`',
    `effective_date` DATE COMMENT 'Date when the emergency response plan becomes effective and operational.',
    `emergency_contact_email` STRING COMMENT 'Email address for emergency contact and plan coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of the primary emergency contact person for this plan.',
    `emergency_contact_phone` STRING COMMENT '24/7 emergency contact phone number for plan activation and incident reporting.',
    `expiration_date` DATE COMMENT 'Date when the emergency response plan expires and requires renewal or revision.',
    `geographic_area` STRING COMMENT 'Geographic region or area covered by the emergency response plan (e.g., Gulf of Mexico, Permian Basin, North Sea).',
    `last_drill_date` DATE COMMENT 'Date of the most recent emergency response drill or exercise conducted under this plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the emergency response plan record was last modified in the system.',
    `mutual_aid_agreements` STRING COMMENT 'List or description of mutual aid agreements with other operators, contractors, or response organizations referenced in the plan.',
    `next_drill_due_date` DATE COMMENT 'Scheduled date for the next required emergency response drill or exercise.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the emergency response plan.',
    `oil_spill_response_organization` STRING COMMENT 'Name of the contracted oil spill response organization providing response capabilities under this plan.',
    `operation_type` STRING COMMENT 'Type of oil and gas operation covered by the emergency response plan.. Valid values are `offshore platform|onshore facility|drilling rig|refinery|pipeline|storage terminal`',
    `plan_document_url` STRING COMMENT 'URL or file path to the full emergency response plan document stored in the document management system.',
    `plan_number` STRING COMMENT 'Business identifier for the emergency response plan, used for external reference and regulatory submissions.',
    `plan_scope_description` STRING COMMENT 'Detailed description of the scope, coverage, and boundaries of the emergency response plan including scenarios addressed and geographic coverage.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the emergency response plan.. Valid values are `draft|under review|approved|active|expired|superseded`',
    `plan_title` STRING COMMENT 'Descriptive title of the emergency response plan document.',
    `plan_type` STRING COMMENT 'Classification of the emergency response plan based on the type of emergency scenario it addresses. [ENUM-REF-CANDIDATE: oil spill response plan|facility emergency response plan|well control emergency plan|offshore emergency evacuation plan|fire emergency response plan|H2S emergency response plan|blowout emergency plan|man overboard response plan|hurricane evacuation plan — promote to reference product]. Valid values are `oil spill response plan|facility emergency response plan|well control emergency plan|offshore emergency evacuation plan|fire emergency response plan|H2S emergency response plan`',
    `plan_version` STRING COMMENT 'Version number or identifier of the emergency response plan document.',
    `regulatory_approval_number` STRING COMMENT 'Reference number or approval identifier issued by the regulatory authority for the emergency response plan.',
    `regulatory_body` STRING COMMENT 'Primary regulatory authority to which the emergency response plan was submitted or that governs compliance.. Valid values are `BSEE|EPA|USCG|OSHA|state agency`',
    `regulatory_submission_date` DATE COMMENT 'Date when the emergency response plan was submitted to regulatory authorities such as BSEE or EPA.',
    `response_time_objective_hours` DECIMAL(18,2) COMMENT 'Target time in hours for initial emergency response mobilization as defined in the plan.',
    `revision_date` DATE COMMENT 'Date of the most recent revision to the emergency response plan.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking changes to the emergency response plan over time.',
    `revision_reason` STRING COMMENT 'Description of the reason for the most recent revision, such as regulatory change, incident lessons learned, or facility modification.',
    `worst_case_discharge_volume` DECIMAL(18,2) COMMENT 'Maximum potential volume of oil or hazardous material that could be discharged in a worst-case scenario, used for oil spill response planning.',
    CONSTRAINT pk_emergency_response_plan PRIMARY KEY(`emergency_response_plan_id`)
) COMMENT 'Emergency response plan (ERP) master record and drill execution history for oil and gas facilities and operations. Captures plan definition: plan type (oil spill response plan, facility emergency response plan, well control emergency plan, offshore emergency evacuation plan), facility or operation covered, plan version, approval date, regulatory submission date (BSEE, EPA SPCC), and plan owner. Also captures drill and exercise records: drill type (fire drill, H2S evacuation, oil spill response, well control, man overboard, muster drill), drill date, participants count, scenario description, drill duration, performance evaluation results, deficiencies identified, and regulatory requirement fulfilled (BSEE, USCG, OSHA). Supports BSEE 30 CFR Part 254, EPA SPCC, OPA 90 emergency planning requirements, and emergency preparedness compliance verification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`emergency_drill` (
    `emergency_drill_id` BIGINT COMMENT 'Unique identifier for the emergency drill record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where the emergency drill was conducted (platform, refinery, terminal, plant, or office).',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Emergency drills involving contractors (common in offshore, drilling, construction) require contract reference to verify contractor participation requirements, assess contractor response performance, ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Emergency drill costs (labor, equipment, external observers) must be allocated to cost centers for emergency preparedness budget management. Standard practice for tracking drill program expenses in oi',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Emergency drills test and validate specific emergency response plans. Each drill should reference the ERP being exercised. Business reality: Drills are conducted to verify ERP effectiveness and mainta',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Emergency drills are conducted at specific petrochemical facilities. Regulatory compliance (OPA 90, RMP) requires plant-level drill frequency, documentation, and performance evaluation.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for planning, coordinating, and overseeing the execution of the emergency drill.',
    `quaternary_emergency_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the emergency drill record.',
    `tertiary_emergency_created_by_employee_id` BIGINT COMMENT 'Identifier of the user who created the emergency drill record in the system.',
    `business_unit` STRING COMMENT 'Business unit or operating division responsible for the facility where the drill was conducted (e.g., Upstream, Downstream, Midstream, Refining, Petrochemicals).',
    `communication_effectiveness_rating` STRING COMMENT 'Evaluation of communication effectiveness during the drill, including clarity of alarms, radio communications, public address announcements, and coordination between response teams.. Valid values are `excellent|good|fair|poor`',
    `corrective_actions_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required based on deficiencies identified during the drill (true) or no corrective actions needed (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the emergency drill record was first created in the system.',
    `deficiencies_identified_count` STRING COMMENT 'Total number of deficiencies, gaps, or non-conformances identified during the drill evaluation, requiring corrective action.',
    `deficiencies_summary` STRING COMMENT 'Narrative summary of deficiencies identified during the drill, including procedural gaps, equipment failures, communication breakdowns, and training needs.',
    `drill_coordinator_name` STRING COMMENT 'Full name of the drill coordinator for reference and communication purposes.',
    `drill_date` DATE COMMENT 'Calendar date on which the emergency drill was conducted or is scheduled to be conducted.',
    `drill_duration_minutes` STRING COMMENT 'Total elapsed time in minutes from drill start to drill end, measuring the length of the emergency response exercise.',
    `drill_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the emergency drill concluded, including all-clear signal and personnel return to normal operations.',
    `drill_number` STRING COMMENT 'Unique business identifier assigned to the emergency drill for tracking and reference purposes.',
    `drill_report_reference` STRING COMMENT 'Document reference or URL to the detailed drill report containing full evaluation, observations, photographs, and corrective action plan.',
    `drill_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the emergency drill commenced, including alarm activation or scenario initiation.',
    `drill_status` STRING COMMENT 'Current lifecycle status of the emergency drill. Scheduled indicates planned future drill, in progress indicates drill is actively being conducted, completed indicates drill finished and evaluated, cancelled indicates drill was not conducted, deferred indicates drill postponed to future date.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `drill_type` STRING COMMENT 'Category of emergency drill conducted. Fire drill tests fire response procedures, H2S (Hydrogen Sulfide) evacuation tests toxic gas response, oil spill response tests environmental containment, well control tests blowout preventer and kick procedures, man overboard tests offshore rescue, and muster drill tests personnel accountability.. Valid values are `fire_drill|h2s_evacuation|oil_spill_response|well_control|man_overboard|muster_drill`',
    `equipment_deployed` STRING COMMENT 'List of emergency response equipment deployed and tested during the drill (e.g., fire suppression systems, lifeboats, BOP (Blowout Preventer), spill containment booms, H2S detectors, personal protective equipment).',
    `equipment_performance_notes` STRING COMMENT 'Observations regarding the performance and readiness of emergency equipment during the drill, including any malfunctions or maintenance needs identified.',
    `evaluation_date` DATE COMMENT 'Date on which the drill evaluation and performance assessment were completed and documented.',
    `evaluator_name` STRING COMMENT 'Full name of the drill evaluator for reference and accountability purposes.',
    `external_agencies_involved` STRING COMMENT 'List of external emergency response agencies that participated in or observed the drill (e.g., Coast Guard, local fire department, oil spill response organization, mutual aid partners).',
    `geographic_region` STRING COMMENT 'Geographic region or operational area where the drill was conducted (e.g., Gulf of Mexico, North Sea, Permian Basin, Asia Pacific).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the emergency drill record was last updated in the system.',
    `lessons_learned` STRING COMMENT 'Key insights and lessons learned from the drill that will inform future training, procedure updates, and emergency preparedness improvements.',
    `muster_completion_time_minutes` DECIMAL(18,2) COMMENT 'Time in minutes required to account for all personnel at designated muster stations following the emergency alarm.',
    `next_drill_due_date` DATE COMMENT 'Scheduled date for the next required emergency drill of this type, based on regulatory frequency requirements and facility emergency preparedness plan.',
    `observers_present` STRING COMMENT 'Names and roles of observers present during the drill, including regulatory inspectors, management, HSE (Health Safety and Environment) auditors, and external consultants.',
    `participants_count` STRING COMMENT 'Total number of personnel who participated in the emergency drill, including employees, contractors, and observers.',
    `performance_rating` STRING COMMENT 'Overall evaluation of the drill performance based on response time, procedure adherence, communication effectiveness, and safety protocol compliance.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `personnel_accounted_count` STRING COMMENT 'Number of personnel successfully accounted for at muster stations during the drill, used to verify accountability procedures.',
    `regulatory_compliance_met_flag` BOOLEAN COMMENT 'Indicates whether the drill met all applicable regulatory requirements for frequency, scope, performance, and documentation (true) or failed to meet requirements (false).',
    `regulatory_requirement_reference` STRING COMMENT 'Citation of the specific regulatory requirement that mandates this drill type and frequency (e.g., BSEE 30 CFR 250.1930, USCG 33 CFR 146.210, OSHA 29 CFR 1910.38).',
    `response_time_minutes` DECIMAL(18,2) COMMENT 'Measured time in minutes from alarm activation to completion of critical response actions (e.g., muster completion, equipment deployment, containment initiation).',
    `scenario_description` STRING COMMENT 'Detailed narrative of the emergency scenario simulated during the drill, including the nature of the incident, location, severity, and conditions tested.',
    `scheduled_flag` BOOLEAN COMMENT 'Indicates whether the drill was a scheduled exercise (true) or an unscheduled surprise drill (false). Scheduled drills allow advance preparation while unscheduled drills test real-time readiness.',
    `strengths_identified` STRING COMMENT 'Narrative summary of positive observations and strengths demonstrated during the drill, including effective practices and exemplary performance.',
    `target_response_time_minutes` DECIMAL(18,2) COMMENT 'Established benchmark or regulatory requirement for response time in minutes for this type of emergency, used to evaluate drill performance.',
    `weather_conditions` STRING COMMENT 'Description of weather and environmental conditions during the drill (e.g., wind speed, visibility, sea state, temperature) that may have affected drill execution and realism.',
    CONSTRAINT pk_emergency_drill PRIMARY KEY(`emergency_drill_id`)
) COMMENT 'Emergency response drill and exercise record capturing scheduled and unscheduled drills conducted at oil and gas facilities. Captures drill type (fire drill, H2S evacuation, oil spill response, well control, man overboard, muster drill), facility, drill date, participants count, scenario description, drill duration, performance evaluation results, deficiencies identified, and regulatory requirement fulfilled (BSEE, USCG, OSHA). Supports emergency preparedness compliance and continuous improvement.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`waste_manifest` (
    `waste_manifest_id` BIGINT COMMENT 'Unique identifier for the waste manifest record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility that generated the waste. Links to the facility master data for site identification and regulatory tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Waste disposal costs (cost_usd field present) require cost center allocation for environmental compliance budget tracking. Essential for managing hazardous waste disposal expenses against facility ope',
    `generator_facility_id` BIGINT COMMENT 'FK to asset.asset_facility',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to hse.hazardous_substance. Business justification: Waste manifests describe hazardous substances being disposed, requiring linkage to master substance data for proper characterization. Business reality: RCRA waste manifests require accurate chemical i',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Waste generated from lease operations; lease-level waste tracking for regulatory compliance, lessor notifications, lease obligation fulfillment, and lease-specific waste disposal requirements. Essenti',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Hazardous waste manifests identify the generator facility. RCRA regulations require plant-level EPA ID for waste shipments. Manifest tracking and compliance reporting are plant-specific.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Hazardous waste manifests must identify the petroleum product generating the waste for RCRA waste code determination, disposal method selection, DOT shipping classification, and regulatory compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created the waste manifest record. Supports audit trail and data governance.',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Spill cleanup activities generate hazardous waste requiring proper disposal documentation. Business reality: Environmental spills produce contaminated materials (soil, absorbents, PPE) that must be ma',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Waste disposal and transportation vendors must be tracked on manifests for EPA/state regulatory compliance (RCRA), liability tracking, cost allocation, vendor performance evaluation, and insurance ver',
    `business_unit` STRING COMMENT 'Business unit or operating division responsible for the waste generation. Used for cost allocation and performance tracking.',
    `container_count` STRING COMMENT 'Number of containers or packages in the waste shipment. Required for manifest documentation and transportation safety.',
    `container_type` STRING COMMENT 'Description of container or packaging type used for waste transport (e.g., 55-gallon drum, roll-off box, tanker truck, bulk bag, frac tank).',
    `cost_usd` DECIMAL(18,2) COMMENT 'Total cost in US dollars for waste transportation and disposal services. Used for environmental cost tracking and OPEX reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the waste manifest record was first created in the system. Supports audit trail and regulatory compliance.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies identified during waste receipt, including quantity variances, container damage, or waste characterization differences.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a significant discrepancy was identified between the manifest description and the waste received at the disposal facility. Triggers regulatory reporting requirements.',
    `disposal_date` DATE COMMENT 'Date the waste was actually treated or disposed of at the receiving facility. Required for final closure of waste tracking records.',
    `disposal_facility_epa_code` STRING COMMENT 'Twelve-character EPA identification number for the receiving disposal facility. Required for hazardous waste manifests.',
    `disposal_facility_permit_number` STRING COMMENT 'State or federal permit number authorizing the facility to receive and process the waste type. Validates facility authorization.',
    `disposal_facility_signature` STRING COMMENT 'Digital signature or identifier of the disposal facility representative acknowledging receipt of the waste shipment. Completes the chain of custody.',
    `disposal_facility_signature_date` DATE COMMENT 'Date the disposal facility signed the manifest acknowledging receipt. Triggers generator notification and record retention requirements.',
    `disposal_method` STRING COMMENT 'Treatment or disposal method to be used at the receiving facility (e.g., landfill, incineration, recycling, stabilization, bioremediation, deep well injection).',
    `dot_hazard_class` STRING COMMENT 'DOT hazard classification for transportation (e.g., Class 3 Flammable Liquid, Class 9 Miscellaneous). Required for hazardous materials shipment.',
    `dot_proper_shipping_name` STRING COMMENT 'Official DOT shipping name for the hazardous material as listed in the Hazardous Materials Table. Required on manifest and shipping papers.',
    `dot_un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transportation (e.g., UN1993 for flammable liquids). Required on shipping papers and placards.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of transportation emergency or spill. Required for hazardous waste shipments.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency response phone number for incidents during transportation. Must be monitored at all times during shipment.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this waste manifest should be included in ESG sustainability reporting metrics for waste generation and disposal performance.',
    `generator_certification_date` DATE COMMENT 'Date the generator representative signed and certified the manifest. Establishes legal responsibility for waste characterization.',
    `generator_certification_signature` STRING COMMENT 'Digital signature or identifier of the authorized generator representative certifying the manifest accuracy and waste characterization. Required for legal compliance.',
    `h2s_concentration_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide concentration in parts per million for waste containing sour gas or H2S. Critical for worker safety and transportation requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the waste manifest record was last updated. Supports audit trail and data lineage tracking.',
    `manifest_number` STRING COMMENT 'Unique manifest tracking number assigned by the generator or regulatory authority. Required for EPA RCRA hazardous waste shipments and state waste tracking systems.',
    `manifest_status` STRING COMMENT 'Current lifecycle status of the waste manifest. Tracks progression from generation through final disposal confirmation. [ENUM-REF-CANDIDATE: draft|submitted|in_transit|received|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `manifest_type` STRING COMMENT 'Classification of the manifest based on waste regulatory category. Determines applicable regulatory requirements and handling procedures.. Valid values are `hazardous|non_hazardous|universal_waste|norm|mixed`',
    `norm_activity_level` DECIMAL(18,2) COMMENT 'Measured radioactivity level in picocuries per gram (pCi/g) for NORM-containing waste. Determines classification and disposal pathway.',
    `norm_flag` BOOLEAN COMMENT 'Indicates whether the waste contains naturally occurring radioactive material. Triggers additional handling, transportation, and disposal requirements specific to NORM waste.',
    `rcra_waste_code` STRING COMMENT 'Four-character EPA hazardous waste code(s) identifying the waste characteristics or listing. Multiple codes may be comma-separated. Required for hazardous waste manifests.',
    `received_date` DATE COMMENT 'Date the waste shipment was received at the disposal facility. Completes the manifest tracking cycle and triggers generator notification requirements.',
    `rejection_flag` BOOLEAN COMMENT 'Indicates whether the waste shipment was rejected by the disposal facility due to non-compliance with waste acceptance criteria or permit conditions.',
    `rejection_reason` STRING COMMENT 'Explanation for waste shipment rejection, including specific non-compliance issues or permit violations. Required for regulatory reporting and corrective action.',
    `shipment_date` DATE COMMENT 'Date the waste shipment departed the generator facility. Starts the regulatory tracking timeline for waste transportation.',
    `special_handling_instructions` STRING COMMENT 'Additional handling, storage, or transportation requirements specific to this waste shipment. May include temperature controls, incompatibility warnings, or emergency response procedures.',
    `state_manifest_tracking_number` STRING COMMENT 'State-specific manifest tracking number for jurisdictions with additional state waste tracking requirements beyond federal RCRA.',
    `transporter_dot_registration` STRING COMMENT 'DOT registration or motor carrier number for the transporter. Required for interstate hazardous materials transportation.',
    `transporter_epa_code` STRING COMMENT 'Twelve-character EPA identification number for the waste transporter. Required for hazardous waste shipments.',
    `transporter_signature` STRING COMMENT 'Digital signature or identifier of the transporter representative acknowledging receipt of the waste shipment. Transfers custody responsibility.',
    `transporter_signature_date` DATE COMMENT 'Date the transporter signed the manifest acknowledging receipt of waste. Starts the transportation custody period.',
    `waste_characterization_method` STRING COMMENT 'Method used to determine waste properties and hazard classification. Required to demonstrate compliance with waste identification requirements.. Valid values are `laboratory_analysis|generator_knowledge|msds|process_knowledge|field_test`',
    `waste_profile_number` STRING COMMENT 'Pre-approved waste profile identifier assigned by the disposal facility. Links to detailed waste characterization and acceptance criteria.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of waste being shipped. Must be accompanied by unit of measure. Used for regulatory reporting and disposal capacity planning.',
    `waste_quantity_unit` STRING COMMENT 'Unit of measure for the waste quantity. Must be consistent with waste type and regulatory reporting requirements. [ENUM-REF-CANDIDATE: tons|pounds|kilograms|gallons|liters|barrels|cubic_yards|cubic_meters — 8 candidates stripped; promote to reference product]',
    `waste_type` STRING COMMENT 'Specific classification of waste material being transported. Examples include drilling mud, produced water, refinery sludge, contaminated soil, NORM scale, spent catalyst, or oily waste.',
    CONSTRAINT pk_waste_manifest PRIMARY KEY(`waste_manifest_id`)
) COMMENT 'Hazardous and non-hazardous waste manifest record tracking generation, transportation, and disposal of waste streams from oil and gas operations. Captures waste type (RCRA hazardous, NORM waste, produced water, drilling mud, refinery waste), waste generator facility, waste quantity and units, waste characterization method, transporter name and DOT registration, disposal facility name and permit number, manifest number, and disposal date. Supports EPA RCRA manifest requirements and state waste disposal regulations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`objective` (
    `objective_id` BIGINT COMMENT 'Primary key for objective',
    `asset_facility_id` BIGINT COMMENT 'Reference to the specific facility or site to which this objective applies. Null for corporate-level or business-unit-level objectives.',
    `employee_id` BIGINT COMMENT 'Reference to the senior manager or executive who formally approved this HSE objective for implementation.',
    `objective_created_by_employee_id` BIGINT COMMENT 'Reference to the user or employee who created this objective record in the system.',
    `objective_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `objective_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user or employee who last modified this objective record.',
    `objective_responsible_owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_objective_employee_id` BIGINT COMMENT 'Reference to the employee or manager who is accountable for achieving this HSE objective. Primary point of contact for objective execution and reporting.',
    `achievement_percentage` DECIMAL(18,2) COMMENT 'The percentage of progress toward the target value, calculated as the ratio of improvement achieved to improvement required. Used for performance tracking and reporting.',
    `action_plan_summary` STRING COMMENT 'High-level summary of the key actions, initiatives, or programs planned to achieve this objective. Provides an overview of the execution strategy.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'The actual amount spent in US dollars to date on activities and initiatives supporting this objective. Used for budget tracking and variance analysis.',
    `approval_date` DATE COMMENT 'The date when this HSE objective was formally approved by management and authorized for execution.',
    `approved_by_name` STRING COMMENT 'Full name of the senior manager or executive who approved this objective. Denormalized for reporting and audit trail purposes.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The starting or baseline measurement value for the target metric, representing the performance level at the beginning of the objective period. Used to calculate improvement progress.',
    `baseline_year` STRING COMMENT 'The calendar year in which the baseline value was established or measured, serving as the reference point for tracking progress.',
    `budget_allocated_usd` DECIMAL(18,2) COMMENT 'The financial budget allocated in US dollars to support the achievement of this objective, including resources for programs, technology, training, or capital improvements.',
    `business_unit` STRING COMMENT 'The business unit, division, or operating segment responsible for this objective. Used for organizational reporting and accountability.',
    `closure_date` DATE COMMENT 'The date when this objective was formally closed, either because the target was achieved, not achieved, or the objective was cancelled.',
    `closure_notes` STRING COMMENT 'Free-text notes documenting the final outcome, lessons learned, and any recommendations for future objectives. Captured at closure for knowledge management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this objective record was first created in the system. Audit trail field.',
    `current_value` DECIMAL(18,2) COMMENT 'The most recent measured value of the target metric, reflecting current performance level. Updated periodically based on measurement frequency.',
    `effective_end_date` DATE COMMENT 'The date when this objective period ends or is scheduled to be completed. May be extended if the objective is not achieved by the target year.',
    `effective_start_date` DATE COMMENT 'The date when this objective becomes active and tracking begins. Marks the beginning of the objective period.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this objective is included in external ESG reporting and disclosures to investors, regulators, or sustainability rating agencies.',
    `last_measurement_date` DATE COMMENT 'The date when the current value was last measured or updated. Indicates the recency of performance data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this objective record was last updated in the system. Audit trail field for change tracking.',
    `last_review_date` DATE COMMENT 'The date when this objective was last reviewed by management or the responsible owner. Used to track review frequency and ensure ongoing relevance.',
    `management_review_required` BOOLEAN COMMENT 'Indicates whether this objective requires periodic review by senior management or executive leadership as part of the management review process.',
    `measurement_frequency` STRING COMMENT 'The frequency at which the target metric is measured and reported: daily, weekly, monthly, quarterly, or annually. Determines the cadence of progress tracking.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `next_review_date` DATE COMMENT 'The scheduled date for the next management or owner review of this objective. Ensures timely monitoring and course correction.',
    `objective_category` STRING COMMENT 'Specific category or focus area of the objective within the HSE domain, such as injury reduction, spill prevention, GHG emission reduction, compliance rate improvement, audit finding closure, LDAR compliance, or incident rate reduction. [ENUM-REF-CANDIDATE: injury_reduction|spill_prevention|emission_reduction|compliance_rate|audit_closure|ldar_compliance|incident_rate — 7 candidates stripped; promote to reference product]',
    `objective_description` STRING COMMENT 'Detailed description of the HSE objective including the specific goal, scope, and expected outcomes. Captures the full intent and context of the objective.',
    `objective_number` STRING COMMENT 'Business-assigned unique identifier or code for the HSE objective, used for external reference and tracking in management systems.',
    `objective_status` STRING COMMENT 'Current lifecycle status of the objective: draft (under development), active (in progress), on_track (progressing as planned), at_risk (behind schedule or below target), achieved (target met), not_achieved (target missed), or cancelled (objective discontinued). [ENUM-REF-CANDIDATE: draft|active|on_track|at_risk|achieved|not_achieved|cancelled — 7 candidates stripped; promote to reference product]',
    `objective_type` STRING COMMENT 'Classification of the objective by primary HSE domain: safety (injury prevention, process safety), environmental (emissions, waste, spills), health (occupational health, exposure), compliance (regulatory adherence), or ESG (Environmental Social and Governance reporting).. Valid values are `safety|environmental|health|compliance|esg`',
    `organizational_level` STRING COMMENT 'The organizational level at which this objective is set and managed: corporate (enterprise-wide), business_unit (division or segment), facility (site-specific), or department (functional area).. Valid values are `corporate|business_unit|facility|department`',
    `regulatory_driver` STRING COMMENT 'The specific regulatory requirement, permit condition, consent decree, or compliance obligation that drives this objective. References applicable regulations such as EPA, OSHA, BSEE, or ISO standards.',
    `risk_assessment_level` STRING COMMENT 'The assessed risk level associated with not achieving this objective, considering potential impacts on safety, environment, compliance, or reputation: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `strategic_alignment` STRING COMMENT 'Description of how this HSE objective aligns with broader corporate strategy, business goals, or regulatory commitments. Provides context for the objectives importance.',
    `supporting_team_members` STRING COMMENT 'Comma-separated list of employee names or identifiers who are supporting the achievement of this objective. Captures the broader team involved in execution.',
    `target_metric` STRING COMMENT 'The specific performance metric or Key Performance Indicator (KPI) being measured for this objective, such as Total Recordable Incident Rate (TRIR), spill count, GHG reduction percentage, LDAR compliance rate, or audit closure rate.',
    `target_value` DECIMAL(18,2) COMMENT 'The desired or goal measurement value for the target metric that the organization aims to achieve by the target date. Represents the performance improvement commitment.',
    `target_year` STRING COMMENT 'The calendar year by which the target value is expected to be achieved. Defines the time horizon for the objective.',
    `title` STRING COMMENT 'Short descriptive title or name of the HSE objective for quick identification and reporting purposes.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for the baseline and target values, such as percentage, count, rate per 200,000 hours, tonnes CO2e, or other industry-standard units.',
    CONSTRAINT pk_objective PRIMARY KEY(`objective_id`)
) COMMENT 'HSE management system objective and target record capturing annual and multi-year HSE performance goals set at corporate, business unit, and facility levels. Captures objective description, target metric (TRIR, spill count, GHG reduction percentage, LDAR compliance rate, audit closure rate), baseline value, target value, target year, responsible owner, measurement frequency, and achievement status. Supports ISO 14001 and ISO 45001 objectives and targets management requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` (
    `hse_risk_assessment_id` BIGINT COMMENT 'Unique identifier for the HSE risk assessment record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility or operational site where the risk assessment is conducted.',
    `asset_id` BIGINT COMMENT 'Identifier of the specific asset or equipment being assessed for HSE risks.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the risk assessment record in the system.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the risk assessment record.',
    `primary_hse_employee_id` BIGINT COMMENT 'Identifier of the employee or consultant who led the risk assessment session.',
    `tertiary_hse_approved_by_employee_id` BIGINT COMMENT 'Identifier of the manager or HSE leader who approved the risk assessment.',
    `wildcat_well_plan_id` BIGINT COMMENT 'Foreign key linking to exploration.wildcat_well_plan. Business justification: Formal HSE risk assessment mandatory before wildcat well approval. Evaluates drilling hazards, environmental sensitivity, emergency response readiness, and regulatory compliance. Links assessment to w',
    `achievement_status` STRING COMMENT 'Current status of progress toward achieving the HSE objective and target.. Valid values are `on_track|at_risk|achieved|not_achieved|deferred`',
    `approval_date` DATE COMMENT 'Date when the risk assessment was formally approved.',
    `approval_status` STRING COMMENT 'Approval status of the risk assessment by management or HSE leadership.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by_name` STRING COMMENT 'Name of the approver who authorized the risk assessment.',
    `assessment_date` DATE COMMENT 'Date when the risk assessment was conducted or completed.',
    `assessment_number` STRING COMMENT 'Business identifier for the risk assessment, used for external reference and tracking across HSE management systems.',
    `assessment_report_url` STRING COMMENT 'URL or file path to the detailed risk assessment report document stored in the document management system.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment in the HSE management workflow.. Valid values are `draft|in_progress|completed|approved|under_review|closed`',
    `assessment_team_members` STRING COMMENT 'Comma-separated list of team members who participated in the risk assessment session.',
    `assessment_type` STRING COMMENT 'Type of risk assessment methodology applied: HAZID (Hazard Identification), HAZOP (Hazard and Operability Study), JSA (Job Safety Analysis), Bow-Tie, QRA (Quantitative Risk Assessment), FERA (Fire and Explosion Risk Analysis).. Valid values are `HAZID|HAZOP|JSA|Bow-Tie|QRA|FERA`',
    `baseline_value` DECIMAL(18,2) COMMENT 'Baseline measurement of the target metric at the start of the performance period, used for tracking progress.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for the operation or facility being assessed (e.g., Upstream, Midstream, Downstream, Petrochemicals).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created in the HSE management system.',
    `geographic_region` STRING COMMENT 'Geographic region where the assessed facility or operation is located.',
    `hazards_identified` STRING COMMENT 'Summary of hazards identified during the assessment, including physical, chemical, biological, ergonomic, and process safety hazards.',
    `inherent_risk_level` STRING COMMENT 'Initial risk level before any mitigation measures are applied, based on likelihood and consequence assessment.. Valid values are `critical|high|medium|low|negligible`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was last updated.',
    `lead_facilitator_name` STRING COMMENT 'Name of the lead facilitator who conducted the risk assessment.',
    `measurement_frequency` STRING COMMENT 'Frequency at which the target metric is measured and reported to track progress toward the objective.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `moc_reference_number` STRING COMMENT 'Reference number of the associated MOC record if a change management process was triggered by this assessment.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether a Management of Change process is required based on the risk assessment findings.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the risk assessment.',
    `objective_description` STRING COMMENT 'Description of the HSE management system objective or target established as a result of this risk assessment (e.g., reduce TRIR, eliminate H2S exposure incidents).',
    `operation_assessed` STRING COMMENT 'Description of the specific operation, process, or activity being assessed (e.g., drilling, well completion, SIMOPS, maintenance turnaround).',
    `ptw_integration_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment is integrated with or referenced by a Permit to Work process.',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory requirement or standard that mandates or guides this risk assessment (e.g., OSHA PSM, EPA RMP, BSEE SEMS).',
    `residual_risk_level` STRING COMMENT 'Risk level remaining after implementation of risk reduction measures and controls.. Valid values are `critical|high|medium|low|negligible`',
    `responsible_owner_name` STRING COMMENT 'Name of the responsible owner accountable for the HSE objective.',
    `review_due_date` DATE COMMENT 'Scheduled date for the next review or revalidation of the risk assessment, ensuring ongoing relevance and accuracy.',
    `risk_acceptance_status` STRING COMMENT 'Indicates whether the residual risk has been formally accepted by management or requires further mitigation.. Valid values are `accepted|not_accepted|conditional|pending_review`',
    `risk_matrix_score` STRING COMMENT 'Risk level determined using the organizations risk matrix (e.g., 5x5 matrix combining likelihood and consequence), typically expressed as a score or category (e.g., High, Medium, Low, or numeric score).',
    `risk_reduction_measures` STRING COMMENT 'Description of control measures, safeguards, and mitigation actions identified to reduce the risk to an acceptable level.',
    `scope_description` STRING COMMENT 'Detailed description of the scope of the risk assessment, including boundaries, activities, and operations covered.',
    `target_metric` STRING COMMENT 'Specific HSE performance metric targeted for improvement (e.g., TRIR, spill count, GHG reduction percentage, LDAR compliance rate, lost-time incident rate).',
    `target_value` DECIMAL(18,2) COMMENT 'Desired target value for the HSE performance metric to be achieved by the target year.',
    `target_year` STRING COMMENT 'Year by which the HSE objective and target value are expected to be achieved.',
    CONSTRAINT pk_hse_risk_assessment PRIMARY KEY(`hse_risk_assessment_id`)
) COMMENT 'HSE risk assessment and performance objective record capturing formal hazard identification, risk evaluation activities, and resulting HSE targets for oil and gas operations. Assessment captures: assessment type (HAZID, HAZOP, Job Safety Analysis/JSA, Bow-Tie, QRA, FERA), scope description, facility or operation assessed, assessment date, lead facilitator, hazards identified, risk levels (using risk matrix), risk reduction measures, residual risk level, and review due date. Also captures HSE management system objectives and targets: objective description, target metric (TRIR, spill count, GHG reduction percentage, LDAR compliance rate), baseline and target values, target year, responsible owner, measurement frequency, and achievement status. Supports OSHA PSM hazard analysis, MOC risk evaluation, PTW risk assessment workflows, and ISO 14001/45001 objectives and targets management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`management_of_change` (
    `management_of_change_id` BIGINT COMMENT 'Unique identifier for the Management of Change record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility where the change will be implemented, linking to the facility master data.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: MOCs frequently involve equipment modifications (pressure rating change, control system upgrade, material change). Equipment FK required for technical review, PSSR checklist generation, equipment spec',
    `hierarchy_id` BIGINT COMMENT 'Identifier of the specific asset or equipment affected by the change, linking to the asset management system.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who initiated the MOC request, linking to workforce master data.',
    `quaternary_management_last_modified_by_employee_id` BIGINT COMMENT 'Employee identifier of the user who last modified the MOC record, linking to workforce master data for audit trail.',
    `tertiary_management_created_by_employee_id` BIGINT COMMENT 'Employee identifier of the user who created the MOC record in the system, linking to workforce master data for audit trail.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well MOCs (artificial lift change, completion modification, pressure rating change) require well-specific linkage for reserves impact assessment, well integrity review, regulatory approval (state well',
    `previous_moc_id` BIGINT COMMENT 'Self-referencing FK on management_of_change (previous_moc_id)',
    `actual_implementation_date` DATE COMMENT 'Date when the change was actually implemented and placed into operation, marking the transition from planning to execution.',
    `approval_date` DATE COMMENT 'Date when final approval was granted, authorizing the change to proceed to implementation phase.',
    `approval_required_roles` STRING COMMENT 'Comma-separated list of organizational roles or positions required to approve the MOC (e.g., Operations Manager, HSE Manager, Engineering Lead, Facility Manager).',
    `approval_status` STRING COMMENT 'Overall approval state indicating whether all required approvals have been obtained for the MOC to proceed to implementation.. Valid values are `pending|partial|approved|rejected`',
    `approved_by_name` STRING COMMENT 'Full name of the final approving authority for reporting and audit trail purposes.',
    `change_category` STRING COMMENT 'Primary classification of what is being changed: process technology, equipment, operating procedure, facility infrastructure, organizational structure, or control system software.. Valid values are `process_technology|equipment|procedure|facility|organizational|software`',
    `change_description` STRING COMMENT 'Detailed narrative describing the nature, scope, and rationale for the proposed change to process technology, equipment, procedures, facilities, or organizational structure.',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the proposed change for quick identification and reporting.',
    `change_type` STRING COMMENT 'Classification of the change duration and intent: temporary (time-limited), permanent (indefinite), or emergency (immediate safety response).. Valid values are `temporary|permanent|emergency`',
    `closure_date` DATE COMMENT 'Date when the MOC was formally closed after successful implementation and completion of all follow-up actions, marking the end of the MOC lifecycle.',
    `closure_notes` STRING COMMENT 'Final comments documenting lessons learned, outstanding issues, or post-implementation observations recorded at MOC closure.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the MOC record was first created, providing audit trail for record lifecycle tracking.',
    `drawing_update_required_flag` BOOLEAN COMMENT 'Indicates whether Piping and Instrumentation Diagrams (P&IDs), process flow diagrams, or other technical drawings must be updated to reflect the change.',
    `drawing_update_status` STRING COMMENT 'Status of technical drawing updates required to maintain accurate process safety information following the change.. Valid values are `not_required|pending|in_progress|completed`',
    `hazard_evaluation_method` STRING COMMENT 'Methodology used to assess HSE risks associated with the change: Process Hazard Analysis (PHA), Hazard and Operability Study (HAZOP), What-If Analysis, Checklist, Failure Modes and Effects Analysis (FMEA), Layer of Protection Analysis (LOPA), or Bow-Tie Analysis. [ENUM-REF-CANDIDATE: pha|hazop|what_if|checklist|fmea|lopa|bow_tie — 7 candidates stripped; promote to reference product]',
    `initiating_department` STRING COMMENT 'Business unit or department that originated the MOC request (e.g., Operations, Engineering, Maintenance, HSE).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the MOC record was last updated, providing audit trail for change tracking and compliance verification.',
    `mitigation_measures` STRING COMMENT 'Description of controls, safeguards, and risk reduction measures required to manage identified hazards and ensure safe implementation of the change.',
    `moc_number` STRING COMMENT 'Business identifier for the MOC request, typically a human-readable reference number used for tracking and communication.',
    `moc_status` STRING COMMENT 'Current lifecycle status of the MOC request from initiation through closure, tracking workflow progression and approval state. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|implemented|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `planned_implementation_date` DATE COMMENT 'Target date for implementing the approved change, used for scheduling and resource planning.',
    `procedure_update_required_flag` BOOLEAN COMMENT 'Indicates whether operating procedures, work instructions, or standard operating procedures must be updated to reflect the change.',
    `procedure_update_status` STRING COMMENT 'Status of procedure documentation updates required to support the change, ensuring operating instructions remain current.. Valid values are `not_required|pending|in_progress|completed`',
    `process_unit` STRING COMMENT 'Name or identifier of the process unit or operational area where the change will occur (e.g., Crude Distillation Unit, Compressor Station, Drilling Rig).',
    `pssr_completion_date` DATE COMMENT 'Date when the Pre-Startup Safety Review was completed and approved, authorizing the change to proceed to implementation.',
    `pssr_required_flag` BOOLEAN COMMENT 'Indicates whether a Pre-Startup Safety Review is required before the change can be placed into operation, as mandated by OSHA PSM for process changes.',
    `pssr_status` STRING COMMENT 'Current status of the Pre-Startup Safety Review process, tracking completion of safety verification activities before change implementation.. Valid values are `not_required|pending|in_progress|completed|approved`',
    `ptw_required_flag` BOOLEAN COMMENT 'Indicates whether a Permit to Work is required for the implementation activities, linking MOC to the PTW system for work authorization.',
    `regulatory_notification_date` DATE COMMENT 'Date when required regulatory notification was submitted, ensuring compliance with reporting timelines.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the change requires notification to regulatory authorities such as OSHA, EPA, BSEE, or state agencies.',
    `risk_level` STRING COMMENT 'Overall risk classification resulting from the hazard evaluation, indicating the severity of potential HSE impacts if the change is implemented.. Valid values are `low|medium|high|critical`',
    `risk_matrix_score` STRING COMMENT 'Alphanumeric risk score derived from the risk assessment matrix (e.g., 3A, 4B) combining likelihood and consequence ratings.',
    `submission_date` DATE COMMENT 'Date when the MOC request was formally submitted for review and approval, marking the start of the formal MOC process.',
    `temporary_change_expiration_date` DATE COMMENT 'For temporary changes, the date when the change must be reversed or converted to a permanent MOC, ensuring time-limited changes do not become indefinite.',
    `training_completion_status` STRING COMMENT 'Status of required training activities for affected personnel, tracking readiness for change implementation.. Valid values are `not_required|pending|in_progress|completed`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether personnel training is required before the change can be implemented, ensuring workforce competency for new processes or equipment.',
    CONSTRAINT pk_management_of_change PRIMARY KEY(`management_of_change_id`)
) COMMENT 'Management of Change (MOC) record tracking proposed changes to process technology, equipment, procedures, facilities, or organizational structure that may affect HSE risk profiles. Captures change description, change type (temporary, permanent), initiating department, hazard evaluation method, risk assessment linkage, required approvals, pre-startup safety review (PSSR) status, implementation date, and closure status. Required by OSHA PSM 29 CFR 1910.119(l) and EPA RMP. Integrates with PTW, risk assessment, and CAPA workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` (
    `ldar_inspection_id` BIGINT COMMENT 'Unique identifier for this component inspection record. Primary key.',
    `ldar_survey_id` BIGINT COMMENT 'Foreign key linking to the LDAR survey during which this component inspection occurred',
    `employee_id` BIGINT COMMENT 'Identifier of the specific inspector who performed this component inspection, may differ from survey lead inspector',
    `ldar_component_id` BIGINT COMMENT 'Foreign key linking to the specific equipment component that was inspected',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration for the monitoring instrument used in this inspection, required for EPA compliance',
    `component_condition_observed` STRING COMMENT 'Physical condition of the component observed during inspection: normal, corroded, damaged, loose, missing packing',
    `inspection_result` STRING COMMENT 'Outcome classification for this component inspection: no leak detected, leak detected, component inaccessible, component not found, delayed repair approved',
    `inspection_sequence_number` STRING COMMENT 'Sequential order in which this component was inspected during the survey, used for audit trail and survey planning',
    `inspection_timestamp` TIMESTAMP COMMENT 'Precise date and time when this specific component was inspected during the survey',
    `inspector_comments` STRING COMMENT 'Free-text observations and notes recorded by the inspector specific to this component inspection',
    `instrument_serial_number` STRING COMMENT 'Serial number of the monitoring instrument used for this component inspection, required for regulatory documentation',
    `leak_detected_flag` BOOLEAN COMMENT 'Indicates whether a leak exceeding the regulatory threshold was detected at this component during this inspection',
    `measured_concentration_ppm` DECIMAL(18,2) COMMENT 'Fugitive emission concentration measured at this component in parts per million during this inspection',
    `repair_completion_date` DATE COMMENT 'Date when the leak repair was completed for this component, if repair was required',
    `repair_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action (leak repair) is required for this component based on this inspection result',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of this specific component inspection, relevant for OGI camera effectiveness',
    CONSTRAINT pk_ldar_inspection PRIMARY KEY(`ldar_inspection_id`)
) COMMENT 'This association product represents the inspection event between an LDAR survey and an individual equipment component. It captures the specific inspection details for each component examined during a survey, including measurement readings, leak detection results, and inspector observations. Each record links one LDAR survey to one component with attributes that exist only in the context of this specific inspection.. Existence Justification: In oil and gas LDAR operations, each survey inspects multiple components (valves, flanges, connectors, etc.) and each component is inspected across multiple surveys over time to maintain regulatory compliance. The inspection of a specific component during a specific survey is a distinct operational event that HSE coordinators actively manage, with its own measurement data, leak detection results, repair tracking, and regulatory documentation requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` (
    `incident_substance_involvement_id` BIGINT COMMENT 'Unique identifier for this incident-substance involvement record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Reference to the HSE investigator or safety professional who documented this substance involvement during incident investigation.',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to the hazardous substance master record',
    `incident_id` BIGINT COMMENT 'Foreign key linking to the HSE incident record',
    `containment_method` STRING COMMENT 'Method used to contain or control the release of this specific substance (e.g., boom deployment, absorbent pads, vapor suppression foam, secondary containment activation). Substance-specific because different chemicals require different containment strategies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this incident-substance involvement record was created in the system, typically during incident investigation.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether this specific substance release resulted in environmental impact (soil contamination, water body impact, air quality exceedance). Used for environmental remediation planning and ESG reporting.',
    `exposure_duration_minutes` STRING COMMENT 'Duration of personnel exposure to this substance during the incident, measured in minutes. Used with exposure_level_ppm to calculate time-weighted average exposures.',
    `exposure_level_ppm` DECIMAL(18,2) COMMENT 'Concentration level of substance exposure measured in parts per million during the incident. Used for H2S exposure incidents and other gas/vapor exposures to assess OSHA PEL exceedances.',
    `involvement_type` STRING COMMENT 'Classification of how this substance was involved in the incident. A single incident can involve multiple substances in different ways (e.g., one substance released, another used in response).',
    `lopc_quantity` DECIMAL(18,2) COMMENT 'Quantity of material released in loss of primary containment event, measured in barrels for liquids or thousand cubic feet for gases. Used for API RP 754 Tier 1 and Tier 2 classification. [Moved from incident: This attribute currently exists on the incident table but represents the quantity of a SPECIFIC substance released. In incidents involving multiple substances, each substance has its own release quantity. This should be modeled as quantity_released in the association, allowing each incident-substance pair to have its own quantity value.]',
    `lopc_unit_of_measure` STRING COMMENT 'Unit of measure for the quantity of material released. BBL=Barrels, MCF=Thousand Cubic Feet, LBS=Pounds, KG=Kilograms, GAL=Gallons, L=Liters. [Moved from incident: This attribute is the unit of measure for lopc_quantity and should move with it to the association as release_unit_of_measure. Different substances in the same incident may be measured in different units (e.g., H2S in MCF, crude oil in BBL, produced water in GAL).]. Valid values are `BBL|MCF|LBS|KG|GAL|L`',
    `personnel_exposed_count` STRING COMMENT 'Number of personnel (employees and contractors) exposed to this specific substance during the incident. Used for industrial hygiene follow-up and medical surveillance.',
    `ppe_used` STRING COMMENT 'Personal protective equipment used by responders when handling this specific substance during incident response (e.g., Level A suit, SCBA, chemical-resistant gloves, NORM-rated respirator). Substance-specific because PPE requirements vary by chemical hazard class.',
    `quantity_released` DECIMAL(18,2) COMMENT 'Quantity of this specific hazardous substance released in the incident. Critical for CERCLA reportable quantity determination and EPCRA Section 313 release reporting.',
    `regulatory_threshold_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the quantity released of this specific substance exceeded its CERCLA reportable quantity or other regulatory threshold, triggering mandatory notification to NRC, EPA, or state agencies.',
    `release_unit_of_measure` STRING COMMENT 'Unit of measure for the quantity released. Must align with regulatory reporting requirements (typically pounds for CERCLA/EPCRA).',
    CONSTRAINT pk_incident_substance_involvement PRIMARY KEY(`incident_substance_involvement_id`)
) COMMENT 'This association product represents the involvement of hazardous substances in HSE incidents. It captures the operational reality that incidents can involve multiple hazardous substances (e.g., a multi-chemical spill, exposure to multiple NORM materials) and that each substance can be involved in multiple incidents over time. Each record links one incident to one hazardous_substance with attributes that exist only in the context of this specific involvement: quantity released, exposure levels, personnel affected, containment methods, and regulatory threshold breach status. This is a first-class operational entity used for EPCRA Section 313 release reporting, RMP accident history documentation, substance-specific risk profiling, and ESG reporting of cumulative releases by chemical.. Existence Justification: In oil and gas HSE operations, incidents routinely involve multiple hazardous substances simultaneously (e.g., a wellhead blowout releasing crude oil, H2S gas, and NORM-contaminated produced water; a tank battery fire involving multiple stored chemicals). Conversely, each hazardous substance is involved in multiple incidents over time, requiring cumulative release tracking for EPCRA Section 313 reporting and substance-specific risk profiling. HSE managers actively manage these incident-substance relationships as operational records during incident investigation, documenting substance-specific release quantities, exposure levels, containment methods, and regulatory threshold breaches.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`monitoring_station` (
    `monitoring_station_id` BIGINT COMMENT 'Primary key for monitoring_station',
    `employee_id` BIGINT COMMENT 'Identifier of the employee accountable for station operation.',
    `parent_monitoring_station_id` BIGINT COMMENT 'Self-referencing FK on monitoring_station (parent_monitoring_station_id)',
    `address` STRING COMMENT 'Street address where the monitoring station is installed.',
    `calibration_date` DATE COMMENT 'Date the stations sensors were last calibrated.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration activity.',
    `city` STRING COMMENT 'City of the station location.',
    `compliance_status` STRING COMMENT 'Current compliance status with applicable HSE regulations.',
    `country_code` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code for the station location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the station record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the station was retired or removed from service.',
    `emergency_contact_phone` STRING COMMENT 'Phone number to call in case of an emergency at the station.',
    `hazard_classification` STRING COMMENT 'Regulatory hazard class assigned to the station site.',
    `installation_date` DATE COMMENT 'Date the station was installed and became operational.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the station is currently active in the system.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection.',
    `last_reported_event_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent sensor reading or event logged by the station.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the station in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the station in decimal degrees.',
    `maintenance_contact_phone` STRING COMMENT 'Phone number for the maintenance contact.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Upper bound of the calibrated measurement range.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Lower bound of the calibrated measurement range.',
    `measurement_type` STRING COMMENT 'Primary physical or chemical parameter measured by the station.',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with the measurement type.',
    `next_inspection_due` DATE COMMENT 'Planned date for the next required inspection.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the station.',
    `owner_department` STRING COMMENT 'Internal department responsible for the station.',
    `permit_number` STRING COMMENT 'Permit‑to‑Work or environmental permit identifier associated with the station.',
    `sensor_count` STRING COMMENT 'Number of individual sensors installed at the station.',
    `state_province` STRING COMMENT 'State or province of the station location.',
    `station_code` STRING COMMENT 'Business‑assigned code used to reference the station in operational systems.',
    `station_name` STRING COMMENT 'Human‑readable name of the monitoring station.',
    `station_type` STRING COMMENT 'Category of environmental parameter the station monitors.',
    `monitoring_station_status` STRING COMMENT 'Current operational status of the station.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the station record.',
    CONSTRAINT pk_monitoring_station PRIMARY KEY(`monitoring_station_id`)
) COMMENT 'Master reference table for monitoring_station. Referenced by monitoring_station_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`detector_instrument` (
    `detector_instrument_id` BIGINT COMMENT 'Primary key for detector_instrument',
    `installation_location_id` BIGINT COMMENT 'Reference to the location where the instrument is installed.',
    `parent_detector_instrument_id` BIGINT COMMENT 'Self-referencing FK on detector_instrument (parent_detector_instrument_id)',
    `accuracy` DECIMAL(18,2) COMMENT 'Stated accuracy of the instrument expressed as a percentage.',
    `alarm_setpoint` DECIMAL(18,2) COMMENT 'Configured setpoint for alarm activation.',
    `alarm_threshold` DECIMAL(18,2) COMMENT 'Measurement value that triggers an alarm condition.',
    `asset_tag` STRING COMMENT 'Internal asset tag used for inventory tracking.',
    `battery_status` STRING COMMENT 'Current health of the instruments battery.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibrations.',
    `communication_protocol` STRING COMMENT 'Network protocol used for data transmission.',
    `compliance_status` STRING COMMENT 'Current compliance verification status.',
    `decommission_date` DATE COMMENT 'Date the instrument was removed from service.',
    `detector_instrument_description` STRING COMMENT 'Free‑form description of the instruments purpose and characteristics.',
    `detection_range_max` DECIMAL(18,2) COMMENT 'Maximum measurable value the instrument can detect.',
    `detection_range_min` DECIMAL(18,2) COMMENT 'Minimum measurable value the instrument can detect.',
    `detection_type` STRING COMMENT 'Category of hazard or parameter the instrument is designed to detect.',
    `equipment_category` STRING COMMENT 'Broad category of the equipment.',
    `firmware_version` STRING COMMENT 'Version identifier of the instruments firmware.',
    `installation_date` DATE COMMENT 'Date the instrument was installed at its location.',
    `instrument_name` STRING COMMENT 'Human‑readable name or label assigned to the detector instrument.',
    `is_ghg_monitor` BOOLEAN COMMENT 'Indicates if the instrument is used for greenhouse‑gas monitoring.',
    `is_h2s_capable` BOOLEAN COMMENT 'Indicates if the instrument can detect hydrogen sulfide.',
    `is_wireless` BOOLEAN COMMENT 'Indicates whether the instrument transmits data wirelessly.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration performed on the instrument.',
    `last_maintenance_date` DATE COMMENT 'Date the instrument last underwent maintenance.',
    `maintenance_interval_days` STRING COMMENT 'Planned number of days between maintenance events.',
    `manufacturer` STRING COMMENT 'Company that produced the detector instrument.',
    `model_number` STRING COMMENT 'Model designation of the detector instrument as defined by the vendor.',
    `next_calibration_due` DATE COMMENT 'Scheduled date for the next required calibration.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next maintenance activity.',
    `notes` STRING COMMENT 'Additional remarks or operational notes.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the instrument in the field.',
    `owner_department` STRING COMMENT 'Business department responsible for the instrument.',
    `power_source` STRING COMMENT 'Primary power source for the instrument.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `regulatory_certification` STRING COMMENT 'Regulatory standards to which the instrument complies.',
    `response_time_ms` STRING COMMENT 'Time in milliseconds for the instrument to register a detection.',
    `risk_classification` STRING COMMENT 'Risk level assigned to the instrument based on hazard potential.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number uniquely identifying the hardware unit.',
    `software_version` STRING COMMENT 'Version identifier of any embedded software.',
    `unit_of_measure` STRING COMMENT 'Unit used for the detection range values.',
    CONSTRAINT pk_detector_instrument PRIMARY KEY(`detector_instrument_id`)
) COMMENT 'Master reference table for detector_instrument. Referenced by detector_instrument_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`detector` (
    `detector_id` BIGINT COMMENT 'Primary key for detector',
    `parent_detector_id` BIGINT COMMENT 'Self-referencing FK on detector (parent_detector_id)',
    `alarm_delay_seconds` STRING COMMENT 'Delay after threshold breach before alarm is raised.',
    `alarm_setpoint` DECIMAL(18,2) COMMENT 'Value at which an alarm is generated, may differ from detection threshold.',
    `asset_tag` STRING COMMENT 'Company‑assigned asset tag used to track the detector in inventory.',
    `calibration_date` DATE COMMENT 'Date the detector was last calibrated.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibrations.',
    `compliance_standard` STRING COMMENT 'Regulatory or standards framework the detector supports.',
    `connectivity_type` STRING COMMENT 'Method by which the detector transmits data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the detector record was first created in the system.',
    `data_logging_enabled` BOOLEAN COMMENT 'Indicates whether the detector records raw measurement data.',
    `decommission_date` DATE COMMENT 'Date the detector was retired from service, if applicable.',
    `decommission_reason` STRING COMMENT 'Reason for retiring the detector (e.g., failure, upgrade).',
    `detector_description` STRING COMMENT 'Free‑text description of the detectors purpose, installation notes, or special considerations.',
    `detection_range_max` DECIMAL(18,2) COMMENT 'Maximum measurable value the detector can sense.',
    `detection_threshold` DECIMAL(18,2) COMMENT 'Threshold value at which the detector triggers an alarm.',
    `detector_type` STRING COMMENT 'Category of phenomenon the detector monitors (e.g., gas, flame).',
    `firmware_version` STRING COMMENT 'Version of the firmware installed on the detector.',
    `hazard_classification` STRING COMMENT 'Indicates whether the detector monitors a hazardous or non‑hazardous parameter.',
    `installation_date` DATE COMMENT 'Date the detector was installed at the site.',
    `installation_method` STRING COMMENT 'Physical method used to install the detector.',
    `is_critical` BOOLEAN COMMENT 'True if the detector is deemed critical for safety compliance.',
    `last_data_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent measurement received from the detector.',
    `last_maintenance_date` DATE COMMENT 'Date the detector last underwent maintenance.',
    `location_name` STRING COMMENT 'Name of the physical location or facility where the detector is installed.',
    `maintenance_interval_days` STRING COMMENT 'Planned interval between routine maintenance activities.',
    `manufacturer` STRING COMMENT 'Company that manufactured the detector.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `detector_name` STRING COMMENT 'Human‑readable name or label for the detector.',
    `network_code` STRING COMMENT 'Identifier of the network or gateway the detector is attached to.',
    `next_calibration_date` DATE COMMENT 'Scheduled date for the next calibration.',
    `operating_temperature_max` DECIMAL(18,2) COMMENT 'Maximum ambient temperature at which the detector can operate.',
    `operating_temperature_min` DECIMAL(18,2) COMMENT 'Minimum ambient temperature at which the detector can operate.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum power consumption of the detector.',
    `power_source` STRING COMMENT 'Primary source of power for the detector.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the detector hardware.',
    `software_version` STRING COMMENT 'Version of the application software used for data processing.',
    `detector_status` STRING COMMENT 'Current lifecycle status of the detector.',
    `temperature_unit` STRING COMMENT 'Unit of measure for operating temperature (e.g., C, F).',
    `threshold_unit` STRING COMMENT 'Unit of measure for the detection threshold (e.g., ppm, %LEL).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the detector record.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer warranty expires.',
    `warranty_provider` STRING COMMENT 'Entity providing the warranty coverage.',
    CONSTRAINT pk_detector PRIMARY KEY(`detector_id`)
) COMMENT 'Master reference table for detector. Referenced by detector_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`installation_location` (
    `installation_location_id` BIGINT COMMENT 'Primary key for installation_location',
    `parent_installation_location_id` BIGINT COMMENT 'Self-referencing FK on installation_location (parent_installation_location_id)',
    `address_line1` STRING COMMENT 'Primary street address of the installation.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `city` STRING COMMENT 'City or town where the installation is situated.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the installation is located.',
    `county` STRING COMMENT 'County or district containing the installation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the installation record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the installation was permanently shut down or removed (nullable if still active).',
    `depth_ft` DECIMAL(18,2) COMMENT 'Depth of the well or borehole associated with the installation, expressed in feet.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the installation above mean sea level, expressed in meters.',
    `emergency_response_plan_id` BIGINT COMMENT 'Identifier linking to the emergency response plan applicable to the installation.',
    `environmental_sensitivity_rating` STRING COMMENT 'Rating indicating the environmental sensitivity of the installation site.',
    `facility_class` STRING COMMENT 'Regulatory or engineering classification of the facility.',
    `ghg_emission_factor` DECIMAL(18,2) COMMENT 'Greenhouse gas emission factor associated with the installations production.',
    `hse_zone_classification` STRING COMMENT 'Health, Safety, and Environment risk zone classification for the installation.',
    `installation_date` DATE COMMENT 'Date the installation became operational.',
    `installation_type` STRING COMMENT 'Indicates whether the installation was built new, retrofitted, or upgraded.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent HSE inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the installation in decimal degrees.',
    `location_code` STRING COMMENT 'Business‑assigned unique code or tag for the installation used in operational systems.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the installation in decimal degrees.',
    `installation_location_name` STRING COMMENT 'Human‑readable name of the installation (e.g., platform name, facility name).',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required HSE inspection.',
    `operator_company` STRING COMMENT 'Company responsible for day‑to‑day operation of the installation.',
    `owner_company` STRING COMMENT 'Legal entity that owns the installation.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the regulatory permit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the installation address.',
    `production_capacity_bbl_per_day` DECIMAL(18,2) COMMENT 'Maximum daily production capacity of the installation.',
    `region` STRING COMMENT 'Broad geographic region (e.g., Gulf of Mexico, North Sea).',
    `regulatory_permit_number` STRING COMMENT 'Identifier of the primary regulatory permit governing the installation.',
    `spill_history_flag` BOOLEAN COMMENT 'Indicates whether the installation has a recorded spill incident (true/false).',
    `state_province` STRING COMMENT 'State or province name for the installations location.',
    `installation_location_status` STRING COMMENT 'Current operational lifecycle status of the installation.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the installation location.',
    `installation_location_type` STRING COMMENT 'Category of the installation indicating its physical nature.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the installation record.',
    `water_depth_m` DECIMAL(18,2) COMMENT 'Depth of water at the installation site, relevant for offshore assets.',
    CONSTRAINT pk_installation_location PRIMARY KEY(`installation_location_id`)
) COMMENT 'Master reference table for installation_location. Referenced by installation_location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_previous_action_hse_corrective_action_id` FOREIGN KEY (`previous_action_hse_corrective_action_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_corrective_action`(`hse_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `oil_gas_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_hse_corrective_action_id` FOREIGN KEY (`hse_corrective_action_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_corrective_action`(`hse_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_detector_id` FOREIGN KEY (`detector_id`) REFERENCES `oil_gas_ecm`.`hse`.`detector`(`detector_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_simops_plan_id` FOREIGN KEY (`simops_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`simops_plan`(`simops_plan_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_detector_instrument_id` FOREIGN KEY (`detector_instrument_id`) REFERENCES `oil_gas_ecm`.`hse`.`detector_instrument`(`detector_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_monitoring_station_id` FOREIGN KEY (`monitoring_station_id`) REFERENCES `oil_gas_ecm`.`hse`.`monitoring_station`(`monitoring_station_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_original_submission_regulatory_submission_id` FOREIGN KEY (`original_submission_regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_hse_corrective_action_id` FOREIGN KEY (`hse_corrective_action_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_corrective_action`(`hse_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_previous_training_hse_training_record_id` FOREIGN KEY (`previous_training_hse_training_record_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_training_record`(`hse_training_record_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ADD CONSTRAINT `fk_hse_chemical_inventory_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `oil_gas_ecm`.`hse`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_incident_investigation_id` FOREIGN KEY (`incident_investigation_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident_investigation`(`incident_investigation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `oil_gas_ecm`.`hse`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_previous_moc_id` FOREIGN KEY (`previous_moc_id`) REFERENCES `oil_gas_ecm`.`hse`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ADD CONSTRAINT `fk_hse_ldar_inspection_ldar_survey_id` FOREIGN KEY (`ldar_survey_id`) REFERENCES `oil_gas_ecm`.`hse`.`ldar_survey`(`ldar_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ADD CONSTRAINT `fk_hse_ldar_inspection_ldar_component_id` FOREIGN KEY (`ldar_component_id`) REFERENCES `oil_gas_ecm`.`hse`.`ldar_component`(`ldar_component_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ADD CONSTRAINT `fk_hse_incident_substance_involvement_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `oil_gas_ecm`.`hse`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ADD CONSTRAINT `fk_hse_incident_substance_involvement_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ADD CONSTRAINT `fk_hse_monitoring_station_parent_monitoring_station_id` FOREIGN KEY (`parent_monitoring_station_id`) REFERENCES `oil_gas_ecm`.`hse`.`monitoring_station`(`monitoring_station_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`detector_instrument` ADD CONSTRAINT `fk_hse_detector_instrument_installation_location_id` FOREIGN KEY (`installation_location_id`) REFERENCES `oil_gas_ecm`.`hse`.`installation_location`(`installation_location_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`detector_instrument` ADD CONSTRAINT `fk_hse_detector_instrument_parent_detector_instrument_id` FOREIGN KEY (`parent_detector_instrument_id`) REFERENCES `oil_gas_ecm`.`hse`.`detector_instrument`(`detector_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`detector` ADD CONSTRAINT `fk_hse_detector_parent_detector_id` FOREIGN KEY (`parent_detector_id`) REFERENCES `oil_gas_ecm`.`hse`.`detector`(`detector_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ADD CONSTRAINT `fk_hse_installation_location_parent_installation_location_id` FOREIGN KEY (`parent_installation_location_id`) REFERENCES `oil_gas_ecm`.`hse`.`installation_location`(`installation_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`hse` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `oil_gas_ecm`.`hse` SET TAGS ('dbx_domain' = 'hse');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `charter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Company Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Injured Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_investigation_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Lead Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_investigation_lead_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_investigation_lead_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_observer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Observer Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_observer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_observer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_reporter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_reporter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_reporter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `pipeline_throughput_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Throughput Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `storage_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Inventory Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `truck_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work (DAFW)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `days_of_restricted_work` SET TAGS ('dbx_business_glossary_term' = 'Days of Restricted Work');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `fatality_flag` SET TAGS ('dbx_business_glossary_term' = 'Fatality Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `h2s_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Exposure Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|investigation_complete|closed|reopened');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `initial_description` SET TAGS ('dbx_business_glossary_term' = 'Initial Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|visitor|public|not_applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `lopc_flag` SET TAGS ('dbx_business_glossary_term' = 'Loss of Primary Containment (LOPC) Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `lost_time_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Incident (LTI) Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `norm_involvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Involvement Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `pse_tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event (PSE) Tier Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `pse_tier_classification` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|not_applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `simops_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `spill_to_environment_flag` SET TAGS ('dbx_business_glossary_term' = 'Spill to Environment Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `work_activity_type` SET TAGS ('dbx_business_glossary_term' = 'Work Activity Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `tertiary_incident_lead_investigator_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Approval Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = 'upstream|midstream|downstream|petrochemicals|corporate');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `capa_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors Narrative');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `equipment_failure_analysis` SET TAGS ('dbx_business_glossary_term' = 'Equipment Failure Analysis');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `external_consultant_name` SET TAGS ('dbx_business_glossary_term' = 'External Consultant Organization Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `external_consultant_used` SET TAGS ('dbx_business_glossary_term' = 'External Consultant Used Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings Summary');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `human_factors_analysis` SET TAGS ('dbx_business_glossary_term' = 'Human Factors Analysis');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `immediate_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Investigation Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_report_url` SET TAGS ('dbx_business_glossary_term' = 'Investigation Report Document URL');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|under_review|completed|closed');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_team_members` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team Members List');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'preliminary|detailed|root_cause_analysis|regulatory_mandated|internal_audit');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Documentation');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `management_review_date` SET TAGS ('dbx_business_glossary_term' = 'Management Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `management_review_required` SET TAGS ('dbx_business_glossary_term' = 'Management Review Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `procedural_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Procedural Deficiencies Identified');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `rca_methodology` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Methodology');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `recommendations_summary` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Summary');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `regulatory_report_submitted` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `systemic_causes` SET TAGS ('dbx_business_glossary_term' = 'Systemic Causes Narrative');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Interview Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `hse_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Corrective Action ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `previous_action_hse_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Action ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Jib Statement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|closed|overdue|cancelled');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|improvement');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `attachments_count` SET TAGS ('dbx_business_glossary_term' = 'Attachments Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `effectiveness_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Comments');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `effectiveness_review_status` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `effectiveness_review_status` SET TAGS ('dbx_value_regex' = 'pending|effective|ineffective|partially_effective');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'incident|audit|inspection|near_miss|observation|complaint');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|site_inspection|audit|testing|observation|interview');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit-to-Work (PTW) Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Instrument Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `approval_signature_digital_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Signature Digital Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `concurrent_permit_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Permit Check Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `conflicting_permits` SET TAGS ('dbx_business_glossary_term' = 'Conflicting Permits');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `energy_sources_isolated` SET TAGS ('dbx_business_glossary_term' = 'Energy Sources Isolated');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `gas_test_co_ppm` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Carbon Monoxide (CO) Parts Per Million');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `gas_test_h2s_ppm` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Hydrogen Sulfide (H2S) Parts Per Million');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `gas_test_lel_percent` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Lower Explosive Limit (LEL) Percentage');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `gas_test_oxygen_percent` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Oxygen (O2) Percentage');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `gas_test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `hazard_identification_summary` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identification Summary');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `isolation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Isolation Requirements');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `jsa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Job Safety Analysis (JSA) Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('dbx_value_regex' = '^PTW-[A-Z0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'draft|issued|active|suspended|closed|cancelled');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'hot_work|confined_space_entry|electrical_isolation|excavation|working_at_height|simops');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `rescue_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Rescue Plan Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `simops_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Plan Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `suspended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Suspended Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `valid_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `work_completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Work Completion Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` SET TAGS ('dbx_subdomain' = 'risk_assessment');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `simops_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Plan ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `primary_simops_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Coordinator ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `primary_simops_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `primary_simops_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `tertiary_simops_hse_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Reviewer ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `tertiary_simops_hse_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `tertiary_simops_hse_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|suspended|expired');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `conflicting_operations_identified` SET TAGS ('dbx_business_glossary_term' = 'Conflicting Operations Identified');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `emergency_response_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `exclusion_zone_defined` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Zone Defined Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `exclusion_zone_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Zone Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `hse_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Review Completed Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `hse_review_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `permit_to_work_required` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Plan Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Plan Title');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned End Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `ptw_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `risk_matrix_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Matrix Score');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `simops_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Coordinator Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `simops_coordinator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `simops_coordinator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ALTER COLUMN `simops_scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Scenario Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `areas_audited` SET TAGS ('dbx_business_glossary_term' = 'Areas Audited');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'Planned|In Progress|Completed|Report Issued|Closed|Cancelled');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Conditional|Suspended|Revoked|Not Applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration Days');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `key_risks_identified` SET TAGS ('dbx_business_glossary_term' = 'Key Risks Identified');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `key_strengths_identified` SET TAGS ('dbx_business_glossary_term' = 'Key Strengths Identified');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `management_response_received` SET TAGS ('dbx_business_glossary_term' = 'Management Response Received');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'On-Site|Remote|Hybrid|Document Review');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `objectives` SET TAGS ('dbx_business_glossary_term' = 'Audit Objectives');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `overall_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `overall_compliance_rating` SET TAGS ('dbx_value_regex' = 'Compliant|Substantially Compliant|Partially Compliant|Non-Compliant|Not Applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `standards_assessed` SET TAGS ('dbx_business_glossary_term' = 'Standards Assessed');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `hse_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Audit Finding Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Finding Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `hse_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Corrective Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `quaternary_hse_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `quaternary_hse_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `quaternary_hse_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `quinary_hse_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `quinary_hse_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `quinary_hse_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `tertiary_hse_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `tertiary_hse_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `tertiary_hse_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'safety|environmental|health|process_safety|occupational_health');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'nonconformity|observation|opportunity_for_improvement|positive_practice');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `hse_audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `hse_audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|closed|overdue');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `management_of_change_required` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `previous_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `requirement_clause` SET TAGS ('dbx_business_glossary_term' = 'Requirement Clause');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `root_cause_analysis_required` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|low');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `ldar_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Ldar Survey Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `primary_ldar_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `primary_ldar_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `primary_ldar_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `components_surveyed_count` SET TAGS ('dbx_business_glossary_term' = 'Components Surveyed Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `contractor_company_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Company Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `corrective_action_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `equipment_component_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Component Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `hse_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Review Comments');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `hse_review_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `instrument_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `leak_detection_threshold_ppm` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Threshold (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `leaks_detected_count` SET TAGS ('dbx_business_glossary_term' = 'Leaks Detected Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `maximum_leak_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Leak Concentration (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'ogi_camera|method_21_analyzer|audio_visual_olfactory|smart_ldar|other');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Completion Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey End Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|under_review|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'scheduled|unscheduled|follow_up|post_repair|initial');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `total_estimated_emissions_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Emissions Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `total_estimated_emissions_mcf` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Emissions (Thousand Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Miles Per Hour)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `ldar_component_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection and Repair (LDAR) Component ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `component_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|temporarily_removed');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `component_subtype` SET TAGS ('dbx_business_glossary_term' = 'Component Subtype');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `component_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Component Tag Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'valve|connector|pump_seal|compressor_seal|open_ended_line|pressure_relief_device');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `exemption_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Approval Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `exemption_justification` SET TAGS ('dbx_business_glossary_term' = 'Exemption Justification');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `ghg_reporting_applicable` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reporting Applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `hazardous_air_pollutant_service` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Air Pollutant (HAP) Service');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'no_leak_detected|leak_detected|repair_completed|delayed_repair');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `last_measured_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Concentration Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `leak_threshold_ppm` SET TAGS ('dbx_business_glossary_term' = 'Leak Threshold Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `monitoring_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Days');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `operating_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `piping_and_instrumentation_diagram_reference` SET TAGS ('dbx_business_glossary_term' = 'Piping and Instrumentation Diagram (P&ID) Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `regulatory_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exemption Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `regulatory_exemption_status` SET TAGS ('dbx_value_regex' = 'not_exempt|unsafe_to_monitor|difficult_to_monitor|inaccessible|low_emissions_process');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `service_classification` SET TAGS ('dbx_business_glossary_term' = 'Service Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `service_classification` SET TAGS ('dbx_value_regex' = 'light_liquid|heavy_liquid|gas_vapor|two_phase');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `service_fluid` SET TAGS ('dbx_business_glossary_term' = 'Service Fluid');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ALTER COLUMN `volatile_organic_compound_service` SET TAGS ('dbx_business_glossary_term' = 'Volatile Organic Compound (VOC) Service');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Permit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `cems_installed` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emission Monitoring System (CEMS) Installed Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `control_device_installed` SET TAGS ('dbx_business_glossary_term' = 'Control Device Installed Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `control_device_type` SET TAGS ('dbx_business_glossary_term' = 'Control Device Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `control_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Control Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `esg_reporting_scope` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reporting Scope');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `esg_reporting_scope` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3|not_applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `fuel_heating_value` SET TAGS ('dbx_business_glossary_term' = 'Fuel Higher Heating Value (HHV)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `fuel_heating_value_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Heating Value Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `fuel_heating_value_unit` SET TAGS ('dbx_value_regex' = 'MMBtu/scf|MMBtu/bbl|MMBtu/ton|MMBtu/kg|MJ/kg|MJ/m3');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `geographic_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coordinates');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `ghg_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reporting Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `h2s_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Concentration in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `ldar_component_count` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection and Repair (LDAR) Component Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `ldar_program_applicable` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection and Repair (LDAR) Program Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `monitoring_methodology` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Methodology');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `neshap_subpart_applicable` SET TAGS ('dbx_business_glossary_term' = 'National Emission Standards for Hazardous Air Pollutants (NESHAP) Subpart Applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `norm_present` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Present Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `nsps_subpart_applicable` SET TAGS ('dbx_business_glossary_term' = 'New Source Performance Standards (NSPS) Subpart Applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|standby|idle|maintenance|decommissioned|planned');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `permit_emission_limit` SET TAGS ('dbx_business_glossary_term' = 'Permit Emission Limit');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `permit_emission_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Permit Emission Limit Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `permit_emission_limit_unit` SET TAGS ('dbx_value_regex' = 'tons/year|kg/year|lb/hr|g/s|metric_tons_CO2e/year');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `rated_capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `regulatory_threshold_applicable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Source Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `source_category` SET TAGS ('dbx_value_regex' = 'stationary_combustion|mobile_combustion|process_emissions|fugitive_emissions|vented_emissions|flared_emissions');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `source_number` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `source_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `stack_diameter_meters` SET TAGS ('dbx_business_glossary_term' = 'Stack Diameter in Meters');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `stack_height_meters` SET TAGS ('dbx_business_glossary_term' = 'Stack Height in Meters');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `title_v_major_source` SET TAGS ('dbx_business_glossary_term' = 'Title V Major Source Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `revenue_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `activity_data_unit` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `activity_data_value` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `calculation_notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `carbon_offset_applied` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Applied Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `carbon_offset_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset in Tonnes');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) in Tonnes');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_factor_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_factor_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_value_regex' = 'combustion|flaring|venting|fugitive|process|other');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `epa_subpart_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Subpart Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `esg_disclosure_included` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Disclosure Included Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `ghg_gas_type` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Gas Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `ghg_gas_type` SET TAGS ('dbx_value_regex' = 'CO2|CH4|N2O|HFC|PFC|SF6');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `ghg_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Quantity in Tonnes');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `global_warming_potential` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `measurement_uncertainty_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty Percentage');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `net_emission_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Net Emission Carbon Dioxide Equivalent (CO2e) in Tonnes');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `quantification_methodology` SET TAGS ('dbx_business_glossary_term' = 'Quantification Methodology');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `quantification_methodology` SET TAGS ('dbx_value_regex' = 'direct_measurement|emission_factor|mass_balance|engineering_estimate|default_factor|continuous_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `scope_classification` SET TAGS ('dbx_business_glossary_term' = 'Scope Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `scope_classification` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|third_party_verified|pending_verification');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `charter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Incident Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `pipeline_throughput_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Throughput Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `port_call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Response Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `tertiary_spill_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `tertiary_spill_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `tertiary_spill_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `truck_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `bsee_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Notification Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `bsee_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `cleanup_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Completion Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `cleanup_method` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `cleanup_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `confirmed_volume_barrels` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `containment_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Containment Actions Taken');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `environmental_impact_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Completed');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `estimated_cleanup_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cleanup Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `estimated_cleanup_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `estimated_volume_barrels` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `impacted_area_extent_acres` SET TAGS ('dbx_business_glossary_term' = 'Impacted Area Extent (Acres)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `nrc_notification_required` SET TAGS ('dbx_business_glossary_term' = 'National Response Center (NRC) Notification Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `nrc_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'National Response Center (NRC) Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `nrc_report_number` SET TAGS ('dbx_business_glossary_term' = 'National Response Center (NRC) Report Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `onshore_offshore_indicator` SET TAGS ('dbx_business_glossary_term' = 'Onshore or Offshore Indicator');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `onshore_offshore_indicator` SET TAGS ('dbx_value_regex' = 'onshore|offshore|coastal|inland_water');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `receiving_environment` SET TAGS ('dbx_business_glossary_term' = 'Receiving Environment');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `regulatory_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `release_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Release Cause Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `release_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Release Cause Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|monitoring|completed|regulatory_approved');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Spill Discovery Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_latitude` SET TAGS ('dbx_business_glossary_term' = 'Spill Location Latitude');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_location_description` SET TAGS ('dbx_business_glossary_term' = 'Spill Location Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_longitude` SET TAGS ('dbx_business_glossary_term' = 'Spill Location Longitude');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Spill Occurrence Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Spill Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_status` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `state_agency_notification_required` SET TAGS ('dbx_business_glossary_term' = 'State Agency Notification Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `state_agency_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'State Agency Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `uscg_notification_required` SET TAGS ('dbx_business_glossary_term' = 'United States Coast Guard (USCG) Notification Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `uscg_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'United States Coast Guard (USCG) Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `volume_recovered_barrels` SET TAGS ('dbx_business_glossary_term' = 'Volume Recovered (Barrels)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'barrels|gallons|liters|cubic_meters|pounds|kilograms');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `wildlife_impact_reported` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Impact Reported');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `h2s_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Monitoring ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `detector_id` SET TAGS ('dbx_business_glossary_term' = 'Detector Equipment ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `simops_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Plan ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `alarm_level` SET TAGS ('dbx_business_glossary_term' = 'Alarm Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `alarm_level` SET TAGS ('dbx_value_regex' = 'none|low|high|ceiling|idlh');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `alarm_threshold_breached` SET TAGS ('dbx_business_glossary_term' = 'Alarm Threshold Breached Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `all_clear_timestamp` SET TAGS ('dbx_business_glossary_term' = 'All Clear Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Detector Calibration Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Detector Calibration Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `detector_status` SET TAGS ('dbx_business_glossary_term' = 'Detector Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `detector_status` SET TAGS ('dbx_value_regex' = 'operational|fault|maintenance|calibration_overdue|offline');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `detector_type` SET TAGS ('dbx_business_glossary_term' = 'Detector Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `detector_type` SET TAGS ('dbx_value_regex' = 'fixed_electrochemical|portable_personal_monitor|fixed_infrared|portable_colorimetric|area_monitor');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `evacuation_initiated` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Initiated Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `evacuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `h2s_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Concentration in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity Percentage');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `monitoring_location` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `muster_station_activated` SET TAGS ('dbx_business_glossary_term' = 'Muster Station Activated Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `personnel_count_evacuated` SET TAGS ('dbx_business_glossary_term' = 'Personnel Count Evacuated');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `personnel_count_onsite` SET TAGS ('dbx_business_glossary_term' = 'Personnel Count On-Site');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `response_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Response Action Taken');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature in Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `wind_direction_degrees` SET TAGS ('dbx_business_glossary_term' = 'Wind Direction in Degrees');
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed in Miles Per Hour (MPH)');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `norm_record_id` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Record ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `activity_level_unit` SET TAGS ('dbx_business_glossary_term' = 'Activity Level Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `activity_level_unit` SET TAGS ('dbx_value_regex' = 'pci_per_g|bq_per_kg|pci_per_l|bq_per_l');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `activity_level_value` SET TAGS ('dbx_business_glossary_term' = 'Activity Level Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `decontamination_date` SET TAGS ('dbx_business_glossary_term' = 'Decontamination Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `decontamination_method` SET TAGS ('dbx_business_glossary_term' = 'Decontamination Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `decontamination_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Decontamination Performed Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'routine_survey|maintenance_inspection|decommissioning_survey|incident_investigation|regulatory_inspection');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `disposal_facility_license_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility License Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `disposal_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `disposal_manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Manifest Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'licensed_disposal_facility|onsite_storage|exempt_landfill|recycling|decontamination|pending');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `handling_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Handling Procedure Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `laboratory_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `norm_classification` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `norm_classification` SET TAGS ('dbx_value_regex' = 'below_regulatory_threshold|above_regulatory_threshold|exempt|licensed_material');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `norm_record_number` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Record Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `norm_source_description` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Source Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `norm_source_type` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Source Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `norm_source_type` SET TAGS ('dbx_value_regex' = 'pipe_scale|vessel_deposits|produced_water_sludge|drilling_mud|completion_fluids|equipment_surface_contamination');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `post_decontamination_activity_level` SET TAGS ('dbx_business_glossary_term' = 'Post-Decontamination Activity Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `radionuclide_type` SET TAGS ('dbx_business_glossary_term' = 'Radionuclide Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempted');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `regulatory_report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `regulatory_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Exceeded Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `waste_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Waste Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `waste_volume_unit` SET TAGS ('dbx_value_regex' = 'cubic_feet|cubic_meters|gallons|barrels|liters');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `waste_volume_value` SET TAGS ('dbx_business_glossary_term' = 'Waste Volume Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `waste_weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Waste Weight Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `waste_weight_unit` SET TAGS ('dbx_value_regex' = 'pounds|kilograms|tons|metric_tons');
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ALTER COLUMN `waste_weight_value` SET TAGS ('dbx_business_glossary_term' = 'Waste Weight Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `detector_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Detector Instrument ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_station_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Station ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampled By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `ambient_temperature` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `barometric_pressure` SET TAGS ('dbx_business_glossary_term' = 'Barometric Pressure');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `compliance_program` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `detector_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Detector Instrument Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `evacuation_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Event Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `laboratory_analysis_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `laboratory_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_frequency_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `muster_station_activation_flag` SET TAGS ('dbx_business_glossary_term' = 'Muster Station Activation Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `parameter_measured` SET TAGS ('dbx_business_glossary_term' = 'Parameter Measured');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `permit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `pressure_unit` SET TAGS ('dbx_business_glossary_term' = 'Pressure Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `pressure_unit` SET TAGS ('dbx_value_regex' = 'mbar|inHg|kPa|psi');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `regulatory_limit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `regulatory_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `relative_humidity` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sample_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sampled_by_name` SET TAGS ('dbx_business_glossary_term' = 'Sampled By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_value_regex' = 'celsius|fahrenheit|kelvin');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `wind_direction` SET TAGS ('dbx_business_glossary_term' = 'Wind Direction');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `wind_speed` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `wind_speed_unit` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `wind_speed_unit` SET TAGS ('dbx_value_regex' = 'm/s|mph|km/h|knots');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `charter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `original_submission_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `pipeline_throughput_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Throughput Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `port_call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `tertiary_regulatory_submitted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `tertiary_regulatory_submitted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `tertiary_regulatory_submitted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `truck_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `acknowledgment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|not_acknowledged|rejected|accepted_with_conditions');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Agency Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `attachments_count` SET TAGS ('dbx_business_glossary_term' = 'Attachments Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Email Address');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Phone Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `correction_reason` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `facility_epa_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Environmental Protection Agency (EPA) Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `late_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `resubmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_description` SET TAGS ('dbx_business_glossary_term' = 'Submission Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|web_portal|email|fax|certified_mail');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_portal_name` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'OSHA 300A Annual Summary|EPA Tier II Chemical Inventory|EPA GHG Annual Report|BSEE Incident Report|NRC NORM Report|State Spill Notification');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submitted_by_name` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `hse_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `hse_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Corrective Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `previous_training_hse_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Training ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `tertiary_hse_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `tertiary_hse_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `tertiary_hse_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `competency_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Result');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `competency_assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_assessed');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'h2s_awareness|confined_space_entry|fire_fighting|hazwoper|norm_handling|bop_safety');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|e_learning|on_the_job|blended|simulation|field_exercise');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `instructor_certification` SET TAGS ('dbx_business_glossary_term' = 'Instructor Certification');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `language_of_instruction` SET TAGS ('dbx_business_glossary_term' = 'Language of Instruction');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `refresher_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Refresher Frequency Months');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `refresher_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refresher Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_course_name` SET TAGS ('dbx_business_glossary_term' = 'Training Course Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Provided');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_provider_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Accreditation');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|cancelled|expired');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ALTER COLUMN `work_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `feedstock_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `activity_level_bq_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Activity Level (Becquerels per Kilogram)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `activity_level_pci_per_g` SET TAGS ('dbx_business_glossary_term' = 'Activity Level (Picocuries per Gram)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `average_daily_quantity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Quantity (Pounds)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `carcinogen_classification` SET TAGS ('dbx_business_glossary_term' = 'Carcinogen Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `chemical_family` SET TAGS ('dbx_business_glossary_term' = 'Chemical Family');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `emergency_response_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedure');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `epa_cercla_reportable_quantity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Comprehensive Environmental Response, Compensation, and Liability Act (CERCLA) Reportable Quantity (Pounds)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `exposure_limit_mg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit (Milligrams per Cubic Meter)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `exposure_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `flash_point_f` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Pictogram Codes');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `maximum_daily_quantity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Quantity (Pounds)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `nfpa_704_flammability_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) 704 Flammability Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `nfpa_704_health_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) 704 Health Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `nfpa_704_health_rating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `nfpa_704_health_rating` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `nfpa_704_instability_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) 704 Instability Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `nfpa_704_special_hazard` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) 704 Special Hazard');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `norm_classification` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `norm_classification` SET TAGS ('dbx_value_regex' = 'non_norm|norm_exempt|norm_regulated|norm_licensed');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `osha_hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Hazard Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `phmsa_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Hazard Class');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|vapor|aerosol|mixture');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `radionuclide_type` SET TAGS ('dbx_business_glossary_term' = 'Radionuclide Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `sara_title_iii_section_313_flag` SET TAGS ('dbx_business_glossary_term' = 'Superfund Amendments and Reauthorization Act (SARA) Title III Section 313 Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `sara_title_iii_tier_ii_threshold_lbs` SET TAGS ('dbx_business_glossary_term' = 'Superfund Amendments and Reauthorization Act (SARA) Title III Tier II Threshold (Pounds)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `sds_manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Manufacturer Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `storage_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `substance_status` SET TAGS ('dbx_business_glossary_term' = 'Substance Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `substance_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|restricted|banned');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ALTER COLUMN `waste_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `chemical_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Inventory ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `average_daily_quantity` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Quantity');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `confidential_location_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Location Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `ehs_flag` SET TAGS ('dbx_business_glossary_term' = 'Extremely Hazardous Substance (EHS) Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `fire_department_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Fire Department Submitted Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `hazard_category` SET TAGS ('dbx_value_regex' = 'fire|sudden_release_pressure|reactive|immediate_acute|delayed_chronic');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `health_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `health_hazard_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `health_hazard_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `inventory_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Inventory Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `inventory_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|depleted|transferred|disposed');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `last_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `lepc_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Local Emergency Planning Committee (LEPC) Submitted Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `maximum_daily_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Quantity');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `mixture_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixture Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `physical_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Physical Hazard Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|liquefied_gas');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `product_identifier` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'pounds|gallons|kilograms|liters|barrels');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `regulatory_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `reporting_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Exceeded Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `sds_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `serc_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'State Emergency Response Commission (SERC) Submitted Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `storage_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ALTER COLUMN `storage_type` SET TAGS ('dbx_value_regex' = 'above_ground_tank|underground_tank|container|drum|tote|cylinder');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Risk Assessment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `primary_safety_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Observer ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `primary_safety_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `primary_safety_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `tertiary_safety_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `tertiary_safety_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `tertiary_safety_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `attachments_count` SET TAGS ('dbx_business_glossary_term' = 'Attachments Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `bbs_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Behavior-Based Safety (BBS) Program Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `closure_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Closure Verification Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `follow_up_action_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_description` SET TAGS ('dbx_business_glossary_term' = 'Observation Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_number` SET TAGS ('dbx_business_glossary_term' = 'Observation Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_value_regex' = 'open|under_review|action_assigned|closed|cancelled');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_value_regex' = 'unsafe_act|unsafe_condition|near_miss|positive_observation|stop_work_authority|hazard_identification');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_business_glossary_term' = 'Observer Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_business_glossary_term' = 'Observer Role');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `permit_to_work_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `risk_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Likelihood Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `risk_likelihood_rating` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `risk_matrix_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Matrix Score');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `risk_severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `risk_severity_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `stop_work_authority_exercised` SET TAGS ('dbx_business_glossary_term' = 'Stop Work Authority Exercised Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ALTER COLUMN `work_activity` SET TAGS ('dbx_business_glossary_term' = 'Work Activity');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` SET TAGS ('dbx_subdomain' = 'risk_assessment');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event (PSE) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `consequence_category` SET TAGS ('dbx_business_glossary_term' = 'Consequence Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `consequence_category` SET TAGS ('dbx_value_regex' = 'Injury|Fatality|Environmental|Property Damage|Production Loss|Near Miss');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `equipment_involved` SET TAGS ('dbx_business_glossary_term' = 'Equipment Involved');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `esg_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Confirmed|Closed|Cancelled');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'LOPC|Fire|Explosion|Toxic Release|Overpressure|Runaway Reaction');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `fatality_count` SET TAGS ('dbx_business_glossary_term' = 'Fatality Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `ignition_source` SET TAGS ('dbx_business_glossary_term' = 'Ignition Source');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `immediate_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `lopc_flag` SET TAGS ('dbx_business_glossary_term' = 'Loss of Primary Containment (LOPC) Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `process_unit` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `production_loss_boe` SET TAGS ('dbx_business_glossary_term' = 'Production Loss (Barrel of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `production_loss_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `property_damage_usd` SET TAGS ('dbx_business_glossary_term' = 'Property Damage (USD)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `property_damage_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `pse_number` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event (PSE) Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `pse_tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event (PSE) Tier Classification');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `pse_tier_classification` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `release_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Release Duration (Minutes)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `release_rate` SET TAGS ('dbx_business_glossary_term' = 'Release Rate');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `release_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Release Rate Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `release_rate_unit` SET TAGS ('dbx_value_regex' = 'BBL/HR|LBS/MIN|KG/SEC|MSCF/HR');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `release_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Release Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `safety_system_demand_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety System Demand Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `safety_system_involved` SET TAGS ('dbx_business_glossary_term' = 'Safety System Involved');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `safety_system_response` SET TAGS ('dbx_business_glossary_term' = 'Safety System Response');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `safety_system_response` SET TAGS ('dbx_value_regex' = 'Responded as Designed|Partial Response|Failed to Respond|Not Applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `sec_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Miles Per Hour)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` SET TAGS ('dbx_subdomain' = 'risk_assessment');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `quaternary_emergency_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `quaternary_emergency_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `quaternary_emergency_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `quinary_emergency_plan_owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `tertiary_emergency_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `tertiary_emergency_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `tertiary_emergency_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `discharge_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Discharge Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `discharge_volume_unit` SET TAGS ('dbx_value_regex' = 'BBL|GAL|M3|L');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `drill_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Compliance Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `drill_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|overdue|upcoming|not applicable');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `drill_frequency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Drill Frequency Requirement');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `drill_frequency_requirement` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiration Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drill Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `mutual_aid_agreements` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Agreements');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `next_drill_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Drill Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `oil_spill_response_organization` SET TAGS ('dbx_business_glossary_term' = 'Oil Spill Response Organization (OSRO)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'offshore platform|onshore facility|drilling rig|refinery|pipeline|storage terminal');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document URL');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Scope Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under review|approved|active|expired|superseded');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Title');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'oil spill response plan|facility emergency response plan|well control emergency plan|offshore emergency evacuation plan|fire emergency response plan|H2S emergency response plan');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'BSEE|EPA|USCG|OSHA|state agency');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `response_time_objective_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Objective (Hours)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `worst_case_discharge_volume` SET TAGS ('dbx_business_glossary_term' = 'Worst Case Discharge Volume');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` SET TAGS ('dbx_subdomain' = 'risk_assessment');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `emergency_drill_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Coordinator ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `quaternary_emergency_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `quaternary_emergency_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `quaternary_emergency_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `tertiary_emergency_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `tertiary_emergency_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `tertiary_emergency_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `communication_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Communication Effectiveness Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `communication_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `corrective_actions_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `deficiencies_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Identified Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `deficiencies_summary` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Summary');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Drill Coordinator Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_date` SET TAGS ('dbx_business_glossary_term' = 'Drill Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Drill Duration Minutes');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Drill End Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_number` SET TAGS ('dbx_business_glossary_term' = 'Drill Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Drill Report Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Drill Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `drill_type` SET TAGS ('dbx_value_regex' = 'fire_drill|h2s_evacuation|oil_spill_response|well_control|man_overboard|muster_drill');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `equipment_deployed` SET TAGS ('dbx_business_glossary_term' = 'Equipment Deployed');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `equipment_performance_notes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Performance Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `external_agencies_involved` SET TAGS ('dbx_business_glossary_term' = 'External Agencies Involved');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `muster_completion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Muster Completion Time Minutes');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `next_drill_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Drill Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `observers_present` SET TAGS ('dbx_business_glossary_term' = 'Observers Present');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `participants_count` SET TAGS ('dbx_business_glossary_term' = 'Participants Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `personnel_accounted_count` SET TAGS ('dbx_business_glossary_term' = 'Personnel Accounted Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `regulatory_compliance_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Met Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Minutes');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `strengths_identified` SET TAGS ('dbx_business_glossary_term' = 'Strengths Identified');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `target_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Response Time Minutes');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `waste_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Manifest ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `generator_facility_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petchem Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `disposal_facility_epa_code` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Environmental Protection Agency (EPA) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `disposal_facility_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Permit Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `disposal_facility_signature` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Signature');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `disposal_facility_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Signature Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `dot_proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Proper Shipping Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `dot_un_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `generator_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Generator Certification Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `generator_certification_signature` SET TAGS ('dbx_business_glossary_term' = 'Generator Certification Signature');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `h2s_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Concentration Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `manifest_type` SET TAGS ('dbx_business_glossary_term' = 'Manifest Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `manifest_type` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|universal_waste|norm|mixed');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `norm_activity_level` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Activity Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `norm_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `rcra_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Waste Code');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Rejection Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `state_manifest_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'State Manifest Tracking Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `transporter_dot_registration` SET TAGS ('dbx_business_glossary_term' = 'Transporter Department of Transportation (DOT) Registration');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `transporter_epa_code` SET TAGS ('dbx_business_glossary_term' = 'Transporter Environmental Protection Agency (EPA) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `transporter_signature` SET TAGS ('dbx_business_glossary_term' = 'Transporter Signature');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `transporter_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Transporter Signature Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `waste_characterization_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Characterization Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `waste_characterization_method` SET TAGS ('dbx_value_regex' = 'laboratory_analysis|generator_knowledge|msds|process_knowledge|field_test');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `waste_profile_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `waste_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_id` SET TAGS ('dbx_business_glossary_term' = 'Objective Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_responsible_owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `primary_objective_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `primary_objective_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `primary_objective_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'HSE Achievement Percentage');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `action_plan_summary` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Summary');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'HSE Baseline Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'HSE Baseline Year');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `current_value` SET TAGS ('dbx_business_glossary_term' = 'HSE Current Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `last_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'HSE Last Measurement Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `management_review_required` SET TAGS ('dbx_business_glossary_term' = 'Management Review Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'HSE Measurement Frequency');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_category` SET TAGS ('dbx_business_glossary_term' = 'HSE Objective Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_description` SET TAGS ('dbx_business_glossary_term' = 'HSE Objective Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_number` SET TAGS ('dbx_business_glossary_term' = 'HSE Objective Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_status` SET TAGS ('dbx_business_glossary_term' = 'HSE Objective Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_type` SET TAGS ('dbx_business_glossary_term' = 'HSE Objective Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `objective_type` SET TAGS ('dbx_value_regex' = 'safety|environmental|health|compliance|esg');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `organizational_level` SET TAGS ('dbx_business_glossary_term' = 'HSE Organizational Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `organizational_level` SET TAGS ('dbx_value_regex' = 'corporate|business_unit|facility|department');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `strategic_alignment` SET TAGS ('dbx_business_glossary_term' = 'Strategic Alignment');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `supporting_team_members` SET TAGS ('dbx_business_glossary_term' = 'Supporting Team Members');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'HSE Target Metric');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'HSE Target Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `target_year` SET TAGS ('dbx_business_glossary_term' = 'HSE Target Year');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'HSE Objective Title');
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'HSE Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_assessment');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Assessment ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `primary_hse_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Facilitator ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `primary_hse_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `primary_hse_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `tertiary_hse_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `tertiary_hse_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `tertiary_hse_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `wildcat_well_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Wildcat Well Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `achievement_status` SET TAGS ('dbx_business_glossary_term' = 'Achievement Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `achievement_status` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|achieved|not_achieved|deferred');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report Uniform Resource Locator (URL)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|under_review|closed');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('dbx_business_glossary_term' = 'Assessment Team Members');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'HAZID|HAZOP|JSA|Bow-Tie|QRA|FERA');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `hazards_identified` SET TAGS ('dbx_business_glossary_term' = 'Hazards Identified');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `lead_facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Facilitator Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `objective_description` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Objective Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `operation_assessed` SET TAGS ('dbx_business_glossary_term' = 'Operation Assessed');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `ptw_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `responsible_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `risk_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `risk_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|not_accepted|conditional|pending_review');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `risk_matrix_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Matrix Score');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `risk_reduction_measures` SET TAGS ('dbx_business_glossary_term' = 'Risk Reduction Measures');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ALTER COLUMN `target_year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `quaternary_management_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `quaternary_management_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `quaternary_management_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `tertiary_management_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `tertiary_management_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `tertiary_management_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `previous_moc_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `approval_required_roles` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Roles');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|partial|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'process_technology|equipment|procedure|facility|organizational|software');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'temporary|permanent|emergency');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `drawing_update_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drawing Update Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `drawing_update_status` SET TAGS ('dbx_business_glossary_term' = 'Drawing Update Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `drawing_update_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `hazard_evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Hazard Evaluation Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `initiating_department` SET TAGS ('dbx_business_glossary_term' = 'Initiating Department');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `moc_status` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `procedure_update_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Procedure Update Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `procedure_update_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Update Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `procedure_update_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `process_unit` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `pssr_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Startup Safety Review (PSSR) Completion Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `pssr_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Startup Safety Review (PSSR) Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `pssr_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Startup Safety Review (PSSR) Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `pssr_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|approved');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `ptw_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `risk_matrix_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Matrix Score');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `temporary_change_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Temporary Change Expiration Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed');
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` SET TAGS ('dbx_association_edges' = 'hse.ldar_survey,hse.ldar_component');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `ldar_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'LDAR Inspection ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `ldar_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Ldar Inspection - Hse Ldar Survey Id');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `ldar_component_id` SET TAGS ('dbx_business_glossary_term' = 'Ldar Inspection - Ldar Component Id');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `component_condition_observed` SET TAGS ('dbx_business_glossary_term' = 'Component Condition');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `inspection_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Sequence Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `inspector_comments` SET TAGS ('dbx_business_glossary_term' = 'Inspector Comments');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `leak_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detected');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `measured_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `repair_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Repair Completion Date');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `repair_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Repair Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` SET TAGS ('dbx_association_edges' = 'hse.incident,hse.hazardous_substance');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `incident_substance_involvement_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Substance Involvement ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Substance Involvement - Hazardous Substance Id');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Substance Involvement - Incident Id');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `containment_method` SET TAGS ('dbx_business_glossary_term' = 'Containment Method');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `exposure_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Exposure Duration Minutes');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `exposure_level_ppm` SET TAGS ('dbx_business_glossary_term' = 'Exposure Level PPM');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `involvement_type` SET TAGS ('dbx_business_glossary_term' = 'Involvement Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `lopc_quantity` SET TAGS ('dbx_business_glossary_term' = 'Loss of Primary Containment (LOPC) Quantity');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `lopc_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Loss of Primary Containment (LOPC) Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `lopc_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BBL|MCF|LBS|KG|GAL|L');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `personnel_exposed_count` SET TAGS ('dbx_business_glossary_term' = 'Personnel Exposed Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `ppe_used` SET TAGS ('dbx_business_glossary_term' = 'PPE Used');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `quantity_released` SET TAGS ('dbx_business_glossary_term' = 'Quantity Released');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `regulatory_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Exceeded Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ALTER COLUMN `release_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Release Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ALTER COLUMN `monitoring_station_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Station Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ALTER COLUMN `parent_monitoring_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ALTER COLUMN `maintenance_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ALTER COLUMN `maintenance_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector_instrument` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector_instrument` ALTER COLUMN `detector_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Detector Instrument Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector_instrument` ALTER COLUMN `parent_detector_instrument_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector` ALTER COLUMN `detector_id` SET TAGS ('dbx_business_glossary_term' = 'Detector Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`detector` ALTER COLUMN `parent_detector_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `installation_location_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Location Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `parent_installation_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`hse`.`installation_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
