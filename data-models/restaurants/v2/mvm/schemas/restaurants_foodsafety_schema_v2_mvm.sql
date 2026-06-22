-- Schema for Domain: foodsafety | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-06-22 16:55:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`foodsafety` COMMENT 'Governs HACCP plan management, food safety audit results, health inspection records, corrective action tracking, temperature monitoring logs, sanitation schedules, allergen management, and SOP compliance via Zenput. Ensures adherence to FDA FSMA, local health department requirements, ISO 22000, and ServSafe standards across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` (
    `haccp_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the HACCP plan record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the HACCP plan.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: QSR brands maintain brand-level HACCP plan templates applied across all units. Brand food safety teams author and version HACCP plans at the brand level before unit adoption. Enables brand-wide HACCP ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: HACCP plans are regulatory documents governing a specific restaurant unit. Health regulators and operators require unit-to-HACCP-plan traceability for inspections and compliance audits. Every unit mus',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` (
    `critical_control_point_id` BIGINT COMMENT 'Unique system-generated identifier for the critical control point.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: CCPs are physically located at specific kitchen stations (cooking CCP at grill station, cold-holding CCP at walk-in). HACCP implementation requires mapping each CCP to its physical monitoring location',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each Critical Control Point belongs to a single HACCP plan; adding haccp_plan_id creates the required parent link.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Each CCP must have a qualified employee monitor it; linking enables CCP compliance reports and corrective‑action tracking.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: CCPs require a designated responsible position for monitoring (e.g., Grill Station Cook monitors internal temp CCP). The existing responsible_role is a denormalized text field. A proper FK to work',
    `average_deviation_value` DECIMAL(18,2) COMMENT 'Average magnitude of deviations observed across monitoring events.',
    `critical_control_point_code` STRING COMMENT 'Business identifier code used to reference the CCP in SOPs and audits.',
    `corrective_action_procedure` STRING COMMENT 'Standardized steps to take when a deviation from the critical limit occurs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CCP record was first created in the system.',
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
    `critical_control_point_name` STRING COMMENT 'Human‑readable name of the critical control point.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the CCP.',
    `process_step` STRING COMMENT 'Operational step in the food preparation flow where the CCP applies.. Valid values are `receiving|storage|preparation|cooking|cooling|serving`',
    `regulatory_reference` STRING COMMENT 'Applicable regulatory or certification reference (e.g., FDA FSMA, ISO 22000, ServSafe).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the critical limit values.. Valid values are `C|F|pH|minutes|seconds|hours`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CCP record.',
    `verification_frequency` STRING COMMENT 'How often the CCP is independently verified for compliance.. Valid values are `weekly|monthly|quarterly|annually`',
    `verification_method` STRING COMMENT 'Method used during verification (e.g., internal audit, third‑party audit).',
    CONSTRAINT pk_critical_control_point PRIMARY KEY(`critical_control_point_id`)
) COMMENT 'Defines each Critical Control Point (CCP) within a HACCP plan, including the hazard type (biological, chemical, physical), critical limits (min/max temperature, pH, time), monitoring method, corrective action procedure, and verification frequency. Each CCP is tied to a specific process step (e.g., cooking, cooling, receiving) and HACCP plan version.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` (
    `food_safety_audit_id` BIGINT COMMENT 'Surrogate primary key for the food safety audit record.',
    `employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: A food safety audit is conducted against a specific HACCP plan — this is the governing compliance document being evaluated. The existing denormalized string column `haccp_plan_version` confirms the in',
    `primary_food_employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the audit was conducted.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Food safety audits are performed on suppliers; linking audit to supplier enables audit‑by‑supplier reports required by regulatory compliance.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for the audit finding record.',
    `food_safety_audit_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_safety_audit. Business justification: Audit findings are recorded under a specific food safety audit; adding food_safety_audit_id links findings to their audit.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor accountable for corrective action.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the audit was performed.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Food safety audit findings frequently cite specific stock items (improper allergen storage, temperature abuse of specific ingredients). Linking audit_finding to stock_item enables corrective action tr',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the finding.. Valid values are `open|in_progress|closed|deferred|rejected`',
    `corrective_action` STRING COMMENT 'Prescribed action required to remediate the finding.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created in the system.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative of the violation or observation.',
    `due_date` DATE COMMENT 'Date by which the corrective action must be completed.',
    `finding_category` STRING COMMENT 'High‑level domain of the finding (e.g., HACCP, sanitation).. Valid values are `haccp|food_safety|sanitation|allergen|equipment|facility`',
    `finding_number` STRING COMMENT 'Human‑readable identifier assigned to the finding within the audit.',
    `finding_timestamp` TIMESTAMP COMMENT 'Date and time when the finding was recorded during the audit.',
    `has_attachment` BOOLEAN COMMENT 'Indicates whether supporting documentation (photos, files) is attached.',
    `regulatory_reference` STRING COMMENT 'Code or citation of the applicable regulation (e.g., FDA Food Code section).',
    `resolution_date` DATE COMMENT 'Date when the finding was closed or resolved.',
    `severity_level` STRING COMMENT 'Categorical severity classification of the finding.. Valid values are `critical|major|minor|informational`',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) representing the seriousness of the finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding or violation recorded during a food safety audit, capturing finding category (critical, major, minor), description, regulatory reference (FDA Food Code, local health code), corrective action required, responsible party, due date, and resolution status. Each finding is linked to a specific audit and restaurant unit.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` (
    `health_inspection_id` BIGINT COMMENT 'Unique surrogate key for the health inspection record.',
    `employee_id` BIGINT COMMENT 'System identifier for the inspector.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location inspected.',
    `agency_name` STRING COMMENT 'Name of the regulatory agency that performed the inspection.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates if supporting documents (photos, reports) are attached.',
    `closure_order_date` DATE COMMENT 'Date when the closure order was issued.',
    `closure_order_flag` BOOLEAN COMMENT 'Indicates if the inspection resulted in a closure order.',
    `compliance_code` STRING COMMENT 'Regulatory framework or code applicable to the inspection.. Valid values are `FSMA|HACCP|Local_Code`',
    `corrective_action_deadline` DATE COMMENT 'Date by which corrective actions must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates if corrective actions are required.',
    `corrective_action_status` STRING COMMENT 'Current status of required corrective actions.. Valid values are `pending|completed|not_applicable`',
    `fee_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the inspection fee.',
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
    `score` DECIMAL(18,2) COMMENT 'Numeric score representing compliance level (higher is better).',
    `violation_summary` STRING COMMENT 'Brief description of the violations identified.',
    `violations_count` STRING COMMENT 'Number of violations cited in the inspection.',
    CONSTRAINT pk_health_inspection PRIMARY KEY(`health_inspection_id`)
) COMMENT 'Header-and-line record of official health inspections conducted by local health departments or regulatory authorities at restaurant units, including inspection header (date, inspector, agency, type: routine/follow-up/complaint-driven, overall grade, permit status, closure orders) and individual violations as line items (violation code, severity: critical/non-critical, FDA Food Code citation, corrective action required, compliance deadline, re-inspection outcome). This is the authoritative regulatory inspection record distinct from internal food safety audits.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` (
    `inspection_violation_id` BIGINT COMMENT 'Unique identifier for the inspection violation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the inspector who recorded the violation.',
    `health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that generated this violation.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the violation was observed.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Health inspection violations routinely cite specific food items (expired product, improper temperature storage of specific ingredients). Linking inspection_violation to stock_item enables product-leve',
    `area_of_concern` STRING COMMENT 'Physical area within the restaurant where the violation occurred.. Valid values are `kitchen|storage|dining|restroom|outside`',
    `compliance_deadline` DATE COMMENT 'Date by which the corrective action must be completed to achieve compliance.',
    `corrective_action_required` BOOLEAN COMMENT 'Action that must be taken to remediate the violation.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `violation_code` STRING COMMENT 'Standardized code assigned to the violation by the regulatory authority.. Valid values are `^[A-Z0-9.-]+$`',
    `violation_description` STRING COMMENT 'Full textual description of the violation observed during the inspection.',
    `violation_reported_by` STRING COMMENT 'Full name of the inspector who reported the violation.',
    `violation_timestamp` TIMESTAMP COMMENT 'Exact date and time when the violation was observed.',
    `violation_type` STRING COMMENT 'Broad category describing the nature of the violation.. Valid values are `food|facility|equipment|hygiene|documentation`',
    CONSTRAINT pk_inspection_violation PRIMARY KEY(`inspection_violation_id`)
) COMMENT 'Individual violation cited during an official health inspection, including violation code, description, severity classification (critical, non-critical), regulatory citation (FDA Food Code section, local ordinance), corrective action required, compliance deadline, and re-inspection outcome. Supports regulatory compliance tracking and trend analysis.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` (
    `temperature_log_id` BIGINT COMMENT 'System-generated unique identifier for each temperature reading record.',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: Temperature readings are captured specifically to monitor compliance at Critical Control Points (CCPs) defined in the HACCP plan. The CCP record already defines `critical_limit_max` and `critical_limi',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Temperature readings taken during goods receiving must be associated with the specific receipt event for cold chain compliance verification. HACCP receiving CCPs require temperature logs linked to the',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: HACCP requires continuous temperature monitoring of specific ingredient lots in storage. Linking temperature logs to ingredient lots enables lot-level cold chain compliance tracking, expiration risk a',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manually entered the reading, if applicable.',
    `shift_id` BIGINT COMMENT 'Identifier of the workforce shift during which the reading was taken.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: HACCP temperature monitoring is performed on specific stock items (raw proteins, dairy, etc.). Linking temperature_log to stock_item enables CCP deviation reports by ingredient, supports food safety t',
    `stock_location_id` BIGINT COMMENT 'Identifier of the restaurant location or specific area (e.g., kitchen, dock) where the reading occurred.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier of the equipment or sensor that generated the temperature reading.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Temperature logs are recorded at specific kitchen stations (walk-in cooler, grill, prep). Station-level temperature compliance is a core HACCP CCP monitoring requirement. Enables station-specific temp',
    `audit_reference` STRING COMMENT 'Identifier linking the reading to a specific food safety audit or inspection.',
    `batch_number` STRING COMMENT 'Optional batch identifier grouping a set of readings for a specific audit period.',
    `calibration_date` DATE COMMENT 'Date when the sensor was last calibrated.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next sensor calibration.',
    `compliance_status` STRING COMMENT 'Result of compliance check for this reading against HACCP requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the temperature log record was initially created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the data quality assessment for the reading.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the temperature reading falls outside the defined critical limits.',
    `maintenance_due_date` DATE COMMENT 'Planned date for required maintenance activities.',
    `maintenance_required` BOOLEAN COMMENT 'Indicates whether the equipment requires maintenance based on the reading or schedule.',
    `monitoring_method` STRING COMMENT 'Method used to capture the temperature (manual probe or automated sensor).. Valid values are `manual|automated`',
    `notes` STRING COMMENT 'Free‑text field for additional observations or comments about the reading.',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the temperature measurement was taken at the monitoring point.',
    `reading_type` STRING COMMENT 'Category of the monitoring point where the temperature was recorded.. Valid values are `cooler|freezer|hot_holding|cooking|receiving`',
    `sensor_serial_number` STRING COMMENT 'Manufacturer serial number of the temperature sensor device.',
    `temperature_log_status` STRING COMMENT 'Current lifecycle status of the temperature log record.. Valid values are `active|archived`',
    `temperature_trend` STRING COMMENT 'Observed trend of temperature change relative to previous readings.. Valid values are `rising|falling|stable`',
    `temperature_value` DECIMAL(18,2) COMMENT 'Measured temperature value captured by the sensor or manual probe.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the temperature reading (Fahrenheit or Celsius).. Valid values are `F|C`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the temperature log record.',
    CONSTRAINT pk_temperature_log PRIMARY KEY(`temperature_log_id`)
) COMMENT 'Time-series log of temperature readings captured at critical monitoring points (walk-in coolers, freezers, hot-holding units, cooking equipment, receiving docks), including equipment ID, reading timestamp, measured temperature, unit of measure (°F/°C), critical limit thresholds, deviation flag, and monitoring method (manual probe, automated sensor). Core HACCP monitoring record per Principle 4.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` (
    `sanitation_schedule_id` BIGINT COMMENT 'Unique identifier for the sanitation schedule.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: A sanitation schedule is a core component of a HACCP plan — the Master Sanitation Schedule (MSS) is explicitly referenced in HACCP documentation. haccp_plan already has a denormalized `sanitation_sche',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Sanitation schedule assigns a specific employee; FK provides traceability for health inspections and internal audits.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Sanitation schedules assign cleaning tasks to specific positions (e.g., closing crew, prep cook). The existing responsible_role is a denormalized free-text position reference. Replacing it with a pr',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Sanitation schedules target specific kitchen stations (grill, prep, walk-in cooler). Station-level sanitation compliance tracking is a core HACCP operational requirement. Linking enables managers to v',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Sanitation schedules are unit-specific operational compliance documents. Restaurant managers and health inspectors pull all sanitation schedules per unit during inspections. No existing FK from sanita',
    `sop_document_id` BIGINT COMMENT 'Foreign key linking to foodsafety.sop_document. Business justification: sanitation_schedule has a denormalized `sop_reference` STRING column that is a text pointer to the governing SOP document. sop_document is the authoritative master record for SOPs in this domain. Repl',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Sanitation schedules are defined per storage area; the FK associates each schedule with its location.',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether the task includes allergen control measures.',
    `area` STRING COMMENT 'Physical area or zone where the task is performed (e.g., Front‑of‑House, Back‑of‑House).. Valid values are `FOH|BOH|Kitchen|Dining|Bar|Outdoor`',
    `audit_required_flag` BOOLEAN COMMENT 'Whether a post‑task audit is required.',
    `chemical_concentration` DECIMAL(18,2) COMMENT 'Required concentration of the chemical (e.g., "200 ppm").',
    `chemical_name` STRING COMMENT 'Name of the chemical or sanitizer used.',
    `cleaning_method` STRING COMMENT 'Method used to perform the cleaning (e.g., manual, automated, steam).',
    `compliance_status` STRING COMMENT 'Current compliance status of the task against food‑safety regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was created.',
    `sanitation_schedule_description` STRING COMMENT 'Detailed description of the schedule purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the schedule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the schedule expires or is superseded (nullable).',
    `equipment` STRING COMMENT 'Equipment, fixture, or asset the task applies to.',
    `frequency` STRING COMMENT 'Number of times the task occurs within the defined frequency unit.',
    `frequency_unit` STRING COMMENT 'Time unit for the task frequency.. Valid values are `hourly|daily|weekly|monthly|quarterly|annually`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the task is mandatory for compliance.',
    `last_performed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the task.',
    `next_due_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next required execution of the task.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `priority_level` STRING COMMENT 'Priority assigned to the task for scheduling and resource allocation.. Valid values are `low|medium|high|critical`',
    `sanitation_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|retired|draft`',
    `schedule_code` STRING COMMENT 'Business code used to reference the schedule.. Valid values are `^[A-Z0-9]{3,10}$`',
    `schedule_name` STRING COMMENT 'Human‑readable name of the schedule.',
    `task_name` STRING COMMENT 'Name of the specific cleaning or sanitizing task.',
    `temperature_requirement_celsius` DECIMAL(18,2) COMMENT 'Required temperature condition for the cleaning task, expressed in Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `version_number` STRING COMMENT 'Version number of the schedule for change management.',
    `waste_disposal_method` STRING COMMENT 'Method used to dispose of waste generated by the task (e.g., biohazard, recyclable).',
    CONSTRAINT pk_sanitation_schedule PRIMARY KEY(`sanitation_schedule_id`)
) COMMENT 'Master sanitation schedule (MSS) with execution log for each restaurant unit, including schedule template (task name, target area: FOH/BOH zone/equipment, frequency: hourly/daily/weekly, chemical/sanitizer, concentration requirements, responsible role, SOP reference) and task execution records (completion timestamp, employee, actual concentration measured, pass/fail, deviation notes). Managed via Zenput task management. Serves as both the authoritative sanitation template and the compliance evidence of task completion.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` (
    `sop_document_id` BIGINT COMMENT 'System-generated unique identifier for each SOP document record.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: SOPs in restaurants are authored for specific job positions (e.g., line cook, prep cook). Linking sop_document to position enables role-based SOP assignment, mandatory-SOP compliance tracking per posi',
    `unit_id` BIGINT COMMENT 'P2: Connect restaurant.sop_document by adding column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id. P2: connect_table: restaurant.sop_document** - add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - ',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: SOP documents are authored to satisfy specific brand standards. Compliance teams verify which brand standards each SOP addresses during audits. Linking enables brand standard compliance gap analysis —',
    `applicable_restaurant_format` STRING COMMENT 'Restaurant format(s) to which the SOP applies (e.g., Quick-Service Restaurant, casual, fine-dining).. Valid values are `QSR|casual|fine_dining`',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee that approved the SOP.',
    `attached_files_count` STRING COMMENT 'Number of supplemental files (e.g., checklists, diagrams) linked to the SOP.',
    `compliance_status` STRING COMMENT 'Result of the latest compliance audit against this SOP.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the SOP record was first created in the system.',
    `sop_document_description` STRING COMMENT 'Full textual description of the SOP purpose, scope, and key steps.',
    `distribution_scope` STRING COMMENT 'Scope of SOP distribution: global, regional, or specific to a site.. Valid values are `global|regional|site_specific`',
    `document_code` STRING COMMENT 'External business code or number used to reference the SOP document in franchise and compliance systems.',
    `document_url` STRING COMMENT 'Link to the stored SOP file in the document repository.',
    `effective_date` DATE COMMENT 'Date on which the SOP becomes operationally binding.',
    `expiration_date` DATE COMMENT 'Date after which the SOP is no longer valid; null if indefinite.',
    `file_type` STRING COMMENT 'File format of the SOP document.. Valid values are `pdf|docx|html|txt`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the SOP is mandatory (true) or advisory (false).',
    `language` STRING COMMENT 'Language in which the SOP is authored.. Valid values are `en|es|fr|de|zh`',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the SOP.',
    `next_review_date` DATE COMMENT 'Planned date for the next scheduled review.',
    `owner_name` STRING COMMENT 'Name of the person or role responsible for maintaining the SOP.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework or standard that mandates the SOP (e.g., FDA FSMA, OSHA safety).. Valid values are `FDA|USDA|OSHA|ISO_22000|ServSafe`',
    `revision_history` STRING COMMENT 'Chronological log of changes made to the SOP, stored as free‑text.',
    `sop_category` STRING COMMENT 'High‑level classification of the SOP content area.. Valid values are `Food_Safety|Sanitation|Allergen_Management|Equipment|Training`',
    `sop_document_status` STRING COMMENT 'Current lifecycle status of the SOP.. Valid values are `draft|active|inactive|retired|archived`',
    `title` STRING COMMENT 'Descriptive title of the SOP, e.g., "Handwashing Procedure".',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the SOP record.',
    `version_number` STRING COMMENT 'Incremental version of the SOP; higher numbers indicate newer revisions.',
    CONSTRAINT pk_sop_document PRIMARY KEY(`sop_document_id`)
) COMMENT 'Master record for each Standard Operating Procedure (SOP) governing food safety and operational compliance, including SOP title, version number, effective date, expiration date, applicable restaurant formats (QSR/casual/fine-dining), regulatory basis (FDA, USDA, OSHA), approval authority, and distribution scope. Managed and distributed via Zenput.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` (
    `illness_report_id` BIGINT COMMENT 'Unique identifier for the illness report record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported or is associated with the illness.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: When a guest reports a foodborne illness, health departments require identifying the affected individual. Linking illness_report to guest.profile enables contact tracing, follow-up communication, and ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Guest foodborne illness investigations require cross-referencing the affected guests loyalty order history to identify implicated menu items, visit timestamps, and exposure windows. This named proces',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Foodborne illness outbreak investigations must trace back to the specific ingredient lot implicated. This link replaces the free-text suspected_food_item with a proper FK to ingredient_lot, enabling l',
    `leave_request_id` BIGINT COMMENT 'Foreign key linking to workforce.leave_request. Business justification: FDA Food Code employee health policy mandates that illness exclusions trigger a formal leave request. Linking illness_report to leave_request enables the regulatory workflow: illness exclusion → leave',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the employee fell ill.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Foodborne illness investigations require tracing the suspected food item back to its inventory record (lot number, supplier, storage history). The existing suspected_food_item plain-text column is a',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Foodborne illness outbreak investigations require tracing illness reports to specific menu items for regulatory reporting, menu item risk assessment, and potential recall decisions. Replaces denormali',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: Outbreak investigation requires identifying the specific guest visit during which exposure occurred. Linking illness_report to guest_visit enables traceability of date, unit, daypart, and party size —',
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
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric score representing the severity of the reported illness.',
    `suspected_pathogen` STRING COMMENT 'Pathogen suspected to have caused the illness, if known.',
    `symptoms` STRING COMMENT 'Symptoms reported by the employee, captured for health analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the report record.',
    CONSTRAINT pk_illness_report PRIMARY KEY(`illness_report_id`)
) COMMENT 'Transactional record of a reported employee foodborne illness or suspected foodborne illness event at a restaurant unit, capturing report date, employee role, symptoms reported, onset date, suspected pathogen or food item, exclusion-from-work decision, return-to-work clearance date, and health department notification status. Supports FDA Food Code employee health policy compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_sop_document_id` FOREIGN KEY (`sop_document_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`sop_document`(`sop_document_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Restaurant Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_next_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|in_progress|failed|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `critical_control_points` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Points (CCPs)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'active|archived|superseded|draft|retired|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `hazard_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Summary');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|suspended|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Conformance Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Business Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'Restaurant|Franchise|Corporate|Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'FDA_FSMA|ISO_22000|ServSafe|Local_Health');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `sanitation_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point ID (CCP ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Ccp Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `average_deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Average Deviation Value (Avg Deviation)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_code` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Code (CCP Code)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure (CAP)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_business_glossary_term' = 'Status (CCP Status)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending_review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_max` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Maximum Value (Critical Limit Max)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_min` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Minimum Value (Critical Limit Min)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count (Number of Deviations)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (End Date)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (Start Date)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version (Plan Version)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type (Biological/Chemical/Physical)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'biological|chemical|physical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical (Critical Flag)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_monitored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Monitored Timestamp (Last Monitored At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp (Last Verified At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (Frequency)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'continuous|hourly|per_batch|daily|weekly|monthly');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method (Method)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Name (CCP Name)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (CCP Notes)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step (HACCP Process Step)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_value_regex' = 'receiving|storage|preparation|cooking|cooling|serving');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (Regulation)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'C|F|pH|minutes|seconds|hours');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency (Verification Frequency)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method (Verification Method)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `allergen_control_compliant` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Compliance (ALLERGEN_COMPLIANT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `attached_documents_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Count (DOC_COUNT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Date and Time (AUDIT_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|third_party|health_department');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name (AUDITOR_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (COMPLIANCE_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline (CORRECTIVE_DEADLINE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CORRECTIVE_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count (CRIT_FINDINGS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUDIT_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed|failed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `non_critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Critical Findings Count (NONCRIT_FINDINGS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes (AUDIT_NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Score (OVERALL_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result (PASS_FAIL)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|OSHA|Local_Health_Department');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `sanitation_schedule_compliant` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Compliance (SANITATION_COMPLIANT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `temperature_monitoring_compliant` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Compliance (TEMP_COMPLIANT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|deferred|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'haccp|food_safety|sanitation|allergen|equipment|facility');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `has_attachment` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|informational');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachments Present');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Issued');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `compliance_code` SET TAGS ('dbx_value_regex' = 'FSMA|HACCP|Local_Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Inspection Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fee Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (INS_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|closed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|follow_up|complaint|reinspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Full Name (INSPECTOR_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `overall_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Grade (GRADE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `overall_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F|NA');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `violations_count` SET TAGS ('dbx_business_glossary_term' = 'Violations Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Violation ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Area of Concern');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_value_regex' = 'kitchen|storage|dining|restroom|outside');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `evidence_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Photo URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|dismissed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `reinspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Outcome');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `reinspection_outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|pending|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity (SEVERITY)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|non-critical|minor');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code (CODE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]+$');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'food|facility|equipment|hygiene|documentation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_type_corrected' = 'BOOLEAN');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_required` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_value_regex' = 'cooler|freezer|hot_holding|cooking|receiving');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Sensor Serial Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_status` SET TAGS ('dbx_value_regex' = 'active|archived');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_trend` SET TAGS ('dbx_business_glossary_term' = 'Temperature Trend');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_trend` SET TAGS ('dbx_value_regex' = 'rising|falling|stable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_value` SET TAGS ('dbx_business_glossary_term' = 'Temperature Value');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'F|C');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Restaurant Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sop_document_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Document Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `area` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Area');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `area` SET TAGS ('dbx_value_regex' = 'FOH|BOH|Kitchen|Dining|Bar|Outdoor');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Sanitizer Concentration');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitizer Chemical Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `cleaning_method` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `equipment` SET TAGS ('dbx_business_glossary_term' = 'Equipment or Asset');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Task Frequency Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Task Frequency Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Task Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `last_performed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `next_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Due Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `temperature_requirement_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement (°C)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `applicable_restaurant_format` SET TAGS ('dbx_business_glossary_term' = 'Applicable Restaurant Format');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `applicable_restaurant_format` SET TAGS ('dbx_value_regex' = 'QSR|casual|fine_dining');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'SOP Approval Authority');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `attached_files_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Files Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'SOP Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SOP Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_description` SET TAGS ('dbx_business_glossary_term' = 'SOP Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'SOP Distribution Scope');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'global|regional|site_specific');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `document_code` SET TAGS ('dbx_business_glossary_term' = 'SOP Document Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'SOP Document URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `file_type` SET TAGS ('dbx_business_glossary_term' = 'SOP File Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `file_type` SET TAGS ('dbx_value_regex' = 'pdf|docx|html|txt');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'SOP Mandatory Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'SOP Language');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'SOP Owner Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'FDA|USDA|OSHA|ISO_22000|ServSafe');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'SOP Revision History');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_category` SET TAGS ('dbx_business_glossary_term' = 'SOP Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_category` SET TAGS ('dbx_value_regex' = 'Food_Safety|Sanitation|Allergen_Management|Equipment|Training');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_status` SET TAGS ('dbx_business_glossary_term' = 'SOP Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|archived');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'SOP Title');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SOP Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'SOP Version Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Identifier (IRID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (Restaurant ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (Shift ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Suspected Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_decision` SET TAGS ('dbx_business_glossary_term' = 'Exclusion From Work Decision');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Health Department Notification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_business_glossary_term' = 'Health Department Notification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|closed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Symptom Onset Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_method` SET TAGS ('dbx_business_glossary_term' = 'Report Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_method` SET TAGS ('dbx_value_regex' = 'self|manager|hr');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Number (IRN)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return To Work Clearance Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Illness Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Illness Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `suspected_pathogen` SET TAGS ('dbx_business_glossary_term' = 'Suspected Pathogen');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_business_glossary_term' = 'Reported Symptoms (PHI)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
