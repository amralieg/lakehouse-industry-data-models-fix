-- Schema for Domain: foodsafety | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`foodsafety` COMMENT 'Governs HACCP plan management, food safety audit results, health inspection records, corrective action tracking, temperature monitoring logs, sanitation schedules, allergen management, and SOP compliance via Zenput. Ensures adherence to FDA FSMA, local health department requirements, ISO 22000, and ServSafe standards across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` (
    `haccp_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the HACCP plan record.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the employee responsible for the HACCP plan.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the HACCP plan.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: HACCP plans are developed for specific food production facilities and cover physical process flows within that building. Regulatory frameworks (FDA, USDA) require facility-specific HACCP documentation',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether allergen control procedures are defined in the plan.',
    `approval_date` DATE COMMENT 'Date the HACCP plan received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the HACCP plan.. Valid values are `approved|pending|rejected`',
    `approved_by` STRING COMMENT 'Name of the food safety manager or authority who approved the plan.',
    `audit_last_date` DATE COMMENT 'Date of the most recent HACCP audit.',
    `audit_next_due` DATE COMMENT 'Scheduled date for the next HACCP audit.',
    `audit_status` STRING COMMENT 'Result of the most recent HACCP audit.. Valid values are `compliant|non_compliant|pending|in_progress|failed|not_applicable`',
    `compliance_status` STRING COMMENT 'Current overall compliance standing of the HACCP plan.. Valid values are `compliant|non_compliant|under_review`',
    `corrective_action_procedure` STRING COMMENT 'Standard steps to be taken when a CCP deviation occurs.',
    `critical_control_points` STRING COMMENT 'List of CCPs defined in the plan, stored as a delimited string.',
    `document_status` STRING COMMENT 'Current status of the HACCP document in the document lifecycle.. Valid values are `active|archived|superseded|draft|retired|pending`',
    `document_url` STRING COMMENT 'Link to the stored electronic version of the HACCP plan.',
    `effective_from` DATE COMMENT 'Date when the HACCP plan becomes effective and enforceable.',
    `effective_until` DATE COMMENT 'Date when the HACCP plan expires or is superseded; null if open‑ended.',
    `hazard_analysis_summary` STRING COMMENT 'Brief narrative summarizing identified hazards and risk assessments.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the HACCP plan.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the HACCP plan.. Valid values are `draft|active|inactive|retired|suspended|pending`',
    `monitoring_frequency` STRING COMMENT 'How often each CCP is monitored.. Valid values are `per_shift|daily|weekly|monthly|quarterly|annually`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the HACCP plan.',
    `non_conformance_count` STRING COMMENT 'Number of recorded non‑conformances since the last review.',
    `plan_code` STRING COMMENT 'External business code or identifier used to reference the HACCP plan in reports and audits.',
    `plan_name` STRING COMMENT 'Descriptive name of the HACCP plan for the restaurant unit.',
    `plan_type` STRING COMMENT 'Classification of the plan based on the entity it governs (e.g., restaurant, franchise, corporate, supplier).. Valid values are `Restaurant|Franchise|Corporate|Supplier`',
    `plan_version` STRING COMMENT 'Version identifier of the HACCP plan, typically following a major.minor scheme.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the HACCP plan record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the HACCP plan record.',
    `regulatory_framework` STRING COMMENT 'Regulatory standard(s) the HACCP plan aligns with.. Valid values are `FDA_FSMA|ISO_22000|ServSafe|Local_Health`',
    `revision_number` STRING COMMENT 'Sequential revision count for the HACCP plan.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the plan.. Valid values are `low|medium|high|critical`',
    `sanitation_schedule_reference` STRING COMMENT 'Link or code to the sanitation schedule tied to this HACCP plan.',
    `scope_description` STRING COMMENT 'Narrative describing the physical or operational scope covered by the plan.',
    `temperature_log_reference` STRING COMMENT 'Identifier or path to the temperature log data associated with this plan.',
    `temperature_monitoring_required_flag` BOOLEAN COMMENT 'Indicates if temperature monitoring is a required control in this plan.',
    `training_completion_date` DATE COMMENT 'Date when required training was completed.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether staff training is required for this plan.',
    CONSTRAINT pk_haccp_plan PRIMARY KEY(`haccp_plan_id`)
) COMMENT 'Master record for each restaurant units Hazard Analysis and Critical Control Points (HACCP) plan, including plan version, scope, approval status, regulatory framework alignment (FDA FSMA, ISO 22000, Codex Alimentarius), effective and expiration dates, responsible food safety manager, team members, and prerequisite program references. Serves as the authoritative SSOT for HACCP program governance across all company-owned and franchised units. Each plan undergoes annual review and revalidation.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` (
    `critical_control_point_id` BIGINT COMMENT 'Unique system-generated identifier for the critical control point.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Critical control points (cooking stations, cold storage, receiving docks) are defined for specific physical process locations within a facility. Facility-specific CCP mapping is required for HACCP pla',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each Critical Control Point belongs to a single HACCP plan; adding haccp_plan_id creates the required parent link.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Each CCP must have a qualified employee monitor it; linking enables CCP compliance reports and corrective‑action tracking.',
    `average_deviation_value` DECIMAL(18,2) COMMENT 'Average magnitude of deviations observed across monitoring events.',
    `corrective_action_procedure` STRING COMMENT 'Standardized steps to take when a deviation from the critical limit occurs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CCP record was first created in the system.',
    `critical_control_point_code` STRING COMMENT 'Business identifier code used to reference the CCP in SOPs and audits.',
    `critical_control_point_name` STRING COMMENT 'Human‑readable name of the critical control point.',
    `critical_control_point_status` STRING COMMENT 'Current lifecycle status of the CCP.. Valid values are `active|inactive|retired|pending_review`',
    `critical_limit_max` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable range for the control parameter (e.g., maximum temperature).',
    `critical_limit_min` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable range for the control parameter (e.g., minimum temperature).',
    `deviation_count` STRING COMMENT 'Cumulative number of recorded deviations from the critical limits.',
    `effective_end_date` DATE COMMENT 'Date when the CCP is retired or superseded; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the CCP became effective.',
    `haccp_plan_version` STRING COMMENT 'Version identifier of the HACCP plan to which this CCP belongs.',
    `hazard_type` STRING COMMENT 'Category of hazard the CCP is designed to control.. Valid values are `biological|chemical|physical`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the CCP is classified as a critical control point (true) or a control point (false).',
    `last_monitored_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent monitoring observation.',
    `last_verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent verification activity.',
    `monitoring_frequency` STRING COMMENT 'How often the CCP is monitored.. Valid values are `continuous|hourly|per_batch|daily|weekly|monthly`',
    `monitoring_method` STRING COMMENT 'Technique or instrument used to monitor the CCP (e.g., calibrated thermometer).',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the CCP.',
    `process_step` STRING COMMENT 'Operational step in the food preparation flow where the CCP applies.. Valid values are `receiving|storage|preparation|cooking|cooling|serving`',
    `regulatory_reference` STRING COMMENT 'Applicable regulatory or certification reference (e.g., FDA FSMA, ISO 22000, ServSafe).',
    `responsible_role` STRING COMMENT 'Job role accountable for monitoring and maintaining the CCP.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the critical limit values.. Valid values are `C|F|pH|minutes|seconds|hours`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CCP record.',
    `verification_frequency` STRING COMMENT 'How often the CCP is independently verified for compliance.. Valid values are `weekly|monthly|quarterly|annually`',
    `verification_method` STRING COMMENT 'Method used during verification (e.g., internal audit, third‑party audit).',
    CONSTRAINT pk_critical_control_point PRIMARY KEY(`critical_control_point_id`)
) COMMENT 'Defines each Critical Control Point (CCP) within a HACCP plan, including the hazard type (biological, chemical, physical), critical limits (min/max temperature, pH, time), monitoring method, corrective action procedure, and verification frequency. Each CCP is tied to a specific process step (e.g., cooking, cooling, receiving) and HACCP plan version.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` (
    `food_safety_audit_id` BIGINT COMMENT 'Surrogate primary key for the food safety audit record.',
    `employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit expense tracking: each food safety audit is charged to a cost center for cost control and audit cost reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: HACCP and third-party food safety audits are conducted at a specific physical facility. The existing site_id captures land/address; facility_id captures the inspected building. Multi-facility sites re',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: food_safety_audit has a `haccp_plan_version: STRING` field — a text reference to the HACCP plan version being audited. This is a strong indicator that each food safety audit is conducted against a spe',
    `primary_food_employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the audit was conducted.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Food safety audits are conducted at a specific restaurant location; associating audits with site_id supports site‑wide audit tracking and rent‑related compliance.',
    `allergen_control_compliant` BOOLEAN COMMENT 'Indicates compliance with allergen control requirements.',
    `attached_documents_count` STRING COMMENT 'Number of supporting documents attached to the audit record.',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit, often used in reports and communications.',
    `audit_timestamp` TIMESTAMP COMMENT 'Date and time when the audit was performed on site.',
    `audit_type` STRING COMMENT 'Classification of the audit source: internal, third‑party, or health department.. Valid values are `internal|third_party|health_department`',
    `auditor_name` STRING COMMENT 'Full name of the auditor.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Aggregated compliance score based on weighted findings.',
    `corrective_action_deadline` DATE COMMENT 'Date by which all corrective actions must be completed.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective actions associated with the audit.. Valid values are `pending|in_progress|completed|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical (high‑severity) findings identified.',
    `food_safety_audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `pending|in_progress|completed|closed|failed`',
    `haccp_plan_version` STRING COMMENT 'Version identifier of the HACCP plan referenced during the audit.',
    `non_critical_findings_count` STRING COMMENT 'Number of non‑critical (low‑severity) findings identified.',
    `notes` STRING COMMENT 'Free‑text field for auditor observations, comments, and recommendations.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score representing overall compliance, typically 0‑100.',
    `pass_fail` STRING COMMENT 'Overall result indicating whether the audit passed or failed.. Valid values are `pass|fail`',
    `regulatory_body` STRING COMMENT 'Regulatory authority overseeing the audit.. Valid values are `FDA|USDA|OSHA|Local_Health_Department`',
    `sanitation_schedule_compliant` BOOLEAN COMMENT 'Indicates compliance with scheduled sanitation procedures.',
    `temperature_monitoring_compliant` BOOLEAN COMMENT 'Indicates if temperature monitoring met required standards during the audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    CONSTRAINT pk_food_safety_audit PRIMARY KEY(`food_safety_audit_id`)
) COMMENT 'Header-and-line transactional record of each food safety audit conducted at a restaurant unit, including audit metadata (type: internal/third-party/health-department, date, auditor, overall score, pass/fail) and individual findings (category: critical/major/minor, regulatory reference, corrective action required, responsible party, due date, resolution status). Managed via Zenput. Supports QA compliance tracking, trend analysis, and regulatory reporting. Each audit contains zero-to-many findings as line items.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for the audit finding record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Remediation cost allocation: corrective actions for findings are budgeted against a cost center.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Audit findings identify deficiencies in specific physical facilities. Facility managers need direct facility-level finding reports to prioritize capital repairs and track remediation. Without this FK,',
    `food_safety_audit_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_safety_audit. Business justification: Audit findings are recorded under a specific food safety audit; adding food_safety_audit_id links findings to their audit.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor accountable for corrective action.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the audit was performed.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Audit findings frequently identify specific stock items as non-compliant (expired product, improper labeling, allergen mislabeling). Linking audit_finding to stock_item enables targeted corrective act',
    `audit_finding_description` STRING COMMENT 'Detailed narrative of the violation or observation.',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the finding.. Valid values are `open|in_progress|closed|deferred|rejected`',
    `corrective_action` STRING COMMENT 'Prescribed action required to remediate the finding.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created in the system.',
    `due_date` DATE COMMENT 'Date by which the corrective action must be completed.',
    `finding_category` STRING COMMENT 'High‑level domain of the finding (e.g., HACCP, sanitation).. Valid values are `haccp|food_safety|sanitation|allergen|equipment|facility`',
    `finding_number` STRING COMMENT 'Human‑readable identifier assigned to the finding within the audit.',
    `finding_timestamp` TIMESTAMP COMMENT 'Date and time when the finding was recorded during the audit.',
    `has_attachment` BOOLEAN COMMENT 'Indicates whether supporting documentation (photos, files) is attached.',
    `regulatory_reference` STRING COMMENT 'Code or citation of the applicable regulation (e.g., FDA Food Code section).',
    `resolution_date` DATE COMMENT 'Date when the finding was closed or resolved.',
    `severity_level` STRING COMMENT 'Categorical severity classification of the finding.. Valid values are `critical|major|minor|informational`',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) representing the seriousness of the finding.',
    `source_system` STRING COMMENT 'Originating system that captured the finding (e.g., Zenput).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding or violation recorded during a food safety audit, capturing finding category (critical, major, minor), description, regulatory reference (FDA Food Code, local health code), corrective action required, responsible party, due date, and resolution status. Each finding is linked to a specific audit and restaurant unit.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` (
    `health_inspection_id` BIGINT COMMENT 'Unique surrogate key for the health inspection record.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Health inspections generate fee payments (inspection_fee_amount already on health_inspection) processed as AP invoices. Finance must reconcile inspection fee disbursements to specific inspection event',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection cost accounting: health inspection fees and related expenses are charged to a cost center.',
    `employee_id` BIGINT COMMENT 'System identifier for the inspector.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Health departments inspect specific physical facilities (kitchens, storage areas), not abstract site parcels. A facility_id FK enables facility-level inspection history reporting, compliance scoring p',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location inspected.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Regulatory health inspection reports are filed per physical site; linking enables site‑level compliance dashboards and audit trails.',
    `agency_name` STRING COMMENT 'Name of the regulatory agency that performed the inspection.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates if supporting documents (photos, reports) are attached.',
    `closure_order_date` DATE COMMENT 'Date when the closure order was issued.',
    `closure_order_flag` BOOLEAN COMMENT 'Indicates if the inspection resulted in a closure order.',
    `compliance_code` STRING COMMENT 'Regulatory framework or code applicable to the inspection.. Valid values are `FSMA|HACCP|Local_Code`',
    `corrective_action_deadline` DATE COMMENT 'Date by which corrective actions must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates if corrective actions are required.',
    `corrective_action_status` STRING COMMENT 'Current status of required corrective actions.. Valid values are `pending|completed|not_applicable`',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO currency code for the inspection fee.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `follow_up_inspection_date` DATE COMMENT 'Scheduled date for the follow-up inspection.',
    `follow_up_inspection_required` BOOLEAN COMMENT 'Indicates if a follow-up inspection is mandated.',
    `inspection_date` DATE COMMENT 'Date when the health inspection was conducted.',
    `inspection_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the agency for conducting the inspection.',
    `inspection_number` STRING COMMENT 'Official inspection number assigned by the regulatory agency.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record.. Valid values are `scheduled|in_progress|completed|closed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Exact date and time when the health inspection took place.',
    `inspection_type` STRING COMMENT 'Category of the inspection based on its trigger.. Valid values are `routine|follow_up|complaint|reinspection`',
    `inspector_code` BIGINT COMMENT 'System identifier for the inspector.',
    `inspector_name` STRING COMMENT 'Name of the inspector who performed the health inspection.',
    `notes` STRING COMMENT 'Additional comments or observations recorded by the inspector.',
    `overall_grade` STRING COMMENT 'Overall grade assigned by the inspector.. Valid values are `A|B|C|D|F|NA`',
    `pass_fail` STRING COMMENT 'Indicates whether the restaurant passed the inspection.. Valid values are `pass|fail`',
    `permit_status` STRING COMMENT 'Current status of the health permit.. Valid values are `active|suspended|revoked|expired`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first entered into the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record.',
    `risk_level` STRING COMMENT 'Overall risk classification based on inspection findings.. Valid values are `low|medium|high|critical`',
    `score` STRING COMMENT 'Numeric score representing compliance level (higher is better).',
    `violation_summary` STRING COMMENT 'Brief description of the violations identified.',
    `violations_count` STRING COMMENT 'Number of violations cited in the inspection.',
    CONSTRAINT pk_health_inspection PRIMARY KEY(`health_inspection_id`)
) COMMENT 'Header-and-line record of official health inspections conducted by local health departments or regulatory authorities at restaurant units, including inspection header (date, inspector, agency, type: routine/follow-up/complaint-driven, overall grade, permit status, closure orders) and individual violations as line items (violation code, severity: critical/non-critical, FDA Food Code citation, corrective action required, compliance deadline, re-inspection outcome). This is the authoritative regulatory inspection record distinct from internal food safety audits.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` (
    `inspection_violation_id` BIGINT COMMENT 'Unique identifier for the inspection violation record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Inspection violations are tied to specific physical areas of a facility (e.g., walk-in cooler, prep kitchen). Facility managers need violation history per facility to prioritize capital repairs and de',
    `health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that generated this violation.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the violation was observed.',
    `area_of_concern` STRING COMMENT 'Physical area within the restaurant where the violation occurred.. Valid values are `kitchen|storage|dining|restroom|outside`',
    `compliance_deadline` DATE COMMENT 'Date by which the corrective action must be completed to achieve compliance.',
    `corrective_action_required` STRING COMMENT 'Action that must be taken to remediate the violation.',
    `corrective_action_status` STRING COMMENT 'Current progress status of the corrective action.. Valid values are `not_started|in_progress|completed|deferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation record was first created in the system.',
    `evidence_photo_url` STRING COMMENT 'Link to photographic evidence associated with the violation.',
    `follow_up_inspection_date` DATE COMMENT 'Scheduled date for the re‑inspection after corrective actions.',
    `inspection_violation_status` STRING COMMENT 'Current lifecycle status of the violation record.. Valid values are `open|closed|in_progress|dismissed`',
    `inspector_code` BIGINT COMMENT 'Identifier of the inspector who recorded the violation.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations about the violation.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for the violation, if any.',
    `penalty_currency` STRING COMMENT 'Three‑letter ISO currency code for the penalty amount.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulatory provision (e.g., FDA Food Code section) that the violation breaches.',
    `reinspection_outcome` STRING COMMENT 'Result of the follow‑up inspection after corrective actions were taken.. Valid values are `resolved|unresolved|pending|not_applicable`',
    `severity` STRING COMMENT 'Severity level of the violation indicating its impact on food safety.. Valid values are `critical|non-critical|minor`',
    `source_system` STRING COMMENT 'System or process that captured the violation record.. Valid values are `Zenput|Manual|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `violation_code` STRING COMMENT 'Standardized code assigned to the violation by the regulatory authority.. Valid values are `^[A-Z0-9.-]+$`',
    `violation_description` STRING COMMENT 'Full textual description of the violation observed during the inspection.',
    `violation_reported_by` STRING COMMENT 'Full name of the inspector who reported the violation.',
    `violation_timestamp` TIMESTAMP COMMENT 'Exact date and time when the violation was observed.',
    `violation_type` STRING COMMENT 'Broad category describing the nature of the violation.. Valid values are `food|facility|equipment|hygiene|documentation`',
    CONSTRAINT pk_inspection_violation PRIMARY KEY(`inspection_violation_id`)
) COMMENT 'Individual violation cited during an official health inspection, including violation code, description, severity classification (critical, non-critical), regulatory citation (FDA Food Code section, local ordinance), corrective action required, compliance deadline, and re-inspection outcome. Supports regulatory compliance tracking and trend analysis.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'System-generated unique identifier for the corrective action record.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Corrective actions (equipment repair, pest control, deep cleaning) generate vendor AP invoices. Finance requires linking remediation spend to the triggering food safety event for regulatory cost track',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to foodsafety.audit_finding. Business justification: The foodsafety_corrective_action product description explicitly states it tracks CAPAs initiated in response to food safety audit findings. Formalizing this as a FK to audit_finding establishes the ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial tracking of corrective action spend: each action is budgeted to a cost center for expense control.',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: foodsafety_corrective_action has a boolean field `ccp_deviation: BOOLEAN` explicitly indicating whether the corrective action was triggered by a CCP deviation. This strongly implies a direct relations',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Food safety corrective actions frequently require physical facility remediation (e.g., repairing hand-washing stations, fixing refrigeration). Linking corrective actions to the specific facility enabl',
    `inspection_violation_id` BIGINT COMMENT 'Foreign key linking to foodsafety.inspection_violation. Business justification: Corrective actions in a restaurant food safety context are also triggered by official health inspection violations (not just internal audit findings). The foodsafety_corrective_action table has no exi',
    `employee_id` BIGINT COMMENT 'Identifier of the manager accountable for executing the corrective action.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: A corrective action frequently targets a specific stock item for quarantine, disposal, or reprocessing (e.g., temperature-abused chicken, allergen cross-contact). Linking to stock_item enables targete',
    `tertiary_corrective_verified_by_employee_id` BIGINT COMMENT 'Identifier of the individual who verified the corrective action.',
    `training_completion_id` BIGINT COMMENT 'Foreign key linking to workforce.training_completion. Business justification: CCP deviations and audit findings frequently mandate retraining as corrective action. Linking foodsafety_corrective_action to the training_completion that closes the training requirement enables closu',
    `action_code` STRING COMMENT 'Business identifier or code assigned to the corrective action for tracking and reporting.',
    `action_cost` DECIMAL(18,2) COMMENT 'Monetary cost incurred to implement the corrective action.',
    `action_type` STRING COMMENT 'Classification of the action as corrective, preventive, or both.. Valid values are `corrective|preventive|both`',
    `actual_completion_date` DATE COMMENT 'Date when the corrective action was actually completed.',
    `attachment_url` STRING COMMENT 'Link to supporting documents or images attached to the corrective action.',
    `ccp_deviation` BOOLEAN COMMENT 'Indicates whether the corrective action is related to a Critical Control Point deviation.',
    `closure_status` STRING COMMENT 'Final status indicating whether the corrective action has been closed, verified, or rejected.. Valid values are `pending|verified|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the action cost.',
    `effective_date` DATE COMMENT 'Date when the corrective action became effective.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action was created or initiated.',
    `foodsafety_corrective_action_description` STRING COMMENT 'Detailed description of the corrective or preventive action to be taken.',
    `foodsafety_corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action.. Valid values are `open|in_progress|completed|closed|cancelled`',
    `is_effective` BOOLEAN COMMENT 'Indicates whether the corrective action has been determined effective after verification.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `party_code` BIGINT COMMENT 'Identifier of the primary party (e.g., restaurant unit or franchise) responsible for the corrective action.',
    `priority` STRING COMMENT 'Priority assigned to the corrective action for scheduling and resource allocation.. Valid values are `low|medium|high`',
    `root_cause` STRING COMMENT 'Narrative description of the underlying cause that triggered the corrective action.',
    `severity_level` STRING COMMENT 'Severity rating of the issue that prompted the corrective action.. Valid values are `low|medium|high|critical`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action should be completed.',
    `temperature_exceedance` BOOLEAN COMMENT 'True if the action addresses a temperature limit breach.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the corrective action record.',
    `verification_date` DATE COMMENT 'Date on which the verification of the corrective action was performed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effective.. Valid values are `observation|test|audit|review`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Tracks corrective and preventive actions (CAPA) initiated in response to food safety audit findings, health inspection violations, CCP deviations, temperature exceedances, pest control findings, or allergen incidents. Captures root cause analysis method (5-Why, fishbone), corrective action description, responsible manager, target and actual completion dates, verification method, effectiveness check outcome, and closure status. Serves as the central CAPA registry managed via Zenput task management, supporting FDA Food Code and ISO 22000 corrective action requirements.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` (
    `temperature_log_id` BIGINT COMMENT 'System-generated unique identifier for each temperature reading record.',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: Temperature logs are the operational monitoring records for Critical Control Points under HACCP. The critical_control_point table defines critical_limit_min, critical_limit_max, monitoring_method, and',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manually entered the reading, if applicable.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier of the equipment or sensor that generated the temperature reading.',
    `shift_id` BIGINT COMMENT 'Identifier of the workforce shift during which the reading was taken.',
    `stock_location_id` BIGINT COMMENT 'Identifier of the restaurant location or specific area (e.g., kitchen, dock) where the reading occurred.',
    `audit_reference` STRING COMMENT 'Identifier linking the reading to a specific food safety audit or inspection.',
    `batch_number` STRING COMMENT 'Optional batch identifier grouping a set of readings for a specific audit period.',
    `calibration_date` DATE COMMENT 'Date when the sensor was last calibrated.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next sensor calibration.',
    `compliance_status` STRING COMMENT 'Result of compliance check for this reading against HACCP requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the temperature log record was initially created in the system.',
    `critical_limit_high` DECIMAL(18,2) COMMENT 'Upper temperature threshold defined by HACCP for the monitoring point.',
    `critical_limit_low` DECIMAL(18,2) COMMENT 'Lower temperature threshold defined by HACCP for the monitoring point.',
    `data_quality_flag` STRING COMMENT 'Indicator of the data quality assessment for the reading.. Valid values are `valid|suspect|invalid`',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the temperature reading falls outside the defined critical limits.',
    `maintenance_due_date` DATE COMMENT 'Planned date for required maintenance activities.',
    `maintenance_required` BOOLEAN COMMENT 'Indicates whether the equipment requires maintenance based on the reading or schedule.',
    `monitoring_method` STRING COMMENT 'Method used to capture the temperature (manual probe or automated sensor).. Valid values are `manual|automated`',
    `notes` STRING COMMENT 'Free‑text field for additional observations or comments about the reading.',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the temperature measurement was taken at the monitoring point.',
    `reading_type` STRING COMMENT 'Category of the monitoring point where the temperature was recorded.. Valid values are `cooler|freezer|hot_holding|cooking|receiving`',
    `sensor_serial_number` STRING COMMENT 'Manufacturer serial number of the temperature sensor device.',
    `source_system` STRING COMMENT 'System of origin for the temperature data.. Valid values are `zenput|custom|other`',
    `temperature_log_status` STRING COMMENT 'Current lifecycle status of the temperature log record.. Valid values are `active|archived`',
    `temperature_trend` STRING COMMENT 'Observed trend of temperature change relative to previous readings.. Valid values are `rising|falling|stable`',
    `temperature_value` DECIMAL(18,2) COMMENT 'Measured temperature value captured by the sensor or manual probe.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the temperature reading (Fahrenheit or Celsius).. Valid values are `F|C`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the temperature log record.',
    CONSTRAINT pk_temperature_log PRIMARY KEY(`temperature_log_id`)
) COMMENT 'Time-series log of temperature readings captured at critical monitoring points (walk-in coolers, freezers, hot-holding units, cooking equipment, receiving docks), including equipment ID, reading timestamp, measured temperature, unit of measure (°F/°C), critical limit thresholds, deviation flag, and monitoring method (manual probe, automated sensor). Core HACCP monitoring record per Principle 4.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` (
    `sanitation_task_log_id` BIGINT COMMENT 'Unique system-generated identifier for each sanitation task log entry.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who executed the sanitation task.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Sanitation tasks (hood cleaning, floor sanitization, pest control) are performed in specific physical facilities. The existing site_id is address-level; facility_id enables facility-level sanitation c',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: The haccp_plan table has a `sanitation_schedule_reference: STRING` field, indicating that sanitation schedules are governed by HACCP plans. Sanitation tasks are a core component of HACCP compliance — ',
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier of the equipment item that was sanitized.',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit where the sanitation activity took place.',
    `shift_id` BIGINT COMMENT 'Unique identifier of the employee shift associated with the task.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Sanitation tasks are performed at a specific site; linking enables site‑level sanitation compliance reporting and audit.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Sanitation tasks are scheduled per storage area; the FK ties task logs to the exact location for compliance tracking.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task log entry was first inserted into the data lake.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the sanitation task log entry.',
    `chemical_concentration` DECIMAL(18,2) COMMENT 'Numeric value of the chemical concentration measured during the task.',
    `chemical_name` STRING COMMENT 'Descriptive name of the chemical or sanitizer applied during the task.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task was marked as completed.',
    `compliance_regulation` STRING COMMENT 'Regulation or standard that the sanitation task satisfies.. Valid values are `FDA_FSMA|ServSafe|ISO_22000|Local_Health`',
    `concentration_unit` STRING COMMENT 'Unit of measure for the chemical concentration (e.g., parts per million).. Valid values are `ppm|mg_l|percent`',
    `corrective_action` STRING COMMENT 'Description of any corrective measures applied after a failed sanitation check.',
    `deviation_notes` STRING COMMENT 'Free‑text description of any deviations, issues, or observations noted during the task.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage measured in the task area at the time of execution.',
    `is_critical` BOOLEAN COMMENT 'True if the sanitation task is deemed critical for food safety compliance.',
    `location_area` STRING COMMENT 'Specific area (e.g., Front‑of‑House, Back‑of‑House) where sanitation was executed.. Valid values are `FOH|BOH|kitchen|dining|storage`',
    `notes` STRING COMMENT 'Any supplemental information not captured in other fields.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the sanitation task met compliance criteria.. Valid values are `pass|fail`',
    `photo_url` STRING COMMENT 'Web address of a photo taken as evidence of task completion.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task was scheduled to occur.',
    `source_system` STRING COMMENT 'System of record that created the sanitation task log.. Valid values are `Zenput|Custom`',
    `task_duration_seconds` STRING COMMENT 'Total time taken to complete the sanitation task, measured in seconds.',
    `task_status` STRING COMMENT 'Operational status of the sanitation task record.. Valid values are `completed|missed|overdue|in_progress`',
    `task_timestamp` TIMESTAMP COMMENT 'Exact date and time the sanitation task was completed.',
    `task_type` STRING COMMENT 'Classification of the sanitation task (e.g., surface cleaning, equipment sanitization).. Valid values are `surface_clean|equipment_sanitize|hand_wash|trash_bin_clean`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius measured in the task area at the time of execution.',
    `verification_method` STRING COMMENT 'Technique employed to confirm task compliance.. Valid values are `visual|sensor|chemical_test`',
    CONSTRAINT pk_sanitation_task_log PRIMARY KEY(`sanitation_task_log_id`)
) COMMENT 'Transactional record of each completed or missed sanitation task execution at a restaurant unit, capturing task completion timestamp, employee who performed the task, actual chemical concentration measured, pass/fail status, and any deviation notes. Linked to the master sanitation schedule and managed via Zenput task management.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` (
    `food_safety_certification_id` BIGINT COMMENT 'System‑generated unique identifier for each food safety certification record.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Food safety certifications (ServSafe, health permits, operating licenses) require fee payments processed as AP invoices. Finance tracks certification fee spend by location for compliance cost reportin',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who holds the certification.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Operating permits and food safety certifications (NSF, health permits) are issued to specific facilities, not employees or abstract sites. Facility managers must track certification expiration by faci',
    `food_safety_audit_id` BIGINT COMMENT 'Unique identifier of the certification record in the source system.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Food safety certifications and health permits are issued to specific legal entities in multi-entity franchise operations. Regulatory compliance reporting (FDA, state health departments) requires certi',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: Food safety audit certifications must reconcile with HR certification records for regulatory compliance. Linking food_safety_certification to workforce.certification enables cross-domain expiration tr',
    `attached_document_path` STRING COMMENT 'Location of the digital copy of the certification document in the document repository.',
    `audit_source_system` STRING COMMENT 'Name of the operational system of record (e.g., Zenput) that originated the certification data.',
    `certification_category` STRING COMMENT 'High‑level grouping used for analytics and compliance reporting.. Valid values are `Food Safety|Allergen Management|Quality Assurance|Other`',
    `certification_name` STRING COMMENT 'Descriptive name of the certification (e.g., "ServSafe Manager").',
    `certification_number` STRING COMMENT 'Unique number or code provided by the issuing organization.',
    `certification_type` STRING COMMENT 'Category of the certification according to industry standards.. Valid values are `ServSafe Manager|ServSafe Food Handler|HACCP|Allergen Awareness|Other`',
    `compliance_flag` BOOLEAN COMMENT 'True when the certification satisfies all applicable FDA, USDA, and ISO 22000 requirements.',
    `expiration_date` DATE COMMENT 'Calendar date on which the certification is no longer valid.',
    `expiration_notice_date` DATE COMMENT 'Date on which the expiration reminder was sent.',
    `expiration_notice_sent` BOOLEAN COMMENT 'True when a reminder about upcoming expiration has been communicated to the employee.',
    `food_safety_certification_status` STRING COMMENT 'Operational status indicating if the certification is currently valid, pending renewal, revoked, etc.. Valid values are `active|inactive|revoked|expired|pending`',
    `issue_date` DATE COMMENT 'Calendar date on which the certification became effective.',
    `issuing_body` STRING COMMENT 'Name of the authority that granted the certification.',
    `last_renewal_date` DATE COMMENT 'Date when the certification was last renewed, if applicable.',
    `next_renewal_due` DATE COMMENT 'Projected date by which the certification must be renewed to remain active.',
    `notes` STRING COMMENT 'Additional remarks, auditor comments, or special conditions related to the certification.',
    `record_audit_created` TIMESTAMP COMMENT 'Date‑time when the certification record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the certification record.',
    `renewal_required` BOOLEAN COMMENT 'True if the certification must be renewed prior to its expiration date.',
    `revocation_reason` STRING COMMENT 'Explanation why a certification was revoked or invalidated.',
    `validity_period_days` STRING COMMENT 'Number of days between issue_date and expiration_date.',
    CONSTRAINT pk_food_safety_certification PRIMARY KEY(`food_safety_certification_id`)
) COMMENT 'Unified food safety workforce compliance record covering both training events and resulting certifications held by restaurant employees. Training attributes: program name, type (onboarding/annual refresher/corrective retraining/allergen awareness), delivery method (in-person/e-learning/Zenput), completion date, assessment score, pass/fail, trainer identity. Certification attributes: type (ServSafe Manager/Food Handler/HACCP/allergen awareness), issuing body (NRA ServSafe, ANSI-accredited provider), certification number, issue date, expiration date, validity status. Supports regulatory staffing requirements, retraining triggers, and compliance dashboards.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`foodsafety`.`illness_report` (
    `illness_report_id` BIGINT COMMENT 'Unique identifier for the illness report record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Illness outbreak traceability: Foodservice regulators and operators must trace illness clusters to specific LTO or promotional items. Linking illness_report to campaign enables the named illness-to-L',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported or is associated with the illness.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Illness reports in foodservice must identify the affected guest for follow-up, legal liability management, and health department notification. Currently illness_report only has employee_id; guest-repo',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the employee fell ill.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Foodborne illness reports must be tied to a specific location for health department notification and outbreak investigation. Regulatory agencies track illness incidents by site address. This link enab',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: illness_report.suspected_food_item is a denormalized text field. Normalizing to stock_item_id enables foodborne illness traceability, lot-number-based recalls, and regulatory reporting. Health departm',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: FDA/regulatory foodborne illness investigations require tracing the specific menu item suspected in an illness event. The existing suspected_food_item plain-text column is a denormalization of menu_',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: Health departments require identifying the specific visit/meal event associated with a reported foodborne illness to trace the exposure source. Linking illness_report to guest_visit enables investigat',
    `action_plan` STRING COMMENT 'Planned actions to prevent recurrence.',
    `action_plan_completed_date` DATE COMMENT 'Date when the action plan was completed.',
    `action_plan_due_date` DATE COMMENT 'Target date for completing the action plan.',
    `compliance_reference` STRING COMMENT 'Reference to the specific regulatory requirement or guidance applicable to the report.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action performed in response to the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the report record was first created in the system.',
    `exclusion_decision` BOOLEAN COMMENT 'Indicates whether the employee was excluded from work due to the illness.',
    `exclusion_start_date` DATE COMMENT 'Date when the employees work exclusion began.',
    `health_department_notification_date` DATE COMMENT 'Date when the health department was notified about the incident.',
    `health_department_notified` BOOLEAN COMMENT 'Flag indicating whether the local health department was notified.',
    `illness_report_status` STRING COMMENT 'Current lifecycle status of the illness report.. Valid values are `reported|under_review|closed|rejected`',
    `investigation_end_date` DATE COMMENT 'Date when the health investigation concluded.',
    `investigation_start_date` DATE COMMENT 'Date when the health investigation began.',
    `investigation_status` STRING COMMENT 'Current status of the health investigation.. Valid values are `not_started|in_progress|completed|closed`',
    `notes` STRING COMMENT 'Free‑form notes captured by investigators or managers.',
    `onset_date` DATE COMMENT 'Date when the employee first experienced symptoms.',
    `report_method` STRING COMMENT 'Method by which the illness was reported.. Valid values are `self|manager|hr`',
    `report_number` STRING COMMENT 'Business identifier assigned to the illness report.',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the illness was reported.',
    `return_to_work_date` DATE COMMENT 'Date when the employee was cleared to return to work.',
    `root_cause` STRING COMMENT 'Identified root cause of the illness, if determined.',
    `severity_level` STRING COMMENT 'Categorical severity level derived from the severity score.. Valid values are `mild|moderate|severe`',
    `severity_score` STRING COMMENT 'Numeric score representing the severity of the reported illness.',
    `source_system` STRING COMMENT 'System of record that originated the illness report (e.g., Zenput, HR portal).',
    `suspected_pathogen` STRING COMMENT 'Pathogen suspected to have caused the illness, if known.',
    `symptoms` STRING COMMENT 'Symptoms reported by the employee, captured for health analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the report record.',
    CONSTRAINT pk_illness_report PRIMARY KEY(`illness_report_id`)
) COMMENT 'Transactional record of a reported employee foodborne illness or suspected foodborne illness event at a restaurant unit, capturing report date, employee role, symptoms reported, onset date, suspected pathogen or food item, exclusion-from-work decision, return-to-work clearance date, and health department notification status. Supports FDA Food Code employee health policy compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_inspection_violation_id` FOREIGN KEY (`inspection_violation_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`inspection_violation`(`inspection_violation_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`foodsafety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `restaurants_ecm`.`foodsafety` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_next_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|in_progress|failed|not_applicable');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `critical_control_points` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Points (CCPs)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'active|archived|superseded|draft|retired|pending');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `hazard_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Summary');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Lifecycle Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|suspended|pending');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Conformance Count');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Business Code');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Name');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Type');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'Restaurant|Franchise|Corporate|Supplier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'FDA_FSMA|ISO_22000|ServSafe|Local_Health');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `sanitation_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Reference');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point ID (CCP ID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `average_deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Average Deviation Value (Avg Deviation)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure (CAP)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created At)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_code` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Code (CCP Code)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Name (CCP Name)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_business_glossary_term' = 'Status (CCP Status)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending_review');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_max` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Maximum Value (Critical Limit Max)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_min` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Minimum Value (Critical Limit Min)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count (Number of Deviations)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (End Date)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (Start Date)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version (Plan Version)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type (Biological/Chemical/Physical)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'biological|chemical|physical');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical (Critical Flag)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_monitored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Monitored Timestamp (Last Monitored At)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp (Last Verified At)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (Frequency)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'continuous|hourly|per_batch|daily|weekly|monthly');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method (Method)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (CCP Notes)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step (HACCP Process Step)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_value_regex' = 'receiving|storage|preparation|cooking|cooling|serving');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (Regulation)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role (Role)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'C|F|pH|minutes|seconds|hours');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated At)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency (Verification Frequency)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method (Verification Method)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID (REST_ID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `allergen_control_compliant` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Compliance (ALLERGEN_COMPLIANT)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `attached_documents_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Count (DOC_COUNT)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Date and Time (AUDIT_TS)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|third_party|health_department');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name (AUDITOR_NAME)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (COMPLIANCE_SCORE)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline (CORRECTIVE_DEADLINE)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CORRECTIVE_STATUS)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count (CRIT_FINDINGS)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUDIT_STATUS)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed|failed');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `haccp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version (HACCP_VER)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `non_critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Critical Findings Count (NONCRIT_FINDINGS)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes (AUDIT_NOTES)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Score (OVERALL_SCORE)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result (PASS_FAIL)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|OSHA|Local_Health_Department');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `sanitation_schedule_compliant` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Compliance (SANITATION_COMPLIANT)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `temperature_monitoring_compliant` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Compliance (TEMP_COMPLIANT)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|deferred|rejected');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'haccp|food_safety|sanitation|allergen|equipment|facility');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `has_attachment` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|informational');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachments Present');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Issued');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Code');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `compliance_code` SET TAGS ('dbx_value_regex' = 'FSMA|HACCP|Local_Code');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Inspection Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Inspection Required');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fee Amount (USD)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (INS_NUM)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|closed');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|follow_up|complaint|reinspection');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Full Name (INSPECTOR_NAME)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `overall_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Grade (GRADE)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `overall_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F|NA');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ALTER COLUMN `violations_count` SET TAGS ('dbx_business_glossary_term' = 'Violations Count');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Violation ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Area of Concern');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_value_regex' = 'kitchen|storage|dining|restroom|outside');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `evidence_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Photo URL');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Inspection Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|dismissed');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `reinspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Outcome');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `reinspection_outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|pending|not_applicable');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity (SEVERITY)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|non-critical|minor');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Zenput|Manual|Other');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code (CODE)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]+$');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'food|facility|equipment|hygiene|documentation');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `inspection_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Violation Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `tertiary_corrective_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `tertiary_corrective_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `tertiary_corrective_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Code');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `action_cost` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Cost');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `ccp_deviation` SET TAGS ('dbx_business_glossary_term' = 'CCP Deviation Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Initiation Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `foodsafety_corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `foodsafety_corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `foodsafety_corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `is_effective` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `temperature_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Temperature Exceedance Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'observation|test|audit|review');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_limit_high` SET TAGS ('dbx_business_glossary_term' = 'Critical High Limit');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_limit_low` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Limit');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Due Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_required` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Required Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_value_regex' = 'cooler|freezer|hot_holding|cooking|receiving');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Sensor Serial Number');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'zenput|custom|other');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_status` SET TAGS ('dbx_value_regex' = 'active|archived');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_trend` SET TAGS ('dbx_business_glossary_term' = 'Temperature Trend');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_trend` SET TAGS ('dbx_value_regex' = 'rising|falling|stable');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_value` SET TAGS ('dbx_business_glossary_term' = 'Temperature Value');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'F|C');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_task_log_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Task Log Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration (Measured)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitizing Chemical Name');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'FDA_FSMA|ServSafe|ISO_22000|Local_Health');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration Unit');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg_l|percent');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity (%)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Task Indicator');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `location_area` SET TAGS ('dbx_business_glossary_term' = 'Location Area');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `location_area` SET TAGS ('dbx_value_regex' = 'FOH|BOH|kitchen|dining|storage');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Photo URL');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Task Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Zenput|Custom');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration (Seconds)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'completed|missed|overdue|in_progress');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Execution Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Task Type');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'surface_clean|equipment_sanitize|hand_wash|trash_bin_clean');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'visual|sensor|chemical_test');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Certification Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `attached_document_path` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Path');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Certification Category');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_value_regex' = 'Food Safety|Allergen Management|Quality Assurance|Other');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'ServSafe Manager|ServSafe Food Handler|HACCP|Allergen Awareness|Other');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|expired|pending');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `next_renewal_due` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Days)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Identifier (IRID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (Restaurant ID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (Shift ID)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Suspected Menu Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Description');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Completion Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Reference');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_decision` SET TAGS ('dbx_business_glossary_term' = 'Exclusion From Work Decision');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Start Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Health Department Notification Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_business_glossary_term' = 'Health Department Notification Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|closed|rejected');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Symptom Onset Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `report_method` SET TAGS ('dbx_business_glossary_term' = 'Report Method');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `report_method` SET TAGS ('dbx_value_regex' = 'self|manager|hr');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Number (IRN)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Timestamp');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return To Work Clearance Date');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Illness Severity Level');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Illness Severity Score');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `suspected_pathogen` SET TAGS ('dbx_business_glossary_term' = 'Suspected Pathogen');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_business_glossary_term' = 'Reported Symptoms (PHI)');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
