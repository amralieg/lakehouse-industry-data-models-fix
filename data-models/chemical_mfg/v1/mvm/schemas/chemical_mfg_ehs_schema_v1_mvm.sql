-- Schema for Domain: ehs | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:09

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
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Safety incidents occur at specific facilities. safety_incident currently has no facility-level reference within the EHS domain (only functional_location_id from maintenance domain and department as a ',
    `functional_location_id` BIGINT COMMENT 'Identifier of the physical location (plant, site, area) where the incident occurred.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Safety incidents during hazmat receiving (chemical spills, exposure) must be linked to the specific goods receipt for OSHA recordable reporting, vendor accountability, and root cause analysis. Chemica',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: DOT/PHMSA requires safety incidents during hazmat transport and unloading to reference the inbound delivery document. Before GR posting, the inbound_delivery is the operative supply record for carrier',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Major safety incidents in chemical manufacturing trigger funded investigation and remediation projects. The safety_incident has property_damage_amount requiring a financial object for cost posting. OS',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Required for incident investigation to trace the specific lot that caused the safety incident, enabling recall and root‑cause analysis.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Safety incidents involving specific raw material lots (worker exposure during handling of a specific batch, fire involving a specific lot) require lot-level traceability for OSHA recordkeeping, recall',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Safety Incident Reporting requires linking each incident to the manufacturing order that caused it for root‑cause analysis and regulatory reporting.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Incident tracking uses the material master record to access detailed specifications, storage, and compliance data for the affected raw material.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Regulatory incident reports must reference the specific sales order that caused the safety incident for traceability and liability analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Root‑cause analysis ties each safety incident to the specific PO that delivered the offending material, supporting supplier audits and compliance reporting.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle. Business justification: Vehicle Accident Investigation requires associating safety incidents with the specific vehicle to analyze fleet safety and maintenance needs.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Regulatory incident reports require identifying the responsible supplier of the hazardous material, enabling supplier performance tracking and corrective actions.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: Safety incidents (spills, exposures, fires) occur at specific warehouse storage locations. OSHA incident reporting and root cause analysis require linking the incident to the physical hazmat storage l',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Incident investigations are conducted at specific facilities. While incident_investigation links to safety_incident (which will now have facility_id), a direct facility_id on incident_investigation su',
    `functional_location_id` BIGINT COMMENT 'Identifier of the physical location where the incident occurred.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Incident investigations for receiving-related chemical incidents require the specific goods receipt to establish material identity, vendor, batch, and receiving conditions for root cause analysis. Che',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Incident investigations with significant estimated_loss_amount require dedicated internal orders for cost tracking. Chemical manufacturers fund investigation teams, external consultants, and correctiv',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Incident investigations involving specific raw material batches (contaminated lot causing worker exposure, off-spec material causing process upset) must reference the lot_record for chain-of-custody, ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Incident investigations involving raw material handling (spills, worker exposures, fires) must reference the material master to document the chemical involved, its hazard class, and storage conditions',
    `production_deviation_id` BIGINT COMMENT 'Foreign key linking to production.production_deviation. Business justification: Investigations of safety incidents are often triggered by a specific production deviation; linking provides traceability for CAPA.',
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
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Coordinated corrective actions: EHS CAPA records often reference the same quality CAPA record to ensure aligned safety and quality remediation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charges CAPA corrective action costs to the appropriate cost center for cost control and compliance budgeting.',
    `functional_location_id` BIGINT COMMENT 'Reference to the plant, facility, or site where the CAPA originates.',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: HAZOP studies produce recommended_actions and action_status fields that directly generate CAPA records. In PSM/process safety management, corrective actions arising from HAZOP findings must be tracked',
    `incident_investigation_id` BIGINT COMMENT 'Foreign key linking to ehs.incident_investigation. Business justification: CAPAs are frequently triggered by specific investigation findings and recommendations documented in incident_investigation records. The incident_investigation.corrective_action_recommendations field i',
    `inspection_audit_id` BIGINT COMMENT 'Foreign key linking to ehs.inspection_audit. Business justification: Inspection and audit findings are a primary source of corrective actions in EHS management. inspection_audit has a corrective_actions_required field indicating CAPAs are expected to be generated from ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: CAPA actions in chemical manufacturing often require capital or expense funding tracked via internal orders (e.g., engineering controls, equipment upgrades). The capa_record has cost_estimate and cost',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: CAPAs triggered by raw material-related incidents (contamination events, storage violations, GHS labeling failures) must reference the material master to scope corrective actions, track recurrence by ',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: CAPAs triggered by out-of-specification raw material results reference the material specification to define corrective action acceptance criteria and re-qualification requirements. Quality systems req',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: CAPA records in EHS arise directly from safety incidents. The capa_record description explicitly states tracking remediation actions arising from safety incidents. Adding safety_incident_id as a FK ',
    `vendor_audit_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_audit. Business justification: Vendor audit findings (hazmat handling deficiencies, EHS non-compliance) trigger formal EHS CAPAs in chemical manufacturing. vendor_audit has capa_required_flag and capa_due_date, confirming this proc',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_qualification. Business justification: Vendor qualification failures on EHS scores trigger formal CAPAs in chemical manufacturing. vendor_qualification has ehs_score, findings_critical_count, and capa_required_flag. Linking capa_record to ',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: HAZOP studies are conducted for specific facility process units. hazop_study has plant_location (STRING) as a denormalized text reference to the facility location. Adding facility_id FK normalizes thi',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: HAZOP SCOPE: HAZOP studies are scoped to a functional location; linking enables location‑based risk management.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Funds Hazop studies through an internal order, linking safety analysis to the capital project financial tracking.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: HAZOP studies on process units handling raw materials require the material master for storage temperature limits, incompatibility flags, and regulatory compliance status to assess process deviations. ',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: HAZOP studies reference material specifications to define safe operating envelopes — assay limits, pH ranges, and viscosity bounds define the design intent that HAZOP deviations are measured against',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: HAZOP studies are conducted using Process Safety Information (PSI) as the foundational input. Under OSHA PSM (29 CFR 1910.119), PHAs/HAZOPs must be based on current PSI. process_safety_info is the PSI',
    `tank_id` BIGINT COMMENT 'Foreign key linking to inventory.tank. Business justification: PSM/RMP regulations (29 CFR 1910.119, 40 CFR Part 68) require HAZOP studies for processes involving tanks storing highly hazardous chemicals above threshold quantities. Direct link enables compliance ',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` (
    `emission_event_id` BIGINT COMMENT 'System-generated unique identifier for each emission event record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Emission reporting links each pollutant to its CAS registry entry for regulatory reporting and inventory reconciliation.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Emission tracking ties each pollutant to its chemical product for EPA TRI and permit compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns emission monitoring and mitigation costs to the cost center responsible for the emission source.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to ehs.emission_source. Business justification: Each emission event originates from a specific emission source. Adding emission_source_id to emission_event provides a clear parent relationship.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: EMISSIONS TRACKING: Emission events are typically generated by a specific piece of equipment; linking enables source‑based reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Emission events occur at specific facilities. emission_event has facility_code (BIGINT) as a denormalized reference. Adding facility_id FK to the facility master record normalizes this relationship an',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: Fugitive emission events during hazmat unloading (below injury threshold but EPA/state reportable) must reference the inbound delivery for source identification and regulatory reporting. This is disti',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Significant emission events in chemical manufacturing trigger funded cleanup and remediation projects tracked as internal orders. Environmental incident response costs (containment, cleanup, regulator',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Transport Emission Tracking associates emission events with the corresponding shipment to calculate greenhouse‑gas inventory for regulatory compliance.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Emission events from specific raw material lots (e.g., spill during unloading of a specific batch) require lot-level traceability for insurance claims, regulatory reporting, and supplier liability det',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Regulatory emission reports are generated per production order; linking emissions to the order enables accurate tracking and compliance.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Emission events involving raw material spills or fugitive releases during unloading must reference the material master for TRI/CERCLA regulatory reporting, emergency response planning, and root cause ',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Emission events occur under specific operating permits and must be evaluated against permit limits. emission_event has a regulatory_permit_number (STRING) that is a denormalized reference to the opera',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Emission reporting per production batch is allocated to the originating sales order to satisfy environmental permits and internal cost accounting.',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: Chemical releases and emission events in manufacturing are frequently co-reported as both environmental emission events and safety incidents (e.g., a chemical spill triggers both an emission_event rec',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Regulatory emission reports must be tied to the specific customer site where the release occurred (EPA reporting).',
    `tank_farm_level_id` BIGINT COMMENT 'Foreign key linking to inventory.tank_farm_level. Business justification: EPA RMP and TRI reporting require correlating emission events (tank venting, fugitive releases) with tank inventory levels at the time of the event. Linking emission_event to tank_farm_level enables m',
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
    `geographic_region` STRING COMMENT 'State or region code where the emission source is located.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the emission source.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the emission source.',
    `measurement_method` STRING COMMENT 'Method used to determine the emission quantity.. Valid values are `cems|stack_test|estimate|model`',
    `monitoring_frequency` STRING COMMENT 'How often the emission source is monitored.. Valid values are `continuous|daily|weekly|monthly|annual`',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
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
    `facility_id` BIGINT COMMENT 'FK to ehs.facility',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Emission sources (storage tanks, process vents, loading stations) are associated with specific raw materials being stored or processed. Linking to material_master enables permit limit tracking by mate',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: An emission source is governed by a single operating permit; many sources can share a permit. Adding operating_permit_id to emission_source creates the required inbound link.',
    `process_unit_id` BIGINT COMMENT 'Identifier of the production unit or line associated with the emission source.',
    `tank_id` BIGINT COMMENT 'Foreign key linking to inventory.tank. Business justification: Tanks are primary emission sources in chemical manufacturing (fugitive emissions, loading, venting). EPA Title V and air permit compliance requires linking each emission source record to the specific ',
    `capacity_unit` STRING COMMENT 'Unit of measure for the source capacity.. Valid values are `m3_per_hr|kg_per_hr`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission source record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the confidence level in the reported measurement data.. Valid values are `verified|estimated|pending`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor used to calculate emissions from process activity (e.g., kg pollutant per ton product).',
    `emission_factor_unit` STRING COMMENT 'Unit of the emission factor.. Valid values are `kg_per_ton|lb_per_ton`',
    `emission_limit_unit` STRING COMMENT 'Unit of measure for the emission limit (e.g., kilograms per hour).. Valid values are `kg_per_hr|t_per_day|lb_per_hr`',
    `emission_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable emission quantity for the source per reporting period.',
    `emission_medium` STRING COMMENT 'Environmental medium to which emissions are released.. Valid values are `air|water|soil`',
    `emission_source_description` STRING COMMENT 'Detailed free‑text description of the emission source, its function, and any special characteristics.',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Waste disposal records are generated at specific facilities. waste_disposal_record has facility_code (BIGINT) as a denormalized reference. Adding facility_id FK normalizes this to the facility master ',
    `hazmat_declaration_id` BIGINT COMMENT 'Foreign key linking to logistics.hazmat_declaration. Business justification: RCRA hazardous waste transport requires a DOT hazmat declaration alongside the waste manifest. Chemical manufacturing EHS teams reconcile waste disposal records against filed hazmat declarations for E',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Hazardous waste disposal programs in chemical manufacturing are funded via internal orders for cost tracking and regulatory cost reporting. RCRA compliance requires tracking disposal costs against spe',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Required: Invoices are generated for waste disposal services per regulatory compliance; linking each waste record to its invoice enables accurate billing and audit trails.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Linking waste disposal records to the shipment enables traceability of hazardous waste movements for EPA tracking and internal audit.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Links waste disposal entries to the originating lot for accurate hazardous waste reporting and traceability under EPA/REACH regulations.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: When a specific raw material lot is rejected at incoming inspection or expires, the waste disposal record must reference the originating lot_record for chain-of-custody documentation, RCRA manifest tr',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Waste disposal must be allocated to the specific manufacturing order that generated the waste for cost accounting and environmental compliance.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Waste disposal records for rejected or expired raw materials must reference the originating material master for RCRA compliance, EPA waste code assignment, and cost allocation to the correct material.',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Waste disposal operations in chemical manufacturing are governed by RCRA operating permits. waste_disposal_record tracks RCRA hazardous waste disposal and must reference the applicable operating permi',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Waste generated during order fulfillment must be linked to the order for waste‑cost tracking and regulatory disposal reporting.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Waste disposal services are procured at the PO line level in chemical manufacturing. Linking waste_disposal_record to the specific PO line enables precise three-way match (PO line / disposal record / ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Waste disposal services in chemical manufacturing are procured via purchase orders. Linking waste_disposal_record to the governing PO enables AP invoice matching, cost allocation, and RCRA audit trail',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Waste disposal records must be associated with the generating site for RCRA reporting and cost allocation.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: When inventory is disposed as hazardous waste (off-spec, expired, contaminated material), the waste disposal record must reference the originating stock position for inventory reconciliation and RCRA ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: RCRA compliance requires waste disposal to be performed under approved contracts with licensed disposal vendors. Linking waste_disposal_record to the supply contract enables auditors to verify disposa',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Waste disposal contracts are managed with external waste‑hauler vendors; linking waste records to vendor enables cost tracking and regulatory compliance.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: Specific waste‑processing sites are vendor locations; associating each disposal record with the vendor site supports logistics and audit trails.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: RCRA compliance and hazardous waste manifests require identifying the specific storage location where waste was held prior to disposal. The plain-text waste_storage_location column is a denormalizatio',
    `waste_stream_id` BIGINT COMMENT 'Reference to the master waste‑stream definition describing the type of waste.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the waste disposal transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste disposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the disposal cost (e.g., USD, EUR).',
    `disposal_facility_name` STRING COMMENT 'Name of the licensed external facility where waste was sent.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the waste.. Valid values are `landfill|incineration|recycling|treatment|recovery`',
    `disposal_number` STRING COMMENT 'Business identifier assigned to the waste disposal transaction, used for tracking and reporting.',
    `disposal_timestamp` TIMESTAMP COMMENT 'Date and time when the waste was actually disposed of or shipped for disposal.',
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste code (e.g., D001, F003) associated with the waste.',
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
    CONSTRAINT pk_waste_disposal_record PRIMARY KEY(`waste_disposal_record_id`)
) COMMENT 'Comprehensive waste management record for Chemical Mfg operations covering waste stream master definitions, waste characterization, and individual disposal transactions. Waste stream master data: stream name, physical/chemical description, generating process unit, EPA waste codes, RCRA hazardous waste determination, typical generation rate, approved disposal methods, storage requirements, regulatory notification status. Disposal transaction data: waste characterization, quantity generated, disposal method (landfill, incineration, recycling, treatment), licensed disposal facility, manifest number, shipment date, chain-of-custody documentation, and LDR (Land Disposal Restrictions) compliance. Supports EPA RCRA hazardous waste reporting, biennial reporting, state environmental agency submissions, and ISO 14001 waste management tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` (
    `waste_stream_id` BIGINT COMMENT 'Unique identifier for the waste stream.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: EPA waste code assignment and RCRA hazardous waste characterization require CAS-level substance identification. Linking waste_stream to cas_registry enables automated hazardous waste classification an',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Waste stream classification depends on the originating chemical product for RCRA and internal cost tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Waste streams in chemical manufacturing are owned by specific cost centers responsible for ongoing disposal costs and RCRA compliance. Cost center assignment enables waste management cost allocation, ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Waste streams are generated by specific facility production processes. waste_stream is the master record defining recurring waste streams and must be associated with the facility where they are genera',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Waste streams in chemical manufacturing originate from specific raw materials (off-spec batches, expired inventory, process residues). RCRA hazardous waste classification and EPA waste code assignment',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Unique system-generated identifier for the regulatory submission record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: TRI/SARA 313 submissions are organized by CAS number per EPA reporting requirements. Linking ehs_regulatory_submission to cas_registry enables substance-level threshold lookups, regulatory framework d',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Regulatory submissions (e.g., EPA, TSCA) require specifying the exact chemical product for compliance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates regulatory filing fees to the cost center responsible for the submission, enabling expense tracking.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the manufacturing or storage facility associated with the submission.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: TRI Form R, RMP, and Tier II submissions are filed by legal entities with regulatory agencies. The submitting legal entity is a required field on all federal environmental reports. Chemical manufactur',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: TRI (SARA 313), CERCLA 312, and RMP submissions require reporting annual throughput and maximum on-site quantities by specific chemical/material. Linking to material_master enables automated populatio',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Regulatory submissions (TRI, air emissions reports, RCRA reports) are made under specific operating permits. ehs_regulatory_submission has permit_number (STRING) as a denormalized reference. Adding op',
    `reach_registration_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.reach_registration. Business justification: REACH-related regulatory submissions (SVHC notifications, authorization applications, downstream use notifications) must reference the REACH registration record. This is a direct regulatory workflow d',
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
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Record of formal regulatory submissions, TRI chemical inventory/release calculations, and supporting documentation for Chemical Mfg environmental and safety agency filings. Submission tracking: submission type (TRI Form R, RMP, Title V permit renewal, TSCA CDR, REACH registration, OSHA PSM audit response), submission date, reporting period, agency recipient, status, acknowledgment receipt, permit/registration number. TRI inventory and reporting: TRI-listed chemical (CAS number), facility, reporting year, maximum amount on-site, annual throughput quantity, release quantities by media (air, water, land, off-site transfer), waste management hierarchy data, source reduction activities, Form R submission linkage. Provides the compliance submission audit trail for SOX, ISO 14001/45001 management reviews, EPCRA Section 313 annual reporting, and all agency filing requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` (
    `operating_permit_id` BIGINT COMMENT 'Primary key for operating_permit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links permit fees to the cost center bearing the permit cost for accurate financial allocation.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Operating permits are issued for specific facilities. operating_permit has facility_code (BIGINT) as a denormalized reference. Adding facility_id FK normalizes this to the facility master record, enab',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Air permits, water discharge permits, and Title V permits in chemical manufacturing are issued for specific fixed assets (boilers, storage tanks, process units). Asset retirement and disposal decision',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Inspections and audits are conducted at specific facilities. inspection_audit has no facility reference currently (only functional_location_id which is a maintenance domain reference). Adding facility',
    `functional_location_id` BIGINT COMMENT 'Unique identifier of the plant, site, or location where the inspection took place.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Regulatory inspection findings trigger funded remediation projects in chemical manufacturing. EPA and OSHA audit-driven corrective actions require internal orders to track capital and expense spend. C',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: EHS inspections and audits are frequently conducted to verify compliance with specific operating permits. inspection_audit has regulatory_standard_referenced (STRING) that often corresponds to permit ',
    `tank_id` BIGINT COMMENT 'Foreign key linking to inventory.tank. Business justification: Tanks in chemical manufacturing are subject to PSM mechanical integrity inspections, API 653 assessments, and environmental compliance audits. Linking inspection_audit to the specific tank asset enabl',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: OSHA and EPA hazmat storage inspections are conducted at specific warehouse locations. Linking inspection_audit to warehouse_location enables inspection history tracking per storage area, drives corre',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` (
    `process_safety_info_id` BIGINT COMMENT 'Unique identifier for the Process Safety Information record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: PSI documents are substance-specific and identified by CAS number per OSHA PSM standard (29 CFR 1910.119). Linking to cas_registry enables substance-level PSI lookups and eliminates denormalized physi',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: PSI documents are product‑specific, linking ensures consistent safety data across processes.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: PSM-covered chemicals under OSHA 1910.119 are stored in specific fixed assets (pressure vessels, reactors, storage tanks). Linking PSI to fixed assets enables asset-level PSM compliance tracking, supp',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: PSM/RMP compliance requires PSI documentation to reference the specific raw material master for storage conditions, incompatibility flags, and regulatory status. Chemical engineers building PSI packag',
    `compatible_materials` STRING COMMENT 'Materials that are safe to store or transport the chemical with.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PSI record was initially created.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Mass per unit volume of the chemical at standard temperature and pressure.',
    `document_reference` STRING COMMENT 'Identifier for the linked safety data sheet or regulatory document.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of an incident involving the chemical.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `emergency_procedure` STRING COMMENT 'Brief description of the emergency response steps for this chemical.',
    `environmental_hazards` STRING COMMENT 'Key environmental risk categories for the chemical.. Valid values are `aquatic_toxicity|ozone_depletion|global_warming|soil_contamination|air_pollution`',
    `hazard_classification` STRING COMMENT 'Primary GHS hazard class for the chemical.. Valid values are `flammable|corrosive|toxic|reactive|explosive|oxidizer`',
    `health_hazards` STRING COMMENT 'Primary health hazard categories associated with the chemical.. Valid values are `skin_irritation|respiratory|carcinogenic|reproductive|sensitization|mutagenic`',
    `incompatible_materials` STRING COMMENT 'Materials that must not contact the chemical due to reactive hazards.',
    `inventory_uom` STRING COMMENT 'Unit of measure for the maximum inventory amount.. Valid values are `kg|lb|ton`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date and time when the PSI record was last reviewed for accuracy.',
    `max_inventory_amount` DECIMAL(18,2) COMMENT 'Maximum quantity of the chemical intended to be stored on site.',
    `next_review_timestamp` TIMESTAMP COMMENT 'Planned date and time for the next periodic review.',
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
    CONSTRAINT pk_process_safety_info PRIMARY KEY(`process_safety_info_id`)
) COMMENT 'Process Safety Information (PSI) master record for highly hazardous chemicals and covered processes at Chemical Mfg facilities under OSHA PSM. Captures chemical identity (CAS number), maximum intended inventory, physical/chemical properties, reactivity hazards, corrosivity data, thermal stability data, P&ID reference, equipment design specifications, and safe operating limits. Required documentation under OSHA 29 CFR 1910.119(d) and EPA RMP 40 CFR Part 68.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` (
    `safety_data_sheet_id` BIGINT COMMENT 'Primary key for safety_data_sheet',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: SDSs are substance-specific documents identified by CAS number. Linking ehs.safety_data_sheet to cas_registry enables substance-level SDS management, supports REACH/TSCA compliance reporting, and allo',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: EHS SDS records must reference the master chemical product for unified hazard communication.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: EHS-managed SDSs for raw materials must be linked to the material master for incident response, incoming inspection, and GHS labeling compliance. EHS teams need this link to retrieve the correct SDS d',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: Safety Data Sheet records describe the same chemical identified in Process Safety Info. Linking SDS to PSI via process_safety_info_id removes duplicate chemical identifiers.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: SDSs in chemical manufacturing are authored and provided by the raw material vendor/supplier. Linking SDS to the vendor enables procurement to verify current SDS versions during vendor qualification, ',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` (
    `emergency_response_plan_id` BIGINT COMMENT 'System‑generated unique identifier for the emergency response plan record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: ERPs are drafted for specific chemicals; linking supports drill planning and regulatory compliance.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Emergency response plans are developed for specific facilities. emergency_response_plan has facility_code (BIGINT) as a denormalized reference. Adding facility_id FK normalizes this to the EHS facilit',
    `functional_location_id` BIGINT COMMENT 'Geographic location identifier (e.g., site, campus) for the plan.',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: Emergency response plans are developed based on hazard analyses identified in HAZOP studies. The covered_hazards field on emergency_response_plan directly corresponds to hazards identified in HAZOP st',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Emergency response plan development, annual drills, and equipment maintenance are funded via internal orders in chemical manufacturing. OSHA PSM and EPA RMP require documented drill programs with asso',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Emergency response plans are tied to the operating permit that authorizes the facilitys emissions. Adding operating_permit_id to emergency_response_plan links the plan to its governing permit.',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: Emergency response plans for chemical facilities must reference the Process Safety Information for the covered hazardous chemicals. The covered_hazards field on emergency_response_plan corresponds to ',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key for facility',
    `business_unit_id` BIGINT COMMENT 'Foreign key linking to finance.business_unit. Business justification: Facilities are organized under business units for EHS budget allocation, environmental liability reporting, and P&L assignment. Chemical manufacturers track EHS compliance costs and capital expenditur',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each facility has a primary cost center for EHS overhead allocation, compliance program budgeting, and environmental monitoring costs. Chemical plant controllers require facility-to-cost-center mappin',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Chemical manufacturing facilities are owned by specific legal entities. TRI, RMP, and air permit filings are submitted under a legal entity. Regulatory agencies require legal entity identification on ',
    `parent_facility_id` BIGINT COMMENT 'Self-referencing FK on facility (parent_facility_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Chemical manufacturing facilities map directly to profit centers for segment-level environmental cost and liability reporting. Facility-level EHS spend, fines, and remediation costs must be allocated ',
    `address_line1` STRING COMMENT 'First line of the facilitys street address.',
    `address_line2` STRING COMMENT 'Second line of the facilitys street address, if applicable.',
    `capacity_tons_per_year` DECIMAL(18,2) COMMENT 'Maximum annual production capacity in metric tons.',
    `city` STRING COMMENT 'City of the facilitys location.',
    `closing_date` DATE COMMENT 'Date the facility was permanently closed, if applicable.',
    `compliance_reporting_status` STRING COMMENT 'Current status of the facilitys regulatory compliance reporting.',
    `country` STRING COMMENT 'Three‑letter country code where the facility resides.',
    `ehs_certification_status` STRING COMMENT 'Current status of the facilitys EHS certifications.',
    `ehs_certification_type` STRING COMMENT 'Type of EHS certification held by the facility.',
    `emergency_shutoff_available` BOOLEAN COMMENT 'Indicates whether an emergency shutoff system is installed and functional.',
    `emissions_co2_tons_year` DECIMAL(18,2) COMMENT 'Total CO2 emissions reported for the facility in a calendar year (metric tons).',
    `emissions_hap_tons_year` DECIMAL(18,2) COMMENT 'Total hazardous air pollutants emitted by the facility in a calendar year (metric tons).',
    `energy_consumption_mwh_year` DECIMAL(18,2) COMMENT 'Total energy consumed by the facility in a calendar year (megawatt‑hours).',
    `facility_code` STRING COMMENT 'Unique operational code assigned to the facility.',
    `facility_description` STRING COMMENT 'Additional descriptive information about the facility.',
    `facility_name` STRING COMMENT 'The official name of the facility.',
    `facility_status` STRING COMMENT 'Current lifecycle status of the facility.',
    `facility_type` STRING COMMENT 'Category of the facility (e.g., manufacturing plant, distribution center).',
    `fire_suppression_system` BOOLEAN COMMENT 'Indicates presence of an active fire suppression system.',
    `hazardous_materials_handled` STRING COMMENT 'List or description of hazardous materials the facility handles.',
    `last_inspection_date` DATE COMMENT 'Date when the most recent EHS inspection was performed.',
    `last_reported_tri_date` DATE COMMENT 'Date of the most recent Toxic Release Inventory (TRI) submission for the facility.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the facility location.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the facility location.',
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
    `waste_disposal_method` STRING COMMENT 'Primary method used for waste disposal at the facility.',
    `water_usage_cubic_meters_year` DECIMAL(18,2) COMMENT 'Total water consumed by the facility in a calendar year (cubic meters).',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master reference table for facility. Referenced by facility_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` (
    `emission_reporting_line_item_id` BIGINT COMMENT 'Unique system-generated identifier for each emission reporting line item record',
    `emission_event_id` BIGINT COMMENT 'Foreign key linking to the emission event being reported in this submission',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to the regulatory submission that includes this emission event',
    `calculation_method` STRING COMMENT 'Method used to calculate the reported quantity for this line item (e.g., direct measurement, emission factor, mass balance, engineering estimate)',
    `comments` STRING COMMENT 'Free-text field for additional notes or explanations about this specific line item inclusion',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission reporting line item record was first created in the system',
    `data_quality_code` STRING COMMENT 'Quality indicator for the reported data on this line item (e.g., measured, calculated, estimated, default)',
    `form_section_reference` STRING COMMENT 'Specific section or line number on the regulatory form where this emission is reported (e.g., TRI Form R Section 5.1, Part II Line 3)',
    `regulatory_basis` STRING COMMENT 'The specific regulatory requirement or citation that mandates reporting this emission in this submission (e.g., EPCRA Section 313, 40 CFR Part 98 Subpart C, Title V permit condition)',
    `reported_quantity` DECIMAL(18,2) COMMENT 'The specific quantity of the emission reported in this submission, which may differ from the actual emission quantity due to regulatory calculation methods, rounding rules, or reporting period allocation',
    `reporting_period_allocation` STRING COMMENT 'Method used to allocate the emission event to the reporting period (e.g., full allocation, prorated, annualized) when the event spans multiple reporting periods or requires adjustment',
    `submission_line_item_status` STRING COMMENT 'Lifecycle status of this specific line item within the submission (draft, submitted, amended, corrected, withdrawn)',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this emission reporting line item record',
    CONSTRAINT pk_emission_reporting_line_item PRIMARY KEY(`emission_reporting_line_item_id`)
) COMMENT 'This association product represents the documented inclusion of a specific emission event in a specific regulatory submission. It captures the regulatory reporting relationship between emission events and formal agency filings. Each record links one regulatory submission to one emission event with attributes that exist only in the context of regulatory reporting (reported quantity, period allocation, regulatory basis, and line item status).. Existence Justification: In chemical manufacturing EHS compliance, regulatory submissions (TRI Form R, Title V, EPCRA reports) aggregate emission events across multiple reporting frameworks and time periods. A single emission event can legitimately appear in multiple submissions (e.g., the same VOC release reported in both TRI annual reporting and Title V semi-annual monitoring reports), and each submission covers many emission events. The business actively manages these reporting line items with submission-specific attributes like reported quantity (which may differ from actual due to regulatory calculation rules), regulatory basis, and form section references.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_incident_investigation_id` FOREIGN KEY (`incident_investigation_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`incident_investigation`(`incident_investigation_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_inspection_audit_id` FOREIGN KEY (`inspection_audit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`inspection_audit`(`inspection_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_source`(`emission_source_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ADD CONSTRAINT `fk_ehs_waste_stream_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ADD CONSTRAINT `fk_ehs_operating_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ADD CONSTRAINT `fk_ehs_safety_data_sheet_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ADD CONSTRAINT `fk_ehs_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ADD CONSTRAINT `fk_ehs_emission_reporting_line_item_emission_event_id` FOREIGN KEY (`emission_event_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_event`(`emission_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ADD CONSTRAINT `fk_ehs_emission_reporting_line_item_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`ehs` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `chemical_mfg_ecm`.`ehs` SET TAGS ('dbx_domain' = 'ehs');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` SET TAGS ('dbx_subdomain' = 'workplace_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Location ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` SET TAGS ('dbx_subdomain' = 'workplace_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ALTER COLUMN `production_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Deviation Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` SET TAGS ('dbx_subdomain' = 'workplace_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Capa Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `vendor_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` SET TAGS ('dbx_subdomain' = 'workplace_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard and Operability (HAZOP) Study Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ALTER COLUMN `tank_farm_level_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Farm Level Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `facility_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (PUID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `waste_disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Record ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `hazmat_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Declaration Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID (RSID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `reach_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Registration Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Receipt Date (ARD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `acknowledgment_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Flag (ARF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `agency_recipient` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Recipient (RAR)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `agency_recipient` SET TAGS ('dbx_value_regex' = 'EPA|OSHA|ECHA|TSCA|State_Env|Local_Env');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `annual_throughput_quantity` SET TAGS ('dbx_business_glossary_term' = 'Annual Throughput Quantity (ATQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments (AC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Indicator Flag (CIF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference (SDR)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag (CF)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `max_on_site_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum On‑Site Amount (MOA) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `release_quantity_air` SET TAGS ('dbx_business_glossary_term' = 'Air Release Quantity (ARQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `release_quantity_land` SET TAGS ('dbx_business_glossary_term' = 'Land Release Quantity (LRQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `release_quantity_offsite_transfer` SET TAGS ('dbx_business_glossary_term' = 'Off‑site Transfer Release Quantity (OTRQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `release_quantity_water` SET TAGS ('dbx_business_glossary_term' = 'Water Release Quantity (WRQ) (kg)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date (RPED)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date (RPSD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year (RY)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `source_reduction_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Source Reduction Activity Description (SRAD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date (RSD)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Number (RSN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_value_regex' = '^SUB-d{8}$');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status (RSS)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|rejected|approved|closed');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type (RST)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'TRI_Form_R|RMP|Title_V|TSCA_CDR|REACH|OSHA_PSM');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submission_version` SET TAGS ('dbx_business_glossary_term' = 'Submission Version Number (SVN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `submitted_by_name` SET TAGS ('dbx_business_glossary_term' = 'Submitting Employee Name (SEN)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `waste_management_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Hierarchy Category (WMHC)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ALTER COLUMN `waste_management_hierarchy` SET TAGS ('dbx_value_regex' = 'recycle|treatment|disposal|landfill|incineration|other');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FACILITY_ID)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` SET TAGS ('dbx_subdomain' = 'workplace_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Information ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|reactive|explosive|oxidizer');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_business_glossary_term' = 'Health Hazards');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_value_regex' = 'skin_irritation|respiratory|carcinogenic|reproductive|sensitization|mutagenic');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `health_hazards` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `incompatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Materials');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `inventory_uom` SET TAGS ('dbx_business_glossary_term' = 'Inventory Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `inventory_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `max_inventory_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Intended Inventory Amount');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ALTER COLUMN `next_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Review Timestamp');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` SET TAGS ('dbx_subdomain' = 'workplace_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` SET TAGS ('dbx_subdomain' = 'workplace_safety');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` SET TAGS ('dbx_association_edges' = 'ehs.ehs_regulatory_submission,ehs.emission_event');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `emission_reporting_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Reporting Line Item ID');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Reporting Line Item - Emission Event Id');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Reporting Line Item - Ehs Regulatory Submission Id');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Code');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `form_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Form Section Reference');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `reported_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reported Quantity');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `reporting_period_allocation` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Allocation');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `submission_line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Line Item Status');
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_reporting_line_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
