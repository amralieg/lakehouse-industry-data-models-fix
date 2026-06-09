-- Schema for Domain: hse | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`hse` COMMENT 'Manages health, safety, and environmental compliance including incident reporting, LTIFR/TRIFR tracking, risk assessments, environmental monitoring, permit conditions, PPE tracking, and regulatory submissions. Integrates IsoMetrix for HSE event management and supports ISO 45001, ISO 14001, MSHA, and GRI reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`incident` (
    `incident_id` BIGINT COMMENT 'Primary key for incident',
    `area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: Incidents occur in specific mine areas and must be linked for area-level TRIFR/LTIFR reporting, area risk profiling, and superintendent accountability. location_description on incident is a denormaliz',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: HSE incidents frequently involve specific equipment assets (vehicle collisions, equipment rollovers, machinery failures causing injuries). Incident investigations require linking to the involved asset',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: Marine/port incidents during cargo loading (spills, injuries, fires) must reference the specific shipment for regulatory notification, P&I insurance claims, and demurrage dispute resolution. Mining ex',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Incidents involving hazardous chemicals (spills, exposures, releases) should reference the specific chemical from the register. This creates traceability from incident to chemical properties, SDS info',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Commodity-level incident classification is standard in mining (lithium fires, coal dust explosions, iron ore dust exposure). Regulatory bodies require commodity classification in incident reports. HSE',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: HSE incidents incur costs (investigation, remediation, lost time) that must be allocated to cost centres for management reporting. This FK enables tracking of HSE cost performance by organizational un',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Incidents at counterparty facilities (port terminals, processing plants) or involving counterparty personnel during joint mining operations require regulatory notification and insurance claims referen',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Incidents at port terminals, berths, and stockyards (delivery destinations) during ship loading or product handling must be recorded against the specific delivery destination for port authority report',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: When an HSE incident occurs, it may trigger activation of a specific emergency response plan. Linking incident to the ERP that was activated creates traceability between incident response and document',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Ground fall, slope failure, and gas outburst incidents are attributed to specific geological domains for root cause analysis and regulatory reporting. More granular than orebody_id (already present), ',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: Incidents such as spontaneous combustion, acid mine drainage exposure, and ground falls are directly associated with specific geological units. Linking incident to geological_unit enables lithology-ba',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Every incident in mining HSE is caused by or associated with a specific hazard from the hazard register. Linking incident to hazard enables statistical analysis of which hazards are causing the most i',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Incidents are reported at the mine site level for regulatory notification, TRIFR/LTIFR calculation, and corporate HSE reporting. Regulatory bodies require site-level incident statistics. Site managers',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Mining incidents occur within specific orebodies; incident investigation requires geological context (ore type, mining method, geotechnical domain). Real-world incident reports cite orebody location f',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Environmental or safety incidents in mining may constitute a breach of a specific regulatory condition (e.g., a spill breaches a water discharge condition). Regulators require notification identifying',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Incidents in mining are often linked to the risk assessment that should have identified and controlled the hazard. Linking incident to risk_assessment enables gap analysis — identifying which risk ass',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Incidents frequently involve specific products (chemical spills, contamination, handling injuries, TML exceedance). Incident investigation and regulatory reporting require product identification. Mini',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Incidents involving materials (equipment parts, consumables, non-chemical items causing injury/environmental release) require material master linkage for investigation, root cause analysis, and regula',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site or facility where the incident occurred.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to sales.vessel. Business justification: Marine incidents (grounding, collision, fire) must identify the specific vessel for flag state reporting, P&I club notification, and maritime authority investigation. Mining export operations require ',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Incidents occurring in warehouse/storage areas require precise location tracking for emergency response and regulatory reporting. Incident location tracking at warehouse level is required for danger',
    `activity_being_performed` STRING COMMENT 'Description of the work activity or task being performed at the time of the incident (e.g., drilling, blasting, hauling, maintenance, processing).',
    `affected_media` STRING COMMENT 'For environmental incidents, the environmental media or receptor affected: air, water, soil, groundwater, vegetation, wildlife, heritage site, or none (for non-environmental incidents). [ENUM-REF-CANDIDATE: air|water|soil|groundwater|vegetation|wildlife|heritage_site|none — 8 candidates stripped; promote to reference product]',
    `containment_actions` STRING COMMENT 'Description of immediate containment or emergency response actions taken to control the incident and prevent escalation.',
    `contributing_factors` STRING COMMENT 'Description of contributing factors that enabled or exacerbated the incident (e.g., equipment condition, training gaps, procedural deficiencies, environmental conditions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was first created in the HSE management system.',
    `days_lost` STRING COMMENT 'Number of scheduled work days lost due to the injury. Applicable for LTI incidents.',
    `environmental_volume_released` DECIMAL(18,2) COMMENT 'Volume of material released in an environmental spill or discharge incident, measured in cubic meters or liters. Applicable only for environmental incidents.',
    `immediate_cause` STRING COMMENT 'Description of the immediate or direct cause of the incident as identified during initial assessment.',
    `incident_number` STRING COMMENT 'Externally-known unique incident reference number assigned by IsoMetrix or site HSE system for tracking and reporting purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident: reported, under investigation, investigation complete, closed, or regulatory submitted.. Valid values are `reported|under_investigation|investigation_complete|closed|regulatory_submitted`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the incident occurred. Principal business event timestamp.',
    `incident_type` STRING COMMENT 'Primary classification of the incident: injury (LTI, MTI, FAI, RWI), near-miss, environmental spill, unauthorized discharge, permit exceedance, heritage disturbance, or biodiversity impact. [ENUM-REF-CANDIDATE: injury|near_miss|environmental_spill|unauthorized_discharge|permit_exceedance|heritage_disturbance|biodiversity_impact — 7 candidates stripped; promote to reference product]',
    `injury_body_part` STRING COMMENT 'Body part affected by the injury (e.g., hand, leg, head, back). Applicable only for injury incidents.',
    `injury_nature` STRING COMMENT 'Nature or type of injury sustained (e.g., fracture, laceration, contusion, burn, strain). Applicable only for injury incidents.',
    `investigation_completion_date` DATE COMMENT 'Date when the formal incident investigation was completed and final report issued.',
    `investigation_methodology` STRING COMMENT 'Root cause analysis methodology used for the investigation: ICAM (Incident Cause Analysis Method), Bow-Tie, 5-Why, Root Cause Tree, TapRoot, or not applicable if no formal investigation conducted.. Valid values are `icam|bow_tie|five_why|root_cause_tree|taproot|not_applicable`',
    `investigation_report_status` STRING COMMENT 'Status of the formal investigation report: not started, in progress, draft, final, or approved.. Valid values are `not_started|in_progress|draft|final|approved`',
    `investigation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a formal investigation is required for this incident based on severity and company policy.',
    `investigation_start_date` DATE COMMENT 'Date when the formal incident investigation commenced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was last updated or modified.',
    `ltifr_contribution_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this incident contributes to the Lost Time Injury Frequency Rate (LTIFR) calculation. True for LTI and fatal incidents.',
    `permit_reference_number` STRING COMMENT 'Reference number of the environmental permit or authorization that was exceeded or breached. Applicable only for permit exceedance incidents.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this incident requires notification to regulatory authorities (MSHA, state environmental agencies, etc.).',
    `regulatory_notification_status` STRING COMMENT 'Status of regulatory notification: not required, pending, submitted, or acknowledged by the authority.. Valid values are `not_required|pending|submitted|acknowledged`',
    `regulatory_submission_deadline` DATE COMMENT 'Deadline date by which the incident must be reported to regulatory authorities (e.g., MSHA 24-hour or 10-day reporting requirements).',
    `remediation_description` STRING COMMENT 'Description of remediation or corrective actions required to address the incident impact and prevent recurrence.',
    `remediation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether environmental remediation or corrective actions are required as a result of this incident.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first reported into the HSE management system.',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause(s) identified through the investigation, including immediate, underlying, and systemic causes.',
    `severity_classification` STRING COMMENT 'Severity classification of the incident based on actual or potential consequence. For injuries: fatal, lost time injury (LTI), medical treatment injury (MTI), restricted work injury (RWI), first aid injury (FAI). For near-misses: high potential or low potential. For environmental: minor, moderate, or major. [ENUM-REF-CANDIDATE: fatal|lost_time_injury|medical_treatment_injury|restricted_work_injury|first_aid_injury|high_potential_near_miss|low_potential_near_miss|minor_environmental|moderate_environmental|major_environmental — 10 candidates stripped; promote to reference product]',
    `shift` STRING COMMENT 'Work shift during which the incident occurred: day, night, or swing shift.. Valid values are `day|night|swing`',
    `trifr_contribution_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this incident contributes to the Total Recordable Injury Frequency Rate (TRIFR) calculation. True for LTI, MTI, RWI, and fatal incidents.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Master record of all health, safety, and environmental incidents and their investigations at mine sites. Covers injuries (LTI, MTI, FAI, RWI), near-misses, environmental spills, unauthorized discharges, permit exceedances, heritage disturbances, and biodiversity impacts. Captures incident type, severity classification, LTIFR/TRIFR contribution flags, affected media (for environmental events), location, shift, activity being performed, immediate causes, containment actions, remediation requirements, and regulatory notification status. For investigated incidents, records root cause analysis methodology (ICAM, Bow-Tie, 5-Why), contributing factors, immediate and underlying causes, investigation team members, and final investigation report status. Tracks regulatory submission deadlines for MSHA and state authority notifications. Sourced from IsoMetrix HSE event management. SSOT for ALL HSE incident records and their formal investigations.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective or preventive action record. Primary key.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: Corrective actions arising from method validation failures, accreditation non-conformances, or systematic analytical bias reference the specific analytical method requiring remediation. ISO 17025 qual',
    `area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: Corrective actions are raised for specific mine areas following incidents, audits, or inspections. HSE managers assign corrective actions to area superintendents. site_location on corrective_action is',
    `audit_id` BIGINT COMMENT 'Foreign key reference to the HSE audit that identified this corrective action requirement. Null if not audit-derived.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Corrective actions in mining are commodity-specific — dust suppression actions for coal differ from acid drainage actions for copper. Regulatory TRIFR/LTIFR compliance reports and corrective action cl',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Corrective actions track estimated_cost and actual_cost that must be allocated to cost centres for budget tracking, variance analysis, and AISC reporting. Essential for financial accountability of HSE',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Corrective actions arising from customer-related incidents (loading accidents, port safety issues) or joint operations require counterparty linkage for collaborative remediation, contractual follow-up',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Corrective actions arising from audits or incidents at customer delivery destinations (port terminals, stockyards) must be tracked against the specific location. Mining HSE teams assign and close out ',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Corrective action costs (actual_cost, estimated_cost) must be classified to GL accounts for AISC/C1 cost reporting and financial statement preparation. Mining finance teams require GL account classifi',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Ground control corrective actions (additional support installation, exclusion zones, monitoring programs) are implemented within specific geological domains. Linking corrective_action to geological_do',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Corrective actions in mining HSE are often directed at eliminating or controlling specific hazards identified in the hazard register. corrective_action has hierarchy_of_controls STRING but no FK to th',
    `incident_id` BIGINT COMMENT 'Foreign key reference to the HSE incident that triggered this corrective action, if applicable. Null if action was triggered by audit, inspection, or risk assessment.',
    `inspection_id` BIGINT COMMENT 'Foreign key reference to the workplace inspection that identified this corrective action requirement. Null if not inspection-derived.',
    `investigation_id` BIGINT COMMENT 'Foreign key reference to the incident investigation that identified this corrective action requirement. Null if not investigation-derived.',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Corrective actions are site-specific and must be linked to the mine site for site-level HSE performance reporting, regulatory submissions, and management review. HSE managers report corrective action ',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Actions addressing geotechnical failures, ground control incidents, or ore-handling hazards are orebody-specific; implementation tracking and effectiveness reviews require orebody context to apply lea',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.plant. Business justification: Corrective actions arising from plant HSE incidents and audits must be tracked against the specific plant for close-out monitoring and plant performance reporting. The denormalized site_location text ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_purchase_order. Business justification: Corrective actions in mining HSE frequently require procurement of replacement safety equipment or remediation materials via a specific PO. Linking enables corrective action spend tracking — a stand',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Breach of a tenement regulatory condition directly triggers a corrective action in mining operations. Compliance managers must trace each corrective action back to the specific condition breached. Thi',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key reference to the risk assessment that identified this corrective action requirement. Null if not risk-assessment-derived.',
    `safety_observation_id` BIGINT COMMENT 'Foreign key linking to hse.safety_observation. Business justification: Corrective actions can be triggered by safety observations (e.g., a field observation identifies an unsafe condition requiring a formal CAPA). corrective_action already has source_trigger_type STRING ',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Corrective actions are raised when product fails to meet specification (grade out-of-spec, moisture exceedance). The specification non-conformance corrective action process is a named quality manage',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Corrective actions for material quality issues, handling procedure updates, or storage requirement changes require material master linkage for material-specific improvement tracking, quality managemen',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Corrective actions in mining are scoped to specific tenements for regulatory compliance reporting. Compliance managers must report corrective actions per tenement licence to regulators. No existing te',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Corrective actions triggered by vendor-supplied defective materials, equipment failures, or vendor HSE performance issues require vendor tracking for vendor performance management, quality non-conform',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: When corrective actions require capital work (equipment replacement, facility modification, engineered controls), costs must be tracked against project WBS elements for capex accounting, project cost ',
    `action_number` STRING COMMENT 'Business-facing unique identifier for the corrective or preventive action, typically formatted as CAPA-NNNNNN for external reference and tracking.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `action_status` STRING COMMENT 'Current lifecycle status of the corrective action: open (assigned but not started), in_progress (work underway), pending_verification (action completed awaiting review), verified (effectiveness confirmed), closed (completed and verified), overdue (past due date), cancelled (no longer required). [ENUM-REF-CANDIDATE: open|in_progress|pending_verification|verified|closed|overdue|cancelled — 7 candidates stripped; promote to reference product]',
    `action_type` STRING COMMENT 'Classification of the action: corrective (addresses existing nonconformity), preventive (prevents potential nonconformity), improvement (enhances performance beyond compliance), or observation (noted for awareness without formal action).. Valid values are `corrective|preventive|improvement|observation`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action. Null until action is completed and costs are reconciled.',
    `closed_by` STRING COMMENT 'Name of the individual with authority who formally closed the corrective action after confirming effectiveness.',
    `closure_date` DATE COMMENT 'Date when the corrective action was formally closed after verification and effectiveness review confirmed successful resolution.',
    `comments` STRING COMMENT 'Free-text field for additional notes, lessons learned, implementation challenges, or other relevant information not captured in structured fields.',
    `communication_required` BOOLEAN COMMENT 'Boolean flag indicating whether this corrective action requires formal communication to workforce, contractors, or external stakeholders (True) or is internal only (False).',
    `completion_date` DATE COMMENT 'Actual date when the corrective action implementation was completed. Null if action is still open or in progress.',
    `corrective_action_description` STRING COMMENT 'Detailed narrative description of the corrective or preventive action to be taken, including specific steps, controls to be implemented, and expected outcomes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrective action record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated and actual costs (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Target date by which the corrective action must be completed, established based on risk level and operational constraints.',
    `effectiveness_rating` STRING COMMENT 'Assessment of whether the corrective action successfully addressed the root cause and prevented recurrence: effective (fully resolved), partially_effective (some improvement), ineffective (issue persists), not_yet_assessed (awaiting review period).. Valid values are `effective|partially_effective|ineffective|not_yet_assessed`',
    `effectiveness_review_date` DATE COMMENT 'Scheduled date for follow-up review to assess the long-term effectiveness of the corrective action, typically 30-90 days after implementation.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action, including materials, labor, equipment, and downtime costs. Used for CAPEX/OPEX planning and cost-benefit analysis.',
    `hierarchy_of_controls` STRING COMMENT 'Classification of the corrective action according to the hierarchy of controls framework: elimination (remove hazard), substitution (replace with less hazardous), engineering (isolate people from hazard), administrative (change work procedures), PPE (Personal Protective Equipment - last resort).. Valid values are `elimination|substitution|engineering|administrative|ppe`',
    `interim_action_taken` STRING COMMENT 'Description of any immediate interim or temporary controls implemented while the permanent corrective action is being developed and executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrective action record was last updated, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `priority` STRING COMMENT 'Priority level assigned to the corrective action based on risk severity and business impact: critical (immediate action required), high (urgent), medium (standard timeline), low (routine).. Valid values are `critical|high|medium|low`',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this corrective action addresses a recurring issue (True) or a first-time occurrence (False). Used to identify systemic problems requiring deeper intervention.',
    `responsible_department` STRING COMMENT 'Department or functional area responsible for executing the corrective action (e.g., Mine Operations, Processing, Maintenance, HSE).',
    `root_cause` STRING COMMENT 'Documented root cause identified through investigation techniques (5 Whys, Fishbone, Fault Tree Analysis) that led to the need for this corrective action.',
    `sop_updated` BOOLEAN COMMENT 'Boolean flag indicating whether this corrective action resulted in updates to Standard Operating Procedures (True) or not (False).',
    `source_trigger_type` STRING COMMENT 'Type of event or activity that triggered the creation of this corrective action: incident (actual HSE event), investigation (formal inquiry), audit (compliance review), inspection (routine check), risk_assessment (hazard identification), observation (safety observation), complaint (stakeholder concern), near_miss (potential incident). [ENUM-REF-CANDIDATE: incident|investigation|audit|inspection|risk_assessment|observation|complaint|near_miss — 8 candidates stripped; promote to reference product]',
    `training_required` BOOLEAN COMMENT 'Boolean flag indicating whether implementation of this corrective action requires workforce training or competency development (True) or not (False).',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as implemented and effective. Null if verification has not yet occurred.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action has been effectively implemented: inspection (physical check), audit (systematic review), observation (behavioral verification), document_review (records check), testing (performance test), measurement (quantitative assessment).. Valid values are `inspection|audit|observation|document_review|testing|measurement`',
    `verified_by` STRING COMMENT 'Name of the individual who performed the verification of corrective action effectiveness.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Tracks corrective and preventive actions (CAPAs) arising from incident investigations, risk assessments, audits, inspections, and safety observations. Records action description, action type (corrective/preventive/improvement), responsible owner, priority, due date, completion date, verification method, effectiveness review date, and closure status. Supports hierarchy of controls tracking and ISO 45001/ISO 14001 continual improvement requirements. Links to source trigger (investigation, audit, inspection, or risk assessment).';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the risk assessment record. Primary key for the risk assessment entity.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Commodity-level hazard assessments capture inherent risks (lithium reactivity, coal spontaneous combustion, nickel toxicity). Mining HSE frameworks require commodity-specific risk profiles for regulat',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Risk assessments drive control measure implementation with associated costs. Cost centre link enables budgeting for risk mitigation activities and tracking actual spend against site/area budgets for H',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Risk assessments for loading operations at customer ports, rail terminals, and delivery facilities are mandatory in mining logistics. Assessing berth conditions, equipment compatibility, environmental',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Risk assessments for high-consequence hazards in mining reference specific emergency response plans as a control measure at the top of the hierarchy of controls. Linking risk_assessment to emergency_r',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Ground control risk assessments in mining are conducted per geotechnical/geological domain (slope stability, underground support design). A mining HSE engineer expects risk_assessment to reference the',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: Specific geological units drive distinct hazard profiles — weak shales drive slope instability, pyritic units drive spontaneous combustion, serpentinites may contain asbestos. Risk assessments for geo',
    `hazard_id` BIGINT COMMENT 'Reference to the hazard record in the enterprise-wide hazard register that this risk assessment evaluates.',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Risk assessments are site-specific documents managed within site risk registers. Site HSE managers report risk assessment currency and coverage by mine site to corporate. Regulatory bodies require sit',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Risk assessments in mining are conducted to evaluate risks of breaching specific regulatory conditions (e.g., assessing risk of exceeding a permitted discharge limit). Direct FK enables compliance man',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Product-specific risk assessments are mandatory for hazardous materials, moisture-sensitive products (TML risks), and products with special handling requirements. Mining operations conduct JSAs and ri',
    `superseded_by_assessment_risk_assessment_id` BIGINT COMMENT 'Reference to the newer risk assessment that replaces this one, if applicable.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Material-specific risk assessments (HAZOP, JSA for handling/storage of explosives, fuels, reagents, spare parts) require linkage to material master for proper hazard identification, control measure sp',
    `tenement_id` BIGINT COMMENT 'Reference to the mine site or facility where this risk assessment applies.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_vendor. Business justification: Contractor risk assessments are a mandatory regulatory requirement in mining before vendor personnel commence work on site. Contractor risk assessment process requires linking the risk assessment to',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital projects in mining require formal HSE risk assessments tied to the project WBS element for project governance and gate approvals. Project risk registers are linked to WBS for cost-of-control t',
    `activity_description` STRING COMMENT 'Detailed description of the work activity, task, or operation being assessed for risk.',
    `affected_personnel_count` STRING COMMENT 'Estimated number of workers potentially exposed to the assessed hazard.',
    `approval_date` DATE COMMENT 'Date when the risk assessment was formally approved by authorized personnel.',
    `approver_name` STRING COMMENT 'Full name of the person who approved the risk assessment.',
    `assessment_date` DATE COMMENT 'Date when the risk assessment was conducted or last updated.',
    `assessment_number` STRING COMMENT 'Business identifier for the risk assessment, typically following organizational numbering convention (e.g., RA-2024-001).',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment record.. Valid values are `Draft|Under Review|Approved|Rejected|Expired|Superseded`',
    `assessment_type` STRING COMMENT 'Methodology used for the risk assessment. JSA (Job Safety Analysis), TRA (Task Risk Assessment), HIRA (Hazard Identification and Risk Assessment), HAZOP (Hazard and Operability Study), FMEA (Failure Mode and Effects Analysis), Bow Tie (Bow Tie Analysis).. Valid values are `JSA|TRA|HIRA|HAZOP|FMEA|Bow Tie`',
    `assessor_name` STRING COMMENT 'Full name of the person who conducted the risk assessment.',
    `comments` STRING COMMENT 'Additional notes, observations, or context relevant to the risk assessment, including consultation outcomes and worker participation details.',
    `control_adequacy_rating` STRING COMMENT 'Assessment of whether the implemented control measures are sufficient to manage the risk to an acceptable level.. Valid values are `Inadequate|Adequate|Effective`',
    `control_hierarchy_level` STRING COMMENT 'Highest level of control hierarchy applied per ISO 45001. PPE (Personal Protective Equipment) is the lowest level of control.. Valid values are `Elimination|Substitution|Engineering|Administrative|PPE`',
    `control_measures` STRING COMMENT 'Detailed description of all control measures implemented to mitigate the risk, following the hierarchy of controls (elimination, substitution, engineering, administrative, PPE).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was first created in the system.',
    `expiry_date` DATE COMMENT 'Date when the risk assessment expires and must be renewed or superseded.',
    `hazard_category` STRING COMMENT 'Classification of the hazard type being assessed: Physical (noise, vibration, radiation), Chemical (dust, fumes, gases), Biological (bacteria, viruses), Ergonomic (manual handling, repetitive strain), Psychosocial (stress, fatigue), Environmental (spills, emissions).. Valid values are `Physical|Chemical|Biological|Ergonomic|Psychosocial|Environmental`',
    `hazard_source` STRING COMMENT 'The origin or cause of the hazard (e.g., mobile equipment, explosives, confined space, high voltage, falling objects).',
    `inherent_consequence_rating` STRING COMMENT 'Severity of potential harm or loss before any control measures are applied, using a 5-level scale.. Valid values are `Insignificant|Minor|Moderate|Major|Catastrophic`',
    `inherent_likelihood_rating` STRING COMMENT 'Probability of the hazard occurring before any control measures are applied, using a 5-level scale.. Valid values are `Rare|Unlikely|Possible|Likely|Almost Certain`',
    `inherent_risk_level` STRING COMMENT 'Risk classification before controls based on the inherent risk score and organizational risk matrix.. Valid values are `Low|Medium|High|Extreme`',
    `inherent_risk_score` STRING COMMENT 'Calculated risk matrix score before controls (likelihood × consequence), typically ranging from 1 to 25.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was last updated in the system.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this risk assessment.',
    `regulatory_reference` STRING COMMENT 'Citation of applicable mining safety regulations, MSHA (Mine Safety and Health Administration) standards, or jurisdictional requirements that govern this risk assessment.',
    `residual_consequence_rating` STRING COMMENT 'Severity of potential harm or loss after control measures are applied, using a 5-level scale.. Valid values are `Insignificant|Minor|Moderate|Major|Catastrophic`',
    `residual_likelihood_rating` STRING COMMENT 'Probability of the hazard occurring after control measures are applied, using a 5-level scale.. Valid values are `Rare|Unlikely|Possible|Likely|Almost Certain`',
    `residual_risk_level` STRING COMMENT 'Risk classification after controls based on the residual risk score and organizational risk matrix.. Valid values are `Low|Medium|High|Extreme`',
    `residual_risk_score` STRING COMMENT 'Calculated risk matrix score after controls (likelihood × consequence), typically ranging from 1 to 25.',
    `review_frequency_months` STRING COMMENT 'Required interval in months for periodic review and revalidation of the risk assessment.',
    `reviewer_name` STRING COMMENT 'Full name of the person who reviewed the risk assessment.',
    `risk_acceptance_status` STRING COMMENT 'Whether the residual risk level is accepted by management or requires further treatment.. Valid values are `Accepted|Not Accepted|Conditional`',
    `work_area` STRING COMMENT 'Specific work area, pit, underground level, processing plant section, or operational zone where the assessed hazard is present.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Master record of hazard identification, the enterprise-wide hazard register, and formal risk assessments conducted across mine operations. Maintains the complete hazard inventory covering physical, chemical, biological, ergonomic, and psychosocial hazards with hazard category, source, affected work areas, and control hierarchy (elimination through PPE). Supports Job Safety Analysis (JSA), Task Risk Assessment (TRA), and Hazard Identification and Risk Assessment (HIRA) methodologies. Captures likelihood rating, consequence rating, risk matrix score (inherent and residual), control measures, control adequacy rating, review frequency, and approval status. SSOT for both hazard inventory and risk assessment records. Aligned with ISO 45001 Clause 6.1.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`safety_observation` (
    `safety_observation_id` BIGINT COMMENT 'Unique identifier for the safety observation record.',
    `area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: Safety observations are made in specific mine areas. work_area on safety_observation is a denormalized reference to mine_area. Area-level leading indicator reporting (observations per area per shift) ',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: Safety observations recorded during cargo loading operations at port are linked to the specific shipment for port safety performance reporting, terminal KPI tracking, and supporting laytime/demurrage ',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Safety observations during loading operations at customer ports and facilities are standard practice. Mining personnel document unsafe conditions, near-misses, and positive behaviors at delivery desti',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or asset involved in the observation (if applicable).',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Safety observations for ground conditions (loose ground, water ingress, scaling requirements) are made within specific geological domains. Linking safety_observation to geological_domain enables leadi',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Safety observations identify specific hazards in the field. safety_observation has hazard_category as a free-text STRING — replacing this with a structured FK to the hazard master register normalises ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Safety observations can escalate to or be directly linked to a formal incident record. In mining HSE operations, a stop-work authority event or hazard observation may be the precursor to or concurrent',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Safety observations in active mining areas are spatially tied to orebodies; trending analysis by orebody identifies geological hazard patterns (ground conditions, stope stability, ore hardness affecti',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.plant. Business justification: Safety observations are made at specific processing plants and aggregated for plant-level leading indicator reporting (TRIFR, observation rates). Mining HSE management systems track safety observation',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Safety observations may identify hazards that are already documented in formal risk assessments. Linking observations to risk assessments creates traceability between field-level observations and docu',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Safety observations during product handling, loading, stockpiling, or quality control activities must reference the specific product. Leading indicator programs in mining track product-specific unsafe',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Safety observations related to improper material handling, storage violations, or material-specific hazards (e.g., leaking chemical containers, damaged equipment parts) require material master linkage',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site where the observation was made.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_vendor. Business justification: Safety observations in mining are frequently made about contractor/vendor workers on site. Contractor safety observation tracking is required for vendor performance management and regulatory complia',
    `closure_date` DATE COMMENT 'Date when the observation was formally closed after all actions were completed and verified.',
    `contributing_factors` STRING COMMENT 'List or description of factors that contributed to the observed condition or behavior (e.g., time pressure, inadequate training, equipment failure, environmental conditions).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the observation record was first created in the HSE management system.',
    `due_date` DATE COMMENT 'Target date by which follow-up actions must be completed.',
    `fatigue_indicator_flag` BOOLEAN COMMENT 'Indicates whether fatigue was identified as a contributing factor or declared by the worker (True = fatigue present, False = no fatigue).',
    `follow_up_action_description` STRING COMMENT 'Description of planned or required follow-up actions, investigations, or corrective measures.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether further investigation or corrective action is required beyond immediate response (True = follow-up needed, False = resolved on site).',
    `immediate_action_taken` STRING COMMENT 'Description of any immediate corrective action taken at the time of observation (e.g., work stopped, hazard isolated, coaching provided, positive feedback given).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the observation record was last updated.',
    `leading_indicator_category` STRING COMMENT 'Classification of the observation for leading indicator reporting and trend analysis (e.g., behavioral safety, housekeeping, equipment condition, procedural compliance).',
    `likelihood_rating` STRING COMMENT 'Assessment of the likelihood or probability of the observed hazard resulting in an incident.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `location_description` STRING COMMENT 'Detailed description of the specific location within the site where the observation was made (e.g., pit floor, processing plant, ROM pad, workshop).',
    `observation_description` STRING COMMENT 'Detailed narrative description of what was observed, including context, behavior, condition, and circumstances.',
    `observation_number` STRING COMMENT 'Business identifier for the safety observation in the format OBS-YYYYMMDD-NNNN.. Valid values are `^OBS-[0-9]{8}-[0-9]{4}$`',
    `observation_status` STRING COMMENT 'Current lifecycle status of the safety observation.. Valid values are `open|under_review|action_assigned|closed|cancelled`',
    `observation_timestamp` TIMESTAMP COMMENT 'Date and time when the safety observation was made in the field.',
    `observation_type` STRING COMMENT 'Classification of the observation: safe act, unsafe act, safe condition, unsafe condition, fatigue declaration, or positive recognition.. Valid values are `safe_act|unsafe_act|safe_condition|unsafe_condition|fatigue_declaration|positive_recognition`',
    `observed_person_name` STRING COMMENT 'Name of the person observed (nullable for anonymous observations or condition-based observations).',
    `observer_name` STRING COMMENT 'Full name of the person who made the safety observation.',
    `observer_role` STRING COMMENT 'Role or position of the person who made the observation.. Valid values are `supervisor|safety_officer|worker|contractor|visitor`',
    `photo_attachment_url` STRING COMMENT 'URL or file path to photographic evidence captured at the time of observation.',
    `ppe_compliance_flag` BOOLEAN COMMENT 'Indicates whether proper PPE was being worn at the time of observation (True = compliant, False = non-compliant).',
    `risk_score` STRING COMMENT 'Calculated risk score based on severity and likelihood ratings, used for prioritization.',
    `severity_rating` STRING COMMENT 'Assessment of the potential severity or consequence of the observed hazard or unsafe condition.. Valid values are `low|medium|high|critical`',
    `stop_work_authority_exercised_flag` BOOLEAN COMMENT 'Indicates whether stop work authority was exercised as a result of this observation (True = work stopped, False = work continued).',
    `work_activity` STRING COMMENT 'Specific work activity or task being performed at the time of observation (e.g., drilling blast holes, loading ore, equipment maintenance, sample collection).',
    CONSTRAINT pk_safety_observation PRIMARY KEY(`safety_observation_id`)
) COMMENT 'Records field-level safety observations, positive interactions, stop-work authority events, fatigue declarations, and behavioural safety interactions made by supervisors, safety officers, and workers during site operations. Captures observation type (safe/unsafe act, safe/unsafe condition, fatigue, positive recognition), observer, location, work activity, crew/shift, immediate action taken, and follow-up required. Feeds leading indicator reporting for TRIFR trend analysis and fatigue risk management programs.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring record.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: Environmental monitoring records must specify the analytical method used to analyze samples. Regulators require the method to be documented alongside results for data validation; environmental_monitor',
    `area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: Environmental monitoring points are located within specific mine areas (waste dumps, ROM pads, pit walls). Environmental compliance officers assign monitoring programs to mine areas for area-level exc',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Environmental monitoring equipment (dust monitors, water quality sensors, noise meters) is registered as assets in mining EAM systems. Linking environmental_monitoring to asset normalises monitoring_e',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Environmental monitoring programs are structured by commodity — coal operations monitor methane and dust, copper operations monitor acid rock drainage, lithium operations monitor brine. Regulatory env',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Environmental monitoring programs incur significant costs (sampling, laboratory analysis, equipment calibration, personnel) that must be allocated to site cost centres for budget planning, variance tr',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Environmental monitoring activities are conducted to verify compliance with specific permit conditions and limits. Each monitoring record should reference the permit it is verifying against, creating ',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Acid rock drainage and heavy metal leaching monitoring programs are designed around specific geological domains (e.g., sulphide-bearing domains). Linking environmental_monitoring to geological_domain ',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: Environmental monitoring programs for acid rock drainage, heavy metal leaching, and radioactive material are designed around specific geological units (e.g., pyritic shales, uranium-bearing granites).',
    `incident_id` BIGINT COMMENT 'Reference to an environmental incident record if this monitoring result is associated with an incident investigation. Null if not incident-related.',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory that performed the analysis. Null for field measurements.',
    `laboratory_sample_id` BIGINT COMMENT 'Reference to the physical sample record in the Laboratory Information Management System (LIMS). Null for direct field measurements.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Monitoring points track environmental impacts from specific orebody extraction; acid mine drainage chemistry varies by ore mineralogy, dust composition by commodity, groundwater drawdown by mining met',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.plant. Business justification: Environmental monitoring (stack emissions, effluent discharge, dust) is conducted at specific processing plants and reported against plant-level environmental permits. Mining environmental compliance ',
    `production_drillhole_id` BIGINT COMMENT 'Foreign key linking to geology.production_drillhole. Business justification: Production drillholes are routinely converted to environmental monitoring wells (groundwater, piezometers, gas monitoring). Linking environmental_monitoring to production_drillhole enables traceabilit',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Environmental monitoring programs in mining are established to satisfy specific regulatory conditions (e.g., monthly water quality monitoring required by condition X). Direct FK allows compliance team',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Environmental monitoring data is the primary input to regulatory submissions (e.g., quarterly water quality reports, annual air quality reports to state environmental agencies). environmental_monitori',
    `rehabilitation_provision_id` BIGINT COMMENT 'Foreign key linking to finance.rehabilitation_provision. Business justification: Environmental monitoring exceedances (exceedance_flag) directly trigger rehabilitation provision revisions in mining. Finance teams use monitoring data to update closure cost estimates. Linking monito',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Product-specific environmental monitoring is standard (dust emissions from specific product stockpiles, runoff contamination from product storage areas). Permit compliance reporting requires product-l',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: Environmental monitoring samples are submitted as part of a laboratory sample batch. The monitoring record must reference the batch for turnaround time tracking, QAQC compliance verification, and regu',
    `tenement_id` BIGINT COMMENT 'Reference to the mine site where environmental monitoring was conducted.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_vendor. Business justification: Environmental monitoring in mining is frequently conducted by external contracted firms. Linking to procurement_vendor enables environmental monitoring contractor management — tracking which vendor ',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Environmental monitoring points at or near storage facilities (dust, emissions, groundwater contamination from stored fuels/chemicals/reagents) require warehouse location linkage for compliance monito',
    `calibration_date` DATE COMMENT 'Date when the monitoring equipment was last calibrated prior to this measurement.',
    `comments` STRING COMMENT 'Free-text field for additional observations, anomalies, or contextual information about the monitoring event.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the monitoring result triggered a requirement for corrective action due to exceedance or other concern.',
    `data_source` STRING COMMENT 'Origin of the monitoring data indicating how the measurement was captured.. Valid values are `field_measurement|laboratory_analysis|continuous_monitor|scada|manual_entry`',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the measured value exceeded the permit limit. True if exceeded, False otherwise.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'Percentage by which the measurement exceeded the permit limit. Null if no exceedance occurred.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the monitoring point in decimal degrees for spatial analysis and mapping.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the monitoring point in decimal degrees for spatial analysis and mapping.',
    `laboratory_reference_number` STRING COMMENT 'External reference or job number assigned by the laboratory for traceability. Null for field measurements.',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric value of the environmental measurement recorded.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency at which this monitoring activity is performed as per permit or management plan requirements. [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|annual|event_based — 8 candidates stripped; promote to reference product]',
    `monitoring_point_code` STRING COMMENT 'Unique code identifying the specific monitoring location or station (e.g., surface water sampling point, air quality station, groundwater bore).. Valid values are `^[A-Z0-9]{4,20}$`',
    `monitoring_point_name` STRING COMMENT 'Descriptive name of the monitoring location for business user reference.',
    `monitoring_status` STRING COMMENT 'Current status of the monitoring record in the workflow from sampling through validation.. Valid values are `scheduled|completed|pending_analysis|validated|rejected|under_investigation`',
    `monitoring_type` STRING COMMENT 'Category of environmental monitoring activity being performed. [ENUM-REF-CANDIDATE: air_quality|water_quality_surface|water_quality_groundwater|noise|vibration|biodiversity|soil — 7 candidates stripped; promote to reference product]',
    `parameter_measured` STRING COMMENT 'Specific environmental parameter or pollutant being measured (e.g., PM10, PM2.5, pH, dissolved oxygen, total suspended solids, heavy metals, noise level dB).',
    `permit_limit` DECIMAL(18,2) COMMENT 'Regulatory or permit-defined threshold limit for the measured parameter. Null if no limit applies.',
    `record_created_datetime` TIMESTAMP COMMENT 'Timestamp when this environmental monitoring record was first created in the system.',
    `record_updated_datetime` TIMESTAMP COMMENT 'Timestamp when this environmental monitoring record was last modified.',
    `regulatory_report_flag` BOOLEAN COMMENT 'Indicates whether this monitoring result must be included in regulatory compliance reporting to authorities.',
    `sampled_by` STRING COMMENT 'Name or identifier of the person or team who collected the sample or performed the measurement.',
    `sampling_datetime` TIMESTAMP COMMENT 'Date and time when the environmental sample was collected or measurement was taken.',
    `sampling_method` STRING COMMENT 'Methodology or protocol used for sample collection or measurement (e.g., grab sample, composite sample, continuous monitoring, manual measurement).',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient or sample temperature in degrees Celsius at the time of measurement.',
    `unit_of_measure` STRING COMMENT 'Unit in which the measurement value is expressed (e.g., mg/L, µg/m³, dB, ppm, NTU).',
    `validated_by` STRING COMMENT 'Name or identifier of the environmental specialist who validated the monitoring result.',
    `validation_datetime` TIMESTAMP COMMENT 'Date and time when the monitoring result was validated.',
    `validation_status` STRING COMMENT 'Quality assurance validation status indicating whether the result has been reviewed and approved by environmental personnel.. Valid values are `not_validated|validated|rejected|requires_resampling`',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sampling or measurement (e.g., clear, rainy, windy) that may influence results.',
    `wind_direction` STRING COMMENT 'Cardinal direction from which the wind was blowing at the time of measurement. [ENUM-REF-CANDIDATE: N|NE|E|SE|S|SW|W|NW — 8 candidates stripped; promote to reference product]',
    `wind_speed_mps` DECIMAL(18,2) COMMENT 'Wind speed in meters per second at the time of measurement. Relevant for air quality and dust monitoring.',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Records of environmental monitoring activities including air quality (dust, particulates), water quality (surface and groundwater), noise, vibration, and biodiversity monitoring at mine sites and surrounding areas. Captures monitoring point, parameter measured, measurement value, units, exceedance flags against permit limits, sampling method, and laboratory reference. Supports ISO 14001 and EIS compliance reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`environmental_permit` (
    `environmental_permit_id` BIGINT COMMENT 'Unique identifier for the environmental permit record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Environmental permits in mining are issued for specific commodity extraction activities. Permit conditions, regulated activities, financial assurance amounts, and renewal requirements differ by commod',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Environmental permits require ongoing compliance costs (permit fees, monitoring, reporting, financial assurance). Cost centre allocation enables tracking these regulatory costs against site budgets an',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Environmental permits in mining frequently mandate specific emergency response plans as permit conditions (e.g., a tailings storage facility permit requires an approved ERP for dam failure scenarios).',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Environmental permits are issued to a specific legal entity (the operator of record). In mining groups with multiple legal entities, permit compliance and renewal obligations must be tracked per legal',
    `mine_site_id` BIGINT COMMENT 'FK to mine.site',
    `rehabilitation_provision_id` BIGINT COMMENT 'Foreign key linking to finance.rehabilitation_provision. Business justification: Mining environmental permits legally require a financial assurance bond backed by a rehabilitation provision. Regulators mandate this linkage for closure liability reporting. financial_assurance_amoun',
    `tenement_id` BIGINT COMMENT 'Identifier of the mining site, operation, or facility to which this environmental permit applies. Links the permit to the physical location and operational context.',
    `compliance_status` STRING COMMENT 'Overall assessment of whether the mining operation is currently meeting all conditions and obligations of this permit. Aggregated from individual permit condition compliance assessments.. Valid values are `compliant|non_compliant|under_review|conditional_compliance|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system. Supports audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date from which the permit becomes legally binding and the mining operation is authorized to conduct the permitted activity.',
    `enforcement_action_description` STRING COMMENT 'Description of any regulatory enforcement action, penalty notice, improvement order, or formal warning issued by the regulatory authority in relation to this permit.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether any regulatory enforcement action, penalty, or formal notice has been issued in relation to this permit. True if enforcement action is active or pending.',
    `expiry_date` DATE COMMENT 'Date on which the permit expires and the authorization ceases unless renewed. Nullable for permits with indefinite duration subject to ongoing compliance.',
    `financial_assurance_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires the mining operation to provide financial assurance, bond, or guarantee to cover potential environmental liabilities or rehabilitation costs.',
    `issue_date` DATE COMMENT 'Date on which the environmental permit was officially issued or granted by the regulatory authority.',
    `issuing_authority` STRING COMMENT 'Name of the government agency, regulatory body, or environmental authority that issued the permit. Examples include state environmental protection agencies, water boards, or mining departments.',
    `last_compliance_assessment_date` DATE COMMENT 'Date of the most recent internal or external compliance assessment or audit conducted for this permit.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this permit record. Supports change tracking and audit trail requirements.',
    `monitoring_frequency` STRING COMMENT 'Required frequency for environmental monitoring and measurement activities specified in the permit conditions. Determines the cadence of compliance data collection. [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annually|event_based — 7 candidates stripped; promote to reference product]',
    `next_reporting_due_date` DATE COMMENT 'Date by which the next regulatory compliance report must be submitted to the issuing authority. Used for proactive compliance tracking and deadline management.',
    `non_compliance_count` STRING COMMENT 'Number of permit conditions currently assessed as non-compliant. Provides a quantitative indicator of compliance risk.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, historical notes, or operational considerations related to this permit.',
    `permit_conditions_summary` STRING COMMENT 'High-level summary of the key conditions, restrictions, and obligations imposed by the permit. Detailed condition-level tracking is maintained in a related permit conditions entity.',
    `permit_document_reference` STRING COMMENT 'File path, document management system reference, or URL to the official permit document, licence certificate, or approval letter issued by the regulatory authority.',
    `permit_number` STRING COMMENT 'Official permit number or licence identifier issued by the regulatory authority. This is the externally-known unique identifier used in all regulatory correspondence and submissions.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the environmental permit. Indicates whether the permit is in force, requires renewal action, or has been terminated.. Valid values are `active|expired|suspended|under_renewal|cancelled|pending_approval`',
    `permit_type` STRING COMMENT 'Classification of the environmental permit based on the regulated activity or environmental medium. Determines the applicable regulatory framework and monitoring requirements.. Valid values are `water_licence|air_emission_permit|waste_discharge_approval|environmental_protection_order|mining_lease|exploration_licence`',
    `regulated_activity` STRING COMMENT 'Description of the specific activity, discharge, emission, or environmental aspect that is authorized under this permit. Examples include water extraction, tailings discharge, air emissions from processing plant, or waste rock disposal.',
    `renewal_due_date` DATE COMMENT 'Target date by which the permit renewal application must be submitted to the regulatory authority to avoid lapse. Typically set in advance of the expiry date per regulatory requirements.',
    `renewal_status` STRING COMMENT 'Current status of the permit renewal process. Tracks whether renewal action is required and the stage of the renewal application.. Valid values are `not_required|pending_submission|submitted|under_review|approved|rejected`',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting compliance reports to the regulatory authority as specified in the permit conditions.. Valid values are `monthly|quarterly|semi_annually|annually|event_based|as_required`',
    `responsible_owner` STRING COMMENT 'Name or identifier of the individual, role, or department responsible for managing compliance with this permit. Accountable for monitoring, reporting, and renewal activities.',
    CONSTRAINT pk_environmental_permit PRIMARY KEY(`environmental_permit_id`)
) COMMENT 'Master register of all environmental permits, licences, and approvals held by the mining operation, including water licences, air emission permits, waste discharge approvals, and environmental protection orders. Records permit number, issuing authority, expiry date, renewal status, and associated monitoring requirements. Includes granular permit conditions with individual compliance obligations, monitoring frequencies, reporting deadlines, responsible owners, condition compliance status (compliant/non-compliant/under review), and evidence of compliance. SSOT for regulatory permit obligations and condition-level compliance tracking. Supports regulatory submissions and ISO 14001 compliance.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key.',
    `application_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement_application. Business justification: Regulatory submissions may reference tenement applications (supporting documentation, compliance evidence). Application tracking and regulatory approval processes require this link. Mining operations ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: Regulatory submissions can be based on or reference formal HSE audit outcomes (e.g., third-party certification audits submitted to regulators, compliance audit reports to MSHA or state environmental a',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Regulatory submissions (annual environmental reports, royalty returns, production reports) in mining are structured by commodity. Jurisdictions require commodity-specific reporting — coal royalty retu',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Regulatory submissions incur preparation costs (consulting, technical studies, laboratory testing, report preparation). Cost centre allocation enables tracking compliance costs against site budgets an',
    `environmental_permit_id` BIGINT COMMENT 'Identifier of the environmental or operational permit associated with this submission, if applicable.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Regulatory submissions are frequently triggered by reportable incidents (e.g., MSHA Part 50 notifications, state environmental incident reports). incident has regulatory_notification_required_flag and',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Regulatory submissions are made by a specific legal entity (the licensed operator). Mining groups with multiple legal entities must track which entity made each submission for regulatory compliance, l',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Regulatory submissions (e.g., annual environmental reports, water monitoring returns) are made to satisfy specific regulatory conditions on a tenement. Direct FK enables compliance managers to confirm',
    `rehabilitation_provision_id` BIGINT COMMENT 'Foreign key linking to finance.rehabilitation_provision. Business justification: Annual rehabilitation liability reports submitted to mining regulators reference specific rehabilitation provisions. Regulators require the submitted provision amount to be traceable to the financial ',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: JORC/NI 43-101 resource statements are submitted to securities regulators and mining authorities as formal regulatory submissions. regulatory_submission must reference the specific resource_statement ',
    `royalty_obligation_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_obligation. Business justification: Royalty returns are a primary category of regulatory submissions in mining. Royalty reporting submissions to state/federal mining authorities must reference the specific royalty obligation being repor',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site or facility to which this regulatory submission pertains.',
    `acknowledgement_date` DATE COMMENT 'Date on which acknowledgement or receipt confirmation was received from the regulatory body.',
    `acknowledgement_received` BOOLEAN COMMENT 'Indicates whether an acknowledgement or receipt confirmation has been received from the regulatory body.',
    `acknowledgement_reference` STRING COMMENT 'Reference number or identifier provided by the regulatory body in their acknowledgement of receipt.',
    `approval_date` DATE COMMENT 'Date on which the submission was internally approved for filing with the regulatory body.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or authority who approved the submission for filing.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes capturing key events, decisions, and communications related to the submission for audit and compliance tracking purposes.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which corrective actions or follow-up submissions must be completed, if required by the regulatory body.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions or follow-up submissions are required as a result of the regulatory bodys response.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory submission record was first created in the system.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the submitted document or report package stored in the document management system.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the submission must be filed or submitted to the governing body.',
    `frequency` STRING COMMENT 'Recurring frequency or schedule at which this type of submission is required by the regulatory body. [ENUM-REF-CANDIDATE: Annual|Quarterly|Monthly|Ad-Hoc|Event-Driven|Biennial|Other — 7 candidates stripped; promote to reference product]',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction under which the regulatory submission is required (e.g., country, state, province).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory submission record was last updated or modified.',
    `prepared_by` STRING COMMENT 'Name or identifier of the individual or team responsible for preparing the regulatory submission.',
    `regulatory_body` STRING COMMENT 'Name of the governing body, authority, or agency to which the submission is made (e.g., MSHA, SEC, state environmental department, JORC committee).',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework, standard, or legislation under which the submission is required (e.g., MSHA Part 50, SEC Regulation S-K 1300, ISO 14001).',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by the regulatory submission.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by the regulatory submission.',
    `response_comments` STRING COMMENT 'Comments, feedback, or conditions provided by the regulatory body in their response to the submission.',
    `response_date` DATE COMMENT 'Date on which a formal response or decision was received from the regulatory body.',
    `response_outcome` STRING COMMENT 'Outcome or decision communicated by the regulatory body in response to the submission.. Valid values are `Approved|Conditionally Approved|Rejected|Requires Revision|Under Review|No Action Required`',
    `response_received` BOOLEAN COMMENT 'Indicates whether a formal response, decision, or feedback has been received from the regulatory body following submission.',
    `submission_date` DATE COMMENT 'Actual date on which the submission was filed or delivered to the regulatory body. Null if not yet submitted.',
    `submission_description` STRING COMMENT 'Detailed description of the content, scope, and purpose of the regulatory submission.',
    `submission_method` STRING COMMENT 'Method or channel used to deliver the submission to the regulatory body.. Valid values are `Electronic Portal|Email|Postal Mail|In-Person|Courier|Other`',
    `submission_reference_number` STRING COMMENT 'External reference number or tracking code assigned to the regulatory submission by the submitting organization or regulatory body. Used for correspondence and audit trail.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission indicating its progress through the submission and approval workflow. [ENUM-REF-CANDIDATE: Draft|Pending Review|Submitted|Accepted|Rejected|Under Revision|Overdue|Withdrawn — 8 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'Category of regulatory submission indicating the nature and purpose of the report or filing. [ENUM-REF-CANDIDATE: MSHA Annual Report|Environmental Impact Statement|JORC Resource Report|SEC Mining Disclosure|GRI Sustainability Report|ISO 14001 Audit|ISO 45001 Audit|Permit Application|Incident Notification|Other — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Tracks all mandatory regulatory submissions and reports to governing bodies including MSHA, state environmental authorities, SEC mining disclosure, JORC resource reporting, and GRI sustainability reports. Records submission type, regulatory body, reporting period, due date, submission date, submission status, and document reference. Supports audit trail for compliance obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`emergency_response_plan` (
    `emergency_response_plan_id` BIGINT COMMENT 'Unique identifier for the emergency response plan record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Emergency response plans in mining are commodity-specific — coal mines require methane explosion and fire ERPs, copper mines require acid spill ERPs, lithium mines require thermal runaway ERPs. Regula',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Emergency response plan maintenance costs (drills, equipment, training) are budgeted and tracked to cost centres in mining operations. HSE managers require cost centre linkage for annual ERP budget su',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Emergency response plans in mining are scenario-specific and tied to particular hazards (e.g., tailings dam failure, underground fire, chemical spill). emergency_response_plan has scenario_category an',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site to which this emergency response plan applies.',
    `approval_date` DATE COMMENT 'Date on which the emergency response plan was formally approved.',
    `approval_status` STRING COMMENT 'Approval status of the emergency response plan by the designated authority.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name and title of the person who approved this emergency response plan, typically the site manager or HSE manager.',
    `assembly_point_primary` STRING COMMENT 'Primary designated assembly point location where personnel should gather during an emergency evacuation.',
    `assembly_point_secondary` STRING COMMENT 'Secondary or alternate assembly point location to be used if the primary assembly point is compromised or inaccessible.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency response plan record was first created in the system.',
    `document_location` STRING COMMENT 'Physical or digital location where the full emergency response plan document is stored and accessible.',
    `drill_compliance_status` STRING COMMENT 'Current compliance status of emergency drill frequency against regulatory and corporate requirements.. Valid values are `compliant|overdue|not_required|scheduled`',
    `drill_frequency_required_months` STRING COMMENT 'Required frequency for emergency drills or exercises in months, as mandated by regulation or corporate policy.',
    `effective_from_date` DATE COMMENT 'Date from which this emergency response plan becomes effective and operational.',
    `effective_to_date` DATE COMMENT 'Date on which this emergency response plan expires or is superseded. Nullable for plans with no defined expiry.',
    `emergency_contact_primary` STRING COMMENT 'Primary emergency contact person and phone number for this plan, typically the site emergency coordinator or incident controller.',
    `emergency_contact_secondary` STRING COMMENT 'Secondary or backup emergency contact person and phone number for this plan.',
    `equipment_resources` STRING COMMENT 'List of emergency equipment and resources required for this plan, including location, quantity, and maintenance status (e.g., self-rescuers, fire extinguishers, spill kits, medical supplies).',
    `external_agency_contacts` STRING COMMENT 'Contact details for external emergency response agencies including fire brigade, ambulance, police, environmental protection, and mine rescue services.',
    `last_drill_date` DATE COMMENT 'Date on which the most recent emergency drill or exercise for this plan was conducted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency response plan record was last modified or updated.',
    `last_review_date` DATE COMMENT 'Date on which the emergency response plan was last reviewed for accuracy, completeness, and relevance.',
    `next_drill_due_date` DATE COMMENT 'Scheduled date for the next mandatory emergency drill or exercise for this plan.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next mandatory review of the emergency response plan, typically annual or as required by regulation.',
    `plan_code` STRING COMMENT 'Business identifier for the emergency response plan, typically following a site-specific naming convention.. Valid values are `^ERP-[A-Z0-9]{6,12}$`',
    `plan_name` STRING COMMENT 'Descriptive name of the emergency response plan, identifying the scenario or scope covered.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the emergency response plan.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `plan_type` STRING COMMENT 'Classification of the emergency response plan by scope and applicability.. Valid values are `site_wide|area_specific|scenario_specific|regulatory_mandated|corporate_standard|contractor_specific`',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory requirement or standard that mandates this emergency response plan (e.g., MSHA 30 CFR Part 49, ISO 45001 Clause 8.2).',
    `response_procedures` STRING COMMENT 'Detailed step-by-step response procedures to be followed when the emergency scenario occurs, including immediate actions, escalation protocols, and containment measures.',
    `review_frequency_months` STRING COMMENT 'Required frequency for plan review in months, as mandated by regulation or corporate policy.',
    `revision_notes` STRING COMMENT 'Summary of changes made in the current version of the emergency response plan, documenting updates, corrections, or enhancements.',
    `scenario_category` STRING COMMENT 'Primary emergency scenario category that this plan addresses, aligned with mining-specific hazards.. Valid values are `underground_entrapment|explosives_incident|tailings_dam_failure|chemical_spill|fire|medical_emergency`',
    `scenario_description` STRING COMMENT 'Detailed description of the emergency scenario, including triggering conditions, potential impacts, and scope of the emergency.',
    `version_number` STRING COMMENT 'Version number of the emergency response plan document, following a major.minor versioning convention.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_emergency_response_plan PRIMARY KEY(`emergency_response_plan_id`)
) COMMENT 'Master register of emergency response plans (ERPs) and drill/exercise records for mine sites. Covers scenarios such as underground entrapment, explosives incidents, tailings dam failure, chemical spills, fire, and medical emergencies. Records plan type, site applicability, scenario description, response procedures, assembly points, emergency contacts, equipment resources, last review date, and approval status. Includes drill and exercise records capturing drill type, scenario tested, participants, date, duration, performance observations, debrief findings, and improvement actions. Tracks drill frequency compliance against ERP requirements and regulatory mandates. SSOT for emergency preparedness and drill compliance. Supports ISO 45001 Clause 8.2 and MSHA emergency response requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Primary key for training_record',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: Training records for laboratory analysts must reference the analytical method they are trained and authorized on. ISO 17025 requires method-specific competency records; mining laboratories must demons',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_class. Business justification: Mining operator competency and licensing is equipment-class specific (haul truck operator, drill rig operator, dozer operator). Linking training records to asset_class enables competency verification ',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Commodity-specific safety training is standard in mining (lithium handling procedures, coal dust management, asbestos awareness for certain ore types). Regulatory compliance requires commodity-level c',
    `competent_person_id` BIGINT COMMENT 'Foreign key linking to exploration.competent_person. Business justification: Competent persons (JORC/NI43-101) must maintain current training and competency. Training records linked to competent_person_id enable verification of training currency for resource/reserve sign-off, ',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Training is a common corrective action type in mining HSE — corrective_action has training_required BOOLEAN flag indicating training is needed. When training is mandated as a corrective action, the re',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Training records track cost_amount and cost_currency but need cost centre allocation for budget tracking. Essential for managing training budgets, variance analysis, and ensuring training costs are pr',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining companies provide safety training to customer personnel (stevedores, vessel crew, logistics staff) on loading procedures, emergency response, and hazard awareness. Tracking the counterparty rec',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Training records for emergency response drills, exercises, and competency assessments should link to the specific emergency response plan being trained on. This creates traceability between plan requi',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Training costs must be posted to appropriate GL accounts for expense classification (training expense vs. capex for major competency programs). Enables proper financial reporting, opex/capex split, an',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Training records in mining are frequently hazard-specific (e.g., working at heights, confined space entry, explosives handling). Linking training_record to the specific hazard being addressed enables ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Incident-driven training is a standard corrective measure in mining HSE — after a significant incident, all affected personnel must complete refresher or specific training. Linking training_record to ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Training records for laboratory instrument operators (XRF, ICP-MS, fire assay furnace) must reference the specific instrument. ISO 17025 requires competency to be demonstrated per instrument; mining H',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Mining regulations require workers to be trained on specific hazardous materials they handle (explosives, chemicals). Material handling competency training links training records to the specific mat',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Training records are site-specific — competency requirements, regulatory training mandates, and training completion rates are tracked by mine site. training_location on training_record is a denormaliz',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.plant. Business justification: Plant-specific training (plant induction, circuit-specific procedures, major hazard facility competency) is tracked per processing plant. Mining operations require plant_id on training records to veri',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Regulatory conditions on mining tenements frequently mandate specific training (e.g., condition requires all blast operators to hold a certified competency). Direct FK allows compliance managers to de',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Training records in mining HSE are often directly tied to specific risk assessments — workers must be trained on the controls identified in a risk assessment before performing the associated work acti',
    `tenement_id` BIGINT COMMENT 'Reference to the mine site or facility where the training was delivered or is applicable.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: External training providers are vendors. Linking training records to vendor master enables vendor-delivered training cost allocation, vendor performance evaluation for training services, contract mana',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether the training requires a formal assessment or examination for completion.',
    `assessment_result` STRING COMMENT 'Outcome of the training assessment: pass (met competency standard), fail (did not meet standard), not_assessed (no assessment required), or pending (assessment scheduled but not completed).. Valid values are `pass|fail|not_assessed|pending`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved in the training assessment, typically expressed as a percentage.',
    `attendance_status` STRING COMMENT 'Participant attendance outcome: attended (full participation), absent (did not attend), partial (attended part of session), or excused (authorized absence).. Valid values are `attended|absent|partial|excused`',
    `certificate_expiry_date` DATE COMMENT 'Date on which the training certificate expires and refresher training is required.',
    `certificate_issue_date` DATE COMMENT 'Date on which the training certificate was issued.',
    `certificate_issued` BOOLEAN COMMENT 'Indicates whether a training certificate or competency card was issued to the participant upon successful completion.',
    `certificate_number` STRING COMMENT 'Unique identifier of the training certificate or competency card issued.',
    `comments` STRING COMMENT 'Free-text notes or observations recorded by the trainer or training coordinator regarding the session or participant performance.',
    `competency_level` STRING COMMENT 'Level of competency achieved or required for this training: basic (foundational), intermediate (operational), advanced (supervisory), or expert (specialist/trainer).. Valid values are `basic|intermediate|advanced|expert`',
    `completion_date` DATE COMMENT 'Date on which the participant successfully completed the training.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the training was completed, used for audit trail and compliance verification.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for delivering this training session, including trainer fees, materials, and facility costs.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was first created in the system.',
    `delivery_method` STRING COMMENT 'Mode of training delivery: classroom (in-person instruction), online (e-learning), on_the_job (practical field training), simulation (virtual or physical simulator), or blended (combination of methods).. Valid values are `classroom|online|on_the_job|simulation|blended`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training session in hours.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was last updated.',
    `pass_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment, expressed as a percentage.',
    `refresher_due_date` DATE COMMENT 'Date by which refresher training must be completed to maintain competency and compliance.',
    `regulatory_requirement` STRING COMMENT 'Reference to the specific regulatory or statutory requirement that mandates this training (e.g., MSHA Part 46, ISO 45001 clause, state mining act section).',
    `scheduled_date` DATE COMMENT 'Date on which the training session was scheduled to occur.',
    `trainer_name` STRING COMMENT 'Full name of the instructor or facilitator who delivered the training.',
    `training_code` STRING COMMENT 'Unique alphanumeric code identifying the training course in the HSE training catalog.',
    `training_status` STRING COMMENT 'Current lifecycle status of the training record: scheduled (planned but not started), in_progress (underway), completed (successfully finished), cancelled (did not proceed), or expired (certificate validity lapsed).. Valid values are `scheduled|in_progress|completed|cancelled|expired`',
    `training_title` STRING COMMENT 'Full name of the HSE training course or module delivered.',
    `training_type` STRING COMMENT 'Category of HSE training delivered: induction (site orientation), statutory (legally mandated such as first aid, warden, explosives handling), refresher (periodic recertification), competency (skill validation), emergency_response (evacuation, rescue), or ppe (Personal Protective Equipment usage).. Valid values are `induction|statutory|refresher|competency|emergency_response|ppe`',
    `validity_period_months` STRING COMMENT 'Number of months for which the training certification remains valid before refresher training is required.',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Records of HSE-specific training and competency activities delivered to mine workers and contractors, including inductions, statutory training (first aid, warden, explosives handling), and refresher courses. Captures training type, delivery method, trainer, participant reference, completion date, assessment result, certificate expiry, and regulatory requirement linkage. Distinct from general workforce training — focused on HSE compliance obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`chemical_register` (
    `chemical_register_id` BIGINT COMMENT 'Unique identifier for the chemical register entry. Primary key for the chemical register product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Hazardous chemicals in mining are stored at or used by specific plant assets (reagent storage at processing plant, explosives magazine). Linking chemical_register to the associated asset enables chemi',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Chemicals used in mining are commodity-process specific — cyanide for gold, flotation reagents for copper, methanol for coal. Chemical registers are maintained per commodity processing stream for regu',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Chemical register tracks inventory quantities and storage locations. Chemical inventory holding costs, handling costs, and disposal costs must be allocated to the site cost centre responsible for the ',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Hazardous chemicals stored or used at mine sites often require specific environmental permits (e.g., dangerous goods storage licences, chemical storage approvals). chemical_register currently has perm',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: Naturally occurring hazardous materials (NORM — asbestos in serpentinites, radioactive minerals, mercury in gold ores) require chemical register entries tied to the geological unit where they occur. M',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Chemicals in the HSE register are procurement materials with SDS, hazard class, and storage data in material_master. Chemical inventory management requires linking the register to the procurement ma',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.plant. Business justification: Chemical registers are maintained per processing plant for emergency response, regulatory threshold reporting, and chemical inventory management. Mining sites maintain plant-specific chemical register',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Each chemical in the register should have an associated risk assessment covering its hazards, exposure limits, and control measures. Linking chemical_register to risk_assessment enables verification t',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Some saleable products are hazardous materials requiring chemical registration (lithium concentrate, uranium oxide, certain coal products). Mining operations must maintain SDS and GHS classification f',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site where the chemical is used, stored, or generated.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Regulatory requirement to maintain chemical supplier information for SDS management, emergency contact during chemical incidents, supply chain transparency, and vendor HSE performance tracking. Remove',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Chemicals must be stored in specific licensed warehouse locations. Chemical storage location management is a regulatory requirement (dangerous goods legislation) in mining. The existing storage_loca',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `chemical_name` STRING COMMENT 'Common or trade name of the hazardous chemical or substance as used in operations (e.g., Sodium Cyanide, Sulphuric Acid, Xanthate, ANFO).',
    `chemical_register_status` STRING COMMENT 'Current lifecycle status of the chemical in the register (active = currently in use, inactive = no longer used but may have residual inventory, restricted = use limited by permit or policy, phased_out = scheduled for elimination, pending_approval = awaiting regulatory or management approval).. Valid values are `active|inactive|restricted|phased_out|pending_approval`',
    `chemical_type` STRING COMMENT 'Classification of the chemical based on its primary use or function in mining operations. [ENUM-REF-CANDIDATE: reagent|explosive_precursor|fuel|solvent|acid|base|oxidizer|process_chemical — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the chemical register record was first created in the system.',
    `current_inventory_quantity` DECIMAL(18,2) COMMENT 'Current quantity of the chemical on hand at the site, as of the last inventory count or system update.',
    `disposal_method` STRING COMMENT 'Approved method for disposal of the chemical or its waste residues (e.g., Licensed Hazardous Waste Contractor, Neutralization and Discharge, Return to Supplier, Incineration).',
    `emergency_contact_number` STRING COMMENT '24-hour emergency contact phone number for the chemical supplier or emergency response service (e.g., CHEMTREC, supplier hotline).',
    `environmental_impact_notes` STRING COMMENT 'Free-text notes describing known or potential environmental impacts of the chemical, including aquatic toxicity, persistence, bioaccumulation, or soil contamination risks.',
    `first_registered_date` DATE COMMENT 'Date when the chemical was first registered in the site chemical register.',
    `ghs_classification` STRING COMMENT 'Hazard classification code(s) according to the GHS standard (e.g., Acute Toxicity Category 2, Corrosive to Metals Category 1, Environmental Hazard Acute Category 1).',
    `ghs_pictogram_codes` STRING COMMENT 'Comma-separated list of GHS pictogram codes representing hazard symbols (e.g., GHS05 for Corrosion, GHS06 for Skull and Crossbones, GHS09 for Environment).',
    `handling_procedure_reference` STRING COMMENT 'Reference number or title of the Standard Operating Procedure (SOP) governing safe handling, use, and storage of this chemical.',
    `hazard_statement_codes` STRING COMMENT 'Comma-separated list of H-codes describing the nature of hazards (e.g., H290 May be corrosive to metals, H314 Causes severe skin burns and eye damage, H400 Very toxic to aquatic life).',
    `health_hazard_summary` STRING COMMENT 'Summary of primary health hazards associated with exposure to this chemical (e.g., Corrosive to skin and eyes, Respiratory irritant, Carcinogen Category 1A, Acute toxicity if ingested).',
    `incompatible_materials` STRING COMMENT 'List of materials or chemical classes that must not be stored or mixed with this chemical due to risk of dangerous reactions (e.g., Strong oxidizers, Acids, Alkalis, Water-reactive substances).',
    `inventory_unit_of_measure` STRING COMMENT 'Unit of measure for the maximum inventory quantity (e.g., kilograms, litres, tonnes, cubic metres, units).. Valid values are `kg|L|tonne|m3|unit`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the chemical register record was last updated or modified.',
    `last_reviewed_date` DATE COMMENT 'Date when the chemical register entry was last reviewed for accuracy and compliance.',
    `maximum_inventory_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of the chemical permitted to be stored on site at any time, as defined by permit conditions or internal risk assessments.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next mandatory review of this chemical register entry.',
    `ppe_requirements` STRING COMMENT 'Mandatory personal protective equipment required when handling this chemical (e.g., Chemical-resistant gloves, Face shield, Respirator with organic vapor cartridge, Acid-resistant apron).',
    `precautionary_statement_codes` STRING COMMENT 'Comma-separated list of P-codes describing recommended measures to minimize or prevent adverse effects (e.g., P280 Wear protective gloves, P305+P351+P338 IF IN EYES rinse cautiously with water).',
    `regulatory_threshold_flag` BOOLEAN COMMENT 'Indicates whether the chemical quantity exceeds regulatory reporting thresholds (e.g., EPCRA Section 312 Tier II, state environmental reporting).',
    `regulatory_threshold_type` STRING COMMENT 'Description of the specific regulatory threshold or reporting requirement triggered (e.g., EPCRA Tier II Reporting, State Hazardous Substance Inventory).',
    `sds_reference_number` STRING COMMENT 'Document control number or identifier for the current Safety Data Sheet (formerly MSDS) on file for this chemical.',
    `sds_revision_date` DATE COMMENT 'Date of the most recent revision of the Safety Data Sheet for this chemical.',
    `storage_area_type` STRING COMMENT 'Classification of the storage facility based on its design and environmental controls.. Valid values are `indoor_warehouse|outdoor_compound|refrigerated|flammable_cabinet|explosives_magazine|bulk_tank`',
    `un_number` STRING COMMENT 'Four-digit number that identifies hazardous substances in the framework of international transport (e.g., UN1789 for Hydrochloric Acid).. Valid values are `^UN[0-9]{4}$`',
    `usage_purpose` STRING COMMENT 'Description of the primary operational purpose or process for which the chemical is used (e.g., Gold leaching, Flotation reagent, Blasting agent, Equipment lubrication, Dust suppression).',
    `waste_classification_code` STRING COMMENT 'Regulatory waste classification code for disposal purposes (e.g., EPA Hazardous Waste Code, Basel Convention Code).',
    CONSTRAINT pk_chemical_register PRIMARY KEY(`chemical_register_id`)
) COMMENT 'Master register of all hazardous chemicals and substances used, stored, or generated at mine sites, including reagents (cyanide, sulphuric acid, xanthates), explosives precursors, fuels, and process chemicals. Records chemical name, CAS number, SDS reference, hazard classification (GHS), storage location, maximum inventory quantity, regulatory threshold flags, and disposal requirements. SSOT for chemical inventory supporting ISO 14001 and MSHA chemical standards.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: HSE audits are conducted at specific mine areas. area_inspected on audit is a denormalized reference to mine_area. Audit scheduling, finding assignment, and corrective action tracking all require the ',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: HSE audits in mining are commodity-specific — coal mine audits cover spontaneous combustion and methane standards, copper mine audits cover acid drainage and flotation chemical handling. Audit scope, ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: HSE audits in mining regularly assess contractor compliance against specific procurement contracts. Contract compliance audit is a mandatory process under mining safety regulations. Audit has vendor',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: HSE audits incur costs (external auditor fees, certification body charges, travel, internal resource time). Cost centre allocation enables tracking audit program costs against site budgets and ensures',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: HSE audits of customer facilities (port operators, logistics contractors, stevedoring companies) are standard due diligence in mining supply chains. Mining companies verify customer safety standards, ',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: HSE audits are conducted at customer delivery destinations (port terminals, stockyards) to verify safe handling of mining products, dust suppression compliance, and environmental standards. Mining com',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: HSE audits often specifically assess the adequacy, currency, and compliance of emergency response plans. Audit records should link to the specific ERP being audited to create traceability between audi',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: HSE audits frequently include environmental permit compliance verification. audit has environmental_permit_verified BOOLEAN flag indicating this relationship exists, but lacks a structured FK to the s',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Ground control management system audits are conducted per geotechnical domain (e.g., audit of ground support compliance in a specific weak-rock domain). Regulatory ground control audits require identi',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Audits are conducted at specific mine sites and must be linked for site-level compliance reporting, regulatory submissions, and management review. Corporate HSE teams track audit completion rates and ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.plant. Business justification: HSE audits (ISO 45001, environmental compliance, major hazard facility audits) are conducted at specific processing plants. Mining HSE audit management systems require plant_id on audit records to gen',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Mining compliance audits are conducted to verify adherence to specific regulatory conditions on a tenement. Auditors must record which condition each audit assessed. This traceability is required for ',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Product quality audits, certification audits (ISO, customer-specific), and hazmat compliance audits are product-specific. Mining operations conduct audits for each certified product grade and track fi',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site or facility where the audit or inspection was conducted.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: HSE audits of vendor facilities, contractor HSE performance audits, and vendor prequalification audits require vendor linkage for vendor performance management, supply chain risk management, and vendo',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: HSE audits in mining regularly inspect specific warehouse and storage facilities for dangerous goods compliance. Warehouse HSE audit is a named regulatory process. The existing area_inspected plain ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: HSE audits scoped to capital projects (new mine construction, plant expansions) are tracked against WBS elements for project governance. Mining project managers require audit findings linked to WBS fo',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the audit or inspection was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the audit or inspection commenced.',
    `audit_number` STRING COMMENT 'Business identifier or reference number assigned to the audit or inspection for tracking and reporting purposes.',
    `audit_scope` STRING COMMENT 'Description of the scope of the audit or inspection, including the processes, areas, or management system elements covered.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit or inspection activity.. Valid values are `planned|in_progress|completed|report_issued|closed`',
    `audit_type` STRING COMMENT 'Discriminator indicating the nature of the assessment: internal audit, external audit, certification audit (ISO 45001, ISO 14001), regulatory compliance audit, ICMM performance audit, or workplace inspection.. Valid values are `internal_audit|external_audit|certification_audit|regulatory_compliance_audit|icmm_performance_audit|workplace_inspection`',
    `auditor_organization` STRING COMMENT 'Name of the organization conducting the audit (internal department, third-party certification body, regulatory agency).',
    `certificate_expiry_date` DATE COMMENT 'Date on which the issued certification expires and requires renewal or recertification.',
    `certificate_issue_date` DATE COMMENT 'Date on which the certification was issued, if the audit resulted in certification.',
    `certification_body` STRING COMMENT 'Name of the accredited certification body conducting the certification audit, if applicable (e.g., for ISO 45001, ISO 14001).',
    `certification_outcome` STRING COMMENT 'Outcome of the certification audit, if applicable (certified, not certified, conditional certification, surveillance passed, recertification passed).. Valid values are `certified|not_certified|conditional_certification|surveillance_passed|recertification_passed`',
    `checklist_used` STRING COMMENT 'Identifier or name of the audit checklist or inspection form used during the assessment.',
    `comments` STRING COMMENT 'Additional comments, observations, or notes recorded by the auditor or inspector during the assessment.',
    `conformance_count` STRING COMMENT 'Number of conformances (areas meeting requirements) identified during the audit.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which corrective actions must be completed to address audit findings.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required as a result of the audit findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit or inspection record was first created in the system.',
    `environmental_permit_verified` BOOLEAN COMMENT 'Indicates whether environmental permit conditions were verified during the audit or inspection.',
    `equipment_inspected` STRING COMMENT 'Description or identifier of specific equipment or assets inspected during the assessment (e.g., haul truck, conveyor, ventilation system).',
    `inspection_frequency` STRING COMMENT 'Planned frequency of the inspection or audit (e.g., daily, weekly, monthly, quarterly, annual, ad-hoc).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit or inspection record was last updated in the system.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor or inspector responsible for conducting the assessment.',
    `major_nonconformance_count` STRING COMMENT 'Number of major non-conformances (critical failures to meet requirements) identified during the audit.',
    `minor_nonconformance_count` STRING COMMENT 'Number of minor non-conformances (less critical failures to meet requirements) identified during the audit.',
    `observation_count` STRING COMMENT 'Number of observations (opportunities for improvement that are not non-conformances) identified during the audit.',
    `ppe_compliance_verified` BOOLEAN COMMENT 'Indicates whether personal protective equipment compliance was verified during the inspection.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority conducting or requiring the audit or inspection (e.g., MSHA, state mining department).',
    `report_document_reference` STRING COMMENT 'Reference identifier or file path to the formal audit or inspection report document.',
    `report_issued_date` DATE COMMENT 'Date on which the formal audit or inspection report was issued to stakeholders.',
    `scheduled_date` DATE COMMENT 'Planned date for the audit or inspection to commence.',
    `standard_reference` STRING COMMENT 'Reference to the standard or regulatory framework against which the audit or inspection was conducted (e.g., ISO 45001:2018, ISO 14001:2015, MSHA 30 CFR Part 56).',
    `team_members` STRING COMMENT 'Comma-separated list of names or identifiers of additional auditors or inspectors participating in the assessment.',
    `total_findings_count` STRING COMMENT 'Total number of findings (conformances, non-conformances, observations) identified during the audit or inspection.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Records of all formal HSE management system audits and field-level compliance assessments including internal audits, third-party certification audits (ISO 45001, ISO 14001), regulatory compliance audits, ICMM performance audits, planned workplace inspections, pre-start equipment checks, statutory inspections, and unplanned field inspections. Captures assessment type discriminator (audit/inspection), scope, assessor/inspector details, checklist items, findings (conformances, non-conformances, observations), corrective action requirements, and certification outcome where applicable. SSOT for all HSE compliance verification activities. Supports MSHA inspection readiness, ISO 45001 internal audit programs, and field-level compliance verification.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Primary key for investigation',
    `area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: Incident investigations are conducted at specific mine areas. location_description on investigation is a denormalized reference to mine_area. Area-level investigation tracking enables area risk profil',
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: Formal investigations can be triggered by audit findings (e.g., a major non-conformance identified during an HSE audit may require a root cause investigation). investigation currently only links to in',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Incident investigations in mining are commodity-specific — coal dust explosion investigations follow different methodologies and regulatory frameworks than copper tailings dam failure investigations. ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Investigations have estimated_cost_impact and currency_code but no cost_centre FK. Mining operations track investigation costs (downtime_hours, remediation) to cost centres for AISC cost reporting and',
    `incident_id` BIGINT COMMENT 'Reference to the HSE incident that triggered this investigation.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mining site or facility where the investigated event occurred.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.plant. Business justification: Process safety investigations (chemical releases, equipment failures, fatalities) occur at specific processing plants. investigation has site_id but not plant_id — a mining HSE manager expects plant-l',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Investigations in mining are triggered by or result in breach of specific regulatory conditions. Regulators require investigation reports to identify the specific condition breached. Direct FK enables',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Investigations in mining are reported to regulators per tenement licence. Regulatory-triggered investigations (e.g., environmental breach) must reference the tenement directly. investigation has site_',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_vendor. Business justification: Incident investigations in mining frequently involve contractor activities. Contractor incident investigation requires referencing the vendor for regulatory reporting, liability determination, and v',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Investigation costs (estimated_cost_impact) at capital project sites are tracked against WBS elements for project cost reporting. Mining companies allocate incident investigation costs to the relevant',
    `actual_completion_date` DATE COMMENT 'The actual date when the investigation was completed and findings were finalized.',
    `approved_date` DATE COMMENT 'The date when the investigation report was formally approved by management.',
    `closed_date` DATE COMMENT 'The date when the investigation was formally closed after all corrective actions were verified.',
    `contributing_factors` STRING COMMENT 'Description of additional factors that contributed to the incident or event but were not the primary cause.',
    `corrective_actions_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required as a result of this investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this investigation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact (e.g., USD, AUD, CAD).',
    `data_classification` STRING COMMENT 'Classification level of the investigation data for access control and information security purposes.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours of operational downtime caused by the incident being investigated.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the incident had an environmental impact requiring investigation under ISO 14001 or environmental regulations.',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the incident including damage, downtime, remediation, and investigation costs.',
    `findings_summary` STRING COMMENT 'Executive summary of the key findings from the investigation.',
    `immediate_cause_description` STRING COMMENT 'Detailed description of the immediate or direct cause(s) that led to the incident or event.',
    `initiated_date` DATE COMMENT 'The date when the investigation was formally initiated.',
    `initiated_timestamp` TIMESTAMP COMMENT 'The precise date and time when the investigation was formally initiated.',
    `investigation_method` STRING COMMENT 'The structured investigation methodology or framework applied to analyze the event.',
    `investigation_number` STRING COMMENT 'Externally-known unique business identifier for the investigation, formatted as INV-YYYY-NNNNNN.',
    `investigation_status` STRING COMMENT 'Current state of the investigation in its workflow lifecycle.',
    `investigation_type` STRING COMMENT 'Classification of the investigation based on the triggering event or purpose.',
    `is_recordable` BOOLEAN COMMENT 'Indicates whether the incident is recordable under MSHA or OSHA regulations for LTIFR/TRIFR tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this investigation record was last updated or modified.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the investigation that should be shared across the organization for continuous improvement.',
    `recommendations` STRING COMMENT 'Detailed recommendations for corrective and preventive actions arising from the investigation findings.',
    `regulatory_notification_date` DATE COMMENT 'The date when regulatory authorities were notified of the investigation findings, if applicable.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the investigation findings require notification to regulatory authorities such as MSHA or environmental agencies.',
    `regulatory_reference_number` STRING COMMENT 'External reference number assigned by the regulatory authority for this investigation or incident report.',
    `report_document_url` STRING COMMENT 'URL or file path to the full investigation report document stored in the document management system.',
    `root_cause_description` STRING COMMENT 'Detailed description of the underlying root cause(s) identified through systematic analysis.',
    `severity_classification` STRING COMMENT 'Severity rating assigned to the investigation based on actual or potential consequences of the triggering event.',
    `target_completion_date` DATE COMMENT 'The planned or required date by which the investigation should be completed.',
    `team_members` STRING COMMENT 'Comma-separated list of employee names or identifiers who are part of the investigation team.',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Master reference table for investigation. Referenced by investigation_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`hse`.`hazard` (
    `hazard_id` BIGINT COMMENT 'Primary key for hazard',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Hazards in mining are fundamentally commodity-specific — methane gas and spontaneous combustion for coal, silica dust for iron ore, acid mine drainage for copper/nickel, thermal runaway for lithium. H',
    `parent_hazard_id` BIGINT COMMENT 'Self-referencing FK on hazard (parent_hazard_id)',
    `affected_job_roles` STRING COMMENT 'Comma-separated list or description of the job roles, occupations, or worker categories that are exposed to or may encounter this hazard during their work activities (e.g., drill operators, blasters, maintenance technicians, haul truck drivers).',
    `affected_work_areas` STRING COMMENT 'Comma-separated list or description of the specific work areas, zones, or operational locations within the mine site where this hazard is present or may be encountered (e.g., underground stopes, processing plant, haul roads, maintenance workshop).',
    `control_hierarchy_level` STRING COMMENT 'The primary level of control applied to manage this hazard according to the hierarchy of controls: elimination (remove hazard), substitution (replace with less hazardous), engineering controls (isolate people from hazard), administrative controls (change work practices), or personal protective equipment (PPE).',
    `control_measures` STRING COMMENT 'Detailed description of the specific control measures, safeguards, or mitigation strategies implemented to reduce or eliminate the risk associated with this hazard.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this hazard record was first created in the HSE management system. Supports audit trail and data lineage.',
    `effective_date` DATE COMMENT 'The date from which this hazard definition and its associated controls became effective and applicable in the organizations health and safety management system.',
    `emergency_response_procedure` STRING COMMENT 'Summary or reference to the emergency response procedures, first aid measures, or incident response protocols to be followed if an incident involving this hazard occurs.',
    `exposure_limit` STRING COMMENT 'The maximum permissible exposure level or threshold limit value for this hazard, including units of measure (e.g., 0.05 mg/m³ for respirable crystalline silica, 85 dBA for noise). Applicable primarily to chemical, physical, and environmental hazards.',
    `gri_disclosure_reference` STRING COMMENT 'Reference to the applicable GRI disclosure standard or indicator related to this hazard, used for sustainability and ESG reporting (e.g., GRI 403: Occupational Health and Safety).',
    `hazard_category` STRING COMMENT 'High-level classification of the hazard into major categories: physical (noise, vibration, radiation), chemical (dust, fumes, gases), biological (bacteria, viruses), ergonomic (repetitive strain, manual handling), psychosocial (stress, fatigue), or environmental (spills, emissions).',
    `hazard_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the hazard type for reporting and classification purposes. Follows organizational hazard coding taxonomy.',
    `hazard_description` STRING COMMENT 'Detailed narrative description of the hazard, including its nature, potential sources, and circumstances under which it may be encountered in mining operations.',
    `hazard_name` STRING COMMENT 'The common business name or title of the hazard used for identification and communication across the organization.',
    `hazard_status` STRING COMMENT 'Current lifecycle status of the hazard record. Active indicates the hazard is currently recognized and managed; under review indicates reassessment is in progress; retired indicates the hazard is no longer present; superseded indicates the hazard definition has been replaced by a newer version.',
    `hazard_type` STRING COMMENT 'Specific sub-classification or detailed type of hazard within the broader category (e.g., Silica Dust, Ground Instability, Heavy Equipment Operation, Confined Space).',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether incidents involving this hazard must be reported to external regulatory authorities such as MSHA, state mining departments, or environmental agencies. True if reportable, False otherwise.',
    `last_incident_date` DATE COMMENT 'The date of the most recent recorded incident, injury, or near-miss event associated with this hazard. Used for trend analysis and control effectiveness evaluation.',
    `likelihood_rating` STRING COMMENT 'The probability or frequency with which the hazard is expected to cause harm, ranging from almost certain (expected to occur frequently) to rare (may occur only in exceptional circumstances).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this hazard record was last updated or modified. Supports change tracking and audit trail.',
    `monitoring_frequency` STRING COMMENT 'The required or recommended frequency for monitoring, inspecting, or reassessing this hazard to ensure controls remain effective and exposure remains within acceptable limits.',
    `permit_required` BOOLEAN COMMENT 'Indicates whether a work permit, hot work permit, confined space entry permit, or other authorization is required before work involving this hazard can commence. True if permit is mandatory, False otherwise.',
    `ppe_required` STRING COMMENT 'Comma-separated list of personal protective equipment required when working in the presence of this hazard (e.g., hard hat, safety glasses, respirator, hearing protection, high-visibility vest, steel-toed boots).',
    `regulatory_reference` STRING COMMENT 'Citation of applicable mining safety regulations, standards, or legal requirements that govern the management of this hazard (e.g., MSHA 30 CFR Part 56, state mining acts, ISO standards).',
    `review_date` DATE COMMENT 'The scheduled date for the next formal review or reassessment of this hazard and its control measures to ensure continued relevance and effectiveness.',
    `risk_rating` STRING COMMENT 'Overall risk level derived from the combination of severity and likelihood, used to prioritize control measures and management attention. Extreme and high risks require immediate action.',
    `severity_level` STRING COMMENT 'The potential severity of harm or consequence if the hazard materializes, rated from catastrophic (fatality or permanent total disability) to minor (first aid injury).',
    `training_required` BOOLEAN COMMENT 'Indicates whether specific safety training or competency certification is required for workers who may be exposed to this hazard. True if training is mandatory, False otherwise.',
    CONSTRAINT pk_hazard PRIMARY KEY(`hazard_id`)
) COMMENT 'Master reference table for hazard. Referenced by hazard_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `mining_ecm`.`hse`.`investigation`(`investigation_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_safety_observation_id` FOREIGN KEY (`safety_observation_id`) REFERENCES `mining_ecm`.`hse`.`safety_observation`(`safety_observation_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_superseded_by_assessment_risk_assessment_id` FOREIGN KEY (`superseded_by_assessment_risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`hse`.`hazard` ADD CONSTRAINT `fk_hse_hazard_parent_hazard_id` FOREIGN KEY (`parent_hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`hse` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`hse` SET TAGS ('dbx_domain' = 'hse');
ALTER TABLE `mining_ecm`.`hse`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`hse`.`incident` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `activity_being_performed` SET TAGS ('dbx_business_glossary_term' = 'Activity Being Performed');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `affected_media` SET TAGS ('dbx_business_glossary_term' = 'Affected Media');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `containment_actions` SET TAGS ('dbx_business_glossary_term' = 'Containment Actions');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `days_lost` SET TAGS ('dbx_business_glossary_term' = 'Days Lost');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `environmental_volume_released` SET TAGS ('dbx_business_glossary_term' = 'Environmental Volume Released');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `immediate_cause` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|investigation_complete|closed|regulatory_submitted');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `injury_body_part` SET TAGS ('dbx_business_glossary_term' = 'Injury Body Part');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Injury Nature');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `investigation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `investigation_methodology` SET TAGS ('dbx_value_regex' = 'icam|bow_tie|five_why|root_cause_tree|taproot|not_applicable');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `investigation_report_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Report Status');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `investigation_report_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|draft|final|approved');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `ltifr_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury Frequency Rate (LTIFR) Contribution Flag');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `permit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Reference Number');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `regulatory_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Deadline');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `remediation_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Description');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `mining_ecm`.`hse`.`incident` ALTER COLUMN `trifr_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Total Recordable Injury Frequency Rate (TRIFR) Contribution Flag');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|improvement|observation');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Cost');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By Name');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Action Closure Date');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Action Comments');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `communication_required` SET TAGS ('dbx_business_glossary_term' = 'Communication Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_yet_assessed');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Cost');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `hierarchy_of_controls` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy of Controls Classification');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `hierarchy_of_controls` SET TAGS ('dbx_value_regex' = 'elimination|substitution|engineering|administrative|ppe');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `interim_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Interim Action Taken');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `sop_updated` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Updated Flag');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `source_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Source Trigger Type');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|audit|observation|document_review|testing|measurement');
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard ID');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `superseded_by_assessment_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Assessment ID');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `affected_personnel_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Personnel Count');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Rejected|Expired|Superseded');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'JSA|TRA|HIRA|HAZOP|FMEA|Bow Tie');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Comments');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `control_adequacy_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Adequacy Rating');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `control_adequacy_rating` SET TAGS ('dbx_value_regex' = 'Inadequate|Adequate|Effective');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `control_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Control Hierarchy Level');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `control_hierarchy_level` SET TAGS ('dbx_value_regex' = 'Elimination|Substitution|Engineering|Administrative|PPE');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `hazard_category` SET TAGS ('dbx_value_regex' = 'Physical|Chemical|Biological|Ergonomic|Psychosocial|Environmental');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `hazard_source` SET TAGS ('dbx_business_glossary_term' = 'Hazard Source');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `inherent_consequence_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Consequence Rating');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `inherent_consequence_rating` SET TAGS ('dbx_value_regex' = 'Insignificant|Minor|Moderate|Major|Catastrophic');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood Rating');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('dbx_value_regex' = 'Rare|Unlikely|Possible|Likely|Almost Certain');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Level');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Extreme');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `residual_consequence_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Consequence Rating');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `residual_consequence_rating` SET TAGS ('dbx_value_regex' = 'Insignificant|Minor|Moderate|Major|Catastrophic');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_value_regex' = 'Rare|Unlikely|Possible|Likely|Almost Certain');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Extreme');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `risk_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Status');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `risk_acceptance_status` SET TAGS ('dbx_value_regex' = 'Accepted|Not Accepted|Conditional');
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ALTER COLUMN `work_area` SET TAGS ('dbx_business_glossary_term' = 'Work Area');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation ID');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `fatigue_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Indicator Flag');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `follow_up_action_description` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Action Description');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `leading_indicator_category` SET TAGS ('dbx_business_glossary_term' = 'Leading Indicator Category');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_description` SET TAGS ('dbx_business_glossary_term' = 'Observation Description');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_number` SET TAGS ('dbx_business_glossary_term' = 'Observation Number');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_number` SET TAGS ('dbx_value_regex' = '^OBS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_value_regex' = 'open|under_review|action_assigned|closed|cancelled');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Type');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_value_regex' = 'safe_act|unsafe_act|safe_condition|unsafe_condition|fatigue_declaration|positive_recognition');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observed_person_name` SET TAGS ('dbx_business_glossary_term' = 'Observed Person Name');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observed_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observed_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_business_glossary_term' = 'Observer Name');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_business_glossary_term' = 'Observer Role');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_value_regex' = 'supervisor|safety_officer|worker|contractor|visitor');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `photo_attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Uniform Resource Locator (URL)');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `ppe_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Flag');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `stop_work_authority_exercised_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Work Authority Exercised Flag');
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ALTER COLUMN `work_activity` SET TAGS ('dbx_business_glossary_term' = 'Work Activity');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring ID');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `production_drillhole_id` SET TAGS ('dbx_business_glossary_term' = 'Production Drillhole Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `rehabilitation_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'field_measurement|laboratory_analysis|continuous_monitor|scada|manual_entry');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `laboratory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Reference Number');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_point_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Code');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_point_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_point_name` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Name');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Status');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|pending_analysis|validated|rejected|under_investigation');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Type');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `parameter_measured` SET TAGS ('dbx_business_glossary_term' = 'Parameter Measured');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `permit_limit` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `record_created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `record_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sampled_by` SET TAGS ('dbx_business_glossary_term' = 'Sampled By');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sampling_datetime` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date and Time');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `validation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Validation Date and Time');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_validated|validated|rejected|requires_resampling');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `wind_direction` SET TAGS ('dbx_business_glossary_term' = 'Wind Direction');
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ALTER COLUMN `wind_speed_mps` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Meters Per Second)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit ID');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `rehabilitation_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|conditional_compliance|not_assessed');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `enforcement_action_description` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Description');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `financial_assurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `next_reporting_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reporting Due Date');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `non_compliance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Count');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `permit_conditions_summary` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions Summary');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `permit_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit Document Reference');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|under_renewal|cancelled|pending_approval');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'water_licence|air_emission_permit|waste_discharge_approval|environmental_protection_order|mining_lease|exploration_licence');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `regulated_activity` SET TAGS ('dbx_business_glossary_term' = 'Regulated Activity');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_submission|submitted|under_review|approved|rejected');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|event_based|as_required');
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ALTER COLUMN `responsible_owner` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Application Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `rehabilitation_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `royalty_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `acknowledgement_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Received Flag');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `acknowledgement_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Reference');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Submission Frequency');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `response_comments` SET TAGS ('dbx_business_glossary_term' = 'Response Comments');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `response_outcome` SET TAGS ('dbx_business_glossary_term' = 'Response Outcome');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `response_outcome` SET TAGS ('dbx_value_regex' = 'Approved|Conditionally Approved|Rejected|Requires Revision|Under Review|No Action Required');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `response_received` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_description` SET TAGS ('dbx_business_glossary_term' = 'Submission Description');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Electronic Portal|Email|Postal Mail|In-Person|Courier|Other');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) ID');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `assembly_point_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Assembly Point');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `assembly_point_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Assembly Point');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `drill_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Compliance Status');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `drill_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|overdue|not_required|scheduled');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `drill_frequency_required_months` SET TAGS ('dbx_business_glossary_term' = 'Drill Frequency Required (Months)');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Emergency Contact');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_primary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_primary` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Emergency Contact');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_secondary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `emergency_contact_secondary` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `equipment_resources` SET TAGS ('dbx_business_glossary_term' = 'Emergency Equipment Resources');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `external_agency_contacts` SET TAGS ('dbx_business_glossary_term' = 'External Agency Contacts');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `external_agency_contacts` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `external_agency_contacts` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drill Date');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `next_drill_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Drill Due Date');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) Code');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^ERP-[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) Name');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) Status');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) Type');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'site_wide|area_specific|scenario_specific|regulatory_mandated|corporate_standard|contractor_specific');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `response_procedures` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedures');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `scenario_category` SET TAGS ('dbx_business_glossary_term' = 'Emergency Scenario Category');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `scenario_category` SET TAGS ('dbx_value_regex' = 'underground_entrapment|explosives_incident|tailings_dam_failure|chemical_spill|fire|medical_emergency');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Emergency Scenario Description');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `mining_ecm`.`hse`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`hse`.`training_record` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Training Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed|pending');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'attended|absent|partial|excused');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `competency_level` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|expert');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|on_the_job|simulation|blended');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `pass_threshold` SET TAGS ('dbx_business_glossary_term' = 'Pass Threshold');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `refresher_due_date` SET TAGS ('dbx_business_glossary_term' = 'Refresher Due Date');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `training_code` SET TAGS ('dbx_business_glossary_term' = 'Training Code');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|expired');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `training_title` SET TAGS ('dbx_business_glossary_term' = 'Training Title');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'induction|statutory|refresher|competency|emergency_response|ppe');
ALTER TABLE `mining_ecm`.`hse`.`training_record` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Months');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register ID');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `chemical_register_status` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Status');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `chemical_register_status` SET TAGS ('dbx_value_regex' = 'active|inactive|restricted|phased_out|pending_approval');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `chemical_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Type');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `current_inventory_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current Inventory Quantity');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Number');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `environmental_impact_notes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Notes');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `first_registered_date` SET TAGS ('dbx_business_glossary_term' = 'First Registered Date');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Pictogram Codes');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `handling_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Handling Procedure Reference');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `hazard_statement_codes` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statement Codes');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `health_hazard_summary` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Summary');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `health_hazard_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `health_hazard_summary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `incompatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Materials');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `inventory_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Inventory Unit of Measure');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `inventory_unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|L|tonne|m3|unit');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `maximum_inventory_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inventory Quantity');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `precautionary_statement_codes` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement Codes');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `regulatory_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Flag');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `regulatory_threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Type');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Area Type');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_value_regex' = 'indoor_warehouse|outdoor_compound|refrigerated|flammable_cabinet|explosives_magazine|bulk_tank');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `usage_purpose` SET TAGS ('dbx_business_glossary_term' = 'Usage Purpose');
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ALTER COLUMN `waste_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Classification Code');
ALTER TABLE `mining_ecm`.`hse`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`hse`.`audit` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|report_issued|closed');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_audit|external_audit|certification_audit|regulatory_compliance_audit|icmm_performance_audit|workplace_inspection');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Certification Outcome');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_value_regex' = 'certified|not_certified|conditional_certification|surveillance_passed|recertification_passed');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `checklist_used` SET TAGS ('dbx_business_glossary_term' = 'Checklist Used');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Conformance Count');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `environmental_permit_verified` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Verified');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `equipment_inspected` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inspected');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `major_nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Major Non-Conformance Count');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `minor_nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Non-Conformance Count');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `ppe_compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Verified');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Document Reference');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `mining_ecm`.`hse`.`audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `mining_ecm`.`hse`.`investigation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`hse`.`investigation` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`investigation` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`hse`.`hazard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`hse`.`hazard` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `mining_ecm`.`hse`.`hazard` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identifier');
ALTER TABLE `mining_ecm`.`hse`.`hazard` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`hse`.`hazard` ALTER COLUMN `parent_hazard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
