-- Schema for Domain: compliance | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`compliance` COMMENT 'Enterprise regulatory compliance management covering food safety (FDA/USDA), OSHA workplace safety, ADA accessibility, environmental regulations, data privacy (CCPA/state laws), and audit management across all Grocery operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`program` (
    `program_id` BIGINT COMMENT 'System-generated unique identifier for the compliance program.',
    `parent_program_id` BIGINT COMMENT 'Self-referencing FK on program (parent_program_id)',
    `audit_frequency_months` STRING COMMENT 'Number of months between scheduled compliance audits.',
    `audit_result_summary` STRING COMMENT 'High‑level summary of findings from the most recent audit.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated monetary budget for the program (in base currency).',
    `compliance_area` STRING COMMENT 'Specific compliance domain(s) the program targets.. Valid values are `food|safety|environment|privacy|accessibility`',
    `compliance_requirements` STRING COMMENT 'Concatenated list or summary of regulatory requirements addressed by the program.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the program after the latest audit.. Valid values are `compliant|non_compliant|partial|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance program record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the budget amount.',
    `documentation_url` STRING COMMENT 'Link to the central repository or document that defines the program.',
    `effective_end_date` DATE COMMENT 'Date the program expires or is terminated (nullable for open‑ended programs).',
    `effective_start_date` DATE COMMENT 'Date the program becomes effective and binding.',
    `external_program_code` STRING COMMENT 'Identifier or code assigned by the sponsoring regulatory framework (e.g., FSMA program number).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether participation in the program is mandatory for the business unit.',
    `last_audit_date` DATE COMMENT 'Date the most recent audit of the program was completed.',
    `last_modified_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `next_audit_due_date` DATE COMMENT 'Planned date for the next scheduled audit.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the program.',
    `owner` STRING COMMENT 'Name of the internal owner or sponsor responsible for the program.',
    `program_category` STRING COMMENT 'High‑level classification of the programs focus area.. Valid values are `food_safety|workplace_safety|environment|privacy|accessibility`',
    `program_description` STRING COMMENT 'Detailed description of the compliance program, its objectives, and key activities.',
    `program_name` STRING COMMENT 'Human‑readable name of the compliance program.',
    `program_scope` STRING COMMENT 'Narrative description of the geographic, functional, and operational scope covered by the program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|suspended|closed`',
    `regulatory_body` STRING COMMENT 'Specific agency or body that issues the regulatory requirements.. Valid values are `FDA|OSHA|EPA|FTC|HIPAA|DEA`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework governing the program (e.g., FDA, OSHA).. Valid values are `FDA|OSHA|EPA|CCPA|ADA`',
    `risk_level` STRING COMMENT 'Risk rating assigned to the program based on potential compliance impact.. Valid values are `low|medium|high|critical`',
    `stakeholder_group` STRING COMMENT 'Primary internal stakeholder group(s) involved in the program. [ENUM-REF-CANDIDATE: operations|store|pharmacy|it|hr|finance|supply_chain — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance program record.',
    `version_number` STRING COMMENT 'Version identifier for the program definition (e.g., v1.2).',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for each formal compliance program managed by Grocery, such as the FDA Food Safety Modernization Act (FSMA) program, OSHA Injury and Illness Prevention Program (IIPP), ADA Transition Plan, CCPA Privacy Program, and EPA UST Compliance Program. Captures program name, sponsoring regulatory framework, program owner, scope, program status, and the set of regulatory requirements it addresses. Provides the organizational structure for grouping related compliance activities.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'System-generated unique identifier for the compliance obligation record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance Cost Allocation process assigns each obligation to a cost center responsible for funding and tracking compliance expenses.',
    `associate_id` BIGINT COMMENT 'Employee responsible for overseeing compliance with this obligation.',
    `obligation_escalation_contact_associate_id` BIGINT COMMENT 'Employee to contact for escalation of overdue or critical obligations.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Certain obligations (e.g., controlled‑substance handling) are assigned to specific pharmacy locations.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Regulatory obligations (e.g., labeling, allergen disclosure) are assigned per SKU; the Compliance Obligation report requires linking each obligation to the specific product_item.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Compliance obligations belong to a compliance program; replace the existing string field with a proper FK to compliance_program.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Regulatory obligations are often supplier‑specific; tracking obligations per supplier is required for compliance dashboards.',
    `parent_obligation_id` BIGINT COMMENT 'Self-referencing FK on obligation (parent_obligation_id)',
    `attached_files_flag` BOOLEAN COMMENT 'Indicates whether supporting files are attached to the record.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance obligation record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance obligation record.',
    `business_unit` STRING COMMENT 'Business unit responsible for fulfilling the obligation.',
    `compliance_metric` DECIMAL(18,2) COMMENT 'Numeric metric representing compliance performance (e.g., percentage of requirements met).',
    `compliance_status_detail` STRING COMMENT 'Additional detail describing the current compliance condition (e.g., "awaiting audit", "partial compliance").',
    `department` STRING COMMENT 'Department within the store or corporate structure that must satisfy the obligation.',
    `due_date` DATE COMMENT 'Date by which the obligation must be satisfied.',
    `effective_from` DATE COMMENT 'Date when the obligation becomes active.',
    `effective_until` DATE COMMENT 'Date when the obligation expires or is no longer required (nullable).',
    `evidence_documentation` STRING COMMENT 'Reference or path to the document(s) that prove compliance.',
    `evidence_required` BOOLEAN COMMENT 'Indicates whether supporting evidence must be provided for compliance.',
    `jurisdiction` STRING COMMENT 'Three‑letter country code where the obligation applies.. Valid values are `^[A-Z]{3}$`',
    `last_review_date` DATE COMMENT 'Date when the obligation was last reviewed for relevance or changes.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the status field last changed.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the obligation.',
    `obligation_code` STRING COMMENT 'Human‑readable code that uniquely identifies the regulatory or policy obligation.. Valid values are `^[A-Z]{3}-d{4}-d{3}$`',
    `obligation_name` STRING COMMENT 'Descriptive name of the compliance obligation.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the obligation.. Valid values are `pending|in_progress|fulfilled|overdue|cancelled`',
    `obligation_type` STRING COMMENT 'Category of the obligation indicating its origin or focus area.. Valid values are `regulatory|internal|environmental|safety|privacy|financial`',
    `priority` STRING COMMENT 'Business priority assigned to the obligation.. Valid values are `high|medium|low`',
    `recurrence_schedule` STRING COMMENT 'Frequency with which the obligation repeats.. Valid values are `annual|quarterly|monthly|weekly|daily|one-time`',
    `regulatory_body` STRING COMMENT 'Governing authority that issued the requirement (e.g., FDA, OSHA).',
    `remediation_action` STRING COMMENT 'Planned corrective action if the obligation is not met.',
    `risk_level` STRING COMMENT 'Risk rating associated with non‑compliance.. Valid values are `critical|high|moderate|low|none`',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Operational assignment record linking a specific regulatory requirement to a Grocery business unit, store location, department, or operational entity that must fulfill it. Captures obligation owner, due date, recurrence schedule (annual, quarterly, monthly), obligation status (pending, in-progress, fulfilled, overdue), and the compliance program it belongs to. Serves as the actionable work item driving compliance execution across all locations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`audit_plan` (
    `audit_plan_id` BIGINT COMMENT 'Unique identifier for the audit plan record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Audit plans are owned by a compliance program; adding program_id provides program ownership context.',
    `superseded_audit_plan_id` BIGINT COMMENT 'Self-referencing FK on audit_plan (superseded_audit_plan_id)',
    `actual_end_date` DATE COMMENT 'Actual end date when the audit was completed.',
    `actual_start_date` DATE COMMENT 'Actual start date when the audit began.',
    `audit_budget` DECIMAL(18,2) COMMENT 'Monetary budget allocated for the audit.',
    `audit_category` STRING COMMENT 'High‑level category of the audit.. Valid values are `food_safety|workplace_safety|privacy|financial_controls|environmental|pharmacy_compliance`',
    `audit_criteria` STRING COMMENT 'Criteria and standards against which audit findings are measured.',
    `audit_frequency` STRING COMMENT 'How often the audit is scheduled to occur.. Valid values are `annual|semiannual|quarterly|ad_hoc`',
    `audit_objectives` STRING COMMENT 'Specific objectives the audit aims to achieve.',
    `audit_outcome_summary` STRING COMMENT 'High‑level summary of audit results and conclusions.',
    `audit_plan_status` STRING COMMENT 'Current lifecycle status of the audit plan.. Valid values are `draft|scheduled|in_progress|completed|cancelled`',
    `audit_resources` STRING COMMENT 'Resources (personnel, tools) allocated for the audit.',
    `audit_type` STRING COMMENT 'Classification of the audit as internal, external, or regulatory.. Valid values are `internal|external|regulatory`',
    `compliance_programs` STRING COMMENT 'Comma‑separated list of compliance programs evaluated in the audit.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for implementing corrective actions from audit findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit plan record was created.',
    `document_url` STRING COMMENT 'Link to the stored audit plan document.',
    `findings_count` STRING COMMENT 'Total count of findings identified during the audit.',
    `last_review_date` DATE COMMENT 'Date when the audit plan was last reviewed.',
    `lead_auditor` STRING COMMENT 'Name of the primary auditor responsible for the audit plan.',
    `methodology` STRING COMMENT 'Methodology or approach used for the audit (e.g., risk-based, checklist).',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the audit plan.',
    `notes` STRING COMMENT 'Free‑form notes related to the audit plan.',
    `owner_department` STRING COMMENT 'Department that owns and maintains the audit plan.',
    `plan_code` STRING COMMENT 'Business identifier or code for the audit plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the audit plan.',
    `plan_version` STRING COMMENT 'Version identifier for the audit plan.',
    `planned_end_date` DATE COMMENT 'Scheduled end date for the audit.',
    `planned_start_date` DATE COMMENT 'Scheduled start date for the audit.',
    `priority` STRING COMMENT 'Priority level of the audit plan.. Valid values are `high|medium|low`',
    `regulatory_body` STRING COMMENT 'Regulatory agency overseeing the audit (e.g., FDA, OSHA). [ENUM-REF-CANDIDATE: FDA|OSHA|USDA|DEA|FTC|EPA|HIPAA|SOX — promote to reference product]',
    `risk_level` STRING COMMENT 'Overall risk level assigned to the audit plan.. Valid values are `low|medium|high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score derived from risk assessment.',
    `scope` STRING COMMENT 'Scope of the audit covering specific compliance areas (e.g., food safety, OSHA, privacy).',
    `tags` STRING COMMENT 'Comma‑separated tags for categorization and search.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit plan record.',
    CONSTRAINT pk_audit_plan PRIMARY KEY(`audit_plan_id`)
) COMMENT 'Master record for scheduled compliance audit plans covering internal audits, third-party audits, and regulatory agency inspections across all Grocery operational areas. Captures audit plan name, audit type (internal, external, regulatory), scope (food safety, OSHA, ADA, privacy, financial controls), planned start and end dates, assigned lead auditor, audit methodology, and the compliance programs being assessed. Drives the annual audit calendar and resource allocation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`audit_engagement` (
    `audit_engagement_id` BIGINT COMMENT 'Unique system-generated identifier for each audit engagement.',
    `associate_id` BIGINT COMMENT 'Identifier of the lead auditor who oversaw the engagement.',
    `audit_plan_id` BIGINT COMMENT 'Identifier of the audit plan under which this engagement is executed.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Audit engagement costs are captured via internal orders to track expenses against audit projects.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Audit engagements belong to a compliance program; direct program link simplifies reporting.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, pharmacy, or fuel center audited.',
    `followup_audit_engagement_id` BIGINT COMMENT 'Self-referencing FK on audit_engagement (followup_audit_engagement_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Exact time when the audit work was finished.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Exact time when the audit work actually began on site.',
    `audit_date` DATE COMMENT 'Calendar date on which the audit was performed.',
    `audit_methodology` STRING COMMENT 'Primary technique applied during the audit (e.g., checklist, interview).. Valid values are `checklist|interview|sampling|observation`',
    `audit_notes` STRING COMMENT 'Additional observations, comments, or contextual information recorded by the auditor.',
    `audit_objective` STRING COMMENT 'Statement of the audits intended goals or focus areas.',
    `audit_scope` STRING COMMENT 'Business area or asset category that the audit covers.. Valid values are `store|distribution_center|pharmacy|fuel_center|warehouse`',
    `audit_status` STRING COMMENT 'Current state of the audit engagement in its workflow.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit (e.g., internal, external, regulatory, vendor).. Valid values are `internal|external|regulatory|vendor`',
    `compliance_issue_count` STRING COMMENT 'Number of distinct compliance violations recorded during the audit.',
    `corrective_action_count` STRING COMMENT 'Number of remediation actions mandated as a result of the audit.',
    `corrective_action_deadline` DATE COMMENT 'Target date by which all corrective actions must be resolved.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the audit engagement record was first inserted.',
    `engagement_number` STRING COMMENT 'Human‑readable code assigned to the audit engagement for tracking and reference.',
    `findings_summary` STRING COMMENT 'Concise narrative of key observations and issues identified.',
    `is_critical` BOOLEAN COMMENT 'Flag set to true if any finding is classified as critical.',
    `is_follow_up_required` BOOLEAN COMMENT 'Flag indicating that a subsequent audit must be scheduled.',
    `overall_rating` STRING COMMENT 'Summarized rating indicating audit result.. Valid values are `satisfactory|needs_improvement|unsatisfactory`',
    `rating_score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., 0‑100) derived from audit findings.',
    `report_reference` STRING COMMENT 'Link or identifier to the detailed audit report stored in the document repository.',
    `risk_level` STRING COMMENT 'Overall risk classification derived from the audit outcomes.. Valid values are `low|medium|high|critical`',
    `scheduled_end_date` DATE COMMENT 'Date the audit was scheduled to be completed.',
    `scheduled_start_date` DATE COMMENT 'Date the audit was scheduled to begin.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the audit engagement record.',
    CONSTRAINT pk_audit_engagement PRIMARY KEY(`audit_engagement_id`)
) COMMENT 'Transactional record for each individual audit engagement executed against an audit plan, representing a specific audit instance at a store, DC, pharmacy, or fuel center. Captures engagement number, linked audit plan, location audited, actual start and end dates, lead auditor, audit status (scheduled, in-progress, completed, cancelled), overall audit rating (satisfactory, needs improvement, unsatisfactory), and final report reference. The primary operational record for audit execution tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System‑generated unique identifier for each audit finding.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Audit findings reference analytical datasets used as evidence; storing analytical_dataset_id ties each finding to the supporting dataset.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee or auditor assigned to remediate the finding.',
    `audit_engagement_id` BIGINT COMMENT 'Identifier of the audit engagement to which the finding belongs.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Audit traceability: audit findings often reference specific payment transactions that exhibited non‑compliance, supporting root‑cause analysis.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Required for Pharmacy Compliance Audit Findings report linking each finding to the specific pharmacy location for remediation tracking.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: REQUIRED: Each audit finding is recorded under a specific compliance program (e.g., Food Safety Program) for program‑level reporting and corrective action tracking.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Audit findings need to reference the responsible supplier for root‑cause analysis and supplier scorecard calculations.',
    `related_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on audit_finding (related_audit_finding_id)',
    `audit_finding_category` STRING COMMENT 'Secondary categorization used for reporting (e.g., Process, Documentation, Training).',
    `audit_finding_status` STRING COMMENT 'Current processing state of the finding (open, in progress, closed, or deferred).. Valid values are `open|in_progress|closed|deferred`',
    `compliance_area` STRING COMMENT 'High‑level category of compliance (e.g., Food Safety, Occupational Safety, Privacy).. Valid values are `food_safety|occupational_safety|privacy|environment|financial|pharmacy`',
    `corrective_action` STRING COMMENT 'Prescribed steps to remediate the finding and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the finding was first entered into the system.',
    `department` STRING COMMENT 'Organizational department (e.g., Produce, Pharmacy, Supply Chain) affected by the finding.',
    `due_date` DATE COMMENT 'Target date for completing the corrective action.',
    `evidence_documentation` STRING COMMENT 'Path, URL, or identifier of files that provide evidence for the finding.',
    `finding_description` STRING COMMENT 'Full description of the issue, including what was observed and why it matters.',
    `finding_title` STRING COMMENT 'Short, human‑readable title that captures the essence of the finding.',
    `finding_type` STRING COMMENT 'Category of the finding: non‑conformance, observation, or opportunity for improvement.. Valid values are `non_conformance|observation|opportunity`',
    `regulatory_requirement` STRING COMMENT 'Specific regulation, standard, or policy that the finding relates to (e.g., FDA Food Safety, OSHA Workplace Safety).',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time the finding was marked as resolved or closed.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating (e.g., 0.00‑10.00) reflecting the impact and likelihood.',
    `root_cause_analysis` STRING COMMENT 'Explanation of the underlying cause(s) that led to the finding.',
    `severity` STRING COMMENT 'Risk severity assigned to the finding (critical, major, or minor).. Valid values are `critical|major|minor`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the finding record.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding or observation identified during an audit engagement. Captures finding ID, linked audit engagement, finding type (non-conformance, observation, opportunity for improvement), severity (critical, major, minor), regulatory requirement violated, affected location and department, finding description, root cause analysis, and recommended corrective action. Drives the corrective action and remediation workflow post-audit.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee or team responsible for executing the corrective action.',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Corrective actions for drug‑related compliance issues (labeling, recall) must reference the exact drug involved.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Corrective actions are driven by a compliance program; linking provides program ownership.',
    `audit_finding_id` BIGINT COMMENT 'Identifier of the audit finding or issue that triggered this corrective action.',
    `food_safety_violation_id` BIGINT COMMENT 'Identifier of the regulatory violation (e.g., FDA, OSHA) linked to this corrective action.',
    `followup_corrective_action_id` BIGINT COMMENT 'Self-referencing FK on corrective_action (followup_corrective_action_id)',
    `action_description` STRING COMMENT 'Detailed description of the corrective or preventive action to be taken.',
    `action_title` STRING COMMENT 'Short, human‑readable title that identifies the corrective action.',
    `action_type` STRING COMMENT 'Classification of the CAPA as corrective, preventive, or both.. Valid values are `corrective|preventive|both`',
    `actual_completion_date` DATE COMMENT 'Date when the corrective action was actually completed.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail entries, comments, and observations.',
    `closure_approval_date` DATE COMMENT 'Date when the corrective action was formally approved as closed.',
    `closure_approved_by` BIGINT COMMENT 'Identifier of the employee or manager who approved the closure of the corrective action.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) applicable to the corrective action.. Valid values are `FDA|OSHA|USDA|DEA|FTC|EPA`',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action.. Valid values are `open|in_progress|completed|closed|rejected`',
    `cost` DECIMAL(18,2) COMMENT 'Estimated or actual monetary cost associated with implementing the corrective action.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action record was created.',
    `is_external` BOOLEAN COMMENT 'Indicates whether an external vendor, contractor, or regulator is involved in the corrective action.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the corrective action record.',
    `preventive_action_description` STRING COMMENT 'Description of any preventive measures added to avoid recurrence of the issue.',
    `priority` STRING COMMENT 'Priority for addressing the corrective action.. Valid values are `low|medium|high`',
    `risk_level` STRING COMMENT 'Risk rating assigned to the issue based on impact and likelihood.. Valid values are `low|medium|high|critical`',
    `root_cause_analysis` STRING COMMENT 'Narrative analysis identifying the underlying cause of the finding or violation.',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action should be completed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effective (e.g., audit, inspection, test).',
    `verification_status` STRING COMMENT 'Result of the verification activity.. Valid values are `pending|passed|failed`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record tracking the remediation of audit findings, regulatory violations, food safety incidents, and OSHA citations. Captures CAPA ID, linked finding or violation, assigned owner, corrective action description, preventive action description, target completion date, actual completion date, verification method, verification status, and closure approval. Manages the full CAPA lifecycle from identification through verified closure.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`food_safety_plan` (
    `food_safety_plan_id` BIGINT COMMENT 'Unique identifier for the food safety plan record.',
    `dc_facility_id` BIGINT COMMENT 'Internal identifier of the facility (store, DC, or production site) the plan applies to.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee responsible for the plan.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Food safety plans are part of a compliance program.',
    `superseded_food_safety_plan_id` BIGINT COMMENT 'Self-referencing FK on food_safety_plan (superseded_food_safety_plan_id)',
    `approval_date` DATE COMMENT 'Date the food safety plan was formally approved.',
    `audit_outcome` STRING COMMENT 'Result of the latest audit.. Valid values are `Pass|Fail|Conditional`',
    `compliance_status` STRING COMMENT 'Overall compliance determination against regulatory requirements.. Valid values are `Compliant|Non-Compliant|Pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the stored electronic version of the food safety plan document.',
    `effective_from` DATE COMMENT 'Date when the plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the plan expires or is superseded (nullable).',
    `food_safety_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `Draft|Active|Expired|Suspended`',
    `hazard_analysis_summary` STRING COMMENT 'Narrative summary of identified hazards and risk assessments.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating if the plan contains confidential information.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit of the plan.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the plan.',
    `plan_number` STRING COMMENT 'Business identifier code for the food safety plan (e.g., FS-2023-001).',
    `plan_scope` STRING COMMENT 'Description of the operational scope covered by the plan.',
    `plan_type` STRING COMMENT 'Classification of the food safety plan type as required by FDA regulations.. Valid values are `HACCP|HARPC|Preventive Controls`',
    `plan_version` STRING COMMENT 'Version identifier of the plan (e.g., v1.0, v2.1).',
    `preventive_controls_summary` STRING COMMENT 'Summary of preventive controls defined to mitigate identified hazards.',
    `regulatory_body` STRING COMMENT 'Primary regulatory agency governing the plan.. Valid values are `FDA|USDA|OSHA|EPA`',
    `revision_history` STRING COMMENT 'Chronological log of revisions made to the plan.',
    `risk_level` STRING COMMENT 'Overall risk rating associated with the plans hazards.. Valid values are `Low|Medium|High`',
    `training_completed_date` DATE COMMENT 'Date when required training was completed.',
    `training_required` BOOLEAN COMMENT 'Indicates whether staff training is required for this plan.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_food_safety_plan PRIMARY KEY(`food_safety_plan_id`)
) COMMENT 'Master record for FSMA-mandated food safety plans (HACCP/HARPC) at each Grocery store, DC, and food production facility. Captures plan ID, facility, plan type (HACCP, HARPC, Preventive Controls), plan version, approval date, next review date, plan owner, and the set of hazard analyses and preventive controls defined. Serves as the authoritative food safety management document required by FDA 21 CFR Part 117.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` (
    `food_safety_inspection_id` BIGINT COMMENT 'Unique system-generated identifier for the food safety inspection record.',
    `associate_id` BIGINT COMMENT 'System identifier of the inspector who performed the inspection.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Food safety inspections are conducted under a compliance program.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, pharmacy, bakery, deli, or distribution center where the inspection took place.',
    `followup_food_safety_inspection_id` BIGINT COMMENT 'Self-referencing FK on food_safety_inspection (followup_food_safety_inspection_id)',
    `agency` STRING COMMENT 'Agency or authority that conducted or oversaw the inspection.. Valid values are `FDA|USDA|Local_Health|Internal`',
    `compliance_area` STRING COMMENT 'Specific compliance domain addressed (e.g., hygiene, temperature control, labeling).',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which required corrective actions must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating if any corrective actions were mandated.',
    `critical_violations_count` STRING COMMENT 'Number of critical (high‑risk) violations identified.',
    `follow_up_inspection_date` DATE COMMENT 'Planned date for the follow‑up inspection, if required.',
    `follow_up_inspection_required` BOOLEAN COMMENT 'Indicates whether a follow‑up inspection is scheduled.',
    `food_category` STRING COMMENT 'Category of food items inspected (e.g., produce, dairy, bakery, pharmacy).',
    `food_safety_inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record.. Valid values are `pending|in_progress|completed|closed|reopened`',
    `hygiene_score` DECIMAL(18,2) COMMENT 'Numeric score assessing overall hygiene conditions.',
    `inspection_number` STRING COMMENT 'External or internal reference number assigned to the inspection.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose: routine, follow‑up, or complaint‑driven.. Valid values are `routine|follow_up|complaint_driven`',
    `inspector_name` STRING COMMENT 'Full legal name of the inspector conducting the inspection.',
    `non_critical_violations_count` STRING COMMENT 'Number of non‑critical (low‑risk) violations identified.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the inspector.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall result of the inspection, typically on a 0‑100 scale.',
    `rating` STRING COMMENT 'Outcome of the inspection: pass, conditional pass, fail, or closure order.. Valid values are `pass|conditional_pass|fail|closure_order`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record.',
    `temperature_control_verified` BOOLEAN COMMENT 'Indicates whether temperature control requirements were met.',
    `violation_details` STRING COMMENT 'Detailed description of each violation identified during the inspection.',
    CONSTRAINT pk_food_safety_inspection PRIMARY KEY(`food_safety_inspection_id`)
) COMMENT 'Transactional record of food safety inspections conducted at Grocery store locations, delis, bakeries, pharmacies, and DCs by regulatory agencies (FDA, USDA, local health departments) or internal food safety auditors. Captures inspection ID, location, inspection date, inspector name and agency, inspection type (routine, follow-up, complaint-driven), overall score or rating, critical violations count, non-critical violations count, and inspection outcome (pass, conditional pass, fail, closure order). Distinct from the general store.health_inspection which is store-domain owned; this record is the compliance-domain authoritative record for food safety regulatory inspections.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`food_safety_violation` (
    `food_safety_violation_id` BIGINT COMMENT 'Unique identifier for the food safety violation record.',
    `food_safety_inspection_id` BIGINT COMMENT 'Identifier of the inspection or monitoring event linked to this violation.',
    `product_item_id` BIGINT COMMENT 'Identifier of the SKU or product associated with the violation.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Food safety violations are tracked against a compliance program.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the violation occurred.',
    `related_food_safety_violation_id` BIGINT COMMENT 'Self-referencing FK on food_safety_violation (related_food_safety_violation_id)',
    `ccp_affected` STRING COMMENT 'Critical control point or prerequisite program impacted by the violation.. Valid values are `Temperature Control|Sanitation|Cross-Contamination|Allergen Control|Packaging|Labeling`',
    `corrective_action` STRING COMMENT 'Action taken on-site to remediate the violation.',
    `corrective_action_date` DATE COMMENT 'Date when the corrective action was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation record was first created in the system.',
    `detection_method` STRING COMMENT 'Method used to detect the violation.. Valid values are `Visual|Instrument|Lab Test|Audit`',
    `expiration_date` DATE COMMENT 'Expiration date of the affected product batch.',
    `food_category` STRING COMMENT 'Broad category of the food product involved in the violation.. Valid values are `Produce|Dairy|Meat|Bakery|Frozen`',
    `food_safety_violation_description` STRING COMMENT 'Detailed narrative describing the nature of the violation.',
    `food_safety_violation_status` STRING COMMENT 'Current lifecycle status of the violation record.. Valid values are `Open|Closed|In Review|Resolved`',
    `is_critical` BOOLEAN COMMENT 'True if the violation is deemed critical to public health.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for the product associated with the violation.',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulatory clause or statute cited for the violation.',
    `repeat_violation_flag` BOOLEAN COMMENT 'Indicates whether this violation is a repeat of a prior issue (true/false).',
    `reported_by` STRING COMMENT 'Name of the individual who reported the violation.',
    `reporter_role` STRING COMMENT 'Job role of the person reporting the violation.. Valid values are `Manager|Supervisor|Employee|Auditor`',
    `resolution_date` DATE COMMENT 'Date when the violation was formally resolved.',
    `resolution_notes` STRING COMMENT 'Additional notes regarding how the violation was resolved.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score calculated based on severity, repeat flag, and product impact.',
    `severity_level` STRING COMMENT 'Severity rating assigned to the violation.. Valid values are `High|Medium|Low`',
    `source_system` STRING COMMENT 'Originating system that captured the violation (e.g., SAP, Oracle, manual entry).. Valid values are `SAP|Oracle|Manual`',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature reading captured at the time of violation (if applicable).',
    `temperature_unit` STRING COMMENT 'Unit of measure for the recorded temperature (Celsius or Fahrenheit).. Valid values are `C|F`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `violation_code` STRING COMMENT 'Standard code representing the specific food safety violation as defined by FDA or local health authority.',
    `violation_timestamp` TIMESTAMP COMMENT 'Date and time when the violation was detected or recorded.',
    `violation_type` STRING COMMENT 'Classification of the violation based on impact severity.. Valid values are `Critical|Major|Minor`',
    CONSTRAINT pk_food_safety_violation PRIMARY KEY(`food_safety_violation_id`)
) COMMENT 'Individual food safety violation or critical control point (CCP) deviation identified during a food safety inspection or internal monitoring event. Captures violation ID, linked inspection or monitoring event, violation code (per FDA/local health code), violation description, CCP or prerequisite program affected, corrective action taken on-site, repeat violation flag, and regulatory citation reference. Drives targeted remediation and trend analysis for food safety risk management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`osha_citation` (
    `osha_citation_id` BIGINT COMMENT 'System-generated unique identifier for the OSHA citation record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: OSHA citations are issued within the context of a compliance program.',
    `store_location_id` BIGINT COMMENT 'Identifier of the Grocery store location where the violation occurred.',
    `related_osha_citation_id` BIGINT COMMENT 'Self-referencing FK on osha_citation (related_osha_citation_id)',
    `abatement_deadline` DATE COMMENT 'Date by which Grocery must correct the cited violation.',
    `affected_department` STRING COMMENT 'Business department or functional area within the store impacted by the citation (e.g., Warehouse, Front End).',
    `citation_date` DATE COMMENT 'Date the citation was formally issued by OSHA.',
    `citation_description` STRING COMMENT 'Narrative description of the violation and circumstances.',
    `citation_number` STRING COMMENT 'External citation number assigned by OSHA for tracking and reference.',
    `citation_status` STRING COMMENT 'Current lifecycle status of the citation.. Valid values are `issued|contested|settled|closed|withdrawn`',
    `citation_type` STRING COMMENT 'Classification of the citation based on severity and nature as defined by OSHA.. Valid values are `willful|serious|other_than_serious|repeat|failure_to_abate`',
    `contest_deadline` DATE COMMENT 'Last date to submit a formal contest or appeal.',
    `contest_status` STRING COMMENT 'Current status of any contest or appeal filed against the citation.. Valid values are `not_contested|contested|under_review|resolved`',
    `corrective_action_deadline` DATE COMMENT 'Date by which the required corrective actions must be completed.',
    `corrective_action_required` STRING COMMENT 'Specific actions required by OSHA to remediate the violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the citation record was first entered into the system.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for penalty amounts (e.g., USD).. Valid values are `USD`',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Monetary amount ultimately settled after negotiation or appeal.',
    `issuing_osha_office` STRING COMMENT 'Regional OSHA office that issued the citation.',
    `proposed_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary amount initially proposed by OSHA as a penalty.',
    `standard_violated` STRING COMMENT 'Specific OSHA or related regulatory standard (e.g., 29 CFR 1910.1200) that was violated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the citation record.',
    CONSTRAINT pk_osha_citation PRIMARY KEY(`osha_citation_id`)
) COMMENT 'OSHA citation record issued to Grocery following a workplace safety inspection or investigation. Captures citation ID, issuing OSHA area office, citation date, citation type (willful, serious, other-than-serious, repeat, failure-to-abate), standard violated (29 CFR reference), affected location and department, proposed penalty amount, abatement deadline, contest status, and final settlement amount. Distinct from workforce.safety_incident which captures the incident itself; this record captures the regulatory enforcement action.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory filing record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Regulatory filings are filed by specific legal entities, requiring a link to the entity’s financial record for compliance reporting.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Regulatory filings (e.g., DEA, state board) are submitted per pharmacy location, so the filing must reference that location.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: FDA/USDA filings are filed for individual products; the Regulatory Filing register tracks the product_item associated with each filing.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Regulatory filings are associated with a compliance program; adding compliance_program_id provides program context.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Regulatory filings (e.g., FDA, USDA) are tied to the supplier that provided the product; needed for audit trails.',
    `amended_regulatory_filing_id` BIGINT COMMENT 'Self-referencing FK on regulatory_filing (amended_regulatory_filing_id)',
    `agency` STRING COMMENT 'Government agency responsible for the filing (e.g., FDA, USDA, EPA, DEA).',
    `attached_document_path` STRING COMMENT 'File system or storage location of the submitted filing document.',
    `audit_status` STRING COMMENT 'Outcome of the latest audit.. Valid values are `passed|failed|not_started`',
    `compliance_notes` STRING COMMENT 'Additional remarks from compliance reviewers.',
    `compliance_status` STRING COMMENT 'Result of the most recent compliance review for this filing.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for the fee currency.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `data_source_system` STRING COMMENT 'Originating operational system (e.g., SAP, Oracle) that supplied the filing data.',
    `effective_date` DATE COMMENT 'Date the filing becomes legally effective.',
    `expiration_date` DATE COMMENT 'Date the filing expires or must be renewed (nullable for open‑ended filings).',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee associated with the filing, if any.',
    `filing_category` STRING COMMENT 'High‑level compliance domain the filing belongs to.. Valid values are `food_safety|workplace_safety|environmental|privacy|pharmacy|finance`',
    `filing_number` STRING COMMENT 'External reference number assigned by the regulatory agency or internal tracking system.',
    `filing_period` STRING COMMENT 'Reporting period covered by the filing (e.g., FY2023 Q1).',
    `filing_type` STRING COMMENT 'Category of the filing such as registration, certification, periodic report, license, or public notice.. Valid values are `registration|certification|report|license|notice`',
    `is_renewal` BOOLEAN COMMENT 'Indicates whether the filing is a renewal of a prior submission.',
    `jurisdiction` STRING COMMENT 'State, province, or country code where the filing applies.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit related to this filing.',
    `next_due_date` DATE COMMENT 'Date by which the next filing or renewal must be submitted.',
    `regulatory_filing_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the filing.',
    `regulatory_filing_status` STRING COMMENT 'Current lifecycle state of the filing.. Valid values are `draft|submitted|accepted|rejected|pending_renewal|closed`',
    `regulatory_section` STRING COMMENT 'Specific legal section or code referenced by the filing (e.g., 21 CFR Part 11).',
    `renewal_required` BOOLEAN COMMENT 'True if a future renewal is mandatory based on regulatory rules.',
    `submission_date` DATE COMMENT 'Date the filing was submitted to the agency.',
    `submission_method` STRING COMMENT 'How the filing was delivered to the agency.. Valid values are `electronic|paper|portal|email`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the filing record.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Master record for all mandatory regulatory filings and submissions made by Grocery to government agencies, including FDA facility registrations, USDA organic certifications, EPA Tier II chemical inventory reports, state alcohol beverage control license renewals, pharmacy DEA registrations, and CCPA privacy notices. Captures filing ID, regulatory agency, filing type, filing period, submission date, submission method, filing status (draft, submitted, accepted, rejected, pending renewal), and next due date.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`license_permit` (
    `license_permit_id` BIGINT COMMENT 'System‑generated unique identifier for the license or permit record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Licenses and permits are managed under a compliance program.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, legal entity, pharmacy, or fuel center that holds the license.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Many permits (e.g., alcohol, tobacco) are held by suppliers; linking permits to suppliers supports compliance reporting.',
    `renewed_from_license_permit_id` BIGINT COMMENT 'Self-referencing FK on license_permit (renewed_from_license_permit_id)',
    `attached_document_url` STRING COMMENT 'Link to scanned copy of the license or related documentation.',
    `authority_code` STRING COMMENT 'Standard code identifying the issuing authority (e.g., FDA, USDA).',
    `compliance_category` STRING COMMENT 'Regulatory domain the license belongs to (e.g., food safety, environmental). [ENUM-REF-CANDIDATE: food_safety|environmental|health|alcohol|tobacco|pharmacy|fuel — 7 candidates stripped; promote to reference product]',
    `compliance_deadline` DATE COMMENT 'Date by which any required corrective actions must be completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the license record was first created in the system.',
    `effective_date` DATE COMMENT 'Date the license becomes effective for business operations.',
    `expiration_date` DATE COMMENT 'Date the license expires and must be renewed.',
    `fee_currency` STRING COMMENT 'Currency of the renewal fee (e.g., USD).. Valid values are `USD`',
    `fee_paid_date` DATE COMMENT 'Date the renewal fee was paid.',
    `fee_status` STRING COMMENT 'Current payment status of the renewal fee.. Valid values are `paid|unpaid|partial|waived`',
    `holder_type` STRING COMMENT 'Type of entity that holds the license (store, legal entity, pharmacy, fuel center).. Valid values are `store|legal_entity|pharmacy|fuel_center`',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|pending|not_applicable`',
    `issue_date` DATE COMMENT 'Date the license was originally issued.',
    `issuing_authority` STRING COMMENT 'Government or agency that issued the license or permit. [ENUM-REF-CANDIDATE: FDA|USDA|DEA|State_Board_of_Pharmacy|EPA|FTC|OSHA|Local_Municipality — 8 candidates stripped; promote to reference product]',
    `jurisdiction` STRING COMMENT 'State or local jurisdiction code (e.g., CA, TX) where the license is valid.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection for this license.',
    `license_number` STRING COMMENT 'Official license or permit number assigned by the issuing authority.',
    `license_permit_description` STRING COMMENT 'Free‑form description of the license purpose and scope.',
    `license_permit_status` STRING COMMENT 'Overall operational status of the license.. Valid values are `active|inactive|suspended|revoked|expired`',
    `license_type` STRING COMMENT 'Category of the license (e.g., food handler, alcohol beverage, tobacco, pharmacy, fuel station, business operating). [ENUM-REF-CANDIDATE: food_handler|alcohol_beer|alcohol_wine|alcohol_spirits|tobacco|pharmacy|fuel|business_operating — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the license.',
    `renewal_date` DATE COMMENT 'Date the license was last renewed or is scheduled for renewal.',
    `renewal_fee` DECIMAL(18,2) COMMENT 'Monetary fee required for license renewal.',
    `renewal_status` STRING COMMENT 'Current renewal state of the license.. Valid values are `pending|renewed|expired|revoked|suspended`',
    `risk_level` STRING COMMENT 'Risk classification associated with the license based on compliance history.. Valid values are `low|medium|high|critical`',
    `scope` STRING COMMENT 'Geographic or operational scope covered by the license.. Valid values are `state|county|city|national|international`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the license record.',
    CONSTRAINT pk_license_permit PRIMARY KEY(`license_permit_id`)
) COMMENT 'Master record for all business licenses, operating permits, and regulatory certifications held by Grocery locations and entities, including food handler permits, alcohol beverage licenses (beer/wine/spirits), tobacco retail licenses, pharmacy licenses, fuel station operating permits, and business operating licenses. Captures license ID, license type, issuing authority, license number, holder (store or legal entity), issue date, expiration date, renewal status, and associated fees. Drives license renewal workflows and expiration alerts.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`privacy_request` (
    `privacy_request_id` BIGINT COMMENT 'Unique identifier for the privacy request record.',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Privacy requests often target loyalty member data; linking to membership enables precise data retrieval.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Privacy data retrieval: privacy requests may require extracting transaction details for a shopper, linking request to the exact transaction.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Privacy requests are governed by a compliance program.',
    `rx_patient_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_patient. Business justification: HIPAA privacy requests often target a specific patient’s prescription data; linking to rx_patient enables proper processing.',
    `shopper_id` BIGINT COMMENT 'Identifier of the individual or household that submitted the privacy request.',
    `amended_privacy_request_id` BIGINT COMMENT 'Self-referencing FK on privacy_request (amended_privacy_request_id)',
    `closure_timestamp` TIMESTAMP COMMENT 'Date and time when the privacy request was closed.',
    `data_category` STRING COMMENT 'Broad category of personal data the request pertains to.. Valid values are `personal|financial|health|other`',
    `data_scope` STRING COMMENT 'Scope of data covered by the request (e.g., all data, specific items).. Valid values are `all|specific_items|profile`',
    `fulfillment_status` STRING COMMENT 'Current status of the request fulfillment process.. Valid values are `pending|in_progress|completed|denied|expired`',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Date and time when the request reached its current fulfillment status.',
    `notes` STRING COMMENT 'Internal notes added by compliance staff during processing.',
    `privacy_law` STRING COMMENT 'Regulatory framework governing the request (e.g., CCPA, GDPR).. Valid values are `ccpa|gdpr|california_privacy|other`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the privacy request record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the privacy request record.',
    `request_details` STRING COMMENT 'Additional details or specifications supplied with the privacy request.',
    `request_number` STRING COMMENT 'External reference number assigned to the privacy request for tracking.',
    `request_reason` STRING COMMENT 'Free‑text description of the reason for the privacy request, as provided by the requestor.',
    `request_type` STRING COMMENT 'Type of consumer privacy right being exercised (e.g., access, deletion, correction, portability, opt‑out of sale).. Valid values are `access|deletion|correction|portability|opt_out`',
    `requestor_type` STRING COMMENT 'Classification of the requestor (e.g., shopper, household, employee).. Valid values are `shopper|household|employee`',
    `response_due_date` DATE COMMENT 'Statutory deadline by which the request must be responded to.',
    `submission_channel` STRING COMMENT 'Channel through which the privacy request was received.. Valid values are `web|phone|in_store|email|mail`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the privacy request was submitted.',
    `verification_status` STRING COMMENT 'Current verification state of the requestors identity.. Valid values are `pending|verified|rejected`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the requestors identity was verified.',
    CONSTRAINT pk_privacy_request PRIMARY KEY(`privacy_request_id`)
) COMMENT 'Transactional record for consumer privacy rights requests received by Grocery under CCPA, state privacy laws, and internal privacy policies. Captures request ID, request type (access, deletion, opt-out of sale, correction, portability), requestor identity (shopper or household reference), submission channel (web form, phone, in-store), submission date, verification status, response due date (statutory deadline), fulfillment status, and closure date. Manages the full CCPA/privacy request lifecycle from intake through verified fulfillment.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`privacy_incident` (
    `privacy_incident_id` BIGINT COMMENT 'System-generated unique identifier for the privacy incident record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Privacy incidents are tracked within a compliance program.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to customer.shopper. Business justification: Required for breach reporting: each privacy incident must identify the affected shopper per data protection regulations.',
    `related_privacy_incident_id` BIGINT COMMENT 'Self-referencing FK on privacy_incident (related_privacy_incident_id)',
    `affected_data_categories` STRING COMMENT 'Data classifications impacted by the incident (e.g., Personally Identifiable Information).. Valid values are `PII|PHI|PCI|Other`',
    `affected_party` STRING COMMENT 'Name or identifier of the party (customer, employee, vendor) whose data was impacted.',
    `affected_systems` STRING COMMENT 'List of internal systems or applications where the breach occurred.',
    `containment_actions` STRING COMMENT 'Actions taken to stop further data exposure (e.g., system isolation, password reset).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was initially created in the system.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time the incident was first detected.',
    `estimated_affected_individuals` BIGINT COMMENT 'Approximate count of distinct individuals whose data was compromised.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary loss or cost associated with the breach.',
    `incident_number` STRING COMMENT 'Business identifier assigned to the incident (e.g., INC-2023-0001).',
    `incident_severity` STRING COMMENT 'Risk rating based on impact and sensitivity of data exposed.. Valid values are `low|medium|high|critical`',
    `incident_type` STRING COMMENT 'Category describing how the privacy breach occurred.. Valid values are `unauthorized_access|data_leak|phishing|malware|vendor_violation`',
    `investigation_owner` STRING COMMENT 'Name of the employee or team responsible for the incident investigation.',
    `notes` STRING COMMENT 'Free-form field for additional comments, observations, or follow‑up actions.',
    `notification_deadline` DATE COMMENT 'Legal deadline by which affected parties must be notified.',
    `privacy_incident_status` STRING COMMENT 'Current lifecycle state of the privacy incident.. Valid values are `open|investigating|contained|resolved|closed`',
    `regulatory_notifications` STRING COMMENT 'Regulators or authorities notified about the incident (e.g., HIPAA, FTC).',
    `resolution_date` DATE COMMENT 'Date the incident was fully resolved and closed.',
    `root_cause` STRING COMMENT 'Underlying reason for the incident (e.g., misconfiguration, insider threat).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident record.',
    CONSTRAINT pk_privacy_incident PRIMARY KEY(`privacy_incident_id`)
) COMMENT 'Operational record for data privacy incidents and potential data breaches at Grocery, including unauthorized access to shopper PII, pharmacy patient data exposure, payment card data incidents, and vendor data sharing violations. Captures incident ID, incident type, discovery date, affected data categories (PII, PHI, PCI), estimated number of affected individuals, affected systems, containment actions taken, regulatory notification obligations triggered (state breach notification laws, HIPAA), notification deadlines, and incident status. Distinct from payment.fraud_case which covers payment fraud.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`ada_assessment` (
    `ada_assessment_id` BIGINT COMMENT 'System-generated unique identifier for each ADA accessibility assessment record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: ADA assessments are part of a compliance program.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the store location being assessed.',
    `followup_ada_assessment_id` BIGINT COMMENT 'Self-referencing FK on ada_assessment (followup_ada_assessment_id)',
    `ada_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment record.. Valid values are `pending|in_progress|completed|closed`',
    `assessment_date` DATE COMMENT 'Calendar date on which the ADA assessment was performed.',
    `assessment_number` STRING COMMENT 'Human‑readable identifier or code assigned to the assessment (e.g., AA‑2023‑001).',
    `assessment_type` STRING COMMENT 'Classification of how the assessment was conducted: self‑assessment, third‑party, or DOJ‑driven.. Valid values are `self|third_party|doj_driven`',
    `assessor_name` STRING COMMENT 'Full name of the individual or firm that performed the assessment.',
    `barriers_identified` STRING COMMENT 'Narrative description of physical or digital accessibility barriers discovered during the assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assessment record was first created in the system.',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Projected monetary cost to remediate all identified barriers, expressed in USD.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations captured by the assessor.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation activities should be completed.',
    `remediation_priority` STRING COMMENT 'Priority level assigned to address identified barriers, based on impact and regulatory risk.. Valid values are `low|medium|high|critical`',
    `remediation_status` STRING COMMENT 'Current progress status of the remediation work.. Valid values are `not_started|in_progress|completed|deferred`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assessment record.',
    CONSTRAINT pk_ada_assessment PRIMARY KEY(`ada_assessment_id`)
) COMMENT 'ADA (Americans with Disabilities Act) accessibility assessment record for Grocery store locations, capturing the evaluation of physical accessibility compliance including parking, entrance ramps, aisle widths, restroom accessibility, checkout lane accessibility, and digital accessibility (website/app WCAG compliance). Captures assessment ID, location, assessment date, assessor, assessment type (self-assessment, third-party, DOJ-driven), barriers identified, remediation priority, estimated remediation cost, and remediation status.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`environmental_compliance` (
    `environmental_compliance_id` BIGINT COMMENT 'Unique system-generated identifier for each environmental compliance record.',
    `compliance_document_id` BIGINT COMMENT 'Reference key for the scanned or digital compliance document.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Environmental compliance records are scoped to a compliance program.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the physical location (store, distribution center, fuel station, etc.) that the compliance record pertains to.',
    `superseded_environmental_compliance_id` BIGINT COMMENT 'Self-referencing FK on environmental_compliance (superseded_environmental_compliance_id)',
    `agency_contact` STRING COMMENT 'Phone number or email address for the agency liaison.',
    `agency_name` STRING COMMENT 'Name of the government or state agency overseeing the regulation (e.g., EPA, State Environmental Agency).',
    `compliance_cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the compliance cost amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `compliance_cost_estimated` BOOLEAN COMMENT 'True if the compliance cost is an estimate; false if actual.',
    `compliance_cost_usd` DECIMAL(18,2) COMMENT 'Monetary cost incurred to achieve compliance, expressed in US dollars.',
    `compliance_period_end` DATE COMMENT 'Last day of the reporting period for which compliance is measured.',
    `compliance_period_start` DATE COMMENT 'First day of the reporting period for which compliance is measured.',
    `compliance_status` STRING COMMENT 'Overall status indicating whether the facility met the regulatory requirements for the period.. Valid values are `compliant|non_compliant|pending|under_review|exempt`',
    `corrective_action_status` STRING COMMENT 'Progress state of the remediation work.. Valid values are `not_started|in_progress|completed`',
    `correspondence_date` DATE COMMENT 'Date when the last formal communication with the agency occurred.',
    `correspondence_method` STRING COMMENT 'Channel through which the agency communication was delivered.. Valid values are `email|phone|mail|portal`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the compliance record was first entered into the system.',
    `document_received_date` DATE COMMENT 'Date the supporting compliance documentation was received by the organization.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity or fuel energy used by the facility, expressed in megawatt‑hours.',
    `epa_compliance_flag` BOOLEAN COMMENT 'True if the facility is in full compliance with applicable EPA regulations.',
    `facility_name` STRING COMMENT 'Human‑readable name of the facility.',
    `hazardous_waste_quantity_tons` DECIMAL(18,2) COMMENT 'Total amount of hazardous waste generated, expressed in short tons.',
    `hazardous_waste_type` STRING COMMENT 'Classification of hazardous waste (e.g., universal waste, PCB, lead‑acid battery).',
    `inspection_date` DATE COMMENT 'Date on which the regulatory agency performed the latest inspection.',
    `inspector_name` STRING COMMENT 'Name of the person or team that conducted the inspection.',
    `last_inspection_outcome` STRING COMMENT 'Result of the latest inspection: pass, fail, or conditional.. Valid values are `pass|fail|conditional`',
    `notes` STRING COMMENT 'Additional comments or observations related to the compliance record.',
    `record_status` STRING COMMENT 'Indicates whether the record is currently active, inactive, or archived.. Valid values are `active|inactive|archived`',
    `refrigerant_quantity_kg` DECIMAL(18,2) COMMENT 'Total weight of refrigerant stored or in use at the facility, measured in kilograms.',
    `refrigerant_type` STRING COMMENT 'Chemical name or code of the refrigerant (e.g., R‑410A, R‑22).',
    `regulation_code` STRING COMMENT 'Standard code or identifier for the specific regulation (e.g., EPA‑608, EPA‑UST).',
    `regulation_type` STRING COMMENT 'Broad category of the environmental regulation applicable to the record.',
    `remediation_action` STRING COMMENT 'Description of the corrective steps required to address the violations.',
    `remediation_deadline` DATE COMMENT 'Date by which the corrective actions must be finished to avoid penalties.',
    `source_system` STRING COMMENT 'Name of the operational system of record (e.g., SAP, custom EPA interface).',
    `stormwater_permit_expiry` DATE COMMENT 'Date on which the stormwater permit becomes invalid unless renewed.',
    `stormwater_permit_number` STRING COMMENT 'Identifier of the NPDES stormwater permit issued to the facility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the compliance record.',
    `usta_compliance_flag` BOOLEAN COMMENT 'True if the facility meets all Underground Storage Tank (UST) regulatory requirements.',
    `violation_count` STRING COMMENT 'Number of separate regulatory violations recorded for the inspection.',
    `violation_details` STRING COMMENT 'Full narrative of each violation, including citation numbers and regulatory references.',
    `violation_summary` STRING COMMENT 'High‑level description of the violations identified.',
    CONSTRAINT pk_environmental_compliance PRIMARY KEY(`environmental_compliance_id`)
) COMMENT 'Environmental regulatory compliance record for Grocery operations covering EPA and state environmental obligations including refrigerant management (EPA Section 608), underground storage tank (UST) compliance, hazardous waste disposal (RCRA), stormwater permits (NPDES), and energy reporting. Captures record ID, facility, environmental regulation type, compliance period, compliance status, inspection date, violations identified, remediation actions, and regulatory agency correspondence. Complements fuel.epa_compliance_report which is fuel-center-specific; this record covers all non-fuel environmental compliance.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Unique surrogate key for each training completion record.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate who completed the training.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Training completions are required by a compliance program.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store or facility where training was completed.',
    `training_requirement_id` BIGINT COMMENT 'Identifier of the required training program.',
    `retake_of_training_completion_id` BIGINT COMMENT 'Self-referencing FK on training_completion (retake_of_training_completion_id)',
    `assessment_pass_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the assessment.',
    `assessment_type` STRING COMMENT 'Type of assessment used to evaluate the associate.. Valid values are `quiz|exam|simulation`',
    `audit_trail` STRING COMMENT 'Log of changes made to the training completion record.',
    `certificate_number` STRING COMMENT 'Unique certificate number issued upon successful completion.',
    `completion_number` STRING COMMENT 'Business identifier assigned to the training completion record.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the associate completed the training.',
    `compliance_area` STRING COMMENT 'Specific compliance domain addressed (e.g., Food Safety, Workplace Safety).',
    `compliance_status` STRING COMMENT 'Resulting compliance status after training.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method used to deliver the training to the associate.. Valid values are `online|in_person|blended`',
    `duration_minutes` STRING COMMENT 'Length of the training session in minutes.',
    `expiration_date` DATE COMMENT 'Date when the training certification expires and must be renewed.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the training is mandatory for the associates role.',
    `language` STRING COMMENT 'Language in which the training was delivered.',
    `notes` STRING COMMENT 'Additional remarks or observations about the training completion.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the associate passed the training.. Valid values are `pass|fail`',
    `regulatory_program` STRING COMMENT 'Regulatory program satisfied by this training (e.g., FDA, OSHA, HIPAA).',
    `role_required` STRING COMMENT 'Job role for which the training is required.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the associate on the training assessment.',
    `source_system` STRING COMMENT 'Originating system of the record (e.g., Kronos, Workday).',
    `training_category` STRING COMMENT 'Broad category of the training (e.g., Safety, Data Privacy, Food Safety).',
    `training_completion_status` STRING COMMENT 'Current lifecycle status of the training completion.. Valid values are `completed|in_progress|failed|revoked`',
    `training_title` STRING COMMENT 'Descriptive title of the training program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Version identifier of the training content.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Transactional record of individual associate compliance training completions tracked by the compliance domain for regulatory reporting purposes. Captures completion ID, associate reference, training requirement, completion date, training delivery method, score achieved, pass/fail status, certificate number, expiration date, and the regulatory program it satisfies. Complements workforce.certification (which tracks professional licenses and certifications) by focusing specifically on mandatory regulatory compliance training completions needed for audit evidence.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique system-generated identifier for each policy record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Policies are scoped to a compliance program.',
    `superseded_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (superseded_policy_id)',
    `applicability_scope` STRING COMMENT 'Describes where the policy applies (e.g., "All US stores", "Pharmacy department").',
    `approval_authority` STRING COMMENT 'Name of the person or title who granted final approval for the policy.',
    `attached_document_path` STRING COMMENT 'Location of the electronic policy document in the document repository.',
    `compliance_area` STRING COMMENT 'Regulatory domain linked to the policy (e.g., "FDA Food Safety", "OSHA Workplace Safety").',
    `confidentiality_level` STRING COMMENT 'Data classification indicating how the policy content should be handled.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy entry was initially loaded.',
    `effective_date` DATE COMMENT 'Calendar date on which the policy starts to apply.',
    `expiration_date` DATE COMMENT 'Calendar date when the policy is no longer in force (null for indefinite).',
    `is_mandatory` BOOLEAN COMMENT 'True if the policy must be followed; false if advisory.',
    `last_review_date` DATE COMMENT 'Calendar date when the policy was last reviewed.',
    `next_review_date` DATE COMMENT 'Calendar date scheduled for the upcoming policy review.',
    `owning_department` STRING COMMENT 'Internal department responsible for the policy (e.g., "Food Safety", "HR", "Legal").',
    `policy_code` STRING COMMENT 'Human‑readable alphanumeric code that uniquely identifies the policy within Grocery.',
    `policy_description` STRING COMMENT 'Narrative explaining the intent, requirements, and key provisions of the policy.',
    `policy_name` STRING COMMENT 'Full descriptive name of the policy (e.g., "Food Safety Standard Operating Procedure").',
    `policy_status` STRING COMMENT 'Indicates whether the policy is in draft, active, inactive, revoked, or pending approval.. Valid values are `draft|active|inactive|revoked|pending`',
    `policy_type` STRING COMMENT 'Category of the policy indicating its regulatory or operational domain.. Valid values are `food_safety|osha|privacy|code_of_conduct|alcohol_sales|age_verification`',
    `regulatory_reference` STRING COMMENT 'Citation of the specific law, regulation, or standard (e.g., "21 CFR Part 117").',
    `retention_period_days` STRING COMMENT 'Number of days the policy record must be retained for audit purposes.',
    `review_cycle` STRING COMMENT 'Scheduled interval at which the policy must be reviewed and re‑approved.. Valid values are `annual|biennial|quarterly|monthly|ad_hoc`',
    `revision_number` STRING COMMENT 'Sequential integer incremented each time the policy is revised.',
    `source_system` STRING COMMENT 'Name of the originating system (e.g., "SAP Governance Module").',
    `status_change_date` DATE COMMENT 'Calendar date when the status reason was applied.',
    `status_reason` STRING COMMENT 'Free‑text explanation why the policy is in its current status.',
    `tags` STRING COMMENT 'User‑defined tags that aid discovery and categorization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to any policy field.',
    `version` STRING COMMENT 'Human‑readable version label (e.g., "v2.3").',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master record for all internal compliance policies, standard operating procedures (SOPs), and codes of conduct governing Grocery operations. Captures policy ID, policy name, policy type (food safety SOP, OSHA safety policy, privacy policy, code of conduct, alcohol sales policy, age verification policy), owning department, policy version, effective date, review cycle, approval authority, and applicability scope. Serves as the authoritative policy register driving compliance obligation fulfillment.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` (
    `policy_acknowledgment_id` BIGINT COMMENT 'System-generated unique identifier for each policy acknowledgment record.',
    `associate_id` BIGINT COMMENT 'Unique identifier of the associate (employee) who acknowledged the policy.',
    `policy_id` BIGINT COMMENT 'Unique identifier of the compliance policy, SOP, or code of conduct being acknowledged.',
    `prior_policy_acknowledgment_id` BIGINT COMMENT 'Self-referencing FK on policy_acknowledgment (prior_policy_acknowledgment_id)',
    `acknowledgment_number` STRING COMMENT 'Human‑readable reference number assigned to the acknowledgment event.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the associate completed the acknowledgment.',
    `compliance_status` STRING COMMENT 'Result of compliance verification after acknowledgment (e.g., compliant, non‑compliant, pending review).. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the acknowledgment record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date after which the acknowledgment is no longer valid and must be renewed.',
    `method` STRING COMMENT 'Mechanism used for acknowledgment: electronic signature, paper form, or Learning Management System.. Valid values are `electronic_signature|paper|lms`',
    `notes` STRING COMMENT 'Optional free‑text comments entered by the associate or auditor at the time of acknowledgment.',
    `policy_acknowledgment_status` STRING COMMENT 'Current lifecycle state of the acknowledgment (e.g., active, expired, revoked, pending).. Valid values are `active|expired|revoked|pending`',
    `required_reacknowledgment_date` DATE COMMENT 'Date by which the associate must re‑acknowledge the policy if periodic renewal is required.',
    `signature_hash` STRING COMMENT 'Cryptographic hash of the electronic signature for integrity verification.',
    `source_system` STRING COMMENT 'Originating operational system (e.g., Workday HCM, Kronos, custom LMS) that captured the acknowledgment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the acknowledgment record.',
    CONSTRAINT pk_policy_acknowledgment PRIMARY KEY(`policy_acknowledgment_id`)
) COMMENT 'Transactional record capturing associate acknowledgment of compliance policies, codes of conduct, and mandatory SOPs. Captures acknowledgment ID, associate reference, policy reference, acknowledgment date, acknowledgment method (electronic signature, paper, LMS), and expiration date for policies requiring periodic re-acknowledgment. Provides audit evidence that associates have read and agreed to key compliance policies such as the code of conduct, anti-harassment policy, and food safety SOPs.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` (
    `age_restricted_sale_id` BIGINT COMMENT 'System-generated unique identifier for each age-restricted sale event.',
    `associate_id` BIGINT COMMENT 'Identifier of the store associate who performed the age verification.',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Age‑restricted sale compliance report must identify the loyalty member who made the purchase.',
    `product_item_id` BIGINT COMMENT 'Identifier of the age‑restricted product sold (SKU/UPC).',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the sale occurred.',
    `payment_transaction_id` BIGINT COMMENT 'Identifier of the POS transaction that includes this age‑restricted sale line.',
    `override_age_restricted_sale_id` BIGINT COMMENT 'Self-referencing FK on age_restricted_sale (override_age_restricted_sale_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the age‑restricted sale record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the sale amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `customer_apparent_age` STRING COMMENT 'Age estimated or disclosed by the customer at the time of verification.',
    `id_type_presented` STRING COMMENT 'Type of government‑issued ID the customer presented for age verification.. Valid values are `drivers_license|passport|state_id|other`',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the parent transaction.',
    `product_category` STRING COMMENT 'Category of the age‑restricted product sold.. Valid values are `alcohol|tobacco|lottery|otc_medication`',
    `quantity` STRING COMMENT 'Number of units of the product sold in this line.',
    `refusal_reason` STRING COMMENT 'Reason provided when verification was refused (e.g., underage, invalid ID).',
    `register_number` STRING COMMENT 'Identifier of the POS register or self‑checkout kiosk used for the transaction.',
    `sale_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the age‑restricted sale line.',
    `sale_timestamp` TIMESTAMP COMMENT 'Date and time when the age‑restricted sale was completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the age‑restricted sale record.',
    `verification_outcome` STRING COMMENT 'Result of the age verification check.. Valid values are `approved|refused`',
    CONSTRAINT pk_age_restricted_sale PRIMARY KEY(`age_restricted_sale_id`)
) COMMENT 'Transactional record of age-restricted product sales events (alcohol, tobacco, lottery, certain OTC medications) at Grocery POS and self-checkout, capturing the ID verification check performed. Captures transaction ID, store location, register ID, sale date and time, product category (alcohol, tobacco, lottery), ID type presented (drivers license, passport, state ID), customer apparent age, associate ID who verified, verification outcome (approved, refused), and refusal reason. Supports alcohol beverage control compliance and tobacco retail license requirements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`risk` (
    `risk_id` BIGINT COMMENT 'Unique identifier for each compliance risk record.',
    `associate_id` BIGINT COMMENT 'FK to workforce.associate',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Product‑level risk assessments (e.g., contamination risk) are recorded in Compliance Risk; linking to product_item enables the Product Risk Dashboard.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Risks are registered under a compliance program.',
    `risk_associate_id` BIGINT COMMENT 'Identifier of the employee responsible for managing the risk.',
    `risk_escalation_contact_associate_id` BIGINT COMMENT 'Identifier of the person to contact for escalations.',
    `parent_risk_id` BIGINT COMMENT 'Self-referencing FK on risk (parent_risk_id)',
    `affected_business_area` STRING COMMENT 'Business function or division impacted by the risk.. Valid values are `store_operations|supply_chain|pharmacy|digital_commerce|finance|vendor_management`',
    `classification` STRING COMMENT 'Broad classification indicating the nature of the risk.. Valid values are `strategic|operational|financial|compliance`',
    `compliance_area` STRING COMMENT 'Specific compliance domain the risk belongs to.. Valid values are `food_safety|workplace_safety|data_privacy|environmental|financial_reporting`',
    `control_description` STRING COMMENT 'Narrative of the control(s) currently in place to mitigate the risk.',
    `control_effectiveness_score` STRING COMMENT 'Effectiveness rating (0‑5) of existing controls mitigating the risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk record was first created.',
    `documentation_link` STRING COMMENT 'URL or path to supporting documentation for the risk.',
    `inherent_impact_score` STRING COMMENT 'Potential business impact rating (0‑5) if the risk materialises before controls.',
    `inherent_likelihood_score` STRING COMMENT 'Probability rating (0‑5) of the risk occurring before controls.',
    `inherent_risk_rating` STRING COMMENT 'Combined inherent risk rating derived from likelihood and impact.. Valid values are `low|moderate|high|critical`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent risk review activity.',
    `mitigation_due_date` DATE COMMENT 'Target date for completing mitigation activities.',
    `mitigation_plan` STRING COMMENT 'Planned actions and steps to reduce residual risk.',
    `mitigation_status` STRING COMMENT 'Current execution status of the mitigation plan.. Valid values are `not_started|in_progress|completed|deferred`',
    `next_review_due_date` DATE COMMENT 'Planned date for the next scheduled risk review.',
    `priority` STRING COMMENT 'Priority level used for scheduling remediation activities.. Valid values are `low|medium|high|critical`',
    `regulation_reference` STRING COMMENT 'Official code or citation of the regulation (e.g., 21 CFR Part 11).',
    `regulatory_body` STRING COMMENT 'Governing agency associated with the compliance requirement. [ENUM-REF-CANDIDATE: FDA|USDA|DEA|OSHA|FTC|EPA|HIPAA|SOX — 8 candidates stripped; promote to reference product]',
    `residual_impact_score` STRING COMMENT 'Impact rating (0‑5) after controls are applied.',
    `residual_likelihood_score` STRING COMMENT 'Probability rating (0‑5) after accounting for controls.',
    `residual_risk_rating` STRING COMMENT 'Overall residual risk rating after controls.. Valid values are `low|moderate|high|critical`',
    `review_date` DATE COMMENT 'Date of the most recent formal risk review.',
    `risk_category` STRING COMMENT 'High‑level classification of the risk domain.. Valid values are `food_safety|workplace_safety|data_privacy|environmental|licensing|financial`',
    `risk_description` STRING COMMENT 'Detailed narrative describing the nature and cause of the risk.',
    `risk_name` STRING COMMENT 'Descriptive title of the compliance risk.',
    `risk_source` STRING COMMENT 'Origin of the risk identification.. Valid values are `internal|external|audit|incident`',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk.. Valid values are `open|closed|monitoring|escalated`',
    `severity` STRING COMMENT 'Severity rating reflecting potential business disruption.. Valid values are `low|medium|high|critical`',
    `tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for categorisation.',
    `treatment_strategy` STRING COMMENT 'Chosen approach to address the risk.. Valid values are `accept|mitigate|transfer|avoid`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk record.',
    CONSTRAINT pk_risk PRIMARY KEY(`risk_id`)
) COMMENT 'Compliance risk register record identifying, assessing, and tracking enterprise compliance risks across all regulatory domains. Captures risk ID, risk name, risk category (food safety, workplace safety, data privacy, environmental, licensing, financial), affected business area, inherent likelihood and impact scores, current control effectiveness, residual risk rating, risk owner, risk treatment strategy (accept, mitigate, transfer, avoid), and risk review date. Provides the enterprise compliance risk posture view for the Chief Compliance Officer.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique system-generated identifier for the regulatory change record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Regulatory changes impact a compliance program; adding compliance_program_id links the change to its program.',
    `superseded_regulatory_change_id` BIGINT COMMENT 'Self-referencing FK on regulatory_change (superseded_regulatory_change_id)',
    `attached_document_path` STRING COMMENT 'File system or storage path to the regulatory document or filing associated with the change.',
    `change_announced_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory change was first announced to the organization.',
    `change_number` STRING COMMENT 'Human‑readable identifier assigned to the regulatory change (e.g., CHG‑2024‑001).',
    `change_type` STRING COMMENT 'Nature of the regulatory change: new rule, amendment to an existing rule, or repeal of a rule.. Valid values are `new|amendment|repeal`',
    `compliance_category` STRING COMMENT 'High‑level compliance domain the change belongs to.. Valid values are `food_safety|occupational|environmental|privacy|financial|pharmacy`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory change record was first created in the lakehouse.',
    `enacted_effective_date` DATE COMMENT 'Actual date the regulation becomes legally binding after enactment.',
    `impact_assessment_status` STRING COMMENT 'Progress of the impact assessment for the regulatory change.. Valid values are `not_started|in_progress|completed|deferred`',
    `impacted_business_areas` STRING COMMENT 'Comma‑separated list of business domains (e.g., Store Operations, Pharmacy, Supply Chain) affected by the change.',
    `implementation_owner_name` STRING COMMENT 'Name of the individual responsible for implementing the regulatory change.',
    `implementation_owner_role` STRING COMMENT 'Job role or title of the implementation owner (e.g., Compliance Manager).',
    `last_review_date` DATE COMMENT 'Date when the regulatory change was last reviewed for relevance or status.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by compliance analysts.',
    `priority` STRING COMMENT 'Business priority assigned to the regulatory change.. Valid values are `low|medium|high|critical`',
    `proposed_effective_date` DATE COMMENT 'Date the regulator proposes the change to become effective.',
    `regulation_name` STRING COMMENT 'Official name or title of the regulation (e.g., Food Safety Modernization Act).',
    `regulation_section` STRING COMMENT 'Specific section, clause, or article of the regulation that is changing.',
    `regulatory_body` STRING COMMENT 'Governing agency or authority issuing the regulation. [ENUM-REF-CANDIDATE: FDA|USDA|OSHA|EPA|FTC|DEA|State|HIPAA|PCI|SOX — promote to reference product]',
    `regulatory_change_description` STRING COMMENT 'Detailed narrative describing the regulatory change and its intent.',
    `regulatory_change_status` STRING COMMENT 'Current lifecycle state of the regulatory change.. Valid values are `proposed|review|approved|enacted|rejected`',
    `required_operational_changes` STRING COMMENT 'Summary of operational actions needed to comply with the change (e.g., label redesign, process update).',
    `risk_level` STRING COMMENT 'Overall risk rating associated with non‑compliance.. Valid values are `low|moderate|high|critical`',
    `source_system` STRING COMMENT 'Originating system or source that supplied the regulatory change record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the regulatory change record.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Transactional record tracking proposed and enacted regulatory changes that may impact Grocery operations, including new FDA food labeling rules, OSHA standard updates, state privacy law amendments, EPA refrigerant regulation changes, and minimum wage law updates. Captures change ID, regulatory body, regulation affected, change description, proposed effective date, enacted effective date, impact assessment status, impacted business areas, required operational changes, and implementation owner. Drives proactive compliance gap analysis and remediation planning.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`weights_measures` (
    `weights_measures_id` BIGINT COMMENT 'Unique surrogate identifier for each weights and measures compliance record.',
    `associate_id` BIGINT COMMENT 'Employee identifier of the inspector responsible for the calibration.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Weights and measures devices are governed by a compliance program.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the device is installed.',
    `prior_calibration_weights_measures_id` BIGINT COMMENT 'Self-referencing FK on weights_measures (prior_calibration_weights_measures_id)',
    `calibration_certificate_number` STRING COMMENT 'Reference number of the calibration certificate issued by the certifying authority.',
    `calibration_method` STRING COMMENT 'Method used to calibrate the device.. Valid values are `internal|external|automated`',
    `certification_date` DATE COMMENT 'Date the device received its initial compliance certification.',
    `certification_expiry_date` DATE COMMENT 'Date the current certification becomes invalid and must be renewed.',
    `compliance_status` STRING COMMENT 'Current compliance state of the device with applicable state and federal regulations.. Valid values are `compliant|non_compliant|pending|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance record was first created in the system.',
    `device_name` STRING COMMENT 'Human‑readable name or label assigned to the weighing or measuring device.',
    `device_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number that uniquely identifies the device across the enterprise.',
    `device_type` STRING COMMENT 'Category of the device used for weight or measure capture.. Valid values are `scale|scanner|measure_device`',
    `inspector_name` STRING COMMENT 'Name of the person who performed the most recent calibration or certification inspection.',
    `jurisdiction_state` STRING COMMENT 'U.S. state code governing the metrology requirements for the device. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product] ',
    `last_calibrated_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the device was last calibrated.',
    `measurement_category` STRING COMMENT 'High‑level classification of what the device measures (e.g., weight, volume, dimension).. Valid values are `weight|volume|dimension`',
    `measurement_unit` STRING COMMENT 'Unit of measure used by the device for reporting values.. Valid values are `kg|lb|g|oz`',
    `next_calibration_due` DATE COMMENT 'Scheduled date for the next mandatory calibration of the device.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or observations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance record.',
    `variance_tolerance_kg` DECIMAL(18,2) COMMENT 'Maximum allowable weight variance in kilograms as defined by state metrology standards.',
    `variance_tolerance_percent` DECIMAL(18,2) COMMENT 'Maximum allowable variance expressed as a percentage of the measured value.',
    `weights_measures_status` STRING COMMENT 'Current operational status of the device within the store.. Valid values are `active|inactive|retired|maintenance`',
    CONSTRAINT pk_weights_measures PRIMARY KEY(`weights_measures_id`)
) COMMENT 'Weights and measures compliance tracking for scales, scanners, and measuring devices at store locations. Captures device ID, certification date, next calibration due date, inspector, jurisdiction, compliance status, and variance tolerances per state metrology requirements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`compliance_document` (
    `compliance_document_id` BIGINT COMMENT 'Primary key for compliance_document',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Compliance documents are owned by a compliance program.',
    `superseded_compliance_document_id` BIGINT COMMENT 'Self-referencing FK on compliance_document (superseded_compliance_document_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the document was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the document for active status.',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA‑256) for integrity verification of the document file.',
    `compliance_area` STRING COMMENT 'Business domain or regulatory focus of the document (e.g., food safety, workplace safety, accessibility).',
    `confidentiality_level` STRING COMMENT 'Classification of the documents sensitivity.',
    `document_format` STRING COMMENT 'File format of the stored document.',
    `document_number` STRING COMMENT 'External reference number or code assigned to the document by the issuing authority.',
    `document_type` STRING COMMENT 'Category of the compliance document indicating its purpose and content.',
    `effective_date` DATE COMMENT 'Date on which the document becomes legally effective.',
    `expiration_date` DATE COMMENT 'Date on which the document expires or is no longer in force; null if indefinite.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with this document is mandatory for operations.',
    `issuing_authority` STRING COMMENT 'Organization or agency that issued the compliance document.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction to which the document applies.',
    `last_review_date` DATE COMMENT 'Date when the document was most recently reviewed for relevance and accuracy.',
    `next_review_date` DATE COMMENT 'Planned date for the next mandatory review of the document.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `regulatory_body` STRING COMMENT 'Specific regulatory agency (e.g., FDA, OSHA, ADA) governing the document.',
    `compliance_document_status` STRING COMMENT 'Current lifecycle status of the document.',
    `storage_path` STRING COMMENT 'Logical path or URI where the document is stored in the lakehouse.',
    `title` STRING COMMENT 'Human‑readable title of the compliance document.',
    `version_number` STRING COMMENT 'Version identifier for the document, incremented on each revision.',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the document record.',
    CONSTRAINT pk_compliance_document PRIMARY KEY(`compliance_document_id`)
) COMMENT 'Master reference table for compliance_document. Referenced by compliance_document_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`compliance`.`training_requirement` (
    `training_requirement_id` BIGINT COMMENT 'Primary key for training_requirement',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Training requirements are defined by a compliance program.',
    `prerequisite_training_requirement_id` BIGINT COMMENT 'Self-referencing FK on training_requirement (prerequisite_training_requirement_id)',
    `assessment_required` BOOLEAN COMMENT 'Specifies if an assessment or test follows the training.',
    `certification_expiration_date` DATE COMMENT 'Date when the certification expires and must be renewed.',
    `certification_obtained` BOOLEAN COMMENT 'Indicates whether completion yields a certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training requirement record was first created.',
    `delivery_mode` STRING COMMENT 'Method by which the training is delivered.',
    `training_requirement_description` STRING COMMENT 'Detailed description of the training content and objectives.',
    `duration_minutes` STRING COMMENT 'Typical length of the training session in minutes.',
    `effective_date` DATE COMMENT 'Date when the training requirement becomes effective.',
    `expiration_date` DATE COMMENT 'Date when the training requirement expires or must be refreshed.',
    `mandatory` BOOLEAN COMMENT 'Indicates whether the training is mandatory for the assigned role.',
    `provider_contact_email` STRING COMMENT 'Primary email address for the training provider contact.',
    `regulatory_body` STRING COMMENT 'Governing agency or standard that mandates the training.',
    `required_frequency_months` STRING COMMENT 'How often the training must be repeated, expressed in months.',
    `requirement_code` STRING COMMENT 'Internal alphanumeric code used to reference the requirement.',
    `requirement_name` STRING COMMENT 'Human‑readable name of the training requirement.',
    `training_requirement_status` STRING COMMENT 'Current lifecycle status of the training requirement.',
    `training_provider` STRING COMMENT 'Organization or vendor delivering the training.',
    `training_type` STRING COMMENT 'Category of compliance training (e.g., Food Safety, OSHA).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training requirement record.',
    `created_by` STRING COMMENT 'User or system that created the training requirement record.',
    CONSTRAINT pk_training_requirement PRIMARY KEY(`training_requirement_id`)
) COMMENT 'Master reference table for training_requirement. Referenced by training_requirement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_parent_program_id` FOREIGN KEY (`parent_program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_parent_obligation_id` FOREIGN KEY (`parent_obligation_id`) REFERENCES `grocery_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ADD CONSTRAINT `fk_compliance_audit_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ADD CONSTRAINT `fk_compliance_audit_plan_superseded_audit_plan_id` FOREIGN KEY (`superseded_audit_plan_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_plan`(`audit_plan_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_audit_plan_id` FOREIGN KEY (`audit_plan_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_plan`(`audit_plan_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_followup_audit_engagement_id` FOREIGN KEY (`followup_audit_engagement_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_related_audit_finding_id` FOREIGN KEY (`related_audit_finding_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_food_safety_violation_id` FOREIGN KEY (`food_safety_violation_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_violation`(`food_safety_violation_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_followup_corrective_action_id` FOREIGN KEY (`followup_corrective_action_id`) REFERENCES `grocery_ecm`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ADD CONSTRAINT `fk_compliance_food_safety_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ADD CONSTRAINT `fk_compliance_food_safety_plan_superseded_food_safety_plan_id` FOREIGN KEY (`superseded_food_safety_plan_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ADD CONSTRAINT `fk_compliance_food_safety_inspection_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ADD CONSTRAINT `fk_compliance_food_safety_inspection_followup_food_safety_inspection_id` FOREIGN KEY (`followup_food_safety_inspection_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_inspection`(`food_safety_inspection_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ADD CONSTRAINT `fk_compliance_food_safety_violation_food_safety_inspection_id` FOREIGN KEY (`food_safety_inspection_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_inspection`(`food_safety_inspection_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ADD CONSTRAINT `fk_compliance_food_safety_violation_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ADD CONSTRAINT `fk_compliance_food_safety_violation_related_food_safety_violation_id` FOREIGN KEY (`related_food_safety_violation_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_violation`(`food_safety_violation_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ADD CONSTRAINT `fk_compliance_osha_citation_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ADD CONSTRAINT `fk_compliance_osha_citation_related_osha_citation_id` FOREIGN KEY (`related_osha_citation_id`) REFERENCES `grocery_ecm`.`compliance`.`osha_citation`(`osha_citation_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_amended_regulatory_filing_id` FOREIGN KEY (`amended_regulatory_filing_id`) REFERENCES `grocery_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_renewed_from_license_permit_id` FOREIGN KEY (`renewed_from_license_permit_id`) REFERENCES `grocery_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_amended_privacy_request_id` FOREIGN KEY (`amended_privacy_request_id`) REFERENCES `grocery_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_related_privacy_incident_id` FOREIGN KEY (`related_privacy_incident_id`) REFERENCES `grocery_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ADD CONSTRAINT `fk_compliance_ada_assessment_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ADD CONSTRAINT `fk_compliance_ada_assessment_followup_ada_assessment_id` FOREIGN KEY (`followup_ada_assessment_id`) REFERENCES `grocery_ecm`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `grocery_ecm`.`compliance`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_superseded_environmental_compliance_id` FOREIGN KEY (`superseded_environmental_compliance_id`) REFERENCES `grocery_ecm`.`compliance`.`environmental_compliance`(`environmental_compliance_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `grocery_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_retake_of_training_completion_id` FOREIGN KEY (`retake_of_training_completion_id`) REFERENCES `grocery_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_superseded_policy_id` FOREIGN KEY (`superseded_policy_id`) REFERENCES `grocery_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `grocery_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_prior_policy_acknowledgment_id` FOREIGN KEY (`prior_policy_acknowledgment_id`) REFERENCES `grocery_ecm`.`compliance`.`policy_acknowledgment`(`policy_acknowledgment_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ADD CONSTRAINT `fk_compliance_age_restricted_sale_override_age_restricted_sale_id` FOREIGN KEY (`override_age_restricted_sale_id`) REFERENCES `grocery_ecm`.`compliance`.`age_restricted_sale`(`age_restricted_sale_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ADD CONSTRAINT `fk_compliance_risk_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ADD CONSTRAINT `fk_compliance_risk_parent_risk_id` FOREIGN KEY (`parent_risk_id`) REFERENCES `grocery_ecm`.`compliance`.`risk`(`risk_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_superseded_regulatory_change_id` FOREIGN KEY (`superseded_regulatory_change_id`) REFERENCES `grocery_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ADD CONSTRAINT `fk_compliance_weights_measures_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ADD CONSTRAINT `fk_compliance_weights_measures_prior_calibration_weights_measures_id` FOREIGN KEY (`prior_calibration_weights_measures_id`) REFERENCES `grocery_ecm`.`compliance`.`weights_measures`(`weights_measures_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`compliance_document` ADD CONSTRAINT `fk_compliance_compliance_document_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`compliance_document` ADD CONSTRAINT `fk_compliance_compliance_document_superseded_compliance_document_id` FOREIGN KEY (`superseded_compliance_document_id`) REFERENCES `grocery_ecm`.`compliance`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` ADD CONSTRAINT `fk_compliance_training_requirement_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` ADD CONSTRAINT `fk_compliance_training_requirement_prerequisite_training_requirement_id` FOREIGN KEY (`prerequisite_training_requirement_id`) REFERENCES `grocery_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `grocery_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`program` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `parent_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `audit_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Result Summary');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'food|safety|environment|privacy|accessibility');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Current Compliance Status');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|under_review');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `external_program_code` SET TAGS ('dbx_business_glossary_term' = 'External Program Code');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'food_safety|workplace_safety|environment|privacy|accessibility');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Name');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Lifecycle Status');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|closed');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|OSHA|EPA|FTC|HIPAA|DEA');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'FDA|OSHA|EPA|CCPA|ADA');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Program Risk Level');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `stakeholder_group` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Group');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `grocery_ecm`.`compliance`.`program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Owner ID');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `associate_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_escalation_contact_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact ID');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_escalation_contact_associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_escalation_contact_associate_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `parent_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `attached_files_flag` SET TAGS ('dbx_business_glossary_term' = 'Attached Files Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_metric` SET TAGS ('dbx_business_glossary_term' = 'Compliance Metric');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_status_detail` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Detail');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_documentation` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-d{4}-d{3}$');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|fulfilled|overdue|cancelled');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'regulatory|internal|environmental|safety|privacy|financial');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `recurrence_schedule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Schedule');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `recurrence_schedule` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|weekly|daily|one-time');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low|none');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan ID');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `superseded_audit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_budget` SET TAGS ('dbx_business_glossary_term' = 'Audit Budget Amount');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'food_safety|workplace_safety|privacy|financial_controls|environmental|pharmacy_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly|ad_hoc');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_objectives` SET TAGS ('dbx_business_glossary_term' = 'Audit Objectives');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome Summary');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Lifecycle Status');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_plan_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|cancelled');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_resources` SET TAGS ('dbx_business_glossary_term' = 'Audit Resources Allocated');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (Internal, External, Regulatory)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `compliance_programs` SET TAGS ('dbx_business_glossary_term' = 'Compliance Programs Assessed');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Document URL');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Findings');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `lead_auditor` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Code');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Name');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Version');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Priority');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Responsible');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (Low, Medium, High)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Risk Score');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Tags');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor ID');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan ID');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `followup_audit_engagement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_value_regex' = 'checklist|interview|sampling|observation');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_objective` SET TAGS ('dbx_business_glossary_term' = 'Audit Objective');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('dbx_value_regex' = 'store|distribution_center|pharmacy|fuel_center|warehouse');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|vendor');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `compliance_issue_count` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issue Count');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `corrective_action_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Number');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `is_follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Is Follow‑Up Required');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Rating');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Rating Score');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Reference');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned User Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `related_audit_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Category');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|deferred');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'food_safety|occupational_safety|privacy|environment|financial|pharmacy');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `evidence_documentation` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'non_conformance|observation|opportunity');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Finding Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `food_safety_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Related Violation Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `followup_corrective_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Title');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type (CAPA Type)');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `closure_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Approval Date');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `closure_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'FDA|OSHA|USDA|DEA|FTC|EPA');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|rejected');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Cost (USD)');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'External Party Involvement Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `superseded_food_safety_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Conditional');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Pending');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `food_safety_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `food_safety_plan_status` SET TAGS ('dbx_value_regex' = 'Draft|Active|Expired|Suspended');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `hazard_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Summary');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Number');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `plan_scope` SET TAGS ('dbx_business_glossary_term' = 'Plan Scope');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type (HACCP/HARPC/Preventive Controls)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HACCP|HARPC|Preventive Controls');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `preventive_controls_summary` SET TAGS ('dbx_business_glossary_term' = 'Preventive Controls Summary');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|OSHA|EPA');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'Revision History');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `training_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `food_safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Inspection ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `followup_food_safety_inspection_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency (AGENCY)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `agency` SET TAGS ('dbx_value_regex' = 'FDA|USDA|Local_Health|Internal');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area (COMPLIANCE_AREA)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CORR_ACTION_DUE)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required (CORR_ACTION_REQ)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Violations Count (CRIT_VIOL_COUNT)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Inspection Date (FOLLOWUP_DATE)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Inspection Required (FOLLOWUP_REQ)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `food_category` SET TAGS ('dbx_business_glossary_term' = 'Food Category (FOOD_CAT)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `food_safety_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (STATUS)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `food_safety_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed|reopened');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `hygiene_score` SET TAGS ('dbx_business_glossary_term' = 'Hygiene Score (HYGIENE_SCORE)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (INS_NUM)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type (INS_TYPE)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|follow_up|complaint_driven');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Full Name (INSPECTOR_NAME)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `non_critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Critical Violations Count (NONCRIT_VIOL_COUNT)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes (NOTES)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Score (OVERALL_SCORE)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Inspection Rating (RATING)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|closure_order');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `temperature_control_verified` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Verified (TEMP_CTRL_VERIFIED)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ALTER COLUMN `violation_details` SET TAGS ('dbx_business_glossary_term' = 'Violation Details (VIOL_DETAILS)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `food_safety_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Violation ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `food_safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `related_food_safety_violation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `ccp_affected` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Affected');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `ccp_affected` SET TAGS ('dbx_value_regex' = 'Temperature Control|Sanitation|Cross-Contamination|Allergen Control|Packaging|Labeling');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `corrective_action_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'Visual|Instrument|Lab Test|Audit');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `food_category` SET TAGS ('dbx_business_glossary_term' = 'Food Category');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `food_category` SET TAGS ('dbx_value_regex' = 'Produce|Dairy|Meat|Bakery|Frozen');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `food_safety_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `food_safety_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `food_safety_violation_status` SET TAGS ('dbx_value_regex' = 'Open|Closed|In Review|Resolved');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Violation Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `repeat_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Violation Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `reporter_role` SET TAGS ('dbx_business_glossary_term' = 'Reporter Role');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `reporter_role` SET TAGS ('dbx_value_regex' = 'Manager|Supervisor|Employee|Auditor');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Manual');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_value_regex' = 'C|F');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code (FDA)');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `violation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'Critical|Major|Minor');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `osha_citation_id` SET TAGS ('dbx_business_glossary_term' = 'OSHA Citation Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Store Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `related_osha_citation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `abatement_deadline` SET TAGS ('dbx_business_glossary_term' = 'Abatement Deadline');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `affected_department` SET TAGS ('dbx_business_glossary_term' = 'Affected Department');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `citation_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA Citation Issue Date');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `citation_description` SET TAGS ('dbx_business_glossary_term' = 'Citation Description');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `citation_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Citation Number');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `citation_status` SET TAGS ('dbx_business_glossary_term' = 'OSHA Citation Status');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `citation_status` SET TAGS ('dbx_value_regex' = 'issued|contested|settled|closed|withdrawn');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `citation_type` SET TAGS ('dbx_business_glossary_term' = 'OSHA Citation Type');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `citation_type` SET TAGS ('dbx_value_regex' = 'willful|serious|other_than_serious|repeat|failure_to_abate');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `contest_deadline` SET TAGS ('dbx_business_glossary_term' = 'Citation Contest Deadline');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `contest_status` SET TAGS ('dbx_business_glossary_term' = 'Citation Contest Status');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `contest_status` SET TAGS ('dbx_value_regex' = 'not_contested|contested|under_review|resolved');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `issuing_osha_office` SET TAGS ('dbx_business_glossary_term' = 'OSHA Issuing Office');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `proposed_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Penalty Amount');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `standard_violated` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Violated');
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `amended_regulatory_filing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `attached_document_path` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Path');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_started');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_category` SET TAGS ('dbx_business_glossary_term' = 'Filing Category');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_category` SET TAGS ('dbx_value_regex' = 'food_safety|workplace_safety|environmental|privacy|pharmacy|finance');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period` SET TAGS ('dbx_business_glossary_term' = 'Filing Period');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'registration|certification|report|license|notice');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `is_renewal` SET TAGS ('dbx_business_glossary_term' = 'Is Renewal Filing');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Lifecycle Status');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|pending_renewal|closed');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_section` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Section');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|email');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `license_permit_id` SET TAGS ('dbx_business_glossary_term' = 'License Permit ID');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'License Holder ID');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `renewed_from_license_permit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `attached_document_url` SET TAGS ('dbx_business_glossary_term' = 'Attached Document URL');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Paid Date');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `fee_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial|waived');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `holder_type` SET TAGS ('dbx_business_glossary_term' = 'License Holder Type');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `holder_type` SET TAGS ('dbx_value_regex' = 'store|legal_entity|pharmacy|fuel_center');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `license_permit_description` SET TAGS ('dbx_business_glossary_term' = 'License Description');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `license_permit_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `license_permit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|expired');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `renewal_fee` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `renewal_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|renewed|expired|revoked|suspended');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'License Scope');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'state|county|city|national|international');
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request ID');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Patient Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `amended_privacy_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_category` SET TAGS ('dbx_business_glossary_term' = 'Data Category');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_category` SET TAGS ('dbx_value_regex' = 'personal|financial|health|other');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Scope');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_scope` SET TAGS ('dbx_value_regex' = 'all|specific_items|profile');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|denied|expired');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `privacy_law` SET TAGS ('dbx_business_glossary_term' = 'Applicable Privacy Law');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `privacy_law` SET TAGS ('dbx_value_regex' = 'ccpa|gdpr|california_privacy|other');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_details` SET TAGS ('dbx_business_glossary_term' = 'Request Details');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Number');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_reason` SET TAGS ('dbx_business_glossary_term' = 'Request Reason');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Type');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'access|deletion|correction|portability|opt_out');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requestor Type');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'shopper|household|employee');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'web|phone|in_store|email|mail');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `related_privacy_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `affected_data_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Categories');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `affected_data_categories` SET TAGS ('dbx_value_regex' = 'PII|PHI|PCI|Other');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `affected_party` SET TAGS ('dbx_business_glossary_term' = 'Affected Party');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `containment_actions` SET TAGS ('dbx_business_glossary_term' = 'Containment Actions');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `estimated_affected_individuals` SET TAGS ('dbx_business_glossary_term' = 'Estimated Affected Individuals');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'unauthorized_access|data_leak|phishing|malware|vendor_violation');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `investigation_owner` SET TAGS ('dbx_business_glossary_term' = 'Investigation Owner');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Incident Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Notification Deadline');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_incident_status` SET TAGS ('dbx_value_regex' = 'open|investigating|contained|resolved|closed');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `regulatory_notifications` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notifications');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'ADA Assessment Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `followup_ada_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `ada_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `ada_assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'ADA Assessment Number');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'self|third_party|doj_driven');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `barriers_identified` SET TAGS ('dbx_business_glossary_term' = 'Barriers Identified');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_priority` SET TAGS ('dbx_business_glossary_term' = 'Remediation Priority');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `environmental_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Record Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `superseded_environmental_compliance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `agency_contact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Contact');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cost Currency');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_cost_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_cost_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_cost_estimated` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cost Estimated Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_cost_estimated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cost (USD)');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_period_end` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End Date');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_period_start` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Start Date');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|under_review|exempt');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `correspondence_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Correspondence Date');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `correspondence_method` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Method');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `correspondence_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `document_received_date` SET TAGS ('dbx_business_glossary_term' = 'Document Received Date');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (MWh)');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `epa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EPA Compliance Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `hazardous_waste_quantity_tons` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Quantity (tons)');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `hazardous_waste_type` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Type');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `last_inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `last_inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `refrigerant_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Refrigerant Quantity (kg)');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `refrigerant_type` SET TAGS ('dbx_business_glossary_term' = 'Refrigerant Type');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulation Code');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `regulation_type` SET TAGS ('dbx_business_glossary_term' = 'Regulation Type');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `stormwater_permit_expiry` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Permit Expiry Date');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `stormwater_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Permit Number');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `usta_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'UST Compliance Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_details` SET TAGS ('dbx_business_glossary_term' = 'Violation Details');
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement ID');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `retake_of_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_pass_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Pass Score');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'quiz|exam|simulation');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_number` SET TAGS ('dbx_business_glossary_term' = 'Completion Number');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'online|in_person|blended');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Minutes)');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `role_required` SET TAGS ('dbx_business_glossary_term' = 'Required Role');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|revoked');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_title` SET TAGS ('dbx_business_glossary_term' = 'Training Title');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Training Version Number');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `superseded_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `attached_document_path` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Path');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|revoked|pending');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'food_safety|osha|privacy|code_of_conduct|alcohol_sales|age_verification');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly|monthly|ad_hoc');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Revision Number');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Policy Source System');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `status_change_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Status Change Date');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Status Reason');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Policy Tags');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`policy` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment ID');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `associate_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `associate_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `prior_policy_acknowledgment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Number');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Expiration Date');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'electronic_signature|paper|lms');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `required_reacknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Required Re‑acknowledgment Date');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `signature_hash` SET TAGS ('dbx_business_glossary_term' = 'Signature Hash');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `age_restricted_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Sale ID');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `override_age_restricted_sale_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `customer_apparent_age` SET TAGS ('dbx_business_glossary_term' = 'Customer Apparent Age');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `customer_apparent_age` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `customer_apparent_age` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `id_type_presented` SET TAGS ('dbx_business_glossary_term' = 'Identification Type Presented');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `id_type_presented` SET TAGS ('dbx_value_regex' = 'drivers_license|passport|state_id|other');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category (Age‑Restricted)');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'alcohol|tobacco|lottery|otc_medication');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `refusal_reason` SET TAGS ('dbx_business_glossary_term' = 'Refusal Reason');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register ID');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `sale_amount` SET TAGS ('dbx_business_glossary_term' = 'Sale Amount');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `sale_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sale Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Verification Outcome');
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_value_regex' = 'approved|refused');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `associate_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_escalation_contact_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `parent_risk_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `affected_business_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Area');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `affected_business_area` SET TAGS ('dbx_value_regex' = 'store_operations|supply_chain|pharmacy|digital_commerce|finance|vendor_management');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'strategic|operational|financial|compliance');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'food_safety|workplace_safety|data_privacy|environmental|financial_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `control_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Score');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Documentation Link');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `inherent_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Impact Score');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `inherent_likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood Score');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `mitigation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `residual_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Impact Score');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `residual_likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Score');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Date');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'food_safety|workplace_safety|data_privacy|environmental|licensing|financial');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Name');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Source');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_source` SET TAGS ('dbx_value_regex' = 'internal|external|audit|incident');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|closed|monitoring|escalated');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Risk Tags');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `treatment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Strategy');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `treatment_strategy` SET TAGS ('dbx_value_regex' = 'accept|mitigate|transfer|avoid');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `treatment_strategy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `treatment_strategy` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `attached_document_path` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Path (DOC_PATH)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_announced_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Announcement Timestamp (ANNOUNCE_TS)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Change Number (CHG_NUM)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type (CHG_TYPE)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'new|amendment|repeal');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category (COMPLIANCE_CAT)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'food_safety|occupational|environmental|privacy|financial|pharmacy');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `enacted_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enacted Effective Date (ENACTED_EFF_DT)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Status (IMPACT_ASMT_STATUS)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impacted_business_areas` SET TAGS ('dbx_business_glossary_term' = 'Impacted Business Areas (IMPACTED_AREAS)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Implementation Owner Name (IMPL_OWNER_NAME)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_owner_role` SET TAGS ('dbx_business_glossary_term' = 'Implementation Owner Role (IMPL_OWNER_ROLE)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DT)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (CHG_NOTES)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority (CHG_PRIORITY)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `proposed_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Effective Date (PROPOSED_EFF_DT)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name (REG_NAME)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_section` SET TAGS ('dbx_business_glossary_term' = 'Regulation Section (REG_SEC)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description (CHG_DESC)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status (CHG_STATUS)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_status` SET TAGS ('dbx_value_regex' = 'proposed|review|approved|enacted|rejected');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `required_operational_changes` SET TAGS ('dbx_business_glossary_term' = 'Required Operational Changes (REQ_OP_CHANGES)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LEVEL)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `weights_measures_id` SET TAGS ('dbx_business_glossary_term' = 'Weights Measures Record ID');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location ID');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `prior_calibration_weights_measures_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `calibration_method` SET TAGS ('dbx_value_regex' = 'internal|external|automated');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|expired');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'scale|scanner|measure_device');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `last_calibrated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `measurement_category` SET TAGS ('dbx_business_glossary_term' = 'Measurement Category');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `measurement_category` SET TAGS ('dbx_value_regex' = 'weight|volume|dimension');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|g|oz');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `next_calibration_due` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `variance_tolerance_kg` SET TAGS ('dbx_business_glossary_term' = 'Variance Tolerance (kg)');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `variance_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Tolerance (%)');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `weights_measures_status` SET TAGS ('dbx_business_glossary_term' = 'Device Lifecycle Status');
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ALTER COLUMN `weights_measures_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|maintenance');
ALTER TABLE `grocery_ecm`.`compliance`.`compliance_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`compliance_document` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`compliance_document` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`compliance_document` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`compliance_document` ALTER COLUMN `superseded_compliance_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Identifier');
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` ALTER COLUMN `prerequisite_training_requirement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` ALTER COLUMN `provider_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`compliance`.`training_requirement` ALTER COLUMN `provider_contact_email` SET TAGS ('dbx_pii_email' = 'true');
