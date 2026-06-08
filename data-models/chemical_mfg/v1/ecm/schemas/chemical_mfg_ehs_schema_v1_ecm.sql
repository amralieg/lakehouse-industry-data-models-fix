-- Schema for Domain: ehs | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`ehs` COMMENT 'Environment, Health, and Safety (EHS) domain managing workplace safety, environmental compliance, incident management, and regulatory reporting. Includes safety incidents, near-misses, PSM/HAZOP records, PHA documentation, VOC/HAP emissions tracking, TRI reporting, OSHA recordkeeping, EPA regulatory submissions, chemical exposure monitoring, waste disposal records, and ISO 14001/ISO 45001 audit trails. Integrates with Intelex EHS Management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Unique system-generated identifier for the safety incident record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier Safety Performance Tracking links safety incidents to the carrier involved, enabling carrier compliance metrics and OSHA reporting.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Safety incident reports must link to the CAS registry to retrieve official hazard classifications for the reported chemical.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Incident reports must link to the specific chemical product for root‑cause analysis and regulatory reporting (OSHA, EPA).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating incident-related costs to the responsible cost center for budgeting and regulatory cost reporting.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: INCIDENT MANAGEMENT: Safety incident reports must record the equipment involved for root‑cause analysis and regulatory reporting.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: INCIDENT REPORTING: Safety incident reports must reference the specific formula being produced to assess product‑specific hazards and corrective actions.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the physical location (plant, site, area) where the incident occurred.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Transport Safety Incident Reporting requires linking each safety incident to the shipment during which it occurred for root‑cause analysis and regulatory reporting.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Required for incident investigation to trace the specific lot that caused the safety incident, enabling recall and root‑cause analysis.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Safety Incident Reporting requires linking each incident to the manufacturing order that caused it for root‑cause analysis and regulatory reporting.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Incident tracking uses the material master record to access detailed specifications, storage, and compliance data for the affected raw material.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who initially reported the incident.',
    `product_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Regulatory incident reports must reference the specific sales order that caused the safety incident for traceability and liability analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Root‑cause analysis ties each safety incident to the specific PO that delivered the offending material, supporting supplier audits and compliance reporting.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Incident reporting for R&D projects requires linking each safety incident to its project for risk tracking and regulatory compliance.',
    `tertiary_safety_investigation_lead_employee_id` BIGINT COMMENT 'Identifier of the employee leading the incident investigation.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle. Business justification: Vehicle Accident Investigation requires associating safety incidents with the specific vehicle to analyze fleet safety and maintenance needs.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Regulatory incident reports require identifying the responsible supplier of the hazardous material, enabling supplier performance tracking and corrective actions.',
    `attachments_flag` BOOLEAN COMMENT 'True if supporting documents or media are attached to the incident record.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of the corrective action.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action plan is needed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was initially created.',
    `department` STRING COMMENT 'Organizational department responsible for the area where the incident happened.',
    `environmental_impact_flag` BOOLEAN COMMENT 'True if the incident resulted in an environmental release or impact.',
    `exposure_concentration` DECIMAL(18,2) COMMENT 'Measured concentration of the chemical exposure.',
    `exposure_exceedance_flag` BOOLEAN COMMENT 'True if measured concentration exceeds the regulatory threshold.',
    `exposure_measurement_type` STRING COMMENT 'Method used to measure chemical exposure.. Valid values are `personal_air|area_monitoring|biological`',
    `exposure_threshold` DECIMAL(18,2) COMMENT 'Regulatory threshold (PEL/TLV) for the measured chemical.',
    `exposure_units` STRING COMMENT 'Units of the exposure concentration measurement.. Valid values are `ppm|mg_m3|µg_m3`',
    `first_aid_provided` BOOLEAN COMMENT 'Indicates whether first‑aid was administered on site.',
    `follow_up_actions` STRING COMMENT 'Planned or completed actions to prevent recurrence.',
    `incident_number` STRING COMMENT 'Business identifier assigned to the incident for external reference and tracking.',
    `incident_type` STRING COMMENT 'Classification of the incident (e.g., injury, near‑miss, chemical exposure).. Valid values are `injury|illness|near_miss|property_damage|process_safety|chemical_exposure`',
    `injury_type` STRING COMMENT 'Specific type of injury or health effect resulting from the incident.. Valid values are `laceration|burn|fracture|sprain|chemical_exposure|other`',
    `investigation_completed_date` DATE COMMENT 'Date when the investigation was formally closed.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation.. Valid values are `not_started|in_progress|completed`',
    `lost_time_days` STRING COMMENT 'Number of full days of work lost due to the incident.',
    `lost_time_hours` STRING COMMENT 'Additional hours of work lost beyond full days.',
    `medical_treatment_required` BOOLEAN COMMENT 'Indicates whether professional medical treatment was required.',
    `number_of_affected` STRING COMMENT 'Count of individuals impacted (injured, ill, or exposed) by the incident.',
    `occurrence_timestamp` TIMESTAMP COMMENT 'Date and time when the incident actually occurred.',
    `osha_recordable_flag` BOOLEAN COMMENT 'True if the incident meets OSHA recordable criteria.',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Monetary estimate of property or equipment damage caused by the incident.',
    `psm_incident_flag` BOOLEAN COMMENT 'True if the incident is a PSM‑related event (e.g., loss of containment).',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the incident must be reported to OSHA or other regulators.',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first reported into the system.',
    `root_cause_category` STRING COMMENT 'High‑level category describing the primary cause of the incident. [ENUM-REF-CANDIDATE: equipment|human_error|procedure|material|environment|management|other — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the root cause analysis findings.',
    `safety_incident_status` STRING COMMENT 'Current lifecycle status of the incident record.. Valid values are `open|investigating|closed|reopened`',
    `severity_level` STRING COMMENT 'Severity rating of the incident based on impact and regulatory criteria.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident record.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Master record for all workplace safety incidents, near-misses, first-aid events, and occupational chemical exposure monitoring at Chemical Mfg facilities. Captures incident type (injury, illness, near-miss, property damage, process safety, chemical exposure), severity classification (OSHA recordable, lost-time, first-aid), incident date/time, location, affected personnel, initial description, root cause category, and regulatory reportability flags. For chemical exposure events: captures substance (CAS number), exposure measurement type (personal air sampling, area monitoring, biological monitoring), measured concentration, OSHA PEL/ACGIH TLV threshold, exceedance flag, and required follow-up. Integrates with Intelex EHS Management. Supports OSHA 300/300A recordkeeping, PSM incident reporting, and OSHA 1910.1000 air contaminants compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` (
    `incident_investigation_id` BIGINT COMMENT 'System-generated unique identifier for the incident investigation record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tracks investigation expenses against the cost center responsible for the incident, enabling accurate financial reporting.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the primary investigator leading the effort.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the physical location where the incident occurred.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational department responsible for the area of the incident.',
    `production_deviation_id` BIGINT COMMENT 'Foreign key linking to production.production_deviation. Business justification: Investigations of safety incidents are often triggered by a specific production deviation; linking provides traceability for CAPA.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Investigations are performed per R&D project; linking enables project‑level corrective actions and audit trails.',
    `safety_incident_id` BIGINT COMMENT 'Identifier of the safety incident or near‑miss that triggered this investigation.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: CORRECTIVE ACTION: Investigations often create a work order to implement corrective actions; linking enables traceability.',
    `closure_reason` STRING COMMENT 'Reason provided for closing the investigation (e.g., resolved, withdrawn).',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation was marked complete.',
    `contributing_factors` STRING COMMENT 'Identified factors that contributed to the incident but are not direct causes.',
    `corrective_action_recommendations` STRING COMMENT 'Proposed actions to prevent recurrence of the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the estimated loss amount.',
    `direct_cause` STRING COMMENT 'Immediate cause that directly led to the incident.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Monetary estimate of loss or cost associated with the incident.',
    `follow_up_actions` STRING COMMENT 'Planned or completed actions that follow the investigation recommendations.',
    `impact_area` STRING COMMENT 'Business domain most affected by the incident.. Valid values are `safety|environment|quality|production`',
    `incident_investigation_status` STRING COMMENT 'Current lifecycle status of the investigation.. Valid values are `open|in_progress|completed|closed|cancelled`',
    `investigation_description` STRING COMMENT 'Detailed narrative describing the context, scope, and background of the investigation.',
    `investigation_number` STRING COMMENT 'External reference number assigned to the investigation for tracking and reporting.',
    `investigation_title` STRING COMMENT 'Brief title summarizing the focus of the investigation.',
    `investigation_type` STRING COMMENT 'Classification of the investigation based on the nature of the event.. Valid values are `root_cause|near_miss|hazard|process_deviation`',
    `investigator_team_ids` STRING COMMENT 'Comma‑separated list of employee IDs participating in the investigation.',
    `is_closed` BOOLEAN COMMENT 'Indicates whether the investigation has been formally closed.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the investigation findings.',
    `methodology` STRING COMMENT 'Methodology used to conduct the root‑cause analysis.. Valid values are `five_why|fault_tree|hazop|fishbone`',
    `priority` STRING COMMENT 'Priority level assigned to the investigation based on risk and impact.. Valid values are `low|medium|high|critical`',
    `regulatory_submission_date` DATE COMMENT 'Date on which the regulatory submission was made, if applicable.',
    `regulatory_submission_status` STRING COMMENT 'Status of any required regulatory filing related to the investigation.. Valid values are `not_submitted|submitted|approved|rejected`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating derived from severity, likelihood, and exposure.',
    `root_cause` STRING COMMENT 'Fundamental underlying cause(s) identified through analysis.',
    `severity_level` STRING COMMENT 'Severity classification of the incident impact.. Valid values are `low|medium|high|critical`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation was formally started.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the investigation record.',
    CONSTRAINT pk_incident_investigation PRIMARY KEY(`incident_investigation_id`)
) COMMENT 'Detailed root cause investigation record linked to a safety incident or near-miss. Captures investigation team members, RCI (Root Cause Investigation) methodology used (5-Why, Fault Tree, HAZOP-based), contributing factors, direct and root causes, corrective action recommendations, investigation completion date, and regulatory submission status. Supports PSM incident investigation requirements under OSHA 29 CFR 1910.119 and ISO 45001 audit trails.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` (
    `capa_record_id` BIGINT COMMENT 'System-generated unique identifier for the CAPA record.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Coordinated corrective actions: EHS CAPA records often reference the same quality CAPA record to ensure aligned safety and quality remediation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charges CAPA corrective action costs to the appropriate cost center for cost control and compliance budgeting.',
    `functional_location_id` BIGINT COMMENT 'Reference to the plant, facility, or site where the CAPA originates.',
    `management_of_change_id` BIGINT COMMENT 'Identifier of the MOC record linked to this CAPA, if applicable.',
    `owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_capa_employee_id` BIGINT COMMENT 'Identifier of the internal party (person or team) responsible for executing the CAPA.',
    `safety_incident_id` BIGINT COMMENT 'Identifier of the safety or quality incident that generated this CAPA.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: CAPA EXECUTION: Each CAPA may be executed via one or more work orders; linking provides execution tracking.',
    `action_type` STRING COMMENT 'Indicates whether the record documents a corrective action or a preventive action.. Valid values are `corrective|preventive`',
    `attached_document_count` STRING COMMENT 'Number of supporting documents attached to the CAPA record.',
    `capa_record_status` STRING COMMENT 'Current lifecycle state of the CAPA record.. Valid values are `open|in_progress|closed|cancelled`',
    `closure_reason` STRING COMMENT 'Reason why the CAPA was closed (e.g., completed, withdrawn, not applicable).',
    `completion_date` DATE COMMENT 'Actual date when the CAPA was closed.',
    `compliance_status` STRING COMMENT 'Current compliance status of the CAPA with the referenced regulation.. Valid values are `compliant|non_compliant|pending`',
    `corrective_action_description` STRING COMMENT 'Detailed steps to correct the identified non‑conformance.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual financial cost incurred for the CAPA.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Projected financial cost to implement the CAPA.',
    `department` STRING COMMENT 'Business department that owns the CAPA (e.g., Production, Quality, Maintenance).',
    `due_date` DATE COMMENT 'Target date by which the CAPA must be completed.',
    `effectiveness_rating` STRING COMMENT 'Result of the effectiveness review after CAPA closure.. Valid values are `effective|partially_effective|ineffective`',
    `effectiveness_review_date` DATE COMMENT 'Date when the effectiveness of the CAPA was evaluated.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the CAPA was formally initiated.',
    `is_external` BOOLEAN COMMENT 'True if external consultants or contractors are involved in the CAPA.',
    `last_modified_by` STRING COMMENT 'User identifier who last updated the CAPA record.',
    `notes` STRING COMMENT 'Free‑form notes captured by the owner or reviewers.',
    `preventive_action_description` STRING COMMENT 'Detailed steps to prevent recurrence of the issue.',
    `priority` STRING COMMENT 'Business priority assigned to the CAPA.. Valid values are `high|medium|low`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the CAPA record.',
    `regulatory_reference` STRING COMMENT 'Regulatory framework or standard that prompted the CAPA (e.g., OSHA, EPA).. Valid values are `OSHA|EPA|ISO45001|ISO14001|REACH|GHS`',
    `review_comments` STRING COMMENT 'Comments entered during the effectiveness review.',
    `root_cause_description` STRING COMMENT 'Narrative description of the underlying cause that triggered the CAPA.',
    `severity` STRING COMMENT 'Severity level of the original issue that triggered the CAPA.. Valid values are `critical|major|minor|trivial`',
    `verification_method` STRING COMMENT 'Method used to verify that the CAPA was effective.. Valid values are `inspection|audit|test|review`',
    `created_by` STRING COMMENT 'User identifier who initially created the CAPA record.',
    CONSTRAINT pk_capa_record PRIMARY KEY(`capa_record_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record tracking remediation actions arising from safety incidents, near-misses, audit findings, inspection citations, or regulatory observations at Chemical Mfg facilities. Captures action description, action type (corrective vs. preventive), responsible owner, priority, due date, completion date, verification method, effectiveness review outcome, and linkage to originating incident, inspection finding, or MOC. Supports ISO 45001 continual improvement (Clause 10.2), ISO 14001 nonconformity management, OSHA PSM follow-up, and Responsible Care management system requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` (
    `hazop_study_id` BIGINT COMMENT 'System‑generated unique identifier for the HAZOP study record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: HAZOP studies reference the CAS registry to ensure the correct chemical hazard profile is evaluated during process safety analysis.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: HAZOP studies are conducted per chemical process; linking to the product enables traceability of risk assessments.',
    `employee_id` BIGINT COMMENT 'Name of the primary engineer or safety professional leading the study.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: HAZOP ANALYSIS: Each Hazop study is initiated for a particular formulation to evaluate process safety risks of that product.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: HAZOP SCOPE: HAZOP studies are scoped to a functional location; linking enables location‑based risk management.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Funds Hazop studies through an internal order, linking safety analysis to the capital project financial tracking.',
    `action_due_date` DATE COMMENT 'Target completion date for the recommended actions.',
    `action_owner` STRING COMMENT 'Individual or department responsible for implementing the action.',
    `action_status` STRING COMMENT 'Current status of the recommended action.. Valid values are `open|in_progress|completed|deferred|cancelled`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the study was formally approved.',
    `control_measures` STRING COMMENT 'Engineering or administrative controls in place to mitigate identified hazards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the study record was first created.',
    `documentation_link` STRING COMMENT 'URL or path to the full HAZOP report or supporting documents.',
    `exposure_limit_ppm` DECIMAL(18,2) COMMENT 'Permissible exposure limit for the chemical expressed in parts per million.',
    `hazard_classifications` STRING COMMENT 'GHS hazard classes and pictograms applicable to the chemical.',
    `hazop_study_status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `draft|in_review|approved|revalidated|closed`',
    `inventory_unit` STRING COMMENT 'Unit of measure for the maximum intended inventory.. Valid values are `kg|lb|ton`',
    `last_reviewed_by` STRING COMMENT 'Name of the person who performed the most recent review of the study.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent review.',
    `max_intended_inventory` DECIMAL(18,2) COMMENT 'Maximum quantity of the chemical intended to be stored in the unit (numeric value).',
    `methodology` STRING COMMENT 'Specific analytical approach applied (Guideword‑based HAZOP, What‑If, Checklist, LOPA).. Valid values are `Guideword|What-If|Checklist|LOPA`',
    `notes` STRING COMMENT 'Additional free‑form comments or observations captured during the study.',
    `overall_risk_rank` STRING COMMENT 'Aggregated risk ranking for the study based on likelihood and severity.. Valid values are `low|moderate|high|critical`',
    `physical_state` STRING COMMENT 'Physical state of the chemical at operating conditions.. Valid values are `solid|liquid|gas|plasma`',
    `plant_location` STRING COMMENT 'Identifier of the manufacturing plant or site where the study was performed.',
    `process_unit_code` BIGINT COMMENT 'Unique identifier of the process unit (e.g., reactor, distillation column) examined in the study.',
    `process_unit_name` STRING COMMENT 'Human‑readable name of the process unit covered by the study.',
    `recommended_actions` STRING COMMENT 'Summary of corrective or preventive actions proposed by the study.',
    `regulatory_framework` STRING COMMENT 'Regulatory program(s) governing the study (e.g., OSHA PSM, EPA RMP).. Valid values are `OSHA_PSM|EPA_RMP|ISO_45001|ISO_14001|REACH|GHS`',
    `revalidation_date` DATE COMMENT 'Date of the most recent revalidation or periodic review of the study.',
    `risk_likelihood` STRING COMMENT 'Numeric rating (1‑5) of the likelihood of identified hazards.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score (likelihood × severity) for each node or overall.',
    `risk_severity` STRING COMMENT 'Numeric rating (1‑5) of the severity of potential consequences.',
    `scope_description` STRING COMMENT 'Narrative description of the functional and physical scope of the HAZOP study.',
    `study_code` STRING COMMENT 'Business identifier or reference code assigned to the study (e.g., HZP‑2024‑001).',
    `study_end_date` DATE COMMENT 'Calendar date when the HAZOP study activities were completed.',
    `study_start_date` DATE COMMENT 'Calendar date when the HAZOP study activities commenced.',
    `study_title` STRING COMMENT 'Descriptive title of the HAZOP study.',
    `study_type` STRING COMMENT 'Methodology used for the study (HAZOP, What‑If, LOPA, Checklist).. Valid values are `HAZOP|What-If|LOPA|Checklist`',
    `team_members` STRING COMMENT 'Comma‑separated list of participants (engineers, operators, safety specialists).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the study record.',
    CONSTRAINT pk_hazop_study PRIMARY KEY(`hazop_study_id`)
) COMMENT 'Process safety master record encompassing Process Safety Information (PSI), Hazard and Operability (HAZOP) studies, Process Hazard Analyses (PHA), and granular study nodes for chemical process units at Chemical Mfg plants. PSI content: chemical identity (CAS number), maximum intended inventory, physical/chemical properties, reactivity hazards, corrosivity data, thermal stability, P&ID references, equipment design specifications, safe operating limits. Study content: study scope, process unit reference, team composition, methodology (HAZOP, What-If, Checklist, LOPA), study/revalidation dates, overall risk ranking. Node-level detail: node identifier, design intent, guide words (No, More, Less, Reverse, Other Than), deviations, causes, consequences, safeguards, risk rankings (likelihood × severity), recommended actions. Required under OSHA PSM 29 CFR 1910.119(d) and (e) and EPA RMP 40 CFR Part 68. Integrates with Intelex EHS Management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` (
    `hazop_node_id` BIGINT COMMENT 'System-generated unique identifier for the HAZOP node.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Each HAZOP node references the chemical product to evaluate deviations and safeguards.',
    `employee_id` BIGINT COMMENT 'Individual or team responsible for implementing the recommended action.',
    `equipment_id` BIGINT COMMENT 'Identifier of equipment associated with the node, if applicable.',
    `hazop_study_id` BIGINT COMMENT 'Identifier of the parent HAZOP study to which this node belongs.',
    `action_due_date` DATE COMMENT 'Target date for completion of the recommended action.',
    `cause` STRING COMMENT 'Root cause analysis for the identified deviation.',
    `compliance_status` STRING COMMENT 'Current compliance status of the node with relevant regulations.. Valid values are `compliant|non_compliant|pending|exempt|under_review`',
    `consequence` STRING COMMENT 'Possible outcome or impact if the deviation occurs.',
    `control_strategy` STRING COMMENT 'Description of the control strategy applied at this node.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the HAZOP node record was first created.',
    `design_intent` STRING COMMENT 'Description of the intended operation or purpose of the process at this node.',
    `existing_safeguard` STRING COMMENT 'Current safeguards or controls that mitigate the deviation.',
    `exposure_limit` DECIMAL(18,2) COMMENT 'Maximum allowable exposure limit for the identified hazard.',
    `exposure_unit` STRING COMMENT 'Unit of measure for the exposure limit (e.g., ppm, mg/m³).',
    `guide_words` STRING COMMENT 'Guide words applied to the node (e.g., No, More, Less, Reverse, Other Than).',
    `hazard_type` STRING COMMENT 'Category of hazard associated with the node.. Valid values are `chemical|physical|biological|ergonomic|psychosocial`',
    `hazop_node_status` STRING COMMENT 'Current lifecycle status of the node within the HAZOP workflow.. Valid values are `open|closed|in_review|approved|rejected`',
    `identified_deviation` STRING COMMENT 'Specific deviation from the design intent identified during the HAZOP.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the node is considered critical to safety or operation.',
    `likelihood` STRING COMMENT 'Qualitative likelihood rating for the deviation.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `mitigation_due_date` DATE COMMENT 'Target date for completing mitigation actions.',
    `mitigation_owner` STRING COMMENT 'Person or team responsible for mitigation actions.',
    `mitigation_status` STRING COMMENT 'Current status of the mitigation actions for the node.. Valid values are `not_started|in_progress|completed|deferred|cancelled`',
    `node_code` STRING COMMENT 'Business identifier or code assigned to the node within the HAZOP study.',
    `node_label` STRING COMMENT 'Human‑readable name of the HAZOP node, e.g., "Reactor Feed Section".',
    `node_location` STRING COMMENT 'Physical location or plant area where the node is situated.',
    `node_type` STRING COMMENT 'Classification of the node based on its function in the process.. Valid values are `process_section|equipment|control_logic|instrumentation|utility`',
    `recommended_action` STRING COMMENT 'Proposed corrective or preventive action to address the deviation.',
    `regulatory_reference` STRING COMMENT 'Regulatory standard(s) (e.g., OSHA, EPA) applicable to the node.',
    `review_date` DATE COMMENT 'Date when the node was last reviewed.',
    `reviewed_by` STRING COMMENT 'Name of the person who performed the latest review of the node.',
    `risk_rank` STRING COMMENT 'Overall risk ranking derived from likelihood and severity.. Valid values are `low|medium|high|very_high|extreme`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk ranking (likelihood × severity) expressed as a decimal.',
    `safety_category` STRING COMMENT 'Safety domain to which the node belongs.. Valid values are `process|facility|environment|health|security`',
    `severity` STRING COMMENT 'Qualitative severity rating for the consequence.. Valid values are `minor|moderate|major|critical|catastrophic`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the HAZOP node record.',
    CONSTRAINT pk_hazop_node PRIMARY KEY(`hazop_node_id`)
) COMMENT 'Individual HAZOP study node (process section or design intent) within a parent HAZOP study. Captures node identifier, process description, design intent, guide words applied (No, More, Less, Reverse, Other Than), identified deviations, causes, consequences, existing safeguards, risk ranking (likelihood × severity), and recommended actions. Provides granular PHA documentation required for OSHA PSM compliance and EPA RMP submissions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` (
    `chemical_exposure_record_id` BIGINT COMMENT 'System‑generated unique identifier for each chemical exposure monitoring record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: Employee chemical exposure is evaluated per batch to assess health risk and comply with occupational safety regulations.',
    `cas_registry_id` BIGINT COMMENT 'Unique identifier for the chemical substance being monitored.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Employee exposure logs need the exact chemical product to drive health surveillance and OSHA recordkeeping.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or worker whose exposure is being recorded.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: EXPOSURE MONITORING: Employee exposure records are tied to the specific formulation handled to assess product‑specific health risks.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: EXPOSURE MONITORING: Exposure records are tied to the location where sampling occurred; linking supports compliance reporting.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Needed to associate employee exposure measurements with the exact production lot, supporting regulatory compliance and exposure tracking.',
    `equipment_id` BIGINT COMMENT 'Identifier of the equipment used for sampling (e.g., pump, sampler model).',
    `sampling_point_id` BIGINT COMMENT 'Identifier of the specific location or point where the sample was taken.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Chemical exposure incidents are recorded per work site to satisfy OSHA/TSCA health‑safety reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Exposure monitoring records the supplier of the chemical to assess supplier compliance, risk, and to trigger supplier‑specific corrective actions.',
    `analytical_method` STRING COMMENT 'Laboratory technique used to analyze the sample (e.g., GC‑MS, FTIR).',
    `batch_number` STRING COMMENT 'Lot or batch identifier associated with the sampled material, if applicable.',
    `compliance_status` STRING COMMENT 'Indicates whether the exposure measurement complies with the referenced limit.. Valid values are `compliant|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the exposure record was first entered into the system.',
    `department` STRING COMMENT 'Department or functional area where the employee works (e.g., Production, Maintenance).',
    `employee_role` STRING COMMENT 'Job role of the employee at the time of exposure (e.g., Operator, Maintenance Technician).',
    `exceedance_flag` BOOLEAN COMMENT 'True if measured concentration exceeds the regulatory limit.',
    `exposure_category` STRING COMMENT 'Primary route of exposure for the chemical.. Valid values are `inhalation|dermal|ocular`',
    `exposure_duration_minutes` STRING COMMENT 'Length of time the employee was potentially exposed during the sampling interval.',
    `exposure_source` STRING COMMENT 'Narrative description of the source of the chemical (e.g., vent, process line).',
    `exposure_status` STRING COMMENT 'Overall status of the exposure event based on measurement and limits.. Valid values are `normal|exceedance|follow_up_required`',
    `exposure_type` STRING COMMENT 'Method used to collect the exposure data: personal air sampling, area monitoring, or biological monitoring.. Valid values are `personal_air|area_monitoring|biological`',
    `follow_up_action` STRING COMMENT 'Prescribed corrective or preventive action when an exceedance occurs.',
    `limit_unit` STRING COMMENT 'Unit of the regulatory limit value.. Valid values are `ppm|mg/m3|µg/m3`',
    `limit_value` DECIMAL(18,2) COMMENT 'Applicable occupational exposure limit (e.g., OSHA PEL or ACGIH TLV) for the chemical.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact date and time when the exposure measurement was taken.',
    `measurement_unit` STRING COMMENT 'Unit of the measured concentration (parts per million, milligrams per cubic meter, micrograms per cubic meter).. Valid values are `ppm|mg/m3|µg/m3`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric result of the exposure measurement.',
    `notes` STRING COMMENT 'Additional observations, comments, or contextual information captured by the sampler.',
    `plant_location` STRING COMMENT 'Name of the manufacturing plant or site where the exposure sampling occurred.',
    `ppe_used` BOOLEAN COMMENT 'Indicates whether appropriate PPE was worn during sampling.',
    `record_status` STRING COMMENT 'Current lifecycle status of the record.. Valid values are `active|inactive|archived`',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or guideline (e.g., OSHA PEL, ACGIH TLV) that applies.',
    `risk_category` STRING COMMENT 'Risk classification derived from exposure level and job function.. Valid values are `low|medium|high`',
    `sampling_date` DATE COMMENT 'Calendar date on which the sample was collected.',
    `shift` STRING COMMENT 'Work shift during which the exposure occurred.. Valid values are `day|night|swing`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the record.',
    CONSTRAINT pk_chemical_exposure_record PRIMARY KEY(`chemical_exposure_record_id`)
) COMMENT 'Occupational chemical exposure monitoring record for workers at Chemical Mfg facilities. Captures employee or job role, chemical substance (CAS number), exposure measurement type (personal air sampling, area monitoring, biological monitoring), measured concentration (PPM, mg/m³), OSHA PEL/ACGIH TLV threshold, exceedance flag, sampling date, analytical method, and required follow-up actions. Supports OSHA 1910.1000 air contaminants compliance and industrial hygiene programs.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` (
    `emission_event_id` BIGINT COMMENT 'System-generated unique identifier for each emission event record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Emission reporting links each pollutant to its CAS registry entry for regulatory reporting and inventory reconciliation.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Emission tracking ties each pollutant to its chemical product for EPA TRI and permit compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns emission monitoring and mitigation costs to the cost center responsible for the emission source.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to ehs.emission_source. Business justification: Each emission event originates from a specific emission source. Adding emission_source_id to emission_event provides a clear parent relationship.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: EMISSIONS TRACKING: Emission events are typically generated by a specific piece of equipment; linking enables source‑based reporting.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: EMISSIONS ACCOUNTING: Emission events are reported per formula version to link emissions data to the exact product batch specifications.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Required: Emission fees are billed to customers; linking emission events to the corresponding invoice supports fee calculation and regulatory reporting.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Transport Emission Tracking associates emission events with the corresponding shipment to calculate greenhouse‑gas inventory for regulatory compliance.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Regulatory emission reports are generated per production order; linking emissions to the order enables accurate tracking and compliance.',
    `product_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Emission reporting per production batch is allocated to the originating sales order to satisfy environmental permits and internal cost accounting.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Pilot‑scale emissions must be reported per project to satisfy environmental permits and internal project KPIs.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Regulatory emission reports must be tied to the specific customer site where the release occurred (EPA reporting).',
    `cause_of_release` STRING COMMENT 'Primary cause that triggered the emission event.. Valid values are `equipment_failure|human_error|natural|other`',
    `cleanup_status` STRING COMMENT 'Status of any remediation or cleanup activities.. Valid values are `pending|in_progress|completed|not_required`',
    `containment_success_flag` BOOLEAN COMMENT 'Indicates whether containment measures successfully prevented further release.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission event record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicates whether the emission data passed quality checks.',
    `data_quality_notes` STRING COMMENT 'Comments on data quality issues or anomalies.',
    `emergency_response_action` STRING COMMENT 'Description of emergency response actions taken after the event.',
    `emission_category` STRING COMMENT 'Classification of emission as point source, fugitive, or accidental.. Valid values are `point|fugitive|accidental`',
    `emission_event_status` STRING COMMENT 'Current lifecycle status of the emission event record.. Valid values are `open|closed|investigating`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor used to estimate emissions when direct measurement is unavailable.',
    `emission_factor_unit` STRING COMMENT 'Unit of the emission factor (e.g., kg/ton).',
    `emission_quantity` DECIMAL(18,2) COMMENT 'Measured amount of pollutant released during the event.',
    `emission_unit` STRING COMMENT 'Unit of measure for the emission quantity.. Valid values are `kg|ton|lb|g`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the emission event was observed or recorded.',
    `event_type` STRING COMMENT 'Category of the emission event such as routine monitoring, accidental release, or spill.. Valid values are `routine|accidental|spill`',
    `facility_code` BIGINT COMMENT 'Identifier of the plant or facility where the emission occurred.',
    `geographic_region` STRING COMMENT 'State or region code where the emission source is located.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the emission source.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the emission source.',
    `measurement_method` STRING COMMENT 'Method used to determine the emission quantity.. Valid values are `cems|stack_test|estimate|model`',
    `monitoring_frequency` STRING COMMENT 'How often the emission source is monitored.. Valid values are `continuous|daily|weekly|monthly|annual`',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `regulatory_permit_number` STRING COMMENT 'Permit identifier governing the emission source.',
    `release_media` STRING COMMENT 'Environmental medium into which the pollutant was released.. Valid values are `air|soil|water|drain`',
    `report_status` STRING COMMENT 'Current processing status of the regulatory report.. Valid values are `pending|submitted|rejected|approved`',
    `report_submission_date` DATE COMMENT 'Date the emission report was submitted to the regulator.',
    `reportable_flag` BOOLEAN COMMENT 'True if the emission event meets regulatory reporting thresholds.',
    `reporting_requirement` STRING COMMENT 'Regulatory reporting framework applicable (e.g., EPA 40 CFR 302, TRI).',
    `source_permit_limit` DECIMAL(18,2) COMMENT 'Regulatory emission limit for the source.',
    `source_permit_limit_unit` STRING COMMENT 'Unit of the permit limit (e.g., kg/year).',
    `source_reference` BIGINT COMMENT 'Identifier of the emission source (e.g., stack, vent, tank) that generated the event.',
    `source_type` STRING COMMENT 'Classification of the physical source of the emission.. Valid values are `stack|vent|tank|fugitive_point`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the emission event record.',
    CONSTRAINT pk_emission_event PRIMARY KEY(`emission_event_id`)
) COMMENT 'Comprehensive environmental emissions, releases, and source inventory record for Chemical Mfg facilities. Source inventory: all permitted and tracked emission sources (stacks, vents, fugitive equipment components, storage tanks, wastewater treatment units), source type, associated process unit, geographic coordinates, permit reference, applicable emission limits, control device linkage, monitoring frequency. Routine emissions: point-source and fugitive release quantities of VOCs, HAPs, GHGs, pollutant CAS numbers, emission factors, measurement methods (CEMS, stack test, engineering estimate). Accidental releases/spills: release date/time, chemical identity, quantity released, release media (air, soil, water, drain), cause, containment effectiveness, emergency response actions, regulatory reportability (CERCLA RQ, EPCRA 304, state spill reporting), agency notifications, cleanup status. Feeds TRI annual reporting, EPA air permit compliance, NPDES reporting, and spill notification workflows.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` (
    `emission_source_id` BIGINT COMMENT 'Unique system-generated identifier for the emission source record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Permits for emission sources are tied to the specific chemical emitted, supporting permit management and reporting.',
    `control_device_id` BIGINT COMMENT 'Identifier of the pollution control device linked to the source (e.g., scrubber, baghouse).',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: An emission source is governed by a single operating permit; many sources can share a permit. Adding operating_permit_id to emission_source creates the required inbound link.',
    `process_unit_id` BIGINT COMMENT 'Identifier of the production unit or line associated with the emission source.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Each emission source permit is owned by a plant/site; linking enables site‑level permit inventory and compliance dashboards.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the source capacity.. Valid values are `m3_per_hr|kg_per_hr`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission source record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the confidence level in the reported measurement data.. Valid values are `verified|estimated|pending`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor used to calculate emissions from process activity (e.g., kg pollutant per ton product).',
    `emission_factor_unit` STRING COMMENT 'Unit of the emission factor.. Valid values are `kg_per_ton|lb_per_ton`',
    `emission_limit_unit` STRING COMMENT 'Unit of measure for the emission limit (e.g., kilograms per hour).. Valid values are `kg_per_hr|t_per_day|lb_per_hr`',
    `emission_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable emission quantity for the source per reporting period.',
    `emission_medium` STRING COMMENT 'Environmental medium to which emissions are released.. Valid values are `air|water|soil`',
    `emission_source_description` STRING COMMENT 'Detailed free‑text description of the emission source, its function, and any special characteristics.',
    `facility_code` BIGINT COMMENT 'Identifier of the plant or site where the emission source is located.',
    `is_area_source` BOOLEAN COMMENT 'True if emissions are dispersed over an area rather than a single point.',
    `is_controlled` BOOLEAN COMMENT 'Indicates whether the source has an attached emissions control device.',
    `is_fugitive` BOOLEAN COMMENT 'True if the source represents fugitive emissions (e.g., leaks, vents).',
    `is_point_source` BOOLEAN COMMENT 'True if emissions originate from a discrete point (e.g., stack).',
    `is_reportable` BOOLEAN COMMENT 'Flag indicating if the source is subject to regulatory reporting (e.g., EPA, TRI).',
    `last_monitoring_date` DATE COMMENT 'Date the most recent monitoring measurement was recorded.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the emission source location in decimal degrees.',
    `lifecycle_status` STRING COMMENT 'Lifecycle stage of the source within the enterprise asset management process.. Valid values are `in_service|retired|maintenance|planned`',
    `location_description` STRING COMMENT 'Free‑form description of the source location (e.g., building, floor, area).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the emission source location in decimal degrees.',
    `measurement_method` STRING COMMENT 'Method used to obtain emission measurements.. Valid values are `continuous|periodic|manual`',
    `monitoring_frequency` STRING COMMENT 'Required frequency for emission monitoring of the source.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `next_monitoring_due` DATE COMMENT 'Scheduled date for the next required monitoring activity.',
    `permit_expiry_date` DATE COMMENT 'Date the emission permit expires or must be renewed.',
    `permit_issue_date` DATE COMMENT 'Date the emission permit was issued.',
    `permit_number` STRING COMMENT 'Regulatory permit identifier authorizing the emission source.',
    `reporting_category` STRING COMMENT 'Regulatory framework(s) under which the source must be reported.. Valid values are `EPA|OSHA|REACH|GHS`',
    `source_capacity` DECIMAL(18,2) COMMENT 'Maximum designed throughput or flow rate of the emission source.',
    `source_code` STRING COMMENT 'Business‑assigned alphanumeric code uniquely identifying the emission source within the enterprise.',
    `source_group` STRING COMMENT 'Logical grouping or classification of related emission sources (e.g., boiler cluster).',
    `source_name` STRING COMMENT 'Human‑readable name of the emission source as used in reports and dashboards.',
    `source_operating_hours_per_year` STRING COMMENT 'Total number of hours the source operates in a calendar year.',
    `source_owner` STRING COMMENT 'Organizational unit or department responsible for the emission source.',
    `source_status` STRING COMMENT 'Current operational status of the emission source.. Valid values are `active|inactive|decommissioned|planned`',
    `source_type` STRING COMMENT 'Classification of the source (e.g., stack, vent, fugitive equipment, storage tank, wastewater unit, process unit).. Valid values are `stack|vent|fugitive|tank|wastewater|process_unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the emission source record.',
    CONSTRAINT pk_emission_source PRIMARY KEY(`emission_source_id`)
) COMMENT 'Master record for all permitted and tracked emission sources at Chemical Mfg facilities, including stacks, vents, fugitive equipment components, storage tanks, and wastewater treatment units. Captures source ID, source type, associated process unit, geographic coordinates, permit reference, applicable emission limits, control device linkage, and monitoring frequency requirements. Serves as the SSOT for emission source inventory used in air permit compliance and TRI reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` (
    `waste_disposal_record_id` BIGINT COMMENT 'System-generated unique identifier for the waste disposal record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Waste Transport Carrier Compliance links waste disposal records to the carrier transporting waste, supporting RCRA reporting and carrier performance evaluation.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Hazardous waste manifests must reference the disposed chemical product for RCRA reporting and cost allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns waste disposal expenses to the cost center that incurred the waste, supporting cost recovery and environmental compliance accounting.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: WASTE MANAGEMENT: Waste disposal records must identify the originating formula to track waste streams and compliance per product.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Required: Invoices are generated for waste disposal services per regulatory compliance; linking each waste record to its invoice enables accurate billing and audit trails.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Linking waste disposal records to the shipment enables traceability of hazardous waste movements for EPA tracking and internal audit.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Links waste disposal entries to the originating lot for accurate hazardous waste reporting and traceability under EPA/REACH regulations.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Waste disposal must be allocated to the specific manufacturing order that generated the waste for cost accounting and environmental compliance.',
    `product_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Waste generated during order fulfillment must be linked to the order for waste‑cost tracking and regulatory disposal reporting.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Waste generated during R&D trials is tracked against the responsible project for cost allocation and compliance.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Waste disposal records must be associated with the generating site for RCRA reporting and cost allocation.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Waste disposal contracts are managed with external waste‑hauler vendors; linking waste records to vendor enables cost tracking and regulatory compliance.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: Specific waste‑processing sites are vendor locations; associating each disposal record with the vendor site supports logistics and audit trails.',
    `waste_stream_id` BIGINT COMMENT 'Reference to the master waste‑stream definition describing the type of waste.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the waste disposal transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste disposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the disposal cost (e.g., USD, EUR).',
    `disposal_facility_name` STRING COMMENT 'Name of the licensed external facility where waste was sent.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the waste.. Valid values are `landfill|incineration|recycling|treatment|recovery`',
    `disposal_number` STRING COMMENT 'Business identifier assigned to the waste disposal transaction, used for tracking and reporting.',
    `disposal_timestamp` TIMESTAMP COMMENT 'Date and time when the waste was actually disposed of or shipped for disposal.',
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste code (e.g., D001, F003) associated with the waste.',
    `facility_code` BIGINT COMMENT 'Identifier of the internal plant or external facility that generated the waste.',
    `hazardous_waste_classification` STRING COMMENT 'Classification of waste for RCRA reporting purposes.. Valid values are `hazardous|non_hazardous|mixed`',
    `inspection_date` DATE COMMENT 'Date the disposal site was inspected for compliance.',
    `inspection_report_number` STRING COMMENT 'Identifier of the post‑disposal inspection or audit report.',
    `land_disposal_restrictions_compliance` BOOLEAN COMMENT 'Indicates compliance with Land Disposal Restrictions (true) or non‑compliance (false).',
    `ldr_compliance_details` STRING COMMENT 'Free‑text description of any LDR exemptions, variances, or special conditions.',
    `manifest_number` STRING COMMENT 'Unique EPA manifest identifier for the waste shipment.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of waste disposed, expressed in the unit indicated by quantity_unit.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the disposed quantity (e.g., kilograms, pounds, gallons).. Valid values are `kg|lb|ton|gal|l`',
    `rcra_hazardous_flag` BOOLEAN COMMENT 'True if the waste is classified as hazardous under RCRA regulations.',
    `regulatory_notification_flag` BOOLEAN COMMENT 'Indicates whether required regulatory agencies were notified (true) or not (false).',
    `shipment_date` DATE COMMENT 'Date the waste shipment left the generating facility.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the waste shipment.. Valid values are `truck|rail|ship|air`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the waste disposal record.',
    `waste_batch_lot_number` STRING COMMENT 'Lot or batch identifier associated with the waste generation batch.',
    `waste_characteristics` STRING COMMENT 'Physical and chemical description of the waste (e.g., liquid, solid, pH, VOC content).',
    `waste_disposal_record_status` STRING COMMENT 'Current lifecycle status of the waste disposal record.. Valid values are `pending|approved|rejected|completed|cancelled`',
    `waste_disposal_type` STRING COMMENT 'Indicates whether the disposal was a single shipment, multiple shipments, or type unknown.. Valid values are `single|multiple|unknown`',
    `waste_generation_date` DATE COMMENT 'Date the waste was generated at the facility.',
    `waste_storage_location` STRING COMMENT 'On‑site location where waste was stored prior to disposal.',
    CONSTRAINT pk_waste_disposal_record PRIMARY KEY(`waste_disposal_record_id`)
) COMMENT 'Comprehensive waste management record for Chemical Mfg operations covering waste stream master definitions, waste characterization, and individual disposal transactions. Waste stream master data: stream name, physical/chemical description, generating process unit, EPA waste codes, RCRA hazardous waste determination, typical generation rate, approved disposal methods, storage requirements, regulatory notification status. Disposal transaction data: waste characterization, quantity generated, disposal method (landfill, incineration, recycling, treatment), licensed disposal facility, manifest number, shipment date, chain-of-custody documentation, and LDR (Land Disposal Restrictions) compliance. Supports EPA RCRA hazardous waste reporting, biennial reporting, state environmental agency submissions, and ISO 14001 waste management tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` (
    `waste_stream_id` BIGINT COMMENT 'Unique identifier for the waste stream.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Waste stream classification depends on the originating chemical product for RCRA and internal cost tracking.',
    `average_monthly_volume` DECIMAL(18,2) COMMENT 'Average volume of waste generated per month, expressed in unit_of_measure.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the waste stream with applicable regulations.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste stream record was first created.',
    `disposal_frequency` STRING COMMENT 'Typical frequency at which the waste stream is disposed.. Valid values are `daily|weekly|monthly|as_generated`',
    `disposal_method` STRING COMMENT 'Regulated method used to dispose of the waste stream.. Valid values are `landfill|incineration|recycling|chemical_treatment|secure_storage|export`',
    `effective_from` DATE COMMENT 'Date when the waste stream became effective for reporting and disposal planning.',
    `effective_until` DATE COMMENT 'Date when the waste stream is no longer active (null if open‑ended).',
    `epa_waste_code` STRING COMMENT 'Four‑character EPA waste code (e.g., D001) that identifies the waste stream for regulatory reporting.',
    `generation_rate` DECIMAL(18,2) COMMENT 'Typical amount of waste generated per time unit (see unit_of_measure).',
    `hazardous_materials` STRING COMMENT 'Comma‑separated list of hazardous constituents present in the waste stream.',
    `last_disposal_date` DATE COMMENT 'Date when the waste stream was most recently disposed of.',
    `rcra_hazardous` BOOLEAN COMMENT 'Indicates whether the waste stream is classified as hazardous under RCRA regulations.',
    `regulatory_notification_date` DATE COMMENT 'Date on which the required regulatory notification was submitted.',
    `regulatory_notification_status` STRING COMMENT 'Current status of required regulatory notifications for the waste stream.. Valid values are `notified|pending|exempt|deferred`',
    `storage_location` STRING COMMENT 'Physical location or facility where the waste stream is stored before disposal.',
    `storage_requirements` STRING COMMENT 'Special storage conditions (e.g., temperature, containment) required for the waste stream.',
    `unit_of_measure` STRING COMMENT 'Unit for the generation_rate (e.g., kilograms, liters).. Valid values are `kg|liters|cubic_meters`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the waste stream record.',
    `waste_category` STRING COMMENT 'Classification of the waste stream by hazard type.. Valid values are `hazardous|non_hazardous|radioactive|biological|chemical|mixed`',
    `waste_stream_code` STRING COMMENT 'Business identifier or catalogue code for the waste stream.',
    `waste_stream_description` STRING COMMENT 'Detailed textual description of the waste stream, including physical and chemical characteristics.',
    `waste_stream_name` STRING COMMENT 'Human‑readable name of the waste stream.',
    `waste_stream_status` STRING COMMENT 'Current lifecycle status of the waste stream record.. Valid values are `active|inactive|retired|pending`',
    CONSTRAINT pk_waste_stream PRIMARY KEY(`waste_stream_id`)
) COMMENT 'Master record defining each recurring waste stream generated by Chemical Mfg production processes. Captures waste stream name, physical/chemical description, generating process unit, EPA waste codes, RCRA hazardous waste determination, typical generation rate, approved disposal methods, storage requirements, and regulatory notification status. Provides the classification foundation for all waste disposal records and annual waste reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` (
    `ehs_regulatory_submission_id` BIGINT COMMENT 'Unique system-generated identifier for the regulatory submission record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Regulatory submissions (e.g., EPA, TSCA) require specifying the exact chemical product for compliance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates regulatory filing fees to the cost center responsible for the submission, enabling expense tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who prepared and submitted the filing.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the manufacturing or storage facility associated with the submission.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: REGULATORY FILING: TRI and other EPA submissions require the exact chemical product (formula) identifier for accurate reporting.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Regulatory filings for new chemicals are tied to the originating R&D project for traceability.',
    `related_submission_ehs_regulatory_submission_id` BIGINT COMMENT 'Identifier of a prior submission that this record amends or supersedes.',
    `acknowledgment_date` DATE COMMENT 'Date the acknowledgment was received from the agency.',
    `acknowledgment_received` BOOLEAN COMMENT 'Indicates whether the agency has sent an acknowledgment of receipt.',
    `agency_recipient` STRING COMMENT 'Government or regulatory agency to which the submission is addressed.. Valid values are `EPA|OSHA|ECHA|TSCA|State_Env|Local_Env`',
    `annual_throughput_quantity` DECIMAL(18,2) COMMENT 'Total amount of the chemical processed or used during the reporting year.',
    `comments` STRING COMMENT 'Free‑text field for any additional notes or remarks about the submission.',
    `compliance_flag` BOOLEAN COMMENT 'True if the submission meets all applicable regulatory requirements for the reporting period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `document_reference` STRING COMMENT 'Reference (e.g., file path or document ID) to supporting documentation attached to the submission.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the submission contains confidential information requiring restricted handling.',
    `max_on_site_amount` DECIMAL(18,2) COMMENT 'Maximum quantity of the chemical that could be present on site at any time.',
    `permit_number` STRING COMMENT 'Identifier of the permit, registration, or license granted by the agency.',
    `release_quantity_air` DECIMAL(18,2) COMMENT 'Quantity of the chemical released to ambient air.',
    `release_quantity_land` DECIMAL(18,2) COMMENT 'Quantity of the chemical released to land (soil, surface).',
    `release_quantity_offsite_transfer` DECIMAL(18,2) COMMENT 'Quantity transferred off‑site for disposal or treatment.',
    `release_quantity_water` DECIMAL(18,2) COMMENT 'Quantity of the chemical released to water bodies.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by the submission.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by the submission.',
    `reporting_year` STRING COMMENT 'Calendar year for which the TRI or other regulatory data is reported.',
    `source_reduction_activity_description` STRING COMMENT 'Narrative description of activities undertaken to reduce chemical usage or releases.',
    `submission_date` DATE COMMENT 'Date the submission was formally made to the agency.',
    `submission_number` STRING COMMENT 'External reference number assigned to the submission by the organization.. Valid values are `^SUB-d{8}$`',
    `submission_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|acknowledged|rejected|approved|closed`',
    `submission_type` STRING COMMENT 'Category of the regulatory filing (e.g., TRI Form R, RMP, Title V permit renewal).. Valid values are `TRI_Form_R|RMP|Title_V|TSCA_CDR|REACH|OSHA_PSM`',
    `submission_version` STRING COMMENT 'Version number of the submission record, incremented on each amendment.',
    `submitted_by_name` STRING COMMENT 'Full name of the employee who submitted the filing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `waste_management_hierarchy` STRING COMMENT 'Preferred waste management method according to hierarchy (e.g., recycle, treatment).. Valid values are `recycle|treatment|disposal|landfill|incineration|other`',
    CONSTRAINT pk_ehs_regulatory_submission PRIMARY KEY(`ehs_regulatory_submission_id`)
) COMMENT 'Record of formal regulatory submissions, TRI chemical inventory/release calculations, and supporting documentation for Chemical Mfg environmental and safety agency filings. Submission tracking: submission type (TRI Form R, RMP, Title V permit renewal, TSCA CDR, REACH registration, OSHA PSM audit response), submission date, reporting period, agency recipient, status, acknowledgment receipt, permit/registration number. TRI inventory and reporting: TRI-listed chemical (CAS number), facility, reporting year, maximum amount on-site, annual throughput quantity, release quantities by media (air, water, land, off-site transfer), waste management hierarchy data, source reduction activities, Form R submission linkage. Provides the compliance submission audit trail for SOX, ISO 14001/45001 management reviews, EPCRA Section 313 annual reporting, and all agency filing requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` (
    `operating_permit_id` BIGINT COMMENT 'Primary key for operating_permit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links permit fees to the cost center bearing the permit cost for accurate financial allocation.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Operating permits are issued to a specific site; association is required for renewal tracking and audit readiness.',
    `air_emission_type` STRING COMMENT 'Specific air pollutant or emission category regulated.',
    `amendment_effective_date` DATE COMMENT 'Effective date of the latest permit amendment.',
    `amendment_expiration_date` DATE COMMENT 'Expiration date of the latest permit amendment, if applicable.',
    `compliance_report_due_date` DATE COMMENT 'Date by which the required compliance report must be submitted.',
    `compliance_report_status` STRING COMMENT 'Current status of the compliance reporting requirement.. Valid values are `submitted|pending|overdue|not_required`',
    `compliance_report_submitted_date` DATE COMMENT 'Date the compliance report was actually submitted.',
    `compliance_schedule` STRING COMMENT 'Timeline of compliance milestones and reporting dates.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the facility under this permit.. Valid values are `compliant|non_compliant|conditional|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `effective_date` DATE COMMENT 'Date the permit becomes effective.',
    `emission_limit_unit` STRING COMMENT 'Unit of measure for the emission limit.. Valid values are `kg_per_year|tons_per_year|lb_per_year|g_per_day`',
    `emission_limit_value` DECIMAL(18,2) COMMENT 'Numeric limit on emissions defined by the permit.',
    `expiration_date` DATE COMMENT 'Date the permit expires.',
    `facility_code` BIGINT COMMENT 'Identifier of the facility to which the permit applies.',
    `hazardous_waste_type` STRING COMMENT 'Classification of hazardous waste covered by the permit.',
    `issuing_agency` STRING COMMENT 'Regulatory authority that issued the permit.. Valid values are `EPA|State|Local|Tribal`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection.',
    `monitoring_requirements` STRING COMMENT 'Specific monitoring activities required for compliance.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the permit.',
    `operating_permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `active|inactive|expired|suspended|pending|revoked`',
    `permit_amendment_number` STRING COMMENT 'Sequential number of the most recent amendment to the permit.',
    `permit_conditions` STRING COMMENT 'Key conditions and obligations imposed by the permit.',
    `permit_document_url` STRING COMMENT 'Link to the electronic copy of the permit document.',
    `permit_expiration_notice_sent` BOOLEAN COMMENT 'Indicates whether an expiration notice has been sent to the permit holder.',
    `permit_holder_address` STRING COMMENT 'Mailing address of the permit holder.',
    `permit_holder_contact_email` STRING COMMENT 'Primary email address for the permit holders contact.',
    `permit_holder_contact_phone` STRING COMMENT 'Primary phone number for the permit holders contact.',
    `permit_holder_name` STRING COMMENT 'Legal name of the organization or entity holding the permit.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the issuing agency.',
    `permit_type` STRING COMMENT 'Category of the permit indicating the regulated medium or activity.. Valid values are `air|water|waste|storage|stormwater`',
    `renewal_deadline` DATE COMMENT 'Deadline by which the permit must be renewed.',
    `renewal_status` STRING COMMENT 'Current renewal status of the permit.. Valid values are `renewed|pending|not_renewed|unknown`',
    `source_system` STRING COMMENT 'Originating source system for the permit data (e.g., Intelex).',
    `total_fines_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary fines assessed for violations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    `violation_count` STRING COMMENT 'Number of recorded violations against the permit.',
    `water_discharge_type` STRING COMMENT 'Category of water discharge (e.g., effluent, stormwater) covered.',
    CONSTRAINT pk_operating_permit PRIMARY KEY(`operating_permit_id`)
) COMMENT 'Environmental and safety operating permit master record for Chemical Mfg facilities. Captures permit type (Title V air, NPDES wastewater, RCRA storage, state air permit, stormwater SWPPP), issuing agency, permit number, facility, effective date, expiration date, renewal status, key permit conditions, emission limits, monitoring requirements, and compliance schedule milestones. Serves as the SSOT for permit-driven compliance obligations across air, water, and waste programs.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` (
    `inspection_audit_id` BIGINT COMMENT 'Primary key for inspection_audit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charges audit costs to the responsible cost center for internal audit budgeting.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or external auditor who performed the inspection.',
    `functional_location_id` BIGINT COMMENT 'Unique identifier of the plant, site, or location where the inspection took place.',
    `affected_area` STRING COMMENT 'Physical area, process unit, or system within the facility impacted by the finding.',
    `closure_status` STRING COMMENT 'Overall status of the inspections corrective action closure process.. Valid values are `open|closed|deferred`',
    `corrective_actions_required` STRING COMMENT 'Count of distinct corrective actions that must be implemented to close findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first entered into the system.',
    `critical_findings` STRING COMMENT 'Number of findings classified as critical severity, requiring immediate corrective action.',
    `due_date` DATE COMMENT 'Latest date by which all corrective actions for the inspection must be completed.',
    `high_findings` STRING COMMENT 'Number of findings classified as high severity.',
    `inspection_number` STRING COMMENT 'Business-assigned identifier for the inspection, often used in reports and regulatory filings.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection record.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was actually performed.',
    `inspection_type` STRING COMMENT 'Category of the inspection, indicating the governing standard or agency (e.g., OSHA compliance audit, EPA facility inspection).. Valid values are `osha|epa|iso_14001|iso_45001|responsible_care|third_party`',
    `low_findings` STRING COMMENT 'Number of findings classified as low severity.',
    `medium_findings` STRING COMMENT 'Number of findings classified as medium severity.',
    `notes` STRING COMMENT 'Additional free‑text comments captured by the inspector, including observations not captured in structured fields.',
    `regulatory_standard_referenced` STRING COMMENT 'Specific regulatory clause, standard, or guideline cited for each finding (e.g., OSHA 1910.119, EPA 40 CFR Part 61).',
    `scope_description` STRING COMMENT 'Narrative description of the inspection scope, including processes, areas, and systems examined.',
    `total_findings` STRING COMMENT 'Total number of findings (citations, observations, non‑conformances) recorded during the inspection.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the inspection record.',
    CONSTRAINT pk_inspection_audit PRIMARY KEY(`inspection_audit_id`)
) COMMENT 'EHS inspection, audit, and findings record for internal safety audits, regulatory agency inspections, and third-party compliance assessments at Chemical Mfg facilities. Captures inspection type (OSHA compliance audit, EPA facility inspection, ISO 14001/45001 internal audit, Responsible Care verification), inspection date, inspector/auditor identity, scope, and individual findings (citations, observations, nonconformances, severity, regulatory standard referenced, affected area, required corrective action, due date, closure status). Supports ISO 14001 Clause 9.2 internal audit, OSHA PSM compliance audit requirements, and drives CAPA generation from findings.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT 'System-generated unique identifier for the inspection finding record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the inspector or auditor who recorded the finding.',
    `equipment_id` BIGINT COMMENT 'Identifier of the equipment, asset, or system associated with the finding.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the physical location (plant, site, area) where the finding was observed.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational department responsible for the area or equipment.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Supplier audits generate findings; linking each finding to the vendor allows corrective‑action tracking and supplier performance metrics.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether supporting documents or images are attached to the finding.',
    `closure_timestamp` TIMESTAMP COMMENT 'Date‑time when the finding was formally closed.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed.',
    `corrective_action_required` STRING COMMENT 'Specific corrective or preventive action that must be taken to address the finding.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action associated with the finding.. Valid values are `pending|in_progress|completed|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the finding record was first created in the system.',
    `finding_number` STRING COMMENT 'Human‑readable identifier assigned to the finding, often used in reports and corrective action tracking.',
    `finding_type` STRING COMMENT 'Classification of the finding (e.g., citation, observation, opportunity for improvement, non‑conformance).. Valid values are `citation|observation|opportunity|nonconformance`',
    `impact_area` STRING COMMENT 'Business area or function impacted by the finding.. Valid values are `safety|environment|quality|production|compliance`',
    `inspection_finding_description` STRING COMMENT 'Detailed narrative of the observation, condition, or non‑conformance.',
    `inspection_finding_status` STRING COMMENT 'Current lifecycle state of the finding.. Valid values are `open|closed|in_progress|deferred|rejected`',
    `notes` STRING COMMENT 'Free‑form notes entered by the inspector or follow‑up personnel.',
    `observed_timestamp` TIMESTAMP COMMENT 'Date‑time when the finding was observed or recorded during the inspection.',
    `priority` STRING COMMENT 'Priority assigned to the finding for remediation planning.. Valid values are `low|medium|high`',
    `regulatory_standard` STRING COMMENT 'Regulatory or industry standard that the finding references.. Valid values are `OSHA|EPA|ISO45001|REACH|GHS|TSCA`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score derived from severity, likelihood, and exposure factors.',
    `root_cause` STRING COMMENT 'Identified root cause(s) underlying the finding.',
    `severity_level` STRING COMMENT 'Severity rating assigned to the finding based on risk impact.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'System of record where the finding originated (e.g., Intelex, SAP, manual audit).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the finding record.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'Individual finding or observation recorded during an EHS inspection or audit at Chemical Mfg. Captures finding type (citation, observation, opportunity for improvement, nonconformance), regulatory standard referenced, severity level, affected area or equipment, finding description, required corrective action, due date, and closure status. Child record of ehs_inspection; drives CAPA generation and regulatory response tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` (
    `management_of_change_id` BIGINT COMMENT 'Primary key for management_of_change',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: MOC records often involve changes to a specific chemical product; linking enables traceability and compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tracks MOC implementation costs to the cost center responsible for the change.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who submitted the MOC.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: MOC approvals often reference the R&D project they affect; linking supports change impact analysis.',
    `affected_equipment_ids` STRING COMMENT 'Comma‑separated list of equipment IDs that will be modified.',
    `affected_pids` STRING COMMENT 'Comma‑separated list of Piping & Instrumentation Diagram identifiers affected.',
    `affected_processes` STRING COMMENT 'Comma‑separated list of process identifiers impacted by the change.',
    `approval_chain` STRING COMMENT 'Ordered list of approver identifiers (e.g., employee IDs) for the MOC.',
    `approval_status` STRING COMMENT 'Current status of the MOC approval workflow.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `change_description` STRING COMMENT 'Detailed narrative describing the scope, rationale, and expected impact of the change.',
    `change_title` STRING COMMENT 'Brief title summarizing the proposed change.',
    `change_type` STRING COMMENT 'Category of the change indicating what is being modified.. Valid values are `process|equipment|procedure|facility|software|other`',
    `comments` STRING COMMENT 'Additional free‑form notes or comments related to the MOC.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the change complies with all applicable regulations.',
    `cost_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost estimate.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `cost_estimate_amount` DECIMAL(18,2) COMMENT 'Estimated monetary cost to implement the change.',
    `document_reference_ids` STRING COMMENT 'Comma‑separated list of document identifiers attached to the MOC (e.g., safety analysis reports).',
    `effective_date` DATE COMMENT 'Date when the change becomes operationally effective.',
    `hazop_update_required` BOOLEAN COMMENT 'Flag indicating if a HAZOP or PHA update is required due to the change.',
    `implementation_end_date` DATE COMMENT 'Planned or actual completion date of the change implementation.',
    `implementation_start_date` DATE COMMENT 'Planned start date for implementing the change.',
    `implementation_status` STRING COMMENT 'Current status of the change implementation.. Valid values are `not_started|in_progress|completed|failed`',
    `initiating_department` STRING COMMENT 'Organizational department that originated the MOC request.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the MOC record.. Valid values are `open|closed|cancelled`',
    `moc_number` STRING COMMENT 'Unique alphanumeric code assigned to the MOC request.',
    `moc_submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the MOC request was initially submitted.',
    `pre_startup_safety_review_status` STRING COMMENT 'Current status of the pre‑startup safety review for the change.. Valid values are `not_required|pending|completed|failed`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the MOC record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the MOC record.',
    `regulatory_submission_date` DATE COMMENT 'Date when the regulatory submission was made.',
    `regulatory_submission_status` STRING COMMENT 'Status of any required regulatory submission related to the change.. Valid values are `not_required|pending|submitted|approved|rejected`',
    `risk_category` STRING COMMENT 'Qualitative risk classification derived from the risk score.. Valid values are `low|moderate|high|critical`',
    `risk_score` STRING COMMENT 'Numeric risk rating assigned to the change (e.g., 1‑5).',
    `safety_review_completed` BOOLEAN COMMENT 'Indicates whether the required safety review has been completed.',
    `technical_basis` STRING COMMENT 'Technical justification for the change, such as engineering study or safety analysis.',
    CONSTRAINT pk_management_of_change PRIMARY KEY(`management_of_change_id`)
) COMMENT 'Process Safety Management (PSM) Management of Change (MOC) record for Chemical Mfg process modifications. Captures change description, change type (process chemistry, equipment, procedure, facility), initiating department, technical basis, safety review completion, HAZOP/PHA update requirement, pre-startup safety review (PSSR) status, affected P&IDs, approval chain, and implementation date. Required under OSHA PSM 29 CFR 1910.119(l) for all changes to covered processes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` (
    `process_safety_info_id` BIGINT COMMENT 'Unique identifier for the Process Safety Information record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: PSI documents are product‑specific, linking ensures consistent safety data across processes.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: PSI documents are generated for new chemicals under a project; linking enables project‑level safety compliance.',
    `autoignition_temp_c` DECIMAL(18,2) COMMENT 'Temperature at which the chemical will spontaneously ignite without an external flame.',
    `boiling_point_c` DECIMAL(18,2) COMMENT 'Boiling point temperature in degrees Celsius.',
    `compatible_materials` STRING COMMENT 'Materials that are safe to store or transport the chemical with.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PSI record was initially created.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Mass per unit volume of the chemical at standard temperature and pressure.',
    `document_reference` STRING COMMENT 'Identifier for the linked safety data sheet or regulatory document.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of an incident involving the chemical.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `emergency_procedure` STRING COMMENT 'Brief description of the emergency response steps for this chemical.',
    `environmental_hazards` STRING COMMENT 'Key environmental risk categories for the chemical.. Valid values are `aquatic_toxicity|ozone_depletion|global_warming|soil_contamination|air_pollution`',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which the chemical can form an ignitable mixture in air.',
    `hazard_classification` STRING COMMENT 'Primary GHS hazard class for the chemical.. Valid values are `flammable|corrosive|toxic|reactive|explosive|oxidizer`',
    `health_hazards` STRING COMMENT 'Primary health hazard categories associated with the chemical.. Valid values are `skin_irritation|respiratory|carcinogenic|reproductive|sensitization|mutagenic`',
    `incompatible_materials` STRING COMMENT 'Materials that must not contact the chemical due to reactive hazards.',
    `inventory_uom` STRING COMMENT 'Unit of measure for the maximum inventory amount.. Valid values are `kg|lb|ton`',
    `iupac_name` STRING COMMENT 'Systematic International Union of Pure and Applied Chemistry name for the chemical.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date and time when the PSI record was last reviewed for accuracy.',
    `max_inventory_amount` DECIMAL(18,2) COMMENT 'Maximum quantity of the chemical intended to be stored on site.',
    `melting_point_c` DECIMAL(18,2) COMMENT 'Melting point temperature in degrees Celsius.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Molecular weight of the chemical in grams per mole.',
    `next_review_timestamp` TIMESTAMP COMMENT 'Planned date and time for the next periodic review.',
    `odor_description` STRING COMMENT 'Narrative description of the chemicals odor.',
    `ph` DECIMAL(18,2) COMMENT 'Acidity/alkalinity of the chemical in aqueous solution.',
    `process_safety_info_status` STRING COMMENT 'Current lifecycle status of the PSI record.. Valid values are `active|inactive|retired|pending`',
    `psm_covered` BOOLEAN COMMENT 'Indicates whether the chemical is covered under OSHA Process Safety Management.',
    `reactivity_hazards` STRING COMMENT 'Reactivity hazard classifications indicating dangerous reactions.. Valid values are `water_reactive|air_reactive|oxidizer|explosive|pyrophoric`',
    `regulatory_status` STRING COMMENT 'Current compliance status with applicable regulations (OSHA, EPA, REACH, etc.).. Valid values are `compliant|non_compliant|pending|exempt`',
    `rmp_covered` BOOLEAN COMMENT 'Indicates whether the chemical is covered under EPA Risk Management Plan requirements.',
    `safety_data_sheet_url` STRING COMMENT 'Web address where the current SDS for the chemical is stored.',
    `solubility_water` STRING COMMENT 'Qualitative description of solubility in water (e.g., miscible, limited, insoluble).',
    `source_system` STRING COMMENT 'Originating operational system (e.g., SAP PM, Intelex EHS).',
    `storage_pressure_bar` DECIMAL(18,2) COMMENT 'Pressure range recommended for safe storage.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature range recommended for safe storage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PSI record.',
    `vapor_pressure_kpa` DECIMAL(18,2) COMMENT 'Equilibrium vapor pressure of the chemical at 20 °C expressed in kilopascals.',
    CONSTRAINT pk_process_safety_info PRIMARY KEY(`process_safety_info_id`)
) COMMENT 'Process Safety Information (PSI) master record for highly hazardous chemicals and covered processes at Chemical Mfg facilities under OSHA PSM. Captures chemical identity (CAS number), maximum intended inventory, physical/chemical properties, reactivity hazards, corrosivity data, thermal stability data, P&ID reference, equipment design specifications, and safe operating limits. Required documentation under OSHA 29 CFR 1910.119(d) and EPA RMP 40 CFR Part 68.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` (
    `safety_data_sheet_id` BIGINT COMMENT 'Primary key for safety_data_sheet',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: EHS SDS records must reference the master chemical product for unified hazard communication.',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: Safety Data Sheet records describe the same chemical identified in Process Safety Info. Linking SDS to PSI via process_safety_info_id removes duplicate chemical identifiers.',
    `accidental_release_measures` STRING COMMENT 'Steps to contain and clean up accidental releases.',
    `author` STRING COMMENT 'Name of the person or team that authored the SDS.',
    `boiling_point_c` DECIMAL(18,2) COMMENT 'Boiling point of the substance in degrees Celsius.',
    `confidentiality_level` STRING COMMENT 'Data classification indicating the sensitivity of the SDS record.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SDS record was first created in the system.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Mass per unit volume at 20 °C.',
    `document_url` STRING COMMENT 'Permanent link to the electronic SDS document.. Valid values are `^https?://.+$`',
    `effective_date` DATE COMMENT 'Date when the SDS version became effective.',
    `expiration_date` DATE COMMENT 'Date after which the SDS is no longer valid (if applicable).',
    `exposure_controls` STRING COMMENT 'Engineering controls and personal protective equipment (PPE) requirements.',
    `firefighting_measures` STRING COMMENT 'Procedures and extinguishing media for fire involving the substance.',
    `first_aid_measures` STRING COMMENT 'Recommended first‑aid actions in case of exposure.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Temperature at which the substance can form an ignitable mixture with air.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification string summarizing hazard classes and categories.',
    `handling_and_storage` STRING COMMENT 'Guidelines for safe handling, storage conditions, and segregation.',
    `hazard_class` STRING COMMENT 'Primary GHS hazard class (e.g., Flammable, Toxic).',
    `language` STRING COMMENT 'ISO language code of the SDS document.. Valid values are `en|es|fr|de|zh|ja`',
    `melting_point_c` DECIMAL(18,2) COMMENT 'Melting point of the substance in degrees Celsius.',
    `personal_protective_equipment` STRING COMMENT 'Specific PPE recommended for handling the substance.',
    `ph` DECIMAL(18,2) COMMENT 'Acidity/alkalinity of the substance in aqueous solution.',
    `physical_chemical_properties` STRING COMMENT 'Free‑form description of key physical and chemical characteristics.',
    `pictograms` STRING COMMENT 'List of GHS pictogram codes applicable to the substance.',
    `precautionary_statements` STRING COMMENT 'Standard GHS precautionary statements for handling the substance.',
    `reach_registration_number` STRING COMMENT 'ECHA registration identifier for the substance.. Valid values are `^[A-Z0-9]{8,12}$`',
    `regulatory_information` STRING COMMENT 'Key regulatory status notes (e.g., REACH, TSCA, OSHA).',
    `revision_date` DATE COMMENT 'Date of the most recent revision to the SDS content.',
    `sds_status` STRING COMMENT 'Current lifecycle state of the SDS record.. Valid values are `active|inactive|archived`',
    `sds_version` STRING COMMENT 'Version identifier of the SDS document, e.g., 1.0, 2.1.',
    `signal_word` STRING COMMENT 'GHS signal word indicating severity of hazards.. Valid values are `Danger|Warning`',
    `source_system` STRING COMMENT 'Originating system that supplied the SDS data.. Valid values are `Intelex|SAP|Other`',
    `toxicological_information` STRING COMMENT 'Summary of acute, chronic, and specific toxicity data.',
    `tsca_sara_313_status` STRING COMMENT 'U.S. TSCA SARA 313 reporting requirement status.. Valid values are `required|exempt|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the SDS record.',
    `vapor_pressure_kpa` DECIMAL(18,2) COMMENT 'Equilibrium vapor pressure at 20 °C expressed in kilopascals.',
    CONSTRAINT pk_safety_data_sheet PRIMARY KEY(`safety_data_sheet_id`)
) COMMENT 'Safety Data Sheet (SDS/MSDS) master record for all chemical substances handled, produced, or distributed by Chemical Mfg. Captures SDS version, GHS classification (hazard class, category, signal word, pictograms), CAS number, chemical composition, first-aid measures, firefighting measures, exposure controls, PPE requirements, physical/chemical properties, stability/reactivity data, toxicological information, and regulatory status (REACH, TSCA, SARA 313). Integrates with product and raw material domains via CAS number.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Primary key for training_record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns training expenses to the cost center sponsoring the training, supporting cost allocation.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who received the training.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Training records must be linked to the R&D project to ensure personnel are qualified for specific processes.',
    `site_id` BIGINT COMMENT 'Identifier of the plant or facility associated with the training.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the third‑party contractor who received the training.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end date and time when the training concluded.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start date and time when the training began.',
    `assessment_passed` BOOLEAN COMMENT 'Indicates whether the participant passed the post‑training assessment.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved on the post‑training assessment (0‑100).',
    `attendance_count` STRING COMMENT 'Number of participants who attended the training session.',
    `certification_expiry_date` DATE COMMENT 'Date when the training‑related certification expires and retraining is required.',
    `certification_number` STRING COMMENT 'Identifier of the issued certificate, if applicable.',
    `completion_date` DATE COMMENT 'Date on which the participant successfully completed the training.',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal compliance program that mandates the training.. Valid values are `OSHA|ISO45001|EPA|REACH|GHS|Other`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred for delivering the training.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the training record.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the training cost.',
    `delivery_method` STRING COMMENT 'How the training was delivered to the participant.. Valid values are `in_person|online|blended|on_the_job`',
    `document_reference` STRING COMMENT 'Link or identifier to the training syllabus, agenda, or certificate document.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours (including breaks) the training lasted.',
    `is_external_contractor` BOOLEAN COMMENT 'True if the participant is a third‑party contractor rather than a direct employee.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the training is required by law or company policy.',
    `max_participants` STRING COMMENT 'Maximum number of participants allowed for the session.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the training session.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training record was first entered into the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the training record.',
    `regulatory_reference` STRING COMMENT 'Specific regulation, standard, or clause that the training satisfies.',
    `retraining_due_date` DATE COMMENT 'Date by which the participant must complete refresher training.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date and time for the training session.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time for the training session.',
    `trainer_name` STRING COMMENT 'Name of the individual or organization delivering the training.',
    `training_category` STRING COMMENT 'High‑level classification of the training content.. Valid values are `Safety|Environmental|Technical|Compliance|Leadership`',
    `training_description` STRING COMMENT 'Detailed description of the training content and objectives.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was delivered.',
    `training_number` STRING COMMENT 'Business identifier or code assigned to the training event.',
    `training_status` STRING COMMENT 'Current lifecycle status of the training record.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `training_title` STRING COMMENT 'Descriptive title of the training program.',
    `training_type` STRING COMMENT 'Category of training required by regulatory or internal safety programs.. Valid values are `HAZWOPER|PSM Operator|GHS HazCom|Emergency Response|Confined Space|LOTO`',
    `updated_by_user` STRING COMMENT 'User identifier of the person who last updated the training record.',
    `version_number` STRING COMMENT 'Version of the training record for audit and change tracking.',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'EHS training, competence, and contractor safety qualification record for Chemical Mfg employees and third-party contractors. Employee training: trainee identity, training program, training type (HAZWOPER, PSM operator training, GHS/HazCom, emergency response, confined space, LOTO), delivery method, completion date, assessment score, certification expiry, retraining due date. Contractor safety: contractor company, contract scope, safety prequalification status, OSHA 300 log review, EMR (Experience Modification Rate), site-specific orientation completion, safety performance metrics (recordable rate, near-miss frequency), active violations, re-qualification due date. Supports OSHA training compliance, PSM contractor safety program (29 CFR 1910.119(h)), ISO 45001 competence management (Clause 7.2), and Responsible Care contractor management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` (
    `emergency_response_plan_id` BIGINT COMMENT 'System‑generated unique identifier for the emergency response plan record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: ERPs are drafted for specific chemicals; linking supports drill planning and regulatory compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Emergency response plans assign a coordinator (employee); a proper FK replaces the name field for compliance reporting.',
    `functional_location_id` BIGINT COMMENT 'Geographic location identifier (e.g., site, campus) for the plan.',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Emergency response plans are tied to the operating permit that authorizes the facilitys emissions. Adding operating_permit_id to emergency_response_plan links the plan to its governing permit.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Project‑specific emergency response plans are required for pilot plant operations and regulatory reviews.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Emergency response plans are site‑specific; linking supports drill scheduling, compliance checks, and incident coordination.',
    `community_notification_thresholds` STRING COMMENT 'Quantitative or situational thresholds that trigger external community alerts.',
    `covered_hazards` STRING COMMENT 'Narrative list of specific chemicals, processes, or scenarios addressed by the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan record was first created in the system.',
    `drill_completion_status` STRING COMMENT 'Result of the most recent drill.. Valid values are `completed|pending|failed`',
    `drill_observations` STRING COMMENT 'Narrative observations, performance notes, and corrective actions identified during the drill.',
    `drill_schedule` STRING COMMENT 'Planned frequency and timing of emergency response drills (e.g., quarterly, annual).',
    `effective_from` DATE COMMENT 'Date when the plan becomes effective and binding.',
    `effective_until` DATE COMMENT 'Date when the plan expires or is superseded; null for open‑ended plans.',
    `emergency_coordinator_email` STRING COMMENT 'Primary email address for the emergency coordinator.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_coordinator_phone` STRING COMMENT 'Primary telephone number for the emergency coordinator.',
    `evacuation_routes_description` STRING COMMENT 'Detailed description of evacuation routes and assembly points.',
    `facility_code` BIGINT COMMENT 'Identifier of the facility or plant to which the plan applies.',
    `last_drill_date` DATE COMMENT 'Date of the most recent emergency response drill.',
    `last_review_date` DATE COMMENT 'Date when the plan was last formally reviewed and approved.',
    `lifecycle_status` STRING COMMENT 'Current state of the plan in its lifecycle.. Valid values are `draft|active|suspended|retired`',
    `plan_category` STRING COMMENT 'Broad hazard category covered (e.g., chemical release, fire, explosion, natural disaster, environmental emergency).',
    `plan_document_url` STRING COMMENT 'Link to the stored electronic copy of the full emergency response plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the emergency response plan.',
    `plan_type` STRING COMMENT 'Regulatory classification of the plan as required by OSHA, EPA, or EPCRA.. Valid values are `OSHA_EAP|EPA_RMP|SPCC|EPCRA_LEPC`',
    `plan_version` STRING COMMENT 'Version label or number for the plan (e.g., v1.2, 2023‑Q2).',
    `regulatory_submission_date` DATE COMMENT 'Date the plan was submitted to the applicable regulatory agency.',
    `regulatory_submission_status` STRING COMMENT 'Current status of required regulatory filings for the plan.. Valid values are `submitted|pending|exempt`',
    `shelter_in_place_procedures` STRING COMMENT 'Procedures to be followed when shelter‑in‑place is required.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the plan record.',
    CONSTRAINT pk_emergency_response_plan PRIMARY KEY(`emergency_response_plan_id`)
) COMMENT 'Emergency response plan master record for Chemical Mfg facilities covering chemical release, fire, explosion, natural disaster, and environmental emergency scenarios. Captures plan type (OSHA EAP, EPA RMP Emergency Response Program, SPCC Plan, EPCRA LEPC notification), covered hazards, emergency coordinator contacts, evacuation routes, shelter-in-place procedures, community notification thresholds, drill schedule and completion history, performance observations from exercises, last review date, and regulatory submission status. Required under OSHA 29 CFR 1910.38, EPA RMP 40 CFR Part 68, and EPCRA Section 304. Now includes drill/exercise tracking previously in emergency_drill.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'System‑generated unique identifier for each environmental monitoring record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Monitoring results are tied to the chemical product to assess environmental impact and permit limits.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tracks monitoring program costs against the cost center funding the activity.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst who reviewed or approved the analytical result.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the plant, facility, or monitoring site where the sample originated.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Monitoring data (e.g., sample results) are collected for specific R&D projects to validate process performance.',
    `sample_id` BIGINT COMMENT 'Unique alphanumeric code assigned to the environmental sample.. Valid values are `^[A-Z0-9_-]+$`',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Sampling locations are tied to a site; linking enables site‑level trend analysis and regulatory limit tracking.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: Environmental samples are collected at work‑center locations; linking to work_center ties data to the production unit responsible.',
    `chain_of_custody_number` STRING COMMENT 'Number tracking the custody and handling of the sample from collection to analysis.',
    `comments` STRING COMMENT 'Free‑text field for additional observations or notes about the sample or result.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the monitoring record was first entered into the system.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Lowest concentration that the analytical method can reliably detect.',
    `environmental_monitoring_status` STRING COMMENT 'Current processing status of the monitoring record.. Valid values are `pending|approved|rejected`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental sample was collected or the measurement was taken.',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the result exceeds the regulatory limit (true) or not (false).',
    `lab_reference` STRING COMMENT 'Identifier of the laboratory that performed the analysis.',
    `media_type` STRING COMMENT 'Physical medium being monitored (e.g., air, water, soil).. Valid values are `air|water|soil|groundwater|stormwater`',
    `parameter` STRING COMMENT 'Chemical or physical parameter measured (e.g., pH, VOC, lead).',
    `quality_flag` STRING COMMENT 'Quality status of the analytical result after laboratory review.. Valid values are `pass|fail|questionable`',
    `regulatory_limit` DECIMAL(18,2) COMMENT 'Maximum allowable concentration set by regulatory agencies for the parameter.',
    `regulatory_reporting_requirement` STRING COMMENT 'Regulatory program or standard to which this monitoring record contributes.. Valid values are `NPDES|TitleV|ISO14001|REACH|TSCA`',
    `result_value` DECIMAL(18,2) COMMENT 'Analytical result of the parameter measurement expressed in the specified unit.',
    `sample_method` STRING COMMENT 'Technique used to collect the sample (e.g., grab, composite, automated).. Valid values are `grab|composite|automated`',
    `source_system` STRING COMMENT 'Originating system that supplied the monitoring data (e.g., Intelex, LIMS).',
    `unit_of_measure` STRING COMMENT 'Units associated with the result value (e.g., mg/L, µg/m³, ppm).. Valid values are `mg/L|µg/m3|ppm|pH|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the monitoring record.',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Ambient and effluent environmental monitoring record for Chemical Mfg facilities covering air quality, wastewater effluent, groundwater, and stormwater monitoring programs. Captures monitoring location, media type (air, water, soil, groundwater), parameter measured, analytical result, units, detection limit, regulatory limit, exceedance flag, sampling date, laboratory reference, and chain-of-custody number. Feeds NPDES discharge monitoring reports (DMR), Title V deviation reports, and ISO 14001 environmental performance evaluation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` (
    `tri_inventory_id` BIGINT COMMENT 'Unique surrogate key for the TRI inventory record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: TRI inventory submissions aggregate data per chemical product; linking ensures accurate reporting of on‑site amounts.',
    `ehs_regulatory_submission_id` BIGINT COMMENT 'Identifier of the EPA Form R submission linked to this record.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: TRI inventory reporting distinguishes quantities by project to allocate emissions and waste to development activities.',
    `site_id` BIGINT COMMENT 'Unique identifier of the facility in the enterprise system.',
    `annual_throughput_quantity` DECIMAL(18,2) COMMENT 'Total amount of the chemical processed or used during the reporting year, in pounds.',
    `annual_throughput_unit` STRING COMMENT 'Unit of measure for the annual throughput.. Valid values are `lb|kg|ton`',
    `chemical_state` STRING COMMENT 'Physical state of the chemical at standard conditions.. Valid values are `solid|liquid|gas|plasma`',
    `confidentiality_level` STRING COMMENT 'Data classification level for the record.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `data_source_system` STRING COMMENT 'Source system where the data originated.. Valid values are `SAP|Intelex|Custom`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor used to calculate estimated emissions; unitless.',
    `facility_name` STRING COMMENT 'Name of the reporting facility.',
    `form_r_submission_date` DATE COMMENT 'Date the Form R was submitted to EPA.',
    `hazard_classification` STRING COMMENT 'Hazard classification(s) for the chemical per GHS.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last regulatory review of the record.',
    `max_on_site_amount` DECIMAL(18,2) COMMENT 'Maximum amount of the chemical present on site during the reporting year, in pounds.',
    `max_on_site_unit` STRING COMMENT 'Unit of measure for the maximum on-site amount.. Valid values are `lb|kg|ton`',
    `notes` STRING COMMENT 'Additional free-text notes related to the TRI inventory entry.',
    `ppe_required` BOOLEAN COMMENT 'Indicates if personal protective equipment is required when handling the chemical.',
    `record_status` STRING COMMENT 'Current lifecycle status of the TRI inventory record.. Valid values are `draft|submitted|approved|rejected`',
    `release_air_quantity` DECIMAL(18,2) COMMENT 'Quantity of chemical released to air, in pounds.',
    `release_land_quantity` DECIMAL(18,2) COMMENT 'Quantity of chemical released to land, in pounds.',
    `release_offsite_transfer_quantity` DECIMAL(18,2) COMMENT 'Quantity of chemical transferred off-site for treatment or disposal, in pounds.',
    `release_water_quantity` DECIMAL(18,2) COMMENT 'Quantity of chemical released to water, in pounds.',
    `reporting_threshold_exceeded` BOOLEAN COMMENT 'Flag indicating whether the chemical exceeds the EPCRA reporting threshold.',
    `reporting_year` STRING COMMENT 'Calendar year for which the TRI data is reported.',
    `source_reduction_activities` STRING COMMENT 'Narrative description of source reduction activities performed for the chemical.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `waste_management_hierarchy` STRING COMMENT 'Highest level of waste management hierarchy applied to the chemical.. Valid values are `source_reduction|recycling|energy_recovery|treatment|disposal`',
    CONSTRAINT pk_tri_inventory PRIMARY KEY(`tri_inventory_id`)
) COMMENT 'Toxics Release Inventory (TRI) chemical inventory and release calculation record for Chemical Mfg annual EPA Form R reporting. Captures TRI-listed chemical (CAS number), facility, reporting year, maximum amount on-site, annual throughput quantity, release quantities by media (air, water, land, off-site transfer), waste management hierarchy data, source reduction activities, and Form R submission linkage. Required annually under EPCRA Section 313 for facilities meeting reporting thresholds.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` (
    `management_objective_id` BIGINT COMMENT 'Primary key for management_objective',
    `achievement_status` STRING COMMENT 'Current status of progress against the target.. Valid values are `on_track|behind|completed`',
    `additional_control_recommendation` STRING COMMENT 'Suggested further controls to reduce residual risk.',
    `affected_activity` STRING COMMENT 'Work activity or process that the hazard could impact.',
    `aspect_activity` STRING COMMENT 'Business activity or process linked to the environmental aspect (e.g., batch mixing, waste handling).',
    `aspect_description` STRING COMMENT 'Narrative description of the identified environmental aspect.',
    `attached_document_count` STRING COMMENT 'Number of supporting documents linked to the objective record.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Current value of the metric at the start of the improvement cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the objective record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the objective expires or is superseded; null for open‑ended objectives.',
    `effective_start_date` DATE COMMENT 'Date when the objective becomes effective for compliance and performance tracking.',
    `environmental_impact` STRING COMMENT 'Potential impact on environment resulting from the aspect (e.g., emissions, water use).',
    `existing_control` STRING COMMENT 'Current control measures in place to mitigate the environmental aspect.',
    `hazard_description` STRING COMMENT 'Detailed description of the occupational health and safety hazard.',
    `hazard_type` STRING COMMENT 'Category of the hazard (chemical, physical, etc.).. Valid values are `chemical|physical|biological|ergonomic|psychosocial`',
    `inherent_risk_rating` STRING COMMENT 'Risk rating before any controls are applied.. Valid values are `high|medium|low`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent management review of the objective.',
    `legal_requirement` STRING COMMENT 'Regulatory or statutory requirement linked to the aspect (e.g., EPA, REACH).',
    `management_objective_status` STRING COMMENT 'Current lifecycle status of the objective record.. Valid values are `draft|active|closed|archived`',
    `measurement_frequency` STRING COMMENT 'How often the metric is measured and reported.. Valid values are `monthly|quarterly|annually`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the metric (e.g., kg CO₂e, incidents per 200 000 hrs).',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the objective.',
    `objective_code` STRING COMMENT 'Business identifier or code used to reference the objective in EHS systems and reports.',
    `objective_description` STRING COMMENT 'Narrative description of the integrated ISO management objective.',
    `objective_title` STRING COMMENT 'Human‑readable title describing the objective or planning record.',
    `objective_type` STRING COMMENT 'Classification of the objective: environmental aspect, occupational health & safety hazard, or integrated ISO objective.. Valid values are `environmental|safety|integrated`',
    `progress_milestone` STRING COMMENT 'Key milestone or checkpoint toward the objective.',
    `residual_risk_rating` STRING COMMENT 'Risk rating after existing controls are considered.. Valid values are `high|medium|low`',
    `residual_significance` STRING COMMENT 'Significance rating after accounting for existing controls.. Valid values are `high|medium|low`',
    `responsible_function` STRING COMMENT 'Organizational function or department accountable for achieving the objective.',
    `risk_review_date` DATE COMMENT 'Planned date for reviewing the hazard risk and controls.',
    `significance_criteria` STRING COMMENT 'Criteria used to evaluate the significance of the environmental aspect (e.g., legal thresholds, stakeholder concern).',
    `significance_rating` STRING COMMENT 'Resulting significance rating after applying the criteria.. Valid values are `high|medium|low`',
    `target_metric` STRING COMMENT 'Measurable metric for the objective (e.g., CO₂ emissions, lost‑time injury rate).',
    `target_value` DECIMAL(18,2) COMMENT 'Desired future value for the metric as defined in the objective.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the objective record.',
    CONSTRAINT pk_management_objective PRIMARY KEY(`management_objective_id`)
) COMMENT 'Integrated ISO management system planning record for Chemical Mfg facilities consolidating three core planning elements: (1) Environmental aspects/impacts register (ISO 14001 Clause 6.1.2) — activity, aspect description, environmental impact, significance determination criteria, significance rating, applicable legal requirements, existing controls, residual significance; (2) OHS hazard identification and risk assessment (ISO 45001 Clause 6.1.2) — hazard description, hazard type (chemical, physical, biological, ergonomic, psychosocial), affected work activity, inherent/residual risk ratings, existing controls, additional control recommendations, review dates; (3) Management objectives and targets (ISO 14001/45001 Clause 6.2) — measurable targets, baseline/target values, measurement frequency, responsible function, progress milestones, achievement status. Supports integrated EHS management system planning, continual improvement, legal compliance evaluation, and management review inputs.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` (
    `environmental_aspect_id` BIGINT COMMENT 'System‑generated unique identifier for each environmental aspect record.',
    `management_objective_id` BIGINT COMMENT 'Foreign key linking to ehs.management_objective. Business justification: Environmental aspects are managed through ISO objectives. Adding management_objective_id to environmental_aspect connects each aspect to its governing objective.',
    `aspect_category` STRING COMMENT 'High‑level classification of the aspect (air, water, soil, waste, energy, or other).. Valid values are `air|water|soil|waste|energy|other`',
    `aspect_code` STRING COMMENT 'Business identifier or code used to reference the aspect in reports and systems.',
    `aspect_name` STRING COMMENT 'Human‑readable name of the environmental aspect (e.g., VOC emissions from reactor venting).',
    `aspect_subcategory` STRING COMMENT 'More detailed classification within the main category (e.g., VOC, NOx for air).',
    `control_measures` STRING COMMENT 'Controls currently in place to mitigate the aspect (e.g., scrubbers, waste treatment).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the aspect record was first created.',
    `effective_date` DATE COMMENT 'Date when the aspect record became active in the register.',
    `environmental_aspect_description` STRING COMMENT 'Narrative description of the activity or process that generates the environmental aspect.',
    `environmental_aspect_status` STRING COMMENT 'Current lifecycle status of the aspect record.. Valid values are `active|inactive|retired|pending`',
    `environmental_impact` STRING COMMENT 'Description of the potential environmental impact associated with the aspect (e.g., air quality degradation, water contamination).',
    `last_assessed_timestamp` TIMESTAMP COMMENT 'Date and time when the aspect was last evaluated for significance.',
    `legal_requirement` STRING COMMENT 'Applicable legal or regulatory requirement linked to the aspect (e.g., EPA emission limit, REACH registration).',
    `measurement_unit` STRING COMMENT 'Unit of measure for the aspects quantitative value.. Valid values are `kg|t|m3|kgCO2e|ppm|percent`',
    `monitoring_frequency` STRING COMMENT 'How often the aspect is monitored or measured.. Valid values are `daily|weekly|monthly|quarterly|annually|ad_hoc`',
    `residual_significance` STRING COMMENT 'Significance rating after accounting for existing controls.. Valid values are `high|medium|low`',
    `retirement_date` DATE COMMENT 'Date when the aspect was retired or removed from active monitoring (if applicable).',
    `significance_criteria` STRING COMMENT 'Criteria used to evaluate the significance of the aspect (e.g., regulatory thresholds, stakeholder concerns).',
    `significance_rating` STRING COMMENT 'Resulting significance rating after applying the criteria (high, medium, low).. Valid values are `high|medium|low`',
    `source_system` STRING COMMENT 'Source system where the aspect record originated (e.g., Intelex EHS Management).',
    `threshold_value` DECIMAL(18,2) COMMENT 'Regulatory or internal threshold value for the aspect (e.g., 50 ppm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the aspect record.',
    CONSTRAINT pk_environmental_aspect PRIMARY KEY(`environmental_aspect_id`)
) COMMENT 'Environmental aspect and impact register for Chemical Mfg operations under ISO 14001. Captures activity or process generating the aspect, aspect description (e.g., VOC emissions from reactor venting, wastewater discharge from CIP operations), associated environmental impact, significance determination criteria, significance rating, applicable legal requirements, existing controls, and residual significance. Core to ISO 14001 Clause 6.1.2 environmental aspects and impacts evaluation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` (
    `ohs_risk_assessment_id` BIGINT COMMENT 'Unique surrogate key for the OHS risk assessment record.',
    `functional_location_id` BIGINT COMMENT 'Reference to the plant or site where the activity occurs.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department responsible for the activity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the assessment.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: OHS risk assessments are performed per R&D project to evaluate worker safety and meet regulatory requirements.',
    `work_activity_id` BIGINT COMMENT 'Reference to the specific work activity or task being assessed.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment was formally approved.',
    `assessment_date` DATE COMMENT 'Date the risk assessment was performed.',
    `assessment_method` STRING COMMENT 'Method used to perform the risk assessment.. Valid values are `qualitative|quantitative|checklist`',
    `assessment_number` STRING COMMENT 'Business identifier assigned to the risk assessment, often used in reports and regulatory filings.',
    `assessment_status` STRING COMMENT 'Lifecycle status of the assessment record.. Valid values are `draft|under_review|approved|closed`',
    `attachment_count` STRING COMMENT 'Number of supporting documents or files attached to the assessment.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the assessed hazard.. Valid values are `compliant|non_compliant|exempt`',
    `control_recommendation_status` STRING COMMENT 'Current status of the recommended control actions.. Valid values are `pending|implemented|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `existing_controls` STRING COMMENT 'Textual description of engineering, administrative, or PPE controls currently in place.',
    `hazard_description` STRING COMMENT 'Narrative description of the hazard, including chemical name, physical condition, or ergonomic factor.',
    `hazard_type` STRING COMMENT 'Classification of the primary hazard addressed by the assessment.. Valid values are `chemical|physical|biological|ergonomic|psychosocial`',
    `inherent_likelihood` STRING COMMENT 'Likelihood rating (1‑5) before controls are applied.',
    `inherent_risk_score` STRING COMMENT 'Calculated inherent risk score (likelihood × severity).',
    `inherent_severity` STRING COMMENT 'Severity rating (1‑5) before controls are applied.',
    `mitigation_due_date` DATE COMMENT 'Target date by which recommended controls should be implemented.',
    `mitigation_effectiveness` STRING COMMENT 'Assessment of how well the implemented controls have reduced risk.. Valid values are `effective|partially_effective|ineffective`',
    `mitigation_status` STRING COMMENT 'Current progress status of the mitigation plan.. Valid values are `not_started|in_progress|completed`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or observations.',
    `ohs_risk_assessment_description` STRING COMMENT 'Detailed narrative of the assessment scope, objectives, and context.',
    `ppe_required` BOOLEAN COMMENT 'Indicates whether PPE is required for the assessed activity.',
    `recommended_controls` STRING COMMENT 'Suggested additional or enhanced controls to further reduce risk.',
    `record_version` STRING COMMENT 'Version number of the record for audit‑trail purposes.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation, standard, or clause (e.g., ISO 45001 Clause 6.1.2).',
    `residual_likelihood` STRING COMMENT 'Likelihood rating (1‑5) after existing controls are considered.',
    `residual_risk_score` STRING COMMENT 'Calculated residual risk score (likelihood × severity).',
    `residual_severity` STRING COMMENT 'Severity rating (1‑5) after existing controls are considered.',
    `review_date` DATE COMMENT 'Date the assessment was last reviewed or re‑validated.',
    `revision_number` STRING COMMENT 'Sequential revision identifier for changes to the assessment.',
    `risk_rating` STRING COMMENT 'Overall risk classification derived from the residual risk score.. Valid values are `low|medium|high|critical`',
    `title` STRING COMMENT 'Short, human‑readable title describing the assessment focus.',
    `training_required` BOOLEAN COMMENT 'Indicates whether specific safety training is required for the activity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_ohs_risk_assessment PRIMARY KEY(`ohs_risk_assessment_id`)
) COMMENT 'Occupational Health and Safety (OHS) risk assessment record for Chemical Mfg work activities and tasks. Captures hazard description, hazard type (chemical, physical, biological, ergonomic, psychosocial), affected work activity, inherent risk rating (likelihood × severity), existing controls, residual risk rating, additional control recommendations, and review date. Supports ISO 45001 Clause 6.1.2 hazard identification and risk assessment and OSHA PSM process hazard analysis for non-PSM covered tasks.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` (
    `spill_release_event_id` BIGINT COMMENT 'System-generated unique identifier for the spill or accidental release event record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Spill reports must be linked to the chemical product for emergency response, EPA reporting, and liability tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates spill response and cleanup costs to the responsible cost center for financial impact analysis.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to ehs.emergency_response_plan. Business justification: Spill and release events are handled according to a facilitys emergency response plan. Adding emergency_response_plan_id to spill_release_event creates the needed link.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the specific site location (e.g., area, zone, or coordinate) within the facility.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Spill Incident Reporting mandates linking a spill event to the shipment that caused it for EPA reporting and corrective action.',
    `site_id` BIGINT COMMENT 'Identifier of the plant or facility where the spill occurred.',
    `agencies_notified` STRING COMMENT 'Comma-separated list of regulatory agencies that were notified about the spill.',
    `cleanup_completed` BOOLEAN COMMENT 'Indicates whether remediation and cleanup activities have been completed.',
    `cleanup_completion_date` DATE COMMENT 'Date when the spill cleanup was officially closed.',
    `comments` STRING COMMENT 'Free-text field for additional notes or observations about the spill.',
    `containment_effectiveness` STRING COMMENT 'Effectiveness of containment measures at the time of release.. Valid values are `full|partial|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spill event record was first created in the system.',
    `detection_method` STRING COMMENT 'Method or sensor that first detected the release.',
    `emergency_response_actions` STRING COMMENT 'Summary of immediate actions taken to mitigate the spill.',
    `event_number` STRING COMMENT 'Business-assigned identifier or ticket number for the spill event, used for tracking and external reporting.',
    `federal_report_number` STRING COMMENT 'Report identifier assigned by the federal agency.',
    `incident_report_number` STRING COMMENT 'External report identifier assigned by regulatory agencies or internal tracking.',
    `is_reportable_to_iso` BOOLEAN COMMENT 'True if the incident must be reported under ISO 14001/45001 audit requirements.',
    `is_reportable_to_osha` BOOLEAN COMMENT 'True if the spill triggers OSHA recordable incident reporting.',
    `is_reported_to_federal` BOOLEAN COMMENT 'True if the spill was reported to a federal agency (e.g., EPA).',
    `is_reported_to_state` BOOLEAN COMMENT 'True if the spill was reported to the relevant state environmental agency.',
    `iso_report_number` STRING COMMENT 'Identifier for the ISO compliance report.',
    `osha_report_number` STRING COMMENT 'Identifier for the OSHA incident report.',
    `quantity_released` DECIMAL(18,2) COMMENT 'Measured amount of chemical released.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the released quantity.. Valid values are `kg|lb|g|L|gal`',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether the spill meets regulatory reporting thresholds.',
    `release_cause` STRING COMMENT 'Root cause category for the accidental release.. Valid values are `equipment_failure|human_error|natural_event|unknown`',
    `release_media` STRING COMMENT 'Medium(s) into which the chemical was released.. Valid values are `air|soil|water|drain|other`',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the chemical release actually occurred.',
    `reportable_under_cercla` BOOLEAN COMMENT 'True if the release is reportable under the Comprehensive Environmental Response, Compensation, and Liability Act.',
    `reportable_under_epcra` BOOLEAN COMMENT 'True if the release triggers reporting under EPCRA Section 304.',
    `spill_release_event_status` STRING COMMENT 'Current lifecycle status of the spill event record.. Valid values are `reported|investigated|closed|cancelled`',
    `state_spill_report_number` STRING COMMENT 'Report identifier assigned by the state agency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the spill event record.',
    `weather_conditions` STRING COMMENT 'Brief description of weather at the time of release (e.g., wind speed, precipitation).',
    CONSTRAINT pk_spill_release_event PRIMARY KEY(`spill_release_event_id`)
) COMMENT 'Chemical spill and accidental release event record for Chemical Mfg facilities. Captures release date/time, chemical identity (CAS number), quantity released, release media (air, soil, water, drain), release cause, containment effectiveness, emergency response actions taken, regulatory reportability determination (CERCLA RQ, EPCRA 304, state spill reporting), agency notification records, and cleanup completion status. Distinct from planned emission events; captures unplanned/accidental releases requiring immediate response.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` (
    `contractor_safety_record_id` BIGINT COMMENT 'Unique surrogate key for the contractor safety record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charges contractor safety audit costs to the cost center overseeing the contractor.',
    `active_violations_count` STRING COMMENT 'Count of currently open safety violations for the contractor.',
    `active_violations_details` STRING COMMENT 'Brief description of each active safety violation.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the contractor with EHS regulations.. Valid values are `compliant|non_compliant|under_review`',
    `contractor_address` STRING COMMENT 'Street address of the contractors primary office.',
    `contractor_city` STRING COMMENT 'City component of the contractors address.',
    `contractor_code` STRING COMMENT 'Internal or external code used to identify the contractor.',
    `contractor_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the contractors primary location.',
    `contractor_name` STRING COMMENT 'Legal name of the contractor organization.',
    `contractor_parent_company` STRING COMMENT 'Name of the parent company if the contractor is a subsidiary.',
    `contractor_state` STRING COMMENT 'State or province component of the contractors address.',
    `contractor_type` STRING COMMENT 'Classification of the contractor based on the nature of services provided.. Valid values are `general_contractor|subcontractor|service_provider|consultant`',
    `contractor_zip` STRING COMMENT 'Postal/ZIP code of the contractors address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contractor safety record was first created.',
    `emr_effective_date` DATE COMMENT 'Date the EMR value became effective for the contractor.',
    `experience_modification_rate` DECIMAL(18,2) COMMENT 'Insurance-based metric reflecting the contractors safety performance.',
    `insurance_certificate_number` STRING COMMENT 'Number of the contractors liability insurance certificate.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the liability insurance certificate.',
    `last_safety_audit_date` DATE COMMENT 'Date of the most recent safety audit performed on the contractor.',
    `last_safety_audit_score` DECIMAL(18,2) COMMENT 'Score (0‑100) assigned in the most recent safety audit.',
    `near_miss_frequency` DECIMAL(18,2) COMMENT 'Frequency of near‑miss events per 1,000 work hours.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the contractors safety record.',
    `orientation_completion_date` DATE COMMENT 'Date the site-specific safety orientation was completed.',
    `osha_300_log_review_status` STRING COMMENT 'Status of the review of the contractors OSHA 300 Log.. Valid values are `completed|pending|not_applicable`',
    `prequalification_expiration_date` DATE COMMENT 'Date the prequalification status expires and must be renewed.',
    `prequalification_review_date` DATE COMMENT 'Date the safety prequalification was reviewed.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary safety contact.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary safety contact for the contractor.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary safety contact.',
    `primary_contact_role` STRING COMMENT 'Job role of the primary safety contact within the contractor organization.',
    `record_status` STRING COMMENT 'Current lifecycle status of the contractor safety record.. Valid values are `active|inactive|closed`',
    `recordable_incident_rate` DECIMAL(18,2) COMMENT 'Number of recordable incidents per 200,000 work hours for the contractor.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation(s) governing the contractors safety requirements (e.g., OSHA, EPA).',
    `requalification_due_date` DATE COMMENT 'Date by which the contractor must be re‑qualified for safety compliance.',
    `safety_audit_status` STRING COMMENT 'Overall result of the latest safety audit.. Valid values are `passed|failed|conditional`',
    `safety_prequalification_status` STRING COMMENT 'Result of the contractors safety prequalification assessment.. Valid values are `qualified|conditionally_qualified|not_qualified|pending`',
    `site_specific_orientation_completed` BOOLEAN COMMENT 'Indicates whether the contractor has completed site-specific safety orientation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `workers_comp_cert_expiration` DATE COMMENT 'Expiration date of the workers compensation certificate.',
    `workers_compensation_certificate_number` STRING COMMENT 'Number of the contractors workers compensation insurance certificate.',
    CONSTRAINT pk_contractor_safety_record PRIMARY KEY(`contractor_safety_record_id`)
) COMMENT 'Contractor safety qualification and performance record for third-party contractors working at Chemical Mfg facilities. Captures contractor company, contract scope, safety prequalification status, OSHA 300 log review, EMR (Experience Modification Rate), site-specific safety orientation completion, safety performance metrics (recordable rate, near-miss frequency), active violations, and re-qualification due date. Supports OSHA PSM contractor safety program requirements under 29 CFR 1910.119(h) and Responsible Care contractor management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` (
    `sampling_point_id` BIGINT COMMENT 'Primary key for sampling_point',
    `parent_sampling_point_id` BIGINT COMMENT 'Self-referencing FK on sampling_point (parent_sampling_point_id)',
    `address_line1` STRING COMMENT 'First line of the physical address of the sampling point.',
    `city` STRING COMMENT 'City where the sampling point is located.',
    `sampling_point_code` STRING COMMENT 'Business‑assigned alphanumeric code uniquely identifying the sampling point.',
    `contact_email` STRING COMMENT 'Primary email address for the point of contact responsible for the sampling point.',
    `contact_phone` STRING COMMENT 'Phone number for the point of contact responsible for the sampling point.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the sampling point location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sampling point record was first created.',
    `sampling_point_description` STRING COMMENT 'Free‑form description providing context or notes about the sampling point.',
    `effective_from` DATE COMMENT 'Date when the sampling point became operational.',
    `effective_until` DATE COMMENT 'Date when the sampling point is scheduled to be retired or decommissioned (nullable).',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the sampling point above sea level, expressed in meters.',
    `hazard_class` STRING COMMENT 'Primary hazard classification associated with the sampling point.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the sampling point is located in a hazardous area.',
    `last_sampling_date` DATE COMMENT 'Date when the most recent sample was collected at this point.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the sampling point in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the sampling point in decimal degrees.',
    `media_type` STRING COMMENT 'Physical medium being sampled (e.g., air, water).',
    `sampling_point_name` STRING COMMENT 'Human‑readable name of the sampling location.',
    `next_sampling_due` DATE COMMENT 'Planned date for the next scheduled sample collection.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the sampling point.',
    `regulatory_category` STRING COMMENT 'Regulatory regime governing monitoring at this point.',
    `sampling_frequency_days` STRING COMMENT 'Number of days between scheduled sampling events.',
    `sampling_method` STRING COMMENT 'Method used to collect the sample at this point.',
    `state` STRING COMMENT 'State or province of the sampling point location.',
    `sampling_point_status` STRING COMMENT 'Current lifecycle status of the sampling point.',
    `sampling_point_type` STRING COMMENT 'Category of media sampled at this point (e.g., air, water).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the sampling point record.',
    `zip_code` STRING COMMENT 'Postal or ZIP code for the sampling point address.',
    CONSTRAINT pk_sampling_point PRIMARY KEY(`sampling_point_id`)
) COMMENT 'Master reference table for sampling_point. Referenced by sampling_point_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key for facility',
    `parent_facility_id` BIGINT COMMENT 'Self-referencing FK on facility (parent_facility_id)',
    `address_line1` STRING COMMENT 'First line of the facilitys street address.',
    `address_line2` STRING COMMENT 'Second line of the facilitys street address, if applicable.',
    `capacity_tons_per_year` DECIMAL(18,2) COMMENT 'Maximum annual production capacity in metric tons.',
    `city` STRING COMMENT 'City of the facilitys location.',
    `closing_date` DATE COMMENT 'Date the facility was permanently closed, if applicable.',
    `facility_code` STRING COMMENT 'Unique operational code assigned to the facility.',
    `compliance_reporting_status` STRING COMMENT 'Current status of the facilitys regulatory compliance reporting.',
    `country` STRING COMMENT 'Three‑letter country code where the facility resides.',
    `facility_description` STRING COMMENT 'Additional descriptive information about the facility.',
    `ehs_certification_status` STRING COMMENT 'Current status of the facilitys EHS certifications.',
    `ehs_certification_type` STRING COMMENT 'Type of EHS certification held by the facility.',
    `emergency_shutoff_available` BOOLEAN COMMENT 'Indicates whether an emergency shutoff system is installed and functional.',
    `emissions_co2_tons_year` DECIMAL(18,2) COMMENT 'Total CO2 emissions reported for the facility in a calendar year (metric tons).',
    `emissions_hap_tons_year` DECIMAL(18,2) COMMENT 'Total hazardous air pollutants emitted by the facility in a calendar year (metric tons).',
    `energy_consumption_mwh_year` DECIMAL(18,2) COMMENT 'Total energy consumed by the facility in a calendar year (megawatt‑hours).',
    `fire_suppression_system` BOOLEAN COMMENT 'Indicates presence of an active fire suppression system.',
    `hazardous_materials_handled` STRING COMMENT 'List or description of hazardous materials the facility handles.',
    `last_inspection_date` DATE COMMENT 'Date when the most recent EHS inspection was performed.',
    `last_reported_tri_date` DATE COMMENT 'Date of the most recent Toxic Release Inventory (TRI) submission for the facility.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the facility location.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the facility location.',
    `facility_name` STRING COMMENT 'The official name of the facility.',
    `next_inspection_due` DATE COMMENT 'Planned date for the next EHS inspection.',
    `number_of_employees` STRING COMMENT 'Total number of employees regularly assigned to the facility.',
    `opening_date` DATE COMMENT 'Date the facility commenced operations.',
    `operating_company` STRING COMMENT 'Legal entity that operates the facility.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the facility.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the facility record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the facility record.',
    `region` STRING COMMENT 'Geographic or organizational region to which the facility belongs.',
    `square_footage` BIGINT COMMENT 'Total building area in square feet.',
    `state` STRING COMMENT 'State or province of the facility.',
    `facility_status` STRING COMMENT 'Current lifecycle status of the facility.',
    `facility_type` STRING COMMENT 'Category of the facility (e.g., manufacturing plant, distribution center).',
    `waste_disposal_method` STRING COMMENT 'Primary method used for waste disposal at the facility.',
    `water_usage_cubic_meters_year` DECIMAL(18,2) COMMENT 'Total water consumed by the facility in a calendar year (cubic meters).',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master reference table for facility. Referenced by facility_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`control_device` (
    `control_device_id` BIGINT COMMENT 'Primary key for control_device',
    `functional_location_id` BIGINT COMMENT 'Identifier of the plant or area where the device is installed.',
    `upstream_control_device_id` BIGINT COMMENT 'Self-referencing FK on control_device (upstream_control_device_id)',
    `alarm_status` STRING COMMENT 'Current alarm condition of the device.',
    `alarm_threshold_high` DECIMAL(18,2) COMMENT 'Upper limit that triggers a high‑value alarm.',
    `alarm_threshold_low` DECIMAL(18,2) COMMENT 'Lower limit that triggers a low‑value alarm.',
    `commissioning_date` DATE COMMENT 'Date the device became operational after testing.',
    `control_strategy` STRING COMMENT 'Algorithm or method the device uses to control a process variable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the device record was first created.',
    `current_value` DECIMAL(18,2) COMMENT 'Most recent measurement reported by the device.',
    `current_value_timestamp` TIMESTAMP COMMENT 'Timestamp of the latest measurement.',
    `decommission_date` DATE COMMENT 'Date the device was removed from service.',
    `decommission_reason` STRING COMMENT 'Reason for taking the device out of service.',
    `device_code` STRING COMMENT 'Internal code used to reference the device within the EHS system.',
    `device_type` STRING COMMENT 'Category of the device indicating its functional role.',
    `hazard_classification` STRING COMMENT 'Regulatory hazard class assigned to the device.',
    `inspection_interval_days` STRING COMMENT 'Number of days between routine inspections.',
    `installation_date` DATE COMMENT 'Date the device was physically installed at the site.',
    `is_active` BOOLEAN COMMENT 'True if the device is currently enabled for operation.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the device is critical to safety or process continuity.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the device.',
    `max_operating_range` DECIMAL(18,2) COMMENT 'Highest permissible value for safe operation.',
    `measurement_type` STRING COMMENT 'Physical variable measured or controlled by the device.',
    `measurement_units` STRING COMMENT 'Units of the measured variable (e.g., °C, psi).',
    `min_operating_range` DECIMAL(18,2) COMMENT 'Lowest permissible value for safe operation.',
    `model_number` STRING COMMENT 'Model designation assigned by the manufacturer.',
    `control_device_name` STRING COMMENT 'Human‑readable name or label of the control device.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `safety_rating` STRING COMMENT 'Safety classification based on industry standards.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the device hardware.',
    `setpoint_units` STRING COMMENT 'Units of the setpoint value (e.g., psi, °C).',
    `setpoint_value` DECIMAL(18,2) COMMENT 'Target value the device aims to maintain.',
    `control_device_status` STRING COMMENT 'Current operational state of the device.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the device record.',
    CONSTRAINT pk_control_device PRIMARY KEY(`control_device_id`)
) COMMENT 'Master reference table for control_device. Referenced by control_device_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` (
    `work_activity_id` BIGINT COMMENT 'Primary key for work_activity',
    `parent_work_activity_id` BIGINT COMMENT 'Self-referencing FK on work_activity (parent_work_activity_id)',
    `activity_category` STRING COMMENT 'High‑level category grouping of the work activity.',
    `activity_code` STRING COMMENT 'Short alphanumeric code identifying the work activity type.',
    `activity_description` STRING COMMENT 'Detailed description of the work activity, including purpose and scope.',
    `activity_name` STRING COMMENT 'Descriptive name of the work activity.',
    `activity_type` STRING COMMENT 'Indicates whether the activity is routine, non‑routine, preventive, or corrective.',
    `cost_center_code` STRING COMMENT 'Cost center to which activity costs are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the activity record was first created.',
    `department_code` STRING COMMENT 'Department responsible for the activity.',
    `emergency_contact_number` STRING COMMENT 'Phone number for the emergency contact associated with the activity.',
    `emergency_contact_required` BOOLEAN COMMENT 'Indicates whether an emergency contact must be on‑site during the activity.',
    `emission_type` STRING COMMENT 'Primary environmental emission type associated with the activity.',
    `equipment_required` STRING COMMENT 'List of equipment or tools needed to perform the activity.',
    `estimated_duration_minutes` STRING COMMENT 'Typical time required to complete the activity, expressed in minutes.',
    `exposure_control_plan` STRING COMMENT 'Reference to the exposure control plan document for the activity.',
    `hazard_classification` STRING COMMENT 'Primary hazard class associated with the activity.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the activity type is currently active and usable.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the activity must be reported to regulatory agencies.',
    `location_required` BOOLEAN COMMENT 'Indicates whether a specific location must be assigned when scheduling the activity.',
    `location_type` STRING COMMENT 'Typical location category where the activity is performed.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or special instructions.',
    `permit_required` BOOLEAN COMMENT 'Indicates whether a special permit is required to perform the activity.',
    `permit_type` STRING COMMENT 'Type of permit required, if any.',
    `regulatory_requirement_codes` STRING COMMENT 'Codes of regulatory requirements applicable to the activity (e.g., OSHA, EPA).',
    `report_frequency` STRING COMMENT 'How often the activity must be reported.',
    `required_training` STRING COMMENT 'Comma‑separated list of training codes required before performing the activity.',
    `risk_level` STRING COMMENT 'Assessed safety risk level for performing the activity.',
    `safety_procedure_document` STRING COMMENT 'Link or identifier to the detailed safety procedure document.',
    `updated_by` STRING COMMENT 'User identifier who last modified the activity record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the activity record.',
    `waste_generated` BOOLEAN COMMENT 'Indicates whether the activity generates waste.',
    `waste_type` STRING COMMENT 'Classification of waste produced by the activity.',
    `created_by` STRING COMMENT 'User identifier who created the activity record.',
    CONSTRAINT pk_work_activity PRIMARY KEY(`work_activity_id`)
) COMMENT 'Master reference table for work_activity. Referenced by work_activity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ADD CONSTRAINT `fk_ehs_hazop_node_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_source`(`emission_source_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_control_device_id` FOREIGN KEY (`control_device_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`control_device`(`control_device_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ADD CONSTRAINT `fk_ehs_ehs_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ADD CONSTRAINT `fk_ehs_ehs_regulatory_submission_related_submission_ehs_regulatory_submission_id` FOREIGN KEY (`related_submission_ehs_regulatory_submission_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission`(`ehs_regulatory_submission_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ADD CONSTRAINT `fk_ehs_safety_data_sheet_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ADD CONSTRAINT `fk_ehs_tri_inventory_ehs_regulatory_submission_id` FOREIGN KEY (`ehs_regulatory_submission_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission`(`ehs_regulatory_submission_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ADD CONSTRAINT `fk_ehs_environmental_aspect_management_objective_id` FOREIGN KEY (`management_objective_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_objective`(`management_objective_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ADD CONSTRAINT `fk_ehs_ohs_risk_assessment_work_activity_id` FOREIGN KEY (`work_activity_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`work_activity`(`work_activity_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ADD CONSTRAINT `fk_ehs_spill_release_event_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ADD CONSTRAINT `fk_ehs_sampling_point_parent_sampling_point_id` FOREIGN KEY (`parent_sampling_point_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ADD CONSTRAINT `fk_ehs_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` ADD CONSTRAINT `fk_ehs_control_device_upstream_control_device_id` FOREIGN KEY (`upstream_control_device_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`control_device`(`control_device_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` ADD CONSTRAINT `fk_ehs_work_activity_parent_work_activity_id` FOREIGN KEY (`parent_work_activity_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`work_activity`(`work_activity_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`ehs` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `chemical_mfg_ecm`.`ehs` SET TAGS ('dbx_domain' = 'ehs');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Location ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `tertiary_safety_investigation_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Lead Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `tertiary_safety_investigation_lead_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `tertiary_safety_investigation_lead_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `attachments_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachments Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `exposure_concentration` SET TAGS ('dbx_business_glossary_term' = 'Exposure Concentration');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `exposure_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exposure Exceedance Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `exposure_measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Exposure Measurement Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `exposure_measurement_type` SET TAGS ('dbx_value_regex' = 'personal_air|area_monitoring|biological');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `exposure_threshold` SET TAGS ('dbx_business_glossary_term' = 'Exposure Threshold');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `exposure_units` SET TAGS ('dbx_business_glossary_term' = 'Exposure Units');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `exposure_units` SET TAGS ('dbx_value_regex' = 'ppm|mg_m3|µg_m3');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `first_aid_provided` SET TAGS ('dbx_business_glossary_term' = 'First‑Aid Provided');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Actions');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number (INC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'injury|illness|near_miss|property_damage|process_safety|chemical_exposure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_value_regex' = 'laceration|burn|fracture|sprain|chemical_exposure|other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `lost_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Days');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `lost_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Hours');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Required');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `number_of_affected` SET TAGS ('dbx_business_glossary_term' = 'Number of Affected Persons');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Amount (USD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `psm_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management Incident Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `safety_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `safety_incident_status` SET TAGS ('dbx_value_regex' = 'open|investigating|closed|reopened');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `production_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Deviation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `corrective_action_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Recommendations');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `direct_cause` SET TAGS ('dbx_business_glossary_term' = 'Direct Cause');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount (USD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Actions');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `impact_area` SET TAGS ('dbx_business_glossary_term' = 'Impact Area');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `impact_area` SET TAGS ('dbx_value_regex' = 'safety|environment|quality|production');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `incident_investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `incident_investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `investigation_description` SET TAGS ('dbx_business_glossary_term' = 'Investigation Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number (INV_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `investigation_title` SET TAGS ('dbx_business_glossary_term' = 'Investigation Title');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type (INV_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'root_cause|near_miss|hazard|process_deviation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `investigator_team_ids` SET TAGS ('dbx_business_glossary_term' = 'Investigator Team IDs');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Methodology (RCM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'five_why|fault_tree|hazop|fishbone');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Capa Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Related MOC Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `primary_capa_employee_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `primary_capa_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `primary_capa_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Action Type (Corrective or Preventive)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `attached_document_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Count');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Reason');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'CAPA Actual Cost');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'CAPA Cost Estimate');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Due Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'CAPA Effectiveness Rating');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'External Involvement Indicator');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAPA General Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_value_regex' = 'OSHA|EPA|ISO45001|ISO14001|REACH|GHS');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'CAPA Review Comments');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|trivial');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'CAPA Verification Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|audit|test|review');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` SET TAGS ('dbx_subdomain' = 'process_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard and Operability (HAZOP) Study Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Study Team Lead');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `action_owner` SET TAGS ('dbx_business_glossary_term' = 'Action Owner');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|deferred|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Study Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Study Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Documentation Link');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `exposure_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `hazard_classifications` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classifications (GHS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `hazop_study_status` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Study Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `hazop_study_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|revalidated|closed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `inventory_unit` SET TAGS ('dbx_business_glossary_term' = 'Inventory Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `inventory_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|ton');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `max_intended_inventory` SET TAGS ('dbx_business_glossary_term' = 'Maximum Intended Inventory');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Study Methodology');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'Guideword|What-If|Checklist|LOPA');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `overall_risk_rank` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Rank');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `overall_risk_rank` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|plasma');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `process_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `process_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Actions');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'OSHA_PSM|EPA_RMP|ISO_45001|ISO_14001|REACH|GHS');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `revalidation_date` SET TAGS ('dbx_business_glossary_term' = 'Study Revalidation Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Risk Likelihood Score');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Score');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Study Scope Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Study Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `study_title` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Study Title');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Study Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'HAZOP|What-If|LOPA|Checklist');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Study Team Members');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Study Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` SET TAGS ('dbx_subdomain' = 'process_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `hazop_node_id` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Node Identifier (HAZOP_NODE_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner (ACTION_OWNER)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQUIPMENT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Study Identifier (HAZOP_STUDY_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date (ACTION_DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause (ROOT_CAUSE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt|under_review');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `consequence` SET TAGS ('dbx_business_glossary_term' = 'Potential Consequence (POTENTIAL_CONSEQUENCE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `control_strategy` SET TAGS ('dbx_business_glossary_term' = 'Control Strategy (CONTROL_STRATEGY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RECORD_CREATION_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `design_intent` SET TAGS ('dbx_business_glossary_term' = 'Design Intent (DESIGN_INTENT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `existing_safeguard` SET TAGS ('dbx_business_glossary_term' = 'Existing Safeguard (EXISTING_SAFEGUARD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `exposure_limit` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit (EXPOSURE_LIMIT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `exposure_unit` SET TAGS ('dbx_business_glossary_term' = 'Exposure Unit (EXPOSURE_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `guide_words` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Guide Words (HAZOP_GUIDE_WORDS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type (HAZARD_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'chemical|physical|biological|ergonomic|psychosocial');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `hazop_node_status` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Node Status (HAZOP_NODE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `hazop_node_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_review|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `identified_deviation` SET TAGS ('dbx_business_glossary_term' = 'Identified Deviation (IDENTIFIED_DEVIATION)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag (IS_CRITICAL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `likelihood` SET TAGS ('dbx_business_glossary_term' = 'Likelihood (LIKELIHOOD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `likelihood` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `mitigation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Due Date (MITIGATION_DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `mitigation_owner` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Owner (MITIGATION_OWNER)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status (MITIGATION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Node Code (HAZOP_NODE_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `node_label` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Node Label (HAZOP_NODE_LABEL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `node_location` SET TAGS ('dbx_business_glossary_term' = 'Node Location (NODE_LOCATION)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Node Type (HAZOP_NODE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'process_section|equipment|control_logic|instrumentation|utility');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action (RECOMMENDED_ACTION)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (REGULATORY_REFERENCE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date (REVIEW_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By (REVIEWED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `risk_rank` SET TAGS ('dbx_business_glossary_term' = 'Risk Rank (RISK_RANK)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `risk_rank` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|extreme');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Risk Score (HAZOP_RISK_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `safety_category` SET TAGS ('dbx_business_glossary_term' = 'Safety Category (SAFETY_CATEGORY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `safety_category` SET TAGS ('dbx_value_regex' = 'process|facility|environment|health|security');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity (SEVERITY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical|catastrophic');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RECORD_UPDATE_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `chemical_exposure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Exposure Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Substance Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Equipment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Organizational Department');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `employee_role` SET TAGS ('dbx_business_glossary_term' = 'Employee Role');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exposure Exceedance Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_category` SET TAGS ('dbx_business_glossary_term' = 'Exposure Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_category` SET TAGS ('dbx_value_regex' = 'inhalation|dermal|ocular');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Exposure Duration (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_source` SET TAGS ('dbx_business_glossary_term' = 'Exposure Source Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_status` SET TAGS ('dbx_value_regex' = 'normal|exceedance|follow_up_required');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_type` SET TAGS ('dbx_business_glossary_term' = 'Exposure Monitoring Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `exposure_type` SET TAGS ('dbx_value_regex' = 'personal_air|area_monitoring|biological');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Required Follow‑Up Action');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `limit_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg/m3|µg/m3');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Value');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration Unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg/m3|µg/m3');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration Value');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Record Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `ppe_used` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment Used');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cause_of_release` SET TAGS ('dbx_business_glossary_term' = 'Cause of Release');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cause_of_release` SET TAGS ('dbx_value_regex' = 'equipment_failure|human_error|natural|other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cleanup_status` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cleanup_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_required');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `containment_success_flag` SET TAGS ('dbx_business_glossary_term' = 'Containment Success Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emergency_response_action` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Action');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_category` SET TAGS ('dbx_value_regex' = 'point|fugitive|accidental');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_event_status` SET TAGS ('dbx_value_regex' = 'open|closed|investigating');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_factor_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_quantity` SET TAGS ('dbx_business_glossary_term' = 'Emission Quantity');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_unit` SET TAGS ('dbx_value_regex' = 'kg|ton|lb|g');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'routine|accidental|spill');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'cems|stack_test|estimate|model');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|annual');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `regulatory_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `release_media` SET TAGS ('dbx_business_glossary_term' = 'Release Media');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `release_media` SET TAGS ('dbx_value_regex' = 'air|soil|water|drain');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|rejected|approved');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `source_permit_limit` SET TAGS ('dbx_business_glossary_term' = 'Source Permit Limit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `source_permit_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Source Permit Limit Unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `source_reference` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Reference');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'stack|vent|tank|fugitive_point');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Identifier (ESID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `control_device_id` SET TAGS ('dbx_business_glossary_term' = 'Control Device Identifier (CDID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `control_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `control_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (PUID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit (CU)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'm3_per_hr|kg_per_hr');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DQF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|pending');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor (EF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_factor_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Unit (EFU)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_factor_unit` SET TAGS ('dbx_value_regex' = 'kg_per_ton|lb_per_ton');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Limit Unit (ELU)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_limit_unit` SET TAGS ('dbx_value_regex' = 'kg_per_hr|t_per_day|lb_per_hr');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Limit Value (ELV)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_medium` SET TAGS ('dbx_business_glossary_term' = 'Emission Medium (EM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_medium` SET TAGS ('dbx_value_regex' = 'air|water|soil');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `emission_source_description` SET TAGS ('dbx_business_glossary_term' = 'Source Description (SD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (Facility ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `is_area_source` SET TAGS ('dbx_business_glossary_term' = 'Is Area Source (IAS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `is_controlled` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled (IC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `is_fugitive` SET TAGS ('dbx_business_glossary_term' = 'Is Fugitive Source (IFS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `is_point_source` SET TAGS ('dbx_business_glossary_term' = 'Is Point Source (IPS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable (IR)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `last_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Date (LMD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (°)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Lifecycle Status (ESLS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|planned');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description (LD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (°)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method (MM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'continuous|periodic|manual');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (MF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `next_monitoring_due` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Due Date (NMDD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date (PED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date (PID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number (PN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Reporting Category (RC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `reporting_category` SET TAGS ('dbx_value_regex' = 'EPA|OSHA|REACH|GHS');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_capacity` SET TAGS ('dbx_business_glossary_term' = 'Source Capacity (SC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Code (ESC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_group` SET TAGS ('dbx_business_glossary_term' = 'Source Group (SG)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Name (ESN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_operating_hours_per_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Hours (AH)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_owner` SET TAGS ('dbx_business_glossary_term' = 'Source Owner (SO)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_status` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Operational Status (ESOS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|planned');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type (EST)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'stack|vent|fugitive|tank|wastewater|process_unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` SET TAGS ('dbx_subdomain' = 'waste_operations');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Record ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost Amount');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `disposal_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|recycling|treatment|recovery');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `disposal_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Transaction Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `disposal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposal Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Waste Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `hazardous_waste_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Classification');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `hazardous_waste_classification` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|mixed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `land_disposal_restrictions_compliance` SET TAGS ('dbx_business_glossary_term' = 'LDR Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `ldr_compliance_details` SET TAGS ('dbx_business_glossary_term' = 'LDR Compliance Details');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'EPA Manifest Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Disposed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|gal|l');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `rcra_hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'RCRA Hazardous Waste Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `regulatory_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ship|air');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Batch/Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_characteristics` SET TAGS ('dbx_business_glossary_term' = 'Waste Characteristics');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_disposal_record_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Record Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_disposal_record_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_disposal_type` SET TAGS ('dbx_business_glossary_term' = 'Disposal Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_disposal_type` SET TAGS ('dbx_value_regex' = 'single|multiple|unknown');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Waste Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` SET TAGS ('dbx_subdomain' = 'waste_operations');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `average_monthly_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Volume');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `disposal_frequency` SET TAGS ('dbx_business_glossary_term' = 'Disposal Frequency');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `disposal_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|as_generated');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Approved Disposal Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|recycling|chemical_treatment|secure_storage|export');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Waste Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `generation_rate` SET TAGS ('dbx_business_glossary_term' = 'Typical Generation Rate');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `hazardous_materials` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials List');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `last_disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disposal Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `rcra_hazardous` SET TAGS ('dbx_business_glossary_term' = 'RCRA Hazardous Determination');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'notified|pending|exempt|deferred');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|liters|cubic_meters');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|radioactive|biological|chemical|mixed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_stream_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_stream_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_stream_name` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_stream_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_stream_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `ehs_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID (RSID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitting Employee Identifier (SEID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `related_submission_ehs_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Related Submission Identifier (RSID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Receipt Date (ARD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `acknowledgment_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Flag (ARF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `agency_recipient` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Recipient (RAR)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `agency_recipient` SET TAGS ('dbx_value_regex' = 'EPA|OSHA|ECHA|TSCA|State_Env|Local_Env');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `annual_throughput_quantity` SET TAGS ('dbx_business_glossary_term' = 'Annual Throughput Quantity (ATQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments (AC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Indicator Flag (CIF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference (SDR)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag (CF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `max_on_site_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum On‑Site Amount (MOA) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit or Registration Number (PRN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `release_quantity_air` SET TAGS ('dbx_business_glossary_term' = 'Air Release Quantity (ARQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `release_quantity_land` SET TAGS ('dbx_business_glossary_term' = 'Land Release Quantity (LRQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `release_quantity_offsite_transfer` SET TAGS ('dbx_business_glossary_term' = 'Off‑site Transfer Release Quantity (OTRQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `release_quantity_water` SET TAGS ('dbx_business_glossary_term' = 'Water Release Quantity (WRQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date (RPED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date (RPSD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year (RY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `source_reduction_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Source Reduction Activity Description (SRAD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date (RSD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Number (RSN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_value_regex' = '^SUB-d{8}$');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status (RSS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|rejected|approved|closed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type (RST)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'TRI_Form_R|RMP|Title_V|TSCA_CDR|REACH|OSHA_PSM');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submission_version` SET TAGS ('dbx_business_glossary_term' = 'Submission Version Number (SVN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `submitted_by_name` SET TAGS ('dbx_business_glossary_term' = 'Submitting Employee Name (SEN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `waste_management_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Hierarchy Category (WMHC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ALTER COLUMN `waste_management_hierarchy` SET TAGS ('dbx_value_regex' = 'recycle|treatment|disposal|landfill|incineration|other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `air_emission_type` SET TAGS ('dbx_business_glossary_term' = 'Air Emission Type (AIR_EMISSION_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date (AMENDMENT_EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `amendment_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date (AMENDMENT_EXPIRATION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `compliance_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Report Due Date (COMPLIANCE_REPORT_DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `compliance_report_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Report Status (COMPLIANCE_REPORT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `compliance_report_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|overdue|not_required');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `compliance_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Report Submitted Date (COMPLIANCE_REPORT_SUBMITTED_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `compliance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule (COMPLIANCE_SCHEDULE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|unknown');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (PERMIT_EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `emission_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Limit Unit (EMISSION_LIMIT_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `emission_limit_unit` SET TAGS ('dbx_value_regex' = 'kg_per_year|tons_per_year|lb_per_year|g_per_day');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `emission_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Limit Value (EMISSION_LIMIT_VALUE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (PERMIT_EXPIRATION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FACILITY_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `hazardous_waste_type` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Type (HAZARDOUS_WASTE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency (ISSUING_AGENCY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_value_regex' = 'EPA|State|Local|Tribal');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LAST_INSPECTION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `monitoring_requirements` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Requirements (MONITORING_REQUIREMENTS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date (NEXT_INSPECTION_DUE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `operating_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Lifecycle Status (PERMIT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `operating_permit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending|revoked');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Amendment Number (AMENDMENT_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions (PERMIT_CONDITIONS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_document_url` SET TAGS ('dbx_business_glossary_term' = 'Permit Document URL (PERMIT_DOCUMENT_URL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Notice Sent Flag (NOTICE_SENT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_address` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Address (PERMIT_HOLDER_ADDRESS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Contact Email (PERMIT_HOLDER_EMAIL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Contact Phone (PERMIT_HOLDER_PHONE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Name (PERMIT_HOLDER_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number (PN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type (e.g., Air, Water, Waste) (PERMIT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'air|water|waste|storage|stormwater');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `renewal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline Date (RENEWAL_DEADLINE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status (RENEWAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'renewed|pending|not_renewed|unknown');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `total_fines_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fines Amount (TOTAL_FINES_AMOUNT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count (VIOLATION_COUNT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `water_discharge_type` SET TAGS ('dbx_business_glossary_term' = 'Water Discharge Type (WATER_DISCHARGE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier (INSPECTOR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FACILITY_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `affected_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Area (AFFECTED_AREA)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status (CLOSURE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|deferred');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required (CORR_ACTIONS_REQ)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `critical_findings` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count (CRIT_FINDINGS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `high_findings` SET TAGS ('dbx_business_glossary_term' = 'High Findings Count (HIGH_FINDINGS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (INSPECT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (INSPECT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp (INSPECT_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type (INSPECT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'osha|epa|iso_14001|iso_45001|responsible_care|third_party');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `low_findings` SET TAGS ('dbx_business_glossary_term' = 'Low Findings Count (LOW_FINDINGS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `medium_findings` SET TAGS ('dbx_business_glossary_term' = 'Medium Findings Count (MED_FINDINGS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes (INSPECTION_NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `regulatory_standard_referenced` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Referenced (REG_STD_REF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description (SCOPE_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `total_findings` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count (TOTAL_FINDINGS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag (HAS_ATTACHMENT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Timestamp (CLOSURE_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required (ACTION_REQUIRED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (ACTION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number (ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type (TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'citation|observation|opportunity|nonconformance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `impact_area` SET TAGS ('dbx_business_glossary_term' = 'Impact Area (IMPACT_AREA)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `impact_area` SET TAGS ('dbx_value_regex' = 'safety|environment|quality|production|compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `inspection_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description (DESCRIPTION)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `inspection_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Lifecycle Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `inspection_finding_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|deferred|rejected');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `observed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Observation Timestamp (OBSERVED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Finding Priority (PRIORITY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Referenced (STANDARD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_value_regex' = 'OSHA|EPA|ISO45001|REACH|GHS|TSCA');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (ROOT_CAUSE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEVERITY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` SET TAGS ('dbx_subdomain' = 'process_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management Of Change Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Party Identifier (INITIATING_PARTY_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `affected_equipment_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Equipment Identifiers (AFFECTED_EQUIPMENT_IDS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `affected_pids` SET TAGS ('dbx_business_glossary_term' = 'Affected P&ID References (AFFECTED_PIDS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `affected_processes` SET TAGS ('dbx_business_glossary_term' = 'Affected Processes (AFFECTED_PROCESSES)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain (APPROVAL_CHAIN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description (CHANGE_DESCRIPTION)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title (CHANGE_TITLE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type (CHANGE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'process|equipment|procedure|facility|software|other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code (COST_CURRENCY_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `cost_estimate_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Amount (COST_ESTIMATE_AMOUNT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `document_reference_ids` SET TAGS ('dbx_business_glossary_term' = 'Document Reference IDs (DOCUMENT_REFERENCE_IDS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `hazop_update_required` SET TAGS ('dbx_business_glossary_term' = 'HAZOP Update Required (HAZOP_UPDATE_REQUIRED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `implementation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation End Date (IMPLEMENTATION_END_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date (IMPLEMENTATION_START_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status (IMPLEMENTATION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `initiating_department` SET TAGS ('dbx_business_glossary_term' = 'Initiating Department (INITIATING_DEPARTMENT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number (MOC_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `moc_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'MOC Submitted Timestamp (MOC_SUBMITTED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `pre_startup_safety_review_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Startup Safety Review Status (PSSR_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `pre_startup_safety_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|failed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created (RECORD_AUDIT_CREATED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated (RECORD_AUDIT_UPDATED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date (REGULATORY_SUBMISSION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status (REGULATORY_SUBMISSION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category (RISK_CATEGORY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `safety_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Completed (SAFETY_REVIEW_COMPLETED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ALTER COLUMN `technical_basis` SET TAGS ('dbx_business_glossary_term' = 'Technical Basis (TECHNICAL_BASIS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` SET TAGS ('dbx_subdomain' = 'process_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Information ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `autoignition_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Autoignition Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `boiling_point_c` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `compatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Compatible Materials');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (kg/m³)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `emergency_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procedure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `environmental_hazards` SET TAGS ('dbx_business_glossary_term' = 'Environmental Hazards');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `environmental_hazards` SET TAGS ('dbx_value_regex' = 'aquatic_toxicity|ozone_depletion|global_warming|soil_contamination|air_pollution');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|reactive|explosive|oxidizer');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_business_glossary_term' = 'Health Hazards');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_value_regex' = 'skin_irritation|respiratory|carcinogenic|reproductive|sensitization|mutagenic');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `incompatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Materials');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `inventory_uom` SET TAGS ('dbx_business_glossary_term' = 'Inventory Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `inventory_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `iupac_name` SET TAGS ('dbx_business_glossary_term' = 'IUPAC Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `max_inventory_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Intended Inventory Amount');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `melting_point_c` SET TAGS ('dbx_business_glossary_term' = 'Melting Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight (g/mol)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `next_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `odor_description` SET TAGS ('dbx_business_glossary_term' = 'Odor Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `ph` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `process_safety_info_status` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Information Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `process_safety_info_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `psm_covered` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management Covered');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `reactivity_hazards` SET TAGS ('dbx_business_glossary_term' = 'Reactivity Hazards');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `reactivity_hazards` SET TAGS ('dbx_value_regex' = 'water_reactive|air_reactive|oxidizer|explosive|pyrophoric');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `rmp_covered` SET TAGS ('dbx_business_glossary_term' = 'Risk Management Plan Covered');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `solubility_water` SET TAGS ('dbx_business_glossary_term' = 'Water Solubility');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `storage_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Recommended Storage Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Recommended Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `vapor_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure (kPa)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `accidental_release_measures` SET TAGS ('dbx_business_glossary_term' = 'Accidental Release Measures');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Document Author');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `author` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `author` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `boiling_point_c` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (kg/m³)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `exposure_controls` SET TAGS ('dbx_business_glossary_term' = 'Exposure Controls/Personal Protection');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `firefighting_measures` SET TAGS ('dbx_business_glossary_term' = 'Firefighting Measures');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `first_aid_measures` SET TAGS ('dbx_business_glossary_term' = 'First‑Aid Measures');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `handling_and_storage` SET TAGS ('dbx_business_glossary_term' = 'Handling and Storage');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `melting_point_c` SET TAGS ('dbx_business_glossary_term' = 'Melting Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `personal_protective_equipment` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `ph` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `physical_chemical_properties` SET TAGS ('dbx_business_glossary_term' = 'Physical and Chemical Properties');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `pictograms` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictograms');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statements');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Information');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `sds_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `sds_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Version');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'GHS Signal Word');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'Danger|Warning');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Intelex|SAP|Other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `toxicological_information` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Information');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `tsca_sara_313_status` SET TAGS ('dbx_business_glossary_term' = 'TSCA SARA 313 Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `tsca_sara_313_status` SET TAGS ('dbx_value_regex' = 'required|exempt|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `vapor_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure (kPa)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `assessment_passed` SET TAGS ('dbx_business_glossary_term' = 'Assessment Passed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Attendance Count');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'OSHA|ISO45001|EPA|REACH|GHS|Other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in_person|online|blended|on_the_job');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Hours)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `is_external_contractor` SET TAGS ('dbx_business_glossary_term' = 'Is External Contractor');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Training');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `retraining_due_date` SET TAGS ('dbx_business_glossary_term' = 'Retraining Due Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'Safety|Environmental|Technical|Compliance|Leadership');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_number` SET TAGS ('dbx_business_glossary_term' = 'Training Record Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_title` SET TAGS ('dbx_business_glossary_term' = 'Training Title');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'HAZWOPER|PSM Operator|GHS HazCom|Emergency Response|Confined Space|LOTO');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `community_notification_thresholds` SET TAGS ('dbx_business_glossary_term' = 'Community Notification Thresholds');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `covered_hazards` SET TAGS ('dbx_business_glossary_term' = 'Covered Hazards Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `drill_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Completion Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `drill_completion_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `drill_observations` SET TAGS ('dbx_business_glossary_term' = 'Drill Observations and Findings');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `drill_schedule` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Schedule');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Email Address');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `evacuation_routes_description` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Routes Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Emergency Drill Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Plan Review Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document URL');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Type (OSHA EAP, EPA RMP, SPCC, EPCRA LEPC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'OSHA_EAP|EPA_RMP|SPCC|EPCRA_LEPC');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|exempt');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `shelter_in_place_procedures` SET TAGS ('dbx_business_glossary_term' = 'Shelter‑In‑Place Procedures');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Record ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `sample_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]+$');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain‑of‑Custody Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `lab_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Reference');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'air|water|soil|groundwater|stormwater');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `parameter` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Parameter');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'pass|fail|questionable');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `regulatory_limit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Requirement');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_value_regex' = 'NPDES|TitleV|ISO14001|REACH|TSCA');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `sample_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `sample_method` SET TAGS ('dbx_value_regex' = 'grab|composite|automated');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'mg/L|µg/m3|ppm|pH|percent');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `tri_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'TRI Inventory ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `ehs_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Form R Submission ID (FRSID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `annual_throughput_quantity` SET TAGS ('dbx_business_glossary_term' = 'Annual Throughput Quantity (ATQ)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `annual_throughput_unit` SET TAGS ('dbx_business_glossary_term' = 'Annual Throughput Unit (ATU)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `annual_throughput_unit` SET TAGS ('dbx_value_regex' = 'lb|kg|ton');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `chemical_state` SET TAGS ('dbx_business_glossary_term' = 'Chemical Physical State (CPS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `chemical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|plasma');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (DSS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP|Intelex|Custom');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor (EF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name (FN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `form_r_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Form R Submission Date (FRSD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (HC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LRT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `max_on_site_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum On-Site Amount (MOA)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `max_on_site_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum On-Site Unit (MOU)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `max_on_site_unit` SET TAGS ('dbx_value_regex' = 'lb|kg|ton');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'PPE Required (PPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `release_air_quantity` SET TAGS ('dbx_business_glossary_term' = 'Air Release Quantity (ARQ)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `release_land_quantity` SET TAGS ('dbx_business_glossary_term' = 'Land Release Quantity (LRQ)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `release_offsite_transfer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Off-site Transfer Quantity (OTQ)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `release_water_quantity` SET TAGS ('dbx_business_glossary_term' = 'Water Release Quantity (WRQ)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `reporting_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Exceeded (RTE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year (RY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `source_reduction_activities` SET TAGS ('dbx_business_glossary_term' = 'Source Reduction Activities (SRA)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `waste_management_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Hierarchy (WMH)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ALTER COLUMN `waste_management_hierarchy` SET TAGS ('dbx_value_regex' = 'source_reduction|recycling|energy_recovery|treatment|disposal');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `management_objective_id` SET TAGS ('dbx_business_glossary_term' = 'Management Objective Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `achievement_status` SET TAGS ('dbx_business_glossary_term' = 'Achievement Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `achievement_status` SET TAGS ('dbx_value_regex' = 'on_track|behind|completed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `additional_control_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Additional Control Recommendation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `affected_activity` SET TAGS ('dbx_business_glossary_term' = 'Affected Work Activity');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `aspect_activity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Activity');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `aspect_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `attached_document_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Count');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `existing_control` SET TAGS ('dbx_business_glossary_term' = 'Existing Control');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'OHS Hazard Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'chemical|physical|biological|ergonomic|psychosocial');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `legal_requirement` SET TAGS ('dbx_business_glossary_term' = 'Applicable Legal Requirement');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `management_objective_status` SET TAGS ('dbx_business_glossary_term' = 'Management Objective Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `management_objective_status` SET TAGS ('dbx_value_regex' = 'draft|active|closed|archived');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `objective_code` SET TAGS ('dbx_business_glossary_term' = 'Management Objective Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `objective_description` SET TAGS ('dbx_business_glossary_term' = 'Management Objective Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `objective_title` SET TAGS ('dbx_business_glossary_term' = 'Management Objective Title');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `objective_type` SET TAGS ('dbx_business_glossary_term' = 'Management Objective Type');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `objective_type` SET TAGS ('dbx_value_regex' = 'environmental|safety|integrated');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `progress_milestone` SET TAGS ('dbx_business_glossary_term' = 'Progress Milestone');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `residual_significance` SET TAGS ('dbx_business_glossary_term' = 'Residual Significance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `residual_significance` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `responsible_function` SET TAGS ('dbx_business_glossary_term' = 'Responsible Function');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `risk_review_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `significance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Significance Determination Criteria');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `significance_rating` SET TAGS ('dbx_business_glossary_term' = 'Significance Rating');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `significance_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_objective` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `environmental_aspect_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `management_objective_id` SET TAGS ('dbx_business_glossary_term' = 'Management Objective Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `aspect_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `aspect_category` SET TAGS ('dbx_value_regex' = 'air|water|soil|waste|energy|other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `aspect_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `aspect_name` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Name');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `aspect_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Sub‑Category');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Existing Control Measures');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `environmental_aspect_description` SET TAGS ('dbx_business_glossary_term' = 'Aspect Description');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `environmental_aspect_status` SET TAGS ('dbx_business_glossary_term' = 'Aspect Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `environmental_aspect_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `last_assessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Assessed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `legal_requirement` SET TAGS ('dbx_business_glossary_term' = 'Legal Requirement');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'kg|t|m3|kgCO2e|ppm|percent');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|ad_hoc');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `residual_significance` SET TAGS ('dbx_business_glossary_term' = 'Residual Significance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `residual_significance` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `significance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Significance Determination Criteria');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `significance_rating` SET TAGS ('dbx_business_glossary_term' = 'Significance Rating');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `significance_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_aspect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` SET TAGS ('dbx_subdomain' = 'process_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `ohs_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (RA_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (DEPT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier (ASSESSOR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `work_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Work Activity Identifier (WORK_ACT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date (RA_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology (ASSESS_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|checklist');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number (RA_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status (RA_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|closed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count (ATTACH_COUNT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `control_recommendation_status` SET TAGS ('dbx_business_glossary_term' = 'Control Recommendation Status (CTRL_RECOMM_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `control_recommendation_status` SET TAGS ('dbx_value_regex' = 'pending|implemented|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `existing_controls` SET TAGS ('dbx_business_glossary_term' = 'Existing Controls Description (EXISTING_CTRL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description (HAZARD_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type (HAZARD_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'chemical|physical|biological|ergonomic|psychosocial');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood Rating (INH_LIKELIHOOD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score (INH_RISK_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `inherent_severity` SET TAGS ('dbx_business_glossary_term' = 'Inherent Severity Rating (INH_SEVERITY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `mitigation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Due Date (MITIGATION_DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `mitigation_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Effectiveness (MITIGATION_EFFECTIVENESS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `mitigation_effectiveness` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status (MITIGATION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `ohs_risk_assessment_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Description (RA_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment Required (PPE_REQUIRED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `recommended_controls` SET TAGS ('dbx_business_glossary_term' = 'Recommended Controls (RECOMMENDED_CTRL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number (REC_VERSION)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (REG_REF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating (RES_LIKELIHOOD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score (RES_RISK_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `residual_severity` SET TAGS ('dbx_business_glossary_term' = 'Residual Severity Rating (RES_SEVERITY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Date (RA_REVIEW_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Rating (RISK_RATING)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Title (RA_TITLE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required (TRAINING_REQUIRED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` SET TAGS ('dbx_subdomain' = 'waste_operations');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `spill_release_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Release Event ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `agencies_notified` SET TAGS ('dbx_business_glossary_term' = 'Agencies Notified');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `cleanup_completed` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Completed Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `cleanup_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `containment_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Containment Effectiveness');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `containment_effectiveness` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `emergency_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Actions');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `federal_report_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Report Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `incident_report_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `is_reportable_to_iso` SET TAGS ('dbx_business_glossary_term' = 'ISO Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `is_reportable_to_osha` SET TAGS ('dbx_business_glossary_term' = 'OSHA Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `is_reported_to_federal` SET TAGS ('dbx_business_glossary_term' = 'Federal Reported Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `is_reported_to_state` SET TAGS ('dbx_business_glossary_term' = 'State Reported Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `iso_report_number` SET TAGS ('dbx_business_glossary_term' = 'ISO Report Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `osha_report_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Report Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `quantity_released` SET TAGS ('dbx_business_glossary_term' = 'Quantity Released');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|g|L|gal');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `release_cause` SET TAGS ('dbx_business_glossary_term' = 'Release Cause');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `release_cause` SET TAGS ('dbx_value_regex' = 'equipment_failure|human_error|natural_event|unknown');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `release_media` SET TAGS ('dbx_business_glossary_term' = 'Release Media');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `release_media` SET TAGS ('dbx_value_regex' = 'air|soil|water|drain|other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `reportable_under_cercla` SET TAGS ('dbx_business_glossary_term' = 'CERCLA Reportable');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `reportable_under_epcra` SET TAGS ('dbx_business_glossary_term' = 'EPCRA Reportable');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `spill_release_event_status` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `spill_release_event_status` SET TAGS ('dbx_value_regex' = 'reported|investigated|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `state_spill_report_number` SET TAGS ('dbx_business_glossary_term' = 'State Spill Report Number');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_safety_record_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Safety Record Identifier (CONTRACTOR_SAFETY_RECORD_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `active_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Active Safety Violations Count (ACTIVE_VIOLATIONS_COUNT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `active_violations_details` SET TAGS ('dbx_business_glossary_term' = 'Active Violations Details (ACTIVE_VIOLATIONS_DETAILS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_address` SET TAGS ('dbx_business_glossary_term' = 'Contractor Address (ADDRESS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_city` SET TAGS ('dbx_business_glossary_term' = 'Contractor City (CITY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_code` SET TAGS ('dbx_business_glossary_term' = 'Contractor Code (CONTRACTOR_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_country` SET TAGS ('dbx_business_glossary_term' = 'Contractor Country (COUNTRY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full Name (CONTRACTOR_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_parent_company` SET TAGS ('dbx_business_glossary_term' = 'Contractor Parent Company (PARENT_COMPANY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_state` SET TAGS ('dbx_business_glossary_term' = 'Contractor State/Province (STATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_type` SET TAGS ('dbx_business_glossary_term' = 'Contractor Type (CONTRACTOR_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_type` SET TAGS ('dbx_value_regex' = 'general_contractor|subcontractor|service_provider|consultant');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_zip` SET TAGS ('dbx_business_glossary_term' = 'Contractor Postal Code (ZIP_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_zip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `contractor_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `emr_effective_date` SET TAGS ('dbx_business_glossary_term' = 'EMR Effective Date (EMR_EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `experience_modification_rate` SET TAGS ('dbx_business_glossary_term' = 'Experience Modification Rate (EMR)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number (INSURANCE_CERT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiration Date (INSURANCE_EXPIRY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `last_safety_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Audit Date (LAST_SAFETY_AUDIT_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `last_safety_audit_score` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Audit Score (LAST_SAFETY_AUDIT_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `near_miss_frequency` SET TAGS ('dbx_business_glossary_term' = 'Near-Miss Frequency per 1,000 Work Hours (NEAR_MISS_FREQUENCY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `orientation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completion Date (ORIENTATION_COMPLETION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `osha_300_log_review_status` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300 Log Review Status (OSHA_300_REVIEW_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `osha_300_log_review_status` SET TAGS ('dbx_value_regex' = 'completed|pending|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `prequalification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiration Date (PREQUAL_EXPIRY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `prequalification_review_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Review Date (PREQUAL_REVIEW_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address (PRIMARY_CONTACT_EMAIL)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name (PRIMARY_CONTACT_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number (PRIMARY_CONTACT_PHONE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `primary_contact_role` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Role (PRIMARY_CONTACT_ROLE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RECORD_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `recordable_incident_rate` SET TAGS ('dbx_business_glossary_term' = 'Recordable Incident Rate per 200,000 Work Hours (RECORDABLE_INCIDENT_RATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (REGULATORY_REF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date (REQUAL_DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `safety_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Status (SAFETY_AUDIT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `safety_audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `safety_prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Prequalification Status (PREQUAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `safety_prequalification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditionally_qualified|not_qualified|pending');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `site_specific_orientation_completed` SET TAGS ('dbx_business_glossary_term' = 'Site-Specific Safety Orientation Completed (ORIENTATION_COMPLETED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `workers_comp_cert_expiration` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Certificate Expiration Date (WC_CERT_EXPIRY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `workers_compensation_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Certificate Number (WC_CERT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `workers_compensation_certificate_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ALTER COLUMN `workers_compensation_certificate_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `parent_sampling_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`sampling_point` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` ALTER COLUMN `control_device_id` SET TAGS ('dbx_business_glossary_term' = 'Control Device Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` ALTER COLUMN `upstream_control_device_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` ALTER COLUMN `serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` ALTER COLUMN `work_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Work Activity Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` ALTER COLUMN `parent_work_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`work_activity` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
