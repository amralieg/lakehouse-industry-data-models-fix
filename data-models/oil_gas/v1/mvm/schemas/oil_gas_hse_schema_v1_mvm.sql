-- Schema for Domain: hse | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`hse` COMMENT 'Manages Health, Safety, and Environment (HSE) compliance including incident reporting, permit-to-work (PTW), SIMOPS coordination, LDAR programs, NORM handling, H2S monitoring, GHG and ESG emissions tracking, spill reporting, environmental monitoring, and audit findings. Supports OSHA, EPA, BSEE, ISO 14001, and ISO 45001 regulatory compliance. Integrates with Enablon HSE Management for audit and compliance workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the HSE incident record. Primary key for the incident entity.',
    `asset_id` BIGINT COMMENT 'Reference to the specific asset or equipment involved in the incident. Links to Maximo Asset Management CMMS for equipment history and maintenance records.',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Incidents on exploration blocks must be reported to the blocks licensing authority and regulatory body. Incident statistics are tracked per block for license compliance, JV partner reporting, and min',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Incidents involving carriers reference carrier for vetting and performance scoring. Essential for carrier approval and contract renewal.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Incidents tracked by legal entity for statutory reporting, regulatory compliance, insurance claims, and SEC disclosure requirements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Incident costs (investigation, remediation, lost production) must be allocated to cost centers for HSE budget tracking and variance analysis. Standard oil-and-gas practice for incident cost accounting',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Incidents at facilities where customers take delivery or have operational presence must track the involved customer account for liability determination, insurance claims, and relationship management. ',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Incidents occurring at delivery points (terminals, loading facilities, custody transfer points) must be tracked to the specific location for safety performance reporting, regulatory compliance, and op',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Incident costs posted to specific GL accounts for financial reporting, cost tracking, and HSE budget management.',
    `injection_well_id` BIGINT COMMENT 'Foreign key linking to production.injection_well. Business justification: Incidents at injection well sites (H2S exposure, mechanical failures, injection pressure exceedances causing surface events) must be tracked against the injection well for OSHA recordkeeping and UIC r',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Incidents occur on leased properties; regulatory reporting, liability determination, lease compliance verification, and lessor notification obligations require linking incidents to the specific lease.',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Incidents during nominated lifting operations (vessel loading, pipeline delivery) must be linked to the specific nomination for operational analysis, customer notification, and impact assessment on de',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Incidents often occur during permitted work activities; linking incident to PTW enables analysis of work-related incidents. Business reality: PTW violations or inadequate hazard controls during permit',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: HSE incidents (injuries, near-misses, environmental releases) at production facilities must be tracked against the facility for OSHA recordkeeping, BSEE reporting, and facility-level safety performanc',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Well-specific incidents (blowouts, well control events, wellhead injuries) must be linked to the production well for BSEE/state regulatory reporting, well safety performance tracking, and insurance cl',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Incidents tracked by profit center for P&L impact analysis, HSE performance metrics, and management reporting. Standard oil & gas operational reporting.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Incidents on projects tracked for project management, risk assessment, schedule impact, and HSE performance reporting.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Pre-drilling incidents during seismic acquisition, site surveys, or geotechnical work occur at prospect locations. Links incident to exploration target for risk profiling, future drilling hazard asses',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Incidents under PSA operations trigger government notification requirements, regulatory reporting obligations, and potential impact on cost recovery and profit oil calculations per production sharing ',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: BSEE/OSHA incident reporting requires tracking which rig an incident occurred on. Rig-level HSE performance scorecards and contractor safety audits depend on this link. Domain experts expect every dri',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Incidents on ROW trigger specific reporting to ROW grantors, may affect ROW agreement terms, and require ROW-specific response protocols. Critical for grantor relations and ROW agreement compliance.',
    `seismic_survey_id` BIGINT COMMENT 'Foreign key linking to exploration.seismic_survey. Business justification: HSE incidents during seismic acquisition campaigns (crew injuries, equipment fires, vessel accidents) must reference the seismic survey in progress. Incident reports filed with regulators and acquisit',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Incidents at terminals reference terminal for facility safety records. Essential for OSHA reporting and operational approval.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Incidents occur on specific tracts; environmental impact assessments, surface owner notifications, geographic incident analysis, and tract-level remediation tracking require tract identification. Esse',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Incidents involve specific partner personnel, assets, or operations; partner identification is required for liability determination, insurance claims processing, regulatory reporting, and JIB cost all',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Incidents often result in regulatory violations. Linking incidents to violations supports enforcement response tracking, penalty management, and corrective action verification required by regulatory a',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Incidents on capital projects tracked to WBS for project cost management, schedule impact analysis, and partner billing.',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Investigation costs tracked by legal entity for statutory financial reporting, tax deductions, and legal liability management.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Root cause analysis of incidents involving contracted services/equipment requires contract reference to assess vendor obligations, scope compliance, HSE requirements adherence, and determine liability',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Investigation costs (investigation_cost_usd field present) require cost center allocation for HSE compliance budget management. Essential for tracking investigation expenses against facility/business ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Investigations analyze equipment failures beyond facility level. Equipment-specific link needed for failure mode analysis, barrier diagram development, and integration with asset reliability database ',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Incident investigations on capital projects track costs to AFE for cost recovery, capital allocation, and JOA billing. Standard oil & gas practice for project-related incidents.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Investigation costs posted to GL accounts for financial reporting, budget tracking, and cost analysis by investigation type.',
    `incident_id` BIGINT COMMENT 'Reference to the parent HSE incident that triggered this investigation. Links to the incident record in the HSE incident management system.',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to venture.operating_committee. Business justification: Major incident investigations (fatalities, Tier 1 PSEs, significant spills) are presented to operating committees per JOA HSE governance requirements. Operating committee reviews investigation finding',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Investigation costs allocated to profit center for financial reporting, budget management, and HSE cost analysis by business unit.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Investigation costs allocated to project for budget management, cost tracking, and project performance analysis.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Incident investigations generate regulatory reports submitted to agencies (OSHA 300 logs, BSEE incident reports, CSB notifications). incident_investigation has regulatory_report_submitted and regulato',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Investigations identify violations through root cause analysis. Linking investigation findings to formal violation records supports regulatory response, corrective action planning, and enforcement doc',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Investigation costs charged to WBS for project cost tracking, budget management, and capital project reporting.',
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
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: CAPAs arise from audit findings (per product description). Linking hse_corrective_action directly to the audit that generated it enables audit closure tracking, corrective action plan due date monitor',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Corrective action costs tracked by legal entity for statutory reporting, tax deductions, and compliance cost management.',
    `consent_order_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_order. Business justification: Consent orders mandate specific corrective actions with deadlines. Linking actions to consent orders supports milestone tracking, penalty avoidance, regulatory reporting, and demonstrates fulfillment ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Corrective actions from incidents/audits often require contract amendments, vendor-executed remediation, or procurement of replacement equipment. Contract reference enables enforcement of vendor oblig',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Corrective actions have cost_estimate and actual_cost fields requiring cost center allocation for HSE improvement budget tracking. Standard practice for tracking corrective action expenditures against',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Corrective actions often target specific equipment (replace PRV, upgrade SIS logic solver). Equipment FK required for automatic work order generation in CMMS, equipment modification history tracking, ',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Corrective actions on capital projects charged to AFE for cost tracking, budget management, and partner billing. Essential for capital project HSE cost allocation.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Corrective actions on fixed assets tracked for asset integrity management, maintenance cost allocation, and asset retirement planning.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Corrective action costs posted to GL accounts for financial reporting, budget management, and HSE cost analysis.',
    `incident_id` BIGINT COMMENT 'Foreign key reference to the HSE incident record if this corrective action arose from an incident investigation.',
    `incident_investigation_id` BIGINT COMMENT 'Foreign key linking to hse.incident_investigation. Business justification: CAPAs frequently arise directly from incident investigations. Linking hse_corrective_action to the specific incident_investigation that generated it provides full traceability from root cause analysis',
    `ldar_survey_id` BIGINT COMMENT 'Foreign key linking to hse.ldar_survey. Business justification: LDAR surveys with detected leaks (leaks_detected_count > 0) require corrective actions for repair. ldar_survey has corrective_actions_required and corrective_action_deadline_date fields indicating thi',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Corrective actions addressing lease-specific HSE deficiencies require lease context; lease compliance corrective actions, lessor notifications, and lease-specific remediation tracking. Essential for l',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Corrective actions fulfill ongoing compliance obligations (e.g., LDAR program requirements, permit conditions). Linking actions to obligations supports obligation tracking, compliance calendar managem',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline integrity corrective actions (coating repair, cathodic protection upgrade, inline inspection anomaly remediation) require segment-level tracking for integrity management plan compliance, regu',
    `previous_action_hse_corrective_action_id` BIGINT COMMENT 'Foreign key reference to a prior corrective action record if this action is addressing a recurrence or follow-up to an earlier ineffective action.',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Process safety events (Tier 1/Tier 2 PSEs) generate corrective and preventive actions as part of the PSM (Process Safety Management) program. Linking hse_corrective_action to the originating process_s',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Corrective action costs allocated to profit center for P&L reporting, budget tracking, and HSE performance management by business unit.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Corrective actions on projects tracked for cost management, schedule impact, and project HSE performance.',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Spill events generate remediation and corrective actions (cleanup, source repair, containment improvements). Linking hse_corrective_action to the originating spill_event enables spill remediation trac',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Corrective actions from vessel inspections reference vessel for approval status and vetting improvement.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: HSE corrective actions are mandated by violations. Linking actions to violations supports closure verification, regulatory reporting, penalty mitigation, and demonstrates compliance with enforcement o',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Corrective actions on projects tracked to WBS for cost management, schedule impact, and project performance reporting.',
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
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Work permits for maintenance, inspection, or modification activities at delivery points (terminals, loading arms, metering stations) must be tracked to the specific location for HSE compliance and coo',
    `equipment_id` BIGINT COMMENT 'Identifier of the calibrated gas detection instrument used for atmospheric testing. Ensures traceability and compliance with calibration requirements.',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Permits to work issued for well operations (drilling, completion, testing, workover) must reference the specific well. Critical for operational control, regulatory compliance (MMS/BSEE), and linking P',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Permits issued for AFE-funded work (drilling, construction, major maintenance) require AFE linkage for cost tracking and capital vs. opex classification.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOAs mandate HSE standards and work authorization protocols for joint operations; permit issuance, approval authority, and associated costs are governed by JOA HSE provisions and overhead allocation.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Work permits on leased properties must verify lease terms allow the activity; lease restrictions, depth limitations, and operational constraints govern permissible work. Land department reviews permit',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Permit-to-work systems specify the petroleum product being handled to determine appropriate safety controls, gas testing requirements (LEL, H2S, benzene), PPE specifications, and isolation procedures.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Hot work, excavation, and maintenance permits on pipelines require segment identification for isolation planning, SIMOPS coordination with adjacent segments, and emergency response planning. Critical ',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Permits issued for project work tracked for project management, schedule coordination, and HSE compliance.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Work permits must reference authorizing regulatory permits (air, water, operating) to ensure activities comply with permit conditions. Critical for demonstrating regulatory compliance during work exec',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: PTWs for hot work, confined space entry, and critical lifts on drilling rigs must reference the specific rig. Rig-level PTW management is a fundamental operational safety control required by BSEE and ',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Permits must comply with surface use agreement terms; agreement restrictions, access rights, permitted activities, and compensation triggers are verified during permit issuance. Critical for surface o',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Permits to work are frequently issued to contractor vendors performing maintenance, construction, or specialized services at facilities. Tracking which vendor holds each PTW is essential for contracto',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Permits for project work tracked to WBS for cost allocation, schedule management, and project reporting.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: HSE audits of exploration block operations are required by exploration licenses and JOA agreements. Audit findings tied to specific blocks drive license compliance ratings, JV partner reporting, and r',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Audits conducted at legal entity level for statutory compliance, regulatory reporting, and corporate governance requirements.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: HSE audits of contracted operations require contract reference to assess vendor compliance with contractual HSE requirements, performance standards, certification obligations, and insurance provisions',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: HSE audit costs (internal labor, external consultants, travel) must be allocated to cost centers for compliance program budget management. Required for tracking audit program expenses in oil-and-gas r',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: HSE audits include assessment of emergency response plans and drill compliance (ISO 14001, ISO 45001, BSEE requirements). Linking audit to the emergency_response_plan being assessed enables ERP audit ',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: HSE audits of capital projects (facility construction, well drilling) track to AFE for compliance verification and cost allocation of audit findings.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Audit costs posted to GL accounts for financial reporting, budget tracking, and compliance cost management.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOA audit rights clauses mandate HSE audit frequency, scope, and cost allocation; partners exercise contractual audit rights to verify operator HSE compliance and joint account charge appropriateness.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Audits verify compliance with specific obligations. Linking audits to obligations supports compliance calendar management, audit planning, obligation fulfillment verification, and demonstrates due dil',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to venture.operating_committee. Business justification: Operating committees review and approve HSE audit findings, corrective action plans, and budget implications per JOA governance. Major audit findings require operating committee approval before implem',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: HSE audits are frequently conducted in response to or in review of process safety events (PSM audits, BSEE inspections post-PSE). Linking audit to the process_safety_event being investigated enables P',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: HSE audits (ISO 14001, OSHA PSM, API RP 75, BSEE SEMS) are conducted at production facilities. Linking audit to production_facility enables facility-level audit program management, compliance rating t',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Audit findings and costs tracked by profit center for performance management, compliance reporting, and management accountability.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Project audits tracked for compliance verification, cost management, and project performance assessment.',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: HSE audits conducted by regulatory bodies (BSEE, EPA, OSHA) are the same events as compliance regulatory audits. Enables unified audit management across operational and compliance perspectives for enf',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: HSE audits are routinely conducted on specific drilling rigs — BSEE rig inspections, ISM audits, and contractor HSE audits. Linking audit to rig enables rig safety performance trending, certification ',
    `seismic_survey_id` BIGINT COMMENT 'Foreign key linking to exploration.seismic_survey. Business justification: HSE audits of seismic acquisition contractors are conducted mid-survey and post-survey to verify compliance with acquisition contract HSE requirements, permit conditions, and environmental management ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: HSE audits are conducted on vendor facilities and operations as part of pre-qualification, periodic vendor assessments, and contractor HSE performance reviews. This link enables tracking vendor-specif',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Project audits tracked to WBS for cost allocation, compliance verification, and project performance management.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`ldar_survey` (
    `ldar_survey_id` BIGINT COMMENT 'Primary key for ldar_survey',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: LDAR surveys tracked by legal entity for EPA reporting, state regulatory compliance, and environmental cost management.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: LDAR surveys are typically performed by specialized third-party contractors with certified equipment and EPA Method 21 qualifications. Linking to vendor enables contractor performance tracking, invoic',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: LDAR surveys are conducted on specific emission sources (compressors, valves, flanges, etc.). emission_source is the master record for stationary and fugitive emission sources subject to LDAR programs',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: LDAR surveys on new facilities or capital projects charged to AFE for capital cost tracking and regulatory compliance documentation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: LDAR costs posted to GL accounts for financial reporting, environmental compliance cost tracking, and budget management.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: LDAR surveys fulfill specific regulatory obligations (EPA LDAR requirements, state air quality programs). Linking surveys to obligations supports compliance tracking, deadline management, and regulato',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: LDAR surveys are conducted at production facilities under EPA Method 21, NSPS OOOOa/OOOOb, and state regulations. Linking ldar_survey to production_facility enables facility-level LDAR program managem',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: LDAR surveys on projects tracked for cost allocation, compliance documentation, and project environmental performance.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: ldar_survey has regulatory_submission_date and regulatory_submission_reference as denormalized fields. Linking to regulatory_submission normalizes this relationship and enables full regulatory filing ',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: LDAR surveys are conducted on rig equipment components (engines, mud systems, flare). EPA/state regulatory compliance programs require LDAR results to be traceable to the specific rig for rig-level em',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: LDAR surveys on projects tracked to WBS for cost allocation, capital project reporting, and compliance documentation.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Fahrenheit at the time of the survey, recorded to assess environmental conditions that may affect detection sensitivity.',
    `components_surveyed_count` STRING COMMENT 'Total number of equipment components inspected during the LDAR survey.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`emission_source` (
    `emission_source_id` BIGINT COMMENT 'Unique identifier for the emission source. Primary key for the emission source master record.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the oil and gas facility where this emission source is located. Links to the facility master record for site-level aggregation and reporting.',
    `asset_id` BIGINT COMMENT 'Reference to the physical asset record in the CMMS (Maximo) for maintenance history, asset lifecycle, and reliability tracking. Links emission source to asset management workflows.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Emission sources registered to legal entity for EPA reporting, state permits, and environmental liability management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Emission monitoring and control equipment costs must be allocated to cost centers for environmental compliance budget tracking. Essential for managing air quality compliance program expenses in oil-an',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Delivery points (loading arms, vapor recovery units, storage tanks at terminals) are emission sources requiring GHG reporting under EPA regulations. Links emission inventory to specific customer-facin',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Drilling wells are registered emission sources (flaring, venting, fugitive emissions from wellhead). EPA Subpart W and state regulations require emission sources to be linked to the specific well for ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Emission sources (heaters, boilers, engines, flares, storage tanks) are equipment assets. Equipment FK integrates emissions inventory with asset register for GHG accounting, permit limit tracking, and',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Emission sources installed under capital projects track to AFE for capitalization, depreciation basis, and environmental compliance cost allocation.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Emission sources tied to fixed assets for depreciation basis, asset retirement obligation calculation, and environmental liability management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Emission control costs posted to GL accounts for financial reporting, environmental cost tracking, and capital vs. opex classification.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Emission sources consuming fuels/chemicals must link to material master for accurate emission factor application, fuel consumption reconciliation, GHG reporting (EPA GHGRP), and consistency between pr',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Emission sources are subject to specific monitoring/reporting obligations. Linking sources to obligations supports compliance calendar management, regulatory reporting, and demonstrates fulfillment of',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Emission sources operate under facility operating licenses. Linking sources to licenses supports permit compliance tracking, emissions inventory management, license renewal preparation, and regulatory',
    `permit_id` BIGINT COMMENT 'Reference to the air quality permit (Title V, PSD, minor source permit) that authorizes emissions from this source. Links to permit conditions, emission limits, and compliance monitoring requirements.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Emission sources combusting or processing petroleum products require product identification for emission factor selection, EPA air permit compliance, GHG reporting calculations, and fuel quality track',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Emission sources assigned to profit center for ESG reporting, carbon cost allocation, and environmental performance tracking by business unit.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Emission sources on projects tracked for cost allocation, asset management, and project environmental compliance.',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Rig engines, mud pits, and flare systems are registered emission sources under EPA NSPS/NESHAP subparts. Linking emission_source to the rig enables rig-level GHG inventory, air permit compliance track',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Emission sources on projects tracked to WBS for cost allocation, capitalization, and project asset management.',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: GHG emissions reported by legal entity for EPA GHGRP, state reporting, SEC climate disclosure, and carbon tax compliance.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude grade carbon intensity calculations require grade-specific API gravity and sulfur content for Scope 3 upstream emissions, OPGEE modeling, and ESG disclosure under TCFD and CDP frameworks.',
    `emission_source_id` BIGINT COMMENT 'Identifier of the specific emission source unit or equipment (e.g., flare, combustion unit, fugitive source).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Carbon costs (offsets, taxes, compliance) posted to GL accounts for financial reporting, ESG cost tracking, and P&L management.',
    `ldar_survey_id` BIGINT COMMENT 'Foreign key linking to hse.ldar_survey. Business justification: GHG emission records can be calculated from LDAR survey results — ldar_survey captures total_estimated_emissions_co2e_metric_tons and total_estimated_emissions_mcf. Linking ghg_emission to the origina',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: GHG emissions reporting fulfills specific regulatory obligations (EPA GHGRP, state programs). Linking emissions records to obligations supports compliance verification, deadline tracking, and regulato',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: GHG emission calculations require product-specific emission factors and carbon intensity values. Product identification is mandatory for EPA Subpart C/W reporting, Scope 3 emissions tracking, and ESG ',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product emissions tracking requires product-specific heating values, renewable content percentage, and carbon intensity for EPA GHGRP Subpart MM reporting, LCFS credit generation, and Scope 3 ',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: GHG emissions data populates regulatory filings (annual GHG reports, ESG disclosures). Linking emissions to filings supports filing preparation, audit trail, data traceability, and regulatory verifica',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: GHG emissions are reported via mandatory regulatory submissions (EPA Subpart W, GHGRP). Linking ghg_emission to the regulatory_submission it was included in enables GHG inventory-to-filing traceabilit',
    `seismic_survey_id` BIGINT COMMENT 'Foreign key linking to exploration.seismic_survey. Business justification: GHG emissions from seismic vessel engines, helicopter support, and explosive detonations are tracked per survey for ESG reporting and carbon accounting. Operators must allocate Scope 1/2 emissions to ',
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
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Spills occurring during exploration block operations must be reported to the licensing authority referencing the specific block number. Regulatory notifications (NRC, BSEE, national regulators) and li',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Spills by carriers reference carrier for insurance claims and approval status. Essential for liability determination and vetting.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Spill events reported by legal entity for NRC/BSEE reporting, state compliance, insurance claims, and SEC materiality assessment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spill cleanup costs (estimated_cleanup_cost_usd field present) must be allocated to cost centers for environmental incident cost tracking and insurance claims. Critical for oil-and-gas environmental l',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude spill response requires grade-specific API gravity, H2S content, and TAN value for containment strategy, vapor monitoring, and regulatory reporting to BSEE/NRC beyond generic petroleum_product c',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_order. Business justification: Spills during delivery orders reference order for environmental reporting and liability. Essential for volume reconciliation and regulatory compliance.',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Spills during loading/unloading operations at delivery points are common environmental incidents. Essential for tracking environmental performance at custody transfer locations, regulatory reporting (',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Spill events activate emergency response plans (oil spill response organizations, containment procedures). Linking spill_event to the emergency_response_plan that was activated enables ERP effectivene',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Equipment failures cause spills (tank overflow, pump seal failure, valve packing leak). Equipment FK required for failure analysis, asset reliability tracking, equipment replacement prioritization, an',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Spill response and remediation costs on capital projects charged to AFE for cost recovery, insurance claims, and partner billing. Role prefix distinguishes from operational spills.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Spills from fixed assets tracked for impairment assessment, asset retirement obligation adjustment, and environmental liability management.',
    `incident_id` BIGINT COMMENT 'Foreign key reference to the parent HSE incident record for unified event tracking and root cause analysis across all incident types.',
    `injection_well_id` BIGINT COMMENT 'Foreign key linking to production.injection_well. Business justification: Injection well failures causing surface spills (produced water overflow, tubing leaks, surface casing vent flow) require NRC/state notification and are tracked against the injection well for UIC compl',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Spill events at joint operations trigger JOA liability provisions, insurance claims, cleanup cost allocation, and regulatory reporting obligations; cleanup costs are joint account charges billed throu',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Spills on leased land trigger lease clause reviews, lessor notifications, potential lease termination risk assessments, and lease-specific remediation obligations. Critical for land department spill r',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Spill events must identify the specific petroleum product released for NRC/BSEE regulatory reporting, cleanup method selection, environmental impact assessment, and financial liability calculations. R',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline spills must link to specific segment for integrity investigation, PHMSA incident reporting (Form 7000-1), risk model updates, segment-level spill rate tracking, and remediation cost allocatio',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Spills at production facilities (tank battery overflows, separator leaks, produced water releases) are tracked against the facility for SPCC reporting, NRC notification, and remediation cost allocatio',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Wellhead spills, produced water releases, and well control events resulting in spills are tracked against the specific production well for SPCC, NRC, and state regulatory reporting. spill_event has ex',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Spill costs allocated to profit center for P&L reporting, insurance claims, and environmental performance tracking by business unit.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Spill events on projects tracked for cost management, schedule impact, and project risk assessment.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Spill cleanup and remediation costs are invoiced to responsible parties, JV partners, or third parties under JOA/PSA cost recovery provisions. Real business process: environmental incident cost alloca',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product spills require product-specific flash point, vapor pressure, and benzene content for emergency response planning, air monitoring, and EPA/state agency notification under SPCC and OPA-9',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Spill events require mandatory regulatory notifications and submissions (NRC, BSEE, USCG, state agencies). spill_event has nrc_notification_required, bsee_notification_required, uscg_notification_requ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Spill response costs posted to GL accounts for financial reporting, insurance claims, and environmental cost tracking. Role prefix for clarity.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Spill response contractors and cleanup service vendors must be tracked for regulatory reporting (NRC, BSEE), cost recovery and insurance claims, vendor performance evaluation, and verification of vend',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Spills occurring on or from a drilling rig must reference the rig for BSEE/NRC regulatory reporting. Rig-level environmental performance tracking and insurance claims require spill events to be tracea',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Spills on ROW require grantor notification, remediation per ROW agreement terms, potential ROW termination risk assessment, and ROW-specific cleanup obligations. Essential for grantor relations and RO',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Spills require tract-level tracking for surface owner notifications, remediation boundary definition, title opinion updates regarding environmental encumbrances, and tract-specific cleanup cost alloca',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Spill events require partner notification per JOA terms; operator vs non-operator responsibilities, insurance claims coordination, and cleanup cost sharing follow partnership agreement provisions.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Spills from vessels reference vessel for P&I claims and vetting status. Essential for liability determination and charter approval.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Spills often constitute violations of environmental permits or regulations. Linking spill events to violation records supports enforcement response, penalty tracking, corrective action verification, a',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: Spills during voyages reference voyage for charter party claims and insurance. Essential for liability determination and regulatory reporting.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Spill costs on projects charged to WBS for cost tracking, insurance claims, and project financial reporting.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring record.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the oil and gas facility where monitoring was conducted.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Monitoring data tracked by legal entity for regulatory compliance, permit requirements, and environmental liability management.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Environmental monitoring programs (groundwater, air quality near wellsite) are conducted at specific well locations. Regulatory baseline monitoring and post-drilling environmental compliance require m',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: Environmental monitoring is conducted at specific emission sources (ambient air quality monitoring near stacks, fence-line monitoring). Linking environmental_monitoring to emission_source enables sour',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Environmental monitoring programs for capital projects (baseline studies, construction monitoring) charged to AFE for capital cost tracking and regulatory compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Monitoring costs posted to GL accounts for financial reporting, environmental compliance cost tracking, and budget management.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Environmental monitoring samples are analyzed by certified third-party laboratories. Linking to vendor enables tracking lab certifications, accreditation status, chain-of-custody, invoice reconciliati',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Environmental monitoring fulfills permit conditions and regulatory obligations. Linking monitoring records to obligations supports compliance verification, deadline tracking, and demonstrates fulfillm',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Environmental monitoring is required by specific permits (air quality, water discharge). Linking monitoring records to permits supports permit compliance tracking, exceedance reporting, and permit ren',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Environmental monitoring programs track product-specific parameters (benzene from gasoline, H2S from sour crude, VOCs from refined products) for air permit compliance, fence-line monitoring, and commu',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Monitoring costs allocated to profit center for budget management, environmental compliance cost tracking, and P&L reporting.',
    `seismic_survey_id` BIGINT COMMENT 'Foreign key linking to exploration.seismic_survey. Business justification: Regulatory permits for seismic surveys require environmental baseline and impact monitoring (marine mammal observation, noise levels, water quality). Environmental monitoring records must reference th',
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
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental monitoring record was last modified in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value of the measurement result.',
    `monitoring_frequency_required` STRING COMMENT 'Required monitoring frequency per regulatory permit or internal HSE program (e.g., continuous, hourly, daily, weekly, monthly, quarterly, annual).',
    `monitoring_type` STRING COMMENT 'Type of environmental or occupational monitoring conducted (ambient air quality, groundwater, surface water, soil, noise, H2S fixed detector, H2S portable detector, toxic gas, personal exposure, area monitoring). [ENUM-REF-CANDIDATE: ambient_air_quality|groundwater|surface_water|soil|noise|h2s_fixed|h2s_portable|toxic_gas|personal_exposure|area_monitoring — 10 candidates stripped; promote to reference product]',
    `muster_station_activation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether muster stations were activated as a result of this measurement or alarm (True if activated, False otherwise).',
    `parameter_measured` STRING COMMENT 'Specific environmental or occupational parameter measured (e.g., VOCs, benzene, H2S ppm, TSS, pH, TDS, noise dBA, particulate matter PM2.5, CO, LEL).',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Regulatory submissions filed by legal entity for EPA, BSEE, state agency compliance, and corporate legal obligations.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Emergency response plans are submitted to regulatory agencies for approval (BSEE, EPA, USCG). emergency_response_plan.regulatory_submission_date and regulatory_approval_number indicate this regulatory',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Regulatory filing costs posted to GL accounts for financial reporting, compliance cost tracking, and budget management.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Regulatory submissions for joint operations require JOA context; operator reporting obligations, partner notification requirements, and submission cost allocation are governed by JOA regulatory compli',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Many HSE regulatory submissions are lease-specific (air permits, spill reports, NORM notifications); lease identification required for regulatory filings, lessor notifications, and lease compliance do',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Regulatory submissions fulfill specific obligations. Linking submissions to obligations supports compliance calendar management, deadline tracking, obligation closure verification, and provides audit ',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Regulatory submissions report on licensed operations (production reports, compliance certifications). Linking submissions to licenses supports license compliance tracking, renewal preparation, and reg',
    `original_submission_regulatory_submission_id` BIGINT COMMENT 'Identifier of the original submission record if this is a resubmission or correction.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Many regulatory submissions report on permit compliance (annual reports, exceedance notifications). Linking submissions to permits supports permit management, compliance tracking, and permit renewal p',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Many HSE regulatory submissions are product-specific: EPA fuel quality reports, state product registration, TSCA chemical notifications, DOT hazmat registrations, and SARA Title III hazardous substanc',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Regulatory submissions (PHMSA, FERC) reference nomination for compliance documentation. Links submission to nomination for audit trail and verification.',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Process safety events require mandatory regulatory notifications (BSEE, OSHA, EPA). process_safety_event.regulatory_notification_required flag indicates this obligation. Linking regulatory_submission ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Regulatory costs tracked by profit center for budget management, compliance cost analysis, and P&L reporting by business unit.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: HSE regulatory submissions (incident reports, emissions data, spill notifications) are formalized as compliance regulatory filings. Links operational submission tracking to formal compliance filing re',
    `seismic_survey_id` BIGINT COMMENT 'Foreign key linking to exploration.seismic_survey. Business justification: Regulatory submissions for seismic permits, environmental clearances, and post-survey environmental impact reports must reference the specific seismic survey. Regulators require survey-level submissio',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`hse`.`process_safety_event` (
    `process_safety_event_id` BIGINT COMMENT 'Unique identifier for the process safety event record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: PSE tracked by legal entity for SEC reporting, insurance claims, regulatory notifications, and corporate risk management.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: PSE investigations for crude processing require grade-specific H2S, TAN, and vapor pressure data for root cause analysis, safety instrumented system design, and API RP 754 Tier 1/2 reporting.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Well control events, blowouts, and H2S releases are process safety events tied to specific drilling wells. BSEE and API RP 754 reporting require PSE traceability to the operational well record for reg',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Process safety events (LOPC, fires, explosions) activate emergency response plans. Linking process_safety_event to the emergency_response_plan that was activated enables ERP effectiveness evaluation, ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: PSEs (loss of primary containment) involve specific equipment failures (vessel rupture, piping leak, relief valve lift). Equipment FK required for barrier analysis, bow-tie diagram updates, equipment ',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: PSE investigations and remediation on capital projects charged to AFE for cost tracking, insurance claims, and SEC materiality assessment.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: PSE involving fixed assets tracked for impairment assessment, asset retirement planning, and insurance claims.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: PSE costs posted to GL accounts for financial reporting, insurance claims, and process safety cost tracking.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Process safety events involving loss of primary containment must identify the petroleum product released for consequence analysis, API RP 754 Tier reporting, regulatory notification (EPA RMP, OSHA PSM',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline PSEs (rupture, significant leak) require segment-level linkage for integrity investigation, risk model updates (probability of failure), consequence analysis updates, and segment-specific PSE',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Process safety events (LOPC, overpressure, fire/explosion) occur at production facilities. API RP 754 and BSEE require PSE tracking by facility. Domain experts expect process_safety_event to reference',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: PSE costs allocated to profit center for P&L reporting, insurance claims, and process safety performance tracking by business unit.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: PSE on projects tracked for cost management, schedule impact, risk assessment, and project safety performance.',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product PSEs require specific flash point, autoignition temperature, and flammability limits for loss of primary containment analysis, consequence modeling, and OSHA PSM compliance documentati',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Process safety events (blowouts, fires, releases) on drilling rigs must be tracked against the specific rig for BSEE regulatory reporting, API RP 754 benchmarking, and rig safety performance KPIs used',
    `seismic_survey_id` BIGINT COMMENT 'Foreign key linking to exploration.seismic_survey. Business justification: Process safety events during seismic operations (H2S release from shallow gas, explosive handling incidents, high-pressure equipment failures) must reference the survey for IOGP/API PSE Tier classific',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Process safety events may constitute violations of PSM regulations or permit conditions. Linking PSEs to violation records supports enforcement response, corrective action tracking, and regulatory rep',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: PSE on projects tracked to WBS for cost allocation, schedule impact analysis, and project risk management.',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ERP maintained by legal entity for regulatory compliance, insurance requirements, and corporate liability management.',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Emergency response plans are required for delivery points (marine terminals, truck loading facilities) where customers take custody. Regulatory requirement for oil spill response planning and coordina',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ERP costs posted to GL accounts for financial reporting, compliance cost tracking, and capital vs. opex classification.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOAs require emergency response plans for joint operations; plan approval, funding allocation, mutual aid obligations, and response cost sharing are contractual requirements under JOA HSE provisions.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Emergency plans must cover leased properties; lease terms may require specific response protocols, lessor coordination is often mandated, and lease-specific emergency contacts and procedures are maint',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Emergency response plans fulfill specific regulatory obligations (OPA 90, SPCC requirements). Linking plans to obligations supports compliance tracking, plan review scheduling, and regulatory reportin',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to venture.operating_committee. Business justification: Operating committees approve emergency response plans, review drill results, and authorize ERP updates per JOA HSE standards. ERPs require operating committee approval when covering joint venture oper',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Emergency response plans are required by operating licenses. Linking plans to licenses supports license compliance verification, renewal preparation, and demonstrates fulfillment of license conditions',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Emergency response plans require designated operator for lease/basin-level emergency coordination and regulatory compliance (OPA-90, NCP). Operator ownership of ERP is standard oil-and-gas practice fo',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Emergency response plans (SPCC, FRP, OPA-90) are required by and submitted under specific permits. Links plan to authorizing permit for compliance verification, renewal tracking, and regulatory audit ',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: ERP for projects tracked for cost allocation, compliance management, and project safety planning.',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Surface use agreements often require emergency response plans; agreement terms specify response obligations, surface owner notification protocols, and emergency access rights. Critical for surface own',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: ERP for projects tracked to WBS for cost allocation, capital project reporting, and compliance documentation.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `oil_gas_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_incident_investigation_id` FOREIGN KEY (`incident_investigation_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident_investigation`(`incident_investigation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_ldar_survey_id` FOREIGN KEY (`ldar_survey_id`) REFERENCES `oil_gas_ecm`.`hse`.`ldar_survey`(`ldar_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_previous_action_hse_corrective_action_id` FOREIGN KEY (`previous_action_hse_corrective_action_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_corrective_action`(`hse_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_ldar_survey_id` FOREIGN KEY (`ldar_survey_id`) REFERENCES `oil_gas_ecm`.`hse`.`ldar_survey`(`ldar_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_original_submission_regulatory_submission_id` FOREIGN KEY (`original_submission_regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`hse` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `oil_gas_ecm`.`hse` SET TAGS ('dbx_domain' = 'hse');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `regulatory_report_submitted` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `systemic_causes` SET TAGS ('dbx_business_glossary_term' = 'Systemic Causes Narrative');
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Interview Count');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `hse_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Corrective Action ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `consent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `ldar_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Ldar Survey Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `previous_action_hse_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Action ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Instrument Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `ldar_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Ldar Survey Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ALTER COLUMN `components_surveyed_count` SET TAGS ('dbx_business_glossary_term' = 'Components Surveyed Count');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Permit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `ldar_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Ldar Survey Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Response Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Incident Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Response Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Response Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_frequency_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Required');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Type');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `muster_station_activation_flag` SET TAGS ('dbx_business_glossary_term' = 'Muster Station Activation Flag');
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `parameter_measured` SET TAGS ('dbx_business_glossary_term' = 'Parameter Measured');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `original_submission_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission Identifier');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event (PSE) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
