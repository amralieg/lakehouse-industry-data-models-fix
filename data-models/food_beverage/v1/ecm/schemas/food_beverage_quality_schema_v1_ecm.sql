-- Schema for Domain: quality | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`quality` COMMENT 'Owns food safety and quality assurance data including HACCP plans, critical control points (CCPs), sensory panels, organoleptic testing, microbiological testing (CFU counts), shelf life studies, non-conformances, CAPA, SQF/BRC/FSSC 22000 audit and certification records, inspection lots, and Veeva Vault QMS document control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`haccp_plan` (
    `haccp_plan_id` BIGINT COMMENT 'Primary key for haccp_plan',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Regulatory safety reports are organized per brand; associating each HACCP plan with its brand supports brand‑level safety documentation and audit trails.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: HACCP plans are required per registered facility; linking enables compliance reporting and audit traceability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: HACCP plan must be owned and approved by a Food Safety Manager (employee) per regulatory compliance process.',
    `acceptance_criteria` STRING COMMENT 'Pre‑defined criteria that must be met for validation to be successful.',
    `allergen_changeover_validation` BOOLEAN COMMENT 'Indicates whether allergen changeover cleaning validation has been performed.',
    `approval_status` STRING COMMENT 'Current approval state of the HACCP plan.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan was approved.',
    `approver_name` STRING COMMENT 'Name of the food‑safety professional who approved the plan.',
    `cleaning_validation_method` STRING COMMENT 'Methodology used for cleaning validation (e.g., CIP, visual inspection).',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence (percentage) associated with validation results.',
    `doc_control_number` STRING COMMENT 'Control number used for document management and version control.',
    `effective_end_date` DATE COMMENT 'Date when the HACCP plan expires or is superseded (nullable for open‑ended plans).',
    `effective_start_date` DATE COMMENT 'Date when the HACCP plan becomes effective.',
    `equipment_qualification_study` STRING COMMENT 'Reference to the equipment qualification (IQ/OQ/PQ) study linked to the plan.',
    `execution_end_date` DATE COMMENT 'Date when validation activities were completed.',
    `execution_start_date` DATE COMMENT 'Date when validation activities commenced.',
    `haccp_plan_status` STRING COMMENT 'Current lifecycle status of the HACCP plan.. Valid values are `draft|active|inactive|retired|pending`',
    `hazard_categories` STRING COMMENT 'Comma‑separated list of hazard categories addressed by the plan.. Valid values are `biological|chemical|physical|radiological`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `outcome` STRING COMMENT 'Result of the validation activity.. Valid values are `validated|failed`',
    `plan_number` STRING COMMENT 'Unique business identifier assigned to the HACCP plan (e.g., HACCP-2024-001).',
    `plan_type` STRING COMMENT 'Classification of the plan (e.g., product, facility, process).',
    `protocol_reference` STRING COMMENT 'Reference identifier for the validation protocol document.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the HACCP plan record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the HACCP plan record.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework(s) that drive the HACCP plan (e.g., FDA FSMA Preventive Controls).. Valid values are `FDA FSMA|USDA FSIS|Codex|EU Regulation|GFSI`',
    `revalidation_interval_days` STRING COMMENT 'Maximum number of days between required re‑validations.',
    `revalidation_trigger` STRING COMMENT 'Condition that initiates a re‑validation (e.g., product change, equipment upgrade).',
    `scope_description` STRING COMMENT 'Narrative description of the plans scope (products, processes, facilities covered).',
    `test_results_summary` STRING COMMENT 'High‑level summary of test outcomes and observations.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the HACCP plan record.',
    `validation_scope` STRING COMMENT 'Specific processes, equipment, or areas covered by the validation.',
    `validation_type` STRING COMMENT 'Category of validation associated with the plan.. Valid values are `process|cleaning|equipment|aseptic`',
    `version_number` STRING COMMENT 'Version identifier for the HACCP plan (e.g., v1.0, v2.1).',
    `created_by` STRING COMMENT 'User identifier of the person who created the HACCP plan record.',
    CONSTRAINT pk_haccp_plan PRIMARY KEY(`haccp_plan_id`)
) COMMENT 'Master record for Hazard Analysis and Critical Control Points (HACCP) plans per production facility and product category, including all associated process validation, cleaning validation, and equipment qualification studies. Captures plan version, scope, hazard categories (biological, chemical, physical, radiological), regulatory basis (FDA FSMA Preventive Controls, USDA FSIS HACCP, Codex Alimentarius), approval status, effective dates, and responsible food safety team. Includes validation records: validation type (process/thermal, cleaning/CIP, equipment IQ/OQ/PQ, aseptic), scope, protocol reference, execution dates, acceptance criteria, test results summary, statistical confidence level, outcome (validated/failed), revalidation trigger conditions, and approval authority. Covers allergen changeover cleaning validation. SSOT for HACCP program governance, preventive control validation, process/cleaning/equipment qualification, and food safety plan management across all manufacturing sites.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`critical_control_point` (
    `critical_control_point_id` BIGINT COMMENT 'Unique surrogate key for the critical control point record.',
    `asset_id` BIGINT COMMENT 'Identifier of the sensor that records the CCP measurement.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator responsible for monitoring this CCP.',
    `equipment_master_id` BIGINT COMMENT 'Identifier of equipment used to enforce or monitor the CCP.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: CCPs are defined for each registered plant; the FK supports regulatory mapping of critical limits to the establishment.',
    `haccp_plan_id` BIGINT COMMENT 'Reference to the parent HACCP plan that includes this CCP.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line where the CCP is applied.',
    `audit_status` STRING COMMENT 'Current status of the most recent audit of this CCP.. Valid values are `pending|completed|failed`',
    `audit_timestamp` TIMESTAMP COMMENT 'Date and time when the latest audit was performed.',
    `ccp_code` STRING COMMENT 'Business identifier code for the CCP, often used in documentation and labeling.',
    `compliance_status` STRING COMMENT 'Current compliance status of the CCP with regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `control_point_category` STRING COMMENT 'Broad category of the control point measurement.. Valid values are `temperature|ph|metal_detection|brix|water_activity|time`',
    `corrective_action_procedure` STRING COMMENT 'Standard operating procedure to follow when a deviation occurs.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the CCP record was created.',
    `critical_control_point_name` STRING COMMENT 'Descriptive name of the CCP, e.g., "Cooking Temperature Check".',
    `critical_control_point_status` STRING COMMENT 'Current lifecycle status of the CCP.. Valid values are `active|inactive|retired|pending`',
    `critical_limit_unit` STRING COMMENT 'Unit of measure associated with the critical limit value.. Valid values are `C|pH|%|seconds|µm`',
    `critical_limit_value` DECIMAL(18,2) COMMENT 'Numeric threshold that must not be exceeded (or must be met) for the hazard.',
    `data_source_system` STRING COMMENT 'Originating system for the CCP definition (e.g., MES, manual entry).',
    `deviation_trigger` STRING COMMENT 'Condition that triggers a deviation (e.g., "temperature > 75°C").',
    `effective_from` DATE COMMENT 'Date when the CCP becomes effective.',
    `effective_until` DATE COMMENT 'Date when the CCP is retired or superseded (nullable).',
    `escalation_path` STRING COMMENT 'Defined escalation steps and contacts when a deviation occurs.',
    `hazard_type` STRING COMMENT 'Category of hazard the CCP is designed to control.. Valid values are `biological|chemical|physical`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the CCP is considered a critical control point (true) or a monitoring point (false).',
    `last_measured_value` DECIMAL(18,2) COMMENT 'Numeric value recorded in the most recent observation.',
    `last_measurement_status` STRING COMMENT 'Result of the most recent observation (pass, fail, or out of range).. Valid values are `pass|fail|out_of_range`',
    `last_observed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent monitoring observation for this CCP.',
    `measurement_type` STRING COMMENT 'Specific type of measurement captured at the CCP.. Valid values are `temperature|ph|brix|water_activity|time|metal_detection`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measurement type.. Valid values are `C|pH|%|seconds|µm`',
    `monitoring_frequency_minutes` STRING COMMENT 'How often the CCP must be monitored, expressed in minutes.',
    `monitoring_method` STRING COMMENT 'Method used to monitor the CCP (e.g., sensor, manual check, lab test).',
    `notes` STRING COMMENT 'Free-text field for any supplemental information about the CCP.',
    `process_step` STRING COMMENT 'Specific manufacturing step or operation where the CCP is applied.',
    `regulatory_reference` STRING COMMENT 'Reference to applicable regulatory requirement (e.g., FSMA, GFSI).',
    `risk_level` STRING COMMENT 'Risk classification associated with the CCP.. Valid values are `low|medium|high`',
    `sampling_frequency_minutes` STRING COMMENT 'How often sampling is performed, expressed in minutes.',
    `sampling_method` STRING COMMENT 'Method used to obtain the sample for measurement (e.g., random, systematic).',
    `sampling_size` STRING COMMENT 'Number of units or volume taken for each sample.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Minimum acceptable value below the critical limit before a deviation is flagged.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable value above the critical limit before a deviation is flagged.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the CCP record.',
    `verification_activity` STRING COMMENT 'Periodic verification activity to ensure the CCP remains effective.',
    CONSTRAINT pk_critical_control_point PRIMARY KEY(`critical_control_point_id`)
) COMMENT 'Master entity defining each Critical Control Point (CCP) within a HACCP plan, plus all associated real-time monitoring observations recorded during production. Records the CCP number, process step, hazard type, critical limits (temperature, pH, Brix, water activity, time, metal detector sensitivity), monitoring method, monitoring frequency, corrective action procedure, verification activity, and responsible operator. Monitoring records capture each observation: batch/lot, timestamp, measured value, critical limit comparison, pass/fail result, operator ID, equipment/sensor ID, and deviation trigger with escalation path. Linked to the parent HACCP plan and specific production line. SSOT for CCP definition and all CCP monitoring data. Supports real-time food safety control and FSMA regulatory traceability.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the inspection.',
    `equipment_master_id` BIGINT COMMENT 'Identifier of the equipment or instrument used during inspection.',
    `facility_inspection_id` BIGINT COMMENT 'Foreign key linking to regulatory.facility_inspection. Business justification: Lot inspection results are part of a facility inspection report; linking enables traceability to inspection findings.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Required for Order Fulfillment Inspection Report: each inspection lot must be linked to the sales order it satisfies for traceability and compliance.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for the Lot Release Inspection Report to tie each inspection lot to the specific SKU for batch approval.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Failed inspection lots trigger corrective work orders; linking provides traceability from lot to maintenance action.',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier associated with the inspected material.',
    `control_chart_type` STRING COMMENT 'Type of statistical control chart used for SPC analysis.. Valid values are `x_bar|r_chart|s_chart|p_chart|np_chart`',
    `cp_value` DECIMAL(18,2) COMMENT 'Statistical Cp value indicating process capability for the inspected characteristic.',
    `cpk_value` DECIMAL(18,2) COMMENT 'Statistical Cpk value indicating process capability centered within specification limits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection lot record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date when the inspected lot expires or reaches end of shelf life.',
    `fda_approval_number` STRING COMMENT 'Identifier of FDA approval or notification linked to the inspected product.',
    `gfs_i_certified` BOOLEAN COMMENT 'Indicates whether the lot meets GFSI certification requirements.',
    `humidity_recorded` DECIMAL(18,2) COMMENT 'Relative humidity measured during inspection, expressed as a percentage.',
    `inspection_date` DATE COMMENT 'Calendar date when the inspection was performed.',
    `inspection_method` STRING COMMENT 'Method used to conduct the inspection (e.g., visual, laboratory, sensor, taste, microbial).. Valid values are `visual|lab|sensor|taste|microbial`',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection lot.. Valid values are `open|closed|released|rejected|hold`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Exact timestamp of the inspection event.',
    `inspection_type` STRING COMMENT 'Type of quality inspection performed (e.g., incoming, in‑process, final release).. Valid values are `incoming|in_process|final_release`',
    `lot_creation_date` DATE COMMENT 'Date when the material lot was originally created.',
    `lot_disposition` STRING COMMENT 'Final disposition of the lot after inspection.. Valid values are `released|rework|scrap|quarantine`',
    `lot_number` STRING COMMENT 'Business identifier assigned to the inspection lot by the manufacturing system.',
    `material_number` STRING COMMENT 'Identifier of the material or SKU being inspected.',
    `notes` STRING COMMENT 'Free‑text comments or observations recorded by the inspector.',
    `overall_result` STRING COMMENT 'Aggregated outcome of the inspection lot.. Valid values are `pass|fail|conditional`',
    `plant_code` STRING COMMENT 'Code of the production plant where the inspection took place.',
    `quantity_inspected` DECIMAL(18,2) COMMENT 'Total quantity of material inspected, expressed in the unit of measure.',
    `regulatory_compliance_status` STRING COMMENT 'Compliance status with applicable regulatory requirements (e.g., FDA, GFSI).. Valid values are `compliant|non_compliant|pending`',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Quantity of material represented by the sample.',
    `sample_size` STRING COMMENT 'Number of units sampled for inspection.',
    `sample_unit_of_measure` STRING COMMENT 'Unit of measure for the sampled quantity.. Valid values are `kg|g|lb|l|ml|units`',
    `sampling_plan` STRING COMMENT 'Reference to the sampling plan applied for this inspection.',
    `shelf_life_days` STRING COMMENT 'Calculated shelf life of the lot in days.',
    `specification_version` STRING COMMENT 'Version of the quality specification applied to this inspection.',
    `stock_posting_status` STRING COMMENT 'Result of the stock posting operation after inspection.. Valid values are `posted|not_posted|error`',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature measured during inspection, expressed in degrees Celsius.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the inspected quantity (e.g., kilograms, liters).. Valid values are `kg|g|lb|l|ml|units`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection lot record.',
    `usage_decision` STRING COMMENT 'Decision on whether the inspected material can be used, rejected, or held.. Valid values are `accept|reject|hold`',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'SAP QM-aligned entity representing quality inspection lots, their characteristic-level results, and statistical evaluations. Captures lot number, inspection type (incoming, in-process, final release), material/SKU, batch, plant, quantity, usage decision (accept/reject/hold), and stock posting outcome. Includes individual characteristic results: measured values (moisture, fat, pH, microbial count, organoleptic score), specification limits, valuation, inspection method, equipment used, and inspector. Supports statistical process control (SPC) with control charts, Cp/Cpk calculations, lot disposition decisions, and full quality inspection traceability across the supply chain. SSOT for all quality inspection events and measurements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`non_conformance` (
    `non_conformance_id` BIGINT COMMENT 'System-generated unique identifier for the non-conformance record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Non‑conformance source tracking needs the customer account that reported the issue; this supports the Non‑Conformance Root‑Cause Analysis process.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting of non‑conformance impacts requires allocating expense to a cost center for internal reporting.',
    `critical_control_point_id` BIGINT COMMENT 'Identifier of the Critical Control Point deviation linked to the event.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Link non_conformance to the inspection lot where the issue was discovered; enables proper relational traceability and removes redundant free‑text column.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing facility where the batch was produced.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Reportable NCRs can trigger changes to product registration status; the FK supports regulatory update workflows.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Root‑cause investigations must reference the exact production order that generated the defect for corrective action.',
    `production_shift_id` BIGINT COMMENT 'Identifier of the production shift during which the batch was manufactured.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Non‑Conformance Tracking during Promotional Periods links NC records to promotions to identify period‑specific issues.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: NCRs generated during R&D testing are tracked against the originating R&D project for corrective action planning.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: NCRs are logged by the employee who discovers the issue; required for root‑cause analysis and audit traceability.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Non‑conformance events discovered during shipment need to be tied to that shipment for root‑cause analysis and corrective action.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Non‑conformance incidents are tracked per SKU in the Non‑Conformance Management Process and regulatory reporting.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Root‑cause analysis and recall actions require linking each NCR to the specific stock position affected.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external or internal party associated with the source (e.g., supplier, customer, internal department).',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Each non‑conformance generates a maintenance work order to remediate equipment; linking ties root‑cause to corrective work.',
    `batch_expiration_date` DATE COMMENT 'Calculated expiration date for the batch based on shelf‑life.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number linked to the non-conformance.',
    `batch_production_date` DATE COMMENT 'Date on which the batch was manufactured.',
    `batch_quantity` STRING COMMENT 'Number of units produced in the batch linked to the non-conformance.',
    `complaint_category` STRING COMMENT 'Category of the consumer or customer complaint associated with the non-conformance. [ENUM-REF-CANDIDATE: safety|quality|labeling|packaging|taste|odor|appearance — promote to reference product]. Valid values are `safety|quality|labeling|packaging|taste|odor`',
    `complaint_channel` STRING COMMENT 'Channel through which the complaint was received.. Valid values are `call_center|retailer|social_media|direct_to_consumer|online|email`',
    `complaint_description` STRING COMMENT 'Free-text description of the issue reported by the customer or internal stakeholder.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of the corrective action plan.',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective actions defined to address the root cause.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation.. Valid values are `not_started|in_progress|completed|failed`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the cost impact amount.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the non-conformance (e.g., rework, scrap, recall costs).',
    `defect_type` STRING COMMENT 'Primary classification of the defect causing the non-conformance. [ENUM-REF-CANDIDATE: contamination|label_error|packaging|taste|appearance|foreign_body|microbial|chemical|physical|texture — promote to reference product]. Valid values are `contamination|label_error|packaging|taste|appearance|foreign_body`',
    `disposition_decision` STRING COMMENT 'Final action taken for the affected product.. Valid values are `release|rework|scrap|return_to_supplier|hold|destroy`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the non-conformance was first observed or recorded.',
    `hold_duration_days` STRING COMMENT 'Planned duration of the hold in days.',
    `hold_location` STRING COMMENT 'Warehouse or storage location where the product is held.',
    `hold_status` STRING COMMENT 'Current status of the hold action.. Valid values are `active|released|expired`',
    `hold_type` STRING COMMENT 'Type of containment action applied to the affected product.. Valid values are `quarantine|release_hold|rework_hold|destroy_hold|return_to_supplier`',
    `investigation_status` STRING COMMENT 'Current status of the root cause investigation.. Valid values are `open|in_progress|closed|escalated`',
    `ncr_number` STRING COMMENT 'Business identifier assigned to the non-conformance event, used for tracking and reporting.',
    `product_line` STRING COMMENT 'Higher‑level product family or line to which the affected SKU belongs.',
    `quality_metric_unit` STRING COMMENT 'Unit of measure for the quality metric value.. Valid values are `CFU|pH|Brix|%ABV`',
    `quality_metric_value` DECIMAL(18,2) COMMENT 'Measured value of the primary quality metric (e.g., CFU count, pH).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the non-conformance record was created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the non-conformance record.',
    `regulatory_report_type` STRING COMMENT 'Specific regulatory reporting mechanism applicable to the event.. Valid values are `FDA_MedWatch|USDA|Reportable_Food_Registry|None`',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether the event must be reported to a regulatory authority.',
    `resolution_status` STRING COMMENT 'Overall outcome status of the non-conformance handling process.. Valid values are `resolved|unresolved|pending|deferred`',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause. [ENUM-REF-CANDIDATE: process|material|equipment|human_error|supplier|design|environment|unknown — promote to reference product]. Valid values are `process|material|equipment|human_error|supplier|design`',
    `root_cause_detail` STRING COMMENT 'Detailed description of the identified root cause.',
    `severity_classification` STRING COMMENT 'Risk severity assigned to the non-conformance based on impact and likelihood.. Valid values are `critical|high|medium|low|informational`',
    `severity_score` STRING COMMENT 'Numeric severity rating (1‑5) where higher values indicate greater risk.',
    `source_type` STRING COMMENT 'Origin of the non-conformance event, indicating how it was detected.. Valid values are `in_process|supplier|customer_complaint|consumer_hotline|audit_finding|ccp_deviation`',
    CONSTRAINT pk_non_conformance PRIMARY KEY(`non_conformance_id`)
) COMMENT 'Master record for all quality non-conformance events (NCRs), customer/consumer complaints, and product hold/containment actions. Captures NCR number, source (in-process, supplier, customer complaint, consumer hotline, audit finding, CCP deviation), affected SKU/batch/lot, defect type, complaint details (category, channel — call center, retailer, social media, DTC — description, investigation status, resolution), severity classification, regulatory reportability (FDA MedWatch, USDA, Reportable Food Registry), hold/containment details (hold type, warehouse location, segregation status, hold duration, disposition authority), disposition decision (release, rework, scrap, return to supplier, hold, destroy), root cause category, and originating inspection lot or CCP deviation. SSOT for all quality failures, deviations, complaints, containment holds, and disposition actions across the enterprise.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT 'System-generated unique identifier for the Corrective and Preventive Action record.',
    `customer_complaint_id` BIGINT COMMENT 'Identifier of the customer complaint that initiated this CAPA, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal owner responsible for the CAPA.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: CAPA corrective‑action expenses are charged to a GL account to track corrective cost effectiveness.',
    `non_conformance_id` BIGINT COMMENT 'Identifier of the non‑conformance that triggered this CAPA, if applicable.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: CAPA records need to reference the R&D project they remediate, enabling project‑level effectiveness reporting.',
    `audit_finding_id` BIGINT COMMENT 'Identifier of the audit finding linked to this CAPA, if applicable.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: CAPA implementation often requires maintenance tasks; linking associates corrective actions with specific work orders.',
    `actual_completion_date` DATE COMMENT 'Date when the CAPA actions were actually completed.',
    `attached_document_count` STRING COMMENT 'Number of supporting documents attached to the CAPA record.',
    `capa_number` STRING COMMENT 'Business-visible CAPA reference number assigned by quality management (e.g., CAPA-2023-001).',
    `capa_status` STRING COMMENT 'Current lifecycle status of the CAPA.. Valid values are `open|in_progress|closed|on_hold|cancelled`',
    `capa_type` STRING COMMENT 'Indicates whether the record is a corrective action or a preventive action.. Valid values are `corrective|preventive`',
    `ccn_number` STRING COMMENT 'Identifier of the critical control point (CCP) related to the CAPA.',
    `closure_date` DATE COMMENT 'Date when the CAPA record was formally closed.',
    `comments` STRING COMMENT 'Additional free‑form comments or notes related to the CAPA.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action to be implemented.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was first created in the system.',
    `department` STRING COMMENT 'Business department responsible for the CAPA.. Valid values are `Quality|Manufacturing|Supply_Chain|Regulatory|R&D|Other`',
    `effectiveness_verification_method` STRING COMMENT 'Method used to verify that the CAPA was effective.. Valid values are `retest|audit|review|other`',
    `effectiveness_verification_result` STRING COMMENT 'Result of the effectiveness verification.. Valid values are `effective|ineffective|partial`',
    `is_closed` BOOLEAN COMMENT 'Indicates whether the CAPA record is closed (true) or still open (false).',
    `is_effective` BOOLEAN COMMENT 'Indicates whether the CAPA was determined to be effective (true) or not (false).',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the CAPA effectiveness and status.',
    `lot_number` STRING COMMENT 'Manufacturing lot number linked to the CAPA.',
    `owner_name` STRING COMMENT 'Full name of the employee owning the CAPA.',
    `preventive_action_description` STRING COMMENT 'Detailed description of the preventive action to avoid recurrence.',
    `priority` STRING COMMENT 'Priority for execution of the CAPA actions.. Valid values are `high|medium|low`',
    `product_code` STRING COMMENT 'Code of the product associated with the CAPA, if applicable.',
    `regulatory_reference` STRING COMMENT 'Regulatory framework or standard that the CAPA addresses (e.g., FDA, GFSI, ISO 22000).',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score representing the risk level associated with the issue, used for prioritization.',
    `root_cause_description` STRING COMMENT 'Narrative description of the identified root cause.',
    `root_cause_method` STRING COMMENT 'Methodology used to determine the root cause (e.g., 5-Why, Fishbone).. Valid values are `5_why|fishbone|fault_tree|pareto|other`',
    `severity` STRING COMMENT 'Severity level assigned to the issue addressed by the CAPA.. Valid values are `critical|high|medium|low|minor`',
    `target_completion_date` DATE COMMENT 'Planned date by which the CAPA actions should be completed.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the corrective or preventive action.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CAPA record.',
    `verification_date` DATE COMMENT 'Date when the effectiveness verification was performed.',
    `verification_responsible` STRING COMMENT 'Name of the person who performed the effectiveness verification.',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) master record linked to non-conformances, audit findings, customer complaints, or CCP deviations. Captures CAPA number, type (corrective/preventive), root cause analysis method (5-Why, Fishbone), root cause description, corrective actions defined, preventive actions defined, responsible owner, target completion date, actual completion date, effectiveness verification method, and closure status. Managed within Veeva Vault QMS.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`micro_test_result` (
    `micro_test_result_id` BIGINT COMMENT 'Unique identifier for the microbiological test result record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Microbiological test results must be attributed to the lab analyst for compliance reporting and corrective action.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Micro‑test results are generated on lab equipment that is a maintained asset; linking supports asset maintenance planning.',
    `equipment_master_id` BIGINT COMMENT 'Identifier of the equipment used for the analysis.',
    `lab_id` BIGINT COMMENT 'Identifier of the laboratory that performed the test.',
    `sample_id` BIGINT COMMENT 'Unique identifier for the physical sample that was tested.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Microbial test results for a batch are required for each shipment to meet regulatory compliance and quality release.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Microbial test results must be linked to SKU for the Microbial Testing Compliance Report required by FDA.',
    `accreditation_status` STRING COMMENT 'Indicates whether the laboratory is accredited for the test method.. Valid values are `accredited|non_accredited`',
    `analysis_date` DATE COMMENT 'Date the laboratory completed the analysis.',
    `analyst_name` STRING COMMENT 'Name of the laboratory analyst who performed the test.',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier for the sample.',
    `chain_of_custody` STRING COMMENT 'Record of custody transfers for the sample from collection to analysis.',
    `collection_date` DATE COMMENT 'Date the sample was collected from the source.',
    `collection_location` STRING COMMENT 'Facility, line, or site where the sample was obtained.',
    `collection_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the sample was taken, including time zone.',
    `control_sample_type` STRING COMMENT 'Type of control sample used (positive, negative, or blank).. Valid values are `positive|negative|blank`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result record was first created in the system.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Analytical detection limit for the test method.',
    `detection_limit_unit` STRING COMMENT 'Unit of measure for the detection limit.. Valid values are `CFU_per_g|CFU_per_ml`',
    `incubation_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the sample was incubated.',
    `incubation_time_hours` DECIMAL(18,2) COMMENT 'Duration of incubation for the test.',
    `is_control_sample` BOOLEAN COMMENT 'True if the sample is a quality control (positive/negative) sample.',
    `lot_number` STRING COMMENT 'Lot or batch number assigned to the material at production.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the analyst.',
    `pass_fail` STRING COMMENT 'Overall pass/fail determination based on result criteria.. Valid values are `pass|fail`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the test result meets applicable regulatory criteria (e.g., FSMA limits).',
    `result_interpretation` STRING COMMENT 'Narrative interpretation of the test outcome by the analyst.',
    `result_reported_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result was officially reported to the requesting party.',
    `result_unit` STRING COMMENT 'Unit of measure for the result value.. Valid values are `CFU_per_g|CFU_per_ml|presence_absence`',
    `result_value` DECIMAL(18,2) COMMENT 'Quantitative test outcome (e.g., CFU count).',
    `sample_condition` STRING COMMENT 'Physical condition of the sample at collection.. Valid values are `frozen|refrigerated|room_temp`',
    `sample_source` STRING COMMENT 'Origin of the sample (e.g., supplier, in‑house production, field collection).. Valid values are `supplier|in_house|field`',
    `sample_type` STRING COMMENT 'Category of the sample (e.g., raw material, work‑in‑process, finished goods, environmental swab, water).. Valid values are `raw_material|wip|finished_goods|environmental_swab|water`',
    `shelf_life_days` STRING COMMENT 'Calculated shelf‑life in days based on the microbiological result.',
    `target_organism` STRING COMMENT 'Microbial organism or indicator targeted by the test.. Valid values are `Salmonella|Listeria|E_coli_O157_H7|TPC|Yeast_Mold`',
    `test_method` STRING COMMENT 'Standard analytical method used for the microbiological test.. Valid values are `AOAC|ISO|USDA_FSIS`',
    `test_status` STRING COMMENT 'Current processing status of the test.. Valid values are `pending|completed|failed|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test result record.',
    CONSTRAINT pk_micro_test_result PRIMARY KEY(`micro_test_result_id`)
) COMMENT 'Transactional record for microbiological testing including sample tracking and laboratory results. Covers sample registration (source, SKU/material, lot/batch, collection point, chain of custody, lab assignment, test panel requested) and test results (test method per AOAC/ISO/USDA FSIS, target organism — Salmonella, Listeria, E. coli O157:H7, TPC, Yeast & Mold — CFU count or presence/absence, detection limit, incubation conditions, lab accreditation, pass/fail). Applies to raw materials, WIP, finished goods, environmental swabs, and water samples. Critical for FSMA Preventive Controls and HACCP verification. SSOT for all microbiological sample-to-result tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`sensory_panel` (
    `sensory_panel_id` BIGINT COMMENT 'Unique system-generated identifier for the sensory evaluation panel.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the panel leader/coordinator.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing or testing facility where the panel took place.',
    `rd_sensory_panel_id` BIGINT COMMENT 'Foreign key linking to research.rd_sensory_panel. Business justification: Cross‑domain sensory panels require traceability from quality panel to the originating R&D sensory panel for consistency checks.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Sensory panel data is tied to SKU for the Sensory Evaluation Report used in product development decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the panel data was approved for analysis.',
    `attribute_list` STRING COMMENT 'Comma‑separated list of sensory attributes evaluated (e.g., appearance, aroma, flavor).',
    `audit_status` STRING COMMENT 'Internal audit outcome for the panel.. Valid values are `passed|failed|in_review`',
    `average_overall_score` DECIMAL(18,2) COMMENT 'Mean overall sensory score across panelists.',
    `batch_number` STRING COMMENT 'Manufacturing batch number of the product sample.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the panel data.. Valid values are `compliant|non_compliant|pending`',
    `confidence_interval` DECIMAL(18,2) COMMENT 'Confidence interval percentage for overall scores.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the panel record was first created.',
    `data_collection_method` STRING COMMENT 'Method used to capture panelist scores.. Valid values are `paper|electronic|tablet`',
    `expiration_date` DATE COMMENT 'Shelf‑life expiration date of the product sample.',
    `lot_number` STRING COMMENT 'Lot number associated with the product sample.',
    `manufacturing_date` DATE COMMENT 'Date the product batch was manufactured.',
    `median_score` DECIMAL(18,2) COMMENT 'Median overall sensory score.',
    `notes` STRING COMMENT 'Additional free‑form observations or comments.',
    `overall_status` STRING COMMENT 'Current lifecycle status of the panel.. Valid values are `planned|in_progress|completed|cancelled`',
    `panel_date` DATE COMMENT 'Calendar date on which the panel was conducted.',
    `panel_end_time` TIMESTAMP COMMENT 'Exact end time of the sensory evaluation session.',
    `panel_leader_name` STRING COMMENT 'Full name of the panel leader.',
    `panel_name` STRING COMMENT 'Human‑readable name or title for the sensory panel.',
    `panel_start_time` TIMESTAMP COMMENT 'Exact start time of the sensory evaluation session.',
    `panel_type` STRING COMMENT 'Type of sensory test performed.. Valid values are `descriptive|hedonic|discrimination|triangle|consumer`',
    `panelist_count` STRING COMMENT 'Number of panelists who participated.',
    `panelist_data_source` STRING COMMENT 'Origin of panelist participants.. Valid values are `internal|external|contractor`',
    `product_gtin` STRING COMMENT 'GTIN of the evaluated product.',
    `product_upc` STRING COMMENT 'UPC barcode of the evaluated product.',
    `protocol_version` STRING COMMENT 'Version identifier of the sensory evaluation protocol used.',
    `regulatory_body` STRING COMMENT 'Regulatory authority governing the panels compliance.. Valid values are `FDA|USDA|EFSA|GFSI`',
    `scoring_scale` STRING COMMENT 'Scale used for scoring (e.g., 1‑9 hedonic).',
    `sensory_degradation_trend` STRING COMMENT 'Observed trend in sensory quality over shelf life.. Valid values are `improving|stable|degrading`',
    `shelf_life_day` STRING COMMENT 'Number of days from manufacturing to expiration for the sampled product.',
    `standard_deviation` DECIMAL(18,2) COMMENT 'Standard deviation of overall scores.',
    `statistical_method` STRING COMMENT 'Statistical analysis method applied to panel results.. Valid values are `ANOVA|t-test|nonparametric|chi_square|regression`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the panel record.',
    CONSTRAINT pk_sensory_panel PRIMARY KEY(`sensory_panel_id`)
) COMMENT 'Master record for sensory evaluation panels including panel configuration and all individual panelist scoring data. Captures panel type (descriptive, hedonic, discrimination, triangle test, consumer), product/SKU evaluated, panel date, panelist roster, evaluation protocol, sensory attributes assessed (appearance, aroma, flavor, texture, mouthfeel, aftertaste, overall acceptability), scoring scale, and panel leader. Includes panelist-level scores: attribute name, score value, hedonic scale, confidence interval, and qualitative comments. Enables statistical analysis of organoleptic quality, shelf life sensory degradation, NPD sensory benchmarking, and gold standard maintenance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` (
    `shelf_life_study_id` BIGINT COMMENT 'System-generated unique identifier for the shelf life study record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Shelf‑life studies underpin brand marketing of product freshness; associating studies with brand enables brand‑level shelf‑life claim validation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Shelf‑life studies are conducted and signed off by a quality scientist (employee) to meet shelf‑life specification requirements.',
    `formulation_version_id` BIGINT COMMENT 'Foreign key linking to research.formulation_version. Business justification: Shelf‑life studies are performed on specific formulation versions; linking provides data for product release decisions.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Shelf‑life study expenses are posted to a GL account for product lifecycle cost analysis.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Shelf‑life study results are required for product registration dossiers; linking ensures compliance documentation.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Shelf‑life study results are linked to SKU for the Shelf‑Life Validation Study supporting label shelf‑life claims.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Shelf life studies evaluate the stability of a product as defined by its specification.',
    `assay_method` STRING COMMENT 'Analytical method used for each measurement (e.g., pH meter, HPLC, sensory panel).',
    `batch_number` STRING COMMENT 'Identifier of the production batch used for the study.',
    `compliance_standard` STRING COMMENT 'Regulatory or certification framework governing the study (e.g., FDA, GFSI).. Valid values are `FDA|USDA|GFSI|ISO22000|FSSC22000`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the shelf life study record was first created in the system.',
    `data_source` STRING COMMENT 'Originating operational system (e.g., SAP QM, Veeva Vault QMS) that supplied the study data.',
    `degradation_model` STRING COMMENT 'Mathematical model selected to describe product degradation over time.. Valid values are `q10|arrhenius|linear|exponential`',
    `evaluation_schedule` STRING COMMENT 'Narrative schedule describing planned evaluation days (e.g., "Day 0, 30, 60, 90").',
    `evaluator_name` STRING COMMENT 'Name of the person or lab responsible for conducting the evaluations.',
    `evaluator_role` STRING COMMENT 'Job role or function of the evaluator (e.g., Quality Engineer, Microbiologist).',
    `gtin` STRING COMMENT 'Global identifier for the product, may be 14‑digit GTIN‑14.',
    `humidity_acceleration_factor` DECIMAL(18,2) COMMENT 'Factor used to model the effect of humidity on product degradation.',
    `lab_location` STRING COMMENT 'Physical location or facility where the study measurements are performed.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of raw material or finished product.',
    `notes` STRING COMMENT 'Additional free‑form observations or comments captured during the study.',
    `packaging_format` STRING COMMENT 'Description of the packaging type (e.g., bottle, pouch, can).',
    `q10_value` DECIMAL(18,2) COMMENT 'Temperature coefficient indicating rate increase per 10 °C rise, used for accelerated studies.',
    `shelf_life_study_description` STRING COMMENT 'Free‑text description of the study purpose, design, and scope.',
    `shelf_life_study_status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity level maintained during the study.',
    `storage_light_exposure` STRING COMMENT 'Light exposure condition for the product during storage.. Valid values are `dark|ambient|direct`',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Controlled storage temperature in degrees Celsius for the study.',
    `study_end_date` DATE COMMENT 'Calendar date when the shelf life study concluded or was terminated.',
    `study_name` STRING COMMENT 'Descriptive name given to the shelf life study for easy identification.',
    `study_start_date` DATE COMMENT 'Calendar date when the shelf life study commenced.',
    `study_type` STRING COMMENT 'Indicates whether the study is real‑time, accelerated, or based on the Arrhenius model.. Valid values are `real_time|accelerated|arrhenius`',
    `target_shelf_life_days` STRING COMMENT 'Targeted shelf life duration in days that the study aims to validate.',
    `temperature_acceleration_factor` DECIMAL(18,2) COMMENT 'Factor applied to adjust real‑time data to accelerated temperature conditions.',
    `upc` STRING COMMENT '12‑digit barcode number associated with the product.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the study record.',
    CONSTRAINT pk_shelf_life_study PRIMARY KEY(`shelf_life_study_id`)
) COMMENT 'Master record for shelf life and accelerated shelf life testing (ASLT) studies including all time-point measurements and degradation trend analysis. Captures study type (real-time, accelerated, Arrhenius model), SKU, storage conditions (temperature, humidity, light exposure), packaging format, target shelf life, and evaluation schedule. Includes time-point results: evaluation day, quality parameter measured (pH, Brix, water activity, microbial count, sensory score, color delta-E, viscosity), measured value, specification limit, pass/fail status, and evaluator. Enables Q10 modeling, degradation kinetics, label date coding decisions, and FEFO inventory management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` (
    `food_safety_audit_id` BIGINT COMMENT 'System-generated unique identifier for the food safety audit record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Food safety audit results are reported per brand for compliance dashboards and consumer trust communications.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_center. Business justification: Food‑safety audits are performed on distribution centers; linking audit to the DC records audit scope and results.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Food safety audits are conducted on registered establishments; the FK ties audit outcomes to the registration record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Food‑safety audit fees are allocated to a GL account to reflect audit expense in financial reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each food safety audit is led by a designated auditor (employee); required for audit reports and corrective actions.',
    `plant_id` BIGINT COMMENT 'Identifier of the production or distribution facility being audited.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first entered into the system.',
    `audit_end_date` DATE COMMENT 'Date when the audit fieldwork concluded.',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit (e.g., internal audit reference).',
    `audit_start_date` DATE COMMENT 'Date when the audit fieldwork began.',
    `audit_title` STRING COMMENT 'Human‑readable title or name of the audit.',
    `audit_type` STRING COMMENT 'Classification of the audit (internal, external, or regulatory).. Valid values are `internal|external|regulatory`',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `auditing_body` STRING COMMENT 'Organization that performed the audit (e.g., SGS, Bureau Veritas).',
    `certificate_expiry_date` DATE COMMENT 'Date on which the certification expires.',
    `certificate_number` STRING COMMENT 'Unique identifier of the issued certification document.',
    `certification_outcome` STRING COMMENT 'Result of the audit regarding certification status.. Valid values are `certified|non_certified|conditional`',
    `certification_scheme` STRING COMMENT 'Food safety certification scheme applied to the audit (e.g., SQF, BRC).. Valid values are `SQF|BRC|FSSC22000|ISO22000|GFSI`',
    `closure_status` STRING COMMENT 'Overall status of corrective action closure for the audit.. Valid values are `open|closed|in_progress`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of required corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether any corrective actions are required.',
    `document_library_path` STRING COMMENT 'File system or DMS path to the audit’s supporting documents.',
    `document_version` STRING COMMENT 'Version identifier of the audit documentation.',
    `finding_count` STRING COMMENT 'Total number of findings recorded for the audit.',
    `food_safety_audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `planned|in_progress|completed|closed`',
    `lead_auditor_name` STRING COMMENT 'Full name of the primary auditor responsible for the audit.',
    `major_non_conformance_count` STRING COMMENT 'Count of major non‑conformances identified.',
    `minor_non_conformance_count` STRING COMMENT 'Count of minor non‑conformances identified.',
    `next_audit_due_date` DATE COMMENT 'Planned date for the subsequent audit cycle.',
    `observation_count` STRING COMMENT 'Number of observations (non‑conformances) recorded.',
    `opportunity_for_improvement_count` STRING COMMENT 'Number of OFI (Opportunity for Improvement) findings.',
    `overall_grade` STRING COMMENT 'Letter grade assigned to the audit based on performance.. Valid values are `A|B|C|D|E|F`',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score representing overall audit performance (e.g., 0‑100).',
    `owner_department` STRING COMMENT 'Business department responsible for the audit record.',
    `risk_level` STRING COMMENT 'Overall risk rating derived from audit findings.. Valid values are `high|medium|low`',
    `scope_description` STRING COMMENT 'Narrative description of the audit scope (sites, processes, products).',
    `training_required_flag` BOOLEAN COMMENT 'Indicates if personnel training is required as a result of audit findings.',
    CONSTRAINT pk_food_safety_audit PRIMARY KEY(`food_safety_audit_id`)
) COMMENT 'Master record for food safety and quality system audits (SQF, BRC, FSSC 22000, ISO 22000, GFSI-benchmarked schemes, internal audits, regulatory inspections), all findings, and the QMS controlled document library. Captures audit ID, type, certification scheme, auditing body, facility, date range, lead auditor, scope, overall grade, certification outcome, certificate number/expiry, and next audit due date. Includes finding-level detail: finding type (major NC, minor NC, observation, OFI), clause reference, description, risk level, required corrective action, response due date, and closure status. Manages QMS controlled documents: document ID, type (SOP, work instruction, form, policy, specification, HACCP plan, validation protocol), title, version, effective/expiry dates, owner, approval workflow, training requirement flag, and applicable sites. SSOT for audit management, certification status, GFSI scheme compliance, and QMS document governance per ISO 9001 Clause 7.5.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`specification` (
    `specification_id` BIGINT COMMENT 'Primary key for specification',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Specifications must be approved by a qualified employee (e.g., Quality Manager) to ensure regulatory compliance.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand managers need direct access to product specifications for compliance checks and marketing claim substantiation; linking specification to brand enables brand‑level spec dashboards.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Product specifications must reference SKU to ensure each SKU meets its defined quality specification.',
    `approved_by` STRING COMMENT 'Name of the person or system that approved the specification.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification was approved.',
    `audit_status` STRING COMMENT 'Result of the most recent compliance audit for this specification.. Valid values are `passed|failed|pending|exempt`',
    `brix_percent` DECIMAL(18,2) COMMENT 'Target sugar content expressed as degrees Brix.',
    `change_reason` STRING COMMENT 'Narrative reason for the most recent revision.',
    `color` STRING COMMENT 'Standardized color designation for the product. [ENUM-REF-CANDIDATE: red|green|blue|yellow|white|black|other — 7 candidates stripped; promote to reference product]',
    `compliance_standard` STRING COMMENT 'Food safety or quality standard to which the specification adheres.. Valid values are `GFSI|SQF|BRC|FSSC22000|ISO22000`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created.',
    `effective_date` DATE COMMENT 'Date on which the specification becomes effective.',
    `expiration_date` DATE COMMENT 'Date on which the specification expires, if applicable.',
    `fat_percent` DECIMAL(18,2) COMMENT 'Maximum allowable fat content as a percentage of total weight.',
    `height_cm` DECIMAL(18,2) COMMENT 'Target height dimension in centimeters.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the specification is considered critical for product safety or regulatory compliance.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit performed on the specification.',
    `length_cm` DECIMAL(18,2) COMMENT 'Target length dimension in centimeters.',
    `listeria_cfu_g` DECIMAL(18,2) COMMENT 'Maximum allowable Listeria monocytogenes colony forming units per gram.',
    `moisture_percent` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content as a percentage of total weight.',
    `organoleptic_score` STRING COMMENT 'Numeric score (1‑10) representing sensory evaluation results.',
    `packaging_type` STRING COMMENT 'Standard packaging format for the product.. Valid values are `bottle|can|box|pouch|bag|tray`',
    `ph` DECIMAL(18,2) COMMENT 'Target pH (acidity) of the product.',
    `protein_percent` DECIMAL(18,2) COMMENT 'Minimum required protein content as a percentage of total weight.',
    `revision_number` STRING COMMENT 'Sequential revision number for change tracking.',
    `salmonella_cfu_g` DECIMAL(18,2) COMMENT 'Maximum allowable Salmonella colony forming units per gram.',
    `sensory_panel_method` STRING COMMENT 'Methodology used for organoleptic testing.. Valid values are `triangle|duo-trio|ranking|hedonic`',
    `shelf_life_days` STRING COMMENT 'Maximum allowable shelf life in days under specified storage conditions.',
    `sodium_mg_per_kg` DECIMAL(18,2) COMMENT 'Maximum allowable sodium concentration in milligrams per kilogram.',
    `spec_type` STRING COMMENT 'Category of the specification (finished product, raw material, packaging, work‑in‑process).. Valid values are `finished_product|raw_material|packaging|wip`',
    `specification_code` STRING COMMENT 'Business-visible code uniquely identifying the specification within the organization.. Valid values are `SPEC-[A-Z0-9]{6}`',
    `specification_description` STRING COMMENT 'Free‑form description of the specification purpose and scope.',
    `specification_name` STRING COMMENT 'Human‑readable name of the specification.',
    `specification_status` STRING COMMENT 'Current lifecycle status of the specification.. Valid values are `active|inactive|draft|retired|pending_approval`',
    `storage_condition` STRING COMMENT 'Recommended storage condition for the product.. Valid values are `ambient|refrigerated|frozen|controlled_atmosphere`',
    `tpc_cfu_g` DECIMAL(18,2) COMMENT 'Maximum total aerobic plate count per gram.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `version` STRING COMMENT 'Version identifier of the specification, following semantic versioning.. Valid values are `vd+.d+`',
    `weight_kg` DECIMAL(18,2) COMMENT 'Target weight of the product or component in kilograms.',
    `width_cm` DECIMAL(18,2) COMMENT 'Target width dimension in centimeters.',
    `created_by` STRING COMMENT 'User or system that created the specification record.',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Master record defining quality specifications for finished goods, raw materials, packaging, and WIP. Managed via TraceGains and SAP QM. Captures specification ID, material/SKU, specification type (finished product, raw material, packaging), version, effective date, physical parameters (weight, dimensions, color), chemical parameters (pH, Brix, moisture, fat, protein, sodium), microbiological limits (TPC, Salmonella, Listeria), organoleptic standards, and approval status. SSOT for quality acceptance criteria.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` (
    `allergen_matrix_id` BIGINT COMMENT 'Primary key for allergen_matrix',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Allergen declarations are brand‑specific for labeling and marketing claims; linking matrix to brand supports clean‑label and allergen claim compliance.',
    `formulation_id` BIGINT COMMENT 'Reference to the formulation record that defines the ingredient blend for the SKU.',
    `production_line_id` BIGINT COMMENT 'Identifier of the manufacturing line where the product is produced.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Allergen matrix defines allergen profile for SKUs; linking to specification centralizes product quality attributes.',
    `allergen_celery` STRING COMMENT 'Indicates presence of celery or celery extracts.. Valid values are `present|may_contain|absent`',
    `allergen_control_measures` STRING COMMENT 'Textual description of controls (e.g., dedicated equipment, cleaning procedures) used to mitigate allergen risk.',
    `allergen_egg` STRING COMMENT 'Indicates presence of egg proteins.. Valid values are `present|may_contain|absent`',
    `allergen_fish` STRING COMMENT 'Indicates presence of finned fish allergens.. Valid values are `present|may_contain|absent`',
    `allergen_lupin` STRING COMMENT 'Indicates presence of lupin protein.. Valid values are `present|may_contain|absent`',
    `allergen_matrix_status` STRING COMMENT 'Current lifecycle status of the allergen matrix record.. Valid values are `active|inactive|retired|draft`',
    `allergen_milk` STRING COMMENT 'Indicates presence of milk proteins.. Valid values are `present|may_contain|absent`',
    `allergen_mollusk` STRING COMMENT 'Indicates presence of mollusk allergens (e.g., clams, mussels).. Valid values are `present|may_contain|absent`',
    `allergen_mustard` STRING COMMENT 'Indicates presence of mustard seeds or derivatives.. Valid values are `present|may_contain|absent`',
    `allergen_peanut` STRING COMMENT 'Indicates if peanuts are present, may be present, or absent in the product.. Valid values are `present|may_contain|absent`',
    `allergen_sesame` STRING COMMENT 'Indicates presence of sesame seeds or oil.. Valid values are `present|may_contain|absent`',
    `allergen_shellfish` STRING COMMENT 'Indicates presence of crustacean or mollusk shellfish allergens.. Valid values are `present|may_contain|absent`',
    `allergen_soy` STRING COMMENT 'Indicates presence of soy proteins.. Valid values are `present|may_contain|absent`',
    `allergen_sulfites` STRING COMMENT 'Indicates presence of sulfite additives above regulatory thresholds.. Valid values are `present|may_contain|absent`',
    `allergen_tree_nut` STRING COMMENT 'Status of tree nut allergens (e.g., almond, walnut) in the product.. Valid values are `present|may_contain|absent`',
    `allergen_wheat` STRING COMMENT 'Indicates presence of wheat gluten.. Valid values are `present|may_contain|absent`',
    `cleaning_validation_date` DATE COMMENT 'Date when the most recent cleaning validation was performed.',
    `cleaning_validation_notes` STRING COMMENT 'Free‑form notes from the cleaning validation activity.',
    `cleaning_validation_status` STRING COMMENT 'Current status of cleaning validation for allergen control.. Valid values are `validated|pending|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the allergen matrix record was first created.',
    `cross_contact_risk` STRING COMMENT 'Assessed risk of allergen cross‑contact during manufacturing.. Valid values are `low|medium|high`',
    `effective_date` DATE COMMENT 'Date from which the allergen matrix is considered valid for labeling and production.',
    `expiration_date` DATE COMMENT 'Date after which the allergen matrix is no longer valid; null if indefinite.',
    `gtin` STRING COMMENT '14‑digit global identifier for the product.. Valid values are `^d{14}$`',
    `label_declaration_required` BOOLEAN COMMENT 'Indicates whether the allergen must be declared on the consumer label.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the allergen matrix.',
    `matrix_type` STRING COMMENT 'Indicates whether the matrix follows the standard regulatory template or a custom internal version.. Valid values are `standard|custom`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) summarizing overall allergen risk for the SKU.',
    `sku` STRING COMMENT 'Unique SKU code that identifies the finished product.. Valid values are `^[A-Z0-9]{8,12}$`',
    `upc` STRING COMMENT '12‑digit barcode used for retail scanning and inventory.. Valid values are `^d{12}$`',
    `version_number` STRING COMMENT 'Sequential version of the allergen matrix for change management.',
    CONSTRAINT pk_allergen_matrix PRIMARY KEY(`allergen_matrix_id`)
) COMMENT 'Master record defining the allergen profile for each SKU, formulation, and production line. Captures the 14 major allergens (FDA Big 9 + EU 14) present, may-contain declarations, cross-contact risk assessment, allergen control measures in place, cleaning validation status, and label declaration requirements. Critical for regulatory compliance (FDA FALCPA, EU 1169/2011), consumer safety, and co-packing/toll manufacturing risk management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`customer_complaint` (
    `customer_complaint_id` BIGINT COMMENT 'System generated unique identifier for each complaint record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for Complaint Management Report: each complaint must be tied to the originating customer account for liability and service tracking.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Complaints are analyzed per brand to drive brand reputation metrics and corrective actions; a brand FK provides the necessary aggregation.',
    `contact_id` BIGINT COMMENT 'Unique identifier of the complainant (if known) linking to the customer master.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Customer complaints are assigned to a responsible employee for investigation and resolution, tracked in complaint handling reports.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Customer Complaint Traceability: linking complaint to the original sales order enables root‑cause analysis, warranty handling, and service recovery.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Promotion Impact & Complaint Correlation report links complaints to specific promotion events to assess promotion‑driven quality issues.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Customer complaints are linked to SKU for the Complaint Resolution Process and regulatory reporting.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number associated with the complained product.',
    `closure_date` DATE COMMENT 'Date when the complaint was formally closed.',
    `complainant_address` STRING COMMENT 'Mailing address of the complainant, used for regulatory follow‑up if required.',
    `complainant_email` STRING COMMENT 'Primary email address of the complainant for follow‑up communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `complainant_name` STRING COMMENT 'Full legal name of the individual or organization submitting the complaint.',
    `complainant_phone` STRING COMMENT 'Contact phone number of the complainant.',
    `complainant_type` STRING COMMENT 'Indicates whether the complainant is a consumer, trade partner, or internal stakeholder.. Valid values are `consumer|trade|internal`',
    `complaint_category` STRING COMMENT 'Standard classification of the complaint type.. Valid values are `foreign_material|off_flavor|packaging_defect|illness|labeling_error|other`',
    `complaint_number` STRING COMMENT 'Business identifier assigned to the complaint, used for tracking and communication.. Valid values are `^CC[0-9]{8}$`',
    `complaint_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was received or logged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the financial impact amount.',
    `customer_complaint_description` STRING COMMENT 'Detailed narrative provided by the complainant describing the issue.',
    `customer_complaint_status` STRING COMMENT 'Current lifecycle status of the complaint.. Valid values are `open|investigating|resolved|closed|rejected`',
    `expected_resolution_date` DATE COMMENT 'Target date for resolving the complaint as set during investigation.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary impact associated with the complaint (e.g., refunds, warranty costs).',
    `investigation_status` STRING COMMENT 'Current status of the internal investigation into the complaint.. Valid values are `not_started|in_progress|completed`',
    `product_upc` STRING COMMENT 'Universal Product Code of the product linked to the complaint.',
    `regulatory_agency` STRING COMMENT 'Regulatory body to which the complaint is reportable, if any.. Valid values are `FDA|USDA|EFSA|none`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the complaint must be reported to a regulatory agency (e.g., FDA MedWatch, USDA).',
    `resolution_action` STRING COMMENT 'Action taken to resolve the complaint (e.g., product recall, reformulation, packaging change).',
    `root_cause` STRING COMMENT 'Identified root cause of the issue after investigation.',
    `severity` STRING COMMENT 'Severity level assigned to the complaint based on impact and risk.. Valid values are `low|medium|high|critical`',
    `source_channel` STRING COMMENT 'Channel through which the complaint was received.. Valid values are `call_center|retailer|social_media|direct|email`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the complaint record.',
    CONSTRAINT pk_customer_complaint PRIMARY KEY(`customer_complaint_id`)
) COMMENT 'Transactional record for consumer and trade customer quality complaints received through all channels (call center, retailer, social media, DTC). Captures complaint ID, complaint source, product/SKU, batch/lot number, complaint category (foreign material, off-flavor, packaging defect, illness, labeling error), complaint description, severity, regulatory reportability flag (FDA MedWatch, USDA), investigation status, root cause, resolution action, and closure date. Supports FSMA reportable food registry obligations.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`product_recall` (
    `product_recall_id` BIGINT COMMENT 'System-generated unique identifier for each product recall event.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Recall investigations and communications are executed at the brand level; linking recalls to brand enables brand‑centric recall reporting and KPI tracking.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_center. Business justification: Recalls are executed per distribution center; linking recall to DC supports regulatory reporting and execution tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Recall financial loss is posted to a specific GL account for regulatory and management reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Recall initiation is performed by a designated employee (e.g., Recall Coordinator) to satisfy FDA/USDA recall procedures.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Recall records need a direct SKU link for the Recall Management Process to identify affected products.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Product recall events are associated with a specific product specification.',
    `affected_lot_codes` STRING COMMENT 'Comma‑separated list of lot or batch codes subject to the recall.',
    `affected_sku_codes` STRING COMMENT 'Comma‑separated list of SKU identifiers impacted by the recall.',
    `audit_report_reference` STRING COMMENT 'Identifier of the internal audit report linked to the recall.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the recall with regulatory requirements.. Valid values are `Compliant|NonCompliant|Pending`',
    `corrective_action_plan` STRING COMMENT 'Planned actions to prevent recurrence of the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary loss amount.',
    `distribution_scope` STRING COMMENT 'Geographic scope of the recall distribution.. Valid values are `Nationwide|Regional|International|Local`',
    `fda_notification_date` DATE COMMENT 'Date the FDA was notified of the recall.',
    `initiating_party_name` STRING COMMENT 'Name of the party (e.g., manufacturer, regulator) that triggered the recall.',
    `is_voluntary` BOOLEAN COMMENT 'True if the recall was initiated voluntarily by the company.',
    `monetary_loss_amount` DECIMAL(18,2) COMMENT 'Estimated financial loss associated with the recall, excluding recovered inventory.',
    `press_release_issued` BOOLEAN COMMENT 'Indicates whether a public press release was issued for the recall.',
    `product_recovery_quantity` BIGINT COMMENT 'Number of units successfully recovered from the market.',
    `quantity_affected` BIGINT COMMENT 'Total number of units (e.g., cases, bottles) affected by the recall.',
    `recall_classification` STRING COMMENT 'Broad classification of the recall purpose.. Valid values are `Safety|Quality|Labeling`',
    `recall_closure_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall was officially closed.',
    `recall_initiation_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall was formally initiated.',
    `recall_number` STRING COMMENT 'External reference number assigned to the recall by the company or regulator.',
    `recall_reason` STRING COMMENT 'Primary cause prompting the recall.. Valid values are `Microbial|Allergen|Foreign Material|Labeling|Regulatory|Other`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event.. Valid values are `Initiated|InProgress|Closed|Cancelled`',
    `recall_type` STRING COMMENT 'Classification of the recall according to FDA definitions or voluntary withdrawal.. Valid values are `Class I|Class II|Class III|Voluntary`',
    `retailer_notification_status` STRING COMMENT 'Current status of retailer notifications regarding the recall.. Valid values are `Notified|Pending|Completed`',
    `risk_level` STRING COMMENT 'Assessed risk level of the recall based on severity and exposure.. Valid values are `High|Medium|Low`',
    `root_cause_analysis` STRING COMMENT 'Narrative description of the root cause investigation findings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the recall record.',
    `usda_notification_date` DATE COMMENT 'Date the USDA was notified of the recall (if applicable).',
    CONSTRAINT pk_product_recall PRIMARY KEY(`product_recall_id`)
) COMMENT 'Master record for product recall and withdrawal events. Captures recall ID, recall type (Class I, II, III per FDA / voluntary withdrawal), triggering event (micro failure, allergen mislabel, foreign material, regulatory action), affected SKUs, affected lot/date codes, quantity affected, distribution scope, recall initiation date, FDA/USDA notification date, press release issued flag, retailer notification status, product recovery quantity, and recall closure date. SSOT for recall management and regulatory reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`qms_document` (
    `qms_document_id` BIGINT COMMENT 'Unique surrogate key for each QMS document record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: QMS document management costs are posted to a GL account for expense tracking and compliance audit.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: QMS documents have an owner employee responsible for maintenance and training, required for document control audits.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: QMS documents (e.g., SOPs) linked to specific R&D projects support compliance and knowledge management.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: QMS documents often pertain to a specific product specification.',
    `applicable_sites` STRING COMMENT 'Comma‑separated list of plant or site codes where the document applies.',
    `approval_date` DATE COMMENT 'Date when the document was approved.',
    `approval_status` STRING COMMENT 'Current status of the approval workflow.. Valid values are `approved|rejected|pending|revoked`',
    `approver` STRING COMMENT 'Name of the individual who approved the document.',
    `checksum` STRING COMMENT 'Hash value (e.g., SHA‑256) for file integrity verification.',
    `confidentiality_level` STRING COMMENT 'Data classification of the document per corporate policy.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `document_category` STRING COMMENT 'High‑level business domain the document belongs to.. Valid values are `Quality|Safety|Compliance|Process|Product|Training`',
    `document_number` STRING COMMENT 'Business identifier assigned to the document (e.g., SOP-001, HACCP-2023).',
    `document_subtype` STRING COMMENT 'Optional finer classification of the document (e.g., SOP – Production, SOP – Packaging).',
    `document_type` STRING COMMENT 'Category of the QMS document. [ENUM-REF-CANDIDATE: Validation Protocol — promote to reference product]. Valid values are `SOP|Work Instruction|Form|Policy|Specification|HACCP Plan`',
    `effective_date` DATE COMMENT 'Date on which the document becomes effective for the organization.',
    `expiry_date` DATE COMMENT 'Date after which the document is no longer valid; may be null for indefinite documents.',
    `file_format` STRING COMMENT 'Electronic file format of the document.. Valid values are `pdf|docx|xlsx|pptx|txt`',
    `file_path` STRING COMMENT 'Storage location or URL of the electronic document.',
    `file_size_bytes` BIGINT COMMENT 'Size of the electronic file in bytes.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `owner` STRING COMMENT 'Name of the person or function responsible for the document.',
    `owner_department` STRING COMMENT 'Organizational department that owns the document.',
    `qms_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `draft|active|inactive|archived|pending_approval`',
    `regulatory_compliance` STRING COMMENT 'Regulatory framework(s) the document satisfies.. Valid values are `FDA|USDA|EFSA|GFSI|ISO22000|ISO9001`',
    `review_date` DATE COMMENT 'Scheduled date for the next periodic review of the document.',
    `revision_number` STRING COMMENT 'Sequential revision count for the document.',
    `title` STRING COMMENT 'Human‑readable title of the QMS document.',
    `training_completed` BOOLEAN COMMENT 'Indicates whether required training has been completed.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel must be trained on this document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Version identifier following the companys versioning scheme (e.g., 1.0, 2.1.3).',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_qms_document PRIMARY KEY(`qms_document_id`)
) COMMENT 'Master record for quality management system (QMS) controlled documents managed in Veeva Vault. Captures document ID, document type (SOP, work instruction, form, policy, specification, HACCP plan, validation protocol), title, version number, effective date, expiry/review date, document owner, approval workflow status, training requirement flag, and applicable sites. SSOT for QMS document control and version management per ISO 9001 Clause 7.5 and GFSI scheme requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` (
    `supplier_quality_assessment_id` BIGINT COMMENT 'System-generated unique identifier for each supplier quality assessment record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supplier assessments are performed by a qualified employee (assessor) whose identity is needed for audit trails.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supplier assessment costs are allocated to a cost center for budgeting and performance measurement.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Supplier quality assessments are performed against product specifications.',
    `supplier_esg_score_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_score. Business justification: Supplier Quality Assessment incorporates ESG scores; the assessment workflow uses the supplier_esg_score to evaluate environmental and social performance alongside quality metrics.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier being assessed.',
    `approved_supplier_list_status` STRING COMMENT 'Current status of the supplier on the companys Approved Supplier List.. Valid values are `approved|pending|rejected`',
    `assessment_date` DATE COMMENT 'Date the assessment was performed or officially recorded.',
    `assessment_notes` STRING COMMENT 'Free‑form comments and observations recorded during the assessment.',
    `assessment_number` STRING COMMENT 'External reference number assigned to the assessment for tracking and communication with suppliers.',
    `assessment_outcome` STRING COMMENT 'Result of the assessment indicating overall compliance.. Valid values are `pass|fail|conditional`',
    `assessment_type` STRING COMMENT 'Method used to conduct the supplier quality assessment.. Valid values are `questionnaire|on_site_audit|desk_review|certificate_review`',
    `assessor_name` STRING COMMENT 'Name of the quality professional who performed the assessment.',
    `audit_report_reference` STRING COMMENT 'Document identifier for the detailed audit report linked to this assessment.',
    `brc_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds a valid BRC certification.',
    `brix_value` DECIMAL(18,2) COMMENT 'Sugar content measurement of the sample expressed in degrees Brix.',
    `cap_action_implemented` BOOLEAN COMMENT 'Indicates whether identified corrective and preventive actions have been completed.',
    `certification_status` STRING COMMENT 'Current certification status of the supplier under relevant schemes.. Valid values are `certified|not_certified|pending`',
    `cfu_count` STRING COMMENT 'Microbiological count (CFU) observed in sampled material.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the supplier meets all required compliance criteria.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for implementing any required corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the assessment identified issues that need corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `data_source_system` STRING COMMENT 'Source system where the assessment data originated.. Valid values are `TraceGains|SAP|Oracle|Salesforce`',
    `document_control_number` STRING COMMENT 'Reference number for the quality management document linked to this assessment.',
    `food_safety_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting the suppliers food‑safety performance.',
    `fssc_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds a valid FSSC 22000 certification.',
    `last_reviewed_by` STRING COMMENT 'Name of the quality manager who performed the final review of the assessment.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the final review was completed.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier associated with the sampled material.',
    `material_category` STRING COMMENT 'Category of the material or ingredient supplied (e.g., raw ingredient, packaging, finished good).',
    `non_conformance_count` STRING COMMENT 'Number of distinct non‑conformances identified during the assessment.',
    `overall_score` DECIMAL(18,2) COMMENT 'Weighted aggregate of food safety, quality, and compliance scores.',
    `ph_value` DECIMAL(18,2) COMMENT 'Measured acidity/alkalinity of the sample.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting overall product quality performance of the supplier.',
    `reassessment_due_date` DATE COMMENT 'Date by which the supplier must be re‑assessed to maintain approval.',
    `regulated_product_flag` BOOLEAN COMMENT 'Indicates whether the assessed material is subject to specific regulatory controls.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework(s) governing the assessment criteria.. Valid values are `FDA|USDA|EFSA|GFSI|ISO22000|ISO9001`',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the supplier based on assessment outcomes.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of samples taken for laboratory testing.',
    `sampling_method` STRING COMMENT 'Method used to select samples for testing during the assessment.. Valid values are `random|risk_based|full`',
    `shelf_life_days` STRING COMMENT 'Estimated shelf life of the material in days based on assessment.',
    `sqf_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds a valid SQF certification.',
    `supplier_quality_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `draft|in_progress|completed|rejected`',
    `supplier_rating` STRING COMMENT 'Overall rating assigned to the supplier based on assessment results.. Valid values are `A|B|C|D`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assessment record.',
    CONSTRAINT pk_supplier_quality_assessment PRIMARY KEY(`supplier_quality_assessment_id`)
) COMMENT 'Transactional record for supplier quality evaluations and approved supplier assessments conducted by the quality team. Captures assessment ID, supplier, material/ingredient category, assessment type (questionnaire, on-site audit, desk review, third-party certificate review), assessment date, SQF/BRC/FSSC 22000 certification status, food safety score, quality score, approved supplier list (ASL) status, risk tier, and re-assessment due date. Supports TraceGains supplier compliance management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`process_validation` (
    `process_validation_id` BIGINT COMMENT 'System-generated unique identifier for the process validation record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Process validation results require sign‑off by an approval authority employee to satisfy GMP and regulatory validation records.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Process validation activities generate costs that must be recorded in a GL account for compliance budgeting.',
    `plant_id` BIGINT COMMENT 'FK to manufacturing.plant',
    `sku_id` BIGINT COMMENT 'Identifier of the product to which the validation applies.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Process validation studies validate manufacturing processes for a product defined by its specification.',
    `acceptance_criteria` STRING COMMENT 'Pre‑defined criteria that must be met for validation to be accepted.',
    `allergen_changeover_validation` BOOLEAN COMMENT 'Indicates whether the validation includes allergen changeover verification.',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee approving the validation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the validation was formally approved.',
    `batch_number` STRING COMMENT 'Batch identifier when validation is scoped to a specific production batch.',
    `cleaning_validation_method` STRING COMMENT 'Method used for cleaning validation (e.g., visual, swab, chemical, microbiological).',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence (percentage) associated with the validation results.',
    `doc_control_number` STRING COMMENT 'Reference number linking to the controlled QMS document.',
    `equipment_qualification_study` STRING COMMENT 'Reference to the equipment qualification study associated with this validation.',
    `execution_end_date` DATE COMMENT 'Date when validation activities were completed.',
    `execution_start_date` DATE COMMENT 'Date when validation activities commenced.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the validation record.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the validation.',
    `outcome` STRING COMMENT 'Result of the validation: validated, failed, or conditionally validated.. Valid values are `validated|failed|conditionally_validated`',
    `process_validation_status` STRING COMMENT 'Current lifecycle status of the validation record.. Valid values are `pending|in_progress|validated|failed|revalidation_needed|retired`',
    `protocol_reference` STRING COMMENT 'Reference to the detailed validation protocol document.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the validation record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the validation record.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework or standard that drives the validation requirements.. Valid values are `FDA|GFSI|USDA|EFSA|ISO22000|FSSC22000`',
    `revalidation_interval_days` STRING COMMENT 'Maximum number of days between required revalidations.',
    `revalidation_trigger` STRING COMMENT 'Condition or event that initiates a revalidation (e.g., product change, equipment upgrade).',
    `risk_level` STRING COMMENT 'Risk classification associated with the validation.. Valid values are `low|medium|high`',
    `scope_description` STRING COMMENT 'Narrative describing the scope (product, line, equipment) covered by the validation.',
    `test_results_summary` STRING COMMENT 'Concise summary of test outcomes and observations.',
    `updated_by` STRING COMMENT 'User identifier who last modified the validation record.',
    `validation_code` STRING COMMENT 'Business identifier or code assigned to the validation (e.g., PV‑2023‑001).',
    `validation_name` STRING COMMENT 'Human‑readable name of the validation study.',
    `validation_scope` STRING COMMENT 'High‑level scope indicator (product, line, equipment).',
    `validation_type` STRING COMMENT 'Category of validation performed: process, cleaning/CIP, equipment, thermal, or aseptic.. Valid values are `process|cleaning|equipment|thermal|aseptic`',
    `validation_version` STRING COMMENT 'Version number of the validation protocol or study.',
    `created_by` STRING COMMENT 'User identifier who initially created the validation record.',
    CONSTRAINT pk_process_validation PRIMARY KEY(`process_validation_id`)
) COMMENT 'Master record for process validation, cleaning validation, and equipment qualification studies at manufacturing facilities. Captures validation type (process, cleaning/CIP, equipment, thermal process, aseptic), scope (product, line, equipment), protocol reference, execution dates, acceptance criteria, test results summary, statistical confidence level, outcome (validated/failed), revalidation trigger conditions, and approval authority. Includes cleaning validation for allergen changeover verification. Critical for GMP compliance, HACCP verification, and GFSI scheme requirements (SQF 2.5, BRC 6.1).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for each environmental monitoring sample record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Environmental monitoring expenses are tracked against a cost center for compliance cost reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality analyst who performed or reviewed the test.',
    `laboratory_id` BIGINT COMMENT 'Identifier of the laboratory where the sample was analyzed.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental sample was collected at the facility.',
    `corrective_action_triggered` BOOLEAN COMMENT 'Indicates whether the test result initiated a corrective action according to the EMP SOP.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Lowest concentration of the target that the method can reliably detect, expressed in the same units as result_quantity.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity at the time of sample collection, expressed as a percentage.',
    `location_description` STRING COMMENT 'Free‑text description of the exact location within the zone where the sample was collected.',
    `method_used` STRING COMMENT 'Analytical method employed for the test (e.g., PCR, culture, ATP luminometer).. Valid values are `PCR|Culture|ATP Luminometer`',
    `notes` STRING COMMENT 'Free‑text field for any additional observations, comments, or deviations noted by the analyst.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the environmental monitoring record was first entered into the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the environmental monitoring record.',
    `result_flag` STRING COMMENT 'Qualitative outcome of the test indicating presence (positive) or absence (negative) of the target organism.. Valid values are `positive|negative`',
    `result_quantity` DECIMAL(18,2) COMMENT 'Numeric result of the test (e.g., CFU per cm²) when a quantitative measurement is applicable.',
    `sample_type` STRING COMMENT 'Physical form of the sample collected (e.g., swab, air, surface rinse, water).. Valid values are `swab|air|surface|water`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature at the time of sample collection, recorded in degrees Celsius.',
    `test_target` STRING COMMENT 'Microbiological or hygiene target analyzed for the sample (e.g., Listeria spp., Listeria monocytogenes, ATP, Aerobic Plate Count).. Valid values are `Listeria spp.|Listeria monocytogenes|ATP|APC`',
    `trend_status` STRING COMMENT 'Trend classification based on historical results for the same zone and target.. Valid values are `improving|stable|deteriorating|new_issue`',
    `zone` STRING COMMENT 'Designated zone of the facility where the sample was taken (Zone 1 food contact, Zone 2 near food contact, Zone 3 non‑food contact, Zone 4 remote).. Valid values are `zone1|zone2|zone3|zone4`',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Transactional record for environmental monitoring program (EMP) samples collected across production facilities. Captures sample ID, sample zone (Zone 1 food contact, Zone 2 near food contact, Zone 3 non-food contact, Zone 4 remote), sample location, collection date, test target (Listeria spp., Listeria monocytogenes, ATP, APC), result (positive/negative, CFU/cm²), corrective action triggered flag, and trend status. Supports FSMA Preventive Controls environmental monitoring requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`hold_record` (
    `hold_record_id` BIGINT COMMENT 'System-generated unique identifier for the hold record.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_center. Business justification: Inventory holds are managed at specific distribution centers; linking hold_record to the DC enables inventory visibility and recall coordination.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Holding inventory incurs cost; linking to a cost center enables accurate inventory holding cost accounting.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order Hold Management: holds are often placed on specific sales orders pending quality investigation; linking provides order status and financial impact visibility.',
    `employee_id` BIGINT COMMENT 'System identifier of the person who created the hold.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality hold records must reference SKU to manage inventory holds per specific product SKU.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Hold management process needs to tie a hold record to the exact stock position being quarantined for traceability and release decisions.',
    `attached_document_count` STRING COMMENT 'Number of supporting documents (e.g., lab reports, audit findings) attached to the hold record.',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the held material.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the held material.. Valid values are `compliant|non_compliant|pending_review`',
    `disposition_decision` STRING COMMENT 'Final action taken on the held material (release, rework, destroy, return to supplier, or quarantine).. Valid values are `release|rework|destroy|return_to_supplier|quarantine`',
    `disposition_reason` STRING COMMENT 'Explanation for the chosen disposition action.',
    `disposition_timestamp` TIMESTAMP COMMENT 'Date‑time when the disposition decision was executed.',
    `hold_creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `hold_expiration_date` DATE COMMENT 'Date on which the hold is scheduled to be automatically released if no disposition occurs.',
    `hold_initiated_by` STRING COMMENT 'Name of the person who created the hold record.',
    `hold_initiated_department` STRING COMMENT 'Business department that originated the hold request.. Valid values are `quality|production|procurement|logistics`',
    `hold_initiation_timestamp` TIMESTAMP COMMENT 'Date‑time when the hold was placed.',
    `hold_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    `hold_number` STRING COMMENT 'Human‑readable identifier assigned to the hold transaction.',
    `hold_reason` STRING COMMENT 'Free‑text description explaining why the hold was initiated.',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold (e.g., active, released, rework, destroyed, pending, closed).. Valid values are `active|released|rework|destroyed|pending|closed`',
    `hold_type` STRING COMMENT 'Classification of the hold reason (quality, microbiological, allergen, regulatory, or customer complaint).. Valid values are `quality|micro|allergen|regulatory|customer_complaint`',
    `is_fefo_compliant` BOOLEAN COMMENT 'Indicates whether the hold respects First‑Expired‑First‑Out inventory rules.',
    `is_fifo_compliant` BOOLEAN COMMENT 'Indicates whether the hold respects First‑In‑First‑Out inventory rules.',
    `lot_number` STRING COMMENT 'Lot identifier for the batch of material placed on hold.',
    `material_upc` STRING COMMENT 'Universal Product Code of the material, 12‑digit numeric identifier.. Valid values are `^[0-9]{12}$`',
    `notes` STRING COMMENT 'Additional free‑text comments or observations related to the hold.',
    `quality_manager_name` STRING COMMENT 'Full name of the quality manager who authorized the hold.',
    `quantity_held` DECIMAL(18,2) COMMENT 'Amount of material placed on hold, expressed in the selected unit of measure.',
    `regulatory_reference_number` STRING COMMENT 'Reference number from FDA, USDA, or other regulator linked to the hold.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the held quantity (e.g., kilogram, gram, pound, unit, case, liter).. Valid values are `kg|g|lb|unit|case|liter`',
    `warehouse_location_code` STRING COMMENT 'Identifier of the warehouse or storage location where the hold is physically applied.',
    CONSTRAINT pk_hold_record PRIMARY KEY(`hold_record_id`)
) COMMENT 'Transactional record for product holds (quality, micro, allergen, regulatory, customer complaint) placed on finished goods, WIP, or raw materials pending quality disposition. Captures hold type, affected material/SKU, lot/batch, quantity, hold initiation date, reason, warehouse location, disposition decision (release, rework, destroy, return to supplier), disposition date, and authorizing quality manager. Integrates with warehouse management for physical segregation and supports FIFO/FEFO inventory management, lot traceability, and regulatory containment requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` (
    `certificate_of_analysis_id` BIGINT COMMENT 'Primary key for certificate_of_analysis',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: COA must record the analyst employee who performed the test for traceability and compliance reporting.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: COA documents are part of the product registration compliance package; linking enables regulatory review of test results.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: COA documents are tied to SKU for regulatory compliance and traceability of material specifications.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Certificate of Analysis records test results for a lot; linking to specification ties the CoA to the product specification.',
    `alcohol_by_volume` DECIMAL(18,2) COMMENT 'Alcohol content expressed as a percentage of volume.',
    `allergen_presence` STRING COMMENT 'Indicates whether declared allergens were detected.. Valid values are `present|absent|not_tested`',
    `analyst_name` STRING COMMENT 'Name of the laboratory analyst who performed the test.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the CoA was formally approved.',
    `approver_name` STRING COMMENT 'Name of the person who approved the CoA.',
    `batch_number` STRING COMMENT 'Batch identifier associated with the lot.',
    `brix` DECIMAL(18,2) COMMENT 'Sugar content expressed in degrees Brix.',
    `certificate_of_analysis_status` STRING COMMENT 'Current lifecycle state of the CoA record.. Valid values are `draft|issued|approved|revoked`',
    `coa_number` STRING COMMENT 'Human‑readable identifier assigned to the CoA by the issuing entity.',
    `coa_type` STRING COMMENT 'Classification of the CoA source: internal lab, supplier‑provided, or third‑party laboratory.. Valid values are `internal|supplier|third_party`',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard referenced (e.g., FDA, GFSI, ISO 22000).',
    `digital_document_uri` STRING COMMENT 'Link to the digital copy of the CoA document.',
    `document_control_number` STRING COMMENT 'Control number used for document management and versioning.',
    `document_version` STRING COMMENT 'Version identifier of the CoA document.',
    `expiration_date` DATE COMMENT 'Date after which the CoA is no longer valid.',
    `fda_approval_number` STRING COMMENT 'FDA approval identifier associated with the product, if applicable.',
    `gfs_i_certified` BOOLEAN COMMENT 'True if the product is certified under a GFSI scheme.',
    `issue_date` DATE COMMENT 'Date the CoA was formally issued.',
    `issuing_entity` STRING COMMENT 'Entity that performed the testing and issued the CoA.. Valid values are `internal_lab|supplier_lab|third_party_lab`',
    `lab_location` STRING COMMENT 'Physical location of the laboratory where testing occurred.',
    `lot_disposition` STRING COMMENT 'Final disposition of the lot after CoA evaluation.. Valid values are `released|rejected|quarantined`',
    `lot_number` STRING COMMENT 'Lot identifier for the batch of material tested.',
    `material_upc` STRING COMMENT 'UPC code of the material covered by the CoA.',
    `microbial_cfu_count` STRING COMMENT 'Colony‑forming unit count from microbiological testing.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the CoA.',
    `overall_conformance` STRING COMMENT 'Overall pass/fail result of the CoA against its specifications.. Valid values are `pass|fail`',
    `ph` DECIMAL(18,2) COMMENT 'Measured pH of the product.',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant where the material was produced.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the CoA record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CoA record.',
    `regulatory_compliance_status` STRING COMMENT 'Indicates whether the CoA meets applicable regulatory requirements.. Valid values are `compliant|non_compliant`',
    `result_status` STRING COMMENT 'Pass/fail/out‑of‑spec status for the primary test.. Valid values are `pass|fail|out_of_spec`',
    `shelf_life_days` STRING COMMENT 'Declared shelf life of the product in days.',
    `specification_reference` STRING COMMENT 'Reference to the specification document or standard used for testing.',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Recommended storage humidity level.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature for the product.',
    `test_date` DATE COMMENT 'Date on which the analytical testing was performed.',
    `test_method` STRING COMMENT 'Standard method or protocol used for the primary test.',
    `test_result_unit` STRING COMMENT 'Unit of measure for the primary test result (e.g., mg/kg).',
    `test_result_value` DECIMAL(18,2) COMMENT 'Numeric result of the primary analytical test.',
    CONSTRAINT pk_certificate_of_analysis PRIMARY KEY(`certificate_of_analysis_id`)
) COMMENT 'Master record for Certificates of Analysis (CoA) issued for finished goods lots and received from ingredient/raw material suppliers. Captures CoA ID, material/SKU, lot/batch number, issuing entity (internal lab, supplier, third-party lab), issue date, test parameters and results (physical, chemical, microbiological), specification reference, overall conformance status, and digital document reference. Supports customer CoA requests, supplier incoming quality control, and regulatory traceability.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Primary key for audit_finding',
    `qms_document_id` BIGINT COMMENT 'Reference to supporting documentation stored in Veeva Vault QMS.',
    `food_safety_audit_id` BIGINT COMMENT 'Identifier of the audit event in the source system.',
    `related_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on audit_finding (related_audit_finding_id)',
    `audit_finding_category` STRING COMMENT 'Broad classification (e.g., hygiene, labeling, process deviation).',
    `audit_type` STRING COMMENT 'Origin of the audit that generated the finding.',
    `closure_date` DATE COMMENT 'Date the finding was formally closed.',
    `comments` STRING COMMENT 'Free‑form notes added by auditors or owners.',
    `corrective_action_description` STRING COMMENT 'Planned steps to remediate the finding.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completing corrective actions.',
    `corrective_action_owner` STRING COMMENT 'Individual or team responsible for executing corrective actions.',
    `corrective_action_status` STRING COMMENT 'Current progress state of the corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created in the system.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative of the issue identified during the audit.',
    `detection_date` DATE COMMENT 'Date the non‑conformance was first observed.',
    `finding_number` STRING COMMENT 'Human‑readable identifier assigned by the audit team to track the finding.',
    `finding_source` STRING COMMENT 'Method or channel through which the finding was identified.',
    `follow_up_date` DATE COMMENT 'Planned date for post‑closure verification.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional monitoring is needed after closure.',
    `is_repeat_finding` BOOLEAN COMMENT 'Indicates whether the same issue has been recorded previously.',
    `location_code` STRING COMMENT 'Plant, warehouse, or site where the finding was observed.',
    `non_conformance_code` STRING COMMENT 'Standardized code representing the type of deviation.',
    `product_code` STRING COMMENT 'SKU or internal code of the product affected.',
    `regulatory_standard` STRING COMMENT 'Applicable food‑safety standard (e.g., SQF, BRC, FSSC 22000).',
    `reported_by_name` STRING COMMENT 'Name of the person who reported the finding.',
    `responsible_party` STRING COMMENT 'Team, department, or individual accountable for corrective action.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating derived from severity and likelihood.',
    `root_cause_category` STRING COMMENT 'High‑level category describing the underlying cause.',
    `severity_level` STRING COMMENT 'Risk severity assigned to the finding based on impact and likelihood.',
    `audit_finding_status` STRING COMMENT 'Current workflow state of the finding.',
    `title` STRING COMMENT 'Brief title summarizing the audit finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the finding record.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Master reference table for audit_finding. Referenced by related_audit_finding_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Primary key for laboratory',
    `parent_laboratory_id` BIGINT COMMENT 'Self-referencing FK on laboratory (parent_laboratory_id)',
    `accreditation_body` STRING COMMENT 'Organization that provided the laboratory accreditation.',
    `accreditation_date` DATE COMMENT 'Date when the laboratory received its accreditation.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the laboratory.',
    `address_line1` STRING COMMENT 'Primary street address of the laboratory.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite or building).',
    `capacity_per_day` STRING COMMENT 'Maximum number of samples the laboratory can process per day.',
    `certification_expiry` DATE COMMENT 'Expiration date of the laboratorys current certification.',
    `city` STRING COMMENT 'City where the laboratory is situated.',
    `laboratory_code` STRING COMMENT 'Business code used to reference the laboratory in external systems.',
    `compliance_status` STRING COMMENT 'Overall compliance standing of the laboratory.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the laboratory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory record was first created.',
    `laboratory_description` STRING COMMENT 'Free‑form description of the laboratorys purpose and capabilities.',
    `effective_from` DATE COMMENT 'Date when the laboratory became operational or the record became effective.',
    `effective_until` DATE COMMENT 'Date when the laboratory ceased operations or the record is no longer effective (nullable).',
    `email_address` STRING COMMENT 'Primary email address for laboratory communications.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in an emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for emergency contact related to the laboratory.',
    `equipment_count` STRING COMMENT 'Total number of major testing instruments in the laboratory.',
    `humidity_control_range` STRING COMMENT 'Allowed humidity range for controlled environments (e.g., "30-50% RH").',
    `inspection_score` STRING COMMENT 'Numeric score (0‑100) resulting from the latest inspection.',
    `is_haccp_compliant` BOOLEAN COMMENT 'Indicates whether the laboratory complies with HACCP requirements.',
    `lab_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area of the laboratory in square meters.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection.',
    `location_name` STRING COMMENT 'Name of the site or campus where the laboratory is located.',
    `manager_contact_phone` STRING COMMENT 'Direct phone number of the laboratory manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for laboratory operations.',
    `laboratory_name` STRING COMMENT 'Human‑readable name of the laboratory.',
    `notes` STRING COMMENT 'Additional remarks or comments about the laboratory.',
    `operating_hours` STRING COMMENT 'Standard daily operating hours (e.g., "08:00-17:00").',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the laboratory.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the laboratory address.',
    `primary_testing_method` STRING COMMENT 'Main analytical technique employed by the laboratory (e.g., HPLC, GC‑MS).',
    `safety_incident_count` STRING COMMENT 'Number of recorded safety incidents in the laboratory over the past year.',
    `shift_pattern` STRING COMMENT 'Typical work shift pattern for laboratory staff.',
    `state` STRING COMMENT 'State or province of the laboratory location.',
    `laboratory_status` STRING COMMENT 'Current operational status of the laboratory.',
    `temperature_control_range` STRING COMMENT 'Allowed temperature range for controlled environments (e.g., "2-8C").',
    `laboratory_type` STRING COMMENT 'Category of testing performed by the laboratory.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the laboratory record.',
    `waste_disposal_method` STRING COMMENT 'Method used for disposing laboratory waste (e.g., incineration, autoclave).',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master reference table for laboratory. Referenced by lab_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`quality`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `analyst_employee_id` BIGINT COMMENT 'Identifier of the analyst who performed the test.',
    `capa_id` BIGINT COMMENT 'Reference to the corrective action record linked to a non‑conformance.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the sample collection.',
    `sku_id` BIGINT COMMENT 'Reference to the product that the sample represents.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory analysis was completed.',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the sampled product.',
    `collection_location` STRING COMMENT 'Facility, plant, or site code where the sample was taken.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was physically collected.',
    `comments` STRING COMMENT 'Free‑text field for additional observations or notes about the sample.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the system.',
    `expiry_date` DATE COMMENT 'Calculated expiry date of the sampled product based on shelf‑life.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity measured at the collection point.',
    `lot_number` STRING COMMENT 'Lot identifier used for traceability of the sampled material.',
    `non_conformance_flag` BOOLEAN COMMENT 'Indicates whether the sample result triggered a non‑conformance event.',
    `result_unit` STRING COMMENT 'Unit of measure for the result value (e.g., "CFU/g", "pH").',
    `result_value` DECIMAL(18,2) COMMENT 'Numeric value produced by the test (e.g., CFU count, pH).',
    `sample_code` STRING COMMENT 'External code or barcode assigned to the sample for tracking across labs and processes.',
    `sample_name` STRING COMMENT 'Human‑readable name or description of the sample (e.g., "Batch 12 – Chocolate Bar").',
    `sample_type` STRING COMMENT 'Category of the sample such as raw material, finished product, in‑process, or environmental swab.',
    `shelf_life_days` STRING COMMENT 'Number of days the product is expected to remain fit for consumption.',
    `sample_status` STRING COMMENT 'Current lifecycle state of the sample within the quality workflow.',
    `storage_condition` STRING COMMENT 'Required storage condition for the sample after collection.',
    `storage_location` STRING COMMENT 'Physical location (e.g., freezer ID, shelf) where the sample is stored.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the sample at the time of collection, expressed in degrees Celsius.',
    `test_method` STRING COMMENT 'Analytical method or protocol used to evaluate the sample (e.g., AOAC, ISO 22000).',
    `test_result` STRING COMMENT 'Outcome of the primary quality test performed on the sample.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sample record.',
    `volume_ml` DECIMAL(18,2) COMMENT 'Measured volume of the sample in milliliters.',
    `weight_grams` DECIMAL(18,2) COMMENT 'Measured weight of the sample in grams.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `food_beverage_ecm`.`quality`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `food_beverage_ecm`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `food_beverage_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `food_beverage_ecm`.`quality`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `food_beverage_ecm`.`quality`.`sample`(`sample_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ADD CONSTRAINT `fk_quality_shelf_life_study_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ADD CONSTRAINT `fk_quality_allergen_matrix_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ADD CONSTRAINT `fk_quality_qms_document_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ADD CONSTRAINT `fk_quality_process_validation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `food_beverage_ecm`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_qms_document_id` FOREIGN KEY (`qms_document_id`) REFERENCES `food_beverage_ecm`.`quality`.`qms_document`(`qms_document_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `food_beverage_ecm`.`quality`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_related_audit_finding_id` FOREIGN KEY (`related_audit_finding_id`) REFERENCES `food_beverage_ecm`.`quality`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_parent_laboratory_id` FOREIGN KEY (`parent_laboratory_id`) REFERENCES `food_beverage_ecm`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `food_beverage_ecm`.`quality`.`capa`(`capa_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `allergen_changeover_validation` SET TAGS ('dbx_business_glossary_term' = 'Allergen Changeover Validation');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `cleaning_validation_method` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `doc_control_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `equipment_qualification_study` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Study');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `execution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Execution End Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `haccp_plan_status` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `haccp_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|pending');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `hazard_categories` SET TAGS ('dbx_business_glossary_term' = 'Hazard Categories');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `hazard_categories` SET TAGS ('dbx_value_regex' = 'biological|chemical|physical|radiological');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Validation Outcome');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'validated|failed');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Protocol Reference');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'FDA FSMA|USDA FSIS|Codex|EU Regulation|GFSI');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `revalidation_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Interval (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `revalidation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Trigger');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Scope Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `validation_scope` SET TAGS ('dbx_business_glossary_term' = 'Validation Scope');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'process|cleaning|equipment|aseptic');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Sensor Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operator Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `ccp_code` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `control_point_category` SET TAGS ('dbx_business_glossary_term' = 'Control Point Category');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `control_point_category` SET TAGS ('dbx_value_regex' = 'temperature|ph|metal_detection|brix|water_activity|time');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `critical_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `critical_limit_unit` SET TAGS ('dbx_value_regex' = 'C|pH|%|seconds|µm');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `critical_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `deviation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Deviation Trigger');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type (Biological, Chemical, Physical)');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'biological|chemical|physical');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `last_measured_value` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `last_measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `last_measurement_status` SET TAGS ('dbx_value_regex' = 'pass|fail|out_of_range');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `last_observed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Observed Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'temperature|ph|brix|water_activity|time|metal_detection');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'C|pH|%|seconds|µm');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `monitoring_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (Minutes)');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `sampling_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency (Minutes)');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `sampling_size` SET TAGS ('dbx_business_glossary_term' = 'Sampling Size');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Tolerance Limit');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Tolerance Limit');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ALTER COLUMN `verification_activity` SET TAGS ('dbx_business_glossary_term' = 'Verification Activity');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_value_regex' = 'x_bar|r_chart|s_chart|p_chart|np_chart');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `cp_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `fda_approval_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Approval Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `gfs_i_certified` SET TAGS ('dbx_business_glossary_term' = 'GFSI Certified Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `humidity_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Humidity (%RH)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'visual|lab|sensor|taste|microbial');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'open|closed|released|rejected|hold');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final_release');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Creation Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'released|rework|scrap|quarantine');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (SKU)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Result');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `quantity_inspected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Inspected');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Sample Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|l|ml|units');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `stock_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Posting Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `stock_posting_status` SET TAGS ('dbx_value_regex' = 'posted|not_posted|error');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|l|ml|units');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision');
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision` SET TAGS ('dbx_value_regex' = 'accept|reject|hold');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'CCP Deviation ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `production_shift_id` SET TAGS ('dbx_business_glossary_term' = 'Production Shift ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Source Party ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `batch_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Expiration Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `batch_production_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Production Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `batch_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Quantity');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'safety|quality|labeling|packaging|taste|odor');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `complaint_channel` SET TAGS ('dbx_business_glossary_term' = 'Complaint Channel');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `complaint_channel` SET TAGS ('dbx_value_regex' = 'call_center|retailer|social_media|direct_to_consumer|online|email');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'contamination|label_error|packaging|taste|appearance|foreign_body');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'release|rework|scrap|return_to_supplier|hold|destroy');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `hold_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Hold Duration (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `hold_location` SET TAGS ('dbx_business_glossary_term' = 'Hold Location');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'quarantine|release_hold|rework_hold|destroy_hold|return_to_supplier');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|escalated');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report Number (NCR)');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `quality_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Quality Metric Unit');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `quality_metric_unit` SET TAGS ('dbx_value_regex' = 'CFU|pH|Brix|%ABV');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `quality_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Quality Metric Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `regulatory_report_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `regulatory_report_type` SET TAGS ('dbx_value_regex' = 'FDA_MedWatch|USDA|Reportable_Food_Registry|None');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|pending|deferred');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process|material|equipment|human_error|supplier|design');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'in_process|supplier|customer_complaint|consumer_hotline|audit_finding|ccp_deviation');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customer Complaint Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Non-Conformance Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `attached_document_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|on_hold|cancelled');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `ccn_number` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'CAPA Comments');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `department` SET TAGS ('dbx_value_regex' = 'Quality|Manufacturing|Supply_Chain|Regulatory|R&D|Other');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_value_regex' = 'retest|audit|review|other');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Result');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partial');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `is_effective` SET TAGS ('dbx_business_glossary_term' = 'Is Effective Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_value_regex' = '5_why|fishbone|fault_tree|pareto|other');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minor');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `verification_responsible` SET TAGS ('dbx_business_glossary_term' = 'Verification Responsible');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `verification_responsible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ALTER COLUMN `verification_responsible` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `micro_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Micro Test Result ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `lab_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|non_accredited');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `chain_of_custody` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `collection_location` SET TAGS ('dbx_business_glossary_term' = 'Collection Location');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `control_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `control_sample_type` SET TAGS ('dbx_value_regex' = 'positive|negative|blank');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `detection_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Unit');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `detection_limit_unit` SET TAGS ('dbx_value_regex' = 'CFU_per_g|CFU_per_ml');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `incubation_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Incubation Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `incubation_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Incubation Time (hours)');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `is_control_sample` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Indicator');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `result_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Reported Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `result_unit` SET TAGS ('dbx_value_regex' = 'CFU_per_g|CFU_per_ml|presence_absence');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sample_condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Condition');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sample_condition` SET TAGS ('dbx_value_regex' = 'frozen|refrigerated|room_temp');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sample_source` SET TAGS ('dbx_business_glossary_term' = 'Sample Source');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sample_source` SET TAGS ('dbx_value_regex' = 'supplier|in_house|field');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'raw_material|wip|finished_goods|environmental_swab|water');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `target_organism` SET TAGS ('dbx_business_glossary_term' = 'Target Organism');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `target_organism` SET TAGS ('dbx_value_regex' = 'Salmonella|Listeria|E_coli_O157_H7|TPC|Yeast_Mold');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'AOAC|ISO|USDA_FSIS');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|cancelled');
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `sensory_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Leader Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `rd_sensory_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Sensory Panel Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `attribute_list` SET TAGS ('dbx_business_glossary_term' = 'Sensory Attributes Assessed');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|in_review');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `average_overall_score` SET TAGS ('dbx_business_glossary_term' = 'Average Overall Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `confidence_interval` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval (%)');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'paper|electronic|tablet');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `median_score` SET TAGS ('dbx_business_glossary_term' = 'Median Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Panel Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Overall Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panel_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panel_end_time` SET TAGS ('dbx_business_glossary_term' = 'Panel End Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panel_leader_name` SET TAGS ('dbx_business_glossary_term' = 'Panel Leader Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panel_name` SET TAGS ('dbx_business_glossary_term' = 'Panel Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panel_start_time` SET TAGS ('dbx_business_glossary_term' = 'Panel Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panel_type` SET TAGS ('dbx_business_glossary_term' = 'Panel Type (Descriptive, Hedonic, Discrimination, Triangle, Consumer)');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panel_type` SET TAGS ('dbx_value_regex' = 'descriptive|hedonic|discrimination|triangle|consumer');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panelist_count` SET TAGS ('dbx_business_glossary_term' = 'Panelist Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panelist_data_source` SET TAGS ('dbx_business_glossary_term' = 'Panelist Data Source');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `panelist_data_source` SET TAGS ('dbx_value_regex' = 'internal|external|contractor');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `product_gtin` SET TAGS ('dbx_business_glossary_term' = 'Product GTIN (Global Trade Item Number)');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `product_upc` SET TAGS ('dbx_business_glossary_term' = 'Product UPC (Universal Product Code)');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Protocol Version');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|GFSI');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `scoring_scale` SET TAGS ('dbx_business_glossary_term' = 'Scoring Scale');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `sensory_degradation_trend` SET TAGS ('dbx_business_glossary_term' = 'Sensory Degradation Trend');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `sensory_degradation_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|degrading');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `shelf_life_day` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Score Standard Deviation');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `statistical_method` SET TAGS ('dbx_value_regex' = 'ANOVA|t-test|nonparametric|chi_square|regression');
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `shelf_life_study_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Study Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `assay_method` SET TAGS ('dbx_business_glossary_term' = 'Assay Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'FDA|USDA|GFSI|ISO22000|FSSC22000');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `degradation_model` SET TAGS ('dbx_business_glossary_term' = 'Degradation Model');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `degradation_model` SET TAGS ('dbx_value_regex' = 'q10|arrhenius|linear|exponential');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `evaluation_schedule` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Schedule');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `evaluator_role` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Role');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `humidity_acceleration_factor` SET TAGS ('dbx_business_glossary_term' = 'Humidity Acceleration Factor');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `packaging_format` SET TAGS ('dbx_business_glossary_term' = 'Packaging Format');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `q10_value` SET TAGS ('dbx_business_glossary_term' = 'Q10 Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `shelf_life_study_description` SET TAGS ('dbx_business_glossary_term' = 'Study Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `shelf_life_study_status` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Study Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `shelf_life_study_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Relative Humidity (%)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `storage_light_exposure` SET TAGS ('dbx_business_glossary_term' = 'Storage Light Exposure');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `storage_light_exposure` SET TAGS ('dbx_value_regex' = 'dark|ambient|direct');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Study Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Study Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'real_time|accelerated|arrhenius');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `target_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Target Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `temperature_acceleration_factor` SET TAGS ('dbx_business_glossary_term' = 'Temperature Acceleration Factor');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_title` SET TAGS ('dbx_business_glossary_term' = 'Audit Title');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Certification Outcome');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_value_regex' = 'certified|non_certified|conditional');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `certification_scheme` SET TAGS ('dbx_business_glossary_term' = 'Certification Scheme');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `certification_scheme` SET TAGS ('dbx_value_regex' = 'SQF|BRC|FSSC22000|ISO22000|GFSI');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `document_library_path` SET TAGS ('dbx_business_glossary_term' = 'Document Library Path');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `finding_count` SET TAGS ('dbx_business_glossary_term' = 'Total Finding Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `major_non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Major Non‑Conformance Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `minor_non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Non‑Conformance Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `opportunity_for_improvement_count` SET TAGS ('dbx_business_glossary_term' = 'Opportunity‑for‑Improvement Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `overall_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Grade');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `overall_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Audit Risk Level');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|exempt');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `brix_percent` SET TAGS ('dbx_business_glossary_term' = 'Brix Percentage');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'GFSI|SQF|BRC|FSSC22000|ISO22000');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `fat_percent` SET TAGS ('dbx_business_glossary_term' = 'Fat Percentage');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (cm)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Specification Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (cm)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `listeria_cfu_g` SET TAGS ('dbx_business_glossary_term' = 'Listeria Limit (CFU/g)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `moisture_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Percentage');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `organoleptic_score` SET TAGS ('dbx_business_glossary_term' = 'Organoleptic Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'bottle|can|box|pouch|bag|tray');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `ph` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `protein_percent` SET TAGS ('dbx_business_glossary_term' = 'Protein Percentage');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `salmonella_cfu_g` SET TAGS ('dbx_business_glossary_term' = 'Salmonella Limit (CFU/g)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `sensory_panel_method` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `sensory_panel_method` SET TAGS ('dbx_value_regex' = 'triangle|duo-trio|ranking|hedonic');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `sodium_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Sodium (mg/kg)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `spec_type` SET TAGS ('dbx_value_regex' = 'finished_product|raw_material|packaging|wip');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'Specification Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_value_regex' = 'SPEC-[A-Z0-9]{6}');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `specification_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|pending_approval');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_atmosphere');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `tpc_cfu_g` SET TAGS ('dbx_business_glossary_term' = 'Total Plate Count (CFU/g)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'vd+.d+');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (cm)');
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Matrix Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_celery` SET TAGS ('dbx_business_glossary_term' = 'Celery Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_celery` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_control_measures` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Measures');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_egg` SET TAGS ('dbx_business_glossary_term' = 'Egg Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_egg` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Fish Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_lupin` SET TAGS ('dbx_business_glossary_term' = 'Lupin Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_lupin` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_matrix_status` SET TAGS ('dbx_business_glossary_term' = 'Allergen Matrix Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_matrix_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Milk Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_mollusk` SET TAGS ('dbx_business_glossary_term' = 'Mollusk Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_mollusk` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_mustard` SET TAGS ('dbx_business_glossary_term' = 'Mustard Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_mustard` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_peanut` SET TAGS ('dbx_business_glossary_term' = 'Peanut Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_peanut` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_sesame` SET TAGS ('dbx_business_glossary_term' = 'Sesame Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_sesame` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Shellfish Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_soy` SET TAGS ('dbx_business_glossary_term' = 'Soy Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_soy` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_sulfites` SET TAGS ('dbx_business_glossary_term' = 'Sulfites Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_sulfites` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_tree_nut` SET TAGS ('dbx_business_glossary_term' = 'Tree Nut Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_tree_nut` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Wheat Allergen Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_value_regex' = 'present|may_contain|absent');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `cleaning_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `cleaning_validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `cleaning_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `cleaning_validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending|failed');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `cross_contact_risk` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Contact Risk Level');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `cross_contact_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{14}$');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `label_declaration_required` SET TAGS ('dbx_business_glossary_term' = 'Label Declaration Required');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `matrix_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Matrix Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `matrix_type` SET TAGS ('dbx_value_regex' = 'standard|custom');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Closure Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_business_glossary_term' = 'Complainant Address');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_business_glossary_term' = 'Complainant Email Address');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_business_glossary_term' = 'Complainant Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_business_glossary_term' = 'Complainant Phone Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_type` SET TAGS ('dbx_business_glossary_term' = 'Complainant Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complainant_type` SET TAGS ('dbx_value_regex' = 'consumer|trade|internal');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'foreign_material|off_flavor|packaging_defect|illness|labeling_error|other');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_value_regex' = '^CC[0-9]{8}$');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed|rejected');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `expected_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `product_upc` SET TAGS ('dbx_business_glossary_term' = 'Product UPC');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|none');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Complaint Severity');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source Channel');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'call_center|retailer|social_media|direct|email');
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `affected_lot_codes` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Codes (ALC)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `affected_sku_codes` SET TAGS ('dbx_business_glossary_term' = 'Affected SKU Codes (ASK)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference (ARR)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|NonCompliant|Pending');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope (DS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'Nationwide|Regional|International|Local');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `fda_notification_date` SET TAGS ('dbx_business_glossary_term' = 'FDA Notification Date (FND)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `initiating_party_name` SET TAGS ('dbx_business_glossary_term' = 'Initiating Party Name (IPN)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `is_voluntary` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Recall Flag (VRF)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `monetary_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Monetary Loss Amount (MLA)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `press_release_issued` SET TAGS ('dbx_business_glossary_term' = 'Press Release Issued Flag (PRIF)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `product_recovery_quantity` SET TAGS ('dbx_business_glossary_term' = 'Product Recovery Quantity (PRQ)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected (QA)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification (RC)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'Safety|Quality|Labeling');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Closure Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Timestamp (RIT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number (RN)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason (RR)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_reason` SET TAGS ('dbx_value_regex' = 'Microbial|Allergen|Foreign Material|Labeling|Regulatory|Other');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status (RS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'Initiated|InProgress|Closed|Cancelled');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type (RT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Voluntary');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `retailer_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Retailer Notification Status (RNS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `retailer_notification_status` SET TAGS ('dbx_value_regex' = 'Notified|Pending|Completed');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ALTER COLUMN `usda_notification_date` SET TAGS ('dbx_business_glossary_term' = 'USDA Notification Date (UND)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `qms_document_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System Document ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `applicable_sites` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sites (SITES)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|revoked');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `approver` SET TAGS ('dbx_business_glossary_term' = 'Approver (APPROVER)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Checksum (CHECKSUM)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category (DOC_CAT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'Quality|Safety|Compliance|Process|Product|Training');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number (DOC_NUM)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `document_subtype` SET TAGS ('dbx_business_glossary_term' = 'Document Subtype (DOC_SUBTYPE)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (DOC_TYPE)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'SOP|Work Instruction|Form|Policy|Specification|HACCP Plan');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXP_DT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format (FILE_FMT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|xlsx|pptx|txt');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path (FILE_PATH)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (FILE_SIZE)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (MODIFIED_BY)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Document Owner (OWNER)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (DEPT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `qms_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `qms_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived|pending_approval');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `regulatory_compliance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance (REG_COMP)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `regulatory_compliance` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|GFSI|ISO22000|ISO9001');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date (REV_DT)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NUM)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title (TITLE)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `training_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag (TRAIN_CMPL)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag (TRAIN_REQ)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER_NUM)');
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `supplier_quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Assessment ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `supplier_esg_score_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Score Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `approved_supplier_list_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `approved_supplier_list_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'questionnaire|on_site_audit|desk_review|certificate_review');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `brc_certified` SET TAGS ('dbx_business_glossary_term' = 'BRC Certified Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `brix_value` SET TAGS ('dbx_business_glossary_term' = 'Brix Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `cap_action_implemented` SET TAGS ('dbx_business_glossary_term' = 'CAPA Implemented Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|pending');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `cfu_count` SET TAGS ('dbx_business_glossary_term' = 'Colony Forming Units Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'TraceGains|SAP|Oracle|Salesforce');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `document_control_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `fssc_certified` SET TAGS ('dbx_business_glossary_term' = 'FSSC 22000 Certified Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑conformance Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Assessment Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `reassessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re‑assessment Due Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `regulated_product_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulated Product Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|GFSI|ISO22000|ISO9001');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `sampling_method` SET TAGS ('dbx_value_regex' = 'random|risk_based|full');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `sqf_certified` SET TAGS ('dbx_business_glossary_term' = 'SQF Certified Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `supplier_quality_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `supplier_quality_assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|rejected');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `supplier_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Rating');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `supplier_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `process_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Process Validation ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `allergen_changeover_validation` SET TAGS ('dbx_business_glossary_term' = 'Allergen Changeover Validation');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `cleaning_validation_method` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `doc_control_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `equipment_qualification_study` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Study');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `execution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Execution End Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Validation Outcome');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'validated|failed|conditionally_validated');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|validated|failed|revalidation_needed|retired');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Protocol Reference');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'FDA|GFSI|USDA|EFSA|ISO22000|FSSC22000');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `revalidation_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Interval (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `revalidation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Trigger');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `validation_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `validation_name` SET TAGS ('dbx_business_glossary_term' = 'Validation Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `validation_scope` SET TAGS ('dbx_business_glossary_term' = 'Validation Scope');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'process|cleaning|equipment|thermal|aseptic');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `validation_version` SET TAGS ('dbx_business_glossary_term' = 'Validation Version');
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Record ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `corrective_action_triggered` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Triggered');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity (%)');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Description');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `method_used` SET TAGS ('dbx_business_glossary_term' = 'Testing Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `method_used` SET TAGS ('dbx_value_regex' = 'PCR|Culture|ATP Luminometer');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `result_flag` SET TAGS ('dbx_business_glossary_term' = 'Result Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `result_flag` SET TAGS ('dbx_value_regex' = 'positive|negative');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `result_quantity` SET TAGS ('dbx_business_glossary_term' = 'Result Quantity');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'swab|air|surface|water');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `test_target` SET TAGS ('dbx_business_glossary_term' = 'Test Target');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `test_target` SET TAGS ('dbx_value_regex' = 'Listeria spp.|Listeria monocytogenes|ATP|APC');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `trend_status` SET TAGS ('dbx_business_glossary_term' = 'Trend Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `trend_status` SET TAGS ('dbx_value_regex' = 'improving|stable|deteriorating|new_issue');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `zone` SET TAGS ('dbx_business_glossary_term' = 'Sampling Zone');
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ALTER COLUMN `zone` SET TAGS ('dbx_value_regex' = 'zone1|zone2|zone3|zone4');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_record_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Record ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated By ID');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `attached_document_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'release|rework|destroy|return_to_supplier|quarantine');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated By');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_initiated_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_initiated_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_initiated_department` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated Department');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_initiated_department` SET TAGS ('dbx_value_regex' = 'quality|production|procurement|logistics');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiation Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|rework|destroyed|pending|closed');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'quality|micro|allergen|regulatory|customer_complaint');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `is_fefo_compliant` SET TAGS ('dbx_business_glossary_term' = 'FEFO Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `is_fifo_compliant` SET TAGS ('dbx_business_glossary_term' = 'FIFO Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `material_upc` SET TAGS ('dbx_business_glossary_term' = 'Material UPC');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `material_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `quality_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Manager Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `quality_manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `quality_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `quantity_held` SET TAGS ('dbx_business_glossary_term' = 'Quantity Held');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|unit|case|liter');
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `alcohol_by_volume` SET TAGS ('dbx_business_glossary_term' = 'Alcohol By Volume (ABV)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `allergen_presence` SET TAGS ('dbx_business_glossary_term' = 'Allergen Presence');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `allergen_presence` SET TAGS ('dbx_value_regex' = 'present|absent|not_tested');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `brix` SET TAGS ('dbx_business_glossary_term' = 'Brix (°Bx)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_status` SET TAGS ('dbx_value_regex' = 'draft|issued|approved|revoked');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Number (COA)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `coa_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Type (COA Type)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `coa_type` SET TAGS ('dbx_value_regex' = 'internal|supplier|third_party');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `digital_document_uri` SET TAGS ('dbx_business_glossary_term' = 'Digital Document URI');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `document_control_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `fda_approval_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Approval Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `gfs_i_certified` SET TAGS ('dbx_business_glossary_term' = 'GFSI Certified Flag');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `issuing_entity` SET TAGS ('dbx_business_glossary_term' = 'Issuing Entity');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `issuing_entity` SET TAGS ('dbx_value_regex' = 'internal_lab|supplier_lab|third_party_lab');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Lab Location');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'released|rejected|quarantined');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_upc` SET TAGS ('dbx_business_glossary_term' = 'Material UPC (Universal Product Code)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `microbial_cfu_count` SET TAGS ('dbx_business_glossary_term' = 'Microbial CFU Count');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `overall_conformance` SET TAGS ('dbx_business_glossary_term' = 'Overall Conformance (Pass/Fail)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `overall_conformance` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `ph` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|out_of_spec');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity (%)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_result_unit` SET TAGS ('dbx_business_glossary_term' = 'Test Result Unit');
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_result_value` SET TAGS ('dbx_business_glossary_term' = 'Test Result Value');
ALTER TABLE `food_beverage_ecm`.`quality`.`audit_finding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`audit_finding` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`audit_finding` ALTER COLUMN `related_audit_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `parent_laboratory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`quality`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`quality`.`sample` SET TAGS ('dbx_subdomain' = 'quality_testing');
